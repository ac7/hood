
local NPC = require "npc"
local Rock = require "rock"
local Tree = require "tree"
local Apple = require "apple"
local factions = require "factions"

local function random_actor()
	local n = math.random(4)
	if n == 1 then
		return NPC("hostile", math.random(3))
	elseif n == 2 then
		return Tree()
	elseif n == 3 then
		return Apple()
	elseif n == 4 then
		return Rock()
	end
	error("You forgot to change the random parameter.")
end

local function generate(actors)
	assert(type(actors) == "table")
	local cap = math.random(512)
	for i=1,cap do
		local actor = random_actor()
		local safety_counter = 10
		repeat
			actor.x = math.random(-2000, 2000)
			actor.y = math.random(-2000, 2000)
			safety_counter = safety_counter - 1
		until util.closest_touching(actor, actors) == nil or safety_counter <= 0
		table.insert(actors, actor)
	end
end

return generate

