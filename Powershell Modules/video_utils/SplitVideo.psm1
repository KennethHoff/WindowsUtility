$FolderNameForAdjustedVideos = "Adjusted"
$FolderNameForTemporaryVideos = "Temporary"

$fileExtension = ".mp4"

Function SplitVideo {
    Param(
        [Parameter(Mandatory, HelpMessage="Enter the File path")]
        $FilePath,
        [Parameter(Mandatory, HelpMessage="Enter the time span (seconds:seconds)")]
        $Timespan,
        $Internal
    )

    SplitVideo_Internal $FilePath $Timespan $Internal
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

Export-ModuleMember -Function SplitVideo
