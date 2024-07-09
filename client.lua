local spawnPos = vector3(686.245, 577.950, 130.461)

AddEventHandler('onClientGameTypeStart', function()
    exports.spawnmanager:setAutoSpawnCallback(function()
        exports.spawnmanager:spawnPlayer({
            x = spawnPos.x,
            y = spawnPos.y,
            z = spawnPos.z,
            model = 'a_m_m_skater_01'
        }, function()
            TriggerEvent('chat:addMessage', {
                args = { 'Welcome to the party!~' }
            })
        end)
    end)

    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
end)

-- Function to calculate the points of the hexagon
local function calculateHexagon(center, size)
    local hexagonPoints = {}

    local angle = math.pi / 3 -- 60 degrees in radians
    for i = 0, 5 do
        local theta = i * angle
        local x = center.x + size * math.cos(theta)
        local y = center.y + size * math.sin(theta)
        table.insert(hexagonPoints, vector2(x, y))
    end

    return hexagonPoints
end

-- Function to draw the hexagon
local function drawHexagon(points)
    for i = 1, #points do
        local nextIndex = i % #points + 1
        print(points[i])
        DrawLine(points[i].x, points[i].y, points[i].z, points[nextIndex].x, points[nextIndex].y, points[nextIndex].z, 255, 0, 0, 255)
        DrawRect(points[i].x, points[i].y, 20, 20, 0, 255, 0, 255)
    end
end

local function movePlayerToFirstLine(points)
    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, points[1].x, points[1].y, points[1].z, false, false, false, true)
end

local random = math.random
local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end


-- Let's work on it

RegisterCommand('setup-t', function(source, args)
    -- Get player position
    local playerPed = PlayerPedId() -- get the local player ped
    local center = GetEntityCoords(playerPed) -- get the position of the local player ped

    local hexagonPoints = calculateHexagon(center, 50)

    local zone_uuid = uuid()

    PolyZone:Create(
     hexagonPoints, {
        name = zone_uuid,
        minZ = center.z - 5,
        maxZ = center.z + 30,
        debugPoly = true
      }
    )

    print("Generated zone with uuid: ", zone_uuid);

    -- calculateHexagon(center, 10.0)

    -- drawHexagon(hexagonPoints)

    -- movePlayerToFirstLine(hexagonPoints)

    -- Create a foxhole like config arround player
        -- player is center of hexagone

end, false)