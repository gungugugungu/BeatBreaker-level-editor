helperlib = {}

function aabb_collision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
           x2 < x1 + w1 and
           y1 < y2 + h2 and
           y2 < y1 + h1
end
helperlib.aabb_collision = aabb_collision

function distance_between(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end
helperlib.distance_between = distance_between

function move_towards(x1, y1, x2, y2, speed)
    local dx = x2 - x1
    local dy = y2 - y1
    local ax = math.abs(dx)
    local ay = math.abs(dy)

    if ax > ay then
        return x1 + math.sign(dx) * speed, y1 + dy * (speed / ax)
    else
        return x1 + dx * (speed / ay), y1 + math.sign(dy) * speed
    end
end
helperlib.move_towards = move_towards

function move_in_angle_optimized(x, y, angle, distance)
    angle = angle % 360
    local new_x = x + cos_cache[angle] * distance
    local new_y = y + sin_cache[angle] * distance
    return new_x, new_y
end
helperlib.move_in_angle_optimized = move_in_angle_optimized

function point_rect_collision(px, py, rx, ry, rw, rh)
    return px > rx and
        px < rx+rw and
           py > ry and
        py < ry+rh
end
helperlib.point_rect_collision = point_rect_collision

function point_rect_dir_collision(px, py, rx, ry, rw, rh)
    in_left = px > rx
    in_right = px < rx+rw
    in_top = py > ry
    in_bottom = py < ry+rh
    return in_left, in_right, in_top, in_bottom
end
helperlib.point_rect_dir_collision = point_rect_dir_collision

function min_max(n, min, max)
    if n < min then
        n = min
    end
    if n > max then
        n = max
    end
    return n
end
helperlib.min_max = min_max

function math.sign(x)
    return x > 0 and 1 or (x < 0 and -1 or 0)
end

function deepcopy(o, seen)
    seen = seen or {}
    if o == nil then return nil end
    if seen[o] then return seen[o] end

    local no
    if type(o) == 'table' then
        no = {}
        seen[o] = no

        for k, v in next, o, nil do
            no[deepcopy(k, seen)] = deepcopy(v, seen)
        end
        setmetatable(no, deepcopy(getmetatable(o), seen))
    else -- number, string, boolean, etc
        no = o
    end
    return no
end
helperlib.deepcopy = deepcopy

return helperlib