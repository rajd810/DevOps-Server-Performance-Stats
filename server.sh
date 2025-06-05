#!/bin/bash

echo "Developing"

# CPU Usage
echo -e "\n--- Total CPU Usage ---"
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d "%" -f1)
CPU_USAGE=$(echo "scale=2; 100 - $CPU_IDLE" | bc)
echo "CPU Usage: $CPU_USAGE%"

# Memory Usage
echo -e "\n--- Memory Usage ---"
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_USAGE_PCT=$(echo "scale=2; $MEM_USED * 100 / $MEM_TOTAL" | bc)
echo "Total Memory: ${MEM_TOTAL}MB"
echo "Used Memory : ${MEM_USED}MB"
echo "Free Memory : ${MEM_FREE}MB"
echo "Memory Usage: $MEM_USAGE_PCT%"

# Disk Usage
echo -e "\n--- Disk Usage ---"
df -h --total | awk '/^total/ {print "Total Disk: " $2 "\nUsed Disk : " $3 "\nFree Disk : " $4 "\nDisk Usage: " $5}'

# Top 5 Processes by CPU
echo -e "\n--- Top 5 Processes by CPU Usage ---"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 Processes by Memory
echo -e "\n--- Top 5 Processes by Memory Usage ---"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6




