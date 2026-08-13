#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# For disabling / enabling the touchpad.
#
# Edit Touchpad_Device in ~/.config/hypr/UserConfigs/Laptops.lua to match your
# system -- use `hyprctl devices` to find the name.
#
# NOTE: this used to toggle a hyprlang variable via `hyprctl keyword`. Since the
# config moved to Lua, `hyprctl keyword` no longer exists; the device is
# reconfigured directly with `hyprctl eval` instead.

notif="$HOME/.config/swaync/images/ja.png"

# Keep this in sync with UserConfigs/Laptops.lua
TOUCHPAD_DEVICE="asue120d:00-04f3:31fb-touchpad"

export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

set_touchpad() {
    # $1 -> "true" | "false"
    hyprctl eval "hl.device({ name = \"${TOUCHPAD_DEVICE}\", enabled = $1 })" >/dev/null
}

enable_touchpad() {
    printf "true" >"$STATUS_FILE"
    notify-send -u low -i "$notif" " Enabling" " touchpad"
    set_touchpad true
}

disable_touchpad() {
    printf "false" >"$STATUS_FILE"
    notify-send -u low -i "$notif" " Disabling" " touchpad"
    set_touchpad false
}

if ! [ -f "$STATUS_FILE" ]; then
  enable_touchpad
else
  if [ "$(cat "$STATUS_FILE")" = "true" ]; then
    disable_touchpad
  elif [ "$(cat "$STATUS_FILE")" = "false" ]; then
    enable_touchpad
  fi
fi
