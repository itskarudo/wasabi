client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Rounded Corners
client.connect_signal("manage", function (c)
  awful.client.setslave(c)
end)
