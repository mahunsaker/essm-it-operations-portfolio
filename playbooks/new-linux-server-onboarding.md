# New Linux Server Onboarding

## Purpose

Standardize the introduction of a new Ubuntu or Debian server into the ESSM HomeLab.

## Procedure

1. Record the system purpose, owner, operating system, and assigned resources.
2. Set a unique hostname.
3. Apply operating-system updates.
4. Configure the approved network settings.
5. Create or verify the administrative account.
6. Install and enable OpenSSH Server.
7. Copy the authorized public SSH key.
8. Test key-based access before disabling or restricting other access methods.
9. Create the required internal DNS record.
10. Configure only the services and firewall ports required for the assigned role.
11. Enable automatic security-update or maintenance procedures as appropriate.
12. Add the system to ESSM health and port checks.
13. Test connectivity, DNS resolution, service access, storage mounts, and reboot recovery.
14. Document the final configuration in the private inventory.

## Example Validation

```bash
hostnamectl
ip -brief address
systemctl --failed
ss -lntup
df -hT
free -h
```

From the administration workstation:

```bash
ssh -o BatchMode=yes -o ConnectTimeout=5 <host-alias> hostname
```

## Security Notes

Never commit passwords, private SSH keys, private inventory files, or authentication tokens to a public repository.
