-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Commands and apps to be executed at launch
-- https://wiki.hypr.land/Configuring/Basics/Autostart/

local HOME        = os.getenv("HOME")
local scriptsDir  = HOME .. "/.config/hypr/scripts"
local UserScripts = HOME .. "/.config/hypr/UserScripts"

-- local wallDIR     = HOME .. "/Pictures/wallpapers"
-- local SwwwRandom  = UserScripts .. "/WallpaperAutoChange.sh"

hl.on("hyprland.start", function()
  -- wallpaper stuff
  -- NOTE: this system has `awww` installed, not `swww` (awww is the maintained
  -- fork; see nixos-config/configuration.nix). The old .conf launched
  -- `swww-daemon`, which does not exist here, so the wallpaper daemon never
  -- started.
  hl.exec_cmd("awww-daemon --format xrgb")
  hl.exec_cmd("variety")

  -- random wallpaper switcher every 30 minutes
  -- hl.exec_cmd(SwwwRandom .. " " .. wallDIR)

  -- Startup: export the Wayland session env to systemd + D-Bus.
  -- Hyprland already does this itself unless HYPRLAND_NO_SD_VARS is set, but
  -- these are harmless and cover D-Bus activation of user services.
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

  -- Polkit authentication agent. The unit is declared in configuration.nix and
  -- is pulled in by graphical-session.target, but that can fire before
  -- WAYLAND_DISPLAY reaches the systemd user environment -- which is exactly
  -- how the old Qt agent crash-looped itself into the start limit. Restarting
  -- it here, right after the import above, guarantees it comes up with a
  -- usable Wayland connection. Restarting an already-healthy unit is cheap.
  hl.exec_cmd("systemctl --user restart hyprpolkitagent")

  -- startup apps
  hl.exec_cmd("nm-applet --indicator")
  hl.exec_cmd("swaync")
  -- NOTE: `ags` removed. The installed ags is v2 (Astal), where a bare `ags`
  -- only prints help; ~/.config/ags is an AGS v1 config, so it never ran.
  hl.exec_cmd("blueman-applet")
  hl.exec_cmd("rog-control-center")
  hl.exec_cmd("waybar")

  -- clipboard manager
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")

  -- Rainbow borders
  hl.exec_cmd(UserScripts .. "/RainbowBorders.sh")

  -- hypridle, to drive hyprlock
  hl.exec_cmd("hypridle")

  -- NOTE: `hyprdim` removed. It crashes on start against the Lua config
  -- (hyprland-rs cannot parse decoration:dim_inactive), and
  -- decoration.dim_inactive in UserDecorations.lua already dims inactive windows.

  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Amber 24")
end)

-- NOTE: xdg-desktop-portal-hyprland is D-Bus activated and systemd-managed on
-- NixOS; do not start or kill it by hand (the old PortalHyprland.sh did, and
-- left the portal dead).
