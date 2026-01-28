local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback {
  { family = "JetBrainsMonoNL Nerd Font Mono", harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' } },
  "Meslo"
}
config.font_size = 15
config.line_height = 1.1

config.color_scheme = 'Catppuccin Mocha'

config.enable_tab_bar = false
-- config.window_decorations = "RESIZE"

config.window_background_opacity = 0.85
-- config.macos_window_background_blur = 10

config.initial_cols = 120
config.initial_rows = 40

return config
