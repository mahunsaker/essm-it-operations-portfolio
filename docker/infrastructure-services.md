# Docker Infrastructure Services

## Project Summary

A dedicated Ubuntu Docker host runs several services used for administration, documentation, monitoring, and document management.

## Deployed Services

| Service | Function |
|---|---|
| Homepage | Central service dashboard |
| Portainer | Container administration |
| Netdata | System and service monitoring |
| Nginx Proxy Manager | Web proxy administration |
| BookStack | Technical documentation |
| Paperless-ngx | Document management |
| UniFi Network Application | Network-device administration |

## Operational Responsibilities

- Deploy services with Docker and Docker Compose
- Map application ports and persistent storage
- Verify container status and application reachability
- Review container and service logs
- Apply controlled restarts
- Document recovery procedures
- Protect persistent volumes and configuration data

## Standard Health Checks

```bash
docker ps
docker compose ps
docker compose logs --tail=100
docker system df
curl -I --max-time 15 http://localhost:<published-port>
```

## Skills Demonstrated

Docker, Docker Compose, Linux administration, persistent storage, port mapping, application monitoring, log analysis, and service recovery.
