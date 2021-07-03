$FolderNameForAdjustedVideos = "Adjusted"
$FolderNameForTemporaryVideos = "Temporary"

$SuffixForCompressedVideos = "_Compressed"
$fileExtension = ".mp4"

Function OpenActiveFolder()
{
    explorer.exe $FolderNameForAdjustedVideos
}


Function CreateFolder()
{
    Param(
        $folderName
    )
    New-Item $folderName -itemType "directory"
}

Function CreateFolderIfNotAlreadyExists()
{
    Param(
        $folderName
    )

    $folderExists = Test-Path $folderName

    if (!$folderExists)
    {
        CreateFolder $folderName
    }
}
Function CreateTemporaryFolder()
{
    CreateFolderIfNotAlreadyExists $FolderNameForTemporaryVideos
}

Function CreateAdjustedFolder()
{
    CreateFolderIfNotAlreadyExists $FolderNameForAdjustedVideos

}
Function DeleteTemporaryFolder()
{
    Remove-Item $FolderNameForTemporaryVideos -Recurse
}

Function MoveItemFromTemporaryToAdjusted()
{
    Param(
        $InputFileName
    )

    $folderExists = Test-Path $FolderNameForAdjustedVideos

    if (!$folderExists)
    {
        New-Item $FolderNameForAdjustedVideos -ItemType Directory | Out-Null
    }
    Move-Item ".\$FolderNameForTemporaryVideos\$inputFileName" ".\$FolderNameForAdjustedVideos\$inputFileName" -force

}

Function SplitVideo {
    Param(
        [Parameter(Mandatory, HelpMessage="Enter the File path")]
        $FilePath,
        [Parameter(Mandatory, HelpMessage="Enter the time span (seconds:seconds)")]
        $Timespan
    )

    SplitVideo_Internal $FilePath $Timespan $true
}

Function SplitVideo_Internal
{
    Param(
        $FilePath,
        $Timespan,
        $CalledExternally
    )

    $replacedTimespanString = $Timespan.Replace(":", "-");
    $replacedFilePathString = $FilePath.Replace(".\", "").Replace(".mp4", "")

    $OutputFileName = $replacedFilePathString + "_" + $replacedTimespanString

    $outputFilePath = ""

    if ($CalledExternally)
    {
        $outputFilePath = "$FolderNameForAdjustedVideos\$OutputFileName"

        #        write-host """Split Video"" called Externally"
    }
    else
    {
        $outputFilePath = "$FolderNameForTemporaryVideos\$OutputFileName"

        #        write-host """Split Video"" called Internally"
    }
    mp4box -splitx $Timespan `"$FilePath`" -out $outputFilePath$fileExtension

    return $outputFileName + $fileExtension
}

Function CompressVideo {
    Param(
        [Parameter(Mandatory, HelpMessage="Enter the File path")]
        $InputFilePath,
        $scale
    )

    CompressVideo_Internal $InputFilePath $scale $true
}

Function CompressVideo_Internal {
    Param(
        $InputFilePath,
        $scale,
        $CalledExternally
    )

    $ReplacedInputFilePathString = $InputFilePath.Replace(".\", "").Replace(".mp4", "")
    $OutputFileName = "$ReplacedInputFilePathString$SuffixForCompressedVideos"

    $OutputFileName = $OutputFileName.Replace("$FolderNameForTemporaryVideos\", "");

    $OutputFilePath = ""
    if ($CalledExternally)
    {
        $OutputFilePath = "$FolderNameForAdjustedVideos\$OutputFileName"
    }
    else {
        $OutputFilePath = "$FolderNameForTemporaryVideos\$OutputFileName"
    }

    if ($scale)
    {
        $OutputFilePath = "$OutputFilePath`_$scale$fileExtension"
        $OutputFileName += "_$scale"

        $scale = "$scale`:-1"
        ffmpeg -i $InputFilePath -vcodec libx265  -vf `"scale=$scale`" -crf 28 "$OutputFilePath"
    }
    else {
        $OutputFilePath = "$outputFilePath$fileExtension"
        ffmpeg -i $InputFilePath -vcodec libx264 -crf 28 "$OutputFilePath"
    }

#    write-host ffmpeg "-i" $InputFilePath "-vcodec" libx265 "-crf" 28 $OutputFilePath
#    write-host
#    write-host
#    write-host
#    write-host

    return $OutputFileName + $fileExtension
}


Function SplitAndCompressVideo {
    Param(
        [Parameter(Mandatory, HelpMessage="Enter the File path")]
        $InputFilePath,
        $Timespan,
        $scale
    )
    #    0. Setup some runtime variables
    $ActiveFileName = ""


    #    1. Create Temporary Folders if it does not already exist
    CreateTemporaryFolder


    #    2. If there was a Timespan supplied, split the video
    if ($Timespan)
    {
        #   2a-1. Split up the video into the parts requested.
        #           > Into the 'Temporary' folder

        Write-Progress "Splitting..."
        #        2a-2. Set the 'ActiveFileName' to the path of the video (without the Temporary/Adjusted folder)
        $ActiveFileName = SplitVideo_Internal $InputFilePath $Timespan $false
        #        2a-3. Add the temporary/adjusted folder back in
        $ActiveFileName = "$FolderNameForTemporaryVideos\$ActiveFileName"
    }
    else
    {
        #   2b-1. Set the 'ActiveFileName' to the input name; No changes required
        $ActiveFileName = $InputFilePath
    }

    #    3. Compress the video into h.265 format
    #        > Into the 'Temporary' folder
    Write-Progress "Compressing..."

    $ActiveFileName = CompressVideo_Internal $ActiveFileName $scale $false

    #    4. Create the Adjusted Folder (If it does not already exist), and move the compressed video from the 'Temporary' folder into the 'Adjusted' folder.
    CreateAdjustedFolder
    MoveItemFromTemporaryToAdjusted $ActiveFileName

    #    5.Delete the 'Temporary' folder
    DeleteTemporaryFolder
}

Export-ModuleMember -Function SplitVideo
Export-ModuleMember -Function CompressVideo
Export-ModuleMember -Function SplitAndCompressVideo
