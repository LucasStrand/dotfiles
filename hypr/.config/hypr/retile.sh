#!/usr/bin/env bash
# Directional re-tile for the dwindle layout, bound to SUPER+SHIFT+h/j/k/l.
#   left / right  -> make the current pair side-by-side, then move that way
#   up   / down   -> make the current pair stacked,      then move that way
# So you place windows by pushing them, instead of guessing with togglesplit.

dir="$1"
case "$dir" in
    left|right) want=h ;;
    up|down)    want=v ;;
    *) exit 0 ;;
esac

# Detect the focused window's current split orientation by looking at its
# tiled neighbour: a side-by-side neighbour => "h", a stacked neighbour => "v".
cur=$(python3 - <<'PY'
import json, subprocess, sys
def hc(*a): return json.loads(subprocess.run(["hyprctl",*a,"-j"],capture_output=True,text=True).stdout or "null")
a = hc("activewindow")
if not a or a.get("floating"): print("skip"); sys.exit()
ws=a["workspace"]["id"]; ax,ay=a["at"]; aw,ah=a["size"]
def ov(a0,a1,b0,b1): return min(a1,b1)-max(a0,b0) > 5
o="?"
for c in hc("clients"):
    if c["workspace"]["id"]!=ws or c.get("floating") or c.get("hidden") or not c.get("mapped"): continue
    x,y=c["at"]; w,h=c["size"]
    if [x,y,w,h]==[ax,ay,aw,ah]: continue
    if (abs(x-(ax+aw))<60 or abs(x+w-ax)<60) and ov(ay,ay+ah,y,y+h): o="h"; break
    if (abs(y-(ay+ah))<60 or abs(y+h-ay)<60) and ov(ax,ax+aw,x,x+w): o="v"; break
print(o)
PY
)

# If the orientation already matches the pressed direction, move/swap that way.
# If it doesn't, just re-orient (togglesplit) — that IS the "push" into the new
# layout. (Doing both makes movewindow undo the togglesplit.)
if { [ "$cur" = "h" ] || [ "$cur" = "v" ]; } && [ "$cur" != "$want" ]; then
    hyprctl dispatch 'hl.dsp.layout("togglesplit")' >/dev/null 2>&1
else
    # already the right orientation: swap position that way (keeps orientation;
    # movewindow would wrongly flip it).
    hyprctl dispatch "hl.dsp.window.swap({ direction = \"$dir\" })" >/dev/null 2>&1
fi
