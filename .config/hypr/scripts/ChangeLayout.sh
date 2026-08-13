#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Toggle between the dwindle and master layouts
#
# NOTE: `hyprctl keyword` (including `keyword bind` / `keyword unbind`) was
# removed when the config moved to Lua. Everything now goes through
# `hyprctl eval` with the hl.* API.

notif="$HOME/.config/swaync/images/ja.png"

LAYOUT=$(hyprctl -j getoption general.layout | jq -r '.str')

if [ "$LAYOUT" == "master" ]; then
	hyprctl eval '
		hl.config({ general = { layout = "dwindle" } })
		hl.unbind("SUPER + J")
		hl.unbind("SUPER + K")
		hl.bind("SUPER + J", hl.dsp.window.cycle_next())
		hl.bind("SUPER + K", hl.dsp.window.cycle_next({ next = false }))
		hl.bind("SUPER + O", hl.dsp.layout("togglesplit"))
	' >/dev/null
	notify-send -e -u low -i "$notif" "Layout" "dwindle"
else
	hyprctl eval '
		hl.config({ general = { layout = "master" } })
		hl.unbind("SUPER + J")
		hl.unbind("SUPER + K")
		hl.unbind("SUPER + O")
		hl.bind("SUPER + J", hl.dsp.layout("cyclenext"))
		hl.bind("SUPER + K", hl.dsp.layout("cycleprev"))
	' >/dev/null
	notify-send -e -u low -i "$notif" "Layout" "master"
fi
