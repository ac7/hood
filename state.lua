
local State = class()

function State:__init()
	self.actors = {}
	self.bg_color = {255, 255, 255}
end

function State:update(dt)
	-- update bg color
	local r, g, b, _ = love.graphics.getBackgroundColor()
	local transition_speed = 3.0
	r = r + (self.bg_color[1] - r) * dt * transition_speed
	g = g + (self.bg_color[2] - g) * dt * transition_speed
	b = b + (self.bg_color[3] - b) * dt * transition_speed
	love.graphics.setBackgroundColor(r, g, b)

	for i, v in pairs(self.actors) do
		assert(v)
		assert(v.update)
		if v:update(dt) == false then
			self.actors[i] = nil
		end
	end
end

function State:draw()
	for _, v in pairs(self.actors) do
		assert(v)
		assert(v.draw)
		v:draw()
	end
end

return State

