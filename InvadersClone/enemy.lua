function enemyUpdatePos(dt)
  for i, v in ipairs(enemies) do
    v.y = v.y + (dt * v.speed)
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
    enemySpeed = enemySpeed + 5
    earl.speed = earl.speed + 5
    for i = 0, 8 do
      local enemy = { x = i * 150 + 5, y = 10, speed = enemySpeed, sizeX = 40, sizeY = 40 }
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
