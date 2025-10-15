local t = 2
local timetrans = 2
local tTrans = 1
local isBlack = false
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
	end
end