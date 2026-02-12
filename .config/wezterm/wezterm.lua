local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback {
  { family = "JetBrainsMonoNL Nerd Font Mono", weight="Medium", harfbuzz_features = { 'calt=1', 'clig=0', 'liga=0' } },
  "Menlo",
  "Monaco",
  "Courier New",
  "monospace"
}
config.font_size = 16
config.line_height = 1.1

config.color_scheme = 'Catppuccin Mocha'

config.enable_tab_bar = false
-- config.window_decorations = "RESIZE"

config.window_background_opacity = 0.85
-- config.macos_window_background_blur = 10

config.initial_cols = 100
config.initial_rows = 30

return config
