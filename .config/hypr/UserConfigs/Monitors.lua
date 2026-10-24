-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Monitor configuration
-- https://wiki.hypr.land/Configuring/Basics/Monitors/
--
-- scripts/PowerProfile.sh mirrors the eDP-1 line (60 Hz, 8-bit) on battery.

hl.monitor({
  output   = "eDP-1",
  mode     = "2560x1600@240.0",
  position = "auto",
  scale    = 1.25,
  bitdepth = 10,
})

-- Fallback for any other/unknown output
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "auto",
})
