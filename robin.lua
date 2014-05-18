
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
		Robin.super.move(self, delta_x, delta_y)
	end
end

function Robin:mousereleased(mx, my, button)
	assert(state)
	if not self.active then
		return
	end
	if button == "l" then
		self:shoot(mx + state.offset_x, my + state.offset_y)
	elseif button == "r" then
		for _, v in pairs(state.actors) do
			assert(v)
			if v:is(Item) and util.touching(self, v) then
				self:take(v)
				break
			end
		end
	end
end

return Robin

