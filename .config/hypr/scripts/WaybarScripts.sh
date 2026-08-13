#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
# This file used on waybar modules sourcing defaults set in $HOME/.config/hypr/UserConfigs/01-UserDefaults.conf

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

term=$(lua_default term)
files=$(lua_default files)
Search_Engine=$(lua_default search_engine)

# Check if $term is set correctly
if [[ -z "$term" ]]; then
    echo "Error: \$term is not set in the configuration file!"
    exit 1
fi

# Execute accordingly based on the passed argument
if [[ "$1" == "--btop" ]]; then
    $term --title btop sh -c 'btop'
elif [[ "$1" == "--nvtop" ]]; then
    $term --title nvtop sh -c 'nvtop'
elif [[ "$1" == "--nmtui" ]]; then
    $term nmtui
elif [[ "$1" == "--term" ]]; then
    $term &
else
    echo "Usage: $0 [--btop | --nvtop | --nmtui | --term]"
    echo "--btop       : Open btop in a new term"
    echo "--nvtop      : Open nvtop in a new term"
    echo "--nmtui      : Open nmtui in a new term"
    echo "--term   : Launch a term window"
fi
