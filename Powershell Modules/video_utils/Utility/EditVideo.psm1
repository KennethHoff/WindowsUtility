Import-Module video_utils/Utility/Utils

Function EditVideo($FilePath, $TimeSpan, $AudioTrack, $Scale, $Folder)
{
    WriteToTerminal "Starting Splitting..." "EditVideo"

    $replacedTimeSpanString = $TimeSpan.Replace(":", "_")
    $timeSpanArray = $TimeSpan.Split("-")

    $startTime = $timeSpanArray[0]
    $endTime = $timeSpanArray[1]

    WriteToTerminal "Splitting video between $startTime and $endTime" "EditVideo"

    $replacedFilePathString = $FilePath.Replace(".\", "").Replace("\","").Replace(".mp4", "").Replace($Folder, "")

    $audioTracksString = $AudioTrack

    $OutputFileName = $replacedFilePathString + "_" + $replacedTimeSpanString + "_Tracks" + $audioTracksString
    writeToTerminal "Output File Name: $OutputFileName" "EditVideo"

    $outputFilePath = "$Folder\$OutputFileName.mp4"
    $outputFilePathCompressed = "$Folder\$OutputFileName`_Compressed.mp4"

    writeToTerminal "Output File Path: $outputFilePath" "EditVideo"

    $inputOptions = '-i ' +  $FilePath
    $outputOptions = $outputFilePath
    $scaleOptions = '-vf' + ' "scale=' + "$Scale`""
    $timeSpanOptions = '-ss ' + $startTime + ' -to ' + $endTime
    $audioTrackOptions = '-map 0:v:0 -map 0:a:' + $audioTrack
    $compressionOptions = '-vcodec libx264 -crf 28'

    WriteToTerminal "Input Options: [$inputOptions]" "EditVideo"
    WriteToTerminal "Output Options: [$outputOptions]" "EditVideo"
    WriteToTerminal "Scale Options: [$scaleOptions]" "EditVideo"
    WriteToTerminal "Timespan Options: [$timeSpanOptions]" "EditVideo"
    WriteToTerminal "Audio Track Options: [$audioTrackOptions]" "EditVideo"
    WriteToTerminal "Compression Options: [$compressionOptions]" "EditVideo"

    $finalCommand = "ffmpeg $inputOptions $($Scale ? $scaleOptions : '') $timeSpanOptions $audioTrackOptions $compressionOptions $outputOptions"

    WriteToTerminal "Final command: [$finalCommand]" "EditVideo"

    Invoke-Expression -Command $finalCommand

    WriteToTerminal "Completed Editing... Output File Path: $outputFilePath" "EditVideo"

    return $outputFilePath
}
