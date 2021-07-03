Import-Module video_utils/Utils

Function SplitAndCompressVideo {

    Param(
        [Parameter(Mandatory, HelpMessage="Enter the File path")]
        $InputFilePath,
        $Timespan,
        $Scale
    )
    #    0. Setup some runtime variables
    $ActiveFileName = ""

    #    1. Create Temporary Folders if it does not already exist
    CreateTemporaryFolder

    #    2. If there was a Timespan supplied, split the video
    if ($Timespan)
    {
        #   2a-1. Split up the video into the parts requested.
        #           > Into the 'Temporary' folder

        Write-Progress "Splitting..."
        #        2a-2. Set the 'ActiveFileName' to the path of the video (without the Temporary/Adjusted folder)
        $ActiveFileName = SplitVideo_Internal $InputFilePath $Timespan $false
        #        2a-3. Add the temporary/adjusted folder back in
        $ActiveFileName = "$FolderNameForTemporaryVideos\$ActiveFileName"
    }
    else
    {
        #   2b-1. Set the 'ActiveFileName' to the input name; No changes required
        $ActiveFileName = $InputFilePath
    }

    #    3. Compress the video into h.265 format
    #        > Into the 'Temporary' folder
    Write-Progress "Compressing..."

    $ActiveFileName = CompressVideo $ActiveFileName $Scale $false

    #    4. Create the Adjusted Folder (If it does not already exist), and move the compressed video from the 'Temporary' folder into the 'Adjusted' folder.
    CreateAdjustedFolder
    MoveItemFromTemporaryToAdjusted $ActiveFileName

    #    5.Delete the 'Temporary' folder
    DeleteTemporaryFolder
}

Export-ModuleMember -Function SplitAndCompressVideo
