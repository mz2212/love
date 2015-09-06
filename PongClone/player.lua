function drawPlayer( array )
   love.graphics.setColor(255, 255, 255)
   love.graphics.rectangle( "fill", array.x, array.y, array.sizeX, array.sizeY )
end

function updatePlayer(dt, array)
   if love.keyboard.isDown("up") then
      array.y = array.y - (dt * array.speed)
   elseif love.keyboard.isDown("down") then
      array.y = array.y + (dt * array.speed)
   end
end

function playerAI(dt, array)
   if ball.y > array.y + (array.sizeY / 2) then
      array.y = array.y + (dt * array.speed)
   elseif ball.y < array.y + (array.sizeY / 2) then
      array.y  = array.y - (dt * array.speed)
   end
end

function playerCollisionCheck(array)
   if array.y < 0 then
      array.y = 0
   end
   if array.y + array.sizeY > love.graphics.getHeight() then
      array.y = love.graphics.getHeight() - array.sizeY
   end
end
