
local Actor = require "actor"
local Human = require "human"
local Arrow = require "arrow"
local spritepack = require "spritepack"

local Archer = Human:extends{
	speed = 256,
	name = "Archer",
	arrows = 12,
}

function Archer:__init()
	Archer.super.__init(self, spritepack("archer"))
end

function Archer:shoot(target_x, target_y)
	assert(type(target_x) == "number" and type(target_y) == "number")
	assert(state)
	assert(type(state.actors) == "table")

	if self.arrows < 1 then return end
	self.arrows = self.arrows - 1

	self.direction = util.direction_from_delta(target_x - self.x, target_y - self.y)

	local arrow = Arrow(self, self.x, self.y, target_x, target_y)
	table.insert(state.actors, arrow)
end

return Archer

