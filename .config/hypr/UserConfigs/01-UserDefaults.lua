-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Your own default apps, default search engine, etc.
--
-- This is a plain Lua module: it returns a table and has no side effects.
-- Require it wherever you need these values, e.g.
--   local defaults = require("UserConfigs.01-UserDefaults")

return {
  -- Used by UserConfigs/UserKeybinds.lua
  term  = "kitty",  -- Terminal
  files = "thunar", -- File manager

  -- Default search engine for the web search bind (SUPER S); scripts/RofiSearch.sh
  -- reads it from this line, {} is replaced with the URL-encoded query.
  search_engine = "https://www.google.com/search?q={}",
}
