
local Archer = require "archer"
local util = require "util"

local NPC = Archer:extends{
	strategy = "wander",
	wander_point_x = nil,
	wander_point_y = nil,
	wander_distance = 512,
	walk_speed = 96,
	run_speed = 128,
	hostile_timeout = 0,
}

function NPC:__init(strategy, faction)
	NPC.super.__init(self)
	assert(type(faction) == "number")
	assert(type(strategy) == "string")
	self.faction = faction
	self.strategy = strategy
end

function NPC:take_damage(amount, angle)
	NPC.super.take_damage(self, amount, angle)
	self.hostile_timeout = 3
	self.strategy = "hostile"
end

function NPC:update(dt)
	local choose_new_point = false
	if not self.wander_point_x or not self.wander_point_y then
		choose_new_point = true
	else
		if util.dist(self.x, self.y, self.wander_point_x, self.wander_point_y) < (self.width + self.height) / 3 then
			choose_new_point = true
		else
			local angle = math.atan2(self.wander_point_x - self.x, self.wander_point_y - self.y)
			local path_clear = self:move(math.sin(angle) * dt * self.speed, math.cos(angle) * dt * self.speed)

			if not path_clear then
				self.wander_point_x = self.x + (math.random() - 0.5) * self.wander_distance
				self.wander_point_y = self.y + (math.random() - 0.5) * self.wander_distance
			end
		end
	end

	if choose_new_point == true then
		if self.strategy == "wander" then
			self.bow_drawn = false
			self.wander_point_x = self.x + (math.random() - 0.5) * self.wander_distance
			self.wander_point_y = self.y + (math.random() - 0.5) * self.wander_distance
		elseif self.strategy == "hostile" then
			self.bow_drawn = true
			local closest_distance = nil
			local closest_actor = nil

			for _, actor in pairs(state.actors) do
				local actor_dist = util.dist(actor.x, actor.y, self.x, self.y)
				if actor ~= self and (not closest_distance or actor_dist < closest_distance)
				and actor.get_faction and actor:get_faction() ~= self:get_faction() then
					closest_distance = actor_dist
					closest_actor = actor
				end
			end

			if closest_actor == nil then
				self.hostile_timeout = self.hostile_timeout - dt
				if self.hostile_timeout <= 0 then
					self.strategy = "wander"
				end
			else
				self.hostile_timeout = 3
				if closest_actor:get_faction() ~= self:get_faction() then
					self:shoot(closest_actor.x, closest_actor.y)
					self.wander_point_x = self.x + (math.random() - 0.5) * self.wander_distance*2/3
					self.wander_point_y = self.y + (math.random() - 0.5) * self.wander_distance*2/3
				end
			end
		else
			error("Invalid strategy " .. tostring(self.strategy))
		end
	end
	NPC.super.update(self, dt)
end

return NPC

