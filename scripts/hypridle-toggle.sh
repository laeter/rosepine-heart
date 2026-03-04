#!/bin/bash

# Toggle hypridle on/off
if pgrep -x hypridle > /dev/null; then
    pkill hypridle
    notify-send "Hypridle" "Idle timer disabled" -t 2000
else
    uwsm-app -- hypridle &
    notify-send "Hypridle" "Idle timer enabled" -t 2000
fi
