
-- logtime_plugin.lua : charge le plugin logtime depuis le projet, sans rien copier. Sans le projet (pas de git clone

-- dans ~/Projet_Perso/logtime.wezterm), WezTerm démarre sans logtime : un plugin vide, qui ne fait rien.

-- `require("logtime_plugin")` garde le résultat en mémoire : tous les fichiers de la config partagent le MÊME plugin.

--

-- Si le chargement échoue, l'erreur est aussi écrite dans le fichier .logtime_erreur.txt de ton dossier personnel

-- (hors du dossier de config : pas de rechargement en boucle). Elle est effacée dès que le chargement réussit.

local wezterm = require("wezterm")



local sep = package.config:sub(1, 1)

local dir = wezterm.home_dir .. sep .. "Projet_Perso" .. sep .. "logtime.wezterm"

local path = dir .. sep .. "plugin" .. sep .. "init.lua"

local report_path = wezterm.home_dir .. sep .. ".logtime_erreur.txt"



local function report(message)

local out = io.open(report_path, "w")

if out then

out:write(os.date("%Y-%m-%d %H:%M:%S") .. "\n" .. message .. "\n")

out:close()

end

end



local f = io.open(path, "rb")

-- Pas de projet logtime sur cette machine : un plugin vide (pas de compteur, pas d'erreur)

if not f then

os.remove(report_path)

return {

apply_to_config = function() end,

tick = function()

return ""

end,

}

end

local source = f:read("*a")

f:close()



local chunk, err = load(source, "@" .. path)

if not chunk then

report("syntaxe : " .. tostring(err))

error("logtime : " .. tostring(err), 0)

end



local ok, result = xpcall(chunk, function(e)

return tostring(e)

end, dir)

if not ok then

report("chargement : " .. result)

error("logtime : " .. result, 0)

end



os.remove(report_path)

return result

