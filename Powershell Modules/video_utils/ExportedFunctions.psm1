$FolderNameForAdjustedVideos = "Adjusted"
$FolderNameForTemporaryVideos = "Temporary"

Import-Module video_utils/Utility/Utils

Import-Module video_utils/Utility/EditVideo
Import-Module video_utils/Utility/ConvertVideo

Function SplitAndCompressVideo() {
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        [String]
        $InputFilePath,

        [String]
#        [ValidatePattern('^(([\d])+:([\d]|end|end(-[\d]*))+)$')] # Digit:Digit // Digit:End // Digit:End-Digit
        # -TimeSpan 00:01:23-00:01:40
        $Timespan = $false,

        [Int]
        [ValidateSet(360, 480, 720, 1080, 1440, 2160,ErrorMessage="Value '{0}' is invalid. Try one of: '{1}'")]
        $Scale,

        [Int]
        [ValidateSet(0,1,2,3,4,5)]
        $AudioTrack = 1
    )

    #    1. Create 'Temporary' and 'Adjusted' Folder if they do not already exist
    WriteToTerminal "step-1: Create Temporary Folder" "SplitAndCompressVideo"
    CreateTemporaryFolder
    CreateAdjustedFolder

    #   2. Make sure the video is a .mp4 file
    WriteToTerminal "step-2: Make sure file is .MP4" "SplitAndCompressVideo"
    if (!($InputFilePath.EndsWith(".mp4")))
    {
        WriteToTerminal "This software requires an MP4" "SplitAndCompressVideo"
        return
    }

    #    3. Figure out variables
    WriteToTerminal "step-3: Figuring out variables" "SplitAndCompressVideo"

    #   4. Edit video
    WriteToTerminal "Editing Video..." "SplitAndCompressVideo"
    $verticalScale = ($scale) ? $Scale * 16/9 : $false
    $ActiveFilePath = EditVideo $InputFilePath $Timespan $AudioTrack $verticalScale $FolderNameForTemporaryVideos

    #    5. Move the compressed video from the 'Temporary' folder into the 'Adjusted' folder.
    WriteToTerminal "step-6: Move item from 'Temporary' -> 'Adjusted'" "SplitAndCompressVideo"
    MoveItemFromTemporaryToAdjusted $ActiveFilePath

    #    6.Delete the 'Temporary' folder
    WriteToTerminal "step-6: Delete 'Temporary' folder" "SplitAndCompressVideo"
    DeleteTemporaryFolder
}

Export-ModuleMember -Function SplitAndCompressVideo
Export-ModuleMember -Function ConvertVideo
