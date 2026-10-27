# ESSM IT Operations Portfolio

<img width="1536" height="1024" alt="ESSM IT operations workspace" src="https://github.com/user-attachments/assets/03317cf4-0e59-4cd9-b230-27688db53881" />

This repository documents the design, administration, automation, and troubleshooting of **ESSMHomeLab.Local**, a working multi-platform homelab built to demonstrate practical IT support, systems administration, networking, virtualization, automation, and IT operations skills.

## AI-Assisted IT Operations Workflow

I use ChatGPT as an AI assistant within a disciplined technical workflow: **Define → Assess → Plan → Validate → Execute → Verify → Troubleshoot → Automate → Document → Version → Monitor → Improve**.

Human judgment remains authoritative. AI assists with research, analysis, planning, scripting, troubleshooting, automation, and documentation while I remain responsible for understanding the environment, evaluating risk, approving changes, and validating results.

- [AI-Assisted IT Operations Workflow](docs/ai-assisted-it-workflow.md)
- [PowerShell Beyond the Script: Building Modular Administration Tools That Last](docs/powershell-beyond-the-script.md) — independently authored architecture article with generic diagrams

## Portfolio Objectives

- Demonstrate practical Windows and Linux administration
- Build and manage virtualized infrastructure
- Administer Active Directory and internal DNS
- Deploy and maintain Docker-based applications
- Automate system-health and service checks
- Build repeatable information-processing and reporting workflows
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
| `essmhealthstatus` | Combines availability and detailed health into one report |
| `essmports` | Tests essential application and infrastructure ports |
| `essmupdate` | Supports standardized maintenance operations |

The tools use SSH, PowerShell, Bash, ping, and TCP port checks to gather information from Windows, Linux, and Proxmox systems.

## Automated Infrastructure Health Reporting

The custom `essmhealthstatus` workflow connects to authorized Windows, Linux, and Proxmox systems and produces a consolidated report containing platform version, uptime, connectivity state, and pending-reboot status.

A production wrapper runs the report automatically through Windows Task Scheduler and Ubuntu WSL. It preserves timestamped reports, identifies attention conditions, sends formatted email, logs delivery, retries transient failures, and runs missed tasks when the workstation becomes available.

- [Automated health reporting case study](docs/automated-health-reporting.md)
- [Sanitized daily email wrapper](scripts/essm-daily-email.sh)

![ESSM infrastructure health report](https://github.com/user-attachments/assets/a50439a9-abc7-4f44-9c46-f816712e6d8c)

## Featured Projects

### Automated Job Search & Application Tracker

Designed an automated multi-source job-discovery and application-tracking workflow that evaluates IT opportunities against relevant technical skills, separates remote from on-site/hybrid roles, detects duplicate listings, preserves application state, and generates an Excel application pipeline with dashboard reporting and direct application links.

The implementation demonstrates scheduled workflow automation, data normalization, classification, deduplication, state preservation, spreadsheet generation, output validation, and privacy-aware documentation.

- [Job search and application tracker case study](docs/job-search-application-tracker.md)

### Windows Server Active Directory and DNS

Deployed Windows Server 2022 as the laboratory domain controller and DNS server, including internal name resolution and cross-platform DNS testing.

### Centralized Storage Services

Configured Ubuntu storage services providing NFS shares for Linux systems and Samba shares for Windows-compatible access.

### Docker Application Platform

Deployed and managed infrastructure and business applications using Docker and Docker Compose, persistent volumes, port mappings, health verification, and log-based troubleshooting.

### WSL Administration Workstation

Configured Ubuntu under Windows Subsystem for Linux as a centralized administration console using systemd, SSH keys, host aliases, Bash tools, PowerShell integration, and scheduled cross-platform health reporting.

### Cockpit Browser-Based Administration

Designed a selective, Ansible-managed Cockpit rollout for Linux servers, including pilot validation, access restrictions, TLS planning, monitoring integration, and rollback procedures.

## Architecture and Documentation

- [AI-Assisted IT Operations Workflow](docs/ai-assisted-it-workflow.md)
- [ESSMHomeLab operations and readiness overview](docs/essm-homelab-overview.md)
- [Download the portfolio PDF](docs/essm-homelab-operations-overview.pdf)
- [Automated health reporting case study](docs/automated-health-reporting.md)
- [Automated job search and application tracker](docs/job-search-application-tracker.md)
- [Layered infrastructure automation program](docs/layered-infrastructure-automation.md)
- [Cockpit implementation guide](docs/cockpit-implementation-guide.md)
- [Sanitized infrastructure diagram](diagrams/essm-infrastructure.md)
- [Operational playbooks](playbooks/README.md)
- [Windows administration](windows-admin/README.md)
- [Docker application operations](docker/README.md)
- [Administration scripts overview](scripts/README.md)
- [Troubleshooting case studies](troubleshooting/README.md)

## Repository Structure

| Directory | Contents |
|---|---|
| [`docs`](docs/essm-homelab-overview.md) | Current environment overview, automation case studies, and supporting documentation |
| [`diagrams`](diagrams/essm-infrastructure.md) | Sanitized infrastructure diagrams |
| [`playbooks`](playbooks/README.md) | Repeatable operational procedures |
| [`windows-admin`](windows-admin/README.md) | Windows Server and workstation administration |
| [`docker`](docker/README.md) | Docker deployments and application operations |
| [`scripts`](scripts/README.md) | Administration and monitoring tool documentation |
| [`troubleshooting`](troubleshooting/README.md) | Technical problems, investigations, and resolutions |

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

This repository contains sanitized examples only. Passwords, authentication tokens, private keys, personal information, exact network details, live reports, private application history, and sensitive configuration values are not committed to GitHub.

## Professional Relevance

This work demonstrates experience applicable to IT support, desktop support, service desk, systems administration, application support, network support, IT operations, infrastructure automation, workflow automation, and practical AI-assisted technical operations.

## About the Author

Mark Hunsaker is an IT professional with more than 33 years of experience supporting users, hardware, software, systems, and networks. This portfolio demonstrates continued professional development through practical infrastructure projects, automation, troubleshooting, documentation, and responsible use of AI-assisted technical workflows.
