require 'bullet'
player = {}

function player:setupAnimations()
    self.sprite = love.graphics.newImage('assets/sprites/tile000.png')
    self.spriteSheet = love.graphics.newImage('assets/sprites/SpriteSheet_player.png')
    self.grid = anim8.newGrid( 45, 45, self.spriteSheet:getWidth(), self.spriteSheet:getHeight() )

    self.animations = {}
    self.animations.idle = anim8.newAnimation(self.grid('1-6', 1), 0.1)
    self.animations.run = anim8.newAnimation(self.grid('1-5', 2), 0.1)
    self.animations.shooting = anim8.newAnimation(self.grid('3-4', 3), 0.1)
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

function player:load()
    self.directionX = 1
    self.directionY = 0

    self:setupPhysics()
    self:setupAnimations()
end

function player:update(dt)
    self.currentAnim:update(dt)
    self:syncPhysics()
    self:move(dt)
    self:applyGravity(dt)
    self:manageDirections()
end

function player:manageDirections()
    if love.keyboard.isDown("up", "z") then
        self.directionY = -1
        --self.currentAnim = self.animations.run
    elseif love.keyboard.isDown("down", "s") then
        self.directionY = 1
        --self.currentAnim = self.animations.run
    else
        self.directionY = 0
    end
end

function player:move(dt)
    local moving = false

    if love.keyboard.isDown("right", "d") then
        self.directionX = 1
        self.currentAnim = self.animations.run
        moving = true
        self.xVel = math.min(self.xVel + self.acceleration * dt, self.maxSpeed)
    elseif love.keyboard.isDown("left", "q") then
        self.directionX = -1
        self.currentAnim = self.animations.run
        moving = true
        self.xVel = math.max(self.xVel - self.acceleration * dt, -self.maxSpeed)
    else
        self:applyFriction(dt)
    end

    if moving == false then
        self.currentAnim = self.animations.idle
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
end

function player:applyGravity(dt)
    if not self.grounded then
        self.yVel = self.yVel + self.gravity * dt
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
       player:shoot()
    end
 end

function player:shoot()
    local newBullet = bullet.new("e", player.x, player.y)
    table.insert(GameObjects, newBullet)
    table.insert(PlayerBullets, newBullet)
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

function player:draw()
    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.rectangle('line', self.x - self.width/2, self.y - self.height/2, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 1)

    self.currentAnim:draw(self.spriteSheet, self.x, self.y - self.height*1.25, nil, self.directionX, 1, self.sprite:getHeight()/2, 0)
end