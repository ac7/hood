
local Actor = require "actor"
local util = require "util"

local Arrow = Actor:extends{
	speed = 512,
	damage = 16,
}

function Arrow:__init(parent, x, y, target_x, target_y)
	Arrow.super.__init(self, "data/arrow.png")

	for _, v in pairs({x, y, target_x, target_y}) do
		assert(type(v) == "number")
	end
	self.x = x
	self.y = y
	self.angle = math.atan2(target_x - self.x, target_y - self.y)

	if parent then
		assert(parent:is(Actor))
		self.parent = parent
	end
end

function Arrow:update(dt)
	self.x = self.x + math.sin(self.angle) * dt * self.speed
	self.y = self.y + math.cos(self.angle) * dt * self.speed

	for _,v in pairs(state.actors) do
		if v.active and v ~= self.parent and v ~= self
		and v.take_damage
		and util.dist(self.x, self.y, v.x, v.y) < self.width then
			v:take_damage(self.damage)
			self.active = false
			break
		end
	end
end

function Arrow:draw(offset_x, offset_y)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image, self.x - offset_x, self.y - offset_y, -self.angle, 1, 1, self.width/2, self.height/2)
end

return Arrow

