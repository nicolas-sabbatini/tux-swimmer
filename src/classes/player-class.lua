local Player = {}
Player.__index = Player

-- TODO sound
function Player:new(x, y, img, minY, maxY, gravity, acceleration, score_audio, dead_audio, flap_audio)
  local p = {}
  setmetatable(p, Player)
  p.img = love.graphics.newImage(img)
  p.width  = p.img:getWidth()
  p.height = p.img:getHeight()
  p.x = x - p.width /2 or 0
  p.y = y - p.height/2 or 0
  p.minY = minY or 0
  p.maxY = maxY or 0
  p.G = gravity or 0.94
  p.A = acceleration or -0.47
  p.V = 0
  p.score = 0
  p.alive = true
  if score_audio then
    p.score_sound = {}
    for key, value in pairs(score_audio) do
      p.score_sound[key] = love.audio.newSource(value, 'static') 
    end
  end
  if dead_audio then
    p.dead_sound = love.audio.newSource(dead_audio, 'static')
  end
  if flap_audio then
    p.flap_sound = {}
    for key, value in pairs(flap_audio) do
      p.flap_sound[key] = love.audio.newSource(value, 'static')
      p.flap_sound[key]:setVolume(0.1)
    end
  end
  return p
end

function Player.getBorders(self)
  local x1 = self.x + 5
  local y1 = self.y + 5
  local x2 = self.x + self.width - 5
  local y2 = self.y + self.height - 5
  return {x1 = x1, x2 = x2, y1 = y1, y2 = y2}
end

function Player.scoreUp(self)
  self.score = self.score + 1
  if self.score_sound then
    local r = love.math.random(#self.score_sound)
    self.score_sound[r]:play()
  end
end

function Player.kill(self)
  self.alive = false
  if self.dead_sound then
    self.dead_sound:play()
  end
end

function Player.update(self, dt)
  if KEY_TABLE['space'] then
    self.V = self.A
    if self.flap_sound then
      local r = love.math.random(#self.flap_sound)
      self.flap_sound[r]:play()
    end
  else
    self.V = self.V + (self.G * dt)
  end
  self.y = self.y + self.V
  if self.y < self.minY then self:kill() end
  if self.y > self.maxY - self.height then self:kill() end
end

function Player.draw(self)
  love.graphics.draw(self.img, self.x, self.y)
end

return Player