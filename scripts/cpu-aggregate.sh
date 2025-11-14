#!/bin/sh
# cpu-aggregate.sh - lightweight CPU usage for Waybar
# outputs JSON with text and tooltip

get_stats() {
  awk 'NR==1{for(i=2;i<=NF;i++) sum+=$i; print sum, $5}' /proc/stat
}

read total1 idle1 <<EOF
$(get_stats)
EOF
sleep 0.25
read total2 idle2 <<EOF
$(get_stats)
EOF

delta_total=$((total2 - total1))
delta_idle=$((idle2 - idle1))

if [ "$delta_total" -le 0 ]; then
  usage=0
else
  usage=$((100 * (delta_total - delta_idle) / delta_total))
fi

printf '{"text":" %s%%","tooltip":"CPU usage: %s%%"}\n' "$usage" "$usage"
