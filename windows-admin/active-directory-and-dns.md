# Active Directory and DNS Administration

## Project Summary

Windows Server 2022 provides Active Directory Domain Services and internal DNS for the ESSM laboratory environment.

## Work Performed

- Installed and administered Active Directory Domain Services
- Maintained internal forward-lookup records
- Verified name resolution from Windows and Linux clients
- Supported domain accounts and authentication
- Investigated DNS-related service-access problems
- Validated essential directory-service ports
- Documented configuration and troubleshooting steps

## Validation Examples

Windows PowerShell:

```powershell
Resolve-DnsName <internal-hostname>
Test-NetConnection <internal-hostname> -Port 53
Get-Service DNS
Get-Service NTDS
```

Linux:

```bash
dig <internal-hostname>
getent hosts <internal-hostname>
nc -zv <domain-controller> 53
```

## Troubleshooting Method

1. Confirm client IP configuration.
2. Verify that the approved internal DNS server is assigned.
3. Test the hostname and fully qualified domain name.
4. Query the DNS server directly.
5. Confirm required services are running.
6. Test the relevant TCP ports.
7. Correct the record or client configuration.
8. Repeat the original test and document the outcome.

## Skills Demonstrated

Windows Server, Active Directory, DNS, PowerShell, TCP/IP troubleshooting, Linux interoperability, and operational documentation.
