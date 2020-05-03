local Timer = {}
Timer.__index = Timer

function Timer:load(width, height)
  local t = {}
  setmetatable(t, Timer)
  t.WIDTH = width
  t.HEIGHT = height
  t.font = love.graphics.newFont('assets/fonts/fff-forward/FFFFORWA.TTF', 60)
  t.time = 3
  t.acu = 0

  return t
end

function Timer.reload(self)
  return self:load(self.WIDTH, self.HEIGHT)
end

function Timer.update(self, dt)
  self.acu = self.acu + dt
  if self.acu > 1 then 
    self.time = self.time - 1
    self.acu = 0
  end
  if self.acu > 0.25 and self.time <= 0 then
    return 0
  end
end

function Timer.draw(self)
  love.graphics.setFont(self.font)
  love.graphics.printf(self.time, 0, self.HEIGHT/3, self.WIDTH, 'center')
end

return Timer
