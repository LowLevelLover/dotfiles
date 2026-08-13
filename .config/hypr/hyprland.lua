-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Hyprland configuration -- Lua
--
-- Migrated from the old hyprlang (.conf) configuration.
-- hyprlang is deprecated since Hyprland 0.55; the config lives in hyprland.lua now.
-- Reference: https://wiki.hypr.land/Configuring/Start/
--
-- Layout mirrors the previous .conf structure so the old mental map still works:
--   UserConfigs/<Name>.conf     ->  UserConfigs/<Name>.lua
--   configs/Keybinds.conf       ->  configs/Keybinds.lua
--
-- Each require() gets its own Lua scope, so an error in one file does not stop
-- the others from loading.

-- NOTE: the old hyprland.conf had
--   exec-once = $HOME/.config/hypr/initial-boot.sh
-- but the file on disk is spelled "inital-boot.sh" (and is not executable), so
-- that line never ran and the ~/.config/hypr/.initial_startup_done marker was
-- never created. It is a one-shot dotfiles installer that overwrites the waybar
-- style, kvantum/gtk/icon/cursor themes with JaKooLit defaults, so it is left
-- disabled here on purpose rather than being "fixed" into running.
-- To run it deliberately: bash ~/.config/hypr/inital-boot.sh

-- ## This is where you want to start tinkering ## --

require("UserConfigs.Startup_Apps")     -- start-up applications
require("UserConfigs.ENVariables")      -- environment variables

require("UserConfigs.Monitors")         -- monitor layout (nwg-displays writes this)
require("UserConfigs.WorkspaceRules")   -- workspace rules

require("UserConfigs.Laptops")          -- laptop keys, touchpad device
require("UserConfigs.LaptopDisplay")    -- laptop lid / display handling

require("UserConfigs.WindowRules")      -- window rules and layer rules

require("UserConfigs.UserDecorations")  -- decoration config
require("UserConfigs.UserAnimations")   -- animation config
require("UserConfigs.UserSettings")     -- main Hyprland settings

require("configs.Keybinds")             -- pre-configured keybinds
require("UserConfigs.UserKeybinds")     -- put your own keybinds here

-- NOTE: plugins
-- The old hyprland.conf carried a `plugin { hypr-dynamic-cursors ... hyprgrass ... }`
-- block, but neither plugin is installed (both are commented out in
-- nixos-config/configuration.nix), so that block was dead config and is not
-- carried over. To bring them back: enable the packages in configuration.nix,
-- then load and configure them here with hl.plugin.load() / hl.plugin.<name>.
