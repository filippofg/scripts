#!/bin/bash

lock_label="lock"
logout_label="exit"
suspend_label="suspend"
reboot_label="reboot"
shutdown_label="shutdown/poweroff"
cancel_label="cancel"

backend=$(echo $XDG_SESSION_TYPE)

options="$lock_label\n$logout_label\n$suspend_label\n$reboot_label\n$shutdown_label\n$cancel_label"

#choice="$(echo -e $options | BEMENU_OPTS='-m 0 -l 6 -n -p  "Power"  --line-height=30 --tb=#1f232b --tf=#e06c75 --fb=#1f232b --ff=#98c375 --nb=#181c24 --nf=#a3be8c --hf=#d08770 --hb=#1f232b' bemenu)"

# colors="--tb=#1a2127 --tf=#8fbcbb --fb=#1a2127 --ff=#8fbcbb --nb=#1a2127 --nf=#d8dee9 --hb=#1a2127 --hf=#a3be8c --scf=#ebdbb2"


choice=$(echo -e $options | BEMENU_BACKEND=$backend BEMENU_OPTS='--tb=#1a2127 --tf=#8fbcbb --fb=#1a2127 --ff=#8fbcbb --nb=#1a2127 --nf=#d8dee9 --hb=#1a2127 --hf=#a3be8c --scf=#ebdbb2 -p "Power" --ignorecase --fn "Hack 8" --line-height=20' bemenu )

case "$choice" in
    $lock_label)
        swaylock -f -c 1d2021
	;;	
    $suspend_label)
        playerctl pause
        amixer set Master mute
        #systemctl suspend
	swaylock -f -c 1d2021
	loginctl suspend
	;;
    $reboot_label)
        loginctl reboot
	;;
    $shutdown_label)
        loginctl poweroff
	;;
    $logout_label)
	~/bin/sway/logout.sh
	swaymsg exit
    	;;
    *)
        ;;
esac
