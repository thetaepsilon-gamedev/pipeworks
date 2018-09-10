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




local whack = function(bpos)
	local positions = do_search(bpos)

	for hash, npos in pairs(positions) do
		minetest.add_entity(npos, entname)
	end
end
local use = function(itemstack, user, pointed)
	if pointed.type == "node" then
		whack(pointed.under)
	end
end
local inv = "superbalance_indicator.png"
local whacker = "superbalance:debug_tool"
minetest.register_craftitem(whacker, {
	inventory_image = inv,
	on_use = use,
})



-- clear internal mod table so other mods don't see it
_mod = {}

