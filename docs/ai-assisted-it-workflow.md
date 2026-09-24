# AI-Assisted IT Operations Workflow

## Mark Hunsaker + ChatGPT

**Practical AI-assisted IT operations, automation, troubleshooting, documentation, and continuous learning.**

This document describes how I use ChatGPT as an AI assistant in technical work. The objective is not to replace technical knowledge or human judgment. It is to combine practical IT experience with AI-assisted research, analysis, planning, scripting, troubleshooting, automation, and documentation to build reliable and repeatable solutions.

> **Human judgment remains authoritative. AI assists the process.**

## The 12-Step Workflow

| Step | Stage | Purpose |
|---|---|---|
| 1 | **Define** | Establish the technical objective, environment, constraints, and success criteria. |
| 2 | **Assess** | Gather facts from systems, configurations, logs, screenshots, documentation, and observed behavior. |
| 3 | **Plan** | Develop a staged implementation or troubleshooting approach and identify dependencies. |
| 4 | **Validate First** | Check prerequisites, backups, connectivity, permissions, recovery options, and rollback paths before making changes. |
| 5 | **Execute** | Apply commands, scripts, configurations, or infrastructure changes in a controlled manner. |
| 6 | **Verify** | Test services, ports, storage, networking, applications, system health, and expected results. |
| 7 | **Troubleshoot** | Analyze errors and symptoms, identify root causes, and adapt the plan using evidence. |
| 8 | **Automate** | Convert proven manual procedures into repeatable scripts, scheduled workflows, reports, and maintenance processes. |
| 9 | **Document** | Capture procedures, lessons learned, diagrams, checklists, runbooks, and technical references. |
| 10 | **Version & Archive** | Preserve appropriate scripts and documentation in GitHub with meaningful organization and change history. |
| 11 | **Monitor & Improve** | Use health checks, alerts, reports, logs, and recurring review to identify improvements and maintain reliability. |
| 12 | **Human + AI** | I provide experience, environmental context, risk judgment, and final decisions; ChatGPT assists with research, analysis, ideas, scripting, and documentation. |

## Real-World Example: PVE02 VM Storage Recovery

A recent ESSMHomeLab incident demonstrates the workflow in practice. A failing HDD produced medium errors and unrecovered read errors while virtual-machine storage was being migrated to NVMe. The response was deliberately staged rather than forcing the failed migration.

1. **Identify** — storage I/O errors were confirmed on the source HDD.
2. **Protect** — affected virtual machines were stopped or handled conservatively before storage changes.
3. **Migrate** — healthy VM disks were moved to the new NVMe storage first.
4. **Recover** — the remaining VM disk was recovered from the failing source using GNU ddrescue and a persistent mapfile.
5. **Validate** — the recovered raw image, partition table, storage registration, and boot configuration were checked before startup.
6. **Restore** — the recovered VM was attached to NVMe storage and successfully returned to service.
7. **Application validation** — network reachability, SSH, Mattermost service availability, and PostgreSQL database accessibility were verified.
8. **Back up** — a fresh Proxmox backup was created from the recovered NVMe VM and the Zstandard archive passed an integrity test.

The case demonstrates a core principle of the workflow: **do not treat a successful command as proof of a successful change. Validate the system and the service afterward.**

## Technologies Used Across the Workflow

- Proxmox VE and virtualization
- Linux administration
- Windows and PowerShell
- Windows Subsystem for Linux (WSL)
- Active Directory and DNS
- TCP/IP networking and service-port testing
- SSH administration
- Docker and Docker Compose
- NFS and Samba storage
- Backup, recovery, and integrity verification
- Bash scripting and scheduled automation
- Git and GitHub
- Monitoring, reporting, and operational documentation

## Operating Principles

### Safety first
Before consequential changes, establish current state, backups, dependencies, recovery options, and rollback paths.

### Evidence over assumptions
Logs, configuration output, service state, connectivity tests, and application behavior determine the next troubleshooting step.

### Validate at multiple layers
A VM reporting `running` does not prove its operating system, network, database, or application is healthy. Validation should follow the stack from infrastructure to application.

### Automate proven procedures
Automation should normally follow a successful manual process. This reduces the risk of automating an incorrect assumption.

### Document while the evidence is fresh
Successful troubleshooting becomes substantially more valuable when converted into a reusable procedure or case study.

### Sanitize public documentation
Public portfolio material excludes credentials, authentication secrets, private keys, exact private-network details, sensitive operational information, and unrelated personal information.

## Why I Use AI This Way

AI is most useful to me when it strengthens a disciplined technical process. It can accelerate research, help analyze command output, generate candidate scripts, identify validation steps, improve documentation, and preserve continuity across a complex project. The administrator remains responsible for understanding the environment, evaluating risk, approving changes, and confirming results.

The goal is straightforward:

**Define → Assess → Plan → Validate → Execute → Verify → Troubleshoot → Automate → Document → Version → Monitor → Improve**

---

**ESSMHomeLab.Local** — Build · Learn · Automate · Share
