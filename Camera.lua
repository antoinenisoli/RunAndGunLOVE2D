local Camera = {
    x = 0,
    y = 0,
    offsetX = 0,
    offsetY = -350,
    scale = 1.5,
}

function Camera:apply()
    love.graphics.push()
    love.graphics.scale(self.scale, self.scale)
    love.graphics.translate(-self.x, -self.y)
end

function Camera:clear()
    love.graphics.pop()
end

function Camera:setPosition(x, y)
    self.x = x - (love.graphics.getWidth() / 2) / self.scale
    self.y = y
    local rs = self.x + love.graphics.getWidth() / 2

    if self.x < 0 then
        self.x = 0
    elseif rs > mapWidth then
        self.x = mapWidth - love.graphics.getWidth() / 2
    end

    self.x = self.x + self.offsetX
    self.y = self.y + self.offsetY
end

return Camera
