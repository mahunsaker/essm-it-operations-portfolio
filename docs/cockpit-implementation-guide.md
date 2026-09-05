# Cockpit Browser-Based Linux Administration

## Project overview

This project defines a controlled deployment of Cockpit across selected Linux systems in a multi-platform homelab. Cockpit provides browser-based access to system health, logs, storage, networking, accounts, services, updates, and an interactive terminal.

The design emphasizes selective deployment, automation, validation, security, and rollback rather than installing another administrative interface on every machine.

## Objectives

- Provide convenient browser-based Linux administration
- Standardize deployment through Ansible
- Restrict administrative access to trusted management systems
- Integrate Cockpit readiness into existing health and service-port reports
- Document validation and rollback procedures
- Avoid duplicating purpose-built management platforms

## System-selection strategy

| System category | Decision | Reason |
|---|---|---|
| General Linux server | Deploy | Useful system, service, log, storage, and update administration |
| Storage server | Deploy | Strong visibility into filesystems, capacity, and storage services |
| Docker host | Deploy | Useful host-level monitoring and troubleshooting |
| Application server | Deploy | Supports service, resource, and log investigation |
| Security server | Controlled deployment | Valuable visibility, but requires stricter access restrictions |
| Proxmox host | Exclude | Proxmox already supplies a purpose-built management interface |
| Windows Server | Exclude | Managed with Windows-native tools and PowerShell |
| Desktop learning workstation | Defer | Limited server-management benefit |
| Application container | Exclude | Management belongs on the container host |

## Architecture

- A private Git repository stores the operational Ansible inventory and deployment code.
- Administrative workstations act as development and emergency control nodes.
- A persistent automation controller executes scheduled and approved playbooks.
- A browser-based automation interface is planned for controlled task execution.
- Cockpit remains accessible only from the trusted management network.
- Public documentation contains sanitized examples rather than live infrastructure details.

## Planned Ansible structure

```text
playbooks/deploy-cockpit.yml
roles/cockpit/
├── defaults/main.yml
├── handlers/main.yml
├── tasks/main.yml
└── templates/cockpit.conf.j2
docs/cockpit-implementation-guide.md
```

The role is designed to:

- Install Cockpit from supported distribution repositories
- Enable the socket-activated service
- Verify port 9090 and the HTTPS endpoint
- Install metrics-history support where available
- Preserve unrelated system configuration
- Support repeatable deployment and removal
- Remain idempotent

## Phased deployment

### 1. Pilot

Deploy first to a low-risk Linux administration and testing server.

Validation includes:

- User login and administrative elevation
- CPU and memory metrics
- Logs
- Services
- Storage
- Browser terminal
- Software-update visibility
- Verification that unrelated services remain unaffected
- A second Ansible run with no unexpected changes

### 2. Core servers

After the pilot succeeds, deploy to selected storage, Docker, application, genealogy, and media-service hosts.

### 3. Security server

Deploy only after confirming that port 9090 is restricted to trusted administrative sources.

### 4. TLS

Use self-signed certificates only during controlled internal testing. The long-term design uses a certificate trusted by the internal environment.

## Monitoring integration

Cockpit readiness will be incorporated into the existing ESSM operational tooling:

- TCP 9090 checks in the service-port report
- Cockpit socket status in the Daily Operations Report
- Links in the internal service dashboard
- Package-version and validation-date tracking
- Alerts when the socket or HTTPS endpoint fails

## Security controls

- No direct public-internet exposure
- Access limited to trusted administrative systems
- Normal user accounts with controlled privilege elevation
- Operational inventory and secrets kept in a private repository
- No passwords, keys, tokens, or unencrypted secrets in Git
- Screenshots and reports sanitized before publication
- TLS certificate deployment after internal trust design is validated

## Rollback strategy

Cockpit can be disabled without removing packages:

```bash
sudo systemctl disable --now cockpit.socket
```

The Ansible role also provides a repeatable removal state. Every rollout phase records targets, results, exceptions, corrective actions, and rollback validation.

## Skills demonstrated

- Linux systems administration
- Browser-based server management
- Ansible configuration management
- Infrastructure as code
- Service validation
- Access-control planning
- TLS planning
- Change and rollback management
- Operational documentation
- Security-conscious portfolio publishing

## Project status

- Initial WSL deployment: operational
- Ansible deployment role: planned
- Linux pilot: pending
- Core rollout: pending
- Security-server rollout: pending
- Trusted TLS: pending
- Central monitoring integration: pending
