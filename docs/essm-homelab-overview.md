# ESSM HomeLab Infrastructure Overview

## Project Summary

ESSM HomeLab is a multi-platform infrastructure environment designed for hands-on systems administration, service hosting, troubleshooting, automation, and operational documentation.

The environment combines Windows Server, Linux, Proxmox virtualization, Docker applications, centralized storage, networking, and cross-platform administration.

## Core Architecture

| Layer | Implementation |
|---|---|
| Virtualization | Three Proxmox VE hosts |
| Identity and name services | Windows Server 2022 with Active Directory Domain Services and DNS |
| Server operating systems | Ubuntu Server and Debian |
| Administration | Linux Mint, Windows 11, WSL2, SSH, Bash, and PowerShell |
| Applications | Docker and Docker Compose |
| Storage | Centralized NFS and Samba services |
| Monitoring | Custom host-health, connectivity, service-port, and reboot checks |

## Virtualized Workloads

The Proxmox environment hosts separate systems for:

- Active Directory and DNS
- Docker application hosting
- Centralized storage
- Security and administration
- Mattermost collaboration
- Gramps Web genealogy
- Linux testing and learning

A separate Debian system supports Jellyfin media services.

## Application Services

Deployed services include:

- Homepage
- Portainer
- Netdata
- Nginx Proxy Manager
- BookStack
- Paperless-ngx
- UniFi Network Application
- Mattermost
- Jellyfin
- Gramps Web

## Administration Model

Administrative access is centralized through Linux Mint and Windows Subsystem for Linux workstations. SSH keys and host aliases provide consistent remote access to authorized Linux, Proxmox, and Windows systems.

Custom ESSM commands provide:

- Rapid host-availability checks
- Consolidated infrastructure-health reporting
- Essential service-port testing
- Reboot-status reporting
- Standardized maintenance workflows

## Storage Services

Centralized Linux storage provides:

- NFS access for Linux systems
- Samba access for Windows-compatible clients
- Persistent client mounts
- Separate primary-storage and backup functions
- User and group permission management

## Skills Demonstrated

- Windows Server administration
- Active Directory and DNS
- Linux systems administration
- Proxmox virtualization
- Docker and Docker Compose
- SSH key management
- Bash and PowerShell
- TCP/IP and service-port troubleshooting
- NFS and Samba storage
- Technical documentation
- Incident investigation and validation

## Security and Privacy

This public overview is intentionally sanitized. Exact addresses, account names, credentials, keys, firewall rules, serial numbers, and other sensitive implementation details are excluded.
