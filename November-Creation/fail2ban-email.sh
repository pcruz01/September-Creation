#!/bin/bash
IP=$1
SUBJECT="Fail2Ban Alert: SSH Attempt Blocked"
EMAIL="your-email@example.com"
BODY="The IP $IP has been banned for excessive SSH attempts."

echo -e "Subject: $SUBJECT\n\n$BODY" | /usr/sbin/sendmail $EMAIL
