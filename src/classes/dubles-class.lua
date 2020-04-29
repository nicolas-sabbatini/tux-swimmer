local Dubles = {}
Dubles.__index = Dubles

local Pipe = require('classes/pipe-class')

function Dubles:addDefault(path )
  Pipe:addDefault(path)
end

function Dubles:new( x, minWidth, maxWidth, minHeight, maxHeight, gap, speed )
  local d = {}
  setmetatable(d, Dubles)
  d.x = x or 0
  d.minWidth = (minWidth - Pipe.WIDTH) or 0
  d.maxWidth = maxWidth or 0
  d.minHeight = minHeight or 0
  d.maxHeight = maxHeight or 0
  d.gap = gap or 0
  d.speed = speed or 0
  local r = love.math.random( d.minHeight, d.maxHeight )
  d.y1 = r - Pipe.HEIGHT
  d.y2 = r + d.gap
  d.pipes = {
    Pipe:new(d.x, d.y1),
    Pipe:new(d.x, d.y2)
  }
  return d
end

function Dubles.checkColition(self, box)
  local pipe_box = {
    x1 = self.x,
    y1 = self.y1,
    x2 = self.x  + Pipe.WIDTH,
    y2 = self.y2 + Pipe.HEIGHT,
  }
  if pipe_box.x1 < box.x2 and
     pipe_box.x2 > box.x1 and
     pipe_box.y1 < box.y2 and
     pipe_box.y2 > box.y1 then
    return true
  end
  return false
end

function Dubles.checkPipeColition(self, box)
  local h1 = self.pipes[1]:checkColition(box)
  local h2 = self.pipes[2]:checkColition(box)
  return h1 or h2
end

function Dubles.update(self, dt)
  self.x = self.x - (self.speed * dt)
  if self.x < self.minWidth then
    self.x = self.maxWidth
    local r = love.math.random( self.minHeight, self.maxHeight )
    self.y1 = r - Pipe.HEIGHT
    self.y2 = r + self.gap
  end
  self.pipes[1]:update(self.x, self.y1)
  self.pipes[2]:update(self.x, self.y2)
end

function Dubles.draw(self)
  self.pipes[1]:draw()
  self.pipes[2]:draw()
end

return Dubles
