
local Archer = require "archer"
local util = require "util"

local NPC = Archer:extends{
	strategy = "neutral",
	wander_point_x = 0.0,
	wander_point_y = 0.0,
	wander_distance = 512,
	speed = 64,
}

function NPC:update(dt)
	local choose_new_point = false
	if util.dist(self.x, self.y, self.wander_point_x, self.wander_point_y)
	< (self.width + self.height) / 2 then
		choose_new_point = true
	else
		if self.wander_point_x < self.x then
			choose_new_point = not self:move(-self.speed*dt, 0)
		else
			choose_new_point = not self:move(self.speed*dt, 0)
		end

		if self.wander_point_y < self.y then
			choose_new_point = not self:move(0, -self.speed*dt)
		else
			choose_new_point = not self:move(0, self.speed*dt)
		end
	end

	if choose_new_point then
		if self.strategy == "neutral" then
			self.wander_point_x = self.x + (math.random() - 0.5) * self.wander_distance
			self.wander_point_y = self.y + (math.random() - 0.5) * self.wander_distance
		elseif self.strategy == "hostile" then
		end
	end
end

return NPC

