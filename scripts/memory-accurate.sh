#!/bin/sh
# memory-accurate.sh - outputs used memory info (Total - Available) for Waybar
# prints JSON for waybar consumption

total_kb=$(awk '/MemTotal:/ {print $2; exit}' /proc/meminfo 2>/dev/null || echo 0)
avail_kb=$(awk '/MemAvailable:/ {print $2; exit}' /proc/meminfo 2>/dev/null || echo 0)

if [ -z "$total_kb" ] || [ "$total_kb" -le 0 ]; then
	printf '{"text":" --","tooltip":"Memory unknown"}\n'
	exit 0
fi

used_kb=$((total_kb - avail_kb))
pct=$((used_kb * 100 / total_kb))

hr() {
	kb=$1
	if [ "$kb" -ge 1048576 ]; then
		# show GiB with one decimal
		awk -v k="$kb" 'BEGIN{printf("%.1fG", k/1048576)}'
		return
	fi
	if [ "$kb" -ge 1024 ]; then
		awk -v k="$kb" 'BEGIN{printf("%.1fM", k/1024)}'
		return
	fi
	printf "%dk" "$kb"
}

used_hr=$(hr "$used_kb")
total_hr=$(hr "$total_kb")

printf '{"text":" %s/%s (%d%%)","tooltip":"Memory used: %d kB of %d kB"}\n' "$used_hr" "$total_hr" "$pct" "$used_kb" "$total_kb"
