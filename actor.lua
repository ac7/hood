
local Actor = class({
	x = 0.0,
	y = 0.0,
	name = "Actor",
	image = nil,
	active = true,
})

function Actor:__init(image)
	assert(image, "Invalid image " .. tostring(image) .. " provided to Actor constructor.")
	if type(image) == "string" then
		image = love.graphics.newImage(image)
	end
	self.image = image
	self.width = image:getWidth()
	self.height = image:getHeight()
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

