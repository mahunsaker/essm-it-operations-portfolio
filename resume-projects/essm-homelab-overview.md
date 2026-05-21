# ESSM HomeLab Infrastructure Overview

## Project Summary

ESSM HomeLab is a multi-system infrastructure environment designed for hands-on learning, systems administration practice, service hosting, troubleshooting, automation, and operational documentation.

The environment combines Linux, Windows Server, virtualization, Docker services, networking, storage management, and media infrastructure into a unified learning and operations platform.

---

# Core Infrastructure

## Hypervisors

### Proxmox Nodes

| Hostname | Hardware | Purpose |
|---|---|---|
| pve01 | Lenovo Mini i5-6500T 32GB RAM | Virtualization host |
| pve | HP EliteDesk Mini i5-6500T 16GB RAM | Virtualization host |

---

# Virtual Machines

| VM | Operating System | Purpose |
|---|---|---|
| DC01 | Windows Server 2022 | Active Directory, DNS |
| docker-host | Ubuntu Server | Docker services |
| storage-vm | Ubuntu Server | NFS and SMB storage |
| UB01 | Ubuntu Server | Linux administration/testing |
| UB03 | Ubuntu Server | CasaOS and Docker workloads |

---

# Core Services

## Infrastructure Services

- Active Directory
- DNS
- DHCP
- SMB file sharing
- NFS exports

## Docker Services

- Jellyfin
- Portainer
- Nginx Proxy Manager
- Homepage Dashboard
- Paperless-ngx
- Kavita
- BookStack
- Unifi Controller

---

# Networking

## Network Environment

- 192.168.1.0/24
- ATT Fiber gateway
- Managed switches
- Wireless access points
- Remote RV connectivity

## Technologies Used

- VLAN concepts
- DNS troubleshooting
- DHCP management
- Network diagnostics
- Port management
- Reverse proxy routing

---

# Storage Infrastructure

## Shares

| Share | Purpose |
|---|---|
| storage6TB | Primary media and storage |
| backup15 | Backup storage |

## Protocols

- SMB/CIFS
- NFS

---

# Skills Demonstrated

- Linux administration
- Windows Server administration
- Active Directory management
- DNS troubleshooting
- Docker deployment
- Storage management
- Network troubleshooting
- Documentation development
- Service deployment
- Infrastructure planning

---

# Ongoing Development

Current roadmap includes:

- Automation workflows
- Infrastructure monitoring
- Security hardening
- Centralized documentation
- AI-assisted knowledge systems
- Advanced Docker orchestration
- Operational playbooks

