# Mattermost Mobile Connectivity Investigation

## Incident Summary

A self-hosted Mattermost server was accessible from an Android device, but the mobile application displayed a server-configuration warning related to notifications.

## Investigation

The application was tested through its private laboratory address and internal DNS name. Server-side outbound HTTP connectivity and the Linux firewall state were also checked.

```bash
curl -I --max-time 10 http://example.com
sudo ufw status verbose
```

## Findings

- The Mattermost web service was reachable.
- The Android client could authenticate successfully.
- The server had outbound network connectivity.
- The warning was not caused by a general outbound-network failure.
- Mobile push notification configuration is separate from normal application access and message delivery.

## Outcome

Local authentication and messaging were confirmed operational. Mobile push-notification configuration was recorded as a separate improvement item.

## Lessons Learned

- Application access and push notifications are separate service functions.
- Successful authentication confirms more than basic network connectivity.
- Application warnings should be investigated at the application layer after connectivity is verified.
- Internal DNS names are preferable to memorized addresses for long-term administration.

## Skills Demonstrated

Application-support troubleshooting, DNS management, Linux connectivity testing, mobile-client testing, and service-layer analysis.
