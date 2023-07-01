#!/usr/bin/env bash

# bemenu launcher

# if another istance is running, exit quietly
#if [ $(pgrep bemenu-run | wc -l) > 1 ]; then
#	exit 0
#fi

# x11 or wayland backend depending on the current session type
backend=$XDG_SESSION_TYPE

prompt="% run"
font="Hack 8"
line_height=20

# colors (f = foreground, b = background):
# - t: title
# - f: filter
# - n: normal
# - h: highlighted
# - s: selected
# - sc: scrollbar
#colors="--tb=#1E2129 --tf=#ebdbb2 --fb=#1E2129 --ff=#D08700 --nb=#1E2129 --nf=#E4E8EF --hb=#1E2129 --hf=#5EAA9D"
colors="--tb=#1a2127 --tf=#8fbcbb --fb=#1a2127 --ff=#8fbcbb --nb=#1a2127 --nf=#d8dee9 --hb=#1a2127 --hf=#a3be8c --scf=#ebdbb2"

# run launcher
env BEMENU_BACKEND=$backend bemenu-run --ignorecase --prompt "$prompt" --line-height=$line_height --fn="$font" $colors "$@"
