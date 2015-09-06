require "ball"
require "player"
require "hitboxing"

function love.load(arg)
   directions = { dr = "dr", ur = "ur", ul = "ul", ld = "ld" }
   ball = { x = love.graphics.getWidth()/2 - 15, y = love.graphics.getHeight()/2 - 15, sizeX = 30, sizeY = 30, speed = 160, direction = directions.ur }
   playerOne = { x = love.graphics.getWidth() - 30, y = love.graphics.getHeight()/2 - 90, sizeX = 15, sizeY = 180, speed = 160, points = 0}
   playerTwo = { x = 15, y = love.graphics.getHeight()/2 - 90, sizeX = 15, sizeY = 180, speed = 160, points = 0 }
   audioOne = love.audio.newSource("beep.ogg", ogg)
   audioTwo = love.audio.newSource("peep.ogg", ogg)
   audioThree = love.audio.newSource("plop.ogg", ogg)
   math.randomseed(os.time())
   trail = {}
   trail_max = 20
end

function love.update(dt)
   ballEdgeCollisionCheck()
   if checkHit( ball.x, ball.y, ball.sizeX, ball.sizeY, playerOne.x, playerOne.y, playerOne.sizeX, playerOne.sizeY )
         and ball.direction == directions.dr then
      ball.speed = ball.speed + 5
      ball.direction = directions.dl
      love.audio.play(audioThree)
   elseif checkHit( ball.x, ball.y, ball.sizeX, ball.sizeY, playerOne.x, playerOne.y, playerOne.sizeX, playerOne.sizeY )
         and ball.direction == directions.ur then
      ball.speed = ball.speed + 5
      ball.direction = directions.ul
      love.audio.play(audioThree)
   end
   if checkHit( ball.x, ball.y, ball.sizeX, ball.sizeY, playerTwo.x, playerTwo.y, playerTwo.sizeX, playerTwo.sizeY )
         and ball.direction == directions.dl then
      ball.speed = ball.speed + 5
      ball.direction = directions.dr
      love.audio.play(audioThree)
   elseif checkHit( ball.x, ball.y, ball.sizeX, ball.sizeY, playerTwo.x, playerTwo.y, playerTwo.sizeX, playerTwo.sizeY )
         and ball.direction == directions.ul then
      ball.speed = ball.speed + 5
      ball.direction = directions.ur
      love.audio.play(audioThree)
   end
   updateBall(dt)
   updatePlayer(dt, playerOne)
   playerAI(dt, playerTwo)
   playerCollisionCheck(playerOne)
   playerCollisionCheck(playerTwo)

   table.insert(trail, 1, {ball.x, ball.y} )
   if (#trail > trail_max) then
      table.remove(trail, #trail)
   end
end

function love.draw()
   love.graphics.setColor( 123, 123, 123 )
   love.graphics.rectangle( "fill", love.graphics.getWidth()/2 - 3, 0, 6, love.graphics.getHeight() )
   love.graphics.setColor(255, 255, 255)
   love.graphics.print("Player 1: " .. playerOne.points, 10, 10)
   love.graphics.print("Player 2: " .. playerTwo.points, 10, 25)
   drawBall()
   drawPlayer(playerOne)
   drawPlayer(playerTwo)

   local trail_length = #trail
   for index,value in pairs(trail) do
      local i = (trail_length-index)
      love.graphics.setColor(255,255,255, (150/trail_length)*i )
      local trail_width = (ball.sizeX/trail_length)*i
      local trail_height = (ball.sizeY/trail_length)*i
      love.graphics.rectangle("fill", value[1]-trail_width/2 + ball.sizeX/2, value[2]-trail_height/2 + ball.sizeY/2, trail_width, trail_height )
   end
end
