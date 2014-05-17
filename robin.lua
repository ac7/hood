
local Archer = require "archer"
local factions = require "factions"

local Robin = Archer:extends{
	faction = factions.MERRY_MEN
}

function Robin:update(dt)
	Robin.super.update(self, dt)
	local delta_x = 0
	local delta_y = 0
	if love.keyboard.isDown("a") then
		delta_x = -dt * self.speed
	end
	if love.keyboard.isDown("d") then
		delta_x = dt * self.speed
	end
	if love.keyboard.isDown("w") then
		delta_y = -dt * self.speed
	end
	if love.keyboard.isDown("s") then
		delta_y = dt * self.speed
	end
	if delta_x ~= 0 or delta_y ~= 0 then
		local x_collision, y_collision = false, false
		if #self:find_collisions(self.x + delta_x, self.y) > 0 then
			x_collision = true
		end
		if #self:find_collisions(self.x, self.y + delta_y) > 0 then
			y_collision = true
		end
		if not x_collision then
			self.x = self.x + delta_x
		end
		if not y_collision then
			self.y = self.y + delta_y
		end
	end
end

function Robin:mousereleased(mx, my, button)
	if button == "l" then
		self:shoot(mx + state.offset_x, my + state.offset_y)
	end
end

return Robin

