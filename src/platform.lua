Platform = {}
Platform.__index = Platform

function Platform.create(x,y,squares,image)
  local instance = {
    image = image,
    imageHeight = 171,
    imageWidth = 101,
    scale = 0.65,
    x = x,
    y = y,
    squares = squares
  }
  setmetatable(instance, Platform)
  return instance
end

function Platform:draw()
  for i = 1,self.squares do
    local width = 100 * self.scale
    local heightOffset = 100 * self.scale
    local xPos = self.x + ((i - 1) * width) + worldOffset
    love.graphics.draw(self.image, xPos, self:getHeight() - heightOffset, 0, self.scale, self.scale)
  end
  local x,y,width,height = self:getBox()
  love.graphics.rectangle("line",x,y,width,height)
end

function Platform:getHeightOffset()
  return 100 * self.scale
end

function Platform:getHeight()
  return self.y - (self.imageHeight * self.scale) + self:getHeightOffset()
end

function Platform:getBox()
  return self.x + worldOffset, self:getHeight(), self:getEndOfWorld(), 50 * self.scale
end

function Platform:getEndOfWorld()
  return self.squares * 100 * self.scale
end

function Platform:isOnPlatform(player)
  return (player.x - worldOffset < self:getEndOfWorld())
end