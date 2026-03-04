#!/bin/bash

ACTION=$1

# We still need this to get the current state for the Waybar module
CURRENT_VOLUME=$(echo "$VOLUME_INFO" | jq -r '.percentage')

case "$ACTION" in
    "inc")
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+
        # swayosd-client --output-volume +1 # Removed swayosd call
        ;;
    "dec")
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
        # swayosd-client --output-volume -1 # Removed swayosd call
        ;;
    "mute")
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        # swayosd-client --output-volume mute-toggle # Removed swayosd call
        ;;
    *)
        exit 1
        ;;
esac