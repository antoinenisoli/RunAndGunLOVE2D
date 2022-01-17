local Camera = {
    x = 0,
    y = 0,
    offsetX = 50,
    offsetY = -300,
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
    self.x = (x + self.offsetX) - (screenWidth / 2) / self.scale
    self.y = y + self.offsetY
    local currentPosX = self.x + (screenWidth / 2)

    if self.x < 0 then
        self.x = 0
    elseif currentPosX > mapWidth then
        self.x = mapWidth - (screenWidth / 2)
    end

    local currentPosY = self.y + (screenHeight / 2)
    if self.y < 0 then
        self.y = 0
    elseif currentPosY > mapHeight then
        self.y = mapHeight - (screenHeight / 2)
    end

    
end

return Camera
