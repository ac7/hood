
local Actor = require "actor"

--[[
--
-- Humans have allegiances and health.
--
--]]
local Human = Actor:extends{
	health = 50,
	max_hp = 50,
}

function Human:take_damage(amount)
	assert(type(amount) == "number")
	self.health = self.health - amount
	if self.health <= 0 then
		self.active = false
	end
end

function Human:allegiance()
	return -1
end

return Human

