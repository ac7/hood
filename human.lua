
local Actor = require "actor"

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

return Human

