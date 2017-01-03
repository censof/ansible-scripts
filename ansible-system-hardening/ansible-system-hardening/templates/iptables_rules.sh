#!/bin/bash 
# Flush all current rules from iptables
iptables -F

# SSH (4622) - Don't lock ourselves out + Limit of 3 attempts
# per minute
iptables -A INPUT -p tcp --dport 22 --syn -m limit --limit 1/m --limit-burst 3 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 --syn -j DROP

# Set default policies for INPUT, FORWARD and OUTPUT chains
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Set access for localhost
 iptables -A INPUT -i lo -j ACCEPT

# Accept packets belonging to established and
# related connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Make sure new incoming tcp connections are SYN
# packets; otherwise we need to drop them
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP

# Drop packets with incoming fragments
iptables -A INPUT -f -j DROP

# Drop incoming malformed XMAS packets
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP

# Drop all NULL packets
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP

# ICMP (PING) - Ping flood protection 1 per second

iptables -A INPUT -p icmp -m limit --limit 5/s --limit-burst 5 -j ACCEPT
iptables -A INPUT -p icmp -j DROP

# Allow MySQL (port 3306) access
# from other servers
# Drop all NULL packets
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT

# Save settings
/sbin/service iptables save

# List rules
iptables -L -v


