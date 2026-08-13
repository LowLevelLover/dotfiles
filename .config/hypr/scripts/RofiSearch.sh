#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# For Searching via web browsers

# Define the path to the config file
# NOTE: defaults moved from 01-UserDefaults.conf (hyprlang) to
# 01-UserDefaults.lua when the Hyprland config moved to Lua.
config_file=$HOME/.config/hypr/UserConfigs/01-UserDefaults.lua

# Check if the config file exists
if [[ ! -f "$config_file" ]]; then
    echo "Error: Configuration file not found!"
    exit 1
fi

# Pull a `key = "value",` entry out of the Lua defaults table
lua_default() {
    sed -n "s/^[[:space:]]*$1[[:space:]]*=[[:space:]]*\"\([^\"]*\)\".*$/\1/p" "$config_file" | head -n1
}

Search_Engine=$(lua_default search_engine)
term=$(lua_default term)
files=$(lua_default files)

# Check if $term is set correctly
if [[ -z "$Search_Engine" ]]; then
    echo "Error: \$Search_Engine is not set in the configuration file!"
    exit 1
fi

# Rofi theme and message
rofi_theme="$HOME/.config/rofi/config-search.rasi"
msg='‼️ **note** ‼️ search via default web browser'

# Kill Rofi if already running before execution
if pgrep -x "rofi" >/dev/null; then
    pkill rofi
fi

# Open Rofi and pass the selected query to xdg-open for Google search
echo "" | rofi -dmenu -config "$rofi_theme" -mesg "$msg" | xargs -I{} xdg-open $Search_Engine
