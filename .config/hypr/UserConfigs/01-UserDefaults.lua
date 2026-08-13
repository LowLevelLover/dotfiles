-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Your own default apps, default search engine, etc.
--
-- This is a plain Lua module: it returns a table and has no side effects.
-- Require it wherever you need these values, e.g.
--   local defaults = require("UserConfigs.01-UserDefaults")

return {
  -- Preferred text editor. Falls back to helix if $EDITOR is unset.
  edit = os.getenv("EDITOR") or "hx",

  -- Used by UserConfigs/UserKeybinds.lua
  term  = "kitty",  -- Terminal
  files = "thunar", -- File manager

  -- Default search engine for the rofi search bind (SUPER S).
  -- NOTE: scripts/RofiSearch.sh is a shell script and cannot read this value;
  -- it carries its own copy. Change it there too if you switch engines.
  search_engine = "https://www.google.com/search?q={}",
}
