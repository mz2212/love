function registerButton( xi, yi, sizeXi, sizeYi, texti )
  local button = { x = xi, y = yi, sizeX = sizeXi, sizeY = sizeYi, text = texti }
  table.insert(buttons, button)
end

function drawButtons()
  for i, v in ipairs(buttons) do
      if i == menuSelection then
        love.graphics.setColor(0, 125, 0)
      else
        love.graphics.setColor(125, 0, 0)
      end
      love.graphics.rectangle("fill", v.x, v.y, v.sizeX, v.sizeY)
      love.graphics.setColor(255, 255, 255)
      love.graphics.print(v.text, v.x + (v.sizeX / 2), v.y + (v.sizeY / 2))
  end
end
