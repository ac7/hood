
local m = require "image_manager"

local prefixes = {
	"south",
	"southeast",
	"east",
	"northeast",
	"north",
	"northwest",
	"west",
	"southwest",
}

local function spritepack(directory_name)
	local images = {}
	local counter = 1
	for _, prefix in pairs(prefixes) do
		images[prefix] = {}
		for i = 1, 3 do
			images[prefix][i] = m:get(directory_name .. "/" .. directory_name .. string.format("%04d.png", counter))
			counter = counter + 1
		end
	end
	return images
end

return spritepack

