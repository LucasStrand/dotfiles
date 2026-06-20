#!/usr/bin/env bash
# GPU temp + usage (NVIDIA). JSON output so the hover tooltip can label it.
out=$(nvidia-smi --query-gpu=temperature.gpu,utilization.gpu --format=csv,noheader,nounits 2>/dev/null) || exit 0
t=${out%%,*}; u=${out##*,}
t=${t//[!0-9]/}; u=${u//[!0-9]/}
[ -z "$t" ] && exit 0
printf '{"text":"  %s°C  %s%%","tooltip":"GPU temperature %s°C · usage %s%%"}\n' "$t" "$u" "$t" "$u"
