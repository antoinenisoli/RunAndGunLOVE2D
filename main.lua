love.graphics.setDefaultFilter('nearest', 'nearest')
local sti = require('libraries/sti') --for tilemaps
local player = require 'player'
local enemy = require 'enemy'
local Camera = require 'Camera'

local background = love.graphics.newImage('assets/sprites/Assets_area_1/Background/subway_BG.png')
screenWidth = 992
screenHeight = 544
GameObjects = {}
PlayerBullets = {}
EnemyBullets = {}
Enemies = {}

local function spawnEnemies()
    for i, spawner in ipairs(Map.layers.entities.objects) do
        if spawner.type == "enemy" then
            local newEnemy = enemy.new(spawner.x, spawner.y, spawner.properties.direction)
            table.insert(GameObjects, newEnemy)
            table.insert(Enemies, newEnemy)
        end
    end
end

local function setupMap()
    Map = sti("maps/1.lua", {"box2d"})
    mapWidth = Map.layers.ground.width * 16
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(beginContact, endContact)
    Map:box2d_init(World)
    Map.layers.solid.visible = false
    Map.layers.entities.visible = false
end

local function setupGame()
    setupMap()
    spawnEnemies()
end

function love.load()
    math.randomseed(os.time())
    setupGame()
    player:load() 
    for i, spawner in ipairs(Map.layers.entities.objects) do
        if spawner.type == "player" then
            player:spawn(spawner.properties.direction, spawner.x, spawner.y)
        end
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

    Camera:setPosition(player.x, player.y)
    love.keyboard.keysPressed = {}
end

function love.draw()
    love.graphics.draw(background, screenWidth/2, screenHeight/2, nil, 2, 2, background:getWidth()/2, background:getHeight()/2)
    Map:draw(-Camera.x, -Camera.y, Camera.scale)

    Camera:apply()
    player:draw()
    for i, instance in ipairs(GameObjects) do
        instance:draw()
    end

    Camera:clear()
    love.graphics.print(player.x, 10, 10)
end

