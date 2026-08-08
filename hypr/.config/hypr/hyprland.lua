--###############
--## MONITORS ###
--###############

hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@60",
    position = "auto",
    scale = "1.2",
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1360x768@60.02Hz",
    position = "auto",
    scale = "1",
})

--##################
--## MY PROGRAMS ###
--##################

local terminal = "kitty"
local fileManager = "thunar"
local menu = "rofi -show drun"
local browser = "brave-origin"

--#############################
--## ENVIRONMENT VARIABLES ###
--#############################

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

--####################
--## LOOK AND FEEL ###
--####################

-- Bezier curves for animations
-- See https://wiki.hypr.land/Configuring/Animations/#curves
hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1    }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0,    0    }, { 1,    1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5,  0.5  }, { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0    }, { 0.1,  1 } } })

-- Animations
-- See https://wiki.hypr.land/Configuring/Animations/
hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default"      })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick"        })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 3.5,  bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick"        })

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },

    --####################
    --## LOOK AND FEEL ###
    --####################

    -- Refer to https://wiki.hypr.land/Configuring/Variables/
    -- https://wiki.hypr.land/Configuring/Variables/#general
    general = {
        gaps_in = 2,
        gaps_out = 1,
        border_size = 2,
        -- https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
        col = {
            active_border   = "rgba(e6e6e6aa)",
            inactive_border = "rgba(595959aa)",
        },
        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,
        -- Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
        allow_tearing = false,
        layout = "dwindle",
    },

    -- https://wiki.hypr.land/Configuring/Variables/#decoration
    decoration = {
        rounding = 2,
        rounding_power = 2,
        -- Change transparency of focused and unfocused windows
        active_opacity   = 0.9,
        inactive_opacity = 0.9,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
        -- https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
            enabled  = true,
            size     = 3,
            passes   = 2,
            vibrancy = 0.1696,
        },
    },

    -- https://wiki.hypr.land/Configuring/Variables/#animations
    animations = {
        enabled = true,
    },

    -- Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
    -- "Smart gaps" / "No gaps when only"
    -- uncomment all if you wish to use that.
    -- workspace = w[tv1], gapsout:0, gapsin:0
    -- workspace = f[1], gapsout:0, gapsin:0
    -- windowrule {
    --     name = no-gaps-wtv1
    --     match:float = false
    --     match:workspace = w[tv1]
    --     border_size = 0
    --     rounding = 0
    -- }
    -- windowrule {
    --     name = no-gaps-f1
    --     match:float = false
    --     match:workspace = f[1]
    --     border_size = 0
    --     rounding = 0
    -- }

    -- See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
    -- dwindle = {
    --     pseudotile    = true, -- Master switch for pseudotiling. Enabling is bound to mainMod + P below
    --     preserve_split = true, -- You probably want this
    -- },

    -- See https://wiki.hypr.land/Configuring/Master-Layout/ for more
    master = {
        new_status = "master",
    },

    -- https://wiki.hypr.land/Configuring/Variables/#misc
    misc = {
        force_default_wallpaper = 1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random Hyprland logo / anime girl background :(
    },

    --############
    --## INPUT ###
    --############

    -- https://wiki.hypr.land/Configuring/Variables/#input
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        follow_mouse = 1,
        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll = true,
        },
    },
})

-- See https://wiki.hypr.land/Configuring/Gestures
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

--##################
--## KEYBINDINGS ###
--##################

-- See https://wiki.hypr.land/Configuring/Keywords/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- See https://wiki.hypr.land/Configuring/Binds/ for more
hl.bind(mainMod .. " + return",       hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",            hl.dsp.window.close())
-- bind = $mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit
hl.bind(mainMod .. " + E",            hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B",            hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + W",            hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + A",            hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V",            hl.dsp.exec_cmd('cliphist list | rofi -dmenu -p "Clipboard" | cliphist decode | wl-copy'))
hl.bind(mainMod .. " + P",            hl.dsp.window.pseudo()) -- dwindle
-- bind = $mainMod, J, togglesplit, # dwindle
hl.bind(mainMod .. " + L",            hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + T",            hl.dsp.exec_cmd("prime-run /usr/games/tlauncher/lib/jvm/jre/bin/java -Dfile.encoding=UTF8 -jar /usr/games/tlauncher/starter-core.jar"))

-- Reload Waybar with Super + Shift + W
hl.bind(mainMod .. " + SHIFT + W",    hl.dsp.exec_cmd("killall -SIGUSR2 waybar"))

-- Power Menu (Super + Backspace)
hl.bind(mainMod .. " + Backspace",    hl.dsp.exec_cmd("~/.config/rofi/powermenu.sh"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",         hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + right",        hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",           hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + down",         hl.dsp.focus({ direction = "down"  }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1",            hl.dsp.focus({ workspace = 1  }))
hl.bind(mainMod .. " + 2",            hl.dsp.focus({ workspace = 2  }))
hl.bind(mainMod .. " + 3",            hl.dsp.focus({ workspace = 3  }))
hl.bind(mainMod .. " + 4",            hl.dsp.focus({ workspace = 4  }))
hl.bind(mainMod .. " + 5",            hl.dsp.focus({ workspace = 5  }))
hl.bind(mainMod .. " + 6",            hl.dsp.focus({ workspace = 6  }))
hl.bind(mainMod .. " + 7",            hl.dsp.focus({ workspace = 7  }))
hl.bind(mainMod .. " + 8",            hl.dsp.focus({ workspace = 8  }))
hl.bind(mainMod .. " + 9",            hl.dsp.focus({ workspace = 9  }))
hl.bind(mainMod .. " + 0",            hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1",    hl.dsp.window.move({ workspace = 1  }))
hl.bind(mainMod .. " + SHIFT + 2",    hl.dsp.window.move({ workspace = 2  }))
hl.bind(mainMod .. " + SHIFT + 3",    hl.dsp.window.move({ workspace = 3  }))
hl.bind(mainMod .. " + SHIFT + 4",    hl.dsp.window.move({ workspace = 4  }))
hl.bind(mainMod .. " + SHIFT + 5",    hl.dsp.window.move({ workspace = 5  }))
hl.bind(mainMod .. " + SHIFT + 6",    hl.dsp.window.move({ workspace = 6  }))
hl.bind(mainMod .. " + SHIFT + 7",    hl.dsp.window.move({ workspace = 7  }))
hl.bind(mainMod .. " + SHIFT + 8",    hl.dsp.window.move({ workspace = 8  }))
hl.bind(mainMod .. " + SHIFT + 9",    hl.dsp.window.move({ workspace = 9  }))
hl.bind(mainMod .. " + SHIFT + 0",    hl.dsp.window.move({ workspace = 10 }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",            hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S",    hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down",   hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",     hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272",    hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273",    hl.dsp.window.resize())

-- Laptop multimedia keys for volume and LCD brightness (locked = bindl, repeating = bindel)
hl.bind("XF86AudioRaiseVolume",       hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",       hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",              hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",           hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",        hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",      hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                   { locked = true, repeating = true })

-- Screenshot (Print Screen)
hl.bind("Print",                      hl.dsp.exec_cmd("~/.config/rofi/screenshot.sh"))

-- Requires playerctl
hl.bind("XF86AudioNext",              hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause",             hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",              hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",              hl.dsp.exec_cmd("playerctl previous"),     { locked = true })

-- Lid switch handling
-- If plugged in (systemd-ac-power returns 0/true) -> Turn screen off
-- If on battery  (systemd-ac-power returns 1/false) -> Suspend
hl.bind("switch:on:Lid Switch",
    hl.dsp.exec_cmd("systemd-ac-power && hyprctl dispatch dpms off || systemctl suspend"),
    { locked = true })

-- When opening lid -> Turn screen back on
hl.bind("switch:off:Lid Switch",
    hl.dsp.exec_cmd('hyprctl dispatch dpms on && hyprctl keyword monitor "eDP-1, 1920x1080@60, auto, 1.2"'),
    { locked = true })

--#############################
--## WINDOWS AND WORKSPACES ###
--#############################

-- See https://wiki.hypr.land/Configuring/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule({
    name = "suppress-maximize-events",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name = "move-hyprland-run",
    match = {
        class = "hyprland-run",
    },
    move  = "20 monitor_h-120",
    float = true,
})

--#################
--## AUTOSTART ####
--#################

hl.on("hyprland.start", function()
    hl.exec_cmd("dunst & waybar & blueman-applet")
    hl.exec_cmd("sh -c 'hyprpaper & sleep 0.8; hyprctl hyprpaper wallpaper \"eDP-1,/home/shyam/dotfiles-black-minimal/wallpapers/starry-sky.jpg\"'")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")   -- Stores only text data
    hl.exec_cmd("wl-paste --type image --watch cliphist store")  -- Stores only image data
    hl.exec_cmd("kdeconnect-indicator")                          -- install kdeconnect and use this
    hl.exec_cmd("hypridle")
    hl.exec_cmd("/home/shyam/.config/hypr/scripts/watch-network.sh") -- captive portal auto-login prompt
    hl.exec_cmd("mcontrolcenter")                                -- msi center for linux - mcontrolcenter-bin aur package
end)
