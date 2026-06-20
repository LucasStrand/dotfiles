#!/usr/bin/env bash
# Weather for waybar: Nerd Font glyph + temp from wttr.in (auto-locates by IP).
# Prints nothing on failure so the pill hides.
data=$(curl -fs -m 6 "https://wttr.in/?format=%C|%t" 2>/dev/null) || exit 0
cond=${data%%|*}; temp=${data##*|}
temp=${temp// /}; temp=${temp//+/}
c=$(printf '%s' "$cond" | tr '[:upper:]' '[:lower:]')
h=$(date +%H)
case "$c" in
  *thunder*|*storm*)                 i='' ;;
  *snow*|*blizzard*|*sleet*|*ice*)   i='' ;;
  *rain*|*drizzle*|*shower*)         i='' ;;
  *fog*|*mist*|*haze*|*smoke*)       i='' ;;
  *overcast*)                        i='' ;;
  *cloud*|*partly*)                  i='' ;;
  *clear*|*sunny*) if [ "$h" -ge 19 ] || [ "$h" -lt 6 ]; then i=''; else i=''; fi ;;
  *)                                 i='' ;;
esac
[ -n "$temp" ] && printf '%s  %s\n' "$i" "$temp"
