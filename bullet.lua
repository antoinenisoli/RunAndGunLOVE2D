local explosionVFX = require 'explosionVFX'
local bullet = {}
bullet.__index = bullet

function bullet.new(name, x, y, directionX, directionY, speed)
    local instance = setmetatable({}, bullet)
    instance.x = x
    instance.y = y
    instance.name = name
    instance.speed = speed
    instance.directionX = directionX
    instance.directionY = directionY
    instance.timer = 0
    instance.lifetime = 10
    instance.toBeRemoved = false

    instance:setupGraphics()
    instance:setupPhysics()
    return instance
end

function bullet:setupGraphics()
    self.image = love.graphics.newImage("assets/sprites/tile009.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
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
        return true
    end
end

function bullet:endContact(a, b, collision)
    
end

function bullet:checkRemove()
    if self.toBeRemoved then
        self:remove()
    end
end

function bullet:remove()
    for i, instance in ipairs(PlayerBullets) do
        if instance == self then
            table.remove(PlayerBullets, i)
            self:destroy()
            break
        end
    end
end

function bullet:drawCollider()
    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.rectangle('line', self.x - self.width/2, self.y - self.height/2, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 1)
end

function bullet:draw()
    local s = 2
    love.graphics.draw(self.image, self.x, self.y, math.rad(90) * self.directionY, s, s, self.width/2, self.height/2)
    self:drawCollider()
end

function bullet:destroy()
    self.physics.body:destroy()
    removeGameobject(self)
    local vfx = explosionVFX.new(self.x, self.y)
    table.insert(GameObjects, vfx)
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

return bullet