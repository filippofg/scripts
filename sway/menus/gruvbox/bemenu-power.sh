#!/bin/bash

#lock_label=" lock"
#logout_label=" exit"
#suspend_label=" suspend"
#reboot_label=" reboot"
#shutdown_label=" shutdown/poweroff"
#cancel_label=" cancel"

lock_label="lock"
logout_label="exit"
suspend_label="suspend"
reboot_label="reboot"
shutdown_label="shutdown/poweroff"
cancel_label="cancel"


backend=$(echo $XDG_SESSION_TYPE)

options="$lock_label\n$logout_label\n$suspend_label\n$reboot_label\n$shutdown_label\n$cancel_label"

#choice="$(echo -e $options | BEMENU_OPTS='-m 0 -l 6 -n -p  "Power"  --line-height=30 --tb=#1f232b --tf=#e06c75 --fb=#1f232b --ff=#98c375 --nb=#181c24 --nf=#a3be8c --hf=#d08770 --hb=#1f232b' bemenu)"

choice=$(echo -e $options | BEMENU_BACKEND=$backend BEMENU_OPTS='--tb=#1d2021 --tf=#d3869b --fb=#1d2021 --ff=#d3869b --nb=#1d2021 --nf=#a89984 --hb=#1d2021 --hf=#8ec07c --scf=#ebdbb2 -p "Power" --ignorecase --fn "Ubuntu Mono 11" --line-height=22 ' bemenu )

case "$choice" in
    $lock_label)
        swaylock -i ~/Pictures/bsod.png
	;;	
    $suspend_label)
        playerctl pause
        amixer set Master mute
	swaylock -f -i ~/Pictures/bsod.png	
	#systemctl suspend
	loginctl suspend
	;;
    $reboot_label)
        loginctl reboot
	;;
    $shutdown_label)
        loginctl poweroff
	;;
    $logout_label)
	swaymsg exit
    	;;
    *)
        ;;
esac
