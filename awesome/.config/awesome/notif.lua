-- ding - notification
-- ~~~~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local naughty = require("naughty")
local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local dpi = beautiful.xresources.apply_dpi
local ruled = require("ruled")
local menubar = require("menubar")
local gears = require("gears")

-- configuration
-- ~~~~~~~~~~~~~

-- icon
naughty.connect_signal("request::icon", function(n, context, hints)
    if context ~= "app_icon" then return end

    local path = menubar.utils.lookup_icon(hints.app_icon) or menubar.utils.lookup_icon(hints.app_icon:lower())

    if path then n.icon = path end

end)

-- naughty config
naughty.config.defaults.ontop       = true
naughty.config.defaults.screen      = awful.screen.focused()
naughty.config.defaults.timeout     = 5
naughty.config.defaults.title       = "Ding!"
naughty.config.defaults.position    = "bottom_right"

naughty.config.padding = dpi(10)
naughty.config.spacing = dpi(1)
naughty.config.defaults.shape = help.rrect(2)

naughty.config.defaults.border_width = dpi(10)
naughty.config.defaults.border_color = beautiful.bg_normal

naughty.config.defaults.fg = beautiful.fg_focus
naughty.config.defaults.bg = beautiful.bg_normal

-- naughty normal preset
naughty.config.presets.normal = {
    fg      = beautiful.fg_focus,
    bg      = beautiful.bg_normal
}

-- naughty low preset
naughty.config.presets.low = {
    fg = beautiful.ok,
    bg = beautiful.bg_normal
}

-- naughty critical preset
naughty.config.presets.critical = {
    fg = beautiful.err,
    bg = beautiful.bg_normal,
}

-- ruled notification
ruled.notification.connect_signal("request::rules", function()
    ruled.notification.append_rule {
        rule = {},
        properties = {screen = awful.screen.preferred, implicit_timeout = 6}
    }
end)



-- connect to each display
-- ~~~~~~~~~~~~~~~~~~~~~~~
naughty.connect_signal("request::display", function(n)


    -- action widget
    local action_widget = {
        {
            {
                id = "text_role",
                align = "center",
                valign = "center",
                font = beautiful.font .. '10',
                widget = wibox.widget.textbox
            },
            left = dpi(6),
            right = dpi(6),
            widget = wibox.container.margin
        },
        bg = beautiful.bg_2,
        forced_height = dpi(30),
        widget = wibox.container.background
    }


    -- actions
    local actions = wibox.widget {
        notification = n,
        base_layout = wibox.widget {
            spacing = dpi(8),
            layout = wibox.layout.flex.horizontal
        },
        widget_template = action_widget,
        style = {underline_normal = false, underline_selected = true},
        widget = naughty.list.actions
    }

    -- image
    local image_n = wibox.widget {
    {
        image = n.icon,
        resize = true,
        halign = "center",
        valign = "center",
        widget = wibox.widget.imagebox,
    },
    strategy = "exact",
    height = dpi(72),
    width = dpi(72),
    widget = wibox.container.constraint,
    }


    -- title
    local title_n = wibox.widget{
        {
            {
                markup      = n.title,
                font        = beautiful.font .. '10',
                align       = "left",
                valign      = "center",
                widget      = wibox.widget.textbox
            },
            forced_width    = dpi(200),
            widget          = wibox.container.scroll.horizontal,
            step_function   = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
            speed           = 50
        },
        margins     = {right = 15},
        widget      = wibox.container.margin
    }


    local message_n = wibox.widget{
        {
            {
                markup      = "<span weight='normal'>" .. n.message .. "</span>",
                font        = beautiful.font .. '10',
                align       = "left",
                valign      = "center",
                wrap        = "char",
                widget      = wibox.widget.textbox
            },
            forced_width    = dpi(200),
            layout = wibox.layout.fixed.horizontal
        },
        margins     = {right = 15},
        widget      = wibox.container.margin
    }


    -- app name
    local app_name_n = wibox.widget{
            markup      = n.app_name,
            font        = beautiful.font .. '10',
            align       = "left",
            valign      = "center",
            widget      = wibox.widget.textbox
    }

    local time_n = wibox.widget{
        {
            markup      = "now",
            font        = beautiful.font .. '10',
            align       = "right",
            valign      = "center",
            widget      = wibox.widget.textbox
        },
        margins = {right = 20},
        widget  = wibox.container.margin
    }


    -- extra info
    local notif_info = wibox.widget{
        app_name_n,
        {
            widget = wibox.widget.separator,
            shape = gears.shape.circle,
            forced_height = dpi(4),
            forced_width = dpi(4),
            color = beautiful.fg_normal
        },
        time_n,
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(7)
    }


    -- init
    naughty.layout.box {
        notification = n,
        type    = "notification",
        bg      = beautiful.bg_normal,
        widget_template = {
            {
                {
                    {
                        {
                            notif_info,
                            {
                                {
                                    title_n,
                                    message_n,
                                    layout = wibox.layout.fixed.vertical,
                                    spacing = dpi(3)
                                },
                                margins = {left = dpi(6)},
                                widget = wibox.container.margin
                            },
                            layout = wibox.layout.fixed.vertical,
                            spacing = dpi(16)
                        },
                        nil,
                        image_n,
                        layout = wibox.layout.align.horizontal,
                        expand = "none"
                    },
                    {
                        {actions, layout = wibox.layout.fixed.vertical},
                        margins = {top = dpi(20)},
                        visible = n.actions and #n.actions > 0,
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.fixed.vertical,
                },
                margins = dpi(18),
                widget = wibox.container.margin
            },
            widget          = wibox.container.background,
            forced_width    = dpi(340),
            bg              = beautiful.bg_normal,
        }
    }


    -- don't show notification when dnd is on or dash is visible
    if _G.awesome_dnd_state then
	    naughty.destroy_all_notifications(nil, 1)
    end
end)
