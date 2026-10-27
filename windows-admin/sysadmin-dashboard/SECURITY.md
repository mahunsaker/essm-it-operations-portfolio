# Safe development and information-handling rules

This project is a generic sample built independently of any internal organization-specific code.

## Always exclude

- Organization, customer, or site names and identifiers.
- Real internal hostnames, private IP ranges, domain names, usernames, email addresses, screenshots and inventories.
- Credentials, access tokens, certificates, keys, internal network diagrams, production logs, and security configurations.
- Proprietary application logic or script material copied from restricted systems.

Use synthetic documentation targets such as `host01.example.test` and documentation IP address `192.0.2.10`.

## Execution boundary

- Remote operations are limited to allowlisted read-only CIM queries or one ICMP check.
- The target is operator-selected; no auto-discovery, subnet sweeping, or implicit domain inventory.
- Use current Windows identity and configured WinRM/WSMan security. No saved credentials, secret prompts, privileged elevation, remote script invocation, or shell command injection.
- Export TXT writes only to a local destination explicitly selected by the user.
- Source control is optional for development; deployed runtime is entirely offline.

## Review before publishing

Search every added/changed file for real identities and private assets. Inspect file metadata and screenshots. Publishing to a public GitHub repository is irreversible for practical confidentiality purposes, even if a later commit deletes material.

This prototype is not a security boundary and has not yet undergone enterprise hardening or authorized-network verification.
