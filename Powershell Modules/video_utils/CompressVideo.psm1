$FolderNameForAdjustedVideos = "Adjusted"
$FolderNameForTemporaryVideos = "Temporary"

$SuffixForCompressedVideos = "_Compressed"
$fileExtension = ".mp4"

Function CompressVideo {
    Param(
        [Parameter(Mandatory, HelpMessage="Enter the File path")]
        $InputFilePath,
        $Scale,
        $Internal
    )

    CompressVideo_Internal $InputFilePath $Scale $Internal
}

Function CompressVideo_Internal {
    Param(
        $InputFilePath,
        $Scale,
        $CalledExternally
    )

    write-host "[CompressVideo]: Input File Path: $InputFilePath"

    $ReplacedInputFilePathString = $InputFilePath.Replace(".\", "").Replace(".mp4", "")

    Write-Host "[CompressVideo]: Edited Input File Path: $ReplacedInputFilePathString"

    $OutputFileName = "$ReplacedInputFilePathString$SuffixForCompressedVideos"

    Write-Host "[CompressVideo]: OutputFileName: $OutputFileName"

    $OutputFileName = $OutputFileName.Replace("$FolderNameForTemporaryVideos\", "");

    Write-Host "[CompressVideo]: Edited OutputFileName: $OutputFileName"


    $OutputFilePath = ""
    if ($CalledExternally)
    {
        $OutputFilePath = "$FolderNameForAdjustedVideos\$OutputFileName"
    }
    else {
        $OutputFilePath = "$FolderNameForTemporaryVideos\$OutputFileName"
    }
    write-host "[CompressVideo]: OutputFilePath written"

    $extraOptions

    if ($Scale)
    {
        $OutputFilePath = "$OutputFilePath`_$Scale$fileExtension"
        $OutputFileName += "_$Scale"

        $Scale = "$Scale`:-1"
        $extraOptions = '-vf' + ' "scale=' + "$Scale`""
    }
    else {
        $OutputFilePath = "$outputFilePath$fileExtension"
    }

#    $defaultOptions = "-i `"$InputFilePath`" -vcodec libx264 -crf 28 -fs 7000000"
    $defaultOptions = "-i `"$InputFilePath`" -vcodec libx264 -crf 28"
    $outputOptions = "`"$OutputFilePath`""

#    Write-Host "ffmpeg $defaultOptions $outputOptions"
#    Write-Host
#    Write-Host
#    Write-Host
#    Write-Host

    Invoke-Expression -Command "ffmpeg $defaultOptions $extraOptions $outputOptions"

    $returnValue = "$OutputFileName$fileExtension"

    return ,$returnValue
}
Export-ModuleMember -Function CompressVideo
