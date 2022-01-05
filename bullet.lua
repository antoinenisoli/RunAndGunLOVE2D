require 'explosionVFX'
bullet = {}
bullet.__index = bullet

function bullet.new(name, x, y)
    local instance = setmetatable({}, bullet)
    instance.x = x
    instance.y = y
    instance.image = love.graphics.newImage("assets/sprites/tile013.png")
    instance.width = instance.image:getWidth()
    instance.height = instance.image:getHeight()
    instance.name = name
    instance.speed = 450
    instance.directionX = player.directionX
    instance.directionY = player.directionY
    instance.timer = 0
    instance.lifetime = 10
    instance.toBeRemoved = false

    instance:setupPhysics()
    return instance
end

function bullet:setupPhysics()
    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setSensor(true)
end

function bullet:syncPhysics(dt)
    self.x, self.y = self.physics.body:getPosition() 
    if self.directionY == 0 then
        self.physics.body:setLinearVelocity(self.speed * self.directionX, 0)  
    else
        self.physics.body:setLinearVelocity(0, self.speed * self.directionY)  
    end
end

function bullet:beginContact(a, b, collision)
    if self.physics.fixture == a or b == self.physics.fixture then
        if player.physics.fixture ~= a and b ~= player.physics.fixture then
            --self.toBeRemoved = true
        end

        return true
    end
end

function bullet:endContact(a, b, collision)
    
end

function bullet:checkRemove()
    if self.toBeRemoved then
        self:destroy()
    end
end

function bullet:drawCollider()
    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.rectangle('line', self.x - self.width/2, self.y - self.height/2, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 1)
end

function bullet:draw()
    self:drawCollider()
    local s = 1.3
    love.graphics.draw(self.image, self.x, self.y, math.rad(90) * self.directionY, s, s, self.width/2, self.height/2)
end

function bullet:destroy()
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

function bullet:update(dt)
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