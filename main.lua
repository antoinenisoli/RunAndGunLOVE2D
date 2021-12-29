love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()
    -- init something here ...
    player = {}
    player.x = 250
    player.y = 250
    player.speed = 2
    player.sprite = love.graphics.newImage('assets/sprites/tile000.png')
    player.spriteSheet = love.graphics.newImage('assets/sprites/SpriteSheet_player.png')

    love.window.setTitle('Hello love2d!')
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    -- ...
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'right' then
        player.x = player.x + player.speed
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
    end

    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
    end

    if love.keyboard.isDown("up") then
        --
    end

    if love.keyboard.isDown("down") then
        --
    end

    love.keyboard.keysPressed = {}
end

function love.draw()
    -- draw your stuff here
    love.graphics.print('Welcome to the Love2d world!', 10, 10)
    love.graphics.draw(player.sprite, player.x, player.y)
end

