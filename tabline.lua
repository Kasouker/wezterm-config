local wezterm = require("wezterm")
local M = {}

function M.apply(config)
	local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
	tabline.setup({
		options = {
			theme_overrides = {
				normal_mode = {
					a = { fg = "#17191F", bg = "#C9AB6B" },
					b = { fg = "#C9AB6B", bg = "#2B2E36" },
					c = { fg = "#8B8E99", bg = "#1B1E25" },
				},
				tab = {
					active = { fg = "#C9AB6B", bg = "#2B2E36" },
					inactive = { fg = "#8B8E99", bg = "#1B1E25" },
					inactive_hover = { fg = "#D8D3C6", bg = "#2B2E36" },
				},
			},
		},
	})
	tabline.apply_to_config(config)
end

return M