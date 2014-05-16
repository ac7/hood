
local Actor = require "actor"
local Human = require "human"
local Arrow = require "arrow"

local Archer = Human:extends{
	y_offset = 0,
	pulse = 0,
	speed = 256,
	name = "Archer",
}

function Archer:__init()
	Archer.super.__init(self, "archer.png")
	self.x = 0
	self.y = 0
end

function Archer:update(dt)
	self.pulse = self.pulse + dt * 3
	self.y_offset = math.sin(self.pulse) * 8
end

function Archer:draw(offset_x, offset_y)
	local old_y = self.y
	self.y = self.y + self.y_offset
	Archer.super.draw(self, offset_x, offset_y)
	self.y = old_y
end

function Archer:shoot(target_x, target_y)
	assert(type(target_x) == "number" and type(target_y) == "number")
	assert(state)
	assert(type(state.actors) == "table")

	local arrow = Arrow(self, self.x, self.y, target_x, target_y)
	table.insert(state.actors, arrow)
end

return Archer

