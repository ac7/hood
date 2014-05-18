
local Actor = require "actor"
local Human = require "human"
local Arrow = require "arrow"
local spritepack = require "spritepack"

local Archer = Human:extends{
	speed = 256,
	name = "Archer",
}

function Archer:__init()
	self.images = spritepack("archer")
	self.direction = "south"
	self.walk = 1
	self.walking = false
	self.image = self.images[self.direction][math.floor(self.walk)]
	Archer.super.__init(self, self.image)
end

function Archer:update(dt)
	self.image = self.images[self.direction][math.floor(self.walk)]
	self.walk = self.walk + dt * 3
	if self.walk >= 4 then
		self.walk = 1
	end
end

function Archer:move(delta_x, delta_y)
	local new_direction = ""

	if delta_y < -0.1 then
		new_direction = "north"
	elseif delta_y > 0.1 then
		new_direction = "south"
	end
	if delta_x < -0.1 then
		new_direction = new_direction .. "west"
	elseif delta_x > 0.1 then
		new_direction = new_direction .. "east"
	end

	if #new_direction > 0 then
		self.direction = new_direction
	end

	return Archer.super.move(self, delta_x, delta_y)
end

function Archer:shoot(target_x, target_y)
	assert(type(target_x) == "number" and type(target_y) == "number")
	assert(state)
	assert(type(state.actors) == "table")

	local arrow = Arrow(self, self.x, self.y, target_x, target_y)
	table.insert(state.actors, arrow)
end

return Archer

