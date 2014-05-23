
local State = require "state"
local image_manager = require "image_manager"

local Title = State:extends()

function Title:__init()
	Title.super.__init(self)
	self.bg_color = {34, 109, 34}
	self.offset = 32
end

function Title:draw()
	love.graphics.setColor(34, 139, 34)
	love.graphics.rectangle("line", 32, 32, width - 64, height - 64)

	love.graphics.setFont(fonts.large)
	love.graphics.setColor(255, 255, 255)
	love.graphics.printf("Robin Hood", 0, height / 3 + self.offset, width, "center")

	love.graphics.setFont(fonts.medium)
	love.graphics.printf("-spacebar-", 0, height - 128 + self.offset, width, "center")

	local image = image_manager:get("robinhood/robinhood0007.png")
	love.graphics.draw(image, width / 2, height / 2 + self.offset, 0, 1, 1, image:getWidth()/2, image:getHeight()/2)
end

function Title:update(dt)
	Title.super.update(self, dt)
	self.offset = self.offset - self.offset * dt
end

function Title:keyreleased(key, unicode)
	if key == " " or key == "return" then
		set_state(states.play)
	end
end

return Title

