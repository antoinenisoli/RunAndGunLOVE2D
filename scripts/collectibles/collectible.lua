local anim8 = require 'libraries/anim8' --for animations
local test = require 'scripts/test'
local collectible = {}

function collectible:new(x, y)
    self.x = x
    self.y = y
end

function collectible:setupGraphics()
    self.spriteSheet = love.graphics.newImage('assets/sprites/tileset_icons.png')
    self.grid = anim8.newGrid(16, 16, self.spriteSheet:getWidth(), self.spriteSheet:getHeight() )
    self.width = 16
    self.height = 16
    local frames = self.grid('1-4', 1)
    self.sprite = frames[2]
end

function collectible:load()
    self:setupGraphics()
end

function collectible:draw()
    love.graphics.draw(self.spriteSheet, self.sprite, self.x, self.y, nil, 1, 1, self.width/2, self.height/2)
end

return collectible