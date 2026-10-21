-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Main Hyprland settings
-- https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
  dwindle = {
    preserve_split       = true,
    special_scale_factor = 0.8, -- carried over from the old .conf, lost in the Lua migration
  },

  master = {
    new_status = "master",
    new_on_top = true,
    mfact      = 0.5,
  },

  general = {
    resize_on_border = true,
    layout           = "dwindle",
  },

  input = {
    kb_layout  = "us,ir",
    kb_variant = "",
    kb_model   = "",
    -- SUPER+SPACE layout switching is done by scripts/SwitchKeyboardLayout.sh
    -- (UserKeybinds.lua); grp:win_space_toggle here made it switch twice.
    kb_options = "",
    kb_rules   = "",

    repeat_rate  = 50,
    repeat_delay = 300,

    sensitivity = 0, -- mouse sensitivity
    -- accel_profile = "", -- flat / adaptive; empty means libinput's default

    numlock_by_default         = true,
    left_handed                = false,
    follow_mouse               = 1,
    float_switch_override_focus = false,

    touchpad = {
      disable_while_typing   = true,
      natural_scroll         = true,
      clickfinger_behavior   = false,
      middle_button_emulation = true,
      tap_to_click           = true, -- was `tap-to-click` in hyprlang
      drag_lock              = false,
    },

    -- for devices with a touchscreen
    touchdevice = {
      enabled = true,
    },

    -- tablet
    tablet = {
      transform   = 0,
      left_handed = false,
    },
  },

  misc = {
    disable_hyprland_logo     = true,
    disable_splash_rendering  = true,
    vrr                       = 2,
    mouse_move_enables_dpms   = true,
    enable_swallow            = false,
    swallow_regex             = "^(kitty)$",
    focus_on_activate         = false,
    initial_workspace_tracking = 0,
    middle_click_paste        = false,
  },

  opengl = {
    nvidia_anti_flicker = true,
  },

  -- Touchpad workspace swipe tuning (the gestures themselves are hl.gesture() below)
  gestures = {
    workspace_swipe_distance           = 300,
    workspace_swipe_cancel_ratio       = 0.3,
    workspace_swipe_min_speed_to_force = 15,
    workspace_swipe_create_new         = true,
    workspace_swipe_direction_lock     = true,
    workspace_swipe_forever            = true,
  },

  binds = {
    workspace_back_and_forth = true,
    allow_workspace_cycles   = true,
    pass_mouse_when_bound    = false,
  },

  -- Can help when scaling, to avoid pixelation
  xwayland = {
    enabled            = true,
    force_zero_scaling = true,
  },

  cursor = {
    sync_gsettings_theme    = true,
    no_hardware_cursors     = 2, -- auto: HW cursor on the Intel-driven eDP, SW on NVIDIA outputs
    -- Bibata-Modern-Amber in ~/.local/share/icons is an XCursor theme (its
    -- manifest.hl is empty, there is no hyprcursors/ dir), so hyprcursor must
    -- stay off; the theme is applied via XCURSOR_* in ENVariables.lua.
    enable_hyprcursor       = false,
    warp_on_change_workspace = 2,
    no_warps                = true,
  },
})

-- Touchpad gestures.
-- Since Hyprland 0.51 gestures are declared explicitly (the old
-- `gestures { workspace_swipe = true }` switch is gone), and the Lua migration
-- carried none over -- which is why 3-finger swipes did nothing.
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "up",         action = "special", workspace_name = "special" })
hl.gesture({ fingers = 3, direction = "down",       action = "special", workspace_name = "special" })
hl.gesture({ fingers = 4, direction = "pinchin",    action = "fullscreen" })
hl.gesture({ fingers = 4, direction = "pinchout",   action = "fullscreen" })
