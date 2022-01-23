local anim8 = require 'libraries/anim8' --for animations
local explosionVFX = {}
explosionVFX.__index = explosionVFX

function explosionVFX.new(x, y)
    local instance = setmetatable({}, explosionVFX)
    instance.x = x
    instance.y = y
    
    instance.spriteSheet = love.graphics.newImage('assets/sprites/Explosion_Particle.png')
    instance.width = 32
    instance.height = 32
    instance.grid = anim8.newGrid(instance.width, instance.height, instance.spriteSheet:getWidth(), instance.spriteSheet:getHeight())
    instance.animation = anim8.newAnimation(instance.grid('1-9', 1), 0.06)

    instance.timer = 0
    return instance
end

function explosionVFX:draw()
    self.animation:draw(self.spriteSheet, self.x, self.y, nil, 0.5, 0.5, self.width/2, self.height/2)
end

function explosionVFX:update(dt)
    self.animation:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.animation.totalDuration then
        self:destroy()
    end
end

function explosionVFX:destroy()
    for i, instance in ipairs(GameObjects) do
        if instance == self then
            table.remove(GameObjects, i)
        end
    end
end

function explosionVFX:beginContact(a, b, collision)
    
end

function explosionVFX:endContact(a, b, collision)
    
end

return explosionVFX