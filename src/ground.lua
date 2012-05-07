Ground = {}
Ground.__index = Ground

function Ground.create()
  local instance = {
    image = love.graphics.newImage("planetcute/Grass Block.png"),
    imageHeight = 171,
    imageWidth = 101
  }
  setmetatable(instance, Ground)
  return instance
end

function Ground:draw()
  for i = 1,12 do
    local xPos = ((i - 1) * 100) + worldOffset
    love.graphics.draw(self.image, xPos, self:getHeight() - 100)
  end
  local x,y,width,height = self:getBox()
  love.graphics.rectangle("line", x,y,width,height)
end

function Ground:getHeight()
  return love.graphics.getHeight() - self.imageHeight + 100
end

function Ground:getBox()
  return 0, self:getHeight(), 1200 + worldOffset, love.graphics.getHeight()
end

function Ground:isOnGround(player)
  return player.x - worldOffset < 1200
end