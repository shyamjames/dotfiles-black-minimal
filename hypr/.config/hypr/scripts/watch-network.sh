#!/bin/bash
# ==========================================
# Network Watcher — launched by Hyprland
# Monitors NM events and shows rofi prompt
# when connected to captive portal networks.
# ==========================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

if [ ! -f "$ENV_FILE" ]; then
    notify-send "Rajagiri Network" "Missing .env file at $ENV_FILE"
    exit 1
fi

source "$ENV_FILE"

TARGET_SSIDS=("RAJAGIRI" "ASSUMPTION")

show_prompt() {
    local ssid="$1"
    CHOICE=$(echo -e "Yes\nNo" | rofi -dmenu -p "Login as $USERNAME on $ssid?" -l 2 -selected-row 0)
    ROFI_EXIT=$?

    if [ $ROFI_EXIT -eq 0 ] && [ "$CHOICE" = "Yes" ]; then
        "$SCRIPT_DIR/login.sh"
    fi
}

# Monitor NetworkManager connection events
nmcli monitor | while read -r line; do
    # Trigger on "connected" state changes
    if echo "$line" | grep -qi "connected"; then
        sleep 1  # brief wait for IP to settle
        CURRENT_SSID=$(iwgetid -r 2>/dev/null)
        for ssid in "${TARGET_SSIDS[@]}"; do
            if [ "$CURRENT_SSID" = "$ssid" ]; then
                show_prompt "$CURRENT_SSID"
                break
            fi
        done
    fi
done
