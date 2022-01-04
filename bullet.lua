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
    instance.speed = 200
    instance.direction = player.direction
    instance.timer = 0
    instance.lifetime = 10
    return instance
end

function bullet:draw()
    local s = 1.3
    love.graphics.draw(self.image, self.x, self.y, 0, s, s, self.width/2, self.height/2)
end

function bullet:destroy()
    for i, instance in ipairs(allBullets) do
        if instance == self then
            table.remove(allBullets, i)
        end
    end
end

function bullet:update(dt)
    self.x = self.x + (self.speed * self.direction) * dt
    self.timer = self.timer + dt
    if self.timer > self.lifetime then
        self:destroy()
    end

    local screenBounds = 50
    if self.x >= screenWidth - screenBounds or self.x <= screenBounds/4 then
        self:destroy()
    end
end