#!/usr/bin/env bash
# Copy live configs from ~/.config into this repo, ready to commit.
# Run from anywhere:  ~/dotfiles/sync.sh
set -e
cd "$(dirname "$0")"

copy() { mkdir -p "$(dirname "$2")"; rm -rf "$2"; cp -r "$1" "$2"; }

copy ~/.config/hypr/hyprland.lua      hypr/.config/hypr/hyprland.lua
copy ~/.config/hypr/hyprpaper.conf    hypr/.config/hypr/hyprpaper.conf
copy ~/.config/hypr/wallpaper.sh      hypr/.config/hypr/wallpaper.sh
copy ~/.config/hypr/spotlight.sh      hypr/.config/hypr/spotlight.sh
copy ~/.config/hypr/cheatsheet.sh     hypr/.config/hypr/cheatsheet.sh
copy ~/.config/hypr/keybind-help.sh   hypr/.config/hypr/keybind-help.sh
copy ~/.local/bin/keybinds            bin/.local/bin/keybinds
copy ~/.config/kitty/kitty.conf       kitty/.config/kitty/kitty.conf
copy ~/.config/waybar/config.jsonc    waybar/.config/waybar/config.jsonc
copy ~/.config/waybar/style.css       waybar/.config/waybar/style.css
copy ~/.config/waybar/scripts/weather.sh waybar/.config/waybar/scripts/weather.sh
copy ~/.config/rofi/config.rasi       rofi/.config/rofi/config.rasi
copy ~/.config/dunst/dunstrc          dunst/.config/dunst/dunstrc
copy ~/.config/starship.toml          starship/.config/starship.toml
copy ~/.config/btop/btop.conf         btop/.config/btop/btop.conf
copy ~/.config/btop/themes/catppuccin_mocha.theme btop/.config/btop/themes/catppuccin_mocha.theme
copy ~/.config/yazi/theme.toml         yazi/.config/yazi/theme.toml
copy ~/.config/yazi/flavors/catppuccin-mocha.yazi yazi/.config/yazi/flavors/catppuccin-mocha.yazi

echo "✓ synced live configs into repo"
