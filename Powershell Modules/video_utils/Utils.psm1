$FolderNameForAdjustedVideos = "Adjusted"
$FolderNameForTemporaryVideos = "Temporary"

Function CreateFolder()
{
    Param(
        $folderName
    )
    New-Item $folderName -itemType "directory"
}

Function DeleteFolder()
{
    Param(
        $folderName
    )
    Remove-Item $folderName -Recurse

}

Function CreateFolderIfNotAlreadyExists()
{
    Param(
        $folderName
    )

    $folderExists = Test-Path $folderName

    if (!$folderExists)
    {
        CreateFolder $folderName
    }
}

Function CreateTemporaryFolder()
{
    CreateFolderIfNotAlreadyExists $FolderNameForTemporaryVideos
}

Function CreateAdjustedFolder()
{
    CreateFolderIfNotAlreadyExists $FolderNameForAdjustedVideos
}

Function DeleteTemporaryFolder()
{
    DeleteFolder $FolderNameForTemporaryVideos
}

Function MoveItemFromTemporaryToAdjusted()
{
    Param(
        $InputFileName
    )

    $folderExists = Test-Path $FolderNameForAdjustedVideos

    if (!$folderExists)
    {
        New-Item $FolderNameForAdjustedVideos -ItemType Directory | Out-Null
    }
    Move-Item ".\$FolderNameForTemporaryVideos\$inputFileName" ".\$FolderNameForAdjustedVideos\$inputFileName" -force

}
Function WriteToTerminal()
{
    Param(
        $Text,
        $Source
    )
    Write-host "[$Source]: $Text" -ForegroundColor Blue
}
