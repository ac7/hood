
local Actor = require "actor"
local Human = require "human"
local Arrow = require "arrow"

local Archer = Human:extends{
	speed = 256,
	name = "Archer",
}

function Archer:__init()
	Archer.super.__init(self, "archer.png")
	self.x = 0
	self.y = 0
end

function Archer:update(dt)
end

function Archer:shoot(target_x, target_y)
	assert(type(target_x) == "number" and type(target_y) == "number")
	assert(state)
	assert(type(state.actors) == "table")

	local arrow = Arrow(self, self.x, self.y, target_x, target_y)
	table.insert(state.actors, arrow)
end

return Archer

