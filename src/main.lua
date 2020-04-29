local push = require './lib/push'
local play_state = require 'states/play-state'

-- Gloval
KEY_TABLE = {}

-- aspect ratio 16:9
local REAL_WIDTH  = 1280
local REAL_HEIGHT = 720
local FAKE_WIDTH  = 480
local FAKE_HEIGHT = 270

-- Local
local background, midleground, play

-- Auxiliar functions
function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
  KEY_TABLE[key] = true
end

-- Game functions
function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  -- Load graphics
  background = {
    img = love.graphics.newImage('assets/fondo-mar.png'),
    x1 = 0,
    x2 = FAKE_WIDTH,
    xm = 10,
  }
  midleground = {
    img = love.graphics.newImage('assets/frente.png'),
    x1 = 0,
    x2 = FAKE_WIDTH,
    xm = 30,
  }

  play = play_state:load(FAKE_WIDTH, FAKE_HEIGHT)

  push:setupScreen(FAKE_WIDTH, FAKE_HEIGHT, REAL_WIDTH, REAL_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true,
  })
end

function love.update(dt)
  background.x1 = background.x1 - (background.xm * dt)
  background.x2 = background.x2 - (background.xm * dt)

  midleground.x1 = midleground.x1 - (midleground.xm * dt)
  midleground.x2 = midleground.x2 - (midleground.xm * dt)

  if background.x1 < -FAKE_WIDTH then background.x1 = FAKE_WIDTH end
  if background.x2 < -FAKE_WIDTH then background.x2 = FAKE_WIDTH end
  if midleground.x1 < -FAKE_WIDTH then midleground.x1 = FAKE_WIDTH end
  if midleground.x2 < -FAKE_WIDTH then midleground.x2 = FAKE_WIDTH end

  play:update(dt)
  KEY_TABLE = {}
end

function love.draw()
  push:start()
  love.graphics.draw(background.img , background.x1, 0)
  love.graphics.draw(background.img , background.x2, 0)
  love.graphics.draw(midleground.img , midleground.x1, 0)
  love.graphics.draw(midleground.img , midleground.x2, 0)
  play:draw()
  push:finish()
end
