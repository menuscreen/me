<#
.SYNOPSIS
    A script to reset the network settings and initiate optional reboot on a Windows system.
.DESCRIPTION
    This script resets TCP/IP settings, flushes DNS cache, releases and renews IP addresses, resets Winsock settings,
    prompts the user to reboot immediately or manually at a later time.
.PARAMETER Verbose
    Provides detailed output of the commands being executed.
.EXAMPLE
    .\ResetNetwork.ps1 -Verbose
.AUTHOR
    menuscreen
.DATE
    August 19, 2023
#>

param (
    # Verbose switch provides detailed output
    [switch]$Verbose
)

Add-Type -AssemblyName System.Windows.Forms

# Perform network reset
function Reset-Network {
    Write-Host "Resetting TCP/IP Stack..."
    # If Verbose flag is provided, print detailed output
    if ($Verbose) { netsh int ip reset }
    else { netsh int ip reset | Out-Null }

    Write-Host "Flushing DNS Cache..."
    if ($Verbose) { ipconfig /flushdns }
    else { ipconfig /flushdns | Out-Null }

    Write-Host "Releasing IP Address..."
    if ($Verbose) { ipconfig /release }
    else { ipconfig /release | Out-Null }

    Write-Host "Renewing IP Address..."
    if ($Verbose) { ipconfig /renew }
    else { ipconfig /renew | Out-Null }

    Write-Host "Resetting Winsock Catalog..."
    if ($Verbose) { netsh winsock reset }
    else { netsh winsock reset | Out-Null }

    Write-Host "Network reset completed."
}

# Prompt user for reboot decision
function Prompt-Reboot {
    $message = "Your network has been reset. Would you like to reboot now or later?"
    $title = "Network Reset - Reboot Decision"
    $yesNoChoice = 4
    $questionIcon = 32
    $result = [System.Windows.Forms.MessageBox]::Show($message, $title, $yesNoChoice, $questionIcon)

    if ($result -eq "Yes") {
        Reboot-Now
    } else {
        Write-Host "Reboot deferred. Please reboot manually at your convenience."
    }
}


# Reboot the system immediately
function Reboot-Now {
    Write-Host "Rebooting now..."
    shutdown.exe -r -t 0 | Out-Null
}

# Main execution
try {
    Reset-Network
}
catch {
    Write-Host "An error occurred while resetting the network. Please run the script as an administrator or check the commands."
}
try {
    Prompt-Reboot
}
catch {
    Write-Host "An error occurred when prompting to reboot. Please run the script as an administrator or check the commands."
}
