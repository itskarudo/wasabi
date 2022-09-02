-- Importing libraries
gears = require('gears')
awful = require('awful')
wibox = require('wibox')
naughty = require("naughty")
beautiful = require('beautiful')
dpi = beautiful.xresources.apply_dpi

beautiful.init('~/.config/awesome/theme/init.lua')
keys = require('keys')
help = require('help')
dashboard = require("dashboard")

local req = {
  'notif',
  'bar',
  'menu',
  'rule',
  'titlebar',
  'client',
  'signals',
  'OSD',
  'awful.autofocus'
}

for _, x in pairs(req) do
  require(x)
end

-- Layouts
awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating,
  }


-- Virtual desktops/ Tabs
awful.screen.connect_for_each_screen(function(s)
  local tagTable = {}
  for i = 1, keys.tags do
    table.insert(tagTable, tostring(i))
  end
  awful.tag(tagTable, s, awful.layout.layouts[1])
end)

-- Autostart
awful.spawn.with_shell('nitrogen --restore')
awful.spawn("setxkbmap -option caps:ctrl_modifier")
awful.spawn("setxkbmap -layout us,ar -option grp:alt_shift_toggle")

-- Garbage Collection
collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)
