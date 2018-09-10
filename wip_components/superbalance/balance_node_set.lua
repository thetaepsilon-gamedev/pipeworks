-- balance out a provided set of nodes.
local get_pressure_access = pipeworks.flowlogic.get_pressure_access

local balance = function(nodeset)
	-- pressure handles to average over
	local connections = {}
	-- average calculation
	local totalv = 0
	local totalc = 0

	-- for each neighbour, add neighbour's pressure to the total to balance out
	for hash, pos in pairs(nodeset) do
		local pressure = get_pressure_access(pos)
		local n = pressure.get()
		totalv = totalv + n
		totalc = totalc + 1
		connections[hash] = pressure
	end
	local average = totalv / totalc
	for _, target in pairs(connections) do
		target.set(average)
	end

	return average
end



return balance

