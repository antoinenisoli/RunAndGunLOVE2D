local anim8 = require 'libraries/anim8' --for animations
local collectible = require 'scripts/collectibles/collectible'
local ammoPack = {}
ammoPack.__index = ammoPack
setmetatable(ammoPack, collectible)

function ammoPack.new(x, y, width, height)
    local instance = setmetatable({}, ammoPack)
    instance.x = x
    instance.y = y

    instance.triggerWidth = width
    instance.triggerHeight = height

    instance:setupGraphics()
    instance:setupPhysics()
    return instance
end

function ammoPack:setupGraphics()
    self.width = 15
    self.height = 11
    self.sprite = love.graphics.newImage('assets/sprites/ammoPack.png')
end

function ammoPack:drawCollider()
    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.rectangle('line', self.x - self.triggerWidth/2, self.y - self.triggerHeight/2, self.triggerWidth, self.triggerHeight)
    love.graphics.setColor(255, 255, 255, 1)
end

function collectible:draw()
    self:drawCollider()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return ammoPack