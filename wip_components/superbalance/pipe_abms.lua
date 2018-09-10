-- for now, we only register on straight pipes.
-- pipeworks:pipe_3_empty
local whack = _mod.whack

minetest.register_abm({
	label = "pipeworks long balance",
	interval = 2,
	chance = 20,
	nodenames = { "pipeworks:pipe_3_empty" },
	catch_up = false,
	action = function(pos)
		whack(pos, false)
	end,
})



