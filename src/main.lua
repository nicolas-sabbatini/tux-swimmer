local push = require './lib/push'
local play_state = require 'states/play-state'
local score_state = require 'states/score-state'
local timer_state = require 'states/timer-state'
local menu_state = require 'states/menu-state'

-- Gloval
KEY_TABLE = {}

-- aspect ratio 16:9
local REAL_WIDTH  = 1280
local REAL_HEIGHT = 720
local FAKE_WIDTH  = 480
local FAKE_HEIGHT = 270

-- Local
local background, midleground, current, states, order

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

  order = {
    menu = 'timer',
    timer = 'play',
    play = 'score',
    score = 'timer',
  }
  current = 'menu'
  states =  {
    menu = menu_state:load(FAKE_WIDTH, FAKE_HEIGHT),
    timer = timer_state:load(FAKE_WIDTH, FAKE_HEIGHT),
    play = play_state:load(FAKE_WIDTH, FAKE_HEIGHT),
    score = score_state:load(FAKE_WIDTH, FAKE_HEIGHT, 0),
  }

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

  local value = states[current]:update(dt)
  if value then
    current = order[current]
    states[current] = states[current]:reload(value) 
  end
  KEY_TABLE = {}
end

function love.draw()
  push:start()
  love.graphics.draw(background.img , background.x1, 0)
  love.graphics.draw(background.img , background.x2, 0)
  love.graphics.draw(midleground.img , midleground.x1, 0)
  love.graphics.draw(midleground.img , midleground.x2, 0)
  states[current]:draw()
  push:finish()
end
