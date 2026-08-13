#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Wallust colors for the current wallpaper
#
# NOTE: this system uses `awww` (the maintained swww fork), which caches under
# ~/.cache/awww/<version>/<output> rather than ~/.cache/swww/<output>.
# Both layouts are handled below, newest first.

# Locate the wallpaper cache directory
cache_dir=""
for d in "$HOME"/.cache/awww/*/; do
    [ -d "$d" ] && cache_dir="$d"   # last match wins => highest version
done
[ -z "$cache_dir" ] && [ -d "$HOME/.cache/swww" ] && cache_dir="$HOME/.cache/swww/"

if [ -z "$cache_dir" ]; then
    echo "No awww/swww cache directory found -- is the wallpaper daemon running?" >&2
    exit 1
fi

# Initialize a flag to determine if the ln command was executed
ln_success=false

# Get current focused monitor
current_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')
echo "$current_monitor"

# Construct the full path to the cache file
cache_file="${cache_dir}${current_monitor}"
echo "$cache_file"

# Check if the cache file exists for the current monitor output
if [ -f "$cache_file" ]; then
    # Extract the image path. awww writes " crop:center Lanczos3 /path" while
    # swww wrote NUL-separated "\0Lanczos3\0/path\0" -- the path is the last
    # field either way once NULs are turned into spaces.
    wallpaper_path=$(tr '\0' ' ' < "$cache_file" | awk '{print $NF}')
    echo "$wallpaper_path"

    if [ -n "$wallpaper_path" ] && [ -f "$wallpaper_path" ]; then
        # symlink the wallpaper to the location Rofi can access
        if ln -sf "$wallpaper_path" "$HOME/.config/rofi/.current_wallpaper"; then
            ln_success=true
        fi
        # copy the wallpaper for wallpaper effects
        cp -r "$wallpaper_path" "$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"
    fi
fi

# Check the flag before executing further commands
if [ "$ln_success" = true ]; then
    echo 'about to execute wallust'
    # execute wallust, skipping tty and terminal changes
    wallust run "$wallpaper_path" -s &
fi
