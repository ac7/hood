
local Human = require "human"

local HUD = class{
	x = 32,
	y = 32,
	width = 256,
	height = 16,
	active = true,
	health_slider = 0,
}

function HUD:__init(player)
	assert(player)
	assert(player:is(Human))
	self.player = player
end

function HUD:update(dt)
	self.health_slider = self.health_slider + (self.player.health - self.health_slider) * dt * 4
end

function HUD:draw()
	local percentage = math.max(0, self.health_slider / self.player.max_hp)
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("line", self.x-1, self.y-1, self.width+1, self.height+1)
	love.graphics.setColor(0, 255, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.width * percentage, self.height)
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", self.x + self.width * percentage, self.y, self.width * (1 - percentage), self.height)
end

return HUD

