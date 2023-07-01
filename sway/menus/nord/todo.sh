#!/usr/bin/env bash

TODO_FILE=~/.todo

if [ ! -e "$TODO_FILE" ] ; then
	touch "$TODO_FILE"
fi

add_todo() {
	echo "$*" >> "$TODO_FILE"
}

print_todos() {
	cat "$TODO_FILE"
}

remove_todo() {
	sed -i "/^$*$/d" "$TODO_FILE"
}

## Bemenu: options

# Backend
backend=$XDG_SESSION_TYPE

# Prompt
prompt="To do:"

# colors
#colors="--tb=#1d2021 --tf=#d3869b --fb=#1d2021 --ff=#d3869b --nb=#1d2021 --nf=#a89984 --hb=#1d2021 --hf=#8ec07c --scf=#ebdbb2"
colors="--tb=#1a2127 --tf=#8fbcbb --fb=#1a2127 --ff=#8fbcbb --nb=#1a2127 --nf=#d8dee9 --hb=#1a2127 --hf=#a3be8c --scf=#ebdbb2"

# Font
font="Hack 8"
line_height=20

while true; do
	user_choice=$(print_todos | BEMENU_BACKEND=$backend bemenu --ignorecase --prompt "$prompt" --line-height=$line_height --fn="$font" $colors -l 5 --wrap --scrollbar=autohide $@ )
	
	if grep -Fxq "$user_choice" "$TODO_FILE"; then
		remove_todo "$user_choice"
	elif [ "$user_choice" = "" ]; then
		exit 0
	else
		add_todo "$user_choice"
	fi
done
