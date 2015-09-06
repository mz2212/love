require "player"
require "enemy"
require "hitboxing"
require "buttons"

function love.load(arg)
	height = love.graphics.getHeight()
	width = love.graphics.getWidth()
	-- Game Variables
	wave = 1
	earl = { x = width/2, y = height/1.5, speed = 90, sizeX = 30, sizeY = 30, shots = {} }
	enemySpeed = 10
	enemies = {}
	for i = 0, 8 do
		local enemy = { x = i * 150 + 5, y = 10, speed = 10, sizeX = 40, sizeY = 40, xOrig = i * 150 + 5, goingRight = true }
		table.insert(enemies, enemy)
	end
	timer = 0
	-- Menu Variables
	menuButtons = {}
	lostButtons = {}
	menuSelection = 1
	titleFont = love.graphics.newFont(36)
	defaultFont = love.graphics.getFont()
	registerButton(love.graphics.getWidth() / 2 - 80, love.graphics.getHeight() / 2, 160, 40, "Play", menuButtons)
	registerButton(love.graphics.getWidth() / 2 - 80, love.graphics.getHeight() / 2 + 60, 160, 40, "IDK lol", menuButtons)
	registerButton(love.graphics.getWidth() / 2 - 80, love.graphics.getHeight() / 2 + 90, 160, 40, "Again?", lostButtons)
	registerButton(love.graphics.getWidth() / 2 - 80, love.graphics.getHeight() / 2 + 150, 160, 40, "Quit!", lostButtons)
	-- Gamestate (Tracks where we are in the game (menu, playing, paused, etc.))
	gamestate = "menu"
	math.randomseed(os.time())
end

function love.keyreleased(key)
	if (key == " ") then
		shoot()
	end
	if gamestate == "menu" then
		if key == "down" then
			menuSelection = menuSelection + 1
			if menuSelection > #menuButtons then
				menuSelection = #menuButtons
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
			menuSelection = 1
		end
		if key == "return" and menuSelection == 2 then
			gamestate = "credits"
		end
	end
	if key == "return" and gamestate == "credits" then
		gamestate = "menu"
	end
	if gamestate == "lost" then
		if key == "down" then
			menuSelection = menuSelection + 1
			if menuSelection > #lostButtons then
				menuSelection = #lostButtons
			end
		end
		if key == "up" then
			menuSelection = menuSelection - 1
			if menuSelection < 1 then
				menuSelection = 1
			end
		end
		if key == "return" and menuSelection == 1 then
			resetGame()
		end
		if key == "return" and menuSelection == 2 then
			love.event.push("quit")
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
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("Wave: " .. wave, 3, 10)
	end
	if gamestate == "menu" then
		drawButtons(menuButtons)
		love.graphics.setFont(titleFont)
		love.graphics.printf("Just An AWFUL Game!", 0, height/3, width, "center", 0)
		love.graphics.setFont(defaultFont)
	end
	if gamestate == "credits" then
		love.graphics.printf("Creator: Tidest; with the help of a few tutorials", 0, height/3, width, "center")
		love.graphics.printf("Made with love in the LÖVE engine", 0, height/3 + 20, width, "center")
	end
	if gamestate == "lost" then
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("You lose...", width/2, height/2)
		drawButtons(lostButtons)
	end
	-- Debugging
end
