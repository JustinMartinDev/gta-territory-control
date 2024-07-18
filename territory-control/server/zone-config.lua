-- This file only contain method to return territories list
-- You have to update this file to return data from you data

Zone = {}
Zone.__index = Zone

function Zone:fromSqlRow(zoneSqlRow)
    local zone = {}             -- our new object
    setmetatable(zone,Zone)  -- make Account handle lookup

    zone.id = zoneSqlRow.id
    zone.name = zoneSqlRow.name
    zone.owner = zoneSqlRow.owner
    zone.colors = json.decode(zoneSqlRow.colors)

    zone.coordinates = {}

    for _, coord in pairs(json.decode(zoneSqlRow.coordinates)) do
        table.insert(zone.coordinates, vector2(coord.x, coord.y))
    end

    return zone
end

local zones = {}


MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM `zone`', {}, function(result)
        -- Send each row to the client
        for _, row in pairs(result) do
            -- print(exports.utils:dump(rows))
            local zone = Zone:fromSqlRow(row)
            table.insert(zones, zone)
        end
    end)
end)


local function triggerRequestZonesEvent()
    TriggerClientEvent("ZoneConfig:OnReceiveZones", source, zones)
end

RegisterNetEvent("ZoneConfig:RequestZones")
AddEventHandler("ZoneConfig:RequestZones", triggerRequestZonesEvent)