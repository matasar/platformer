Platform = {}
Platform.__index = Platform

function Platform.create()
  local instance = {
    image = love.graphics.newImage("planetcute/Grass Block.png"),
    imageHeight = 171,
    imageWidth = 101
  }
  setmetatable(instance, Platform)
  return instance
end

function Platform:draw()
  for i = 1,12 do
    local xPos = ((i - 1) * 100) + worldOffset
    love.graphics.draw(self.image, xPos, self:getHeight() - 100)
  end
  local x,y,width,height = self:getBox()
  love.graphics.rectangle("line", x,y,width,height)
end

function Platform:getHeight()
  return love.graphics.getHeight() - self.imageHeight + 100
end

function Platform:getBox()
  return 0, self:getHeight(), 1200 + worldOffset, love.graphics.getHeight()
end

function Platform:isOnPlatform(player)
  return (player.x - worldOffset < 1200)
end