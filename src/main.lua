local mods = rom.mods

mods['SGG_Modding-ENVY'].auto()

rom = rom
_PLUGIN = PLUGIN

game = rom.game
import_as_fallback(game)

modutil = mods['SGG_Modding-ModUtil']
chalk = mods["SGG_Modding-Chalk"]
reload = mods['SGG_Modding-ReLoad']

config = chalk.auto 'config.lua'
public.config = config

local function on_ready()
	-- what to do when we are ready, but not re-do on reload.
	if config.enabled == false then return end

	import 'ready.lua'
end

local function on_reload()
	-- what to do when we are ready, but also again on every reload.
	-- only do things that are safe to run over and over.
	
	import 'reload.lua'
end

-- this allows us to limit certain functions to not be reloaded.
local loader = reload.auto_single()

-- this runs only when modutil and the game's lua is ready
modutil.on_ready_final(function()
	print("Starting clock")
	loader.load(on_ready, on_reload)
end)
