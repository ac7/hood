
local image_manager = {}
image_manager.images = {}

function image_manager:get(name)
	assert(type(name) == "string")
	if self.images[name] then
		return self.images[name]
	else
		self.images[name] = love.graphics.newImage("data/" .. name)
		return self:get(name)
	end
end

function image_manager:release(name)
	assert(type(name) == "string")
	assert(self.images[name] ~= nil)
	self.images[name] = nil
end

return image_manager

