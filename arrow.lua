
local Actor = require "actor"

local Arrow = Actor:extends()

function Arrow:__init(parent, x, y, target_x, target_y)
	Arrow.super.__init(self, "data/arrow.png")
	for _, v in pairs({x, y, target_x, target_y}) do
		assert(type(v) == "number")
	end
	self.x = x
	self.y = y

	self.angle = math.atan2(target_x - self.x, target_y - self.y)
	self.speed = 512.0

	if parent then
		assert(parent:is(Actor))
		self.parent = parent
	end
end

function Arrow:update(dt)
	self.x = self.x + math.sin(self.angle) * dt * self.speed
	self.y = self.y + math.cos(self.angle) * dt * self.speed
end

function Arrow:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image, self.x, self.y, -self.angle, 1, 1, self.width/2, self.height/2)
end

return Arrow

