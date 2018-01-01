#!/bin/sh

export DISPLAY=:0.0
export XAUTHORITY=/home/$1/.Xauthority

HOSTNAME=$(hostname)

# Config for HP ProBook 6465 with dockstation
# External display connected via dockstation's DP
if [ "$HOSTNAME" = "mln-probook" ]; then
    # Check if laptop is placed in dockstation
    if [ `cat /sys/devices/platform/hp-wmi/dock` -eq 0 ]; then
        xrandr --output VGA-0 --off --output LVDS --mode 1600x900 --pos 0x0 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output DisplayPort-0 --off >> /dev/null 2>&1
    else
        xrandr --output VGA-1 --off --output LVDS-1 --off --output DP-2 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-3 --off --output DP-1 --off
    fi
# Generic config for two displays on VGA-0 and VGA-1
else
    xrandr --output VGA-1 --auto --left-of VGA-0
fi
