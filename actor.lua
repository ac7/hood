
local image_manager = require "image_manager"
local util = require "util"

local Actor = class{
	x = 0.0,
	y = 0.0,
	width = 0,
	height = 0,
	name = "Actor",
	image = nil,
	active = true,
	collideable = true,
}

function Actor:__init(image)
	assert(type(image) == "string", "Invalid image " .. tostring(image) .. " provided to Actor constructor.")
	self.image = image_manager:get(image)
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
end

function Actor:update(dt)
end

function Actor:draw(camera_x, camera_y)
	assert(type(camera_x) == "number")
	assert(type(camera_y) == "number")

	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image, self.x - camera_x, self.y - camera_y, 0, 1, 1, self.width/2, self.height/2)
	love.graphics.circle("line", self.x - camera_x, self.y - camera_y, (self.width + self.height)/3, 32)

	if self.get_faction then
		love.graphics.printf(tostring(self:get_faction()), self.x - camera_x, self.y - camera_y + self.height, 0, "left")
	end
end


function Actor:find_collisions(x_pos, y_pos)
	local x_pos = x_pos or self.x
	local y_pos = y_pos or self.y
	local collisions = {}
	for _, actor in pairs(state.actors) do
		if actor ~= self and actor.collideable and util.dist(actor.x, actor.y, x_pos, y_pos) < (self.width + self.height + actor.width + actor.height) / 6 then
			table.insert(collisions, actor)
		end
	end
	return collisions
end

function Actor:move(delta_x, delta_y)
	assert(type(delta_x) == "number")
	assert(type(delta_y) == "number")
	local new_x, new_y = self.x + delta_x, self.y + delta_y
	if #self:find_collisions(new_x, new_y) > 0 then
		return false
	end
	self.x, self.y = new_x, new_y
	return true
end

return Actor

