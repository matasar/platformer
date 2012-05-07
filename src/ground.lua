Ground = {}
Ground.__index = Ground

function Ground.create()
  local instance = {
    image = love.graphics.newImage("planetcute/Grass Block.png"),
    height = 171,
    width = 101
  }
  setmetatable(instance, Ground)
  return instance
end

function Ground:draw()
  for i = 1,12 do
    local xPos = ((i - 1) * 100) + worldOffset
    love.graphics.draw(self.image, xPos, self:getHeight())
  end
  local x,y,width,height = self:getBox()
  love.graphics.rectangle("line", x,y,width,height)
end

function Ground:getHeight()
  return love.graphics.getHeight() - self.height
end

function Ground:getBox()
  return 0, 0, love.graphics.getWidth(), self:getHeight() + 115
end