#!/usr/bin/env bash
# ============================================================
#  Spotlight — a modular, macOS-style search for Hyprland
# ============================================================
#  Searches multiple "providers" in one list: apps, keybinds, …
#
#  TO ADD A NEW PROVIDER (the modular bit):
#    1. Write a function `provider_xxx` that prints rows as:
#          <DISPLAY TEXT><US><ACTION>
#       where <US> is the $US separator and <ACTION> is one of:
#          run:<shell command>     run a command on select
#          app:<file.desktop>      launch a desktop app
#          noop:                   do nothing (informational)
#    2. Call it inside collect().
# ============================================================

US=$'\x1f'   # unit separator — safe field delimiter, never in labels

# ---- provider: applications -------------------------------
provider_apps() {
    local d f name id
    for d in /usr/share/applications "$HOME/.local/share/applications"; do
        [ -d "$d" ] || continue
        for f in "$d"/*.desktop; do
            [ -f "$f" ] || continue
            grep -qiE '^(NoDisplay|Hidden)=true' "$f" && continue
            name=$(awk -F= '/^Name=/{print $2; exit}' "$f")
            id=$(basename "$f")
            [ -n "$name" ] && printf '  %s%sapp:%s\n' "$name" "$US" "$id"
        done
    done
}

# ---- provider: keybinds (informational) -------------------
provider_keybinds() {
    while IFS= read -r row; do
        [ -n "$row" ] && printf '  %s%snoop:\n' "$row" "$US"
    done <<'KB'
SUPER + Q              Open terminal (kitty)
SUPER + R / Space      Spotlight search (this)
SUPER + E              File manager (dolphin)
SUPER + C              Close active window
SUPER + V              Toggle floating window
SUPER + P              Pseudo-tile
SUPER + J              Toggle split direction
SUPER + M              Exit Hyprland (log out)
SUPER + Arrows         Move focus between windows
SUPER + LMB drag       Move window
SUPER + RMB drag       Resize window
SUPER + [1-9,0]        Switch to workspace N
SUPER + SHIFT + [1-9,0]  Move window to workspace N
SUPER + scroll         Cycle workspaces
SUPER + S              Toggle special "magic" workspace
Volume / Media keys    Audio & playback control
Brightness keys        Screen brightness
KB
}

# ---- aggregate everything ---------------------------------
collect() {
    provider_apps
    provider_keybinds
    # provider_power   # <- example future provider
    # provider_emoji   # <- example future provider
}

main() {
    local menu choice action
    menu=$(collect)

    choice=$(printf '%s\n' "$menu" | cut -d"$US" -f1 \
        | wofi --dmenu --insensitive --prompt "Search" --width 720 --height 560)
    [ -z "$choice" ] && exit 0

    action=$(printf '%s\n' "$menu" | awk -F"$US" -v c="$choice" '$1==c{print $2; exit}')

    case "$action" in
        app:*) gtk-launch "${action#app:}" >/dev/null 2>&1 & disown ;;
        run:*) setsid -f sh -c "${action#run:}" >/dev/null 2>&1 ;;
        *)     : ;;   # noop / informational
    esac
}

main
