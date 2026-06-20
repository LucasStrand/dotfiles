#!/usr/bin/env bash
# Pending package updates (official repos). Prints nothing (hidden) when none.
command -v checkupdates >/dev/null 2>&1 || exit 0
n=$(checkupdates 2>/dev/null | wc -l)
[ "$n" -gt 0 ] && printf '  %s\n' "$n"
