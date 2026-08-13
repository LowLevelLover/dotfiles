#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# searchable enabled keybinds using rofi
#
# NOTE: this used to grep `^bind` out of the .conf files. The config is Lua now,
# so keybinds are read from the compositor with `hyprctl binds` instead -- that
# lists what is actually registered (including binds added at runtime) and picks
# up the `description` field set on each bind.

# kill yad to not interfere with this binds
pkill yad || true

# check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

rofi_theme="$HOME/.config/rofi/config-keybinds.rasi"
msg='☣️ NOTE ☣️: Clicking with Mouse or Pressing ENTER will have NO function'

# Build "MODS + KEY   ->   description / dispatcher" lines from hyprctl.
keybinds=$(hyprctl -j binds | jq -r '
  # modmask bits -> readable names
  def mods(m):
    [ if (m % 2)        >= 1 then "SHIFT" else empty end
    , if (m / 4  | floor) % 2 == 1 then "CTRL"  else empty end
    , if (m / 8  | floor) % 2 == 1 then "ALT"   else empty end
    , if (m / 64 | floor) % 2 == 1 then "SUPER" else empty end
    ] | join(" + ");

  .[]
  | . as $b
  | (mods($b.modmask)) as $m
  | (if ($b.key // "") != "" then $b.key
     elif ($b.keycode // 0) > 0 then "code:\($b.keycode)"
     else "?" end) as $k
  # `arg` is an internal handle in the Lua API, so fall back to the dispatcher
  # name (HL.Dispatcher(exec_cmd) -> exec_cmd) when no description is set.
  | (if ($b.description // "") != "" then $b.description
     else ($b.dispatcher | sub("^HL.Dispatcher\\("; "") | sub("\\)$"; "")) end) as $desc
  | (if $m != "" then "\($m) + \($k)" else $k end) as $combo
  | "\($combo)	->	\($desc)"
' 2>/dev/null | sort -u)

# check for any keybinds to display
if [[ -z "$keybinds" ]]; then
    echo "no keybinds found."
    exit 1
fi

# use rofi to display the keybinds
echo "$keybinds" | rofi -dmenu -i -config "$rofi_theme" -mesg "$msg"
