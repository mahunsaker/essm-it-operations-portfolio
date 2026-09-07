# ESSM Administration and Monitoring Scripts

This directory documents Bash and PowerShell tools developed for the ESSM HomeLab.

## Available Commands

| Command | Purpose |
|---|---|
| `essmstatus` | Performs a rapid availability test against defined infrastructure systems |
| `essmhealth` | Collects host role, platform, uptime, connectivity, and reboot status |
| `essmhealthstatus` | Combines network availability and detailed system health in one report |
| `essmports` | Tests essential application and infrastructure service ports |
| `essmhelp` | Displays administration commands and SSH targets |
| `essmupdate` | Supports standardized maintenance operations |

## Published Automation Examples

| Script | Purpose |
|---|---|
| [`essm-daily-email.sh`](essm-daily-email.sh) | Runs the consolidated report, saves it locally, evaluates attention conditions, and emails a formatted HTML copy |

The scheduling and security design is documented in the [Automated ESSM Health Reporting](../docs/automated-health-reporting.md) case study.

## Design Goals

- Provide a consistent view of the environment
- Reduce repetitive manual checks
- Identify unreachable hosts and unavailable services
- Highlight pending reboots and unhealthy conditions
- Support faster incident triage
- Produce readable output for documentation and email
- Work from Linux Mint and WSL administration stations

## Security

Only sanitized script versions are published. Passwords, private keys, authentication tokens, exact private inventory, live email addresses, and generated reports are excluded. SSH access uses locally stored keys that are never committed to this repository. SMTP credentials are maintained outside the repository in permission-restricted local files.
