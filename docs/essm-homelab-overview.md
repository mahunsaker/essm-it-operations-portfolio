# ESSMHomeLab Operations and Readiness Overview

> **Public portfolio edition:** This document describes the design, administration, monitoring, and operational practices used in ESSMHomeLab. Exact addresses, account names, credentials, private keys, storage paths, share names, and sensitive configuration values are intentionally excluded.

## Executive Summary

ESSMHomeLab is a working multi-platform environment built for hands-on systems administration, technical support, virtualization, networking, application support, automation, and operational documentation. It combines three Proxmox VE hosts, Windows Server Active Directory and DNS, Ubuntu and Debian servers, Docker applications, centralized storage, Linux and Windows administration workstations, and custom health-reporting tools.

The environment is managed as a small production-style infrastructure platform. Systems are assigned defined roles, dependencies are documented, expected network services are tested, pending reboots are tracked, and application readiness is verified beyond simple host availability.

## Environment at a Glance

| Area | Implementation |
|---|---|
| Virtualization | Three independently managed Proxmox VE hosts |
| Identity and DNS | Windows Server 2022 with Active Directory Domain Services and Microsoft DNS |
| Server platforms | Ubuntu Server, Debian, and Linux Mint |
| Application platform | Docker and Docker Compose |
| Storage | Centralized NFS and Samba services with separate primary and backup storage functions |
| Administration | Windows 11 with WSL2 and a Linux Mint administrative workstation |
| Automation | Bash, PowerShell, SSH keys, host aliases, ping tests, and TCP service checks |
| Monitoring | Consolidated availability, operating-system health, uptime, service-port, and reboot reporting |
| Network | Private IPv4 LAN with reserved infrastructure addressing and internal DNS |

## Architecture and Workload Placement

The workload design separates infrastructure services from applications and end-user systems. This makes troubleshooting easier and reduces the impact of maintenance on unrelated services.

| Virtualization layer | Primary workloads |
|---|---|
| Proxmox node 1 | Centralized storage and the primary Docker application platform |
| Proxmox node 2 | Active Directory/DNS, security and monitoring, and a multipurpose infrastructure server |
| Proxmox node 3 | Mattermost, Gramps Web, and a Linux learning workstation |
| Physical Debian host | Jellyfin media services |
| Administrative systems | Windows/WSL primary console and Linux Mint secondary console |

### Managed Entity Summary

| Entity | Primary use | Operational focus |
|---|---|---|
| Proxmox node 1 | Hosts storage and Docker workloads | Host resources, storage, Proxmox services, and guest state |
| Proxmox node 2 | Hosts identity and infrastructure workloads | Host resources, Proxmox services, and guest readiness |
| Proxmox node 3 | Hosts collaboration, genealogy, and learning workloads | Memory pressure, VM state, and local storage |
| Windows domain controller | AD DS, DNS, Kerberos, LDAP, SMB, and remote administration | Directory services, DNS accuracy, authentication, event logs, and diagnostics |
| Security/monitoring server | Platform for current and future security services | Failed units, resources, authentication logs, and security-tool health |
| Central storage server | NFS and Samba file services | Mounted filesystems, free capacity, exports, shares, permissions, and restore readiness |
| Docker application host | Runs infrastructure and business applications | Docker engine, containers, restart counts, logs, certificates, and endpoints |
| Mattermost server | Team collaboration and messaging | Application process, API, authentication, message delivery, and logs |
| Infrastructure utility server | File, identity, monitoring, and guest-management support | SSH, Samba, SSSD, monitoring services, resources, and updates |
| Gramps Web server | Genealogy application and background workers | Containers, application data, authentication, search, media, and backups |
| Jellyfin server | Media library and playback | Container health, media mounts, library scans, playback, and transcoding |
| Linux learning workstation | Technical and theology research environment | Desktop login, applications, updates, resources, and data access |
| Linux admin workstation | Secondary command center | SSH keys, management tools, shared storage, and target connectivity |
| Windows/WSL admin workstation | Primary command center and reporting platform | OpenSSH, WSL2, scripts, PowerShell integration, and remote access |

## Service Portfolio

The environment includes both infrastructure services and user-facing applications.

| Service category | Technologies and uses | Verification approach |
|---|---|---|
| Virtualization | Proxmox VE management and VM lifecycle | Confirm management interface, storage, Proxmox services, and expected guests |
| Identity | Active Directory, Kerberos, and LDAP | Resolve internal names, authenticate a domain user, and run directory diagnostics |
| Name services | Microsoft DNS | Query internal records directly and confirm clients use the correct resolver |
| File services | NFS and Samba | Enumerate exports/shares and complete client-side create, read, and delete tests |
| Reverse proxy and TLS | Nginx Proxy Manager | Confirm routes, certificates, and the administrative interface |
| Documentation | BookStack | Test login, search, and page retrieval |
| Document management | Paperless-ngx | Test login, document search, and retrieval |
| Network management | UniFi Network Application | Confirm the controller loads and managed devices report current state |
| Container administration | Portainer | Confirm login and inspect environments, containers, and health status |
| Performance monitoring | Netdata and Prometheus | Confirm current metrics and healthy collection targets |
| Collaboration | Mattermost | Test API response, login, and message delivery |
| Genealogy | Gramps Web | Test login, tree access, search, media, and background jobs |
| Media | Jellyfin | Test the health endpoint, library access, and client playback |
| Dashboard | Homepage | Confirm the dashboard loads and links reach their intended services |

## Expected Network Services

The monitoring inventory checks standard infrastructure ports and application-specific listeners. The public documentation records service types without exposing the private address map.

| Service | Typical TCP port | Purpose |
|---|---:|---|
| SSH | 22 | Secure remote administration |
| DNS | 53 | Internal name resolution |
| Kerberos | 88 | Domain authentication |
| LDAP | 389 | Directory access |
| SMB/Samba | 445 | Windows-compatible file sharing |
| NFS | 2049 | Linux file sharing |
| RDP | 3389 | Windows remote administration |
| Proxmox HTTPS | 8006 | Virtualization management |
| HTTP/HTTPS | 80/443 | Web applications and reverse proxy services |
| Mattermost | 8065 | Collaboration application |
| Jellyfin | Custom internal port | Media application |
| Application administration | Restricted internal ports | Container, network, proxy, and monitoring consoles |

An open TCP port confirms that a listener accepted a connection. It does not prove that authentication, data access, background processing, or the normal user workflow is functioning.

## ESSM Monitoring and Automation

Custom shell functions provide a consistent operational view from the primary administration workstation.

| Command | Function | Expected healthy result |
|---|---|---|
| `essmstatus` | Tests network availability across the managed inventory | Every expected system reports `ONLINE` |
| `essmhealth` | Collects platform, version, uptime, SSH health, and pending-reboot state | Every system reports `HEALTHY`; reboot state is `NO` |
| `essmports` | Tests registered TCP service listeners | Every expected listener reports `OPEN` |
| `essmhealthstatus` | Produces the combined availability and detailed-health report | Status and health counts match the managed inventory |
| `essmhelp` | Lists available ESSM commands and configured management targets | Current commands and targets are displayed |

The scripts use multiple ping attempts and longer or retried SSH connections to reduce false `OFFLINE` and `NO SSH` results caused by initial address-resolution or neighbor-discovery delays.

### Readiness Model

1. **Reachability:** Confirm the system responds to repeated network probes.
2. **Port availability:** Confirm each expected TCP listener accepts a connection.
3. **Service health:** Verify the required systemd unit, Windows service, VM process, or container is active and stable.
4. **Functional readiness:** Complete the real workload, such as authentication, DNS lookup, file access, message delivery, document retrieval, genealogy search, or media playback.

### Report Interpretation

| Result | Meaning | Required response |
|---|---|---|
| `ONLINE` | The system replied during the network test | Continue with service and application checks |
| `OFFLINE` | No reply was received during the polling window | Retry and test TCP, address resolution, VM state, NIC, and host state |
| `HEALTHY` | The remote health query completed successfully | Review reboot and service-specific status |
| `NO SSH` | SSH connectivity or authentication failed | Test port 22, username, key, host key, SSH service, and firewall |
| `REBOOT YES` | The operating system reports a pending reboot | Schedule a controlled reboot and verify recovery |
| `PORT OPEN` | A TCP listener accepted the connection | Perform the application-level functional test |

## Operational Validation Procedures

### Daily or On-Demand Check

1. Run `essmhealthstatus` and confirm that the network and health counts match the current inventory.
2. Confirm every expected system is `ONLINE` and `HEALTHY`.
3. Confirm every reboot indicator is `NO`.
4. Run `essmports` and confirm every registered service is `OPEN`.
5. Perform functional checks for critical services, including DNS, authentication, storage, collaboration, genealogy, media, and the Docker application platform.
6. Investigate any `OFFLINE`, `NO SSH`, `REBOOT YES`, or `CLOSED` result before making unrelated changes.
7. Record material failures, corrections, address changes, and service changes.

### Incident Triage

1. Repeat the failed check to rule out a transient packet-loss or neighbor-discovery event.
2. Compare network, TCP-port, SSH, process, container, and application results to identify the failing layer.
3. If a virtualization management address fails, test its guest systems before declaring the host unavailable.
4. For SSH failures, verify port 22, the expected username, authorized key, host key, SSH service, and firewall.
5. For an open application port with a failed user workflow, inspect service or container logs and dependencies.
6. Apply the least disruptive correction and rerun both the technical and functional tests.

### Controlled Reboot and Recovery

- Reboot only one dependent system at a time.
- Verify backups, file transfers, and long-running jobs before rebooting storage or application systems.
- Wait for network and SSH access to return.
- Confirm the new uptime and verify that the reboot-required indicator cleared.
- Validate failed-service state, storage mounts, containers, application endpoints, authentication, and the normal user workflow.
- Rerun `essmhealthstatus` and `essmports` after planned maintenance is complete.

Hypervisors are rebooted only during a planned maintenance window after guests are safely stopped or migrated. The domain controller is handled separately so DNS and authentication can be verified immediately after recovery.

## Storage, Security, and Change Control

### Storage and Data Protection

- Monitor free capacity and filesystem errors on primary, backup, and virtualization storage.
- Test NFS and Samba from a client system, not only from the storage server.
- Review backup completion and perform periodic test restores.
- Document retention, encryption, destination, and restore ownership for critical datasets.
- Verify dependent mounts and applications after storage maintenance.

### Access and Security

- Use key-based SSH from approved administrative workstations.
- Restrict management consoles to the trusted LAN or a secured VPN.
- Review authorized keys, privileged group membership, and firewall rules regularly.
- Keep credentials, tokens, private keys, and recovery information outside the public repository.
- Remove unused services and close ports that are not part of the expected-service inventory.
- Review elevated NFS export options and limit them to explicitly trusted clients.

### Maintenance Cadence

| Frequency | Review |
|---|---|
| Daily or on demand | Consolidated health report, critical application functions, and pending reboots |
| Weekly | Expected ports, failed services, disk capacity, container health, backups, and updates |
| Monthly | Restore test, account/key review, certificates, inventory, and documentation reconciliation |
| After every material change | Script syntax, health and port reports, dependencies, service inventory, and change record |

## Verified Historical Baseline

The September 5, 2026 operational baseline recorded:

- 14 managed systems online
- 14 detailed health checks completed successfully
- 28 combined polling operations completed
- All registered service listeners open
- No pending reboot indicators after planned maintenance

This baseline is evidence of a successful test at that time, not a guarantee of current state. Current command output remains the authoritative operational source.

## Skills Demonstrated

- Proxmox VE installation, administration, storage, and VM operations
- Windows Server 2022, Active Directory, DNS, Kerberos, LDAP, SMB, and RDP
- Ubuntu, Debian, and Linux Mint administration
- Docker and Docker Compose deployment and troubleshooting
- NFS and Samba storage administration
- Bash and PowerShell automation
- SSH key management and cross-platform remote administration
- TCP/IP, DNS, port, process, and application-layer troubleshooting
- Monitoring, operational readiness testing, controlled maintenance, recovery validation, runbook development, change control, and security-minded documentation
