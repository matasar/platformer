Player = {}
Player.__index = Player

function Player.create(xPos,yPos)
  local instance = {
    x = xPos,
    y = yPos,
    upVelocity = 0,
    image = love.graphics.newImage("planetcute/Character Boy.png"),
    gravity = 1000,
    jumpHeight = 400,
    upAcceleration = 0,
    maxUpAcceleration = 0.1,
    xVelocity = 400
  }
  setmetatable(instance, Player)
  return instance
end

function Player:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

function Player:up()
  if not self:isJumping() then
    self.upAcceleration = self.maxUpAcceleration
    self.upVelocity = self.jumpHeight
  end
end

function Player:isJumping()
  return self.upVelocity ~= 0
end

function Player:isMovingLeft()
  return keyDownForAction("left")
end

function Player:isMovingRight()
  return not self:isMovingLeft() and keyDownForAction("right")
end

function Player:update(dt)
  if self.upAcceleration > 0 and keyDownForAction("up") then
    self.upAcceleration = self.upAcceleration - dt
    self.upVelocity = self.upVelocity + self.jumpHeight * (dt / self.maxUpAcceleration)
  end

  if self.upVelocity ~= 0 then
    self.y = self.y - self.upVelocity * dt
    self.upVelocity = self.upVelocity - (self.gravity * dt)
    if self.y > 400 then
      self.upVelocity = 0
      self.upAcceleration = 0
      self.y = 400
    end
  end
  if self:isMovingLeft() then
    self.x = self.x - dt * self.xVelocity
  end
  if self:isMovingRight() then
    self.x = self.x + dt * self.xVelocity
  end

end