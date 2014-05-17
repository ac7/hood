
local Actor = require "actor"
local util = require "util"
local image_manager = require "image_manager"

local Arrow = Actor:extends{
	speed = 512,
	damage = 16,
	collideable = false,
}

function Arrow:__init(parent, x, y, target_x, target_y)
	Arrow.super.__init(self, "arrow.png")

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

function Arrow:move(delta_x, delta_y)
	self.x = self.x + delta_x
	self.y = self.y + delta_y
	for _,v in pairs(self:find_collisions(self.x, self.y)) do
		if v.active and v ~= self.parent and v ~= self
		and v.take_damage
		and util.dist(self.x, self.y, v.x, v.y) < (self.width + self.height + v.width + v.height) / 4 then
			v:take_damage(self.damage)
			self.active = false
			break
		end
	end
end

function Arrow:update(dt)
	self:move(math.sin(self.angle) * dt * self.speed, math.cos(self.angle) * dt * self.speed)
end

function Arrow:draw(offset_x, offset_y)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image, self.x - offset_x, self.y - offset_y, -self.angle, 1, 1, self.width/2, self.height/2)
end

return Arrow

