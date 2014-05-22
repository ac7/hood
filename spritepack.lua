
local m = require "image_manager"

local function spritepack(directory_name)
	local images = {}
	local counter = 1
	for index=1,8 do
		images[index] = {}
		for i = 1, 3 do
			images[index][i] = m:get(directory_name .. "/" .. directory_name .. string.format("%04d.png", counter))
			counter = counter + 1
		end

		-- the table will look like this when this block of code
		-- finishes:
		--
		-- 1 - left foot forward
		-- 2 - standing still
		-- 3 - right foot forward
		-- 4 - standing still
		--
		-- The reason for this is so the walking animation is
		-- smoother and easier to understand because we simply
		-- iterate from 1-4 repeatedly.
		images[index][4] = images[index][1]
		images[index][1] = images[index][2]
		images[index][2] = images[index][4]
	end
	return images
end

return spritepack

