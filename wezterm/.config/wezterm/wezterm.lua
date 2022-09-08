local wezterm = require("wezterm")

return {
  -- https://wezfurlong.org/wezterm/config/lua/config/term.html
  term = "wezterm",
  color_scheme = "Paradise",

  enable_tab_bar = false,
  default_cursor_style = "SteadyBar",
  force_reverse_video_cursor = true,

  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 10.3,

  window_padding = {
    left = 15,
    right = 15,
    top = 15,
    bottom = 15
  },

  check_for_updates = false,
  warn_about_missing_glyphs = false
}
