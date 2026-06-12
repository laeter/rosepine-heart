#!/usr/bin/env bash

# Colors for formatting output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${PURPLE}==============================================${NC}"
echo -e "${PURPLE}       Rosepine Heart Waybar Installer        ${NC}"
echo -e "${PURPLE}==============================================${NC}"

# Target config directory
TARGET_DIR="$HOME/.config/waybar"
BACKUP_DIR="$HOME/.config/waybar.bak_$(date +%Y%m%d_%H%M%S)"

# Check if waybar config directory already exists
if [ -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}Existing Waybar configuration detected at $TARGET_DIR.${NC}"
    echo -e "${BLUE}Backing up existing config to $BACKUP_DIR...${NC}"
    mv "$TARGET_DIR" "$BACKUP_DIR"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Backup successfully created!${NC}"
    else
        echo -e "${RED}Error: Failed to create backup. Installation aborted.${NC}"
        exit 1
    fi
fi

# Get the directory where the install script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}Installing Rosepine Heart Waybar configuration to $TARGET_DIR...${NC}"
mkdir -p "$TARGET_DIR"

# Copy all files
cp -r "$SCRIPT_DIR"/* "$TARGET_DIR"/
if [ $? -eq 0 ]; then
    # Clean up non-config files in the destination directory
    rm -rf "$TARGET_DIR"/install.sh \
           "$TARGET_DIR"/README.md \
           "$TARGET_DIR"/screenshot-*.png \
           "$TARGET_DIR"/backups \
           "$TARGET_DIR"/.git \
           "$TARGET_DIR"/.gitignore \
           "$TARGET_DIR"/v21.png
    
    echo -e "${GREEN}Configuration files successfully installed!${NC}"
else
    echo -e "${RED}Error: Failed to copy files. Installation aborted.${NC}"
    exit 1
fi

# Try to reload waybar if running
if pgrep -x waybar >/dev/null; then
    echo -e "${BLUE}Waybar process detected. Reloading configuration...${NC}"
    pkill -USR2 waybar
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Waybar reloaded successfully!${NC}"
    else
        echo -e "${YELLOW}Could not reload signal. Attempting to restart Waybar...${NC}"
        pkill -x waybar
        sleep 0.5
        if command -v uwsm-app &>/dev/null; then
            uwsm-app -- waybar >/dev/null 2>&1 &
        else
            waybar >/dev/null 2>&1 &
        fi
        echo -e "${GREEN}Waybar restarted!${NC}"
    fi
else
    echo -e "${YELLOW}Waybar is not currently running. Start it using your desktop environment launcher.${NC}"
fi

echo -e "${PURPLE}==============================================${NC}"
echo -e "${GREEN}      Installation Completed Successfully!    ${NC}"
echo -e "${PURPLE}==============================================${NC}"
