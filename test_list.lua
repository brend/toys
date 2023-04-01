require "tests"

local list = require "list"

local tests = {
	new_is_empty = function () 
		local l = list.new()
		
		assert(list.is_empty(l), "expected new list to be empty")
	end,
	
	append_makes_nonempty = function ()
		local l = list.new()
		
		list.append(l, 17)
		
		assert(not list.is_empty(l), "expected list not to be empty")
	end,
	
	prepend_makes_nonempty = function ()
		local l = list.new()
		
		list.prepend(l, 17)
		
		assert(not list.is_empty(l), "expected list not to be empty")
	end,
	
	remove_first_to_empty = function ()
		local l = list.new()
		
		list.append(l, 17)
		
		local e = list.remove_first(l)
		
		assert(list.is_empty(l), "expected list to be empty")
		assert(e == 17, "expected element to be 17")
	end,
	
	remove_last_to_empty = function ()
		local l = list.new()
		
		list.append(l, 17)
		
		local e = list.remove_last(l)
		
		assert(list.is_empty(l), "expected list to be empty")
		assert(e == 17, "expected element to be 17")
	end,
	
	iter = function () 
		local l = list.new()
		local a = {17, 4, "32", true, 8}
		
		for _, v in pairs(a) do
			list.append(l, v)
		end
		
		local i = 1
		
		for v in list.iter(l) do 
			assert(v == a[i], "expected: " .. tostring(a[i]) .. ", found: " .. tostring(v))
			i = i + 1
		end
	end,
	
	removing_too_much = function () 
		local l = list.new()
		
		list.append(l, 17)
		list.remove_last(l)
		list.remove_last(l)
		
		assert(list.is_empty(l), "expect list to be empty")
		assert(list.first(l) == nil, "expect first element to be missing")
	end
}

run_tests(tests)