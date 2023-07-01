#!/usr/bin/env bash

# bemenu launcher

# if another istance is running, exit quietly
#if [ $(pgrep bemenu-run | wc -l) > 1 ]; then
#	exit 0
#fi
if pidof -x "bemenu-run" >/dev/null; then
#    echo "nope"
    exit
fi

# x11 or wayland backend depending on the current session type
backend=$XDG_SESSION_TYPE

prompt="% run"
font="Ubuntu Mono 11"
line_height=22

# colors (f = foreground, b = background):
# - t: title
# - f: filter
# - n: normal
# - h: highlighted
# - s: selected
# - sc: scrollbar
#colors="--tb=#1E2129 --tf=#ebdbb2 --fb=#1E2129 --ff=#D08700 --nb=#1E2129 --nf=#E4E8EF --hb=#1E2129 --hf=#5EAA9D"
colors="--tb=#1d2021 --tf=#d3869b --fb=#1d2021 --ff=#d3869b --nb=#1d2021 --nf=#a89984 --hb=#1d2021 --hf=#8ec07c --scf=#ebdbb2"

# run launcher
env BEMENU_BACKEND=$backend bemenu-run --ignorecase --prompt "$prompt" --line-height=$line_height --fn="$font" $colors "$@"
