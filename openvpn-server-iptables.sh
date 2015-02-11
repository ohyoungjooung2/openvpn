#!/usr/bin/env bash
# This is for openvpn server. Just forwarding from client to outside.

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -s openvpn.client.ip -p udp -m udp --dport 1800 -j ACCEPT
iptables -A FORWARD -s openvpn.client.ip -i eth0 -j ACCEPT
