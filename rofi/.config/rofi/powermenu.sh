#!/bin/bash

# Options
lock=" Lock"
logout="󰗽 Logout"
suspend="󰤄 Suspend"
reboot="󰜉 Reboot"
shutdown=" Shutdown"

# Variable passed to rofi
options="$lock\n$logout\n$suspend\n$reboot\n$shutdown"

selected_option=$(echo -e "$options" | rofi -dmenu -i -p "Power" -theme-str 'window {width: 20%;} listview {lines: 6;}')

case $selected_option in
    $lock)
        hyprlock ;;
    $logout)
        hyprctl dispatch exit ;;
    $suspend)
        systemctl suspend ;;
    $reboot)
        systemctl reboot ;;
    $shutdown)
        systemctl poweroff ;;
esac
