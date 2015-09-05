require "player"
require "enemy"
require "hitboxing"
require "buttons"

function love.load(arg)
	height = love.graphics.getHeight()
	width = love.graphics.getWidth()
	-- Game Variables
	earl = { x = width/2, y = height/1.5, speed = 90, sizeX = 30, sizeY = 30, shots = {} }
	enemySpeed = 10
	enemies = {}
	for i = 0, 8 do
		local enemy = { x = i * 150 + 5, y = 10, speed = 10, sizeX = 40, sizeY = 40 }
		table.insert(enemies, enemy)
	end
	timer = 0
	-- Menu Variables
	buttons = {}
	menuSelection = 1
	registerButton(love.graphics.getWidth() / 2 - 80, love.graphics.getHeight() / 2, 160, 40, "Play")
	registerButton(love.graphics.getWidth() / 2 - 80, love.graphics.getHeight() / 2 + 60, 160, 40, "IDK lol")
	-- Gamestate (Tracks where we are in the game (menu, playing, paused, etc.))
	gamestate = "menu"
end

function love.keyreleased(key)
	if (key == " ") then
		shoot()
	end
	if gamestate == "menu" then
		if key == "down" then
			menuSelection = menuSelection + 1
			if menuSelection > #buttons then
				menuSelection = #buttons
			end
		end
		if key == "up" then
			menuSelection = menuSelection - 1
			if menuSelection < 1 then
				menuSelection = 1
			end
		end
		if key == "return" and menuSelection == 1 then
			gamestate = "playing"
		end
	end
end


function love.update(dt)
	if gamestate == "playing" then
		controls(dt)
		edgeCollisionCheck()
		enemyUpdatePos(dt)
		for i, v in ipairs(earl.shots) do
			if (v.y + v.sizeY) < 0 then
				table.remove(earl.shots, i)
			end
		end
		for i, v in ipairs(earl.shots) do
			for ii, vv in ipairs(enemies) do
				if checkHit(vv.x, vv.y, vv.sizeY, vv.sizeX, v.x, v.y, v.sizeY, v.sizeX) then
					table.remove(earl.shots, i)
					table.remove(enemies, ii)
				end
			end
		end
		makeEnemy(dt)
		checkLose()
	end
end

function love.draw(dt)
	if gamestate == "playing" then
		playerDraw()
		drawEnemy()
	end
	if gamestate == "menu" then
		drawButtons()
	end
	if gamestate == "lost" then
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("You lose...", width/2, height/2)
		love.graphics.print("Close window to exit.", width/2, height/2 + 10)
	end
	-- Debugging
end
