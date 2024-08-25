local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback { "JetBrainsMono Nerd Font Mono", "Meslo" }
config.font_size = 16

config.color_scheme = 'Catppuccin Macchiato'

config.enable_tab_bar = false
-- config.window_decorations = "RESIZE"

config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

config.initial_cols = 120
config.initial_rows = 36

return config
