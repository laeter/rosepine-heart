# Rosepine Heart - Waybar Config

A beautiful, pastel-themed Waybar configuration designed for Hyprland, utilizing the **Rosé Pine** color palette with a customizable layout and dynamic modules.

## Features

- **Rosé Pine Palette**: Sleek, cozy, and vibrant pastel-colored icons and modules.
- **Kanji Workspaces**: Clean workspace switcher using Japanese kanji numerals (`一`, `二`, `三`, `四`, `五`, `六`).
- **Interactive Audio**: Custom volume bar with 1% scroll increments and right-click mute actions, integrated with **SwayOSD** popups.
- **System Diagnostics**: CPU usage, memory occupancy, network link status, and battery percentage monitors.
- **Quick-Access Action Buttons**:
  - 󰹑 **Screenshot Tool**: Region selection (left-click) or full-screen (right-click) via `grimblast`.
  - 󰻃 **Screen Recorder**: Custom audio/video recording controls.
  - 󰍬 **Voice Transcribing**: Status indicators for speech-to-text models.
  -  **System Updates**: Interactive pacman/yay SwarmArch updates.
  -  **Song Recognition**: Quick toggling for song identification wrappers.
- **Extras**: Real-time weather reporting via `wttrbar` and media player controller wrapper (`mpris`).

## Preview

![Waybar with Rosepine Heart theme](screenshot-2026-03-03_22-08-05.png)

![Waybar with Rosepine Heart theme](screenshot-2026-03-03_22-13-48.png)

![Waybar with Rosepine Heart theme](screenshot-2026-03-03_22-13-59.png)

![Waybar with Rosepine Heart theme](screenshot-2026-03-03_22-47-25.png)

![Waybar with Rosepine Heart theme](screenshot-2026-03-03_22-52-19.png)

---

## Prerequisites & Dependencies

To ensure all modules function correctly, install the following packages:

```bash
# Arch Linux (pacman/yay)
yay -S waybar swaync swayosd-git grimblast-git wttrbar btop bluetui impala pamixer pactl
```

### Required Fonts:
- **JetBrainsMono Nerd Font** (used as the main interface typeface)
- **CaskaydiaMono Nerd Font** (fallback for special icons)

---

## Installation

### Method 1: Safe Installer Script (Recommended)
This method is best if you want to backup your existing Waybar configuration before installing this theme.

1. Clone the repository to a temporary directory:
   ```bash
   git clone https://github.com/laeter/rosepine-heart.git ~/Downloads/rosepine-heart
   ```
2. Navigate to the directory and run the installer:
   ```bash
   cd ~/Downloads/rosepine-heart
   chmod +x install.sh
   ./install.sh
   ```
   *The script automatically backs up your existing configuration to `~/.config/waybar.bak_[timestamp]` and reloads Waybar.*

### Method 2: Direct Git Clone
If you do not have any existing configuration, you can clone the repository directly into your config directory:

```bash
git clone https://github.com/laeter/rosepine-heart.git ~/.config/waybar
```

---

## Reloading Waybar

To manually reload Waybar after making modifications:

```bash
pkill -USR2 waybar
```
