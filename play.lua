
local State = require "state"
local Robin = require "robin"
local Archer = require "archer"

local Play = State:extends()

function Play:__init()
	Play.super.__init(self)
	self.player = Robin()
	table.insert(self.actors, self.player)
end

function Play:mousereleased(mx, my, button)
	assert(self.player:is(Archer))
	self.player:mousereleased(mx, my, button)
end

return Play()

