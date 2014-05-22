
local State = class()

function State:__init()
	self.actors = {}
	self.bg_color = {255, 255, 255}
	self.offset_x, self.offset_y = 0, 0
end

function State:update(dt)
	-- update bg color
	local r, g, b, _ = love.graphics.getBackgroundColor()
	local transition_speed = 3.0
	r = r + (self.bg_color[1] - r) * dt * transition_speed
	g = g + (self.bg_color[2] - g) * dt * transition_speed
	b = b + (self.bg_color[3] - b) * dt * transition_speed
	love.graphics.setBackgroundColor(r, g, b)

	for i = #self.actors, 1, -1 do
		local v = self.actors[i]
		assert(v)
		assert(v.update)
		if not v.active then
			table.remove(self.actors, i)
		else
			if self.player then -- some states don't have a player object
				if not v.asleep then
					v:update(dt)
					if util.dist(v.x, v.y, self.player.x, self.player.y) > sleep_distance then
						v.asleep = true
					end
				elseif util.dist(v.x, v.y, self.player.x, self.player.y) < sleep_distance then
					v.asleep = false
				end
			end
		end
	end
end

function State:draw()
	assert(self.offset_x)
	assert(self.offset_y)
	table.sort(self.actors, function(a1, a2)
		if a1 == nil then
			return false
		end
		if a2 == nil then
			return true
		end
		if a1.z == a2.z then
			return a1.y + a1.height/2 < a2.y + a2.height/2
		else
			return a1.z < a2.z
		end
	end)
	for _, v in pairs(self.actors) do
		assert(v)
		assert(v.draw)
		v:draw(math.floor(self.offset_x), math.floor(self.offset_y))
	end
end

return State

