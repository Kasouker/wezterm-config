local wezterm = require("wezterm")
local M = {}

local wallpaper_dir = "C:/Users/gazou/Projet_Perso/wallpapers"

local function get_random_wallpaper()
	local files = {}
	local ok, list = pcall(wezterm.glob, wallpaper_dir .. "/*")
	if ok and list then
		for _, f in ipairs(list) do
			local lower = f:lower()
			if lower:match("%.jpg$") or lower:match("%.jpeg$") or lower:match("%.png$") then
				table.insert(files, f)
			end
		end
	end
	if #files == 0 then
		return nil
	end
	return files[math.random(#files)]
end

function M.apply(config)
	wezterm.GLOBAL.tab_backgrounds = wezterm.GLOBAL.tab_backgrounds or {}

	wezterm.on("update-status", function(window, pane)
		local tab_id = tostring(window:active_tab():tab_id())
		if not wezterm.GLOBAL.tab_backgrounds[tab_id] then
			wezterm.GLOBAL.tab_backgrounds[tab_id] = get_random_wallpaper()
		end
		local bg_path = wezterm.GLOBAL.tab_backgrounds[tab_id]
		if bg_path then
			window:set_config_overrides({
				background = {
					{
						source = { File = bg_path },
						hsb = { brightness = 0.075 },
						horizontal_align = "Center",
					},
				},
			})
		end
	end)
end

return M