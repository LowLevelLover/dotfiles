-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Environment variables
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
--
-- Set your default editor in UserConfigs/01-UserDefaults.lua

-- XDG_CURRENT_DESKTOP, XDG_SESSION_DESKTOP, XDG_SESSION_TYPE, QT_QPA_PLATFORM
-- and QT_QPA_PLATFORMTHEME come from environment.sessionVariables in
-- nixos-config/configuration.nix, which also covers the greeter and systemd units.

-- Toolkit Backend Variables
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")

-- Run SDL2 applications on Wayland.
-- Remove or set to x11 if games that provide older versions of SDL cause issues.
-- hl.env("SDL_VIDEODRIVER", "wayland")

-- QT Variables
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1.25")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- xwayland apps scale fix (useful if you use monitor scaling).
-- Set the same value you use in UserConfigs/Monitors.lua. 1 is 100%, 1.5 is 150%.
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/XWayland/
-- hl.env("GDK_SCALE", "1.25")
-- hl.env("QT_SCALE_FACTOR", "1.25")

-- Bibata-Modern-Amber cursor
-- The installed theme is XCursor-only, so XCURSOR_* is what actually applies it.
-- Without these, GTK/Qt/Electron/XWayland clients each fell back to their own
-- default (Adwaita / whiteglove), giving a different cursor shape and size
-- depending on which window the pointer was over.
hl.env("XCURSOR_THEME", "Bibata-Modern-Amber")
hl.env("XCURSOR_SIZE", "24")
-- Kept so it works unchanged if a hyprcursor build of the theme is installed
-- and cursor.enable_hyprcursor is turned on.
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Amber")
hl.env("HYPRCURSOR_SIZE", "24")

-- firefox
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- electron >28 apps -- auto selects Wayland if possible, X11 otherwise
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- NVIDIA
-- https://wiki.hypr.land/Nvidia/#environment-variables
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")

-- additional ENVs for nvidia. Caution, activate with care.
-- hl.env("GBM_BACKEND", "nvidia-drm")

hl.env("__GL_GSYNC_ALLOWED", "1") -- adaptive Vsync
-- hl.env("__NV_PRIME_RENDER_OFFLOAD", "1")
-- hl.env("__VK_LAYER_NV_optimus", "NVIDIA_only")
-- hl.env("WLR_DRM_NO_ATOMIC", "1")
-- (WLR_RENDERER removed: wlroots-only, Hyprland/aquamarine ignores it)

-- FOR VM AND POSSIBLY NVIDIA
-- LIBGL_ALWAYS_SOFTWARE -- software mesa rendering
-- hl.env("LIBGL_ALWAYS_SOFTWARE", "1") -- Warning. May cause Hyprland to crash
-- hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")

-- nvidia firefox (hardware acceleration on FF)
-- https://github.com/elFarto/nvidia-vaapi-driver#configuration
-- hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
-- hl.env("EGL_PLATFORM", "wayland")

---- Aquamarine Environment Variables ----
-- hl.env("AQ_TRACE", "1")            -- more verbose logging
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/card0")
-- hl.env("AQ_MGPU_NO_EXPLICIT", "1") -- disables explicit syncing on mgpu buffers
-- hl.env("AQ_NO_MODIFIERS", "1")     -- disables modifiers for DRM buffers

---- Hyprland Environment Variables ----
-- hl.env("HYPRLAND_TRACE", "1")       -- more verbose logging
-- hl.env("HYPRLAND_NO_RT", "1")       -- disables realtime priority
-- hl.env("HYPRLAND_NO_SD_NOTIFY", "1")
-- hl.env("HYPRLAND_NO_SD_VARS", "1")
