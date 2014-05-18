
local Actor = require "actor"
local Item = require "item"
local factions = require "factions"

--[[
--
-- Humans have a faction, health, and inventory.
--
--]]
local Human = Actor:extends{
	health = 50,
	max_hp = 50,
	max_bulk = 25.0,
	faction = factions.MERRY_MEN,
}

function Human:__init(image)
	Human.super.__init(self, image)
	self.inventory = {}
end

function Human:take_damage(amount)
	assert(type(amount) == "number")
	self.health = self.health - amount
	if self.health <= 0 then
		self.active = false
	end
end

function Human:get_faction()
	-- an assertion that our faction exists in the list of factions
	for _, v in pairs(factions) do
		if v == self.faction then
			return self.faction
		end
	end
	error("Faction " .. tostring(self.faction) .. " not found.")
end

function Human:get_bulk()
	assert(self.inventory)
	local total = 0
	for _, v in pairs(self.inventory) do
		assert(v and v:is(Item))
		total = total + v.bulk
	end
	return total
end

function Human:take(item)
	assert(item and item:is(Item))
	if self:get_bulk() + item.bulk > self.max_bulk then
		return
	end

	if item.holder then
		for i, v in pairs(item.holder.inventory) do
			if v == item then
				table.remove(item.holder.inventory, i)
				break
			end
		end
	end

	table.insert(self.inventory, item)
	item.holder = self
	for i, v in pairs(state.actors) do
		if v == item then
			table.remove(state.actors, i)
			break
		end
	end
end

function Human:drop(item)
	assert(item and item:is(Item))
	assert(item.holder == self, item.holder)
	item.holder = nil
	for k, v in pairs(self.inventory) do
		if v == item then
			table.remove(self.inventory, k)
			table.insert(states.play.actors, v)
			v.x = self.x + math.random(v.width) - v.width/2
			v.y = self.y + math.max(self.height, v.height) - math.min(self.height, v.height) * 1.2
			return
		end
	end
	error("Cannot drop item not present in inventory.")
end

return Human

