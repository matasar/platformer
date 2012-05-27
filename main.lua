require 'src/player'
require 'src/platform'
require 'src/lib/ilua'

local actions = {
  up = {'up', 'w', ' '},
  left = {'left', 'a'},
  down = {'down', 's'},
  right = {'right', 'd'},
}

local keyMap = {}
for action, keys in pairs(actions) do
  for i, key in pairs(keys) do
    keyMap[key] = action
  end
end

gravity = 5000
worldOffset = 0
playerMaxX = love.graphics.getWidth() - 200
playerMinX = 100

function love.load()
  local skyBlue = {153, 204, 255}

  ground = Platform.create(0,love.graphics.getHeight() - 200,12,love.graphics.newImage("planetcute/Grass Block.png"))
  player = Player.create(300, ground:getHeight(), 0.65)

  love.graphics.setBackgroundColor(skyBlue)
end

function love.keypressed(k)
  local action = keyMap[k]
  if player[action] then
    player[action](player)
  end
end

function keyDownForAction(action)
  local keys = actions[action]
  for i, key in pairs(keys) do
    if love.keyboard.isDown(key) then
      return true
    end
  end
  return false
end

function withColor(color, fn)
  local r,g,b,a = love.graphics.getColor()
  love.graphics.setColor(color)
  fn()
  love.graphics.setColor(r,g,b,a)
end

function updateWorldOffset(newOffset)
  worldOffset = math.min(0,newOffset)
end

function love.draw()
  ground:draw()
  player:draw()
  local yellow = {204, 255, 51, 255}
  withColor(yellow, function()
    love.graphics.arc("fill", 0, 0, 100, 0, math.pi / 2, 20)
  end)
  withColor({0,0,0}, function()
    love.graphics.print("FPS: " .. love.timer.getFPS(), 750, 0)
  end)
end

function love.update(dt)
  player:update(dt)
end