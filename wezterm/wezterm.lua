local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 14

config.color_scheme = 'Catppuccin Macchiato'

config.enable_tab_bar = false
-- config.window_decorations = "RESIZE"

config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

config.initial_cols = 120
config.initial_rows = 36

return config
