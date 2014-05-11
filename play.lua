
local State = require "state"
local Archer = require "archer"

local Play = State:extends()

function Play:__init()
	Play.super.__init(self)
	self.player = Archer()
	table.insert(self.actors, self.player)
end

function Play:mousereleased(mx, my, button)
	assert(self.player:is(Archer))
	if button == "l" then
		self.player:shoot(mx, my)
	end
end

return Play()

