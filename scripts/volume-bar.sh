#!/bin/bash

# Get current volume and mute status
volume=$(pamixer --get-volume)
muted=$(pamixer --get-mute)

# Create volume bar with Unicode characters
bar_length=10
filled=$(($volume * $bar_length / 100))
empty=$(($bar_length - $filled))

# Build the bar
bar=""
for ((i=0; i<$filled; i++)); do
    bar+="━"
done
for ((i=0; i<$empty; i++)); do
    bar+="─"
done

# Icon based on volume level
if [ "$muted" = "true" ]; then
    icon=""
    echo "{\"text\":\"$icon off $bar\", \"class\":\"muted\"}"
elif [ $volume -ge 80 ]; then
    icon=""
    echo "{\"text\":\"$icon $volume% $bar\", \"class\":\"high\"}"
elif [ $volume -ge 50 ]; then
    icon=""
    echo "{\"text\":\"$icon $volume% $bar\", \"class\":\"medium\"}"
else
    icon=""
    echo "{\"text\":\"$icon $volume% $bar\", \"class\":\"low\"}"
fi
