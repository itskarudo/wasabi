-- Importing libraries
gears = require('gears')
awful = require('awful')
wibox = require('wibox')
naughty = require("naughty")
beautiful = require('beautiful')
dpi = beautiful.xresources.apply_dpi

beautiful.init('~/.config/awesome/theme/init.lua')
keys = require('keys')
sig = require('signals')
help = require('help')
dashboard = require("dashboard")

local req = {
  'notif',
  'bar',
  'menu',
  'rule',
  'titlebar',
  'client',
  'awful.autofocus',
}

for _, x in pairs(req) do
  require(x)
end

-- Layouts
tag.connect_signal("request::default_layouts", function()

  awful.layout.append_default_layouts({
    awful.layout.suit.tile.right,
    awful.layout.suit.floating,
  })

end)

-- Virtual desktops/ Tabs
awful.screen.connect_for_each_screen(function(s)
  local tagTable = {}
  for i = 1, keys.tags do
    table.insert(tagTable, tostring(i))
  end
  awful.tag(tagTable, s, awful.layout.layouts[1])
end)

-- Autostart
awful.spawn.with_shell('pulsemixer --unmute')
awful.spawn.with_shell('flameshot &')
awful.spawn("xinput set-prop 12 'libinput Tapping Enabled' 1")
awful.spawn("xinput set-prop 12 'libinput Natural Scrolling Enabled' 1")
awful.spawn("setxkbmap -option caps:ctrl_modifier")

-- Garbage Collection
collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)
