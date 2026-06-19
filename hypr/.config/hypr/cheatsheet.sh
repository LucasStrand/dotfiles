#!/usr/bin/env bash
# Keybind cheat-sheet overlay (floating kitty, class "cheatsheet").
#   show   - open it if not already open   (bound to long SUPER hold)
#   hide   - close it                       (bound to SUPER release)
#   toggle - open/close                     (default, for manual use)

CLASS=cheatsheet

launch() {
    exec kitty --class "$CLASS" \
        -o font_size=10 \
        -o window_padding_width=14 \
        sh -c "$HOME/.local/bin/keybinds; read -rsn1 -t 60 _"
}

case "$1" in
    show) pgrep -f "kitty --class $CLASS" >/dev/null || launch ;;
    hide) pkill -f "kitty --class $CLASS" ;;
    *)    pkill -f "kitty --class $CLASS" || launch ;;
esac
