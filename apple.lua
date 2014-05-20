
local Item = require "item"

local Apple = Item:extends{
	name = "Apple",
	bulk = 0.7,
	collideable = false,
}

function Apple:__init()
	Apple.super.__init(self, "apple.png")
end

return Apple

