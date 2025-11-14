#!/bin/bash

ACTION=$1

# Get current volume using archriot (for consistency with waybar script)
# We still need this to get the current state for the Waybar module
VOLUME_INFO=$($HOME/.local/share/archriot/install/archriot --waybar-volume 2>&1)
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