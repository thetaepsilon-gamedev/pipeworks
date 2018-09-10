-- debug tool: force a long balance or view current pressure
local whack = _mod.whack



local use = function(itemstack, user, pointed)
	if pointed.type == "node" then
		whack(pointed.under)
	end
end
local place = function(itemstack, user, pointed)
	if user:is_player() then
		local pos = pointed.under
		local v = minetest.get_meta(pos):get_float("pipeworks.water_pressure")
		local name = user:get_player_name()
		minetest.chat_send_player(name, "pressure = "..v)
	end
end
local inv = "superbalance_indicator.png"
local whacker = "superbalance:debug_tool"
minetest.register_craftitem(whacker, {
	inventory_image = inv,
	on_use = use,
	on_place = place,
})

