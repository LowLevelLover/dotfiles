-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Commands and apps to be executed at launch
-- https://wiki.hypr.land/Configuring/Basics/Autostart/

local HOME       = os.getenv("HOME")
local scriptsDir = HOME .. "/.config/hypr/scripts"

hl.on("hyprland.start", function()
  -- wallpaper: awww draws it, variety picks and rotates it
  hl.exec_cmd("awww-daemon --format xrgb")
  hl.exec_cmd("variety")

  -- Noctalia shell: bar, notifications + OSD, launcher, clipboard, control
  -- center, session menu, lock + idle and the polkit agent. noctalia.service is
  -- pulled in by graphical-session.target, but that can fire before
  -- WAYLAND_DISPLAY reaches the systemd user environment. Restarting it here
  -- guarantees a usable Wayland connection. exec_cmd calls run concurrently, so
  -- the export runs in the same command to land before the restart. --all
  -- because apps started from Noctalia's launcher get the systemd env, not
  -- Hyprland's: without it they'd miss ENVariables.lua (cursor, GDK/Qt/Electron
  -- Wayland hints) and HYPRLAND_INSTANCE_SIGNATURE, which Noctalia needs for
  -- Hyprland IPC.
  hl.exec_cmd("dbus-update-activation-environment --systemd --all && systemctl --user restart noctalia.service")

  -- startup apps
  hl.exec_cmd("rog-control-center")

  -- battery profile: 60 Hz + no blur/shadow on battery, restored on AC
  hl.exec_cmd(scriptsDir .. "/PowerWatch.sh")

  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Amber 24")
end)

-- NOTE: xdg-desktop-portal-hyprland is D-Bus activated and systemd-managed on
-- NixOS; do not start or kill it by hand.
