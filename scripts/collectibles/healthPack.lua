local anim8 = require 'libraries/anim8' --for animations
local collectible = require 'collectible'
local healthPack = {}
healthPack.__index = healthPack
setmetatable(healthPack, collectible)

function healthPack:setupGraphics()
    self.x = 469
    self.y = 205
    self.spriteSheet = love.graphics.newImage('assets/sprites/tileset_icons.png')
    self.grid = anim8.newGrid(16, 16, self.spriteSheet:getWidth(), self.spriteSheet:getHeight() )
    self.width = 16
    self.height = 16
    local frames = self.grid('1-4', 1)
    self.sprite = frames[2]
end

return healthPack