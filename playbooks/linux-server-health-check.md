# Linux Server Health Check

## Purpose

Use this procedure to assess the health of an Ubuntu or Debian server before maintenance or during incident triage.

## Procedure

### 1. Confirm identity and uptime

```bash
hostnamectl
uptime
```

### 2. Check CPU, memory, and disk utilization

```bash
free -h
df -hT
top -b -n 1 | head -20
```

### 3. Check failed services

```bash
systemctl --failed
systemctl status <service-name>
```

### 4. Review recent high-priority events

```bash
journalctl -p warning -b --no-pager | tail -100
```

### 5. Check network configuration and listening ports

```bash
ip -brief address
ip route
ss -lntup
```

### 6. Review pending updates and reboot status

```bash
apt list --upgradable
test -f /var/run/reboot-required && echo "Reboot required" || echo "No reboot required"
```

## Validation

Record abnormal resource use, failed services, disk volumes above established thresholds, network problems, pending security updates, and reboot requirements.

## Safety Notes

Do not restart services, remove packages, delete logs, or reboot a production system until the impact and recovery plan are understood.
