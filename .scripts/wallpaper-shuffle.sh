#!/usr/bin/env bash

DIR="$HOME/Pictures/wallpapers/"
MONITOR="eDP-1"

WALL=$(find "$DIR" -type f | shuf -n 1)
hyprctl hyprpaper wallpaper "$MONITOR,$WALL"
