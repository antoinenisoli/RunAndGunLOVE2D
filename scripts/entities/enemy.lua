local bulletEnemy = require 'scripts/bullets/bulletEnemy'
local anim8 = require 'libraries/anim8' --for animations
local entity = require 'scripts/entities/entity'
local enemy = {}
enemy.__index = enemy
setmetatable(enemy, entity)

function enemy.new(x, y, direction)
    local instance = setmetatable({}, enemy)
    instance:setupAnimations()
    instance.x = x
    instance.y = y - instance.height/2
    instance.direction = direction

    instance.shootTimer = 0
    instance.shootRate = math.random(1,3) + math.random()

    instance:setupHealth()
    instance:setupPhysics()
    return instance
end

function enemy:setupAnimations()
    self.spriteSheet = love.graphics.newImage('assets/sprites/Characters/Enemies/ARMob.png')
    self.width = 16
    self.height = 38
    self.grid = anim8.newGrid(32, 38, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
    self.animations = {}
    self.animations.idle = anim8.newAnimation(self.grid('1-3', 1), 0.2)
    self.currentAnimation = self.animations.idle
end

function enemy:shoot()
    --soundManager.shoot(0.3)
    self.direction = self.direction * -1
    local newbulletEnemy = bulletEnemy.new("bullet", self.x, self.y, self.direction, 0)
    table.insert(GameObjects, newbulletEnemy)
    table.insert(EnemyBullets, newbulletEnemy)
end

function enemy:update(dt)
    self.currentAnimation:update(dt)
    self:syncPhysics()
    self:manageHit(dt)

    self.shootTimer = self.shootTimer + dt
    if self.shootTimer > self.shootRate then
        self.shootTimer = 0
        self:shoot()
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

return enemy