#!/bin/sh
# game-on: pre-launch gaming settings

# Turn off built-in touchpad
xinput disable 13
# Set the CPU governor to "powersave" (otherwise it will reach very high temperatures)
echo $(kdialog --password "sudo password required" 2>/dev/null) | sudo -S -u root -- cpupower frequency-set --governor powersave
