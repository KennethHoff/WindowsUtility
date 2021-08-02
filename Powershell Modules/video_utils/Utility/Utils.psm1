$FolderNameForAdjustedVideos = "Adjusted"
$FolderNameForTemporaryVideos = "Temporary"

Function CreateFolder()
{
    Param(
        $folderName
    )
    New-Item $folderName -itemType "directory"
}

Function DeleteFolder()
{
    Param(
        $folderName
    )
    Remove-Item $folderName -Recurse

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
    DeleteFolder $FolderNameForTemporaryVideos
}

Function MoveItemFromTemporaryToAdjusted()
{
    Param(
        $InputFileName
    )

    $inputWithoutTemporaryFolder = $InputFileName.Replace($FolderNameForTemporaryVideos, "").Replace(".\", "")

    $finalInputPath = ".\$FolderNameForTemporaryVideos\$inputWithoutTemporaryFolder"
    $finalOutputPath = ".\$FolderNameForAdjustedVideos\$inputWithoutTemporaryFolder"

    WriteToTerminal "'Final Input Path': $finalInputPath" "MoveItemFromTemporaryToAdjusted"
    WriteToTerminal "'Final Output Path': $finalOutputPath" "MoveItemFromTemporaryToAdjusted"

    $finalOutputPath =

    Move-Item $finalInputPath $finalOutputPath -force

}
Function WriteToTerminal()
{
    Param(
        $Text,
        $Source
    )
    Write-host "[$Source]: $Text" -ForegroundColor Blue
}

Function ChooseAudioTrack()
{
    Param(
        $Filepath,
        $AudioTrack,
        $Folder
    )
    $outputFilePath = $Folder + "\" + $Filepath.Replace(".mp4", "") + "_Track" + $AudioTrack + ".mp4"
    ffmpeg -i "$FilePath" -map 0:v:0 -map 0:a:$audioTrack -codec copy "$outputFilePath"

    WriteToTerminal "Replacing audio Track of $FilePath with #$AudioTrack - Output file is: [$outputFilePath]" "Utils"

    $returnValue = $outputFilePath

    return $returnValue
}
