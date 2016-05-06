
if _VERSION == "Lua 5.1" then
	luaload = loadstring
else
	luaload = load
end

print "---------------------------------------------------------"
print "Simplistic Lua read-eval-print loop ('REPL')"
print "To exit, press ctrl-d (end of file) or ctrl-c (interrupt)"
print "---------------------------------------------------------"
io.stdout:flush()

while true do
	-- read a line
	l = io.stdin:read()
	if l then 
		f, m = luaload(l)  -- try to load it as a Lua statement (v5.1+)
		if f then -- if the statement is valid,
			f()  -- execute it (any output is sent to stdout)
			io.stdout:flush()
		else -- display the Lua error message
			print("Lua", m)
			io.stdout:flush()
		end
	else
		break
	end
end

