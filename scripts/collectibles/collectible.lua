local anim8 = require 'libraries/anim8' --for animations
local collectible = {}
collectible.__index = collectible

function collectible.new(x, y, width, height)
    local instance = setmetatable({}, collectible)
    instance.x = x
    instance.y = y

    instance.triggerWidth = width
    instance.triggerHeight = height

    instance:setupGraphics()
    instance:setupPhysics()
    return instance
end

function collectible:setupPhysics()
    self.xVel = 0
    self.yVel = 0
    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.triggerWidth, self.triggerHeight)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setSensor(true)
end

function collectible:setupGraphics()
    self.spriteSheet = love.graphics.newImage('assets/sprites/tileset_icons.png')
    self.grid = anim8.newGrid(16, 16, self.spriteSheet:getWidth(), self.spriteSheet:getHeight() )
    self.width = 16
    self.height = 16
    local frames = self.grid('1-4', 1)
    self.sprite = frames[2]
end

function collectible:drawCollider()
    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.rectangle('line', self.x - self.width/2, self.y - self.height/2, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 1)
end

function collectible:beginContact(a, b, collision)
    if self.physics.fixture == a or b == self.physics.fixture then
        return true
    end
end

function collectible:endContact(a, b, collision)
    
end

function collectible:update(dt)
    
end

function collectible:draw()
    self:drawCollider()
    love.graphics.draw(self.spriteSheet, self.sprite, self.x, self.y, nil, 1, 1, self.width/2, self.height/2)
end

return collectible