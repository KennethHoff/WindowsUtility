$FolderNameForAdjustedVideos = "Adjusted"
$FolderNameForTemporaryVideos = "Temporary"

$SuffixForCompressedVideos = "_Compressed"
$fileExtension = ".mp4"

Import-Module video_utils/Utils


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

    WriteToTerminal "Input File Path: $InputFilePath" "CompressVideo"

    $ReplacedInputFilePathString = $InputFilePath.Replace(".\", "").Replace(".mp4", "")

    WriteToTerminal "Edited Input File Path: $ReplacedInputFilePathString" "CompressVideo"

    $OutputFileName = "$ReplacedInputFilePathString$SuffixForCompressedVideos"

    WriteToTerminal "OutputFileName: $OutputFileName" "CompressVideo"

    $OutputFileName = $OutputFileName.Replace("$FolderNameForTemporaryVideos\", "");

    WriteToTerminal "Edited OutputFileName: $OutputFileName" "CompressVideo"


    $OutputFilePath = ""
    if ($CalledExternally)
    {
        $OutputFilePath = "$FolderNameForAdjustedVideos\$OutputFileName"
    }
    else {
        $OutputFilePath = "$FolderNameForTemporaryVideos\$OutputFileName"
    }
    WriteToTerminal "OutputFilePath written" "CompressVideo"

    $extraOptions

    if ($Scale)
    {
        $OutputFilePath += "_$Scale"
        $OutputFileName += "_$Scale"

        $Scale = "$Scale`:-1"
        $extraOptions = '-vf' + ' "scale=' + "$Scale`""
    }
    $OutputFilePath += "$fileExtension"

#    $defaultOptions = "-i `"$InputFilePath`" -vcodec libx264 -crf 28 -fs 7000000"
    $defaultOptions = "-i `"$InputFilePath`" -vcodec libx264 -crf 28"
    $outputOptions = "`"$OutputFilePath`""

    Invoke-Expression -Command "ffmpeg $defaultOptions $extraOptions $outputOptions"

    $returnValue = "$OutputFileName$fileExtension"

    WriteToTerminal "Return Value: $returnValue" "CompressVideo"

    return ,$returnValue
}
Export-ModuleMember -Function CompressVideo
