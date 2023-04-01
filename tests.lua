function run_tests(tests)
	for k, v in pairs(tests) do 
		local ok, error = pcall(v)
		print("test \"" .. k .. "\" " .. (ok and "\27[32mok" or "\27[31mfailed: ") .. (error or "") .. "\27[37m")
	end	
end