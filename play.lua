
local State = require "state"
local Robin = require "robin"
local Tree = require "tree"
local NPC = require "npc"
local factions = require "factions"
local HUD = require "hud"
local Item = require "item"
local Rock = require "rock"
local Apple = require "apple"

local Play = State:extends{
	fadeout_time = 5,
}

function Play:__init()
	Play.super.__init(self)
	self.player = Robin()
	self.player.x = -200
	self.fadeout_start_time = self.fadeout_time
	table.insert(self.actors, self.player)

	local actor = NPC("hostile", factions.MERRY_MEN)
	actor.x = 32
	actor.y = 128
	table.insert(self.actors, actor)
	actor = Rock()
	actor.x = -300
	actor.y = 48
	table.insert(self.actors, actor)
	actor = Rock()
	actor.x = 128
	actor.y = 48
	table.insert(self.actors, actor)
	actor = Apple()
	actor.x = -400
	actor.y = 40
	table.insert(self.actors, actor)
	actor = Apple()
	actor.x = -400
	actor.y = 10
	table.insert(self.actors, actor)
	actor = NPC("hostile", factions.PRINCE_JOHN)
	actor.x = 240
	actor.y = 48
	table.insert(self.actors, actor)
	actor = NPC("hostile", factions.PRINCE_JOHN)
	actor.x = 100
	actor.y = -128
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

	self.bg_color = {108, 135, 108}
	self.hud = HUD(self.player)

	self.offset_x = (self.player.x - width/2)
	self.offset_y = (self.player.y - height/2)
end

function Play:update(dt)
	if not self.player.active then
		self.fadeout_time = self.fadeout_time - dt
		if self.fadeout_time <= 0 then
			love.event.push("quit")
		end
	end
	self.super.update(self, dt)
	self.hud:update(dt)
	self.offset_x = self.offset_x + ((self.player.x - width/2) - self.offset_x) * dt * 5
	self.offset_y = self.offset_y + ((self.player.y - height/2) - self.offset_y) * dt * 5
end

function Play:draw()
	Play.super.draw(self)
	self.hud:draw()
	if not self.player.active then
		love.graphics.setColor(0, 0, 0, 255 * (1 - self.fadeout_time / self.fadeout_start_time))
		love.graphics.rectangle("fill", 0, 0, width, height)
	end
end

function Play:keypressed(key, unicode)
	if not self.player.active then
		return
	end
	if key == "q" then
		set_state(states.inventory)
	end
end

function Play:mousereleased(mx, my, button)
	if not self.player.active then
		return
	end
	assert(self.player:is(Robin))
	self.player:mousereleased(mx, my, button)
end

function Play:keyreleased(key, unicode)
	if not self.player.active then
		return
	end
	assert(self.player.keyreleased)
	self.player:keyreleased(key, unicode)
end

return Play

