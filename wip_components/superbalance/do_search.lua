local successor = _mod.successor
local hash = _mod.hasher

-- so we have a compatible successor now.
-- next we want a visitor which collects into a table for the time being
local mk_collector = function()
	local hashset = {}
	local visitor = function(vertex, hash)
		hashset[hash] = vertex
	end
	return visitor, hashset
end
-- TODO: age check goes here

local nn = "com.github.thetaepsilon.minetest.libmt_node_network"
local newsearchraw = mtrequire(nn..".floodsearch.bfmap").new
local do_search = function(pos)
	pos.age = 0
	local visitor, hashset = mk_collector()
	local callbacks = {visitor=visitor}
	local ihash = hash(pos)
	local opts = nil

	local search = newsearchraw(pos, hash, successor, callbacks, opts)
	while search.advance() do end
	return hashset
end



return do_search

