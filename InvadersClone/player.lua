function controls(dt)
  if love.keyboard.isDown("escape") then
    love.event.push("quit")
  end
  if love.keyboard.isDown("left") then
    earl.x = earl.x - (earl.speed * dt)
  elseif love.keyboard.isDown("right") then
    earl.x = earl.x + (earl.speed * dt)
  end
  if love.keyboard.isDown("up") then
    earl.y = earl.y - (earl.speed * dt)
  elseif love.keyboard.isDown("down") then
    earl.y = earl.y + (earl.speed * dt)
  end
  for i,v in ipairs(earl.shots) do
    v.y = v.y - (v.speed * dt)
  end
end

function edgeCollisionCheck()
	if earl.x < 0 then
		earl.x = 0
	end
	if earl.y < 0 then
		earl.y = 0
	end
	if earl.x + earl.sizeX > love.graphics.getWidth() then
		earl.x = love.graphics.getWidth() - earl.sizeX
	end
	if earl.y + earl.sizeY > love.graphics.getHeight() then
		earl.y = love.graphics.getHeight() - earl.sizeY
	end
end

function shoot()
	local shot = { x = earl.x + earl.sizeX / 2, y = earl.y, speed = earl.speed * 2, sizeY = 2, sizeX = 5}
	table.insert(earl.shots, shot)
end

function playerDraw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("fill", earl.x, earl.y, earl.sizeX, earl.sizeY)
  love.graphics.setColor(255, 0, 255)
  for i, v in ipairs(earl.shots) do
    love.graphics.rectangle("fill", v.x, v.y, v.sizeY, v.sizeX)
  end
end

function resetGame()
  wave = 1
  enemySpeed = 10
  enemies = {}
  earl = { x = width/2, y = height/1.5, speed = 90, sizeX = 30, sizeY = 30, shots = {} }
  for i = 0, 8 do
    local enemy = { x = i * 150 + 5, y = 10, speed = 10, sizeX = 40, sizeY = 40, xOrig = i * 150 + 5, goingRight = true }
    table.insert(enemies, enemy)
  end
  gamestate = "playing"
end
