#!/usr/bin/env bash
set -euo pipefail

# Monitor AC power and pause/resume mpvpaper accordingly
# - On AC power: mpvpaper runs normally
# - On battery: mpvpaper is paused (suspended)

MPVPAPER_PIDFILE="/tmp/mpvpaper.pid"
LAST_STATE=""

monitor_power() {
  while true; do
    if systemd-ac-power >/dev/null 2>&1; then
      # On AC power
      if [ "$LAST_STATE" != "ac" ]; then
        echo "[$(date '+%H:%M:%S')] AC power detected, resuming mpvpaper"
        pkill -CONT mpvpaper 2>/dev/null || true
        LAST_STATE="ac"
      fi
    else
      # On battery
      if [ "$LAST_STATE" != "battery" ]; then
        echo "[$(date '+%H:%M:%S')] Battery power detected, pausing mpvpaper"
        pkill -STOP mpvpaper 2>/dev/null || true
        LAST_STATE="battery"
      fi
    fi
    sleep 5
  done
}

monitor_power
