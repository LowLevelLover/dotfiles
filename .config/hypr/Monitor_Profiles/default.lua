-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- default Monitor profile
--
-- Copied over UserConfigs/Monitors.lua by scripts/MonitorProfiles.sh.
-- https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Use `hyprctl monitors` to get resolution / offset / scale info.

-- Catch-all: preferred mode, auto position, scale 1
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1, bitdepth = 8 })

-- Some examples to set your own monitor
-- hl.monitor({ output = "eDP-1",     mode = "preferred",      position = "auto", scale = 1 })
-- hl.monitor({ output = "eDP-1",     mode = "2560x1440@165",  position = "0x0",  scale = 1 })
-- hl.monitor({ output = "DP-3",      mode = "1920x1080@240",  position = "auto", scale = 1 })
-- hl.monitor({ output = "HDMI-A-1",  mode = "preferred",      position = "auto", scale = 1 })

-- High refresh rate / high resolution shorthands
-- hl.monitor({ output = "", mode = "highrr",  position = "auto", scale = 1 })
-- hl.monitor({ output = "", mode = "highres", position = "auto", scale = 1 })

-- QEMU-KVM, VirtualBox or VMware
-- hl.monitor({ output = "Virtual-1", mode = "1920x1080@60", position = "auto", scale = 1 })

-- to disable a monitor
-- hl.monitor({ output = "eDP-1", disabled = true })

-- Mirror samples
-- hl.monitor({ output = "DP-3", mode = "1920x1080@60", position = "0x0", scale = 1, mirror = "DP-2" })
-- hl.monitor({ output = "",     mode = "preferred",    position = "auto", scale = 1, mirror = "eDP-1" })

-- 10 bit monitor support
-- https://wiki.hypr.land/Configuring/Basics/Monitors/#10-bit-support
-- NOTE: colors registered in Hyprland (e.g. the border color) do not support 10 bit.
-- NOTE: some applications cannot screen capture with 10 bit enabled (OBS may render black).
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1, bitdepth = 10 })

-- hl.monitor({ output = "eDP-1", transform = 0 })
-- hl.monitor({ output = "eDP-1", reserved = { top = 10, right = 10, bottom = 10, left = 49 } })

-- NOTE: for laptops, see the notes in UserConfigs/Laptops.lua regarding display
-- handling on lid close. See https://github.com/hyprwm/Hyprland/issues/4090
-- Workspace <-> monitor rules live in UserConfigs/WorkspaceRules.lua
