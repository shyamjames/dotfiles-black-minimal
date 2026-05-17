#!/bin/bash

# Path to the video wallpaper
WALLPAPER="$HOME/dotfiles-black-minimal/wallpapers/bmw-m4.mp4"
# MPV socket for IPC
SOCKET="/tmp/mpv-wallpaper-socket"
# Battery path (adjust BAT1 if necessary)
BATTERY_STATUS="/sys/class/power_supply/BAT1/status"

# Kill existing mpvpaper instances
pkill mpvpaper

# Start mpvpaper in the background with IPC enabled
# Using 'ALL' to cover all monitors
mpvpaper -o "input-ipc-server=$SOCKET --loop --no-audio" ALL "$WALLPAPER" &

# Wait for socket to be created
sleep 2

while true; do
    if [ -f "$BATTERY_STATUS" ]; then
        STATUS=$(cat "$BATTERY_STATUS")
        if [ "$STATUS" = "Discharging" ]; then
            # Pause if discharging
            echo '{ "command": ["set_property", "pause", true] }' | socat - "$SOCKET" > /dev/null 2>&1
        else
            # Resume if charging or full
            echo '{ "command": ["set_property", "pause", false] }' | socat - "$SOCKET" > /dev/null 2>&1
        fi
    fi
    sleep 10
done
