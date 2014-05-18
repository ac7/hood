
local Actor = require "actor"

local Item = Actor:extends({
	bulk = 5.0, -- roughly the same as pounds (lbs)
	name = "Item",
	equippable = false,
	holder = nil,
	collideable = false,
})

return Item

