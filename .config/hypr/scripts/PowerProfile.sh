#!/usr/bin/env bash
# Battery-aware display profile for Hyprland.
#
#   battery  60 Hz, 8-bit colour, no blur / shadow / dim_inactive
#   ac       `hyprctl reload`, which restores everything from the Lua config
#            (240 Hz, 10-bit, blur, ...)
#
# Usage: PowerProfile.sh [auto|battery|ac]   (default: auto)
#
# PowerWatch.sh runs this on every AC plug/unplug. Calling it by hand sticks
# until the next plug event.
#
# The overrides go through `hyprctl eval`. The monitor line mirrors
# UserConfigs/Monitors.lua, minus the refresh rate and bit depth.

mode=${1:-auto}
notif="$HOME/.config/hypr/icons/ja.png"
# Keyed by Hyprland instance so a restarted compositor starts from a clean slate
state_file="${XDG_RUNTIME_DIR:-/tmp}/hypr-power-profile-${HYPRLAND_INSTANCE_SIGNATURE:-none}"

# True when any non-battery supply (AC adapter or USB-C PD source) is online
on_ac() {
    local ps
    for ps in /sys/class/power_supply/*; do
        [ "$(cat "$ps/type" 2>/dev/null)" = "Battery" ] && continue
        [ "$(cat "$ps/online" 2>/dev/null)" = "1" ] && return 0
    done
    return 1
}

if [ "$mode" = "auto" ]; then
    if on_ac; then mode=ac; else mode=battery; fi
fi

previous=$(cat "$state_file" 2>/dev/null)
[ "$previous" = "$mode" ] && exit 0

case "$mode" in
battery)
    hyprctl eval '
        hl.monitor({ output = "eDP-1", mode = "2560x1600@60.0", position = "auto", scale = 1.25, bitdepth = 8 })
        hl.config({
            decoration = {
                blur         = { enabled = false },
                shadow       = { enabled = false },
                dim_inactive = false,
            },
        })
    ' >/dev/null
    msg="battery: 60 Hz, effects off"
    ;;
ac)
    # No previous state means Hyprland just started with the full config
    if [ -n "$previous" ]; then
        hyprctl reload >/dev/null
    fi
    msg="AC: 240 Hz, effects on"
    ;;
*)
    echo "usage: ${0##*/} [auto|battery|ac]" >&2
    exit 1
    ;;
esac

echo "$mode" >"$state_file"
[ -n "$previous" ] && notify-send -e -u low -i "$notif" "Power profile" "$msg"
exit 0
