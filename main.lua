require 'src/player'
require 'src/ground'
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

ilua.p(keyMap)

function love.load()
  local skyBlue = {153, 204, 255}

  player = Player.create(300, 400)
  ground = Ground.create()
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

function love.draw()
  ground:draw()
  player:draw()
end

function love.update(dt)
  player:update(dt)
end