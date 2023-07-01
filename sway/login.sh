#!/bin/bash
### Login script
export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export XDG_CURRENT_DESKTOP=sway
# Faster!
#export WLC_BG=0

exec dbus-run-session sway --unsupported-gpu 1>"/home/phil/.config/sway/sway.log" 2>"/home/phil/.config/sway/errors.log"
#exec dbus-launch --sh-syntax --exit-with-session sway --unsupported-gpu "$@"

# Sway on Nvidia:
#export QT_AUTO_SCREEN_SCALE_FACTOR=1
#export QT_QPA_PLATFORM=wayland
#export QT_QPA_PLATFORMTHEME=kvantum
#export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
##export GDK_BACKEND=wayland
#export XDG_CURRENT_DESKTOP=sway
#export _JAVA_AWT_WM_NONREPARENTING=1
#
#export GBM_BACKEND=nvidia-drm
#export __GLX_VENDOR_LIBRARY_NAME=nvidia
#export MOZ_ENABLE_WAYLAND=1
#export WLR_NO_HARDWARE_CURSORS=1
#
#exec dbus-run-session sway --unsupported-gpu
