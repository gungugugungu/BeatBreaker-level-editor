helperlib = require "helperlib"

white = "white"
black = "black"

---- BLOCK TYPES ----
angle_types = {}
angle_types.none = 0
angle_types.up = 1
angle_types.right = 2
angle_types.down = 3
angle_types.left = 4

---- FUNCTIONS ----
function set1bitColor(color)
    if color == "white" then
        love.graphics.setColor(0.8431372549019608, 0.8313725490196079, 0.8)
    else
        love.graphics.setColor(0.19607843137254902, 0.1843137254901961, 0.1607843137254902)
    end
end

function getElapsedTime()
    return love.timer.getTime()-start
end

function restart()
    start = love.timer.getTime()
    blocks = helperlib.deepcopy(start_blocks)
end

block = {}
function block.create(start_x, start_y, target_x, target_y, start_time, end_time, angle)
    return {x=start_x, y=start_y, start_x=start_x, start_y=start_y, target_x=target_x, target_y=target_y, timer=0, start_time=start_time, end_time=end_time, angle=angle}
end
function block.draw(b)
    set1bitColor(white)
    love.graphics.setLineWidth(1)
    love.graphics.line(b["x"], b["y"], b["target_x"], b["target_y"])

    set1bitColor(white)
    love.graphics.rectangle("fill", b["x"]-16, b["y"]-16, 32, 32)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", b["target_x"]-16, b["target_y"]-16, 32, 32)
    if b["angle"] == angle_types.up then
        set1bitColor(black)
        love.graphics.polygon("fill", b["x"]-12, b["y"]-12, b["x"], b["y"]-6, b["x"]+12, b["y"]-12)
    end
    if b["angle"] == angle_types.down then
        set1bitColor(black)
        love.graphics.polygon("fill", b["x"]-12, b["y"]+12, b["x"], b["y"]+6, b["x"]+12, b["y"]+12)
    end
    if b["angle"] == angle_types.left then
        set1bitColor(black)
        love.graphics.polygon("fill", b["x"]-12, b["y"]-12, b["x"]-6, b["y"], b["x"]-12, b["y"]+12)
    end
    if b["angle"] == angle_types.right then
        set1bitColor(black)
        love.graphics.polygon("fill", b["x"]+12, b["y"]-12, b["x"]+6, b["y"], b["x"]+12, b["y"]+12)
    end
end
function block.update(b)
    local elapsed = getElapsedTime()
    if elapsed > b["start_time"] and elapsed < b["end_time"] then
        b["x"], b["y"] = helperlib.move_towards(b["x"], b["y"], b["target_x"], b["target_y"], helperlib.distance_between(b["start_x"], b["start_y"], b["target_x"], b["target_y"])/((b["end_time"]-b["start_time"])*love.timer.getFPS()))
        block.draw(b)
    end
end

---- VARIABLES ----
blocks = {}
start_blocks = {}
table.insert(start_blocks, block.create(200, 120, 32, 32, 2, 4, angle_types.right))
restart()
stopped = false

function love.load()
    scaling = 2
    start = love.timer.getTime()
    love.window.setMode(512*scaling, 256*scaling)
    love.window.setTitle("BeatBreaker level editor")
end

function love.draw()
    -- pre-update bullshitery
    local mx, my = love.mouse.getPosition()
    if stopped == true then
        restart()
    end

    love.graphics.scale(scaling, scaling)
    love.graphics.clear(0.19607843137254902, 0.1843137254901961, 0.1607843137254902)

    -- drawing blocks
    for _, b in ipairs(blocks) do
        block.update(b)
    end

    -- UI
    set1bitColor(white)
    love.graphics.rectangle("fill", 0, 240, 512, 16)
    love.graphics.rectangle("fill", 400, 0, 112, 256)

    -- play button
    set1bitColor(black)
    love.graphics.rectangle("fill", 2, 242, 12, 12)
    set1bitColor(white)
    love.graphics.polygon("fill", 4, 243, 4, 252, 12, 248)

    -- stop
    set1bitColor(black)
    love.graphics.rectangle("fill", 16, 242, 12, 12)
    set1bitColor(white)
    love.graphics.rectangle("fill", 19, 244, 2, 8)
    love.graphics.rectangle("fill", 23, 244, 2, 8)

    -- add button
    set1bitColor(black)
    love.graphics.rectangle("fill", 30, 242, 12, 12)
    set1bitColor(white)
    love.graphics.rectangle("fill", 35, 244, 2, 8)
    love.graphics.rectangle("fill", 32, 247, 8, 2)
end

function love.mousepressed( x, y, button, istouch, presses )
    if button == 1 then
        local mx, my = love.mouse.getPosition()
        local mx, my = mx/scaling, my/scaling
        if (2 < mx and mx < 14) and (242 < my and my < 254) then
            stopped = false
            restart()
        end
        if (16 < mx and mx < 28) and (242 < my and my < 254) then
            stopped = true
        end
    end
end