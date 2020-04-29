local Pipe = {}
Pipe.__index = Pipe

-- Default Pipe img
function Pipe.addDefault( self, path )
  self.img = love.graphics.newImage( path )
  self.WIDTH  = self.img:getWidth() 
  self.HEIGHT = self.img:getHeight()
end

function Pipe:new(x, y)
  local p = {}
  setmetatable( p, Pipe )
  p.x = x or 0
  p.y = y or 0
  return p
end

function Pipe.checkColition(self, box)
  local pipe_box = {
    x1 = self.x,
    y1 = self.y,
    x2 = self.x + Pipe.WIDTH,
    y2 = self.y + Pipe.HEIGHT,
  }
  if pipe_box.x1 < box.x2 and
     pipe_box.x2 > box.x1 and
     pipe_box.y1 < box.y2 and
     pipe_box.y2 > box.y1 then
    return true
  end
  return false
end

function Pipe.update(self, x, y)
  self.x = x
  self.y = y
end

function Pipe.draw( self )
  love.graphics.draw(self.img, self.x, self.y)
end

return Pipe
