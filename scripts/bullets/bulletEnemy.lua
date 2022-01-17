local bullet = require 'scripts/bullets/bullet'
local player = require 'scripts/entities/player'
local bulletEnemy = {}
bulletEnemy.__index = bulletEnemy
setmetatable(bulletEnemy, bullet)

function bulletEnemy.new(name, x, y, directionX, directionY)
    local instance = setmetatable({}, bulletEnemy)
    instance.x = x
    instance.y = y
    instance.name = name
    instance.speed = 250
    instance.directionX = directionX
    instance.directionY = directionY
    instance.timer = 0
    instance.lifetime = 10
    instance.toBeRemoved = false

    instance:setupGraphics()
    instance:setupPhysics()
    return instance
end

function bulletEnemy:remove()
    for i, instance in ipairs(EnemyBullets) do
        if instance == self then
            table.remove(EnemyBullets, i)
            self:destroy()
            break
        end
    end
end

function bulletEnemy:beginContact(a, b, collision)
    if self.physics.fixture == a or b == self.physics.fixture then
        if player.physics.fixture == a or b == player.physics.fixture then
            if player.hit == false then
                player.hit = true
                self.toBeRemoved = true
                player:takeDmg(1)
            end
        end

        return true
    end
end

return bulletEnemy