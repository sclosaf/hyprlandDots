#!/bin/bash

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"

mapfile -t BINDINGS < <(grep '^bind=' "$HYPR_CONF" | \
    sed -e 's/  */ /g' -e 's/bind=//g' -e 's/, /,/g' -e 's/ # /,/' | \
    awk -F, '{cmd=""; for(i=3;i<NF;i++) cmd=cmd $(i) " ";print $1 " + " $2 " - " $NF " - " cmd}')

CHOICE=$(printf '%s\n' "${BINDINGS[@]}" | wofi --dmenu -i -p "Hyprland Keybinds:")

CMD=$(echo "$CHOICE" | sed 's/.* - //')

if [[ $CMD == exec* ]]; then
    eval "$CMD"
else
    hyprctl dispatch "$CMD"
fi
