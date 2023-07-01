#!/bin/bash

if [ "$XDG_CURRENT_DESKTOP" != "sway" ]; then
    exit 1
fi

swaymsg 'output eDP-1 pos 0 0 enable'
