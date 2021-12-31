sti = require('libraries/sti')
anim8 = require 'libraries/anim8'
require 'player'

local background = love.graphics.newImage('assets/sprites/Assets_area_1/Background/subway_BG.png')
screenWidth = 992
screenHeight = 544

local function setupGame()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setMode(screenWidth, screenHeight)
    Map = sti("maps/1.lua", {"box2d"})
    World = love.physics.newWorld(0, 0)
    Map:box2d_init(World)
    --Map.layers.solid.visible = false
end

local function setupPlayer()
    player:load()
end

local function setupAnimations()
    player.animations = {}
    player.animations.idle = anim8.newAnimation(player.grid('1-6', 1), 0.1)
    player.animations.run = anim8.newAnimation(player.grid('1-5', 2), 0.1)
    player.animations.shooting = anim8.newAnimation(player.grid('3-4', 3), 0.1)
    player.currentAnim = player.animations.idle
end

function love.load()
    setupGame()
    setupPlayer()
    setupAnimations()

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

    if key == 'space' then
        --jump
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

local function blockPlayerOnBounds()
    local screenBounds = 50
    if player.x >= screenWidth - screenBounds then
        player.x = screenWidth - screenBounds
    elseif player.x <= screenBounds/4 then
        player.x = screenBounds/4
    end
end

local function playerMove(dt)
    local moving = false

    if love.keyboard.isDown("right") then
        player.direction = 1
        player.currentAnim = player.animations.run
        moving = true
        player.x = player.x + (player.speed * dt)
    end

    if love.keyboard.isDown("left") then
        player.direction = -1
        player.currentAnim = player.animations.run
        moving = true
        player.x = player.x - (player.speed * dt)
    end

    if moving == false then
        player.currentAnim = player.animations.idle
    end
end

function love.update(dt)
    player:update()
    playerMove(dt)
    blockPlayerOnBounds()
    love.keyboard.keysPressed = {}
    player.currentAnim:update(dt)
end

function love.draw()
    love.graphics.draw(background, screenWidth/2, screenHeight/2, nil, 2, 2, background:getWidth()/2, background:getHeight()/2)

    Map:draw(0, -125, 2)
    love.graphics.push()
    love.graphics.scale(2, 2)
    love.graphics.pop()

    player:draw()
    love.graphics.print(player.x, 10, 10)
end

