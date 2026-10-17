local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("wallpaper").apply(config)
require("tabline").apply(config)
require("appearance").apply(config)
require("keys").apply(config)

require("logtime_plugin").apply_to_config(config, { week_starts_on = "monday", lang = "en", open_key = "F2" })

return config
