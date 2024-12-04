November Creation Updates and Creations

ssh-alert.conf update: Triggers logging and email alerts when an IP is banned.
fail2ban-email.sh: Sends email notifications for each banned IP.
Blacklist file (/etc/fail2ban/blacklist.txt): Stores permanently banned IPs.
blacklist.conf: Defines the blacklist as a Fail2Ban filter.
Fail2Ban jail.local update: Activates and enforces the blacklist.
Updated fail2ban-log.sh: Adds banned IPs to the blacklist for persistent blocking.
