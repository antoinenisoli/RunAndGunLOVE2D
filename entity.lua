local shaders = require 'shaders'
local entity = {}
entity.__index = entity

function entity.new(x, y, direction)
    local instance = setmetatable({}, entity)
    instance:setupAnimations()
    instance.x = x
    instance.y = y
    instance.direction = direction

    instance.shootTimer = 0
    instance.shootRate = math.random(1,3) + math.random()

    instance:setupHealth()
    instance:setupPhysics()
    return instance
end

function entity:setupHealth()
    self.hitTimer = 0
    self.hitDuration = 0.1
    self.maxHealth = 3
    self.currentHealth = self.maxHealth
    self.hit = false
end

function entity:setupAnimations()
    self.width = 0
    self.height = 0
    self.spriteSheet = nil
    self.animations = {}
    self.animations.idle = nil
    self.currentAnimation = self.animations.idle
end

function entity:setupPhysics()
    self.xVel = 0
    self.yVel = 0
    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setSensor(true)
end

function entity:beginContact(a, b, collision)
    
end

function entity:endContact(a, b, collision)
    
end

function entity:takeDmg(value)
    self.hitTimer = 0
    self.currentHealth = self.currentHealth - value
    if self.currentHealth <= 0 then
        self:destroy()
    end
end

function entity:manageHit(dt)
    self.hitTimer = self.hitTimer + dt
    if self.hitTimer > self.hitDuration and self.hit then
        self.hit = false
    end
end

function entity:syncPhysics()
    self.x, self.y = self.physics.body:getPosition() 
    self.physics.body:setLinearVelocity(self.xVel, self.yVel)  
end

function entity:drawCollider()
    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.rectangle('line', self.x - self.width/2, self.y - self.height/2, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 1)
end

function entity:draw()
    if self.hit then
        love.graphics.setShader(shaders.hitFlashShader(1,1,1))
    end

    self.currentAnimation:draw(self.spriteSheet, self.x, self.y - self.height/2, nil, self.direction, 1, self.height/2, 0)
    love.graphics.setShader()
    self:drawCollider()
end

function entity:update(dt)
    self.currentAnimation:update(dt)
    self:manageHit(dt)
end

return entity