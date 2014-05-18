
local State = require "state"
local Human = require "human"
local Actor = require "actor"
local MenuItem = require "menu_item"

local Inventory = State:extends()

function Inventory:__init()
	Inventory.super.__init(self)
	self.bg_color = {42, 32, 22}
end

function Inventory:start()
	self.actors = {}
	local player = states.play.player
	assert(player and player:is(Human))
	local count = #player.inventory
	for x = 1, count do
		local item = player.inventory[x]
		assert(item)

		local xpos = x * (width / (count+1))
		local repr = MenuItem(item, xpos)
		table.insert(self.actors, repr)
	end
end

function Inventory:keyreleased(key, unicode)
	if key == "q" then
		set_state(states.play)
	end
end

function Inventory:mousereleased(mx, my, button)
	for _, v in pairs(self.actors) do
		if util.dist(mx, my, v.x, v.y) < (v.width + v.height) / 2 and v.item.holder then
			states.play.player:drop(v.item)
			break
		end
	end
end

function Inventory:draw()
	Inventory.super.draw(self)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("line", 32, 32, width - 64, height - 64)
	love.graphics.setFont(fonts.medium)
	love.graphics.printf("Inventory (" .. tostring(#states.play.player.inventory) .. " items, " .. states.play.player:get_bulk() .. " / " .. states.play.player.max_bulk .. " lbs)", 0, 36, width, "center")
end

return Inventory

