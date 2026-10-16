-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
	hl.exec_cmd("waybar")
    hl.exec_cmd("playerctld daemon")
    hl.exec_cmd("sh -c '[ -f ~/.cache/current_wallpaper ] && swaybg -m fill -i $(cat ~/.cache/current_wallpaper)'")
    hl.exec_cmd("swaync")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
