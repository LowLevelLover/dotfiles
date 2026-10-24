-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Mostly laptop-specific settings. Addendum to configs/Keybinds.lua.
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/

local mainMod    = "SUPER"
local HOME       = os.getenv("HOME")
local scriptsDir = HOME .. "/.config/hypr/scripts"
-- Noctalia shell IPC: https://docs.noctalia.dev/noctalia/ipc/
local ipc        = "noctalia msg "

-- Touchpad device. Run `hyprctl devices` to find your own name.
-- scripts/TouchPad.sh flips `enabled` on this device at runtime.
-- NOTE: the old .conf had "asue1209:00-04f3:319f-touchpad", which is not the
-- name this machine reports -- so the device block matched nothing and the
-- touchpad toggle was a no-op. Corrected against `hyprctl devices`.
local Touchpad_Device = "asue120d:00-04f3:31fb-touchpad"

-- Backlights go through Noctalia so its OSD shows. The keyboard backlight is
-- driven over UPower (asus::kbd_backlight, levels 0-3: one level per press).
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd(ipc .. "keyboard-backlight-down"), { repeating = true })
hl.bind("XF86KbdBrightnessUp",   hl.dsp.exec_cmd(ipc .. "keyboard-backlight-up"),   { repeating = true })
-- The power key is not bound here: logind powers off (HandlePowerKey in configuration.nix).
hl.bind("XF86Launch1", hl.dsp.exec_cmd("rog-control-center"),  { description = "ASUS Armoury Crate button" })
hl.bind("XF86Launch3", hl.dsp.exec_cmd("asusctl led-mode -n"), { description = "FN+F4 switch keyboard RGB profile" })
hl.bind("XF86Launch4", hl.dsp.exec_cmd("asusctl profile -n"),  { description = "FN+F5 change fan profile" })
-- 10% steps; the floor is `[brightness] minimum_brightness` in Noctalia's config.
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down 10%"), { repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(ipc .. "brightness-up 10%"),   { repeating = true })
hl.bind("XF86TouchpadToggle",    hl.dsp.exec_cmd(scriptsDir .. "/TouchPad.sh"), { description = "Toggle touchpad" })

-- Screenshot keybinds using F6 (no PrintScreen button on this keyboard)
hl.bind(mainMod .. " + F6",         hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --now"),   { description = "Screenshot" })
hl.bind(mainMod .. " + SHIFT + F6", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"),  { description = "Screenshot (area)" })
hl.bind(mainMod .. " + CTRL + F6",  hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in5"),   { description = "Screenshot (5s delay)" })
hl.bind(mainMod .. " + ALT + F6",   hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in10"),  { description = "Screenshot (10s delay)" })
hl.bind("ALT + F6",                 hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --active"),{ description = "Screenshot (active window)" })

hl.device({
  name    = Touchpad_Device,
  enabled = true,
})

-- Below is useful when connecting your laptop to an external display.
-- From the wiki: this disables the laptop monitor when the lid is closed.
-- https://wiki.hypr.land/Configuring/Basics/Binds/#switches
-- hl.bind("switch:off:Lid Switch", function()
--   hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })
-- end, { locked = true })
-- hl.bind("switch:on:Lid Switch", function()
--   hl.monitor({ output = "eDP-1", disabled = true })
-- end, { locked = true })

-- WARNING! Using the method above has some caveats: sometimes the main laptop
-- monitor does not come back and needs the external monitor reconnected. A
-- workaround is to make sure the lid is OPEN before shutting down.
