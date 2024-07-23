Marker = {}
Marker.__index = Marker

function Marker:fromSqlRow(markerSqlRow)
    local marker = {}             -- our new object
    setmetatable(marker,Marker)  -- make Marker handle lookup

    marker.id = markerSqlRow.id
    marker.name = markerSqlRow.name
    marker.coordinate = json.decode(markerSqlRow.coordinate)
    marker.inputLabel = markerSqlRow.inputLabel
    marker.radius = markerSqlRow.radius;

    marker.actionKey = markerSqlRow.actionKey
    marker.actionParams = json.decode(markerSqlRow.actionParams)

    return marker
end

local markers = {}


MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM `marker`', {}, function(result)
        -- Send each row to the client
        for _, row in pairs(result) do
            local marker = Marker:fromSqlRow(row)
            table.insert(markers, marker)
        end
    end)
end)


local function triggerRequestMarkersEvent()
    TriggerClientEvent("Marker:OnReceiveMarkers", source, markers)
end

RegisterNetEvent("Marker:RequestMarkers")
AddEventHandler("Marker:RequestMarkers", triggerRequestMarkersEvent)