require 'shaders'
require 'bulletEnemy'
enemy = {}
enemy.__index = enemy

function enemy.new(x, y, direction)
    local instance = setmetatable({}, enemy)
    instance:setupAnimations()
    instance.x = x
    instance.y = y - instance.height/2
    instance.direction = direction

    instance.hitTimer = 0
    instance.hitDuration = 0.1
    instance.maxHealth = 3
    instance.currentHealth = instance.maxHealth
    instance.hit = false

    instance.shootTimer = 0
    instance.shootRate = math.random(1,3) + math.random()

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
    love.graphics.rectangle('line', self.x - self.width/2, self.y - self.height/2, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 1)
end

function enemy:draw()
    self:drawCollider()
    if self.hit then
        love.graphics.setShader(shaders.hitFlashShader())
    end

    self.currentAnimation:draw(self.spriteSheet, self.x, self.y - self.height/2, nil, self.direction, 1, self.height/2, 0)
    love.graphics.setShader()
end

function enemy:manageHit(dt)
    self.hitTimer = self.hitTimer + dt
    if self.hitTimer > self.hitDuration and self.hit then
        self.hit = false
    end
end

function enemy:shoot()
    self.direction = self.direction * -1
    local newbulletEnemy = bulletEnemy.new("bullet", self.x, self.y, self.direction)
    table.insert(GameObjects, newbulletEnemy)
    table.insert(EnemyBullets, newbulletEnemy)
end

function enemy:update(dt)
    self.currentAnimation:update(dt)
    self:manageHit(dt)

    self.shootTimer = self.shootTimer + dt
    if self.shootTimer > self.shootRate then
        self.shootTimer = 0
        self:shoot()
    end
end

function enemy:takeDmg(value)
    self.hitTimer = 0
    self.currentHealth = self.currentHealth - value
    if self.currentHealth <= 0 then
        self:destroy()
    end
end

function enemy:destroy()
    for i, instance in ipairs(Enemies) do
        if instance == self then
            table.remove(Enemies, i)
        end
    end

    removeGameobject(self)
end

function enemy:beginContact(a, b, collision)
    
end

function enemy:endContact(a, b, collision)
    
end

return enemy