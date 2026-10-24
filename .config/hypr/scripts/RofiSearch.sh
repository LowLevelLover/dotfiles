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

# Ask in Noctalia's launcher. With no candidates on stdin it returns whatever is
# typed; Esc prints nothing and exits 1.
query=$(noctalia dmenu -p "Search" </dev/null) || exit 0
[[ -n "$query" ]] || exit 0

# URL-encode the query so &, #, + and spaces survive, then open it in the default browser
xdg-open "${Search_Engine//\{\}/$(jq -rn --arg q "$query" '$q | @uri')}"
