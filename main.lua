sti = require('libraries/sti') --for tilemaps
anim8 = require 'libraries/anim8' --for animations
require 'player'
require 'bullet'

local worldScale = 1.5
local background = love.graphics.newImage('assets/sprites/Assets_area_1/Background/subway_BG.png')
screenWidth = 992
screenHeight = 544
allBullets = {}

local function setupGame()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setMode(screenWidth, screenHeight)
    Map = sti("maps/1.lua", {"box2d"})
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(beginContact, endContact)
    Map:box2d_init(World)
    --Map.layers.solid.visible = false
end

function love.load()
    setupGame()
    player:load() 

    love.window.setTitle('Run&Gun')
    love.keyboard.keysPressed = {}
end

function beginContact(a, b, collision)
    player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    player:endContact(a, b, collision)
end

function love.resize(w, h)
    -- ...
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'space' then
        player:jump()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
       printx = x
       printy = y
       local newBullet = bullet.new("e", player.x, player.y)
       table.insert(allBullets, newBullet)
    end
 end

function love.update(dt)
    World:update(dt)
    player:update(dt)
    for i, instance in ipairs(allBullets) do
        instance:update(dt)
    end

    love.keyboard.keysPressed = {}
end

function love.draw()
    love.graphics.draw(background, screenWidth/2, screenHeight/2, nil, 2, 2, background:getWidth()/2, background:getHeight()/2)
    
    Map:draw(0, 0, worldScale)
    love.graphics.push()
    love.graphics.scale(worldScale, worldScale)
    player:draw()
    for i, instance in ipairs(allBullets) do
        instance:draw()
    end
    love.graphics.pop()

    love.graphics.print(player.x, 10, 10)
end

