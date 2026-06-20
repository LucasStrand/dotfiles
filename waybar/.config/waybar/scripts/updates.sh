#!/usr/bin/env bash
# Show cached update count instantly; refresh cache in background (atomic write).
( command -v checkupdates >/dev/null 2>&1 && checkupdates 2>/dev/null | wc -l > /tmp/waybar-updates.tmp && mv -f /tmp/waybar-updates.tmp /tmp/waybar-updates ) &
n=$(cat /tmp/waybar-updates 2>/dev/null)
[ -n "$n" ] && [ "$n" -gt 0 ] 2>/dev/null && printf "  %s
" "$n"
