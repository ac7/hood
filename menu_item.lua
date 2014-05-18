
local Actor = require "actor"
local Item = require "item"

local MenuItem = Actor:extends()

function MenuItem:__init(item, xpos)
	assert(item and item:is(Item))
	MenuItem.super.__init(self, item.image)
	assert(type(xpos) == "number")
	self.x = xpos
	self.y = height / 2
	self.item = item
end

function MenuItem:draw()
	if self.item.holder then
		love.graphics.setColor(255, 255, 255)
		local scale = 1/self.item.width * (width / 8)
		love.graphics.draw(self.item.image, self.x, self.y, 0, scale, scale, self.item.width/2, self.item.height/2)
		assert(type(self.item.name) == "string")
		love.graphics.setFont(fonts.medium)
		love.graphics.printf(self.item.name, self.x - 200, self.y, 400, "center")
	else
		love.graphics.setFont(fonts.medium)
		love.graphics.printf("Dropped", self.x - 200, self.y, 400, "center")
	end
end

return MenuItem

