#!/bin/bash

# Simple weather script using wttr.in
CITY="${WEATHER_CITY:-Port+Coquitlam}"

# Fetch weather data
weather=$(curl -sf "wttr.in/${CITY}?format=%c+%t" 2>/dev/null)

if [ -z "$weather" ]; then
    echo '{"text":"","tooltip":"Weather unavailable"}'
else
    # Get full weather info for tooltip
    tooltip=$(curl -sf "wttr.in/${CITY}?format=%l:+%c+%t+%w+%h+%p" 2>/dev/null)
    echo "{\"text\":\"$weather\",\"tooltip\":\"$tooltip\"}"
fi
