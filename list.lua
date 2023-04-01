local list = {}

--[[
	Creating a new list
]]
function list.new()
	return {
		firstIndex = 0,
		lastIndex = -1
	}
end

--[[
	Querying list length
]]
function list.len(l)
	return l.lastIndex - l.firstIndex + 1
end

function list.is_empty(l)
	return l.firstIndex > l.lastIndex
end

--[[
	Adding elements to a list
]]
function list.append(l, e)
	local index = l.lastIndex + 1
	
	l[index] = e
	l.lastIndex = index
end

function list.prepend(l, e)
	local index = l.firstIndex - 1
	
	l[index] = e
	l.firstIndex = index
end

--[[
	Removing elements from a list
]]
function list.remove_first(l)
	local index = l.firstIndex
	local e = l[index]
	
	l[index] = nil
	l.firstIndex = index + 1
	
	return e
end

function list.remove_last(l)
	local index = l.lastIndex
	local e = l[index]
	
	l[index] = nil
	l.lastIndex = index - 1
	
	return e
end

--[[
	Retrieving list elements
]]
function list.first(l)
	return l[l.firstIndex]
end

function list.last(l)
	return l[l.lastIndex]
end

function list.nth(l, n)
	return l[l.firstIndex + n - 1]
end

function list.iter(l)
	local i = 0
	local n = list.len(l)
	
	return function ()
			i = i + 1
			if i <= n then return list.nth(l, i) end
		end
end

return list