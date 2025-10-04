#!/bin/bash
HYPR_CONF="$HOME/.config/hypr/keyboard/binds.conf"

# extract the keybinding from hyprland.conf (versione semplificata)
mapfile -t BINDINGS < <(grep -E '^[[:space:]]*bind[[:space:]]*=' "$HYPR_CONF" | \
    sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*/ /g' -e 's/bind[[:space:]]*=[[:space:]]*//' -e 's/, /,/g' -e 's/ # /,/' | \
    awk -F, '{cmd=""; for(i=3;i<=NF;i++) cmd=cmd $(i) " "; gsub(/^[ \t]+|[ \t]+$/, "", cmd); print $1 " + " $2 " - " $NF " - " cmd}')

if [ ${#BINDINGS[@]} -eq 0 ]; then
    echo "No keybindings found!" | wofi --dmenu -p "Error"
    exit 1
fi

CHOICE=$(printf '%s\n' "${BINDINGS[@]}" | wofi --dmenu -i -p "Hyprland Keybinds:")

# extract the command part (everything after the last " - ")
CMD=$(echo "$CHOICE" | sed 's/.* - //')

# Clean up the command
CMD=$(echo "$CMD" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# execute it if first word is exec else use hyprctl dispatch
if [[ $CMD == exec* ]]; then
    eval "$CMD"
elif [[ -n "$CMD" ]]; then
    hyprctl dispatch "$CMD"
fi
