# Mattermost Application Operations

## Project Summary

Mattermost was deployed on a dedicated Ubuntu application server to provide a self-hosted collaboration platform.

## Work Performed

- Deployed and started the application services
- Verified web access on the internal network
- Created an internal DNS record for name-based access
- Tested Android client authentication
- Confirmed server-side outbound connectivity
- Distinguished normal messaging from mobile push-notification configuration
- Documented the investigation and remaining improvement item

## Health Validation

```bash
docker compose ps
docker compose logs --tail=100
curl -I --max-time 15 http://localhost:<published-port>
ss -lntp
```

## Support Lessons

Application login, message delivery, DNS resolution, outbound network access, and mobile push notifications are separate layers. Each must be tested independently before identifying the cause of a client warning.

## Skills Demonstrated

Ubuntu Server, Docker Compose, DNS, mobile-client support, application troubleshooting, network validation, and technical documentation.
