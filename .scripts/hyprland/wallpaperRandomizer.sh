#!/bin/bash

DIR="$HOME/.wallpapers/hyprpaper"
MAX=3
CONFIG="$HOME/.config/hypr/hyprpaper.conf"

X=$(( (RANDOM % MAX) + 1 ))
WALL="$DIR/wallpaper${X}.png"

cat > "$CONFIG" <<EOF
preload = $WALL
wallpaper = ,$WALL
EOF
