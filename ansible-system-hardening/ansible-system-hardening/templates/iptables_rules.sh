#!/bin/bash 
# Flush all current rules from iptables
iptables -F

# SSH (22) - Don't lock ourselves out + Limit of 3 attempts
# per minute
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

#Allow nginx and uwsgi
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 8001 -j ACCEPT 

# Set default policies for INPUT, FORWARD and OUTPUT chains
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Set access for localhost
 iptables -A INPUT -i lo -j ACCEPT

# Accept packets belonging to established and
# related connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow postgresql (port 5432) access
# from other servers
# Drop all NULL packets
iptables -A INPUT -p tcp --dport 5432 -j ACCEPT

# Save settings
/sbin/service iptables save

# List rules
iptables -L -v


