# Cross-Platform SSH Administration from WSL

## Project Summary

Ubuntu under Windows Subsystem for Linux was configured as an administration workstation for Windows, Linux, and Proxmox systems in the ESSM HomeLab.

## Challenge

The environment includes Proxmox VE, Ubuntu Server, Debian, and Windows Server. A consistent remote-management process was needed from a Windows 11 workstation.

## Implementation

The WSL2 environment was configured with:

- Ubuntu 24.04
- systemd support
- OpenSSH client
- ED25519 authentication
- SSH host aliases
- ESSM administration commands
- Cross-platform health checks

## Cross-Platform Considerations

Linux targets accept standard shell syntax:

```bash
hostname && uptime
```

Windows OpenSSH sessions require PowerShell-compatible syntax:

```powershell
hostname; Get-Uptime
```

The reporting automation sends commands appropriate to each target platform.

## Validation

Connectivity and key authentication were tested with non-interactive checks:

```bash
ssh -o BatchMode=yes -o ConnectTimeout=5 <host-alias> hostname
```

Successful tests confirmed authorized access to the Proxmox, Ubuntu, Debian, and Windows Server systems.

## Outcome

The Windows workstation now functions as a centralized command console without requiring a separate Linux computer.

## Skills Demonstrated

WSL2, SSH key authentication, Windows OpenSSH, PowerShell, Bash, cross-platform administration, shell customization, and connectivity validation.
