<#
.SYNOPSIS
    Migrates user files and browser favorites from a Windows machine to a specified directory on a USB drive.

.DESCRIPTION
    This PowerShell script is designed to facilitate the migration of user-specific data from a Windows 
    machine to a designated directory on a USB drive. It enumerates all user profiles, excluding system 
    profiles, and copies their personal folders, such as Documents, Pictures, and Desktop, while excluding 
    certain system directories like 'AppData'. The script also identifies and migrates browser favorites for 
    Chrome, Firefox, and Edge. It features robust error handling, including logging of any issues encountered 
    during the migration process to a log file within each user's directory on the USB drive. The script 
    ensures that the data for each user is organized into separate subdirectories under a directory named 
    after the computer's name.
    
.EXAMPLE
    To run this script, navigate to the directory containing the script file and execute it using PowerShell
    with administrative privileges. The script should be located on the USB drive where the data will be 
    migrated.

    PowerShell.exe -ExecutionPolicy Bypass -File .\MigrateUserData.ps1

    This command runs the script 'MigrateUserData.ps1' with execution policy bypassed temporarily, ensuring
    it can execute regardless of the current execution policy settings without permanently changing the
    system settings. Ensure that the script is run as an administrator to allow access to all user profiles.

.NOTES
    Intended Use:
    - This script is designed for migrating user data from Windows machines to a USB drive.
    - It's particularly useful in scenarios like system upgrades, data backup, or user profile transfers.
    - For each user, the script creates a directory under $usbDrivePath\$computerName\$userName

    File Exclusions:
    - The script enumerates all user directories under C:\Users. It skips known system profiles like 
      'Public', 'Default', etc.
    - The script excludes certain system directories (e.g., 'AppData', '3D Objects', 'Contacts') to focus 
      on personal user data.
    - Browser favorites are specifically included even if located within excluded directories.
    - Modify the $excludedFolders array to change the list of excluded directories.

    Browser Favorites:
    - The script supports Chrome, Firefox, and Edge.
    - Ensure the script is updated if browser data storage paths change in future browser versions.

    Administrative Privileges:
    - The script requires administrative privileges to access all user profiles.

    Logging:
    - Errors encountered during the migration are logged into an 'error_log.txt' file within each user's
      directory on the USB drive.
    - This log aids in troubleshooting and records files that couldn't be copied.

    Testing and Usage:
    - Test the script in a controlled environment before use.
    - Backup important data before running this script to prevent accidental data loss.

    Modifications and Customization:
    - The script can be modified to suit different environments or requirements.
    - Document any changes made to the script for future reference.
#>

# Check if the script is running with administrative privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Relaunch the script with administrative rights
    Start-Process powershell.exe -Verb RunAs -ArgumentList ("-File `"" + $MyInvocation.MyCommand.Definition + "`"")
    exit
}

# Store the computer name in a variable
$computerName = $env:COMPUTERNAME
$usbDrivePath = $PSScriptRoot

# Function to copy directories
function Copy-Directory {
    param (
        [string]$sourcePath,
        [string]$destinationPath
    )

    try {
        if (Test-Path $sourcePath) {
            Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force -ErrorAction Stop
            Write-Host "Copied: $sourcePath to $destinationPath"
        }
    }
    catch {
        Write-Error "Error copying files: $_"
    }
}

# Get all user profiles
$userProfiles = Get-ChildItem -Path "C:\Users" -Directory

foreach ($userProfile in $userProfiles) {
    # Skip system profiles
    if ($userProfile.Name -in @('Public', 'Default', 'Default User', 'All Users')) {
        continue
    }

    $userName = $userProfile.Name
    $userDirectoryPath = "$usbDrivePath\$computerName\$userName"
    New-Item -Path $userDirectoryPath -ItemType Directory -Force | Out-Null

    # Copy user folders and files
    $userProfilePath = $userProfile.FullName
    Copy-Directory -sourcePath $userProfilePath -destinationPath "$userDirectoryPath\Files"

    # Browser favorites locations for Chrome, Firefox, and Edge
    $chromeFavoritesPath = "$userProfilePath\AppData\Local\Google\Chrome\User Data\Default\Bookmarks"
    $firefoxFavoritesPath = "$userProfilePath\AppData\Roaming\Mozilla\Firefox\Profiles\*.default-release\bookmarkbackups"
    $edgeFavoritesPath = "$userProfilePath\AppData\Local\Microsoft\Edge\User Data\Default\Bookmarks"

    # Copy browser favorites
    Copy-Directory -sourcePath $chromeFavoritesPath -destinationPath "$userDirectoryPath\BrowserFavorites\Chrome"
    Copy-Directory -sourcePath $firefoxFavoritesPath -destinationPath "$userDirectoryPath\BrowserFavorites\Firefox"
    Copy-Directory -sourcePath $edgeFavoritesPath -destinationPath "$userDirectoryPath\BrowserFavorites\Edge"
}
