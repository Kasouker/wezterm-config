local wezterm = require("wezterm")
local logtime = require("logtime_plugin")
local M = {}

-- Le nom donné à l'onglet (tab:set_title, comme « Logtime » ou « Logtime · Settings »), ou "" s'il n'en a pas.
local function has_title(tab)
	return tab.tab_title ~= nil and tab.tab_title ~= ""
end
local function no_title(tab)
	return not has_title(tab)
end
local function slash(text)
	return "/" .. text
end

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
		sections = {
			-- un onglet qui a un nom l'affiche ; les autres, comme avant (le dossier, ou le programme)
			tab_active = {
				"index",
				{ "tab", icons_enabled = false, padding = { left = 0, right = 1 }, cond = has_title },
				{ "parent", padding = 0, cond = no_title },
				{ "cwd", padding = { left = 0, right = 1 }, cond = no_title, fmt = slash },
				{ "zoomed", padding = 0 },
			},
			tab_inactive = {
				"index",
				{ "tab", icons_enabled = false, padding = { left = 0, right = 1 }, cond = has_title },
				{ "process", padding = { left = 0, right = 1 }, cond = no_title },
			},
			tabline_x = {},
			tabline_y = {
				function(window)
					return logtime.tick(window)
				end,
			},
			tabline_z = {},
		},
	})
	tabline.apply_to_config(config)
	config.status_update_interval = 1000
end

return M