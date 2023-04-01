require "tests"

local stack = require("stack")

local tests = {
	push_pop = function ()
		local s = stack.new()
		local a = { 17, 139, -4, "doggy", 12 }
		
		for k, v in pairs(a) do 
			stack.push(s, v)
		end
		
		local i = #a
		
		while not stack.empty(s) do 
			local v = stack.pop(s)
			
			assert((a[i] == v), "expected: " .. tostring(a[i] .. ", found: " .. tostring(v)))
			i = i - 1
		end
	end,
	
	new_ist_empty = function ()
		assert(stack.empty(stack.new()), "expect new stack to be empty")
	end,
	
	push_pop_empty = function () 
		local s = stack.new()
		
		stack.push(s, 17)
		stack.push(s, 4)
		
		assert(4 == stack.pop(s))
		
		stack.push(s, 5)
		
		assert(not stack.empty(s))
		assert(5 == stack.pop(s))
		assert(17 == stack.pop(s))
		assert(stack.empty(s))
	end,
	
	performance = function ()
		local s = stack.new()
		
		for i = 1, 1000000 do
			stack.push(s, i * 2)
		end
		
		local i = 1000000
		
		while not stack.empty(s) do
			assert(stack.pop(s) / 2 == i)
			i = i - 1
		end
		
		assert(stack.empty(s))
	end
}

run_tests(tests)