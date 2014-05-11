
local Actor = require "actor"
local Arrow = require "arrow"

local Archer = Actor:extends()

function Archer:__init()
	Archer.super.__init(self, "data/archer.png")
	self.x = love.window.getWidth() / 2
	self.y = love.window.getHeight() / 2
	self.y_offset = 0
	self.pulse = 0
	self.speed = 256.0
end

function Archer:update(dt)
	self.pulse = self.pulse + dt * 3
	self.y_offset = math.sin(self.pulse) * 8
end

function Archer:draw()
	local old_y = self.y
	self.y = self.y + self.y_offset
	Archer.super.draw(self)
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

