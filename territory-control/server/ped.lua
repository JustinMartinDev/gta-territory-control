Ped = {}
Ped.__index = Ped

function Ped:fromSqlRow(pedSqlRow)
    local ped = {}             -- our new object
    setmetatable(ped,Ped)  -- make Ped handle lookup

    ped.id = pedSqlRow.id
    ped.name = pedSqlRow.name
    ped.model = pedSqlRow.model
    ped.coordinate = json.decode(pedSqlRow.coordinate)
    ped.heading = tonumber(pedSqlRow.heading)

    return ped
end

local peds = {}


MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM `ped`', {}, function(result)
        -- Send each row to the client
        for _, row in pairs(result) do
            local ped = Ped:fromSqlRow(row)
            table.insert(peds, ped)
        end
    end)
end)


local function triggerRequestPedsEvent()
    TriggerClientEvent("Ped:OnReceivePeds", source, peds)
end

RegisterNetEvent("Ped:RequestPeds")
AddEventHandler("Ped:RequestPeds", triggerRequestPedsEvent)