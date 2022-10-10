local menu = {
  { "Refresh", awesome.restart },
  { "Logout", function() awesome.quit() end },
  { "Reboot", function() awful.spawn.with_shell("reboot") end},
  { "Shutdown", function() awful.spawn.with_shell("shutdown now") end},
}

local main = awful.menu {
  items = {
    {
      "Awesome",
      menu,
    },
    { "Terminal", "wezterm" },
    { "Browser", "firefox" },
    { "Files", "nemo" },
    { "Editor", "mousepad" },
  }
}

main.wibox.shape = help.rrect(2)

root.buttons(gears.table.join(
  awful.button({ }, 3, function () main:toggle() end)
))
