# Layered Infrastructure Automation Program

## Project summary

I designed a layered, read-only operations automation program for a multi-platform homelab spanning virtualization hosts, Windows Server, Linux systems, shared storage, and containerized applications.

The objective was to move from a single daily snapshot to recurring operational evidence with controlled alerting and management reporting. The production daily health email remains the baseline. Ten additional release-candidate stages were then built in a deliberate order.

## Automation layers

| Order | Capability | Operational value |
|---:|---|---|
| 1 | Backup verification | Verifies repository availability, freshness, capacity, artifact size/count, and recent virtualization backup-task results |
| 2 | Service monitoring | Records recurring DNS, TCP, and HTTP endpoint state |
| 3 | Stateful alerting | Requires consecutive failures, suppresses duplicate alerts, and reports recovery with incident duration |
| 4 | Storage health | Checks mounts, access, filesystem mode, and graduated capacity thresholds |
| 5 | Container status | Checks required containers, running state, healthchecks, and restart evidence |
| 6 | Patch compliance | Reports available updates, patch age, and pending-reboot state across Linux and Windows |
| 7 | Certificate status | Reports TLS connection problems and certificate-expiry thresholds |
| 8 | Virtualization health | Checks quorum, node state, storage, guests, and recent failed tasks |
| 9 | Directory and DNS health | Checks core services, directory shares, diagnostics, replication summary, and time source |
| 10 | Monthly operations report | Aggregates service availability, incidents, and retained operational-report results |

## Design controls

- Detection is automated; remediation remains operator-controlled.
- Checks use bounded timeouts and read-only commands.
- Alerting requires two consecutive failures before declaring a service down.
- Unchanged incidents are suppressed, with periodic reminders and a single recovery notification.
- Installers preserve the prior deployed files before replacement.
- Operational configuration, credentials, network addresses, and generated reports remain private.
- Each stage has a deterministic fixture test and an explicit rollback procedure.
- Production advancement occurs one stage at a time after a manual live run, email review, scheduled execution, and rollback validation.

## Scheduling model

Frequent state and container checks run every 15 minutes. Specialized platform checks are staggered through the morning to avoid simultaneous load. Patch compliance runs weekly, certificate checks run daily, and the management summary runs on the first day of each month.

Windows Task Scheduler starts the WSL-based commands, supports missed-run recovery and wake-to-run behavior, and enforces execution limits. Bash and Python perform the checks; PowerShell handles Windows-side scheduling and read-only Windows health collection.

## Validation

A single regression command validates every Bash file, compiles every Python program, parses all production JSON templates, and runs fixtures for every automation plus multipart email formatting.

The completed fixture suite passed before repository release. Live infrastructure validation remains a separate stage gate so test success is never confused with production acceptance.

## Skills demonstrated

- Bash, Python, and PowerShell automation
- Windows Task Scheduler and WSL integration
- Stateful monitoring and alert lifecycle design
- Linux, Windows, container, storage, TLS, directory-service, and virtualization health checks
- Backup verification and restore-evidence planning
- Safe deployment, rollback, testing, and operational documentation
- Security-conscious separation of private infrastructure code and public portfolio material

Exact hostnames, addresses, accounts, credentials, private configuration, and operational findings are intentionally excluded.
