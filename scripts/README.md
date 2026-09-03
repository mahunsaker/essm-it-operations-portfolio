# ESSM Administration and Monitoring Scripts

This directory documents Bash and PowerShell tools developed for the ESSM HomeLab.

## Available Commands

| Command | Purpose |
|---|---|
| `essmstatus` | Performs a rapid availability test against defined infrastructure systems |
| `essmhealth` | Collects host role, platform, uptime, connectivity, and reboot status |
| `essmports` | Tests essential application and infrastructure service ports |
| `essmhelp` | Displays administration commands and SSH targets |
| `essmupdate` | Supports standardized maintenance operations |

## Design Goals

- Provide a consistent view of the environment
- Reduce repetitive manual checks
- Identify unreachable hosts and unavailable services
- Support faster incident triage
- Produce readable output for documentation
- Work from Linux Mint and WSL administration stations

## Security

Only sanitized script versions will be published. Passwords, private keys, authentication tokens, exact private inventory, and other secrets are excluded. SSH access uses locally stored keys that are never committed to this repository.

## Planned Additions

The working scripts will be reviewed, sanitized, documented, and added individually. Configuration values will be separated from reusable script logic where practical.
