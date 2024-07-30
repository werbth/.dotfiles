local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"

config.font = wezterm.font("Hack Nerd Font")
config.font_size = 16

return config
