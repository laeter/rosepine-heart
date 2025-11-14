#!/bin/sh

## arch-update.sh - waybar update module for Arch
## Outputs JSON for waybar and supports --click to launch updater in ghostty

SCRIPT="$HOME/.config/waybar/scripts/arch-update.sh"

case "$1" in
  --click)
    # open ghostty and run a system update (user needs sudo rights)
    ghostty --class=ArchUpdate -e sh -c "printf "Updating...\n"; sudo pacman -Syu; printf "\nDone. Press any key to close...\n"; read -n 1 -s"
    exit 0
    ;;
esac

# number of available repo updates (checkupdates from pacman-contrib)
if command -v checkupdates >/dev/null 2>&1; then
  UPDATES=$(checkupdates 2>/dev/null | wc -l || echo 0)
else
  UPDATES=0
fi

if [ -z "$UPDATES" ]; then
  UPDATES=0
fi

if [ "$UPDATES" -gt 0 ]; then
  printf "{\"text\": \" %s\", \"tooltip\": \"%s package(s) to update\"}\n" "$UPDATES" "$UPDATES"
else
  printf "{\"text\": \"\", \"tooltip\": \"System is up to date\"}\\n"
fi
