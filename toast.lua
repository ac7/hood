
local Actor = require "actor"

Toast = Actor:extends{
	lifetime = 1,
	fadetime = 1,
	font = fonts.small,
	phrase = "Toast",
	z = 1,
	collideable = false,
}

function Toast:__init(phrase, x, y)
	assert(type(phrase) == "string")
	assert(type(x) == "number")
	assert(type(y) == "number")
	self.phrase = phrase
	self.width = self.font:getWidth(phrase)
	self.height = self.font:getHeight()
	self.x = x
	self.y = y
end

function Toast:update(dt)
	if self.lifetime <= 0 then
		self.fadetime = self.fadetime - dt
		if self.fadetime <= 0 then
			self.active = false
		end
		self.y = self.y - dt * 32
	else
		self.lifetime = self.lifetime - dt
	end
end

function Toast:draw(offset_x, offset_y)
	love.graphics.setColor(0, 0, 0, math.max(0, 100 * self.fadetime))
	love.graphics.rectangle("fill", self.x - self.width*2/3 - offset_x, self.y - offset_y - 4, self.width*4/3, self.height + 8)
	love.graphics.setFont(self.font)
	love.graphics.setColor(255, 255, 255, math.max(0, 255 * self.fadetime))
	love.graphics.printf(self.phrase, self.x - self.width/2 - offset_x, self.y - offset_y, self.width, "center")
end

return Toast

