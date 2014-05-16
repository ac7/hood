
local image_manager = require "image_manager"

local Actor = class{
	x = 0.0,
	y = 0.0,
	name = "Actor",
	image = nil,
	active = true,
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
end

return Actor

