#!/bin/bash
#
#########################################
# Wayland Session environment variables #
#########################################
#

[ $XDG_SESSION_TYPE == "wayland" ] || exit 0

export MOZ_ENABLE_WAYLAND=1
