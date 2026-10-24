-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Hyprland configuration -- Lua
-- Reference: https://wiki.hypr.land/Configuring/Start/
--
-- Each require() gets its own Lua scope, so an error in one file does not stop
-- the others from loading.

-- ## This is where you want to start tinkering ## --

require("UserConfigs.Startup_Apps")     -- start-up applications
require("UserConfigs.ENVariables")      -- environment variables

require("UserConfigs.Monitors")         -- monitor layout
require("UserConfigs.WorkspaceRules")   -- workspace rules

require("UserConfigs.Laptops")          -- laptop keys, touchpad device

require("UserConfigs.WindowRules")      -- window rules and layer rules

require("UserConfigs.UserDecorations")  -- decoration config
require("UserConfigs.UserAnimations")   -- animation config
require("UserConfigs.UserSettings")     -- main Hyprland settings

require("configs.Keybinds")             -- pre-configured keybinds
require("UserConfigs.UserKeybinds")     -- put your own keybinds here
