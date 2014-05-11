
local Actor = require "actor"

local Archer = Actor:extends()

function Archer:__init()
	Archer.super.__init(self, "data/archer.png")
	self.y_offset = 0
	self.pulse = 0
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

return Archer

