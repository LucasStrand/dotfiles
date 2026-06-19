#!/usr/bin/env bash
# Toggle the floating keybind cheat-sheet overlay.
# Bound to a long SUPER hold in hyprland.lua. Press any key, or hold SUPER
# again, to dismiss. A window rule floats/sizes it (class "cheatsheet").

CLASS=cheatsheet

# If it's already open, holding SUPER again closes it.
if pkill -f "kitty --class $CLASS"; then
    exit 0
fi

# `read` keeps the window open (blocks on kitty's pty) until a key is pressed;
# `sh -c` (not `-e`) avoids leaving an interactive shell prompt.
exec kitty --class "$CLASS" \
    -o font_size=10 \
    -o window_padding_width=14 \
    sh -c "$HOME/.local/bin/keybinds; read -rsn1 _"
