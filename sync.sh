#!/usr/bin/env bash
# Copy live configs from ~/.config into this repo, ready to commit.
# Run from anywhere:  ~/dotfiles/sync.sh
set -e
cd "$(dirname "$0")"

copy() { mkdir -p "$(dirname "$2")"; cp -r "$1" "$2"; }

copy ~/.config/hypr/hyprland.lua      hypr/.config/hypr/hyprland.lua
copy ~/.config/hypr/hyprpaper.conf    hypr/.config/hypr/hyprpaper.conf
copy ~/.config/hypr/wallpaper.sh      hypr/.config/hypr/wallpaper.sh
copy ~/.config/hypr/spotlight.sh      hypr/.config/hypr/spotlight.sh
copy ~/.config/hypr/keybind-help.sh   hypr/.config/hypr/keybind-help.sh
copy ~/.config/kitty/kitty.conf       kitty/.config/kitty/kitty.conf
copy ~/.config/waybar/config.jsonc    waybar/.config/waybar/config.jsonc
copy ~/.config/waybar/style.css       waybar/.config/waybar/style.css
copy ~/.config/waybar/scripts/weather.sh waybar/.config/waybar/scripts/weather.sh
copy ~/.config/wofi/config            wofi/.config/wofi/config
copy ~/.config/wofi/style.css         wofi/.config/wofi/style.css
copy ~/.config/dunst/dunstrc          dunst/.config/dunst/dunstrc

echo "✓ synced live configs into repo"
