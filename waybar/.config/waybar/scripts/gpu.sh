#!/usr/bin/env bash
# GPU temp + usage (NVIDIA) for waybar.
out=$(nvidia-smi --query-gpu=temperature.gpu,utilization.gpu --format=csv,noheader,nounits 2>/dev/null) || exit 0
t=${out%%,*}; u=${out##*,}
t=${t//[!0-9]/}; u=${u//[!0-9]/}
[ -n "$t" ] && printf '  %s°C  %s%%\n' "$t" "$u"
