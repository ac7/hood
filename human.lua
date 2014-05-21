
local Actor = require "actor"
local Item = require "item"
local Blood = require "blood"
local Toast = require "toast"
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
	direction = "south",
	walk = 1,
	walking = false,
	faction = factions.MERRY_MEN,
}

function Human:__init(images)
	assert(images)
	self.images = images
	self.image = self.images[self.direction][math.floor(self.walk)]
	Human.super.__init(self, self.image)
	self.inventory = {}
end

function Human:update(dt)
	if self.walking then
		self.image = self.images[self.direction][math.floor(self.walk)]
		self.walk = self.walk + dt * 5
		if self.walk >= #self.images[self.direction]+1 then
			self.walk = 1
		end
	else
		self.image = self.images[self.direction][2]
		self.walk = 1
	end
end

function Human:draw(offset_x, offset_y)
	Human.super.draw(self, offset_x, offset_y)
	love.graphics.setFont(fonts.small)
	love.graphics.printf(tostring(self:get_faction()), math.floor(self.x - offset_x), math.floor(self.y - offset_y), 0, "left")
	self.walking = false
end

function Human:take_damage(amount, angle)
	assert(type(amount) == "number")
	self.health = self.health - amount
	if self.health <= 0 then
		self.active = false
	end
	table.insert(states.play.actors, Blood(self, angle))
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
		table.insert(state.actors, Toast("Carrying Too Much Already", item.x, item.y))
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

	table.insert(state.actors, Toast("Taken", item.x, item.y))
end

function Human:drop(item)
	assert(item and item:is(Item))
	assert(item.holder == self, item.holder)
	item.holder = nil
	for k, v in pairs(self.inventory) do
		if v == item then
			v.x = self.x + (math.random(v.width) - v.width/2) * 0.5
			v.y = self.y + math.max(self.height, v.height) - math.min(self.height, v.height)/2 - (#self.inventory * 4)
			table.remove(self.inventory, k)
			table.insert(states.play.actors, v)
			return
		end
	end
	error("Cannot drop item not present in inventory.")
end

function Human:move(delta_x, delta_y)
	self.direction = util.direction_from_delta(delta_x, delta_y) or self.direction
	self.walking = true

	return Human.super.move(self, delta_x, delta_y)
end

return Human

