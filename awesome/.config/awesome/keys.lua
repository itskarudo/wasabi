require("lockscreen").init()
-- Variables
local keys = {}

local mod = 'Mod4'
local tags = 7
keys.tags = tags

-- Keybindings
keys.globalkeys = gears.table.join(
  -- Awesome
  awful.key({mod, 'Shift'}, 'r', awesome.restart),
  awful.key({mod}, 'd', function() dashboard.toggle() end),
  awful.key({mod, 'Shift'}, 'e', awesome.quit),
  awful.key({mod, 'Shift'}, 'l', function() lock_screen_show() end),

  --Hardware
  awful.key({}, 'XF86MonBrightnessUp', function() awful.spawn.with_shell('brightnessctl set 5%+ -q') end),
  awful.key({}, 'XF86MonBrightnessDown', function() awful.spawn.with_shell('brightnessctl set 5%- -q') end),
  awful.key({}, 'XF86AudioRaiseVolume', function() awful.spawn.with_shell('pactl set-sink-volume @DEFAULT_SINK@ +5%') end),
  awful.key({}, 'XF86AudioLowerVolume', function() awful.spawn.with_shell('pactl set-sink-volume @DEFAULT_SINK@ -5%') end),
  awful.key({}, 'XF86AudioMute', function() awful.spawn.with_shell('pactl set-sink-mute @DEFAULT_SINK@ toggle') end),

  -- Window management
  awful.key({'Mod1'}, 'Tab', function() awful.client.focus.byidx(1) end),

  awful.key({mod}, 'h', function () awful.client.focus.bydirection("left") end),
  awful.key({mod}, 'j', function () awful.client.focus.bydirection("down") end),
  awful.key({mod}, 'k', function () awful.client.focus.bydirection("up") end),
  awful.key({mod}, 'l', function () awful.client.focus.bydirection("right") end),

  awful.key({mod, 'Mod1'}, 'l', function () awful.tag.incmwfact(0.05) end),
  awful.key({mod, 'Mod1'}, 'h', function () awful.tag.incmwfact(-0.05) end),
  awful.key({mod, 'Mod1'}, 'k', function () awful.client.incwfact(0.05) end),
  awful.key({mod, 'Mod1'}, 'j', function () awful.client.incwfact(-0.05) end),

  -- Applications
  awful.key({mod}, 'Return', function() awful.util.spawn('kitty') end),
  awful.key({mod}, 'space', function() awful.util.spawn('rofi -show drun') end),
  awful.key({mod}, 'b', function() awful.util.spawn('firefox') end),
  awful.key({mod}, 'e', function() awful.util.spawn('kitty -e ranger') end),

  -- Screenshots
  awful.key({}, 'Print', function() awful.util.spawn('flameshot gui') end)
)

-- Keyboard Control
keys.clientkeys = gears.table.join(
  awful.key({mod}, 'w', function(c) c:kill() end),
  awful.key({mod}, 'Tab', function() awful.client.floating.toggle() end)
)

-- Mouse controls
keys.clientbuttons = gears.table.join(
  awful.button({}, 1, function(c) client.focus = c end),
  awful.button({mod}, 1, function() awful.mouse.client.move() end),
  awful.button({mod}, 2, function(c) c:kill() end),
  awful.button({mod}, 3, function() awful.mouse.client.resize() end)
)

for i = 1, tags do
  keys.globalkeys = gears.table.join(keys.globalkeys,

  -- View tag
  awful.key({mod}, '#'..i + 9,
    function ()
      local tag = awful.screen.focused().tags[i]
      if tag then
         tag:view_only()
      end
    end),

  -- Move window to tag
  awful.key({mod, 'Shift'}, '#'..i + 9,
    function ()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
     end
    end))
end

-- Set globalkeys
root.keys(keys.globalkeys)

return keys
