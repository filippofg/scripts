#!/bin/sh

# Swaybar status script (called by ~/.config/sway/config)

# Current date + time
datetime=$(date "+ %a %F ::  %H:%M:%S")

# Battery percentage
if [ "$(cat /sys/class/power_supply/BAT0/status)" = "Discharging" ] ; then
	battery_status=' '
else
	battery_status=' '
fi
battery_capacity="$(cat /sys/class/power_supply/BAT0/capacity)%"

echo "$battery_status$battery_capacity :: $datetime :: "
