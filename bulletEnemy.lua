require 'explosionVFX'
bulletEnemy = {}
bulletEnemy.__index = bulletEnemy

function bulletEnemy.new(name, x, y, direction)
    local instance = setmetatable({}, bulletEnemy)
    instance.x = x
    instance.y = y
    instance.image = love.graphics.newImage("assets/sprites/tile009.png")
    instance.width = instance.image:getWidth()
    instance.height = instance.image:getHeight()
    instance.name = name
    instance.speed = 200
    instance.directionX = direction
    instance.timer = 0
    instance.lifetime = 10
    instance.toBeRemoved = false

    instance:setupPhysics()
    return instance
end

function bulletEnemy:setupPhysics()
    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setSensor(true)
end

function bulletEnemy:syncPhysics(dt)
    self.x, self.y = self.physics.body:getPosition() 
    self.physics.body:setLinearVelocity(self.speed * self.directionX, 0)  
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

function bulletEnemy:endContact(a, b, collision)
    
end

function bulletEnemy:checkRemove()
    if self.toBeRemoved then
        self:destroy()
    end
end

function bulletEnemy:drawCollider()
    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.rectangle('line', self.x - self.width/2, self.y - self.height/2, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 1)
end

function bulletEnemy:draw()
    local s = 2
    love.graphics.draw(self.image, self.x, self.y, nil, s, s, self.width/2, self.height/2)
    self:drawCollider()
end

function bulletEnemy:destroy()
    removeGameobject(self)

    for i, instance in ipairs(PlayerBullets) do
        if instance == self then
            self.physics.body:destroy()
            table.remove(PlayerBullets, i)
            local vfx = explosionVFX.new(self.x, self.y)
            table.insert(GameObjects, vfx)
            break
        end
    end
end

function bulletEnemy:update(dt)
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