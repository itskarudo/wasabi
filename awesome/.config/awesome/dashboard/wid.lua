local M = {}

local on = beautiful.pri
local off = beautiful.fg_minimize

M.vol = wibox.widget {
  {
    {
      id = "vol",
      widget = wibox.widget.textbox,
      font = beautiful.icofont,
      markup = "",
      halign = "center",
      align = 'center',
    },
    widget = wibox.container.margin,
    margins = dpi(5),
  },
  fg = beautiful.pri,
  bg = beautiful.bg_minimize,
  shape = help.rrect(2),
  widget = wibox.container.background,
}

M.wifi = wibox.widget {
  {
    {
      id = 'wifi',
      widget = wibox.widget.textbox,
      font = beautiful.icofont,
      markup = "",
      halign = "center",
      align = 'center',
    },
    widget = wibox.container.margin,
    margins = dpi(15),
  },
  fg = on,
  bg = beautiful.bg_minimize,
  shape = help.rrect(2),
  widget = wibox.container.background,
}

M.nig = wibox.widget {
  {
    {
      widget = wibox.widget.textbox,
      font = beautiful.icofont,
      markup = "",
      halign = "center",
      align = 'center',
    },
    widget = wibox.container.margin,
    margins = dpi(5),
  },
  fg = beautiful.pri,
  bg = beautiful.bg_minimize,
  shape = help.rrect(2),
  widget = wibox.container.background,
}

M.rec = wibox.widget {
  {
    {
      widget = wibox.widget.textbox,
      font = beautiful.icofont,
      markup = "",
      halign = "center",
      align = 'center',
    },
    widget = wibox.container.margin,
    margins = dpi(5),
  },
  widget = wibox.container.background,
  bg = beautiful.bg_minimize,
  shape = help.rrect(2),
  fg = beautiful.fg_normal,
}

M.rec:buttons(gears.table.join(
  awful.button({}, 1, function()
    awful.spawn.with_shell("flameshot gui")
  end)
))

local vol = false

awesome.connect_signal("signal::volume", function(_, mut)
  vol = mut
  if mut then
    M.vol:get_children_by_id("vol")[1].markup = ""
    M.vol.fg = off
  else
    M.vol:get_children_by_id("vol")[1].markup = ""
    M.vol.fg = on
  end
end)

M.vol:buttons(gears.table.join(
  awful.button({}, 1, function()
    if vol then
      awful.spawn.with_shell("pulsemixer --unmute")
    else
      awful.spawn.with_shell("pulsemixer --mute")
    end
  end)
))

local wifi = false

awesome.connect_signal("signal::wifi", function(stat)
  wifi = stat
  if stat then
    M.wifi.fg = on
    M.wifi:get_children_by_id("wifi")[1].markup = ""
  else
    M.wifi.fg = off
    M.wifi:get_children_by_id("wifi")[1].markup = ""
  end
end)

M.wifi:buttons(gears.table.join(
  awful.button({}, 1, function()
    if wifi then
      awful.spawn.with_shell("nmcli radio wifi off")
    else
      awful.spawn.with_shell("nmcli radio wifi on")
    end
  end)
))

local nig = false -- enabled in rc.lua using autostart

M.nig:buttons(gears.table.join(
  awful.button({}, 1, function()
    nig = not nig
    if nig then
      M.nig.fg = on
      awful.spawn.with_shell("redshift -x && redshift -O 4000K")
    else
      M.nig.fg = off
      awful.spawn.with_shell("redshift -x")
    end
  end)
))

return M
