-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- This is where you put your own keybinds.
-- Check configs/Keybinds.lua too, to avoid conflicts.
-- See also UserConfigs/Laptops.lua for laptop keybinds.
--
-- https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod     = "SUPER"
local HOME        = os.getenv("HOME")
local scriptsDir  = HOME .. "/.config/hypr/scripts"
-- Noctalia shell IPC: https://docs.noctalia.dev/noctalia/ipc/
local ipc         = "noctalia msg "

local ok, defaults = pcall(require, "UserConfigs.01-UserDefaults")
if not ok then defaults = {} end
local term  = defaults.term  or "kitty"
local files = defaults.files or "thunar"

-- common shortcuts
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"), { description = "Main menu (Noctalia app launcher)" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd('xdg-open "https://"'), { description = "Default browser" })
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term),  { description = "Terminal" })
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(files), { description = "File manager" })

-- FEATURES / EXTRAS
hl.bind(mainMod .. " + O",                 hl.dsp.exec_cmd(ipc .. "panel-toggle kenn/keybind-cheatsheet:cheatsheet"), { description = "Keybind cheat sheet" })
hl.bind(mainMod .. " + ALT + R",           hl.dsp.exec_cmd(ipc .. "config-reload"),              { description = "Reload Noctalia config" })
hl.bind(mainMod .. " + ALT + E",           hl.dsp.exec_cmd(ipc .. "panel-toggle launcher /emo"), { description = "Emoji menu (Noctalia launcher)" })
hl.bind(mainMod .. " + S",                 hl.dsp.exec_cmd(scriptsDir .. "/RofiSearch.sh"),      { description = "Web search (Noctalia launcher)" })
hl.bind(mainMod .. " + ALT + O",           hl.dsp.exec_cmd(scriptsDir .. "/ChangeBlur.sh"),      { description = "Toggle blur settings" })
hl.bind(mainMod .. " + ALT + V",           hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"),     { description = "Clipboard history (Noctalia)" })
hl.bind(mainMod .. " + SHIFT + E",         hl.dsp.exec_cmd(ipc .. "settings-toggle"),            { description = "Noctalia settings" })

hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen(),                       { description = "Full screen" })
hl.bind(mainMod .. " + CTRL + F",  hl.dsp.window.fullscreen({ mode = "maximized" }), { description = "Fake full screen (maximize)" })
hl.bind(mainMod .. " + F",         hl.dsp.window.float(),                            { description = "Float mode" })

-- All-float toggle for the current workspace.
-- NOTE: the old `hyprctl dispatch workspaceopt allfloat` dispatcher no longer
-- exists in the Lua API, so this is reimplemented directly: if anything on the
-- workspace is still tiled, float everything; otherwise tile everything back.
hl.bind(mainMod .. " + ALT + SPACE", function()
  local ws = hl.get_active_workspace()
  if not ws then return end

  local windows = hl.get_workspace_windows(ws)
  local anyTiled = false
  for _, w in ipairs(windows) do
    if not w.floating then
      anyTiled = true
      break
    end
  end

  for _, w in ipairs(windows) do
    hl.dispatch(hl.dsp.window.float({ action = anyTiled and "enable" or "disable", window = w }))
  end
end, { description = "Toggle all windows on this workspace floating" })

-- Dropdown terminal
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(term, {
  float = true,
  move  = {"monitor_w*0.15", "monitor_h*0.05"},
  size  = {"monitor_w*0.7",  "monitor_h*0.6"},
}), { description = "Dropdown terminal" })

-- Desktop zooming / magnifier.
-- NOTE: this used to shell out to `hyprctl keyword cursor:zoom_factor` plus awk.
-- `hyprctl keyword` is gone in the Lua config; reading and setting the option
-- from Lua is both simpler and does not spawn a shell on every scroll tick.
local function zoomBy(multiplier)
  return function()
    local factor = hl.get_config("cursor.zoom_factor")
    if type(factor) ~= "number" or factor < 1 then factor = 1 end
    hl.config({ cursor = { zoom_factor = factor * multiplier } })
  end
end

hl.bind(mainMod .. " + ALT + mouse_down", zoomBy(2.0), { description = "Zoom in" })
hl.bind(mainMod .. " + ALT + mouse_up",   zoomBy(0.5), { description = "Zoom out" })

-- Bar related (Noctalia bar)
hl.bind(mainMod .. " + CTRL + ALT + B", hl.dsp.exec_cmd(ipc .. "bar-toggle"),            { description = "Toggle bar" })
hl.bind(mainMod .. " + ALT + B",        hl.dsp.exec_cmd(ipc .. "settings-toggle bar"),   { description = "Bar layout / widgets (Noctalia settings)" })

-- FEATURES / EXTRAS
-- Enter copies the result to the clipboard, like the old qalc + wl-copy script
hl.bind(mainMod .. " + ALT + C",   hl.dsp.exec_cmd(ipc .. "panel-toggle launcher /calc"), { description = "Calculator (Noctalia launcher)" })
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(scriptsDir .. "/Animations.sh"), { description = "Hyprland animations menu" })
hl.bind(mainMod .. " + CTRL + O",  hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }), { description = "Toggle opacity on active window" })
-- Noctalia runs `hyprctl switchxkblayout all next` and shows its layout OSD,
-- so the bar's keyboard_layout widget stays in sync.
hl.bind(mainMod .. " + SPACE",     hl.dsp.exec_cmd(ipc .. "keyboard-layout-cycle"), { locked = true, non_consuming = true, description = "Change keyboard layout" })

-- For passthrough of the keyboard into a VM
-- hl.bind(mainMod .. " + ALT + P", hl.dsp.submap("passthru"))
-- hl.define_submap("passthru", function()
--   hl.bind(mainMod .. " + ALT + P", hl.dsp.submap("reset"))
-- end)
