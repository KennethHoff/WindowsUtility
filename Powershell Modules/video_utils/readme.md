# How to use it:

## Step 0: Download the 'video_utils' folder

This can be done in a few ways, but I'll only mention this one (I recommend learning how to use Git however - for future reference)

Download the entire git repository via Github (On the Frontpage, press the green 'Code' button and press 'Download Zip') and then extracting the 'video_utils' folder from it (PowerShell Modules -> Video_utils)

## Step 1: Install Install [ffmpeg](https://www.ffmpeg.org/)

If you don't already have it, I recommend installing [Chocolatey](https://chocolatey.org/install) and using that to install it.

```markdown
Choco install ffmpeg
```

## [Optional] Step 2: Install PowerShell Core 7.x

If you don't already have it, I recommend using [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701)

There is a newer cross-platform version of PowerShell; [PowerShell Core](https://github.com/PowerShell/PowerShell).
That can also be [installed via Chocolatey](https://community.chocolatey.org/packages/powershell-core)

```markdown
Choco install powershell-core --pre 
```

After installing PowerShell Core you can open Windows Terminal, and press the array next to the tabs at the top of the window and press the cog wheel - "Settings".

In the settings panel, change the 'Default Profile' under 'Startup' to 'PowerShell' (As Opposed to 'Windows PowerShell'

Afterwards, relaunch Windows Terminal, or press the "+" button at the top to open an instance of PowerShell Core.

## Step 3: Create a PowerShell profile

In Windows Terminal, type the following command:
```markdown
Notepad $PROFILE
```

That will open the PowerShell profile in Notepad, such that you can edit it.

Insert the following values into the Notepad document

```markdown
Import-Module video_utils/ExportedFunctions
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
```

##Step 4: Put the video_Utils folder into the PowerShell Modules Folder

Find the PowerShell directory by typing the following command into PowerShell:

```markdown
$PROFILE
```

Inside the folder where that file resides, create a new folder 'Modules'. Inside that folder, put the video_utils folder you downloaded, such that the folder structure is like the following:

```markdown
<Documents>\PowerShell\Modules\video_utils
```

Inside the video_utils folder there should be two things; A 'Utility' folder with 3 files, and an 'ExportedFunctions' file.

## Step 5: Relaunch a PowerShell instance

This can be done in two ways: Either by relaunching Windows Terminal, or by pressing the "+"

If you experience any red errors, send me a message.

Otherwise, try typing 'SplitA' and then press Tab - if it autocompletes, then the functionality should be working.

## Step 6: Trying the software.

Open PowerShell inside a folder with an .mp4 file.

This can be done in two ways; Right-click on the 'background' of a folder with an .mp4 and press 'Open in Windows Terminal',

or use the following command.

```markdown
cd "<folder>"
```

where <folder> is the name of the path - for example

```markdown
cd "E:\Videos"
```

Now that you have Windows Terminal/PowerShell opened inside the folder you want to use it on, you can start using it.


SplitAndCompressVideo has the following functions. Press TAB after typing '-' to autocomplete:

```markdown
-InputFilePath <Path to .mp4 file> // REQUIRED
-TimeSpan <HH:MM:SS>-<HH:MM:SS> // OPTIONAL // <timestamp of start of clip>-<Timestamp of end of clip>
-AudioTrack <Press tab to see possible values> // OPTIONAL // Which Audio Track to use
-Scale <Press Tab to see possible values> // OPTIONAL // Use this to reduce resolution if the size is too large. (1080 => 1080P (1920*1080); Only works in 16:9 ratio)
```
This is an example of a function call that will cut the clip 'FunClip.mp4' between 45seconds and 1minute15seconds using audio track #2

```markdown
SplitAndCompressVideo -InputFilePath FunClip.mp4 -TimeSpan 00:00:45-00:01:15 -AudioTrack 2
```
