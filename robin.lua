
local Archer = require "archer"
local factions = require "factions"
local Item = require "item"

local Robin = Archer:extends{
	faction = factions.MERRY_MEN
}

function Robin:update(dt)
	Robin.super.update(self, dt)
	local dir_x = 0
	local dir_y = 0

	if love.keyboard.isDown("w") then dir_y = -1; end
	if love.keyboard.isDown("a") then dir_x = -1; end
	if love.keyboard.isDown("s") then dir_y = 1; end
	if love.keyboard.isDown("d") then dir_x = 1; end

	if dir_x ~= 0 or dir_y ~= 0 then
		local angle = math.atan2(dir_x, dir_y)
		local delta_x = math.sin(angle) * dt * self.speed
		local delta_y = math.cos(angle) * dt * self.speed
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
	assert(state)
	if button == "l" then
		self:shoot(mx + state.offset_x, my + state.offset_y)
	elseif button == "r" then
		for _, v in pairs(state.actors) do
			assert(v)
			if v:is(Item) and util.touching(self, v) then
				self:take(v)
			end
		end
	end
end

return Robin

