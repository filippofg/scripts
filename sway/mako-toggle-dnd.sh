#!/bin/sh

lockfile=/tmp/mako-dnd
icon_dnd="dnd"
icon_default="std"

# if lockfile exists, this means mako is set in dnd mode
# then set it in default mode
if test -e "$lockfile"; then
    makoctl set-mode default
    rm $lockfile
    echo $icon_default
else
    makoctl set-mode dnd
    touch "$lockfile"
    echo $icon_dnd
fi
