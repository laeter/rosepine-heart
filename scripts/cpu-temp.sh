#!/bin/bash
# Simple CPU temperature display

# Get CPU temp from sensors
if command -v sensors >/dev/null 2>&1; then
    CPU_TEMP=$(sensors | grep 'Tctl' | awk '{print $2}' | tr -d '+°C')
    if [ -z "$CPU_TEMP" ]; then
        # Fallback to Package or Core temp
        CPU_TEMP=$(sensors | grep -E 'Package id|Core 0' | head -1 | awk '{print $3}' | tr -d '+°C')
    fi
else
    CPU_TEMP="--"
fi

echo "{\"text\":\"${CPU_TEMP}°C\",\"tooltip\":\"CPU Temperature: ${CPU_TEMP}°C\"}"
