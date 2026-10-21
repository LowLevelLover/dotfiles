-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Main Hyprland settings
-- https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
  dwindle = {
    preserve_split      = true,
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
    kb_options = "grp:win_space_toggle",
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
    no_hardware_cursors     = 1, -- change to 1 if you want to disable HW cursors
    enable_hyprcursor       = false,
    warp_on_change_workspace = 2,
    no_warps                = true,
  },
})
