# Offline installation, verification, and rollback

These instructions apply to the generic reference prototype, not an existing installation.

## Prerequisites

- Windows 10/11 or Windows Server with desktop experience.
- PowerShell 7 installed locally (`pwsh -v`), Windows Forms available.
- Administrative approval to access a specific target; local reads typically need fewer privileges.
- Remote CIM: WinRM/WSMan enabled and accessible on the target, appropriate firewall and authentication configuration, and permissions to read WMI/CIM. Do not enable WinRM or change firewall rules solely to try this prototype without approval.

## Stage and validate

1. Obtain the reviewed repository files from a trusted development machine. Transfer **only approved sanitized artifacts** through the permitted process.
2. On a test PC, place the project in a new version-specific folder, e.g. `C:\AdminTools\Dashboard-Prototype-v0.1\`. Do not overwrite an existing dashboard.
3. In a PowerShell 7 session run:

```powershell
pwsh -NoProfile -File .\tests\Smoke.Tests.ps1
pwsh -NoProfile -File .\src\Start-Dashboard.ps1
```

4. Verify **AdminHelp** fills the output box; select **System Information** and double-click it. Confirm accurate OS caption and build.
5. Check Clear Results and Save TXT using a harmless local test file.
6. Enter one specifically approved remote hostname and test Ping Target, then System Information. Record any name-resolution, permission, or WinRM failures as diagnostics, not as authorization to weaken security.
7. Confirm all existing production tools still run from their previous install paths.

## Rollback

Close the prototype and remove its version-specific directory. The prototype creates no scheduled tasks, registry settings, services, or automatic startup entries. Keep the prior dashboard directory and launcher unchanged.

## Release gates

- Source diff reviewed for private data and forbidden dependencies.
- Target validation and non-destructive smoke tests pass.
- GUI and permitted remote host tested on Windows 11 with PowerShell 7.
- Backup copy exists; checksum/signature recorded for every approved transfer.
- Operator signs off before deployment or integration.

**Known limitation:** network reads currently execute synchronously on the GUI thread. A slow or unreachable target can make the window temporarily unresponsive; treat this as an early prototype until asynchronous execution and timeout handling are validated.
