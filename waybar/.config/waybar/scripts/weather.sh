#!/usr/bin/env bash
# Current condition + temperature from wttr.in (auto-locates by IP).
# Prints nothing on failure so the waybar pill simply hides.

out=$(curl -fs -m 6 "https://wttr.in/?format=%c%t" 2>/dev/null) || exit 0
# strip whitespace; wttr returns e.g. "☁️ +26°C"
out=$(printf '%s' "$out" | tr -s ' ' | sed 's/+//')
[ -n "$out" ] && printf '%s\n' "$out"
