function enemyUpdatePos(dt)
  for i, v in ipairs(enemies) do
    v.y = v.y + (dt * v.speed)
    if v.goingRight then
      if v.x > love.graphics.getWidth() - v.sizeX then
        v.goingRight = false
      end
      v.x = v.x + (dt * v.speed)
    elseif not v.goingRight then
      if v.x < 0 then
        v.goingRight = true
      end
      v.x = v.x - (dt * v.speed)
    end
  end
end

function drawEnemy()
  love.graphics.setColor(235, 0, 75)
  for i, v in ipairs(enemies) do
      love.graphics.rectangle("fill", v.x, v.y, v.sizeX, v.sizeY)
  end
end

function makeEnemy(dt)
  if timer >= 8 then
    wave = wave + 1
    enemySpeed = enemySpeed + 5
    earl.speed = earl.speed + 5
    for i = 0, 8 do
      local xi = math.random(0, width)
      local enemy = { x = xi, y = 10, speed = enemySpeed + math.random(0, 5), sizeX = 40, sizeY = 40, xOrig = xi, goingRight = true }
      table.insert(enemies, enemy)
    end
    timer = 0
  else
    timer = timer + dt
  end
end

function checkLose()
  for i, v in ipairs(enemies) do
    if v.y > love.graphics.getHeight() - v.sizeY then
      gamestate = "lost"
    end
  end
end
