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
  hl.exec_cmd("ags")
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

  hl.exec_cmd("hyprdim")

  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Amber 24")
end)

-- NOTE: polkit authentication agent
-- The old .conf ran scripts/Polkit.sh and `systemctl --user start hyprpolkitagent`.
-- Polkit.sh only probes FHS paths (/usr/lib, /usr/libexec) and is a no-op on
-- NixOS. hyprpolkitagent is now started declaratively as a systemd user service
-- bound to hyprland-session.target -- see nixos-config/configuration.nix -- so
-- there is nothing to launch from here.

-- NOTE: xdg-desktop-portal-hyprland
-- The old .conf ran scripts/PortalHyprland.sh at every startup. On NixOS that
-- script is actively harmful: it `killall`s xdg-desktop-portal and
-- xdg-desktop-portal-hyprland, then tries to restart them from /usr/lib and
-- /usr/libexec, which do not exist here -- so it killed the portal and left it
-- dead. The portal is D-Bus activated and systemd-managed on NixOS; it must not
-- be started by hand.
