September Creation

Purpose:

This firewall rule is designed to limit brute-force SSH login attempts by restricting the rate of new connection requests to port 22 (SSH). By monitoring connection attempts from a specific IP address, it drops subsequent requests if multiple failed login attempts are made within a short period of time. This enhances the security of the server by preventing repeated attempts to guess SSH credentials.
