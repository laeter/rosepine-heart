# Waybar Custom Icon Configuration Guide

## Overview
This guide documents the process for adding custom unicode icons to waybar modules without corruption issues.

## The Problem
When pasting unicode icons directly into config files or scripts, they can:
- Get corrupted during copy/paste
- Include extra characters (like `<`)
- Not render properly due to encoding issues
- Cause waybar to fail with Pango markup errors

## The Solution: Empty File Method

### Step-by-Step Process

#### 1. Create an empty file with the icon as the filename
```bash
cd /home/laeter/.config/waybar/scripts
touch temp_icon
# Rename the file in your file manager to just the icon character (no text at all)
```

#### 2. Extract the hex bytes from the filename
```bash
cd /home/laeter/.config/waybar/scripts
ls -1 | grep -v ".sh$" | od -A n -t x1
# Example output: ef 8b 9b 0a
# The '0a' at the end is a newline character, ignore it
# The actual icon bytes are: ef 8b 9b
```

#### 3. Insert the icon into scripts using sed
For bash scripts that output JSON:
```bash
# Replace an existing icon
sed -i 's/\xOLD\xBYTES/\xNEW\xBYTES/g' /path/to/script.sh

# Example: Replace memory icon
sed -i 's/\xee\xbf\x85/\xef\x8b\x9b/g' memory-simple.sh
```

#### 4. Insert icons into waybar configs with Pango markup
For ModulesCustom or config files:
```bash
# Use printf to insert the icon
sed -i "s|placeholder|$(printf '\xef\x8b\x9b')|g" ModulesCustom

# Example: Insert CPU icon into format field
sed -i "49s|<span size='large'></span>|<span size='large'>$(printf '\xef\x8b\x9b')</span>|g" ModulesCustom
```

#### 5. Clean up temporary icon file
```bash
cd /home/laeter/.config/waybar/scripts
rm -f "$(ls -1 | grep -v '.sh$' | head -1)"
```

#### 6. Restart waybar
```bash
killall -9 waybar && sleep 1 && waybar &
```

## Current Icon Configuration

### Icon Hex Values
- **CPU icon**: `ef 8b 9b` ()
- **GPU icon**: `f3 b0 a2 ae` (󰢮)
- **Memory icon**: `ee bf 85` ()
- **Arch Update icon**: `ef 80 a1` ()

### Module Configuration

#### CPU Temperature Module
- **Script**: `/home/laeter/.config/waybar/scripts/cpu-temp.sh`
- **Icon location**: Waybar config (ModulesCustom line 49)
- **Format**: `<span size='large'></span> {}` (icon from Pango markup, temp from script)
- **Script outputs**: Just temperature text (e.g., "42.5°C")

#### GPU Temperature Module
- **Script**: `/home/laeter/.config/waybar/scripts/gpu-temp.sh`
- **Icon location**: Waybar config (ModulesCustom line 59)
- **Format**: `<span size='large'>󰢮</span> {}` (icon from Pango markup, temp from script)
- **Script outputs**: Just temperature text (e.g., "65°C")

#### Memory Usage Module
- **Script**: `/home/laeter/.config/waybar/scripts/memory-simple.sh`
- **Icon location**: Waybar config (ModulesCustom line 69)
- **Format**: `<span size='large'></span> {}` (icon from Pango markup, usage from script)
- **Script outputs**: Just memory usage text (e.g., "10.4GB/31GB")

#### Arch Update Module
- **Script**: `/home/laeter/.config/waybar/scripts/arch-update.sh`
- **Icon location**: Inside the script (lines 28 and 30)
- **Script outputs**: Icon + count in JSON format

## Styling Configuration

### Module Spacing (in style.css)
```css
/* Tighter spacing for CPU, GPU, and Memory modules */
#custom-cpu-temp,
#custom-gpu-temp,
#custom-memory-simple {
  margin: 3px 2px;
}

/* Tighter spacing for Network, Bluetooth and Volume modules */
#network,
#bluetooth,
#custom-volume-bar {
  margin: 3px 2px;
}
```

### Module Order (in config)
Right side modules order:
1. Recording indicator
2. System tray
3. System metrics group
4. CPU temperature
5. GPU temperature
6. Memory usage
7. Network
8. Bluetooth
9. Volume bar
10. Line separator
11. Battery
12. Arch updates
13. Status group (lock/power/desktop-toggle)

### Icon Sizing
Icons in ModulesCustom use Pango markup `<span size='large'>` to make them larger than the default text.

## Troubleshooting

### Icon shows as `<` or corrupted character
- The icon was pasted with extra characters
- Use the empty file method to extract clean hex bytes
- Check the hex with: `od -A n -t x1 filename`

### Icon shows as blank space or `=`
- The font doesn't have that specific glyph
- Try a different icon from the reference dotfiles
- Use the empty file method to get exact bytes from working icons

### Waybar fails with "not a valid character following a '<' character"
- A literal `<` character is in the output
- Pango markup interprets `<` as HTML
- Remove the `<` character using sed: `sed -i 's/<//g' script.sh`

### Icon doesn't update after changes
- Restart waybar: `killall -9 waybar && sleep 1 && waybar &`
- Check script output: `bash /path/to/script.sh`
- Verify hex bytes are correct: `sed -n 'LINE_NUMBER p' file | od -A n -t x1`

## Reference
Icon reference dotfiles: https://github.com/kokopi-dev/dotfiles/blob/master/hyprland/waybar/config.jsonc

## Notes
- Always use the empty file method for new icons
- Icons display differently in terminal vs waybar (font rendering)
- Verify icons work by testing the script output before updating waybar
- Keep this guide updated when adding new icons
