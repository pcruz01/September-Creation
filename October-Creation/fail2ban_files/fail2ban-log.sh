#!/bin/bash
current_time=$(perl -e 'print scalar localtime')
echo "Alert: IP $1 $2 at $current_time" >> /home/{user}/ssh_alerts.log

echo $1 >> /etc/fail2ban/blacklist.txt
