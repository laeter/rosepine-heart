#!/bin/bash

# Check if hypridle is running
if pgrep -x hypridle > /dev/null; then
    echo '{"text":"󰈈","tooltip":"Idle enabled (click to disable)\nRight-click to lock"}'
else
    echo '{"text":"󰈉","tooltip":"Idle disabled (click to enable)\nRight-click to lock"}'
fi
