#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Game Mode. Turning off all animations and eye candy.
#
# NOTE: `hyprctl keyword` / `hyprctl --batch keyword` were removed when the
# config moved to Lua. A single `hyprctl eval` now applies the whole block.
# The wallpaper daemon here is `awww` (this system has awww, not swww).

notif="$HOME/.config/swaync/images/ja.png"
SCRIPTSDIR="$HOME/.config/hypr/scripts"

# NOTE: boolean options report a `bool` field now (the old hyprlang build
# reported them as `int: 1`).
HYPRGAMEMODE=$(hyprctl -j getoption animations.enabled | jq -r '.bool')

if [ "$HYPRGAMEMODE" = "true" ]; then
	hyprctl eval '
		hl.config({
			animations = { enabled = false },
			decoration = {
				shadow   = { enabled = false },
				blur     = { enabled = false },
				rounding = 0,
			},
			general = {
				gaps_in     = 0,
				gaps_out    = 0,
				border_size = 1,
			},
		})
		hl.window_rule({
			name    = "gamemode-opaque",
			match   = { class = ".*" },
			opacity = "1 override 1 override 1 override",
		})
	' >/dev/null

	awww kill
	notify-send -e -u low -i "$notif" " Gamemode:" " enabled"
else
	awww-daemon --format xrgb && awww img "$HOME/.config/rofi/.current_wallpaper" &
	sleep 0.1
	"${SCRIPTSDIR}/WallustSwww.sh"
	sleep 0.5
	"${SCRIPTSDIR}/Refresh.sh"

	# Reload drops the runtime overrides above and restores hyprland.lua
	hyprctl reload >/dev/null
	notify-send -e -u normal -i "$notif" " Gamemode:" " disabled"
fi
