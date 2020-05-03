local Score = {}
Score.__index = Score

function Score:load(width, height, score )
  local s = {}
  setmetatable(s, Score)
  s.font_big = love.graphics.newFont('assets/fonts/fff-forward/FFFFORWA.TTF', 50)
  s.font_small = love.graphics.newFont('assets/fonts/fff-forward/FFFFORWA.TTF', 10)
  s.font_big:setFilter('nearest')
  s.font_small:setFilter('nearest')
  s.WIDTH = width
  s.HEIGHT = height
  s.score = score
  return s
end

function Score.reload(self, score)
  return self:load(self.WIDTH, self.HEIGHT, score)
end

function Score.update(self, dt)
  if KEY_TABLE['return'] then
    return 0
  end
end

function Score.draw(self)
  love.graphics.setFont(self.font_big)
  love.graphics.printf(self.score, 0, self.HEIGHT/3, self.WIDTH, 'center')
  love.graphics.setFont(self.font_small)
  love.graphics.printf('Press "ENTER" to restart', 0, (self.HEIGHT/3) * 2, self.WIDTH, 'center')
end

return Score