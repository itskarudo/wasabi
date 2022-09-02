local playerctl = require("misc.bling").signal.playerctl.lib()

local name = wibox.widget {
  {
    id = 'name',
    align = 'center',
    valign = 'center',
    forced_height = dpi(70),
    widget = wibox.widget.textbox,
  },
  fg = beautiful.pri,
  widget = wibox.container.background,
}

local prev = wibox.widget {
  align = 'center',
  font = beautiful.icofont,
  text = '',
  widget = wibox.widget.textbox,
}

local next = wibox.widget {
  align = 'center',
  font = beautiful.icofont,
  text = '',
  widget = wibox.widget.textbox,
}

local play = wibox.widget {
  {
    id = 'play',
    align = 'center',
    font = beautiful.icofont,
    text = '',
    widget = wibox.widget.textbox,
  },
  widget = wibox.container.background, 
}


playerctl:connect_signal("playback_status", function(_, playing, __)
  if playing then
    play:get_children_by_id('play')[1].text = ''
    play.fg = beautiful.pri
  else
    play.fg = beautiful.fg_minimize
    play:get_children_by_id('play')[1].text = ''
  end


end)

playerctl:connect_signal("metadata", function(_, title, artist, album_path, __, ___, ____)
  if title == "" then title = 'Unkown\n' end
  if artist == "" then artist = 'Unkown\n' end
  name:get_children_by_id('name')[1].text = string.format('%s by %s', title, artist)
end)


play:buttons(gears.table.join(
  awful.button({}, 1, function()
    playerctl:play_pause()
  end)
))

next:buttons(gears.table.join(
  awful.button({}, 1, function()
    playerctl:next()
  end)
))

prev:buttons(gears.table.join(
  awful.button({}, 1, function()
    playerctl:previous()
  end)
))

local player = wibox.widget {
  {
    {
      -- img,
      {
        name,
        {
          prev,
          play,
          next,
          layout = wibox.layout.flex.horizontal,
        },
        layout = wibox.layout.fixed.vertical,
      },
      layout = wibox.layout.flex.horizontal,
    },
    margins = dpi(15),
    widget = wibox.container.margin,
  },
  shape = help.rrect(2),
  -- fg = beautiful.pri,
  bg = beautiful.bg_minimize,
  widget = wibox.container.background,
}

return player
