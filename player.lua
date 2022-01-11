local shaders = require 'shaders'
local anim8 = require 'libraries/anim8' --for animations
local bulletPlayer = require 'bulletPlayer'
local player = {}

function player:setupAnimations()
    self.sprite = love.graphics.newImage('assets/sprites/tile000.png')
    self.spriteSheet = love.graphics.newImage('assets/sprites/SpriteSheet_player.png')
    self.grid = anim8.newGrid( 45, 45, self.spriteSheet:getWidth(), self.spriteSheet:getHeight() )

    self.animations = {}
    self.animations.idle = anim8.newAnimation(self.grid('1-6', 1), 0.1)
    self.animations.jumping = anim8.newAnimation(self.grid('8-8', 2), 0.1)
    self.animations.run = anim8.newAnimation(self.grid('7-8', 1, '1-6', 2), 0.1)
    self.animations.death = anim8.newAnimation(self.grid('7-8', 6, '1-3', 7), 0.1, 'pauseAtEnd')

    self.animations.shootRun = anim8.newAnimation(self.grid('1-8', 4), 0.1)
    self.animations.shootRunUp = anim8.newAnimation(self.grid('1-8', 5), 0.1)

    self.animations.shootJumping = anim8.newAnimation(self.grid('1-2', 6), 0.1)
    self.animations.shootJumpingUp = anim8.newAnimation(self.grid('3-4', 6), 0.1)
    self.animations.shootJumpingDown = anim8.newAnimation(self.grid('5-6', 6), 0.1)

    self.animations.shootIdle = anim8.newAnimation(self.grid('3-4', 3), 0.1)
    self.animations.shootIdleUp = anim8.newAnimation(self.grid('5-6', 3), 0.1)
    self.animations.shootIdleDown = anim8.newAnimation(self.grid('5-6', 6), 0.1)

    self.currentAnim = self.animations.idle
end

function player:setupPhysics()
    self.x = screenWidth/2 - 400
    self.y = 200
    self.width = 15
    self.height = 25
    self.xVel = 0
    self.yVel = 0
    self.maxSpeed = 200
    self.acceleration = 4000
    self.friction = 3500
    self.gravity = 1500
    self.jumpForce = -350
    self.grounded = false;

    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
end

function player:setupHealth()
    self.dead = false
    self.hitTimer = 0
    self.hitDuration = 0.1
    self.maxHealth = 1
    self.currentHealth = self.maxHealth
    self.hit = false
end

function player:load()
    self.directionX = 1
    self.directionY = 0

    self.shootRate = 0.2
    self.shootTimer = self.shootRate
    self.isShooting = false

    self:setupPhysics()
    self:setupAnimations()
    self:setupHealth()

    self.shootPos = {}
    self.shootPos.x = self.x
    self.shootPos.y = self.y
end

function player:manageHit(dt)
    self.dead = self.currentHealth <= 0
    self.hitTimer = self.hitTimer + dt
    if self.hitTimer > self.hitDuration and self.hit then
        self.hit = false
    end
end

function player:manageDirections()
    if love.keyboard.isDown("up", "z") then
        self.directionY = -1
        self.shootPos.x = self.x
        self.shootPos.y = self.y - 25
    elseif love.keyboard.isDown("down", "s") then
        self.directionY = 1
        self.shootPos.x = self.x
        self.shootPos.y = self.y + 5
    else
        self.directionY = 0
    end
end

function player:move(dt)
    self.moving = false

    if love.keyboard.isDown("right", "d") then
        self.directionX = 1
        self.moving = true
        self.xVel = math.min(self.xVel + self.acceleration * dt, self.maxSpeed)
    elseif love.keyboard.isDown("left", "q") then
        self.directionX = -1
        self.moving = true
        self.xVel = math.max(self.xVel - self.acceleration * dt, -self.maxSpeed)
    else
        self:applyFriction(dt)
    end
end

function player:land(collision)
    self.currentGroundCollision = collision
    self.grounded = true
    self.yVel = 0
end

function player:beginContact(a, b, collision)
    if self.grounded == true then return end
    local nx, ny = collision:getNormal()
    if self.physics.fixture == a then
        if ny > 0 then
            self:land(collision)
        elseif ny < 0 then
            self.yVel = 0
        end
    elseif b == self.physics.fixture then
        if ny < 0 then
            self:land(collision)
        elseif ny > 0 then
            self.yVel = 0
        end
    end
end

function player:endContact(a, b, collision)
    if a == self.physics.fixture or b == self.physics.fixture then
        if self.currentGroundCollision == collision then
            self.grounded = false
        end
    end
end

function player:syncPhysics()
    self.x, self.y = self.physics.body:getPosition() 
    self.physics.body:setLinearVelocity(self.xVel, self.yVel)  

    local screenBounds = 50
    if self.x >= screenWidth - screenBounds then
        self.x = screenWidth - screenBounds
    elseif self.x <= screenBounds/4 then
        self.x = screenBounds/4
    end

    self.shootPos.x = self.x + (15 * self.directionX)
    self.shootPos.y = self.y - 5
end

function player:inAir(dt)
    if not self.grounded then
        self.yVel = self.yVel + self.gravity * dt
    end
end

function player:destroy()
    self.dead = true
    self:respawn()
end

function player:respawn()
    print("respawn");
    self.dead = false
    self.currentHealth = self.maxHealth
end

 function player:takeDmg(value)
    self.hitTimer = 0
    self.currentHealth = self.currentHealth - value
    if self.currentHealth <= 0 then
        self:destroy()
    end
end

function player:shoot()
    if self.dead then return end

    local newbulletPlayer = bulletPlayer.new("bullet", self.shootPos.x, self.shootPos.y, self.directionX, self.directionY)
    table.insert(GameObjects, newbulletPlayer)
    table.insert(PlayerBullets, newbulletPlayer)
end

function player:applyFriction(dt)
    if self.xVel > 0 then
        self.xVel = math.max(self.xVel - self.friction * dt, 0)
    elseif self.xVel < 0 then
        self.xVel = math.min(self.xVel + self.friction * dt, 0)
    end
end

function player:jump()
    if self.grounded then
        self.yVel = self.jumpForce
        self.grounded = false
    end
end

function player:drawGizmos()
    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.rectangle('line', self.x - self.width/2, self.y - self.height/2, self.width, self.height) --collider
    love.graphics.setColor(255, 255, 255, 1)

    love.graphics.circle('line', self.shootPos.x, self.shootPos.y, 5) --shoot pos
end

function player:shooting(dt)
    if love.mouse.isDown(1) then
		self.shootTimer = self.shootTimer + dt   
        self.isShooting = true     

        if self.shootTimer > self.shootRate then
            self.shootTimer = 0
            self:shoot()
        end
	else
        self.shootTimer = self.shootRate
        self.isShooting = false
    end
end

function player:manageAnimations(dt)
    if self.isShooting then
        if not self.grounded then
            if self.directionY == -1 then
                self.currentAnim = self.animations.shootJumpingUp
            elseif self.directionY == 1 then
                self.currentAnim = self.animations.shootJumpingDown
            else
                self.currentAnim = self.animations.shootJumping
            end
        else
            if self.directionY == -1 then
                if self.xVel ~= 0 then
                    self.currentAnim = self.animations.shootRunUp
                else
                    self.currentAnim = self.animations.shootIdleUp
                end
            elseif self.directionY == 1 then
                if self.xVel ~= 0 then
                    self.currentAnim = self.animations.shootIdleDown
                else
                    self.currentAnim = self.animations.shootIdleDown
                end
            else
                if self.xVel ~= 0 then
                    self.currentAnim = self.animations.shootRun
                else
                    self.currentAnim = self.animations.shootIdle
                end
            end
        end
    elseif not self.grounded then
        self.currentAnim = self.animations.jumping
    else
        if self.moving then
            self.currentAnim = self.animations.run
        else
            self.currentAnim = self.animations.idle
        end
    end
end

function player:update(dt)
    if self.dead and self.currentAnim ~= self.animations.death then
        self.currentAnim = self.animations.death
    end

    self:manageHit(dt)
    self:manageAnimations(dt)
    self.currentAnim:update(dt)
    self:syncPhysics()
    if self.dead then return end

    self:move(dt)
    self:inAir(dt)
    self:manageDirections()
    self:shooting(dt)
end

function player:draw()
    if self.hit and not self.dead then
        love.graphics.setShader(shaders.hitFlashShader(1,0,0))
    end

    self.currentAnim:draw(self.spriteSheet, self.x, self.y - self.height*1.25, nil, self.directionX, 1, self.height, 0)
    love.graphics.setShader()
    self:drawGizmos()
end

return player