function registerButton( xi, yi, sizeXi, sizeYi, texti, list )
  local button = { x = xi, y = yi, sizeX = sizeXi, sizeY = sizeYi, text = texti }
  table.insert(list, button)
end

function drawButtons(list)
  for i, v in ipairs(list) do
      if i == menuSelection then
        love.graphics.setColor(0, 125, 0)
      else
        love.graphics.setColor(125, 0, 0)
      end
      love.graphics.rectangle( "fill", v.x, v.y, v.sizeX, v.sizeY )
      love.graphics.setColor(255, 255, 255)
      love.graphics.printf( v.text, v.x, v.y + (v.sizeY/2), v.sizeX, "center" )
  end
end
