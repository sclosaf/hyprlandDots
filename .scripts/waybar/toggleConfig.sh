#!/bin/bash

WAYBAR_DIR="$HOME/.config/waybar"
TOPBAR_CONFIG="$WAYBAR_DIR/topbar/config.jsonc"
TOPBAR_STYLE="$WAYBAR_DIR/topbar/style.css"
SIDEBAR_CONFIG="$WAYBAR_DIR/sidebar/config.jsonc"
SIDEBAR_STYLE="$WAYBAR_DIR/sidebar/style.css"

getCurrentConfig()
{
    pgrep -fa "waybar.*-c.*sidebar" > /dev/null && echo "sidebar" || echo "topbar"
}

switchConfig()
{
    local currentConfig=$(getCurrentConfig)
    
    pkill -x waybar
    
    if [[ "$currentConfig" == "topbar" ]]; then
        waybar -c "$SIDEBAR_CONFIG" -s "$SIDEBAR_STYLE" &
    else
        waybar -c "$TOPBAR_CONFIG" -s "$TOPBAR_STYLE" &
    fi
}

switchConfig
