#!/bin/bash

# Get the number of updates
updates=$(checkupdates 2>/dev/null | wc -l)
aur_updates=$(paru -Qum 2>/dev/null | wc -l)

# Calculate total updates
total=$((updates + aur_updates))

# If there are updates, show the count
if [ "$total" -gt 0 ]; then
    echo "{\"text\": \"󰣇 $total\", \"class\": \"pending-updates\", \"tooltip\": \"$updates official updates\\n$aur_updates AUR updates\"}"
else
    echo "{\"text\": \"󰣇\", \"class\": \"no-updates\", \"tooltip\": \"System is up to date\"}"
fi