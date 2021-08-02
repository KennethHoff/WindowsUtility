Import-Module video_utils/Utility/Utils

Function ConvertVideo()
{
    Param(
        $inputFilePath
    )

    WriteToTerminal "Converting $inputFilePath to .mp4" "ConvertVideo"

    $extension = (([IO.FileInfo]$inputFilePath).Extension)

    WriteToTerminal "Input Extension: $extension" "ConvertVideo"

    $outputFilePath = $inputFilePath.Replace($extension, ".mp4")

    WriteToTerminal "Ouput File Path : $outputFilePath" "ConvertVideo"

    ffmpeg -i $inputFilePath -map $outputFilePath
}
