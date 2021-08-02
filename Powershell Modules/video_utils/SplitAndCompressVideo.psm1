$FolderNameForAdjustedVideos = "Adjusted"
$FolderNameForTemporaryVideos = "Temporary"

Import-Module video_utils/Utils

Function SplitAndCompressVideo {

    Param(
        [Parameter(Mandatory, HelpMessage="Enter the File path", Position = -1)]
        $InputFilePath,
        [Parameter(Position = -1)]
        $Timespan,
        [Parameter(Position = -1)]
        [Int] $Scale,
        [Parameter(Position = -1)]
        [Int] $AudioTrack = 1
    )

    #    0. Setup some runtime variables
    WriteToTerminal "step-0: Set up runtime" "SplitAndCompress"
    $ActiveFilePath = ""

    #    1. Create Temporary Folders if it does not already exist
    WriteToTerminal "step-1: Create Temporary Folder" "SplitAndCompress"
    CreateTemporaryFolder

    #   2. Make sure the video is a .mp4 file

#    WriteToTerminal "step-2: Make sure it is .mp4 file" "SplitAndCompress"
#
#    $inputFileName = (Split-Path -Path $InputFilePath -Leaf).Split(".")[0];
#
##    $inputFileName = "`"$inputFileName`""
#    $inputFileExtension = (Split-Path -Path $InputFilePath -Leaf).Split(".")[1];
#
#    WriteToTerminal "inputFileName: $inputFileName" "SplitAndCompress"
#    WriteToTerminal "inputFileExtension: $inputFileExtension" "SplitAndCompress"
#
#    switch ($inputFileExtension)
#    {
#        "mp4" {
#            WriteToTerminal "Extension is MP4" "SplitAndCompress"
#            $ActiveFilePath = $InputFilePath
#        }
#        "mkv" {
#            WriteToTerminal "Extension is MKV. Converting to MP4" "SplitAndCompress"
#            $ActiveFilePath = ConvertVideo_MKV_TO_MP4 $InputFilePath $inputFileName $FolderNameForTemporaryVideos $AudioTrack
#        }
#    }

    $ActiveFilePath = ChooseAudioTrack $InputFilePath $AudioTrack $FolderNameForTemporaryVideos

    #    3. If there was a Timespan supplied, split the video
    WriteToTerminal "step-3: Split video if Timespan supplied" "SplitAndCompress"

    if ($Timespan)
    {
        #    3a. Set the 'ActiveFileName' to the path of the video (without the Temporary/Adjusted folder)
        WriteToTerminal "step-3a: Splitting Video" "SplitAndCompress"

        WriteToTerminal "ActiveFilePath: $ActiveFilePath" "SplitAndCompress"

        $ActiveFilePath = SplitVideo $ActiveFilePath $Timespan $false
    }
    else {
        #   3b. Do nothing
        WriteToTerminal "Step-3b: Not splitting video - TimeSpan not supplied" "SplitAndCompress"
    }


    #    4. Compress the video into h.264 format
    #        > Into the 'Temporary' folder
    WriteToTerminal "step-4: Compress Video" "SplitAndCompress"

    $ActiveFilePath = (CompressVideo $ActiveFilePath $Scale $false)[-1]

    WriteToTerminal $ActiveFilePath "SplitAndCompress"

    #    5. Create the Adjusted Folder (If it does not already exist),
    WriteToTerminal "step-5: Create 'Adjusted' Folder" "SplitAndCompress"
    CreateAdjustedFolder

    #    6. Move the compressed video from the 'Temporary' folder into the 'Adjusted' folder.
    WriteToTerminal "step-6: Move item from Temporary -> Adjusted" "SplitAndCompress"
    MoveItemFromTemporaryToAdjusted $ActiveFilePath

    #    7.Delete the 'Temporary' folder
    WriteToTerminal "step-7: Delete 'Temporary' folder" "SplitAndCompress"
    DeleteTemporaryFolder
}

Export-ModuleMember -Function SplitAndCompressVideo
