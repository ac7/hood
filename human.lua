
local Actor = require "actor"
local factions = require "factions"

--[[
--
-- Humans have a faction and health.
--
--]]
local Human = Actor:extends{
	health = 50,
	max_hp = 50,
	faction = factions.MERRY_MEN,
}

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
		if self.faction == v then
			return self.faction
		end
	end
	error("Faction " .. tostring(self.faction) .. " not found.")
end

return Human

