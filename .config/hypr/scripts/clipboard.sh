#!/usr/bin/env bash

cliphist list | rofi -dmenu \
    -display-columns 2 \
    -theme ~/.config/rofi/type-2/style-15.rasi \
    -i -p "Clipboard" \
    -theme-str '
        window { width: 50%; location: south; anchor: south; }
        element { orientation: horizontal; padding: 10px; }
        element-icon { size: 30px; }
        element-text { vertical-align: 0.5; }
        listview { columns: 1; lines: 8; spacing: 8px; }
        entry { enabled: false; }
    ' | cliphist decode | wl-copy
