local anim8 = require 'libraries/anim8' --for animations
local collectible = require 'scripts/collectibles/collectible'
local player = require 'scripts/entities/player'
local healthPack = {}
healthPack.__index = healthPack
setmetatable(healthPack, collectible)

function healthPack.new(x, y, width, height)
    local instance = setmetatable({}, healthPack)
    instance.x = x
    instance.y = y
    instance.toBeRemoved = false
    instance.triggerWidth = width
    instance.triggerHeight = height

    instance.ammoValue = 5

    instance:setupGraphics()
    instance:setupPhysics()
    return instance
end

function healthPack:setupGraphics()
    self.width = 15
    self.height = 11
    self.sprite = love.graphics.newImage('assets/sprites/collectibles/healthPack.png')
end

function healthPack:effect()
    player.ammo = player.ammo + self.ammoValue
    self.toBeRemoved = true
end

function healthPack:draw()
    self:drawCollider()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return healthPack