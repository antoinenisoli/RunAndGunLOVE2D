local bullet = require 'bullet'
local bulletPlayer = {}
bulletPlayer.__index = bulletPlayer
setmetatable(bulletPlayer, bullet)

function bulletPlayer.new(name, x, y, directionX, directionY)
    local instance = setmetatable({}, bulletPlayer)
    instance.x = x
    instance.y = y
    instance.name = name
    instance.speed = 450
    instance.directionX = directionX
    instance.directionY = directionY
    instance.timer = 0
    instance.lifetime = 10
    instance.toBeRemoved = false

    instance:setupGraphics()
    instance:setupPhysics()
    return instance
end

function bulletPlayer:setupGraphics()
    self.image = love.graphics.newImage("assets/sprites/tile013.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.speed = 450
end

function bulletPlayer:beginContact(a, b, collision)
    if a == self.physics.fixture or b == self.physics.fixture then
        for i, enemy in ipairs(Enemies) do
            if a == enemy.physics.fixture or b == enemy.physics.fixture then
                if enemy.hit == false then
                    enemy.hit = true
                    self.toBeRemoved = true
                    enemy:takeDmg(1)
                    break
                end
            end
        end

        return true
    end
end

return bulletPlayer