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
  for i = 1,9 do
    local xPos = ((i - 1) * 100)
    love.graphics.draw(self.image, xPos, self:getHeight())
  end
end

function Ground:getHeight()
  return love.graphics.getHeight() - self.height
end