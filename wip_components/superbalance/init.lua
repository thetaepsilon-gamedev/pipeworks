--[[
superbalance: longer distance pressure balancing for pipeworks
]]
_mod = {}

local n = minetest.get_current_modname()
local mp = minetest.get_modpath(n) .. "/"
local successor, hash = dofile(mp.."successor.lua")
_mod.successor = successor
_mod.hasher = hash

-- for testing: register a simple indicator entity
local entname = dofile(mp.."indicator.lua")

-- search algorithm bits
local do_search = dofile(mp.."do_search.lua")

-- balance found nodes
local balance = dofile(mp.."balance_node_set.lua")





-- "whack" a pipe to make it do a long balance and get water moving again
local debug = true
local whack = function(bpos, always_show)
	local positions = do_search(bpos)

	local show = debug or always_show
	if show then
		for hash, npos in pairs(positions) do
			minetest.add_entity(npos, entname)
		end
	end
	balance(positions)
end
_mod.whack = whack

-- load manual debug tool
dofile(mp.."debug_tool.lua")





-- clear internal mod table so other mods don't see it
_mod = {}

