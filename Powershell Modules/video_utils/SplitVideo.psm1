$FolderNameForAdjustedVideos = "Adjusted"
$FolderNameForTemporaryVideos = "Temporary"

$outputFileExtension = ".mp4"

Import-Module video_utils/Utils


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
    $replacedFilePathString = $FilePath.Replace(".\", "").Replace("\","").Replace(".mp4", "").Replace($FolderNameForAdjustedVideos, "").Replace($FolderNameForTemporaryVideos, "")

    $OutputFileName = $replacedFilePathString + "_" + $replacedTimespanString

    $outputFilePath = ""

    if ($CalledExternally)
    {
        $outputFilePath = "$FolderNameForAdjustedVideos\$OutputFileName"

    }
    else
    {
        $outputFilePath = "$FolderNameForTemporaryVideos\$OutputFileName"

    }
    mp4box -splitx $Timespan `"$FilePath`" -out $outputFilePath$outputFileExtension

    $returnValue = "$outputFilePath$outputFileExtension"

    return "$returnValue"
}

Export-ModuleMember -Function SplitVideo
