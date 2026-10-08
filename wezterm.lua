local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("wallpaper").apply(config)
require("tabline").apply(config)
require("appearance").apply(config)
require("keys").apply(config)

return config