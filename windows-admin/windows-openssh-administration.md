# Windows OpenSSH Administration

## Project Summary

OpenSSH Server was configured on a Windows 11 administrative system to support secure remote administration from Linux and WSL.

## Implementation

- Installed the Windows OpenSSH Server capability
- Started and enabled the SSH service
- Verified the Windows firewall rule
- Tested account context through a remote session
- Added the Windows system to cross-platform ESSM health reporting
- Adjusted remote commands for PowerShell syntax

## PowerShell Validation

```powershell
Get-Service sshd
Get-NetTCPConnection -LocalPort 22 -State Listen
Get-NetFirewallRule -DisplayName "*OpenSSH*"
whoami
hostname
```

## Cross-Platform Consideration

Linux command chaining and Windows PowerShell syntax are not identical. The ESSM automation selects commands appropriate to the target platform rather than assuming every SSH endpoint uses Bash.

## Skills Demonstrated

Windows optional features, Windows services, firewall validation, OpenSSH, PowerShell, WSL, and cross-platform remote administration.
