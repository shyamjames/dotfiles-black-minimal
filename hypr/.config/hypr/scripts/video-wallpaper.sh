#!/usr/bin/env bash
set -euo pipefail

# Video wallpaper controller
# - Plays a video with mpv in a loop when on AC power
# - Pauses mpv and falls back to a static frame (via swww) when on battery

VIDEO="$HOME/Videos/bmw-m4.mp4"
MPV_PIDFILE="/tmp/mpv-wallpaper.pid"
FRAME="/tmp/wallpaper-frame.jpg"

start_mpv() {
  if ! pgrep -x mpv >/dev/null; then
    # Wayland-optimized flags for wallpaper mode:
    # --loop=inf: infinite loop
    # --no-audio: disable sound
    # --no-osd-bar: hide on-screen display
    # --no-input-default-bindings: disable default key bindings
    # --input-vo-keyboard=no: disable keyboard input
    # --fullscreen=yes: fullscreen mode
    mpv \
      --loop=inf \
      --no-audio \
      --no-osd-bar \
      --no-input-default-bindings \
      --input-vo-keyboard=no \
      --fullscreen=yes \
      "$VIDEO" >/dev/null 2>&1 &
    echo $! > "$MPV_PIDFILE"
  fi
}

pause_mpv() {
  if pgrep -x mpv >/dev/null; then
    pkill -STOP mpv || true
  fi
}

resume_mpv() {
  if pgrep -x mpv >/dev/null; then
    pkill -CONT mpv || true
  fi
}

stop_mpv() {
  if [ -f "$MPV_PIDFILE" ]; then
    kill "$(cat "$MPV_PIDFILE")" 2>/dev/null || true
    rm -f "$MPV_PIDFILE"
  else
    pkill mpv || true
  fi
}

set_frame() {
  # extract a single frame from the video (requires ffmpeg)
  if command -v ffmpeg >/dev/null 2>&1; then
    ffmpeg -y -ss 5 -i "$VIDEO" -vframes 1 "$FRAME" >/dev/null 2>&1 || true
    if [ -f "$FRAME" ]; then
      # swaybg will set the static wallpaper
      swaybg -i "$FRAME" -m fill >/dev/null 2>&1 &
    fi
  fi
}

main_loop() {
  # initial state
  if systemd-ac-power; then
    start_mpv
    resume_mpv
  else
    # on battery: ensure mpv is started (so user can resume when plugged in)
    start_mpv
    pause_mpv
    set_frame
  fi

  while true; do
    if systemd-ac-power; then
      resume_mpv
    else
      pause_mpv
      set_frame
    fi
    sleep 10
  done
}

main_loop
