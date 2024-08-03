local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"

config.font = wezterm.font("Hack Nerd Font")
config.font_size = 15

-- Disable the tab bar
config.enable_tab_bar = false

return config
