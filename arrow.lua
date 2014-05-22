
local Actor = require "actor"
local util = require "util"
local image_manager = require "image_manager"

local Arrow = Actor:extends{
	speed = 512,
	damage = 16,
	collideable = false,
	lifetime = 5, -- in seconds
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

function Arrow:move(angle, speed)
	self.x = self.x + math.sin(angle) * speed
	self.y = self.y + math.cos(angle) * speed
	for _,v in pairs(self:find_collisions(self.x, self.y)) do
		if v.active and v ~= self.parent and v ~= self
		and util.touching(self, v) then
			if v.take_damage then
				v:take_damage(self.damage, self.angle)
			end
			self.active = false
			break
		end
	end
end

function Arrow:update(dt)
	self:move(self.angle, self.speed * dt)
	self.lifetime = self.lifetime - dt
	if self.lifetime < 0 then
		self.active = false
	end
end

function Arrow:draw(offset_x, offset_y)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image, self.x - offset_x, self.y - offset_y, -self.angle, 1, 1, self.width/2, self.height/2)
end

return Arrow

