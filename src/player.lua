Player = {}
Player.__index = Player

function Player.create(xPos,yPos)
  local instance = {
    x = xPos,
    y = yPos,
    upVelocity = 0,
    image = love.graphics.newImage("planetcute/Character Boy.png"),
    gravity = gravity,
    jumpHeight = 1100,
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
  local x,y,width,height = self:getBox()
  love.graphics.rectangle("line", x,y,width,height)
end

function Player:getBox()
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
  return not keyDownForAction("right") and keyDownForAction("left")
end

function Player:isMovingRight()
  return not keyDownForAction("left") and keyDownForAction("right")
end

function Player:isOnGround()
  return ground:isOnGround(self)
end

function Player:moveX(direction, dt) -- -1 is left, 1 is right
  self.xVelocity = math.min(self.xVelocity + (dt * self.xAcceleration), self.maxXVelocity)
  self.x = self.x + dt * self.xVelocity * direction
  self.decelDirection = direction
  self.orientation = direction * math.pi / 20
  if self.x < playerMinX then
    updateWorldOffset(worldOffset + dt * self.xVelocity)
    self.x = playerMinX
  end
  if self.x > playerMaxX then
    updateWorldOffset(worldOffset - dt * self.xVelocity)
    self.x = playerMaxX
  end
end

function Player:decellerateX(dt)
  self.xVelocity = math.max(math.abs(self.xVelocity) - (dt * self.xDeceleration), 0) * self.decelDirection
  if self.x >= playerMaxX then
    updateWorldOffset(worldOffset - dt * self.xVelocity)
    self.x = playerMaxX
  elseif self.x <= playerMinX then
    updateWorldOffset(worldOffset - dt * self.xVelocity)
    self.x = playerMinX
  else
    self.x = self.x + dt * self.xVelocity
  end
  self.orientation = 0
end

function Player:updateJump(dt)
  self.y = self.y - self.upVelocity * dt
  self.upVelocity = self.upVelocity - (self.gravity * dt)
  if self.y > 485 and self:isOnGround() then
    self.upVelocity = 0
    self.upAcceleration = 0
    self.y = 485
  end
end

function Player:update(dt)
  if self.upAcceleration > 0 and keyDownForAction("up") and self:isOnGround() then
    self.upAcceleration = self.upAcceleration - dt
    self.upVelocity = self.upVelocity + self.jumpHeight * (dt / self.maxUpAcceleration)
  end

  if self:isJumping() then
    self:updateJump(dt)
  elseif not self:isOnGround() then
    self.upVelocity = self.upVelocity - (self.gravity * dt)
  end

  if self:isMovingLeft() then
    self:moveX(-1, dt)
  elseif self:isMovingRight() then
    self:moveX(1, dt)
  else -- decel
    self:decellerateX(dt)
  end
end