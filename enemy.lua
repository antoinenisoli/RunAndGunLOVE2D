require 'shaders'
enemy = {}
enemy.__index = enemy

function enemy.new(x, y, direction)
    local instance = setmetatable({}, enemy)
    instance:setupAnimations()
    instance.x = x
    instance.y = y - instance.height/2
    instance.direction = direction
    instance.timer = 0
    instance.hitDuration = 0.1
    instance.maxHealth = 3
    instance.currentHealth = instance.maxHealth
    instance.hit = false

    instance:setupPhysics()
    return instance
end

function enemy:setupPhysics()
    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setSensor(true)
end

function enemy:setupAnimations()
    self.spriteSheet = love.graphics.newImage('assets/sprites/Enemies/ARMob.png')
    self.width = 16
    self.height = 38
    self.grid = anim8.newGrid(32, 38, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
    self.animations = {}
    self.animations.idle = anim8.newAnimation(self.grid('1-3', 1), 0.2)
    self.currentAnimation = self.animations.idle
end

function enemy:drawCollider()
    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.rectangle('line', self.x, self.y - self.height/2, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 1)
end

function enemy:draw()
    self:drawCollider()
    if self.hit then
        love.graphics.setShader(shaders.hitFlashShader())
    end

    self.currentAnimation:draw(self.spriteSheet, self.x, self.y, nil, self.direction, 1, self.width/2, self.height/2)
    love.graphics.setShader()
end

function enemy:update(dt)
    self.currentAnimation:update(dt)

    self.timer = self.timer + dt
    if self.timer > self.hitDuration and self.hit then
        self.hit = false
    end
end

function enemy:takeDmg(value)
    self.timer = 0
    self.currentHealth = self.currentHealth - value
    print("i")
    if self.currentHealth <= 0 then
        self:destroy()
    end
end

function enemy:destroy()
    removeGameobject(self)
end

function enemy:beginContact(a, b, collision)
    for i, bulletInstance in ipairs(PlayerBullets) do
        if a == bulletInstance.physics.fixture or b == bulletInstance.physics.fixture then
            if a == self.physics.fixture or b == self.physics.fixture then
                if self.hit == false then
                    self.hit = true
                    bulletInstance.toBeRemoved = true
                    self:takeDmg(1)
                    break
                end
            end
        end
    end
end

function enemy:endContact(a, b, collision)
    
end

return enemy