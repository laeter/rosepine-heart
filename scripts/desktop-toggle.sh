#!/bin/bash

# Toggle pcmanfm-qt desktop mode on/off

if pgrep -x "pcmanfm-qt" > /dev/null; then
    # Desktop is running, turn it off
    pkill pcmanfm-qt
    echo '{"text": "󰇄", "class": "off", "tooltip": "Desktop Icons: OFF - Click to enable"}'
else
    # Desktop is off, turn it on
    pcmanfm-qt --desktop &
    sleep 0.5
    echo '{"text": "󰇄", "class": "on", "tooltip": "Desktop Icons: ON - Click to disable"}'
fi
