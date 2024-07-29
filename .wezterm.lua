local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"

config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 15

return config
