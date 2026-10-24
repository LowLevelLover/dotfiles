#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for changing blur on the fly
#
# NOTE: `hyprctl keyword` was removed when the config moved to Lua.
# Options are now set with `hyprctl eval` + hl.config(), and read with
# `hyprctl getoption` using dot-separated names (decoration.blur.passes).

notif="$HOME/.config/hypr/icons"

STATE=$(hyprctl -j getoption decoration.blur.passes | jq ".int")

if [ "${STATE}" == "2" ]; then
	hyprctl eval 'hl.config({ decoration = { blur = { size = 2, passes = 1 } } })' >/dev/null
	notify-send -e -u low -i "$notif/note.png" " Less Blur"
else
	hyprctl eval 'hl.config({ decoration = { blur = { size = 5, passes = 2 } } })' >/dev/null
	notify-send -e -u low -i "$notif/ja.png" " Normal Blur"
fi
