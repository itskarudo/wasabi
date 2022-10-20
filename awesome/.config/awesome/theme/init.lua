local theme = {}
local gfs = require("gears.filesystem")
local theme_path = gfs.get_configuration_dir() .. "/theme/"
local images_path = gfs.get_configuration_dir() .. "/images/"

local scheme = require("theme.gruvbox")

theme.font = 'FantasqueSansMono Nerd Font Mono '
theme.icofont = 'Material 14'

theme.ok = scheme.ok
theme.err = scheme.err
theme.pri = scheme.pri

theme.music = theme_path..'close.svg'

theme.fg_normal = scheme.fg_normal
theme.fg_focus= scheme.fg_focus
theme.fg_minimize = scheme.fg_minimize

theme.bg_normal = scheme.bg_normal
theme.bg_focus= scheme.bg_focus
theme.bg_urgent = scheme.bg_urgent
theme.bg_minimize = scheme.bg_minimize

theme.useless_gap = dpi(5)
theme.snap_bg = theme.fg_focus

theme.border_width = dpi(5)
theme.border_color = theme.bg_normal

theme.titlebar_fg = theme.fg_normal
theme.titlebar_fg_normal = theme.fg_normal
theme.titlebar_fg_focus = theme.fg_focus
theme.titlebar_bg = theme.bg_normal
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_font = theme.font .. '10'

theme.taglist_bg = theme.bg_normal
theme.taglist_bg_focus = theme.bg_focus
theme.taglist_font = theme.font .. '14'

theme.menu_bg_normal = theme.bg_normal
theme.menu_bg_focus = theme.bg_minimize
theme.menu_font = theme.font .. '10'
theme.menu_border_color = theme.bg_normal
theme.menu_height = dpi(30)
theme.menu_width  = dpi(130)
theme.menu_border_width = dpi(10)
theme.menu_submenu_icon = theme_path.."menu.svg"

theme.tasklist_plain_task_name = true

theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_width = dpi(200)

theme.separator_color = theme.fg_normal

theme.titlebar_minimize_button_normal = theme_path.."minimize.svg"
theme.titlebar_minimize_button_focus= theme_path.."minimize.svg"

theme.titlebar_close_button_normal = theme_path.."close.svg"
theme.titlebar_close_button_focus= theme_path.."close.svg"

theme.titlebar_maximized_button_normal_inactive = theme_path.."maximize.svg"
theme.titlebar_maximized_button_focus_inactive= theme_path.."maximize.svg"
theme.titlebar_maximized_button_normal_active = theme_path.."maximize.svg"
theme.titlebar_maximized_button_focus_active= theme_path.."maximize.svg"

theme.icon_theme = nil

theme.pfp = images_path .. "profile.jpg"

return theme
