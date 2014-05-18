
local Item = require "item"

local Rock = Item:extends{
	name = "Rock",
	bulk = 20.0,
}

function Rock:__init()
	Rock.super.__init(self, "rock.png")
end

return Rock

