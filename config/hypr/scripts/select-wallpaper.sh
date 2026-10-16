#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
SUBDIR=""

if [ -n "$1" ]; then
    SUBDIR="$1"
fi

CURRENT_DIR="$WALLPAPER_DIR/$SUBDIR"

while true; do
    MENU_ITEMS=""

    if [ -n "$SUBDIR" ]; then
        MENU_ITEMS+=".. (Back)\0icon\x1ffolder\n"
    fi

    while IFS= read -r dir; do
        [ -z "$dir" ] && continue
        rel_dir="${dir#./}"
        MENU_ITEMS+="${rel_dir}\0icon\x1ffolder\n"
    done < <(cd "$CURRENT_DIR" && find . -mindepth 1 -maxdepth 1 -type d | sort)

    while IFS= read -r file; do
        [ -z "$file" ] && continue
        rel_file="${file#./}"
        MENU_ITEMS+="${rel_file}\0icon\x1f${CURRENT_DIR}/${rel_file}\n"
    done < <(cd "$CURRENT_DIR" && find . -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

    SELECTED=$(echo -e "$MENU_ITEMS" | rofi -dmenu -theme ~/.config/rofi/type-2/style-15.rasi -i -p "Wallpaper [${SUBDIR:-Root}]" \
        -show-icons \
        -theme-str '
            window { width: 60%; location: south; anchor: south; }
            element { orientation: vertical; padding: 15px; }
            element-icon { size: 120px; horizontal-align: 0.5; }
            element-text { horizontal-align: 0.5; }
            listview { columns: 4; lines: 2; fixed-columns: true; spacing: 15px; }
            entry { enabled: false; }
        ')

    [ -z "$SELECTED" ] && exit 0

    if [ "$SELECTED" = ".. (Back)" ]; then
        SUBDIR=$(dirname "$SUBDIR")
        [ "$SUBDIR" = "." ] && SUBDIR=""
        CURRENT_DIR="$WALLPAPER_DIR/$SUBDIR"
        continue
    fi

    if [ -d "$CURRENT_DIR/$SELECTED" ]; then
        if [ -z "$SUBDIR" ]; then
            SUBDIR="$SELECTED"
        else
            SUBDIR="$SUBDIR/$SELECTED"
        fi
        CURRENT_DIR="$WALLPAPER_DIR/$SUBDIR"
        continue
    fi

    FULL_PATH="$CURRENT_DIR/$SELECTED"
    if [ -f "$FULL_PATH" ]; then
        killall swaybg 2>/dev/null
        swaybg -m fill -i "$FULL_PATH" &

        mkdir -p ~/.cache
        echo "$FULL_PATH" > ~/.cache/current_wallpaper

        sed -i "s|path = .*|path = $FULL_PATH|" ~/.config/hypr/hyprlock.conf

        matugen image "$FULL_PATH"
        exit 0
    fi
done
