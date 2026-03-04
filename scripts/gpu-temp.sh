#!/bin/bash
# Simple GPU temperature display

# Get GPU temp from nvidia-smi
if command -v nvidia-smi >/dev/null 2>&1; then
    GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)
else
    GPU_TEMP="--"
fi

echo "{\"text\":\"${GPU_TEMP}°C\",\"tooltip\":\"GPU Temperature: ${GPU_TEMP}°C\"}"
