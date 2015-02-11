iptables -F 
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -s 192.168.200.102/32 -d 192.168.200.122/32 -j ACCEPT
iptables -A INPUT -p udp -m udp --sport 53 -j ACCEPT
iptables -A OUTPUT -o eth0 -p udp -m udp --sport 1024:65535 --dport 1800 -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -s 192.168.200.122/32 -d 192.168.200.102/32 -j ACCEPT
iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT
#web
iptables -A OUTPUT -o eth0 -p tcp  --sport 1024:65535 --dport http  -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp  --sport 80 --dport 1024:65535 -m state --state ESTABLISHED -j ACCEPT

#https
iptables -A OUTPUT -o eth0 -p tcp  --sport 1024:65535 --dport https  -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp  --sport 443 --dport 1024:65535 -m state --state ESTABLISHED -j ACCEPT

#transmission for downloading linux iso etc.

iptables -A OUTPUT -o eth0 -p tcp --sport 51413 --dport 1024:65535  -j ACCEPT  
iptables -A INPUT -i eth0 -p tcp  --sport 1024:65535 --dport 51413 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p udp --sport 51413 --dport 1024:65535  -j ACCEPT  
iptables -A INPUT -i eth0 -p udp --sport 1024:65535 --dport 51413 -m state --state RELATED,ESTABLISHED -j ACCEPT
