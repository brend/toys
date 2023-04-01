local list = require "list"
local stack = {}

stack.new = list.new
stack.empty = list.is_empty
stack.push = list.append
stack.pop = list.remove_last

function stack.dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k,v in pairs(o) do
			print("this is a thing "..type(k))
			if type(k) ~= 'number' then k = '"'..k..'"' end
			s = s .. '['..k..'] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end

function stack.print(s) 
	print(dump(s))
end

return stack
