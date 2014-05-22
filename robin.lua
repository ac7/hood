
local Archer = require "archer"
local factions = require "factions"
local Item = require "item"
local Toast = require "toast"

local Robin = Archer:extends{
	faction = factions.MERRY_MEN,
	pull = 0,
	pull_requirement = 0.5,
}

function Robin:update(dt)
	local dir_x = 0
	local dir_y = 0

	if love.keyboard.isDown("w") then dir_y = -1; end
	if love.keyboard.isDown("a") then dir_x = -1; end
	if love.keyboard.isDown("s") then dir_y = 1; end
	if love.keyboard.isDown("d") then dir_x = 1; end

	if self.pull > 0 then
		self.speed = self.speed / 2
	end

	if dir_x ~= 0 or dir_y ~= 0 then
		local angle = math.atan2(dir_x, dir_y)
		Robin.super.move(self, angle, dt * self.speed)
	end

	if self.bow_drawn and love.mouse.isDown("l") then
		assert(state.offset_x)
		assert(state.offset_y)
		self.pull = self.pull + dt
		local diff_x, diff_y = self.x - state.offset_x, self.y - state.offset_y
		diff_x = love.mouse.getX() - diff_x
		diff_y = love.mouse.getY() - diff_y
		local angle = math.atan2(diff_x, diff_y)
		self.direction = util.direction_from_angle(angle)
	else
		self.pull = 0
	end

	Robin.super.update(self, dt)
end

function Robin:keyreleased(key, unicode)
	if key == "r" then
		self.bow_drawn = not self.bow_drawn
	end
end

function Robin:mousereleased(mx, my, button)
	if not self.active then
		return
	end
	if button == "l" then
		if self.bow_drawn then
			if self.pull > self.pull_requirement then
				self:shoot(mx + state.offset_x, my + state.offset_y)
				if self.arrows <= 0 then
					table.insert(state.actors, Toast("Out of arrows!", self.x, self.y))
				end
			end
			self.pull = 0
		else
			self.bow_drawn = true
		end
	elseif button == "r" and not self.bow_drawn then
		local item = util.closest_touching(self, state.actors, function(actor)
			if actor:is(Item) then
				return true
			end
		end)
		if item ~= nil then
			self:take(item)
		end
	end
end

function Robin:draw(offset_x, offset_y)
	if self.bow_drawn and self.pull > 0 then
		love.graphics.setColor(255, 255, 255, math.max(0, math.min(120, 120 * (self.pull / self.pull_requirement))))
		love.graphics.setLineWidth(1)
		local mx, my = love.mouse.getPosition()
		love.graphics.line(self.x - offset_x, self.y - offset_y, mx, my)
		love.graphics.setColor(255, 255, 255, 16)
		love.graphics.arc("fill", self.x - offset_x, self.y - offset_y, self.width * 4/10,
			0, self.pull / self.pull_requirement * math.pi * 2, 32)
	end
	Robin.super.draw(self, offset_x, offset_y)
end

return Robin

