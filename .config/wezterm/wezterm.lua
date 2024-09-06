local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback {
  { family = "JetBrainsMono Nerd Font Mono", harfbuzz_features = { "calt=0", "clig=0", "liga=0" } },
  "Meslo"
}
config.font_size = 16

config.color_scheme = 'Catppuccin Macchiato'

config.enable_tab_bar = false
-- config.window_decorations = "RESIZE"

config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

config.initial_cols = 100
config.initial_rows = 30

return config
