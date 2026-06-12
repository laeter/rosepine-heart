#!/bin/bash
# Wrapper for swaync-client that hides "0" notification count

swaync-client -swb | while read -r line; do
    if echo "$line" | grep -q '"text": "0"'; then
        echo "$line" | sed 's/"text": "0"/"text": ""/'
    else
        echo "$line"
    fi
done
