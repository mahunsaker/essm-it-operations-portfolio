# Portable System Administrator Dashboard (PowerShell 7)

A **generic, independent prototype** of a read-only Windows administration dashboard. The code is authored as a new example for this portfolio; it is **not copied from any employer system or internal dashboard**.

## Current scope

- PowerShell 7 and Windows desktop with built-in Windows Forms and CIM cmdlets.
- One local or explicitly entered remote target, never automatic subnet scanning.
- Double-click command selection or click **Run Selected**.
- **AdminHelp** displays the allowlisted commands in the main output area; no second PowerShell window.
- OS/build/system details, services, network configuration, and one ICMP check.
- Read-only target operations, color-coded results, clear, and local text export.
- On-premises/offline execution; no GitHub, cloud, package downloads, or third-party runtime dependencies.

**Status:** reference prototype. No Windows GUI or network validation has been performed in this development environment. Test on an authorized Windows 11 workstation before any operational use. This is not a tested replacement for an existing production dashboard.

## Layout

```text
windows-admin/sysadmin-dashboard/
├── src/
│   ├── Start-Dashboard.ps1
│   └── Modules/
│       └── Dashboard.Commands.psm1
├── tests/
│   └── Smoke.Tests.ps1
├── INSTALL.md
├── SECURITY.md
└── README.md
```

## Getting started

See [offline installation and rollback](INSTALL.md). For safe command names and target behavior, see [security notes](SECURITY.md).

## Design decisions

1. **Modules first.** Keep target validation, command catalog, and CIM logic separate from Windows Forms.
2. **No freeform remote execution.** UI commands map to a fixed, audited allowlist.
3. **Explicit target selection.** Hostname, FQDN, or IP must be supplied by the operator. Blank means local computer.
4. **WinRM/CIM for remote reads.** Use current Windows credentials; remote CIM requires authorized permissions, network rules, and configured WinRM.
5. **Portable runtime.** PowerShell 7 must already be installed; copy the project directory to an approved local path.
6. **Backup and rollback.** Preserve previous releases and restore the old directory if the new version fails.
7. **Public by design.** No organizational identifiers, internal network details, credentials, customer information, or unreviewed operational code.

## Next milestones

- Windows 11 GUI smoke test and error handling.
- Optional bounded remote-operation timeout and responsive UI worker pattern.
- More read-only categories (event logs, disk usage, uptime) with explicit command registration.
- Print/export formatting, visual polish, structured audit logging, and signed offline release packaging.
- Adapter layer to integrate independently developed modules with an existing dashboard only after source review and approval.

[Return to Windows administration index](../README.md).
