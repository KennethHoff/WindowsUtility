Import-Module video_utils/Utils

Function ConvertVideo_MKV_TO_MP4
{
    Param(
        $FilePath,
        $newFileName,
        $folderName,
        $audioTrack
    )
    $outputFilePath = "$folderName\$newFileName.mp4"
    WriteToTerminal "OutputFilePath: $outputFilePath" "ConvertVideo"

    ffmpeg -i "$FilePath" -map 0:v:0 -map 0:a:$audioTrack -codec copy "$outputFilePath"

    return $outputFilePath
}

Export-ModuleMember -Function ConvertVideo_MKV_TO_MP4
