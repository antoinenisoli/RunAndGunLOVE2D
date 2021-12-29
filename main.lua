love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()
    anim8 = require 'libraries/anim8'
    
    player = {}
    player.x = 250
    player.y = 250
    player.speed = 2
    player.sprite = love.graphics.newImage('assets/sprites/tile000.png')
    player.spriteSheet = love.graphics.newImage('assets/sprites/SpriteSheet_player.png')
    player.grid = anim8.newGrid( 45, 45, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )

    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('1-4', 1), 0.2)
    player.animations.idle = anim8.newAnimation(player.grid('1-6', 1), 0.2)

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
    player.animations.idle:update(dt)
end

function love.draw()
    -- draw your stuff here
    love.graphics.print('Welcome to the Love2d world!', 10, 10)
    --love.graphics.draw(player.sprite, player.x, player.y)
    player.animations.idle:draw(player.spriteSheet, player.x, player.y, nil, 1)
end

