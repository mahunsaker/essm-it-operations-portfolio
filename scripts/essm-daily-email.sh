#!/usr/bin/env bash

# Sanitized portfolio example. Configure addresses through environment variables:
#   export ESSM_MAIL_FROM="sender@example.com"
#   export ESSM_MAIL_TO="recipient@example.com,second@example.com"

set -o pipefail

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PATH

ESSM_DIR="${ESSM_DIR:-$HOME/.essm}"
MAIL_FROM="${ESSM_MAIL_FROM:-sender@example.com}"
MAIL_TO_RAW="${ESSM_MAIL_TO:-recipient@example.com}"
MSMTP_ACCOUNT="${ESSM_MSMTP_ACCOUNT:-default}"

IFS=',' read -r -a MAIL_TO <<< "$MAIL_TO_RAW"
for index in "${!MAIL_TO[@]}"; do
    MAIL_TO[$index]="${MAIL_TO[$index]//[[:space:]]/}"
done

REPORT_DIR="$ESSM_DIR/reports"
LOG_DIR="$ESSM_DIR/logs"
mkdir -p "$REPORT_DIR" "$LOG_DIR"

RUN_DATE="$(date '+%Y-%m-%d')"
RUN_TIME="$(date '+%Y-%m-%d_%H-%M-%S')"
GENERATED="$(date '+%Y-%m-%d %I:%M:%S %p %Z')"
REPORT_FILE="$REPORT_DIR/essmhealthstatus-$RUN_TIME.txt"
LOG_FILE="$LOG_DIR/essm-daily-email.log"

exec 9>"$ESSM_DIR/essm-daily-email.lock"
if ! flock -n 9; then
    printf '%s - Another report is already running\n' "$(date '+%F %T %Z')" >> "$LOG_FILE"
    exit 1
fi

source "$ESSM_DIR/essm-status.sh"
source "$ESSM_DIR/essm-health.sh"
source "$ESSM_DIR/essm-healthstatus.sh"

if essmhealthstatus > "$REPORT_FILE" 2>&1; then
    REPORT_EXIT=0
else
    REPORT_EXIT=$?
fi

REPORT_STATUS="OK"
STATUS_COLOR="#198754"
STATUS_BACKGROUND="#e8f5ee"

if [[ $REPORT_EXIT -ne 0 ]] ||
   grep -Eq 'OFFLINE|UNHEALTHY|DEGRADED|[[:space:]]YES[[:space:]]*$' "$REPORT_FILE"; then
    REPORT_STATUS="ATTENTION"
    STATUS_COLOR="#b42318"
    STATUS_BACKGROUND="#fef0ed"
fi

SUBJECT="ESSMHomeLab Daily Health - $REPORT_STATUS - $RUN_DATE"
printf -v TO_HEADER '%s, ' "${MAIL_TO[@]}"
TO_HEADER="${TO_HEADER%, }"

ESCAPED_REPORT="$(
    python3 -c '
import html
import pathlib
import sys

report = pathlib.Path(sys.argv[1]).read_text(encoding="utf-8", errors="replace")
print(html.escape(report))
' "$REPORT_FILE"
)"

BOUNDARY="ESSM-$(date +%s)-$$"

if {
    echo "From: ESSMHomeLab Health <$MAIL_FROM>"
    echo "To: $TO_HEADER"
    echo "Subject: $SUBJECT"
    echo "Date: $(date -R)"
    echo "MIME-Version: 1.0"
    echo "Content-Type: multipart/alternative; boundary=\"$BOUNDARY\""
    echo

    echo "--$BOUNDARY"
    echo "Content-Type: text/plain; charset=UTF-8"
    echo "Content-Transfer-Encoding: 8bit"
    echo
    echo "ESSMHomeLab Daily Health Report"
    echo "Status: $REPORT_STATUS"
    echo "Generated: $GENERATED"
    echo
    cat "$REPORT_FILE"
    echo

    echo "--$BOUNDARY"
    echo "Content-Type: text/html; charset=UTF-8"
    echo "Content-Transfer-Encoding: 8bit"
    echo

    cat <<HTML
<!DOCTYPE html>
<html>
<body style="margin:0;padding:20px;background:#f3f6f8;font-family:Arial,Helvetica,sans-serif;color:#26343d;">
<div style="max-width:1100px;margin:auto;background:#ffffff;border:1px solid #ccd8df;">
  <div style="background:#15324a;color:#ffffff;padding:22px 26px;">
    <div style="font-size:24px;font-weight:bold;">ESSMHomeLab Daily Health</div>
    <div style="margin-top:6px;color:#dce8ef;">Automated Infrastructure Report</div>
  </div>
  <div style="padding:20px 26px;">
    <table style="border-collapse:collapse;width:100%;margin-bottom:22px;">
      <tr><td style="padding:10px;border:1px solid #ccd8df;font-weight:bold;width:140px;">Report status</td><td style="padding:10px;border:1px solid #ccd8df;color:$STATUS_COLOR;background:$STATUS_BACKGROUND;font-weight:bold;">$REPORT_STATUS</td></tr>
      <tr><td style="padding:10px;border:1px solid #ccd8df;font-weight:bold;">Generated</td><td style="padding:10px;border:1px solid #ccd8df;">$GENERATED</td></tr>
      <tr><td style="padding:10px;border:1px solid #ccd8df;font-weight:bold;">Source</td><td style="padding:10px;border:1px solid #ccd8df;">$(hostname)</td></tr>
      <tr><td style="padding:10px;border:1px solid #ccd8df;font-weight:bold;">Saved report</td><td style="padding:10px;border:1px solid #ccd8df;">$REPORT_FILE</td></tr>
    </table>
    <div style="font-size:18px;font-weight:bold;color:#15324a;margin-bottom:10px;">Complete Health and Status Report</div>
    <div style="background:#101820;color:#edf5f7;padding:18px;border-radius:4px;overflow-x:auto;">
<pre style="margin:0;font-family:Consolas,'Courier New',monospace;font-size:12px;line-height:1.4;white-space:pre;">$ESCAPED_REPORT</pre>
    </div>
  </div>
  <div style="padding:12px 26px;background:#edf3f6;color:#5c6b73;font-size:12px;">Generated automatically by ESSMHomeLab.Local</div>
</div>
</body>
</html>
HTML

    echo
    echo "--$BOUNDARY--"
} | msmtp --account="$MSMTP_ACCOUNT" "${MAIL_TO[@]}"; then
    printf '%s - Formatted email sent - Status=%s - Report=%s\n' \
        "$(date '+%F %T %Z')" "$REPORT_STATUS" "$REPORT_FILE" >> "$LOG_FILE"
    exit 0
else
    MAIL_EXIT=$?
    printf '%s - EMAIL FAILED - Code=%s - Report=%s\n' \
        "$(date '+%F %T %Z')" "$MAIL_EXIT" "$REPORT_FILE" >> "$LOG_FILE"
    exit "$MAIL_EXIT"
fi
