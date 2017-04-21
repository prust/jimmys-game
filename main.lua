local anim8 = require 'anim8'
local sti = require "sti"

function love.load()
  speed = 110
  x = 125
  y = 50
  skelly = love.graphics.newImage("skeleton.png")
  local g = anim8.newGrid(64, 64, skelly:getWidth(), skelly:getHeight())
  right = anim8.newAnimation(g('2-9',4), 0.1)
  down = anim8.newAnimation(g('2-9',3), 0.1)
  left = anim8.newAnimation(g('2-9',2), 0.1)
  up = anim8.newAnimation(g('2-9',1), 0.1)
  motionless = anim8.newAnimation(g(1,3), 0.1)
  anim = motionless

  love.window.setFullscreen(true)
  width, height = love.graphics.getDimensions()
  time = 0

  -- Load a map exported to Lua from Tiled
  map = sti("Lava Place.lua", { "bump" })
end

function love.update(dt)
  right:update(dt)
  map:update(dt)
  time = time+dt
  if love.keyboard.isDown("right") then
    x = x+dt*speed
    anim = right
  elseif love.keyboard.isDown("left") then
    x = x-dt*speed
    anim = left
  elseif love.keyboard.isDown("down") then
    y = y+dt*speed
    anim = down
  elseif love.keyboard.isDown("up") then
    y = y-dt*speed
    anim = up
  else
    anim = motionless
  end
  anim:update(dt)
end

function love.draw()
  if time < 5 then
    right:draw(skelly, width/2, height/2)
    love.graphics.print("LOADING...", width/2-25, height/2-30)
  else
    map:draw()
    anim:draw(skelly, x, y)
  end
end

function love.keyreleased(key)
   if key == "escape" then
      love.event.quit()
   end
end