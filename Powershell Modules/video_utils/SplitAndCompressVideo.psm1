Import-Module video_utils/Utils

Function SplitAndCompressVideo {

    Param(
        [Parameter(Mandatory, HelpMessage="Enter the File path")]
        $InputFilePath,
        $Timespan,
        $Scale
    )
    #    0. Setup some runtime variables
    write-host "step-0"
    $ActiveFileName = ""

    #    1. Create Temporary Folders if it does not already exist
    write-host "step-1"
    CreateTemporaryFolder


    #    2. If there was a Timespan supplied, split the video
    write-host "step-2"

    if ($Timespan)
    {

        #   2a-1. Split up the video into the parts requested.
        #           > Into the 'Temporary' folder
        write-host "step-2a-1"

#        Write-Progress "Splitting..."
        #        2a-2. Set the 'ActiveFileName' to the path of the video (without the Temporary/Adjusted folder)
        write-host "step-2a-2"

        $ActiveFileName = SplitVideo $InputFilePath $Timespan $false
        #        2a-3. Add the temporary/adjusted folder back in
        write-host "step-2a-3"
    }
    else
    {
        #   2b-1. Set the 'ActiveFileName' to the input name; No changes required
        write-host "step-2b-1"
        $ActiveFileName = $InputFilePath
    }

    write-host "Video split"

    #    3. Compress the video into h.264 format
    #        > Into the 'Temporary' folder
    write-host "step-3"
#    Write-Progress "Compressing..."

    Write-Host "Active file name pre-compress: $ActiveFileName"

    $ActiveFileName = CompressVideo $ActiveFileName $Scale $false

    #    4. Create the Adjusted Folder (If it does not already exist),
    write-host "step-4"
    CreateAdjustedFolder

    #    5. Move the compressed video from the 'Temporary' folder into the 'Adjusted' folder.
    write-host "step-5"
    MoveItemFromTemporaryToAdjusted $ActiveFileName

    #    6.Delete the 'Temporary' folder
    write-host "step-6"
    DeleteTemporaryFolder
}

Export-ModuleMember -Function SplitAndCompressVideo
