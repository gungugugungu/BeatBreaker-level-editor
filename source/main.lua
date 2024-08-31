--- HI!!!!!!!!!!!!
--- I'm truly wondering what you are doing here.
--- You might be wondering what in the holy diddly dick is going
--- on in this piece of junk. 
--- Pretty self explanatory; I made this in 2 days without any
--- experience with love2d in the past month.
--- That might seem as if it wasn't that big of a deal, but
--- instead of not using love2d, I did not just *not use* love2d
--- but I also used the Playdate SDK for at least 4 hours a day.
--- 
--- I hope that explains this mess of a codebase, I swear the game
--- is a lot better.
--- 
--- Also,
--- The song included in the repo is "Damage" by F.O.O.L., my
--- favourite level in Beat Saber. Hope you like it, it's the best I had.

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
    song:play()
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
stopped = true
edit_menu_open = false
font = love.graphics.newFont("font.ttf", 12, "none")
currently_editing_str = nil
possible_letters = {}
str_start = "0"
str_end = "0"
str_start_x = "200"
str_start_y = "120"
str_end_x = "200"
str_end_y = "120"
str_angle = "n"
song = love.audio.newSource("song.wav", "static")

restart()

function love.load()
    scaling = 2
    start = love.timer.getTime()
    love.window.setMode(512*scaling, 256*scaling)
    love.window.setTitle("BeatBreaker level editor")

    love.graphics.setDefaultFilter("nearest", "nearest", 1)
end

function love.draw()
    -- pre-update bullshitery
    local mx, my = love.mouse.getPosition()
    if stopped == true then
        restart()
        song:stop()
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

    -- stop button
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

    -- elapsed time
    set1bitColor(black)
    local text = love.graphics.newText(font, math.floor(getElapsedTime()*10)/10)
    love.graphics.draw(text, 44, 243, 0, 1, 1)

    -- edit menu
    if edit_menu_open == true then
        set1bitColor(white)
        love.graphics.rectangle("fill", 160, 104, 192, 48)
        set1bitColor(black)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 160, 104, 192, 48)

        love.graphics.rectangle("fill", 162, 106, 32, 12)
        love.graphics.rectangle("fill", 195, 106, 32, 12)
        love.graphics.rectangle("fill", 228, 106, 24, 12)
        love.graphics.rectangle("fill", 253, 106, 24, 12)
        love.graphics.rectangle("fill", 278, 106, 24, 12)
        love.graphics.rectangle("fill", 303, 106, 24, 12)
        love.graphics.rectangle("fill", 162, 128, 12, 12)
        love.graphics.rectangle("fill", 336, 128, 12, 12)
            set1bitColor(white)
            love.graphics.rectangle("fill", 341, 130, 2, 8)
            love.graphics.rectangle("fill", 338, 133, 8, 2)

        set1bitColor(black)
        text = love.graphics.newText(font, "Start time")
        love.graphics.draw(text, 162, 120, 0, 0.5, 0.5)
        text = love.graphics.newText(font, "End time")
        love.graphics.draw(text, 195, 120, 0, 0.5, 0.5)
        text = love.graphics.newText(font, "Start X")
        love.graphics.draw(text, 228, 120, 0, 0.5, 0.5)
        text = love.graphics.newText(font, "Start Y")
        love.graphics.draw(text, 253, 120, 0, 0.5, 0.5)
        text = love.graphics.newText(font, "End X")
        love.graphics.draw(text, 278, 120, 0, 0.5, 0.5)
        text = love.graphics.newText(font, "End Y")
        love.graphics.draw(text, 303, 120, 0, 0.5, 0.5)
        text = love.graphics.newText(font, "Angle: l, r, u, d, n")
        love.graphics.draw(text, 175, 132, 0, 0.5, 0.5)

        set1bitColor(white)
        text = love.graphics.newText(font, str_start)
        love.graphics.draw(text, 164, 108, 0, 0.75, 0.75)
        text = love.graphics.newText(font, str_end)
        love.graphics.draw(text, 197, 108, 0, 0.75, 0.75)
        text = love.graphics.newText(font, str_start_x)
        love.graphics.draw(text, 230, 108, 0, 0.75, 0.75)
        text = love.graphics.newText(font, str_start_y)
        love.graphics.draw(text, 255, 108, 0, 0.75, 0.75)
        text = love.graphics.newText(font, str_end_x)
        love.graphics.draw(text, 280, 108, 0, 0.75, 0.75)
        text = love.graphics.newText(font, str_end_y)
        love.graphics.draw(text, 305, 108, 0, 0.75, 0.75)
        text = love.graphics.newText(font, str_angle)
        love.graphics.draw(text, 164, 130, 0, 0.75, 0.75)
    end
end

function love.mousepressed( x, y, button, istouch, presses )
    if button == 1 then
        local mx, my = love.mouse.getPosition()
        local mx, my = mx/scaling, my/scaling

        -- play button
        if edit_menu_open == false then
            if (2 < mx and mx < 14) and (242 < my and my < 254) then
                stopped = false
                restart()
            end

            -- stop button
            if (16 < mx and mx < 28) and (242 < my and my < 254) then
                stopped = true
            end

            -- add button
            if (30 < mx and mx < 42) and (242 < my and my < 254) then
                edit_menu_open = true
            end
        else
            -- leaving add menu
            if (160 > mx or mx > 352) or (104 > my or my > 152) then
                edit_menu_open = false
            end

            if (162 < mx and mx < 194) and (106 < my and my < 118) then
                currently_editing_str = "start"
                possible_letters = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."}
            elseif (195 < mx and mx < 227) and (106 < my and my < 118) then
                currently_editing_str = "end"
                possible_letters = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."}
            elseif (228 < mx and mx < 252) and (106 < my and my < 118) then
                currently_editing_str = "startx"
                possible_letters = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
            elseif (253 < mx and mx < 277) and (106 < my and my < 118) then
                currently_editing_str = "starty"
                possible_letters = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
            elseif (278 < mx and mx < 302) and (106 < my and my < 118) then
                currently_editing_str = "endx"
                possible_letters = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
            elseif (303 < mx and mx < 327) and (106 < my and my < 118) then
                currently_editing_str = "endy"
                possible_letters = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
            elseif (162 < mx and mx < 174) and (128 < my and my < 140) then
                currently_editing_str = "angle"
                possible_letters = {"l", "r", "u", "d", "n"}
            end

            -- add to list
            if (336 < mx and mx < 348) and (128 < my and my < 140) then
                local angl = angle_types.none
                if str_angle == "l" then
                    angl = angle_types.left
                end
                if str_angle == "r" then
                    angl = angle_types.right
                end
                if str_angle == "u" then
                    angl = angle_types.up
                end
                if str_angle == "d" then
                    angl = angle_types.down
                end
                local fresh_block = block.create(tonumber(str_start_x), tonumber(str_start_y), tonumber(str_end_x), tonumber(str_end_y), tonumber(str_start), tonumber(str_end), angl)
                print(fresh_block["start_x"])
                print(fresh_block["start_y"])
                print(fresh_block["target_x"])
                print(fresh_block["target_y"])
                print(fresh_block["start_time"])
                print(fresh_block["end_time"])
                print(fresh_block["angle"])
                table.insert(start_blocks, fresh_block)
                edit_menu_open = false
            end
        end
    end
end

function love.keypressed(key, scancode, isrepeat)
    if helperlib.table_contains(possible_letters, key) then
        if currently_editing_str == "start" then
            str_start = str_start .. key
        end
        if currently_editing_str == "end" then
            str_end = str_end .. key
        end
        if currently_editing_str == "startx" then
            str_start_x = str_start_x .. key
        end
        if currently_editing_str == "starty" then
            str_start_y = str_start_y .. key
        end
        if currently_editing_str == "endx" then
            str_end_x = str_end_x .. key
        end
        if currently_editing_str == "endy" then
            str_end_y = str_end_y .. key
        end
        if currently_editing_str == "angle" then
            str_angle = str_angle .. key
        end
    end
    if key == "backspace" then
        if currently_editing_str == "start" then
            str_start = str_start:sub(1, -2)
        end
        if currently_editing_str == "end" then
            str_end = str_end:sub(1, -2)
        end
        if currently_editing_str == "startx" then
            str_start_x = str_start_x:sub(1, -2)
        end
        if currently_editing_str == "starty" then
            str_start_y = str_start_y:sub(1, -2)
        end
        if currently_editing_str == "endx" then
            str_end_x = str_end_x:sub(1, -2)
        end
        if currently_editing_str == "endy" then
            str_end_y = str_end_y:sub(1, -2)
        end
        if currently_editing_str == "angle" then
            str_angle = str_angle:sub(1, -2)
        end
    end
end