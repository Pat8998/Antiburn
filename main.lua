local t = 2
local timetrans = 2
local tTrans = 1
local isBlack = false
local func = {
	function(x) return 0  end,
	function(x) half = love.graphics.getHeight()/40 return math.fmod(x, half*2) - half end,
	function(x) return math.fmod(x, love.graphics.getHeight()/40) end,
	function(x, y) return x^y end,
	function(x, y) return math.sin(x/25 + y)* 0.5*25 end,
	number = 1
}
local Circle = false

function love.load()
	love.window.setFullscreen(true)
        love.mouse.setVisible(false)
	love.keyboard.setKeyRepeat(true)
end

function love.update(dt)
	timetrans = timetrans - 2*dt
	tTrans = tTrans - 2*dt
	if love.system.getOS() == 'Windows' and math.fmod(love.timer.getTime(), 60) < 0.1 then
		os.execute("shutdown -a")
	end
end

function love.draw()
	if isBlack then love.graphics.clear(0,0,0) love.graphics.setColor(1, 1, 1, timetrans) else
	local r = math.fmod(love.timer.getTime() * t   ,3) < 1 and 1 or 0
	local v = math.fmod(love.timer.getTime() * t +1,3) < 1 and 1 or 0
	local b = math.fmod(love.timer.getTime() * t +2,3) < 1 and 1 or 0
	love.graphics.clear(r,v,b) 
	love.graphics.setColor(0, 0, 0, timetrans) end
	love.graphics.printf(os.date("%H:%M:%S"), 0, love.graphics.getHeight()/2, love.graphics.getWidth()/10, 'center', 0, 10)
	love.graphics.setColor(0, 0, 0, tTrans)
	love.graphics.printf(t, 0, 0, love.graphics.getWidth()/3, 'right', 0, 3)

	--FUNCTION
	local time = love.timer.getTime() * t
	love.graphics.setLineWidth(20)
	if func.number ~= 1 then
	for i = 1, love.graphics.getWidth() do
		local j = math.sin(time)
		love.graphics.setColor(
			math.sin(time   ) * 0.5 + 0.5,
			math.sin(time   +math.pi/3 * i) * 0.5 + 0.5,
			math.sin(time   +2*math.pi/3 * i) * 0.5 + 0.5,
			 0.5)
		love.graphics.line(
			i,
			func[func.number ]( i, j  ) * 20 + love.graphics.getHeight()/2,
			i +1,
			func[func.number ]( i+1, j  ) * 20 + love.graphics.getHeight()/2)
		if func.number == 3 then  
			love.graphics.line(
			i,
			func[func.number ]( i, j  ) * 20,
			i +1,
			func[func.number ]( i+1, j  ) * 20 )end
	end end

	if Circle then
		for i = 1, 100, 1 do
			local time = love.timer.getTime() * t
			love.graphics.setColor(
				math.sin(time   ) * 0.5 + 0.5,
				math.sin(time   +math.pi/3 * i) * 0.5 + 0.5,
				math.sin(time   +2*math.pi/3 * i) * 0.5 + 0.5,
				 0.5)
				love.graphics.setLineWidth(math.sin(time / 4) + i/10)
				love.graphics.arc('line',
				'open',
				love.graphics.getWidth() /2,
				love.graphics.getHeight()/2,
				love.graphics.getHeight()/(100 - i),
				math.fmod((time * i * 0.5)* math.pi * 2, 2 * math.pi),
				math.fmod((time * i *0.5)* math.pi * 2, 2 * math.pi) + math.pi *1.99,
				math.sin(time * 4) * 8 + 11)
			end
	end
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	elseif key == 'kp+' then
		t = t * 1.1
		tTrans = 1
	elseif key == 'kp-' then
		t = t / 1.1
		tTrans = 1
	elseif key == 't' then
		timetrans = 2
	elseif key == 'r' then
		love.system.openURL('https://www.youtube.com/watch?v=dQw4w9WgXcQ')
	elseif key == 'q' then
		love.system.openURL('e:')
	elseif key == 'b' then
		isBlack = not isBlack
	elseif key == 'c' then
		Circle = not Circle
	elseif key == 'f' then
		func.number = func.number + 1
		if func.number > #func then func.number = 1 end
		print("Function changed to "..func.number)
	end
end