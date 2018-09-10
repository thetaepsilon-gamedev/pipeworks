-- pipeworks internally already has the making of a successor function
-- (as defined by libmt_node_network; remember, graph theory):
local get_neighbours_positions = pipeworks.flowlogic.get_neighbour_positions
-- however, there are a few things missing.
-- first is hashing behaviour (again, libmt_node_network has the rationale):

local int = function(v)
	assert(v % 1.0 == 0)
	return v
end
local hash = function(pos)
	local x = int(pos.x)
	local y = int(pos.y)
	local z = int(pos.z)
	return "("..x..","..y..","..z..")"
end

-- secondly, right now the signature of the successor doesn't match requirements.
-- get_neighbour_positions has signature (pos, node)
-- and returns an array-like list;
-- the successor for the graph search, instead, gets vertex and hash.
-- node can be supplied by loading node data via minetest.get_node.

--[[
We also want to do something extra here;
we want to "inject" an age of sorts into the position tables of the graph.
The origin node has age 0; every time the successor function is ran,
the returned successors have an age one more than their originating node.
This way, we can track how far away from the origin a node is;
the properties of the breadth first guarantee this is the shortest distance,
as any other touches of that node thereafter will be considered already visited.

We can then use this property to impose a constraint on the breadth first search.
The "testvertex" callback is set up such that positions over a certain age are rejected.
]]
local getnode = minetest.get_node



-- NB: we know that get_neighbours_positions returns new vectors,
-- as internally it uses vector.add.
-- XXX: maybe that should be guaranteed on the interface!
local successor = function(bpos, _)
	local node = getnode(bpos)
	local positions = get_neighbours_positions(bpos, node)
	local age = bpos.age + 1
	-- in-place conversion to hash set form
	for i, pos in ipairs(positions) do
		local k = hash(pos)
		pos.age = age
		positions[k] = pos
	end
	return positions
end

return successor, hash

