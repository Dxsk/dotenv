#!/bin/bash
# Power menu for rofi

if [ -z "$1" ]; then
    echo "⏻  Shutdown"
    echo "  Reboot"
    echo "  Lock"
    echo "󰤄  Suspend"
    echo "  Logout"
else
    case "$1" in
        *Shutdown) systemctl poweroff ;;
        *Reboot) systemctl reboot ;;
        *Lock) hyprlock ;;
        *Suspend) systemctl suspend ;;
        *Logout) hyprctl dispatch exit ;;
    esac
fi
