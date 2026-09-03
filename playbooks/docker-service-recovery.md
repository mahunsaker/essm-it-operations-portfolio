# Docker Service Recovery

## Purpose

Use this procedure when a Docker-hosted application is unavailable or unhealthy.

## Procedure

### 1. Confirm host connectivity

```bash
ping -c 4 <docker-host>
ssh <docker-host>
```

### 2. Review container state

```bash
docker ps -a
docker compose ps
```

### 3. Review recent logs

From the application's Compose directory:

```bash
docker compose logs --tail=100
docker compose logs --tail=100 <service-name>
```

### 4. Validate host resources

```bash
free -h
df -hT
docker system df
```

### 5. Test the application locally

```bash
curl -I --max-time 15 http://localhost:<published-port>
```

### 6. Apply the least disruptive recovery

If the configuration and data paths are verified:

```bash
docker compose restart <service-name>
docker compose ps
```

Use a full stack restart only when required:

```bash
docker compose down
docker compose up -d
```

## Validation

Confirm the container is running, logs show no repeating errors, the local HTTP test succeeds, and the application is reachable from a client.

## Safety Notes

Do not remove volumes, run broad prune commands, or recreate persistent data until backups and mount paths have been verified.
