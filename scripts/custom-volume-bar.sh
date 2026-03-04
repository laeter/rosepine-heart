#!/bin/bash

# Get volume percentage using wpctl (pipewire) or pactl (pulseaudio)
if command -v wpctl &> /dev/null; then
    # Using pipewire
    VOLUME_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    VOLUME_PERCENT=$(echo "$VOLUME_INFO" | awk '{print int($2 * 100)}')
    IS_MUTED=$(echo "$VOLUME_INFO" | grep -q "MUTED" && echo "true" || echo "false")
elif command -v pactl &> /dev/null; then
    # Using pulseaudio
    VOLUME_INFO=$(pactl get-sink-volume @DEFAULT_SINK@)
    VOLUME_PERCENT=$(echo "$VOLUME_INFO" | grep -oP '\d+%' | head -1 | tr -d '%')
    IS_MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes" && echo "true" || echo "false")
else
    echo '{"text": "󰕾 No Audio", "tooltip": "Audio system not found"}'
    exit 1
fi

# Bar configuration
BAR_LENGTH=10
FILLED_BLOCKS=$((VOLUME_PERCENT / (100 / BAR_LENGTH)))
EMPTY_BLOCKS=$((BAR_LENGTH - FILLED_BLOCKS))

FILLED_BAR=$(printf '█%.0s' $(seq 1 $FILLED_BLOCKS))
EMPTY_BAR=$(printf '░%.0s' $(seq 1 $EMPTY_BLOCKS))

if [ "$IS_MUTED" == "true" ]; then
    ICON="󰝟" # Muted icon
    BAR="[░░░░░░░░░░]"
else
    if [ "$VOLUME_PERCENT" -eq 0 ]; then
        ICON="󰖁" # Volume off icon
    elif [ "$VOLUME_PERCENT" -lt 30 ]; then
        ICON="󰕿" # Low volume icon
    elif [ "$VOLUME_PERCENT" -lt 70 ]; then
        ICON="󰖀" # Medium volume icon
    else
        ICON="󰕾" # High volume icon
    fi
    BAR="[$FILLED_BAR$EMPTY_BAR]"
fi

# Output JSON for Waybar
echo "{\"text\": \"$ICON $BAR\", \"tooltip\": \"Volume: $VOLUME_PERCENT%\"}"
