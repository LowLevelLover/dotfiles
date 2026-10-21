-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- This is where you put your own keybinds.
-- Check configs/Keybinds.lua too, to avoid conflicts.
-- See also UserConfigs/Laptops.lua for laptop keybinds.
--
-- https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod     = "SUPER"
local HOME        = os.getenv("HOME")
local scriptsDir  = HOME .. "/.config/hypr/scripts"
local UserScripts = HOME .. "/.config/hypr/UserScripts"

local ok, defaults = pcall(require, "UserConfigs.01-UserDefaults")
if not ok then defaults = {} end
local term  = defaults.term  or "kitty"
local files = defaults.files or "thunar"

-- common shortcuts
-- hl.bind(mainMod .. " + " .. mainMod .. "_L", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -modi drun,filebrowser,run,window"), { release = true })
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("pkill rofi || true && rofi -show drun -modi drun,filebrowser,run,window"), { description = "Main menu (app launcher)" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd('xdg-open "https://"'), { description = "Default browser" })
-- NOTE: dead -- `ags -t` is AGS v1 syntax and the installed ags is v2, so this did nothing.
-- hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("pkill rofi || true && ags -t 'overview'"), { description = "Desktop overview" })
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term),  { description = "Terminal" })
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(files), { description = "File manager" })

-- FEATURES / EXTRAS
hl.bind(mainMod .. " + O",                 hl.dsp.exec_cmd(scriptsDir .. "/KeyHints.sh"),        { description = "Help / cheat sheet" })
hl.bind(mainMod .. " + ALT + R",           hl.dsp.exec_cmd(scriptsDir .. "/Refresh.sh"),         { description = "Refresh waybar, swaync, rofi" })
hl.bind(mainMod .. " + ALT + E",           hl.dsp.exec_cmd(scriptsDir .. "/RofiEmoji.sh"),       { description = "Emoji menu" })
hl.bind(mainMod .. " + S",                 hl.dsp.exec_cmd(scriptsDir .. "/RofiSearch.sh"),      { description = "Web search via rofi" })
hl.bind(mainMod .. " + ALT + O",           hl.dsp.exec_cmd(scriptsDir .. "/ChangeBlur.sh"),      { description = "Toggle blur settings" })
-- hl.bind(mainMod .. " + SHIFT + G",      hl.dsp.exec_cmd(scriptsDir .. "/GameMode.sh"))
-- hl.bind(mainMod .. " + ALT + L",        hl.dsp.exec_cmd(scriptsDir .. "/ChangeLayout.sh"))
hl.bind(mainMod .. " + ALT + V",           hl.dsp.exec_cmd(scriptsDir .. "/ClipManager.sh"),     { description = "Clipboard manager" })
hl.bind(mainMod .. " + CTRL + R",          hl.dsp.exec_cmd(scriptsDir .. "/RofiThemeSelector.sh"), { description = "Rofi theme selector" })
hl.bind(mainMod .. " + CTRL + SHIFT + R",  hl.dsp.exec_cmd("pkill rofi || true && " .. scriptsDir .. "/RofiThemeSelector-modified.sh"))

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

-- Waybar / Bar related
hl.bind(mainMod .. " + CTRL + ALT + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"),           { description = "Toggle waybar" })
hl.bind(mainMod .. " + CTRL + B",       hl.dsp.exec_cmd(scriptsDir .. "/WaybarStyles.sh"),  { description = "Waybar styles menu" })
hl.bind(mainMod .. " + ALT + B",        hl.dsp.exec_cmd(scriptsDir .. "/WaybarLayout.sh"),  { description = "Waybar layout menu" })

-- FEATURES / EXTRAS (UserScripts)
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(UserScripts .. "/RofiBeats.sh"), { description = "Online music via rofi" })
hl.bind(mainMod .. " + ALT + C",   hl.dsp.exec_cmd(UserScripts .. "/RofiCalc.sh"),  { description = "Calculator" })
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(scriptsDir .. "/Animations.sh"), { description = "Hyprland animations menu" })
hl.bind(mainMod .. " + CTRL + O",  hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }), { description = "Toggle opacity on active window" })
hl.bind(mainMod .. " + SPACE",     hl.dsp.exec_cmd(scriptsDir .. "/SwitchKeyboardLayout.sh"), { locked = true, non_consuming = true, description = "Change keyboard layout" })
-- hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd(scriptsDir .. "/KeyBinds.sh"))

-- NOTE: the following binds referenced scripts that do not exist in
-- ~/.config/hypr/UserScripts (only RainbowBorders.sh, RofiBeats.sh and
-- RofiCalc.sh are present), so they were dead binds and are left commented out:
-- hl.bind(mainMod .. " + W",         hl.dsp.exec_cmd(UserScripts .. "/WallpaperSelect.sh"))
-- hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(UserScripts .. "/WallpaperEffects.sh"))
-- hl.bind("CTRL + ALT + W",          hl.dsp.exec_cmd(UserScripts .. "/WallpaperRandom.sh"))
-- hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(UserScripts .. "/ZshChangeTheme.sh"))

-- For passthrough of the keyboard into a VM
-- hl.bind(mainMod .. " + ALT + P", hl.dsp.submap("passthru"))
-- hl.define_submap("passthru", function()
--   hl.bind(mainMod .. " + ALT + P", hl.dsp.submap("reset"))
-- end)
