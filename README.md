# sl0ppy-ALPI
Automated LSASS Process Impersonation Rename defender folders to windows fuck.

# Release 
* `v1.1` rolled out as a test.

# Info
* This Worked on windows 10 and 11 versions prio to 22h2, as they patched it in (22h2!!!)
* Windows changed the Dark blue permissions for lsass process to a light blue NTAUTH process.
* U can verify it with tools like processhacker2 and others to confirm 22h2 has light blue indicator for the lsass process.
* The Dark blue was a parent that was assigned to lsass.exe in versions `prio to 22h2`, and `as of 22h2 its a light blue child process` (which fixed the issue of the abuse of lsass process by impersonating it.

# Extra info
* A threat actor could change the instructions to rename defender to any other instructions, like load malware after defender been renamed and lots more, like file lock a system and such, i don't go in details here... 
* A threat actor could weaponize| stage this multi times to perform task as NT Authority on kernel levels 

# Needed 
* Adminpriv > example `UAC Bypass` or `Weaponized UAC Bypass| Staged UAC Bypass` 

# Usage 
* Place folder on desktop (or change folder path)
* Open sl0ppy-ntauth.ps1 change username to `yourusername` safe file  
* Run `Sl0ppy-ntauth.ps1` 

# Patch 
* Update to 22h2, will fix this bug.

# Change Log 
* fixed folder location in exe's
* rolled out new exe's and added to repo
* changed ps1 folder issue

# Legal Disclaimer: 
* `I am not responsible for U using it on non authorized systems, make sure u use it on systems u own or are authorized on.` 

* `x0xr00t` 
