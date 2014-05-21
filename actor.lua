
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
	assert(image, "Invalid image " .. tostring(image) .. " provided to Actor constructor.")
	if type(image) == "string" then
		self.image = image_manager:get(image)
	else
		self.image = image
	end
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
end

function Actor:update(dt)
end

function Actor:draw(offset_x, offset_y)
	assert(type(offset_x) == "number")
	assert(type(offset_y) == "number")

	local xpos, ypos = self.x - offset_x, self.y - offset_y
	if xpos + self.width/2 < 0 or xpos - self.width/2 > width
	or ypos + self.height/2 < 0 or ypos - self.height/2 > height then
		return
	end

	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image, math.floor(xpos + 0.5), math.floor(ypos + 0.5), 0, 1, 1, self.width/2, self.height/2)
end


function Actor:find_collisions(x_pos, y_pos)
	local x_pos = x_pos or self.x
	local y_pos = y_pos or self.y
	local collisions = {}
	for _, actor in pairs(state.actors) do
		if actor ~= self and actor.collideable and util.dist(actor.x, actor.y, x_pos, y_pos) < (self.width + self.height + actor.width + actor.height) / 7 then
			table.insert(collisions, actor)
		end
	end
	return collisions
end

function Actor:move(delta_x, delta_y)
	assert(type(delta_x) == "number")
	assert(type(delta_y) == "number")
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
	return (x_collision or y_collision) == false
end

return Actor

