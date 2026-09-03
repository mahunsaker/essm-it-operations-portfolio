# Linux SSH Connection Refused

## Incident Summary

A Linux system responded to network pings but rejected SSH connections on TCP port 22.

## Reported Symptom

An SSH connection returned:

```text
ssh: connect to host <server-address> port 22: Connection refused
```

The destination continued to respond to ping requests.

## Assessment

Successful ping responses confirmed that the system was powered on and basic IP connectivity was working. The `Connection refused` response indicated that the host was reachable, but no service was accepting the SSH connection.

## Diagnostic Process

```bash
ping <server-address>
nc -zv <server-address> 22
sudo systemctl status ssh
sudo ss -lntp | grep ':22'
sudo ufw status verbose
```

The investigation considered OpenSSH Server installation, service status, listening ports, firewall configuration, and the accuracy of the destination address.

## Root Cause

The SSH server was not installed, enabled, or actively listening on TCP port 22.

## Resolution

On the destination Linux system:

```bash
sudo apt update
sudo apt install -y openssh-server
sudo systemctl enable --now ssh
sudo ss -lntp | grep ':22'
```

## Validation

The correction was validated by confirming that the SSH service was active, TCP port 22 was listening, and an authorized remote login succeeded.

## Lessons Learned

- Ping validates basic reachability, not application availability.
- A refused connection differs from a timeout.
- Troubleshooting should progress from connectivity to port availability and then service status.
- A remote service generally cannot be enabled remotely unless another management path already exists.

## Skills Demonstrated

TCP/IP troubleshooting, Linux service management, SSH administration, port testing, root-cause analysis, and technical documentation.
