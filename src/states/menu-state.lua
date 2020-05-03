local Menu = {}
Menu.__index = Menu

function Menu:load(width, height)
  local m = {}
  setmetatable(m, Menu)
  m.WIDTH = width
  m.HEIGHT = height
  m.font_big = love.graphics.newFont('assets/fonts/fff-forward/FFFFORWA.TTF', 50)
  m.font_small = love.graphics.newFont('assets/fonts/fff-forward/FFFFORWA.TTF', 10)
  return m
end

function Menu.reload(self)
  return self:load(self.WIDTH, self.HEIGHT)
end

function Menu.update(dt)
  if KEY_TABLE['space'] then
    return 0
  end
end

function Menu.draw(self)
  love.graphics.setFont(self.font_big)
  love.graphics.printf('TUX SWIMER', 0, self.HEIGHT/3, self.WIDTH, 'center')
  love.graphics.setFont(self.font_small)
  love.graphics.printf('Press "SPACE" to start', 0, (self.HEIGHT/3) * 2, self.WIDTH, 'center')
end

return Menu