#!/bin/bash

echo "=== Hardware Information ==="
lshw

echo -e "\n=== Open Files and Network Connections ==="
lsof -i

echo -e "\n=== Network Configuration ==="
ip a

echo -e "\n=== Routing Table ==="
ip route show

echo -e "\n=== Network Statistics ==="
ss -tulpn

echo -e "\n=== Disk Usage ==="
df -h

echo -e "\n=== Disk I/O Statistics ==="
iostat

echo -e "\n=== Memory Usage ==="
free -h

echo -e "\n=== Memory Details ==="
cat /proc/meminfo | head -20

echo -e "\n=== Process List ==="
ps aux

echo -e "\n=== Top Processes by CPU ==="
ps aux --sort=-%cpu | head -10

echo -e "\n=== Top Processes by Memory ==="
ps aux --sort=-%mem | head -10

echo -e "\n=== Recent System Logs (last 50 lines) ==="
journalctl -n 50

echo -e "\n=== Kernel Messages ==="
dmesg | tail -50

echo -e "\n=== PCI Devices ==="
lspci -vv

echo -e "\n=== USB Devices ==="
lsusb -v

echo -e "\n=== System Services ==="
systemctl list-units --type=service --state=running

echo -e "\n=== Failed Services ==="
systemctl --failed

echo -e "\n=== CPU Information ==="
lscpu

echo -e "\n=== System Uptime and Load ==="
uptime

echo -e "\n=== Logged In Users ==="
who

echo -e "\n=== Last Logins ==="
last -n 10

echo -e "\n=== Kernel Version ==="
uname -a

echo -e "\n=== System Information Complete ==="
