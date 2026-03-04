#!/bin/bash

# Rofi power menu for ArchRiot
# Neuro Mocha themed

option=$(echo -e "  Lock\n  Logout\n  Suspend\n󰜉  Reboot\n  Shutdown" | rofi -dmenu -i -p "Power Menu" -theme neuro-mocha)

case "$option" in
    *Lock)
        hyprlock
        ;;
    *Logout)
        hyprctl dispatch exit
        ;;
    *Suspend)
        systemctl suspend
        ;;
    *Reboot)
        systemctl reboot
        ;;
    *Shutdown)
        systemctl poweroff
        ;;
esac
