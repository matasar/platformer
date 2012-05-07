Player = {}
Player.__index = Player

function Player.create(xPos,yPos)
  local instance = {
    x = xPos,
    y = yPos,
    upVelocity = 0,
    image = love.graphics.newImage("planetcute/Character Boy.png"),
    gravity = gravity,
    jumpHeight = 900,
    upAcceleration = 0,
    maxUpAcceleration = 0.4,
    maxXVelocity = 400,
    xAcceleration = 2000,
    xVelocity = 0,
    decelDirection = 1,
    xDeceleration = 1000,
    orientation = 0
  }
  setmetatable(instance, Player)
  return instance
end

function Player:draw()
  love.graphics.draw(self.image, self.x, self.y, self.orientation, 1, 1, 50, 85)
--  local x,y,width,height = self:getHitBox()
--  love.graphics.rectangle("line", x,y,width,height)
end

function Player:getHitBox()
  return self.x - 40, self.y - 30, 80, 85
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

function Player:isMoving()
  return self:isMovingLeft() or self:isMovingRight()
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

  if self:isJumping() then
    self.y = self.y - self.upVelocity * dt
    self.upVelocity = self.upVelocity - (self.gravity * dt)
    if self.y > 485 then
      self.upVelocity = 0
      self.upAcceleration = 0
      self.y = 485
    end
  end

  if self:isMovingLeft() then
    self.xVelocity = math.min(self.xVelocity + (dt * self.xAcceleration), self.maxXVelocity)
    self.x = self.x - dt * self.xVelocity
    self.decelDirection = -1
    self.orientation = -1 * math.pi / 20
  elseif self:isMovingRight() then
    self.xVelocity = math.min(self.xVelocity + (dt * self.xAcceleration), self.maxXVelocity)
    self.x = self.x + dt * self.xVelocity
    self.decelDirection = 1
    self.orientation = math.pi / 20
  else -- decel
    self.xVelocity = math.max(math.abs(self.xVelocity) - (dt * self.xDeceleration), 0) * self.decelDirection
    self.x = self.x + dt * self.xVelocity
    self.orientation = 0
  end
end