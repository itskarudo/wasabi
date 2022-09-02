local M = {}

M.bri = wibox.widget {
  bar_shape           = help.rrect(2),
  bar_height          = dpi(20),
  bar_color           = beautiful.bg_minimize,
  handle_color        = beautiful.pri,
  handle_shape        = help.rrect(2),
  forced_height       = dpi(20),
  widget              = wibox.widget.slider,
}

M.vol = wibox.widget {
  bar_shape           = help.rrect(2),
  bar_height          = dpi(20),
  bar_color           = beautiful.bg_minimize,
  handle_color        = beautiful.pri,
  handle_shape        = help.rrect(2),
  forced_height       = dpi(20),
  widget              = wibox.widget.slider,
}

M.bat = wibox.widget {
  max_value          = 100,
  value              = 10,
  forced_height      = dpi(20),
  shape              = help.rrect(2),
  color              = beautiful.pri,
  background_color   = beautiful.bg_minimize,
  widget             = wibox.widget.progressbar,
}

awesome.connect_signal('signal::brightness', function(val)
  M.bri.value = val
end)

awesome.connect_signal('signal::volume', function(val, _)
  M.vol.value = val
end)

awesome.connect_signal('signal::battery', function(val, stat)
  if stat == 1 then
    M.bat.color = beautiful.pri
  else
    M.bat.color = beautiful.fg_minimize
  end
  M.bat.value = val
end)

M.vol:connect_signal('property::value', function(val)
  awful.spawn.with_shell("killall amixer;amixer set Master " .. val.value .."%")
end)

M.bri:connect_signal('property::value', function(val)
  awful.spawn.with_shell("killall brightnessctl;brightnessctl set " .. val.value .."%" )
end)

return M
