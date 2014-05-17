
local Item = require "item"

local Rock = Item:extends()

function Rock:__init()
	Rock.super.__init("rock.png")
end

return Rock

