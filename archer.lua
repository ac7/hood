
local Actor = require "actor"
local Human = require "human"
local Arrow = require "arrow"
local spritepack = require "spritepack"

local Archer = Human:extends{
	name = "Archer",
	arrows = 12,
	bow_drawn = false,
	walk_speed = 200,
	run_speed = 325,
	packs = {
		normal = spritepack("archer"),
		bow_drawn = spritepack("archer2"),
	},
}

function Archer:__init()
	Archer.super.__init(self, self.packs.normal)
end

function Archer:update(dt)
	if self.bow_drawn then
		self.images = self.packs.bow_drawn
		self.speed = self.walk_speed
	else
		self.images = self.packs.normal
		self.speed = self.run_speed
	end
	Archer.super.update(self, dt)
end

function Archer:shoot(target_x, target_y)
	assert(type(target_x) == "number" and type(target_y) == "number")
	assert(state)
	assert(type(state.actors) == "table")

	if not self.bow_drawn then return end

	if self.arrows < 1 then return end
	self.arrows = self.arrows - 1

	self.direction = util.direction_from_angle(math.atan2(target_x - self.x, target_y - self.y))

	local arrow = Arrow(self, self.x, self.y, target_x, target_y)
	table.insert(state.actors, arrow)
end

return Archer

