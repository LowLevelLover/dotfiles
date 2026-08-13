-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Monitor configuration
-- https://wiki.hypr.land/Configuring/Basics/Monitors/
--
-- NOTE: nwg-displays used to write ~/.config/hypr/monitors.conf. It does not
-- know about the Lua config, so it will keep writing that .conf file and the
-- result will be ignored. Edit this file by hand instead (or re-apply the
-- values nwg-displays reports).
--
-- Previous monitors.conf:
--   monitor=eDP-1,2560x1600@240.0,auto,1.25,bitdepth,8

hl.monitor({
  output   = "eDP-1",
  mode     = "2560x1600@240.0",
  position = "auto",
  scale    = 1.25,
  bitdepth = 8,
})

-- Fallback for any other/unknown output
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "auto",
})
