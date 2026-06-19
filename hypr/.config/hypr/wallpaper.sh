#!/usr/bin/env bash
# Reliable wallpaper startup for hyprpaper.
# hyprpaper started from autostart often runs before Hyprland has registered the
# monitors, so the per-output "wallpaper = DP-3,..." lines in hyprpaper.conf fail
# silently ("monitor not found"). This waits for hyprpaper's IPC and re-applies
# the wallpaper to every connected monitor.

WP="$HOME/Pictures/wallpapers/flower-branch.png"

# Start hyprpaper if it isn't already running.
pgrep -x hyprpaper >/dev/null || (hyprpaper >/dev/null 2>&1 &)

# Wait (up to ~5s) for the hyprpaper IPC to respond.
for _ in $(seq 1 25); do
    hyprctl hyprpaper listloaded >/dev/null 2>&1 && break
    sleep 0.2
done

hyprctl hyprpaper preload "$WP" >/dev/null 2>&1

# Apply to each connected monitor by name.
hyprctl monitors | awk '/^Monitor/{print $2}' | while read -r mon; do
    [ -n "$mon" ] && hyprctl hyprpaper wallpaper "$mon,$WP" >/dev/null 2>&1
done
