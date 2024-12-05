#!/bin/bash
current_time=$(perl -e 'print scalar localtime')
# November addition
geoip=$(geolookup $1 | awk -F ': ' '{print $2}')
echo "Alert: IP $1 $geoip $2 at $current_time" >> /home/{user}/ssh_alerts.log
