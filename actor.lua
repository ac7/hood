
local Actor = class({
	x = 0.0,
	y = 0.0,
	name = "Actor",
	image = nil,
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

function Actor:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.width/2, self.height/2)
end

return Actor

