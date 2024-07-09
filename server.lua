RegisterServerEvent("<resourceName>.getIsAllowed")
AddEventHandler("<resourceName>.getIsAllowed", function(source)
    print(source)
    if IsPlayerAceAllowed(source, "the.permission.name.you.want") then
        TriggerClientEvent("<resourceName>.returnIsAllowed", source, true)
    else
        TriggerClientEvent("<resourceName>.returnIsAllowed", source, false)
    end
end)

local eventPrefix = '__PolyZone__:'

function triggerZoneEvent(eventName, ...)
  TriggerClientEvent(eventPrefix .. eventName, -1, ...)
end

RegisterNetEvent("PolyZone:TriggerZoneEvent")
AddEventHandler("PolyZone:TriggerZoneEvent", triggerZoneEvent)

exports("TriggerZoneEvent", triggerZoneEvent)