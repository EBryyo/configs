#!/usr/bin/env bash

DIR="$HOME/Pictures/wallpapers/"
MONITOR="eDP-1"

while true; do
  WALL=$(find "$DIR" -type f | shuf -n 1)
  hyprctl hyprpaper wallpaper "$MONITOR,$WALL"
  sleep 300
done
