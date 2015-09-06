function resetBall()
   ball = { x = love.graphics.getWidth()/2 - 15, y = love.graphics.getHeight()/2 - 15, sizeX = 30, sizeY = 30, speed = 160, direction = directions.ur }
end

function ballEdgeCollisionCheck()
   if ball.x < 0 then
   	ball.x = 0
      playerOne.points = playerOne.points + 1
      love.audio.play(audioOne)
      resetBall()
	end
	if ball.y < 0 then
		ball.y = 0
      if ball.direction == directions.ur then
         ball.direction = directions.dr
         love.audio.play(audioThree)
      elseif ball.direction == directions.ul then
         ball.direction = directions.dl
         love.audio.play(audioThree)
      end
	end
	if ball.x + ball.sizeX > love.graphics.getWidth() then
		ball.x = love.graphics.getWidth() - ball.sizeX
      playerTwo.points = playerTwo.points + 1
      love.audio.play(audioOne)
      resetBall()
	end
	if ball.y + ball.sizeY > love.graphics.getHeight() then
		ball.y = love.graphics.getHeight() - ball.sizeY
      if ball.direction == directions.dr then
         ball.direction = directions.ur
         love.audio.play(audioThree)
      elseif ball.direction == directions.dl then
         ball.direction = directions.ul
         love.audio.play(audioThree)
      end
	end
end

function updateBall(dt)
   if ball.direction == directions.ur then
      ball.x = ball.x + (dt * (ball.speed + math.random(0, 5)))
      ball.y = ball.y - (dt * (ball.speed + math.random(0, 5)))
   elseif ball.direction == directions.ul then
      ball.x = ball.x - (dt * (ball.speed + math.random(0, 5)))
      ball.y = ball.y - (dt * (ball.speed + math.random(0, 5)))
   elseif ball.direction == directions.dl then
      ball.x = ball.x - (dt * (ball.speed + math.random(0, 5)))
      ball.y = ball.y + (dt * (ball.speed + math.random(0, 5)))
   elseif ball.direction == directions.dr then
      ball.x = ball.x + (dt * (ball.speed + math.random(0, 5)))
      ball.y = ball.y + (dt * (ball.speed + math.random(0, 5)))
   end
end

function drawBall()
   love.graphics.setColor(255, 255, 255)
   love.graphics.rectangle("fill", ball.x, ball.y, ball.sizeX, ball.sizeY)
end
