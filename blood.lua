
Blood = class{
	lifetime = 0.3,
	active = true,
	width = 0,
	height = 0,
}

function Blood:__init(actor, angle)
	assert(actor)
	self.particles = {}
	self.actor = actor
	self.x = self.actor.x
	self.y = self.actor.y - 9999
	self.angle = angle
end

function Blood:update(dt)
	self.lifetime = self.lifetime - dt
	if self.lifetime > 0 then
		for i=0,dt,0.01 do
			local particle = {
				size = math.random(4),
				angle = (self.angle + (math.random()-0.5)/4) * (math.random() > 0.9 and -1 or 1),
				speed = math.random() * 62 + 450,
				lifetime = math.random() * 0.3,
				fadetime = 16,
				circle = math.random() > 0.5 and true or false,
				red = 80 + math.random(30),
			}
			particle.x = self.actor.x + (math.random()-0.5)*self.actor.width * 0.3
			particle.y = self.actor.y + (math.random()-0.5)*self.actor.height * 0.3
			table.insert(self.particles, particle)
		end
	end
	for i=#self.particles,1,-1 do
		local v = self.particles[i]
		v.x = v.x + math.sin(v.angle) * v.speed * dt
		v.y = v.y + math.cos(v.angle) * v.speed * dt
		v.lifetime = v.lifetime - dt
		if v.lifetime < -v.fadetime then
			table.remove(self.particles, i)
		elseif v.lifetime <= 0 then
			v.speed = 0
		end
	end
	self.active = (#self.particles > 0)
end

function Blood:draw(offset_x, offset_y)
	for _, v in pairs(self.particles) do
		local alpha = 255
		if v.lifetime < 0 then
			alpha = (1 - (-v.lifetime) / v.fadetime) * 255
		end
		love.graphics.setColor(v.red, 0, 0, alpha)
		if v.circle then
			love.graphics.circle("fill", v.x - offset_x, v.y - offset_y, v.size)
		else
			love.graphics.rectangle("fill", v.x - offset_x, v.y - offset_y, v.size, v.size)
		end
	end
end

return Blood

