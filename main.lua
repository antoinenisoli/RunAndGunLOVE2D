local sti = require('libraries/sti') --for tilemaps
anim8 = require 'libraries/anim8' --for animations
require 'player'
require 'enemy'

local worldScale = 1.5
local background = love.graphics.newImage('assets/sprites/Assets_area_1/Background/subway_BG.png')
screenWidth = 992
screenHeight = 544
GameObjects = {}
PlayerBullets = {}
EnemyBullets = {}
Enemies = {}
playerSpawner = {}

local function spawnEnemies()
    for i, spawner in ipairs(Map.layers.enemies.objects) do
        if spawner.properties.enemySpawner then
            local dir = -1
            if math.random(0,100) > 50 then
                dir = 1
            end

            local newEnemy = enemy.new(spawner.x, spawner.y, dir)
            table.insert(GameObjects, newEnemy)
            table.insert(Enemies, newEnemy)
        end
    end
end

local function setupGame()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setMode(screenWidth, screenHeight)
    Map = sti("maps/1.lua", {"box2d"})
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(beginContact, endContact)
    Map:box2d_init(World)
    --Map.layers.solid.visible = false
    spawnEnemies()
end

function love.load()
    math.randomseed(os.time())
    setupGame()
    player:load() 
    for i, spawner in ipairs(Map.layers.playerSpawner.objects) do
        playerSpawner.x = spawner.x
        playerSpawner.y = spawner.y
        player.physics.body:setPosition(spawner.x, spawner.y)
    end

    love.window.setTitle('Run&Gun')
    love.keyboard.keysPressed = {}
end

function love.conf(t)
	t.console = true
end

function beginContact(a, b, collision)
    for i, instance in ipairs(GameObjects) do
        if instance:beginContact(a, b, collision) then return end
    end

    player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    player:endContact(a, b, collision)
    for i, instance in ipairs(GameObjects) do
        instance:beginContact(a, b, collision)
    end
end

function removeGameobject(gameObject)
    for i, instance in ipairs(GameObjects) do
        if instance == gameObject then
            table.remove(GameObjects, i)
        end
    end
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

function love.update(dt)
    World:update(dt)
    player:update(dt)
    for i, instance in ipairs(GameObjects) do
        instance:update(dt)
    end

    love.keyboard.keysPressed = {}
end

function love.draw()
    love.graphics.push()
    love.graphics.draw(background, screenWidth/2, screenHeight/2, nil, 2, 2, background:getWidth()/2, background:getHeight()/2)
    
    Map:draw(0, 0, worldScale)
    love.graphics.scale(worldScale, worldScale)
    player:draw()
    for i, instance in ipairs(GameObjects) do
        instance:draw()
    end

    love.graphics.pop()

    love.graphics.print(player.x, 10, 10)
end

