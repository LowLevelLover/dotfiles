-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Workspace rules
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
--
-- You can set workspace rules to achieve workspace-specific behaviors, e.g. a
-- workspace where all windows are drawn without borders or gaps.
--
-- Special workspaces (scratchpad) get wide outer gaps so windows sit centered
-- at ~80% of the screen. Replaces the deprecated dwindle:special_scale_factor
-- = 0.8. Values are logical px: eDP-1 is 2560x1600 @ 1.25 -> 2048x1280, so a
-- 10% margin per side is ~205 horizontally and 128 vertically.
hl.workspace_rule({
  workspace = "s[true]",
  gaps_out  = { top = 128, bottom = 128, left = 205, right = 205 },
})

-- The rest of the previous workspaces.conf was commented-out examples.
-- Below are the same examples in Lua form.

-- Assigning a workspace to a certain monitor:
-- hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
-- hl.workspace_rule({ workspace = "5", monitor = "DP-2" })

-- Example rules:
-- hl.workspace_rule({ workspace = "3", no_rounding = true, decorate = false })
-- hl.workspace_rule({
--   workspace   = "name:coding",
--   no_rounding = true,
--   decorate    = false,
--   gaps_in     = 0,
--   gaps_out    = 0,
--   no_border   = true,
--   monitor     = "DP-1",
-- })
-- hl.workspace_rule({ workspace = "8", border_size = 8 })
-- hl.workspace_rule({ workspace = "name:Hello", monitor = "DP-1", default = true })
-- hl.workspace_rule({ workspace = "5", on_created_empty = "firefox" })
-- hl.workspace_rule({ workspace = "special:scratchpad", on_created_empty = "kitty" })
