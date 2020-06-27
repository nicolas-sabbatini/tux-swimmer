local Play = {}
Play.__index = Play

local Player = require('classes/player-class')
local Dubles = require('classes/dubles-class')

function Play:load(width, height)
  local p = {}
  setmetatable(p, Play)
  p.LIMIT_WIDTH = width
  p.LIMIT_HEIGHT = height
  p.COLITION_INDEX = 0

  Dubles:addDefault('assets/pipe.png')
 
  p.pipes = {}
  for i=1, 5 do
    p.pipes[i] = Dubles:new(width + (103 * i-1), -- x
                            0, -- minWidth
                            width, -- maxWidth
                            90, -- minHeight
                            height - 90, -- maxHeight
                            60, -- gap
                            56) -- speed
  end

  p.player = Player:new(width/2, height/2, 'assets/tux.png', 0, height, 3, -1.5, 
  {'assets/score1.wav', 'assets/score2.wav', 'assets/score3.wav', 'assets/score4.wav'},
  'assets/game_over.wav',
  {'assets/flap1.wav', 'assets/flap2.wav', 'assets/flap3.wav', 'assets/flap4.wav'})
  
  p.font = love.graphics.newFont('assets/fonts/fff-forward/FFFFORWA.TTF', 10)
  p.font:setFilter('nearest')
  
  return p
end

function Play.reload(self, value)
  return self:load(self.LIMIT_WIDTH, self.LIMIT_HEIGHT)
end

function Play.update(self, dt)
  if self.player.alive then
    for key, pipe in pairs(self.pipes) do
      pipe:update(dt)
    end
    self.player:update(dt)
    local player_box = self.player:getBorders()
    for key, pipe in pairs(self.pipes) do
      local result = pipe:checkColition(player_box)
      if result then
        self.COLITION_INDEX = key
        result = pipe:checkPipeColition(player_box)
        if result then
          self.player:kill()
        end
      elseif self.COLITION_INDEX == key then
        self.COLITION_INDEX = 0
        self.player:scoreUp()
      end
    end
  else
    return self.player.score
  end
end

function Play.draw(self)
  for key, pipe in pairs(self.pipes) do
    pipe:draw()
  end
  love.graphics.setFont(self.font)
  love.graphics.printf('Score: ' .. self.player.score, 10, 10, self.LIMIT_WIDTH, 'left')
  self.player:draw()
end


return Play