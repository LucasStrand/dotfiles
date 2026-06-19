#!/usr/bin/env bash
# Hyprland keybind cheatsheet — readable list shown in wofi.
# Bound to SUPER + Space.
#
# NOTE: this is a curated list (Hyprland's Lua config hides the real actions
# from `hyprctl binds`). If you add/change a bind in hyprland.lua, update it here.

cat <<'EOF' | wofi --dmenu --insensitive --prompt "Keybinds" --width 780 --height 620 >/dev/null 2>&1
  SUPER + Q                Open terminal (kitty)
  SUPER + R                App launcher (rofi)
  SUPER + E                File manager (dolphin)
  SUPER + C                Close active window
  SUPER + V                Toggle floating window
  SUPER + P                Pseudo-tile (dwindle)
  SUPER + T                Toggle split direction
  SUPER + Space            Show this keybind cheatsheet
  SUPER + M                Toggle fullscreen
  ───────────────────────────────────────────────
  SUPER + H J K L          Move focus (vim: left/down/up/right)
  SUPER + ← ↓ ↑ →          Move focus (also works)
  SUPER + LMB drag         Move window
  SUPER + RMB drag         Resize window
  ───────────────────────────────────────────────
  SUPER + [1…9, 0]         Switch to workspace N
  SUPER + SHIFT + [1…9, 0]  Move window to workspace N
  SUPER + scroll           Cycle through workspaces
  SUPER + S                Toggle special "magic" workspace
  SUPER + SHIFT + S        Move window to special workspace
  ───────────────────────────────────────────────
  Volume / Mute keys       Adjust audio (wpctl)
  Brightness keys          Adjust screen brightness
  Media keys               Play / pause / next / prev
EOF
