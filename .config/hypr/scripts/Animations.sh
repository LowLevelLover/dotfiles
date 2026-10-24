#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# For applying Animations from different users

# Variables
iDIR="$HOME/.config/hypr/icons"
animations_dir="$HOME/.config/hypr/animations"
UserConfigs="$HOME/.config/hypr/UserConfigs"
# list of animation presets, sorted alphabetically with numbers first
animations_list=$(find -L "$animations_dir" -maxdepth 1 -type f -name '*.lua' | sed 's/.*\///' | sed 's/\.lua$//' | sort -V)

# Menu (Noctalia launcher); the chosen preset is copied into UserAnimations.lua,
# and Hyprland reloads by itself because hyprland.lua require()s that file.
chosen_file=$(echo "$animations_list" | noctalia dmenu -p "Animations")

# Check if a preset was selected (Enter on text that matches nothing returns the text)
full_path="$animations_dir/$chosen_file.lua"
if [[ -n "$chosen_file" && -f "$full_path" ]]; then
    cp "$full_path" "$UserConfigs/UserAnimations.lua"
    notify-send -u low -i "$iDIR/ja.png" "$chosen_file" "Hyprland Animation Loaded"
fi
