September Creation

Purpose:

    This firewall rule is designed to limit brute-force SSH login attempts by restricting the rate of new connection requests to port 22 (SSH). By monitoring connection attempts from a specific IP address, it drops
    subsequent requests if multiple failed login attempts are made within a short period of time. This enhances the security of the server by preventing repeated attempts to guess SSH credentials.

Application:

    These rules are particularly useful for preventing brute-force attacks on SSH, where an attacker may try to guess the username and password by making repeated login attempts.
    By using these rules, the server will allow a maximum of 3 new connection attempts within a 60-second period. On the 4th attempt, the connection is dropped, temporarily blocking the attacker.

Proof of value:

    EXAMPLE of running: (sudo iptables -L INPUT -v -n --line-numbers)
    pkts bytes target  prot opt in   out   source             destination
    2342  148K  DROP   tcp  --  *    *     0.0.0.0/0          0.0.0.0/0    tcp dpt:22 state NEW recent: UPDATE seconds: 60 hitcount: 4

    EXAMPLE of log entries:
    (Before rule implementation)
    Sep 29 12:33:11 server sshd[1123]: Failed password for invalid user admin from 192.168.1.100 port 52234 ssh2
    Sep 29 12:33:15 server sshd[1123]: Failed password for invalid user admin from 192.168.1.100 port 52234 ssh2
    Sep 29 12:33:18 server sshd[1123]: Failed password for invalid user admin from 192.168.1.100 port 52234 ssh2

    (After rule implementation)
    Sep 30 14:10:32 server kernel: [ 3456.89123] IN=eth0 OUT= MAC=... SRC=192.168.1.100 DST=192.168.1.50 LEN=60 TOS=0x00 PREC=0x00 TTL=50 ID=54321 DF PROTO=TCP SPT=52234 DPT=22 WINDOW=65535 RES=0x00 SYN URGP=0 
    Sep 30 14:10:33 server sshd[1123]: Failed password for invalid user admin from 192.168.1.100 port 52234 ssh2
    Sep 30 14:10:36 server kernel: [ 3456.89467] IN=eth0 OUT= MAC=... SRC=192.168.1.100 DST=192.168.1.50 LEN=60 TOS=0x00 PREC=0x00 TTL=50 ID=54321 DF PROTO=TCP SPT=52234 DPT=22 WINDOW=65535 RES=0x00 SYN URGP=0 
    Sep 30 14:10:37 server iptables: IN=eth0 OUT= MAC=... SRC=192.168.1.100 DST=192.168.1.50 DROPPED: SSH brute-force protection triggered

    You can see from this example how quickly these failed attemption connections can fill up the logs. However, with the rule being implemented, you can now see what exactly is happening and can now record and query to see
    how much this is happening. This makes it easier to monitor and keep an eye on certain IP addresses, time of attacks, frequency of attacks, etc.

    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


    SSH brute-force attacks are one of the most common attacks used by malicious persons used to gain unauthorized access to servers. By implementing this rate limiting, this provides an extra layer of protection against
    those malicious parties and greatly slows down the threat. Time is one of the greatest things that allows for more time to respond to an incident and greatly frustrate an attacker.
    1. This limits the attack surface that can come from a single IP address
    2. This is a time and resource drain for attackers, by forcing the attacker to use more resources
    3. This is something that reacts in real time blocking connection attempts that break past the threshold

    Implementing this is minimal overhead by simply adding a few rules to the firewall, allowing normal operations to continue as normal. This still allows for genuine users to still have a buffer of reasonable amount of
    errors when attempting legitimate work. 

    Before implementation, this allows servers to be bombarded by automated tools trying thousands of different usernames and passwords in a relatively short period of time. This is something that also clogs up log files
    and consume server resources.

    This configuration ultimately provides a critical layer of security on any server running SSH. It greatly reduces the risk and possibility for brute force attacks. This is something that can also be easily fine tuned to
    match the IT group's needs. This combined with several other practices can ensure protection against this type of attack.
