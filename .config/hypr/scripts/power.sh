#!/usr/bin/env bash

ICON_DIR="$HOME/.config/rofi/icons"

# Format: Option Text\0icon\x1f/absolute/path/to/icon.svg
options="Lock\0icon\x1f${ICON_DIR}/lock.svg\nLogout\0icon\x1f${ICON_DIR}/logout.svg\nReboot\0icon\x1f${ICON_DIR}/reboot.svg\nShutdown\0icon\x1f${ICON_DIR}/shutdown.svg"

chosen=$(echo -e "$options" | rofi -dmenu -theme ~/.config/rofi/type-2/style-15.rasi -p "Power" \
    -theme-str '
        window { width: 35em; location: south; anchor: south; }
        element { orientation: vertical; padding: 15px; children: [ element-icon ]; }
        element-icon { size: 48px; horizontal-align: 0.5; vertical-align: 0.5; }
        listview { columns: 4; lines: 1; fixed-columns: true; fixed-height: true; spacing: 10px; }
        entry { enabled: false; }
    ')

case $chosen in
    Lock) hyprlock ;;
    Logout) hyprctl dispatch 'hl.dsp.exit()' ;;
    Reboot) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
esac
