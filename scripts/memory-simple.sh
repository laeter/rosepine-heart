#!/bin/bash
# Simple memory usage display

# Read memory info from /proc/meminfo
TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
AVAILABLE=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

# Calculate used memory (Total - Available) to match btop
USED=$((TOTAL - AVAILABLE))

# Convert to GB
USED_GB=$(echo "scale=1; $USED / 1024 / 1024" | bc)
TOTAL_GB=$(echo "scale=0; $TOTAL / 1024 / 1024" | bc)

echo "{\"text\":\"${USED_GB}GB/${TOTAL_GB}GB\",\"tooltip\":\"Memory Usage: ${USED_GB}GB / ${TOTAL_GB}GB\"}"
