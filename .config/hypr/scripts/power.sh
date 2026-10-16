#!/usr/bin/env bash

options="Lock\nLogout\nReboot\nShutdown"

chosen=$(echo -e "$options" | rofi -dmenu -theme ~/.config/rofi/type-2/style-15.rasi -p "Power" \
    -theme-str '
        window { width: 35em; location: south; anchor: south; }
        element { orientation: vertical; padding: 12px; }
        element-icon { size: 40px; horizontal-align: 0.5; }
        element-text { horizontal-align: 0.5; }
        listview { columns: 4; lines: 1; fixed-columns: true; fixed-height: true; spacing: 10px; }
        entry { enabled: false; }
    ')

case $chosen in
    Shutdown) systemctl poweroff ;;
    Reboot) systemctl reboot ;;
    Lock) hyprlock ;;
    Logout) hyprctl dispatch 'hl.dsp.exit()' ;;
esac
