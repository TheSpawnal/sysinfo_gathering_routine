#!/bin/bash

# Color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to colorize output
colorize() {
    while IFS= read -r line; do
        # Check for negative/error indicators (case-insensitive)
        if echo "$line" | grep -iE 'not|failed|error|refused|denied|incomplete|disabled|inactive|down|unavailable|unreachable|no|false|0/|:0 |^0$|dead|stopped|exited' > /dev/null; then
            echo -e "${RED}${line}${NC}"
        # Check for positive/ok indicators
        elif echo "$line" | grep -iE 'ok|active|running|enabled|up|yes|success|complete|available|connected|true|[1-9][0-9]*/' > /dev/null; then
            echo -e "${YELLOW}${line}${NC}"
        else
            echo "$line"
        fi
    done
}

# Function to run command and display output line by line with delay and colors
run_with_delay() {
    local delay=${1:-1}  # Default 1 second delay
    shift
    "$@" | colorize | while IFS= read -r line; do
        echo -e "$line"
        sleep "$delay"
    done
}

echo "=== Hardware Information ==="
run_with_delay 1 lshw

echo -e "\n=== Open Files and Network Connections ==="
run_with_delay 1 lsof -i

echo -e "\n=== Network Configuration ==="
run_with_delay 1 ip a

echo -e "\n=== Routing Table ==="
run_with_delay 1 ip route show

echo -e "\n=== Network Statistics ==="
run_with_delay 1 ss -tulpn

echo -e "\n=== Disk Usage ==="
run_with_delay 1 df -h

echo -e "\n=== Disk I/O Statistics ==="
run_with_delay 1 iostat

echo -e "\n=== Memory Usage ==="
run_with_delay 1 free -h

echo -e "\n=== Memory Details ==="
run_with_delay 1 bash -c "cat /proc/meminfo | head -20"

echo -e "\n=== Process List ==="
run_with_delay 1 ps aux

echo -e "\n=== Top Processes by CPU ==="
run_with_delay 1 bash -c "ps aux --sort=-%cpu | head -10"

echo -e "\n=== Top Processes by Memory ==="
run_with_delay 1 bash -c "ps aux --sort=-%mem | head -10"

# echo -e "\n=== Recent System Logs (last 50 lines) ==="
# run_with_delay 1 journalctl -n 50

echo -e "\n=== Kernel Messages ==="
run_with_delay 1 bash -c "dmesg | tail -50"

echo -e "\n=== PCI Devices ==="
run_with_delay 1 lspci -vv

echo -e "\n=== USB Devices ==="
run_with_delay 1 lsusb -v

echo -e "\n=== System Services ==="
run_with_delay 1 systemctl list-units --type=service --state=running

echo -e "\n=== Failed Services ==="
run_with_delay 1 systemctl --failed

echo -e "\n=== CPU Information ==="
run_with_delay 1 lscpu

echo -e "\n=== System Uptime and Load ==="
run_with_delay 1 uptime

echo -e "\n=== Logged In Users ==="
run_with_delay 1 who

echo -e "\n=== Last Logins ==="
run_with_delay 1 bash -c "last -n 10"

echo -e "\n=== Kernel Version ==="
run_with_delay 1 uname -a

echo -e "\n=== System Information Complete ==="
