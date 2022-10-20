local M = {}

-- Wifi
M.net = wibox.widget {
  font = beautiful.icofont,
  align = 'center',
  widget = wibox.widget.textbox,
}

-- Volume
M.vol = wibox.widget {
  font = beautiful.icofont,
  align = 'center',
  widget = wibox.widget.textbox,
}

-- Battery
M.bat = wibox.widget {
  font = beautiful.icofont,
  align = 'center',
  widget = wibox.widget.textbox,
}

-- Clock
M.clock = wibox.widget {
  font = beautiful.font .. '14',
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox
}

awesome.connect_signal("signal::wifi", function(stat)
  if stat then
    M.net.markup = ""
  else
    M.net.markup = ""
  end
end)

awesome.connect_signal('signal::volume', function(val, mut)
  if mut then
    M.vol.markup = ""
  else
    if val > 60 then
      M.vol.markup = ""
    elseif val > 30 then
      M.vol.markup = ""
    else
      M.vol.markup = ""
    end
  end
end)

awesome.connect_signal('signal::battery', function(val, stat)
  if stat == 1 then
    if val < 100 then
      M.bat.markup = ""
    else
      M.bat.markup = ""
    end
  else
    M.bat.markup = ""
  end
end)

gears.timer {
  timeout = 60,
  autostart = true,
  call_now = true,
  callback = function()
    M.clock.markup = os.date("%H\n%M")
  end
}

return M
