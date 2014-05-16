
local State = require "state"
local Robin = require "robin"
local Archer = require "archer"
local Tree = require "tree"

local Play = State:extends()

function Play:__init()
	Play.super.__init(self)
	self.player = Robin()
	table.insert(self.actors, self.player)
	actor = Archer()
	actor.x = 32
	actor.y = 32
	table.insert(self.actors, actor)
	actor = Archer()
	actor.x = -128
	actor.y = 48
	table.insert(self.actors, actor)
	actor = Archer()
	actor.x = 128
	actor.y = 48
	table.insert(self.actors, actor)
	actor = Tree()
	actor.x = 255
	actor.y = -320
	table.insert(self.actors, actor)
	actor = Tree()
	actor.x = 0
	actor.y = -320
	table.insert(self.actors, actor)
	actor = Tree()
	actor.x = -255
	actor.y = 320
	table.insert(self.actors, actor)

	self.bg_color = {128, 128, 255}
end

function Play:mousereleased(mx, my, button)
	assert(self.player:is(Archer))
	self.player:mousereleased(mx, my, button)
end

function Play:draw()
	self.offset_x = self.player.x - width/2
	self.offset_y = self.player.y - height/2

	Play.super.draw(self)
end

return Play()

