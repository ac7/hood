
local Archer = require "archer"

local Robin = Archer:extends()

function Robin:update(dt)
	Robin.super.update(self, dt)
	if love.keyboard.isDown("a") then
		self.x = self.x - dt * self.speed
	end
	if love.keyboard.isDown("d") then
	    self.x = self.x + dt * self.speed
	end
	if love.keyboard.isDown("w") then
	    self.y = self.y - dt * self.speed
	end
	if love.keyboard.isDown("s") then
		self.y = self.y + dt * self.speed
	end
end

function Robin:mousereleased(mx, my, button)
	if button == "l" then
		self:shoot(mx, my)
	end
end

return Robin

