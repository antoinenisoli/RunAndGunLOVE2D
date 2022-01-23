local anim8 = require 'libraries/anim8' --for animations
local collectible = require 'scripts/collectibles/collectible'
local player = require 'scripts/entities/player'
local ammoPack = {}
ammoPack.__index = ammoPack
setmetatable(ammoPack, collectible)

function ammoPack.new(x, y, width, height)
    local instance = setmetatable({}, ammoPack)
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

function ammoPack:setupGraphics()
    self.width = 15
    self.height = 11
    self.sprite = love.graphics.newImage('assets/sprites/collectibles/ammoPack.png')
end

function ammoPack:effect()
    soundManager.playSound("assets/sounds/Free_Game_Sound_FX/WEAPON CLICK Reload Mechanism 01.wav", 1)
    player.ammo = player.ammo + self.ammoValue
    self.toBeRemoved = true
end

function ammoPack:draw()
    self:drawCollider()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return ammoPack