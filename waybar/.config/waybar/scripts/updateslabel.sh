#!/usr/bin/env bash
n=$(cat /tmp/waybar-updates 2>/dev/null)
[ -n "$n" ] && [ "$n" -gt 0 ] 2>/dev/null && echo 'available · click to install'
