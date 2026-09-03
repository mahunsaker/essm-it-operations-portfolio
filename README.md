# ESSM IT Operations Portfolio

<img width="1536" height="1024" alt="ESSM IT operations workspace" src="https://github.com/user-attachments/assets/03317cf4-0e59-4cd9-b230-27688db53881" />

This repository documents the design, administration, automation, and troubleshooting of **ESSMHomeLab.Local**, a working multi-platform homelab built to demonstrate practical IT support, systems administration, networking, virtualization, and IT operations skills.

## Portfolio Objectives

- Demonstrate practical Windows and Linux administration
- Build and manage virtualized infrastructure
- Administer Active Directory and internal DNS
- Deploy and maintain Docker-based applications
- Automate system-health and service checks
- Document troubleshooting methodology and resolutions
- Develop repeatable IT procedures and operational playbooks

## Infrastructure Overview

| Component | Purpose |
|---|---|
| Three Proxmox VE hosts | Host and manage virtual machines |
| Windows Server 2022 | Active Directory Domain Services and DNS |
| Ubuntu and Debian servers | Application, storage, security, and Docker workloads |
| Linux Mint, WSL, and Windows 11 | Administrative workstations |
| Docker | Runs infrastructure and business applications |
| NFS and Samba | Provide Linux and Windows file sharing |
| SSH | Provides secure remote administration |
| Bash and PowerShell | Automate administration and reporting |

Exact addresses, credentials, and sensitive configuration details are intentionally excluded from this public portfolio.

## Deployed Services

- Active Directory Domain Services and Microsoft DNS
- Proxmox VE
- Docker and Docker Compose
- Homepage, Portainer, Netdata, and Nginx Proxy Manager
- BookStack and Paperless-ngx
- UniFi Network Application
- Mattermost
- Jellyfin
- Gramps Web
- NFS and Samba file sharing

## Administration and Automation

| Command | Function |
|---|---|
| `essmhelp` | Displays ESSM commands and SSH targets |
| `essmstatus` | Tests whether core systems respond over the network |
| `essmhealth` | Collects platform, uptime, health, and reboot information |
| `essmports` | Tests essential application and infrastructure ports |
| `essmupdate` | Supports standardized maintenance operations |

The tools use SSH, PowerShell, Bash, ping, and TCP port checks to gather information from Windows, Linux, and Proxmox systems.

## Automated Infrastructure Health Reporting

The custom `essmhealth` command connects to authorized Windows, Linux, and Proxmox systems and produces a consolidated report containing hostname, role, platform version, uptime, connectivity state, and pending-reboot status.

![ESSM infrastructure health report](https://github.com/user-attachments/assets/a50439a9-abc7-4f44-9c46-f816712e6d8c)

## Featured Projects

### Windows Server Active Directory and DNS

Deployed Windows Server 2022 as the laboratory domain controller and DNS server, including internal name resolution and cross-platform DNS testing.

### Centralized Storage Services

Configured Ubuntu storage services providing NFS shares for Linux systems and Samba shares for Windows-compatible access.

### Docker Application Platform

Deployed and managed infrastructure and business applications using Docker and Docker Compose, persistent volumes, port mappings, health verification, and log-based troubleshooting.

### WSL Administration Workstation

Configured Ubuntu under Windows Subsystem for Linux as a centralized administration console using systemd, SSH keys, host aliases, Bash tools, and PowerShell integration.

## Architecture and Documentation

- [Infrastructure diagram](diagrams/essm-infrastructure.md)
- [Administration scripts overview](scripts/README.md)
- [Troubleshooting case studies](troubleshooting/README.md)

## Repository Structure

| Directory | Contents |
|---|---|
| `docs` | Environment overviews and supporting documentation |
| `diagrams` | Sanitized infrastructure and network diagrams |
| `scripts` | Bash and PowerShell administration scripts |
| `playbooks` | Repeatable operational procedures |
| `troubleshooting` | Technical problems, investigations, and resolutions |
| `windows-admin` | Windows Server and workstation administration |
| `linux-admin` | Linux administration procedures |
| `networking` | DNS, TCP/IP, service ports, and connectivity |
| `docker` | Docker deployments and application operations |
| `resume-projects` | Project summaries for interviews and resumes |

## Troubleshooting Methodology

1. Record the reported symptom.
2. Identify the affected system and service.
3. Verify basic network connectivity.
4. Test DNS resolution and required ports.
5. Review service, application, and operating-system status.
6. Examine relevant logs.
7. Implement the least disruptive correction.
8. Validate service restoration.
9. Record the cause, resolution, and prevention steps.

## Security and Privacy

This repository contains sanitized examples only. Passwords, authentication tokens, private keys, personal information, exact network details, and sensitive configuration values are not committed to GitHub.

## Professional Relevance

This work demonstrates experience applicable to IT support, desktop support, service desk, systems administration, application support, network support, and IT operations roles.

## About the Author

Mark Hunsaker is an IT professional with more than 33 years of experience supporting users, hardware, software, systems, and networks. This portfolio demonstrates continued professional development through practical infrastructure projects, automation, troubleshooting, and documentation.
