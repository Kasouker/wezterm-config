local wezterm = require("wezterm")
local M = {}

function M.apply(config)
	config.color_scheme = "Tokyo Night"
	config.colors = {
		foreground = "#C9C7BD",
		cursor_bg = "#C9AB6B",
		cursor_border = "#C9AB6B",
		cursor_fg = "#14181F",
		selection_bg = "#3A4454",
		selection_fg = "#E6E2D6",
		ansi = {
			"#1B2028", "#A5545F", "#7A9A7E", "#C9AB6B",
			"#6F93AD", "#9C7BA3", "#5F9A9A", "#C9C7BD",
		},
		brights = {
			"#4A5362", "#C0707A", "#93B497", "#DCC58A",
			"#8DB0C9", "#B596BC", "#7FB5B5", "#E6E2D6",
		},
	}
	config.font = wezterm.font("IosevkaTerm Nerd Font", { weight = "Bold" })
	config.font_size = 12.5
	config.window_background_opacity = 0.9
	config.window_decorations = "RESIZE"
	config.default_cursor_style = "BlinkingBar"
	config.audible_bell = "Disabled"
	config.window_close_confirmation = "NeverPrompt"
	-- Sous Windows on ouvre WSL ; sous Linux, le shell par défaut suffit
	if wezterm.target_triple:find("windows") then
		config.default_domain = "WSL:Ubuntu"
	end
end

return M
