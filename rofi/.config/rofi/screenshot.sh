#!/bin/bash

# Options
screen="󰹑 Fullscreen"
area="󰆞 Selected Area"
window="󱂬 Active Window"

# Variable passed to rofi
options="$screen\n$area\n$window"

selected_option=$(echo -e "$options" | rofi -dmenu -i -p "Screenshot" -theme-str 'window {width: 25%;} listview {lines: 3;}')

case $selected_option in
    $screen)
        hyprshot -m output -o ~/Pictures/screenshots ;;
    $area)
        hyprshot -m region -o ~/Pictures/screenshots ;;
    $window)
        hyprshot -m window -o ~/Pictures/screenshots ;;
esac
