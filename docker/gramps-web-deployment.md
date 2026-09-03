# Gramps Web Deployment

## Project Summary

Gramps Web was deployed as a containerized genealogy application on a dedicated virtual machine.

## Implementation Highlights

- Provisioned a virtual machine on Proxmox VE
- Installed the Linux and Docker prerequisites
- Deployed Gramps Web and its background worker with Docker Compose
- Published the application through an internal web port
- Verified container startup and local HTTP response
- Documented service status and recovery commands

## Validation Examples

```bash
docker compose ps
docker compose logs --tail=100
curl -I --max-time 15 http://localhost/
```

A successful validation confirms that the application and background worker are running and that the local web endpoint responds.

## Operational Considerations

- Persistent application data must be backed up.
- Container images and application configuration should be documented.
- Updates should be tested and followed by health validation.
- Credentials and personal genealogy data must not be committed publicly.

## Skills Demonstrated

Proxmox VE, virtual-machine provisioning, Linux, Docker Compose, web-service testing, background workers, persistence, and documentation.
