player = {}

function player:load()
    self.direction = 1
    self.scale = 1.5
    self.speed = 200
    self.sprite = love.graphics.newImage('assets/sprites/tile000.png')
    self.spriteSheet = love.graphics.newImage('assets/sprites/SpriteSheet_player.png')
    self.grid = anim8.newGrid( 45, 45, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )

    self.x = screenWidth/2 - 400
    self.y = screenHeight/2 + 50
    self.width = 25
    self.height = 45
    self.xVel = 0
    self.yVel = 0
    self.maxSpeed = 200
    self.acceleration = 4000
    self.friction = 3500

    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x + self.width/2, self.y + self.height/2, "dynamic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
end

function player:update()
    player:syncPhysics()
end

function player:syncPhysics()
    self.x, self.y = self.physics.body:getPosition()  
    self.physics.body:setLinearVelocity(self.xVel, self.yVel)   
end

function player:draw()
    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.rectangle('line', self.x + self.width/2, self.y + self.height/2, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 1)
    player.currentAnim:draw(player.spriteSheet, player.x + player.sprite:getWidth()/2, player.y, nil, player.direction * player.scale, player.scale, player.sprite:getHeight()/2, 0)
end