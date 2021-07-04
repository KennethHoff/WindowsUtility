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
    write-host "[CompressVideo]: OutputFilePath written"

    if ($Scale)
    {
        $OutputFilePath = "$OutputFilePath`_$Scale$fileExtension"
        $OutputFileName += "_$Scale"

        $Scale = "$Scale`:-1"
        ffmpeg -i $InputFilePath -vcodec libx265  -vf `"scale=$Scale`" -crf 28 "$OutputFilePath"
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
Export-ModuleMember -Function CompressVideo
