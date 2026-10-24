-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Default keybinds
-- https://wiki.hypr.land/Configuring/Basics/Binds/
--
-- Old bind-flag mapping:
--   bind   -> (no opts)                 bindl  -> { locked = true }
--   binde  -> { repeating = true }      bindel -> { locked = true, repeating = true }
--   bindm  -> { mouse = true }          bindln -> { locked = true, non_consuming = true }

local mainMod    = "SUPER"
local HOME       = os.getenv("HOME")
local scriptsDir = HOME .. "/.config/hypr/scripts"
-- Noctalia shell IPC: https://docs.noctalia.dev/noctalia/ipc/
local ipc        = "noctalia msg "

hl.bind("CTRL + ALT + Delete", hl.dsp.exit(),           { description = "Exit Hyprland" })
hl.bind(mainMod .. " + Q",     hl.dsp.window.close(),   { description = "Close active window (not kill)" })
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(scriptsDir .. "/KillActiveProcess.sh"), { description = "Kill active process" })
hl.bind("CTRL + ALT + l",      hl.dsp.exec_cmd(ipc .. "session lock"),          { description = "Screen lock (Noctalia)" })
hl.bind("CTRL + ALT + P",      hl.dsp.exec_cmd(ipc .. "panel-toggle session"),  { description = "Power menu (Noctalia session menu)" })
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center notifications"), { description = "Notification history (Noctalia control center)" })

-- Master Layout
hl.bind(mainMod .. " + CTRL + D",      hl.dsp.layout("removemaster"))
hl.bind(mainMod .. " + I",             hl.dsp.layout("addmaster"))
-- hl.bind(mainMod .. " + J",          hl.dsp.layout("cyclenext"))
-- hl.bind(mainMod .. " + K",          hl.dsp.layout("cycleprev"))
hl.bind(mainMod .. " + CTRL + Return", hl.dsp.layout("swapwithmaster"))

-- Dwindle Layout
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())       -- dwindle

-- Works on either layout (Master or Dwindle)
hl.bind(mainMod .. " + M", hl.dsp.layout("splitratio 0.3"))

-- group
-- hl.bind(mainMod .. " + G",         hl.dsp.group.toggle())
-- hl.bind(mainMod .. " + CTRL + tab", hl.dsp.group.next())

-- Cycle windows; if floating, bring to top
-- NOTE: Noctalia has its own Alt+Tab overlay (`noctalia msg window-switcher hold`);
-- it is not bound so this existing ALT+tab cycle keeps working.
hl.bind("ALT + tab", function()
  hl.dispatch(hl.dsp.window.cycle_next())
  hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Special Keys / Hot Keys
-- Volume goes through Noctalia so its OSD shows (5% steps). Boosting past 100%
-- needs `[audio] enable_overdrive = true` in its config (it is set).
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"),                      { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"),                    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(ipc .. "mic-mute"),                       { locked = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(ipc .. "volume-mute"),                    { locked = true })
hl.bind("XF86Sleep",            hl.dsp.exec_cmd("systemctl suspend"),                     { locked = true })
hl.bind("XF86Rfkill",           hl.dsp.exec_cmd(scriptsDir .. "/AirplaneMode.sh"),        { locked = true })

-- NOTE: the old .conf bound BOTH mic-mute and mute to XF86AudioMute, so the
-- second one silently won and mic mute was unreachable. Mic mute is on
-- XF86AudioMicMute here, which is the key that actually reports it.

-- media controls
-- NOTE: the old .conf also bound `xf86AudioPlayPause`, which is not a real
-- keysym (hyprlang accepted it silently and it never fired). XF86AudioPlay and
-- XF86AudioPause below are the keys that actually get reported.
hl.bind("XF86AudioPause",     hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioPlay",      hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioNext",      hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --nxt"),   { locked = true })
hl.bind("XF86AudioPrev",      hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --prv"),   { locked = true })
hl.bind("XF86AudioStop",      hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --stop"),  { locked = true })

-- Screenshots. NOTE: you may need to press the Fn key as well.
hl.bind(mainMod .. " + Print",                hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --now"),   { description = "Screenshot" })
hl.bind(mainMod .. " + SHIFT + Print",        hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"),  { description = "Screenshot (area)" })
hl.bind(mainMod .. " + CTRL + Print",         hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in5"),   { description = "Screenshot (5s delay)" })
hl.bind(mainMod .. " + CTRL + SHIFT + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in10"),  { description = "Screenshot (10s delay)" })
hl.bind("ALT + Print",                        hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --active"),{ description = "Screenshot (active window)" })

-- screenshot with satty (annotation tool)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --satty"), { description = "Screenshot (satty annotate)" })

-- Resize windows (arrows)
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -50, y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 50,  y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }), { repeating = true })

-- Resize windows (vim keys)
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -50, y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = 50,  y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0,   y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }), { repeating = true })

-- Move windows (arrows)
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.move({ direction = "d" }))

-- Move windows (vim keys)
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ direction = "d" }))

-- Swap windows (arrows)
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.swap({ direction = "d" }))

-- Swap windows (vim keys)
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.swap({ direction = "d" }))

-- Move focus (arrows)
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

-- Move focus (vim keys)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Workspaces
hl.bind(mainMod .. " + tab",         hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.focus({ workspace = "m-1" }))

-- Special workspace
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + U",         hl.dsp.workspace.toggle_special())

-- The following use key codes to better support various keyboard layouts.
-- 1 is code:10, 2 is code:11, etc.
for i = 1, 10 do
  local code = 9 + i        -- code:10 .. code:19
  local ws   = i            -- workspace 1..10 (code:19 = key 0 = workspace 10)

  -- Switch workspaces with mainMod + [0-9]
  hl.bind(mainMod .. " + code:" .. code, hl.dsp.focus({ workspace = ws }))

  -- Move active window and follow, mainMod + SHIFT + [0-9]
  hl.bind(mainMod .. " + SHIFT + code:" .. code, hl.dsp.window.move({ workspace = ws }))

  -- Move active window silently, mainMod + CTRL + [0-9]
  hl.bind(mainMod .. " + CTRL + code:" .. code, hl.dsp.window.move({ workspace = ws, follow = false }))
end

hl.bind(mainMod .. " + SHIFT + bracketleft",  hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + bracketleft",   hl.dsp.window.move({ workspace = "-1", follow = false }))
hl.bind(mainMod .. " + CTRL + bracketright",  hl.dsp.window.move({ workspace = "+1", follow = false }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + period",     hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + comma",      hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true }) -- left click
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- right click
