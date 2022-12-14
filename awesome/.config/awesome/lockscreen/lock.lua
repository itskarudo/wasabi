-- Lockscreen
-- ~~~~~~~~~~~~~~~~~~~~
-- edited from elenapan


-- Requirements
-- ~~~~~~~~~~~~
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local lock_screen = require("lockscreen")
local dpi = beautiful.xresources.apply_dpi

function vertical_pad(height)
    return wibox.widget {
        forced_height = height,
        layout = wibox.layout.fixed.vertical
    }
end

function colorize_text(txt, fg)

    if fg == "" then
        fg = "#ffffff"
    end

    return "<span foreground='" .. fg .. "'>" .. txt .. "</span>"
end


-- misc/vars
-- ~~~~~~~~~

local lock_screen_symbol = ""
local lock_screen_fail_symbol = ""



-- widgets themselves
-- ~~~~~~~~~~~~~~~~~~


local profile_image = wibox.widget {
    {
        image = beautiful.pfp,
        upscale = true,
        forced_width = dpi(160),
        forced_height = dpi(160),
        clip_shape = gears.shape.circle,
        widget = wibox.widget.imagebox,
        halign = "center",
    },
    widget = wibox.container.background,
    border_width = dpi(2),
    shape = gears.shape.circle,
    border_color = beautiful.fg_normal
}


local username = wibox.widget{
    widget = wibox.widget.textbox,
    markup = "karudo",
    font = beautiful.font .. '14',
    align = "center",
    valign = "center"
}


local myself = wibox.widget{
    profile_image,
    username,
    spacing = dpi(15),
    layout = wibox.layout.fixed.vertical
}

-- dummy text
local some_textbox = wibox.widget.textbox()

-- lock icon
local icon = wibox.widget{
    widget = wibox.widget.textbox,
    markup = lock_screen_symbol,
    font = beautiful.font .. '10',
    align = "center",
    valign = "center"
}


-- clock
local clock = wibox.widget{
    vertical_pad(dpi(40)),
    {
        font = beautiful.font .. '14',
        format = colorize_text("%I:%M", beautiful.fg_normal),
        widget = wibox.widget.textclock,
        align = "center",
        valign = "center"
    },
    {
        font = beautiful.font .. '14',
        format = colorize_text("%A, %B", beautiful.fg_normal),
        widget = wibox.widget.textclock,
        align = "center",
        valign = "center"
    },
    spacing = dpi(10),
    layout = wibox.layout.fixed.vertical
}






-- password prompt
local promptbox = wibox.widget{
    widget = wibox.widget.textbox,
    markup = "",
    font = beautiful.font .. '10',
    align = "center"
}

local promptboxfinal = wibox.widget{
    {
        {
            {
                promptbox,
                margins = {left = dpi(10)},
                widget = wibox.container.margin
            },
            nil,
            {
                icon,
                margins = {right = dpi(10)},
                widget = wibox.container.margin
            },
            layout = wibox.layout.align.horizontal,
            expand = "none"
        },
        widget = wibox.container.margin,
        margins = dpi(10)
    },
    widget = wibox.container.background,
    bg = beautiful.fg_normal .. "1A",
    forced_width = dpi(300),
    forced_height = dpi(40),
    shape = gears.shape.rounded_bar
}

-- Create the lock screen wibox
local lock_screen_box = wibox({
    visible = false,
    ontop = true,
    type = "splash",
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal,
    screen = screen.primary
})

-- Create the lock screen wibox (extra)
local function create_extender(s)
    

local lock_screen_box_ext wibox({
    visible = false,
    ontop = true,
    type = "splash",
    bg = beautiful.bg_normal .. "E6",
    fg = beautiful.fg_normal,
    screen = s
})

awful.placement.maximize(lock_screen_box_ext)

return lock_screen_box_ext

end

awful.placement.maximize(lock_screen_box)




-- Add lockscreen to each screen
awful.screen.connect_for_each_screen(function(s)
    if s.index == 2 then
        s.mylockscreenext = create_extender(2)
        s.mylockscreen = lock_screen_box
    else
        s.mylockscreen = lock_screen_box
    end
end)


local function set_visibility(v)
    for s in screen do
        s.mylockscreen.visible = v
        if s.mylockscreenext then
            s.mylockscreenext.visible = v
        end
    end
end



-- Lock helper functions
local characters_entered = 0


-- reset function
local function reset()
    characters_entered = 0;
    promptbox.markup = colorize_text("", beautiful.err)
    icon.markup = lock_screen_symbol
end

-- fail function
local function fail()
    characters_entered = 0;
    promptbox.markup = colorize_text("Incorrect", beautiful.err)
    icon.markup = lock_screen_fail_symbol
end




-- user input
local function grab_password()
    awful.prompt.run {
        hooks = {
            {{ }, 'Escape',
                function(_)
                    reset()
                    grab_password()
                end
            },
            {{ 'Control' }, 'Delete', function ()
                reset()
                grab_password()
            end}
        },
        keypressed_callback  = function(mod, key, cmd)
            if #key == 1 then
                characters_entered = characters_entered + 1
                promptbox.markup = colorize_text(string.rep("*", characters_entered), beautiful.fg_normal)
            elseif key == "BackSpace" then
                if characters_entered > 0 then
                    characters_entered = characters_entered - 1
                end
                promptbox.markup = colorize_text(string.rep("*", characters_entered), beautiful.fg_normal)
            end

        end,
        exe_callback = function(input)
            -- compare input
            if lock_screen.authenticate(input) then
                -- YAY 
                reset()
                set_visibility(false)
            else
                -- NAH, JIT TRIPPIN
                fail()
                grab_password()
            end
        end,
        textbox = some_textbox,
    }
end



-- show lockscreen func
function lock_screen_show()
    set_visibility(true)
    grab_password()
end





-- init
-- ~~~~
lock_screen_box:setup {
    {
        clock,
        {
            myself,
            {
                {
                    promptboxfinal,
                    layout = wibox.layout.fixed.horizontal,
                },
                layout = wibox.container.place
            },
            layout = wibox.layout.fixed.vertical,
            spacing = dpi(50)
        },
        layout = wibox.layout.align.vertical,
        expand = "none"
    },
    layout = wibox.layout.stack
}
