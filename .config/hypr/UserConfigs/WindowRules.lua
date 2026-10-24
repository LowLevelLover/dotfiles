-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Window rules and layer rules
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
--
-- Rules are evaluated top to bottom and the LAST match wins.
-- NOTE: named rules (those with a `name =` field) are all evaluated BEFORE the
-- anonymous ones, regardless of where they appear in the file.

-- Some samples on how to start apps on specific workspaces
-- hl.window_rule({ match = { tag = "email" },       workspace = "1" })
-- hl.window_rule({ match = { tag = "browser" },     workspace = "2" })
-- hl.window_rule({ match = { tag = "projects" },    workspace = "3" })
-- hl.window_rule({ match = { tag = "screenshare" }, workspace = "4 silent" })
-- hl.window_rule({ match = { tag = "gamestore" },   workspace = "5" })
-- hl.window_rule({ match = { class = "^(virt-manager)$" },          workspace = "6 silent" })
-- hl.window_rule({ match = { class = "^(.virt-manager-wrapped)$" }, workspace = "6 silent" })
-- hl.window_rule({ match = { tag = "im" },          workspace = "7" })
-- hl.window_rule({ match = { class = "obsidian" },  workspace = "8" })
-- hl.window_rule({ match = { tag = "games" },       workspace = "8" })
-- hl.window_rule({ match = { tag = "multimedia" },  workspace = "9 silent" })

hl.window_rule({ match = { tag = "browser" }, no_blur = true })

-- ##################################################################
-- TAGS - add apps under the appropriate tag to use the same settings
-- ##################################################################

-- browser tags
hl.window_rule({ match = { class = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr|[Ff]irefox-bin)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$" },                      tag = "+browser" })
hl.window_rule({ match = { class = "^(chrome-.+-Default)$" },                                            tag = "+browser" })
hl.window_rule({ match = { class = "^([Cc]hromium)$" },                                                  tag = "+browser" })
hl.window_rule({ match = { class = "^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$" },              tag = "+browser" })
hl.window_rule({ match = { class = "^(Brave-browser(-beta|-dev|-unstable)?)$" },                         tag = "+browser" })
hl.window_rule({ match = { class = "^([Tt]horium-browser|[Cc]achy-browser)$" },                          tag = "+browser" })
hl.window_rule({ match = { class = "^(zen-alpha|zen)$" },                                                tag = "+browser" })

-- KooL settings tags
hl.window_rule({ match = { class = "^(nwg-look)$" }, tag = "+KooL-Settings" })

-- terminal tags
hl.window_rule({ match = { class = "^(Alacritty|kitty|kitty-dropterm)$" }, tag = "+terminal" })

-- email tags
hl.window_rule({ match = { class = "^([Tt]hunderbird|org.mozilla.Thunderbird)$" }, tag = "+email" })
hl.window_rule({ match = { class = "^(eu.betterbird.Betterbird)$" },               tag = "+email" })
hl.window_rule({ match = { class = "^(org.gnome.Evolution)$" },                    tag = "+email" })

-- project tags
hl.window_rule({ match = { class = "^(codium|codium-url-handler|VSCodium)$" },  tag = "+projects" })
hl.window_rule({ match = { class = "^(VSCode|code|code-url-handler)$" },        tag = "+projects" })
hl.window_rule({ match = { class = "^(jetbrains-.+)$" },                        tag = "+projects" })
hl.window_rule({ match = { class = "^(dev.zed.Zed|antigravity|cursor)$" },      tag = "+projects" })

-- screenshare tags
hl.window_rule({ match = { class = "^(com.obsproject.Studio)$" }, tag = "+screenshare" })

-- IM tags
hl.window_rule({ match = { class = "^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^([Ff]erdium)$" },                       tag = "+im" })
hl.window_rule({ match = { class = "^([Ww]hatsapp-for-linux)$" },            tag = "+im" })
hl.window_rule({ match = { class = "^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop|TelegramDesktop)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^(teams-for-linux)$" },                  tag = "+im" })
hl.window_rule({ match = { class = "^(im.riot.Riot|Element)$" },             tag = "+im" })

-- game tags
hl.window_rule({ match = { class = "^(gamescope)$" },       tag = "+games" })
hl.window_rule({ match = { class = "^(steam_app_\\d+)$" },  tag = "+games" })

-- gamestore tags
hl.window_rule({ match = { class = "^([Ss]team)$" },                     tag = "+gamestore" })
hl.window_rule({ match = { title = "^([Ll]utris)$" },                    tag = "+gamestore" })
hl.window_rule({ match = { class = "^(com.heroicgameslauncher.hgl)$" },  tag = "+gamestore" })

-- file-manager tags
hl.window_rule({ match = { class = "^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$" }, tag = "+file-manager" })
hl.window_rule({ match = { class = "^(app.drey.Warp)$" },                              tag = "+file-manager" })

-- wallpaper tags
hl.window_rule({ match = { class = "^([Ww]aytrogen)$" }, tag = "+wallpaper" })

-- multimedia tags
hl.window_rule({ match = { class = "^([Aa]udacious)$" }, tag = "+multimedia" })

-- multimedia-video tags
hl.window_rule({ match = { class = "^([Mm]pv|vlc)$" }, tag = "+multimedia_video" })

-- settings tags
hl.window_rule({ match = { title = "^(ROG Control)$" },                            tag = "+settings" })
hl.window_rule({ match = { class = "^(wihotspot(-gui)?)$" },                       tag = "+settings" })
hl.window_rule({ match = { class = "^([Bb]aobab|org.gnome.[Bb]aobab)$" },          tag = "+settings" })
hl.window_rule({ match = { class = "^(gnome-disks)$" },                            tag = "+settings" })
hl.window_rule({ match = { title = "(Kvantum Manager)" },                          tag = "+settings" })
hl.window_rule({ match = { class = "^(file-roller|org.gnome.FileRoller)$" },       tag = "+settings" })
hl.window_rule({ match = { class = "^(blueman-manager)$" },                        tag = "+settings" })
hl.window_rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(qt6ct)$" },                                  tag = "+settings" })
hl.window_rule({ match = { class = "(xdg-desktop-portal-gtk)" },                   tag = "+settings" })
hl.window_rule({ match = { class = "^(btrfs-assistant)$" },                        tag = "+settings" })
hl.window_rule({ match = { class = "^(timeshift-gtk)$" },                          tag = "+settings" })

-- viewer tags
hl.window_rule({ match = { class = "^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$" }, tag = "+viewer" })
hl.window_rule({ match = { class = "^(evince)$" },              tag = "+viewer" })
hl.window_rule({ match = { class = "^(eog|org.gnome.Loupe)$" }, tag = "+viewer" })

-- ###########################
-- Some special override rules
-- ###########################

hl.window_rule({ match = { tag = "multimedia_video" }, no_blur = true })
hl.window_rule({ match = { tag = "multimedia_video" }, opacity = "1.0" })
hl.window_rule({ match = { tag = "multimedia" },       no_blur = true })

-- POSITION
hl.window_rule({ match = { tag = "KooL-Settings" }, center = true })
hl.window_rule({ match = { title = "^(ROG Control)$" }, center = true })
hl.window_rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" }, center = true })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, center = true })

-- Avoid idling while a window is fullscreen.
hl.window_rule({ match = { class = ".*" }, idle_inhibit = "fullscreen" })

-- FLOAT
hl.window_rule({ match = { tag = "wallpaper" },     float = true, center = true })
hl.window_rule({ match = { tag = "settings" },      float = true, center = true })
hl.window_rule({ match = { tag = "viewer" },        float = true, center = true })
hl.window_rule({ match = { tag = "KooL-Settings" }, float = true, center = true })
hl.window_rule({ match = { class = "([Zz]oom|onedriver|onedriver-launcher)" },   float = true })
hl.window_rule({ match = { class = "(org.gnome.Calculator|[Qq]alculate-gtk)" },  float = true })
hl.window_rule({ match = { class = "^(mpv|com.github.rafostar.Clapper)$" },      float = true })
hl.window_rule({ match = { class = "^([Ff]erdium)$" },                           float = true })

-- popups and dialogues
hl.window_rule({ match = { initial_title = "(Mini-App.*)" }, float = true, center = true, size = {600, 1000} })
hl.window_rule({ match = { tag = "im", initial_title = "(Medienbetrachter)" }, fullscreen = true })
hl.window_rule({ match = { title = "^(Authentication Required)$" }, float = true, center = true })
hl.window_rule({
  match = {
    class = "(codium|codium-url-handler|VSCodium)",
    title = "negative:(.*codium.*|.*VSCodium.*)",
  },
  float = true,
})
hl.window_rule({
  match = { class = "^(com.heroicgameslauncher.hgl)$", title = "negative:(Heroic Games Launcher)" },
  float = true,
})
hl.window_rule({
  match = { class = "^([Ss]team)$", title = "negative:^([Ss]team)$" },
  float = true,
})
hl.window_rule({
  match = { title = "^(Add Folder to Workspace)$" },
  float = true, center = true, size = {"monitor_w*0.7", "monitor_h*0.6"},
})
hl.window_rule({
  match = { title = "^(Save As)$" },
  float = true, center = true, size = {"monitor_w*0.7", "monitor_h*0.6"},
})
hl.window_rule({
  match = { initial_title = "(Open Files)" },
  float = true, size = {"monitor_w*0.7", "monitor_h*0.6"},
})
hl.window_rule({ match = { class = "^(hyprland-donate-screen)$" }, float = true, center = true })

-- OPACITY
hl.window_rule({ match = { tag = "browser" },      opacity = "0.99 0.8" })
hl.window_rule({ match = { tag = "projects" },     opacity = "0.97 0.9" })
hl.window_rule({ match = { tag = "im" },           opacity = "0.94 0.86" })
hl.window_rule({ match = { tag = "multimedia" },   opacity = "0.94 0.86" })
hl.window_rule({ match = { tag = "file-manager" }, opacity = "0.9 0.8" })
hl.window_rule({ match = { tag = "terminal" },     opacity = "0.9 0.7" })
hl.window_rule({ match = { tag = "settings" },     opacity = "0.8 0.7" })
hl.window_rule({ match = { tag = "viewer" },       opacity = "0.82 0.75" })
hl.window_rule({ match = { tag = "wallpaper" },    opacity = "0.9 0.7" })
hl.window_rule({ match = { class = "^(gedit|org.gnome.TextEditor|mousepad)$" }, opacity = "0.8 0.7" })
hl.window_rule({ match = { class = "^(deluge)$" },   opacity = "0.9 0.8" })
hl.window_rule({ match = { class = "^(seahorse)$" }, opacity = "0.9 0.8" })

-- SIZE
hl.window_rule({ match = { tag = "wallpaper" },  size = {"monitor_w*0.7",  "monitor_h*0.7"} })
hl.window_rule({ match = { tag = "settings" },   size = {"monitor_w*0.7",  "monitor_h*0.7"} })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, size = {"monitor_w*0.6", "monitor_h*0.7"} })

-- BLUR & FULLSCREEN
hl.window_rule({ match = { tag = "games" }, no_blur = true })

-- Stop the hover popups in IntelliJ products from stealing focus
hl.window_rule({ match = { class = "^(jetbrains-*)" }, no_initial_focus = true })
hl.window_rule({ match = { title = "^(wind.*)$" },     no_initial_focus = true })

-- ###########
-- LAYER RULES
-- ###########

-- Noctalia: blur the bar, panels, dock, notifications, OSD and window switcher,
-- and keep Hyprland's layer animations off them (Noctalia animates itself).
-- https://docs.noctalia.dev/noctalia/compositor-settings/hyprland/
hl.layer_rule({
  name         = "noctalia",
  match        = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$" },
  no_anim      = true,
  ignore_alpha = 0.5,
  blur         = true,
  blur_popups  = true,
})

-- #############################
-- Named rules for special cases
-- #############################

-- Noctalia settings window
hl.window_rule({
  name  = "noctalia-settings",
  match = { class = "^(dev.noctalia.Noctalia)$" },
  float = true,
  size  = {1080, 920},
})

hl.window_rule({
  name   = "Whatsapp-zapzap",
  match  = { class = "^([Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap)$" },
  size   = {"monitor_w*0.6", "monitor_h*0.7"},
  center = true,
})

hl.window_rule({
  name              = "Picture-in-Picture",
  match             = { title = "^(Picture-in-Picture)$" },
  float             = true,
  move              = {"monitor_w*0.72", "monitor_h*0.07"},
  opacity           = "0.95 0.75",
  pin               = true,
  keep_aspect_ratio = true,
  size              = {"monitor_w*0.3", "monitor_h*0.3"},
})

-- Thunar copy progress dialog
hl.window_rule({
  name   = "Thunar-Progress-bar",
  match  = { class = "^(thunar)$", title = "^(File Operation Progress)$" },
  float  = true,
  center = true,
  size   = {"monitor_w*0.26", "monitor_h*0.18"},
})
