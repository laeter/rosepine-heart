#!/bin/sh
# temp-bar.sh - report highest thermal zone temp (°C) for Waybar
# outputs JSON with text and tooltip

# prefer /sys thermal zones
max_temp=0
if [ -d /sys/class/thermal ]; then
  for f in /sys/class/thermal/thermal_zone*/temp; do
    [ -f "$f" ] || continue
    t=$(cat "$f" 2>/dev/null)
    # some temps are in millidegC
    if [ -n "$t" ]; then
      if [ ${#t} -gt 3 ]; then
        t=$((t/1000))
      fi
      [ "$t" -gt "$max_temp" ] && max_temp="$t"
    fi
  done
fi

# fallback to sensors output if available
if [ "$max_temp" -eq 0 ] && command -v sensors >/dev/null 2>&1; then
  # try to parse first temp value
  s=$(sensors 2>/dev/null | sed -n 's/.*:\s*+\([0-9]\+\)°C.*/\1/p' | head -n1)
  if [ -n "$s" ]; then
    max_temp=$s
  fi
fi

if [ "$max_temp" -eq 0 ]; then
  printf '{"text":" --°C","tooltip":"Temperature unknown"}\n'
else
  printf '{"text":" %s°C","tooltip":"Max temp: %s°C"}\n' "$max_temp" "$max_temp"
fi
