require 'explosionVFX'
bulletPlayer = {}
bulletPlayer.__index = bulletPlayer

function bulletPlayer.new(name, x, y, direction)
    local enemy = setmetatable({}, bulletPlayer)
    enemy.x = x
    enemy.y = y
    enemy.image = love.graphics.newImage("assets/sprites/tile013.png")
    enemy.width = enemy.image:getWidth()
    enemy.height = enemy.image:getHeight()
    enemy.name = name
    enemy.speed = 450
    enemy.directionX = direction
    enemy.directionY = player.directionY
    enemy.timer = 0
    enemy.lifetime = 10
    enemy.toBeRemoved = false

    enemy:setupPhysics()
    return enemy
end

function bulletPlayer:setupPhysics()
    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setSensor(true)
end

function bulletPlayer:syncPhysics(dt)
    self.x, self.y = self.physics.body:getPosition() 
    if self.directionY == 0 then
        self.physics.body:setLinearVelocity(self.speed * self.directionX, 0)  
    else
        self.physics.body:setLinearVelocity(0, self.speed * self.directionY)  
    end
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

function bulletPlayer:endContact(a, b, collision)
    
end

function bulletPlayer:checkRemove()
    if self.toBeRemoved then
        self:destroy()
    end
end

function bulletPlayer:drawCollider()
    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.rectangle('line', self.x - self.width/2, self.y - self.height/2, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 1)
end

function bulletPlayer:draw()
    local s = 2
    love.graphics.draw(self.image, self.x, self.y, math.rad(90) * self.directionY, s, s, self.width/2, self.height/2)
    self:drawCollider()
end

function bulletPlayer:destroy()
    removeGameobject(self)

    for i, enemy in ipairs(PlayerBullets) do
        if enemy == self then
            self.physics.body:destroy()
            table.remove(PlayerBullets, i)
            local vfx = explosionVFX.new(self.x, self.y)
            table.insert(GameObjects, vfx)
            break
        end
    end
end

function bulletPlayer:update(dt)
    self:syncPhysics(dt)
    self:checkRemove()

    self.timer = self.timer + dt
    if self.timer > self.lifetime then
        self.toBeRemoved = true
    end

    local screenBounds = 50
    if self.x >= screenWidth - screenBounds or self.x <= screenBounds/4 then
        self.toBeRemoved = true
    end
    if self.y >= screenHeight - screenBounds or self.y <= screenBounds/4 then
        self.toBeRemoved = true
    end
end