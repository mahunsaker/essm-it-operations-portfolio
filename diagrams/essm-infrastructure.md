# ESSM HomeLab Infrastructure

This sanitized diagram presents the major infrastructure roles without exposing exact addresses, credentials, or sensitive configuration.

```mermaid
flowchart TD
    WAN["AT&T Fiber"] --> LAN["Private LAN"]
    LAN --> Admin["Admin Workstations"]
    LAN --> PVE["Three Proxmox Hosts"]
    LAN --> Physical["Physical Systems"]

    PVE --> Core["Core Infrastructure VMs"]
    PVE --> Apps["Application VMs"]

    Core --> Identity["Windows Server<br/>AD DS and DNS"]
    Core --> Storage["NFS and Samba Storage"]
    Core --> Docker["Docker Application Host"]

    Apps --> Collaboration["Mattermost"]
    Apps --> Genealogy["Gramps Web"]

    Physical --> Media["Debian and Jellyfin"]
```

## Major Infrastructure Functions

| Area | Technology |
|---|---|
| Virtualization | Proxmox VE |
| Identity | Windows Server Active Directory |
| Name resolution | Microsoft DNS |
| Applications | Docker and Docker Compose |
| Storage | NFS and Samba |
| Administration | SSH, Bash, PowerShell, and WSL |
| Monitoring | Custom ESSM health and port checks |

The public diagram emphasizes architecture and skills while intentionally omitting implementation details that are unnecessary for an employment portfolio.
