local t = "superbalance_indicator.png"
local tex = {t,t,t,t,t,t}
local n = "superbalance:indicator"


local limit = 0.5
local step = function(self, dtime)
	local age = self.age or 0
	age = age + dtime
	if age > limit then
		self.object:remove()
	else
		self.age = age
	end
end

minetest.register_entity(n, {
	hp_max = 1,
	visual = "cube",
	textures = tex,
	on_step = step,
})

return n

