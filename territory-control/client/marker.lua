function getPedMarkersLists(markers, playerCoord)
  local markersToDisplay = {}
  local markersToInteract = {}

  for _, marker in ipairs(markers) do
    -- calc distance between marker and players
    local distance = #(playerCoord - vector3(marker.coordinate.x, marker.coordinate.y, marker.coordinate.z))

    table.insert(markersToDisplay, marker)

    if distance <= marker.radius then
      table.insert(markersToInteract, marker)
    end
  end

  return { markersToDisplay, markersToInteract };
end

-- Function to spawn a ped
function createAllMarkers(markers)
  local playerPed = GetPlayerPed(-1);
  
  Citizen.CreateThread(function ()
    while true do
      Citizen.Wait(0)

      local playerCoord = GetEntityCoords(playerPed)

      local markersToDisplay, markersToInteract = table.unpack(getPedMarkersLists(markers, playerCoord))

      for _, marker in ipairs(markersToDisplay) do
        local floatingRadius = exports.utils:tofloat(marker.radius);

        DrawMarker(1, marker.coordinate.x, marker.coordinate.y, marker.coordinate.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, floatingRadius * 2, floatingRadius * 2, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
      end

      for _, marker in ipairs(markersToInteract) do
        print("You can interact with", marker.name)
      end
      
      if #markersToDisplay == 0 then
        Citizen.Wait(2000)
      end
    end
  end)
end

local function triggerOnReceiveMarkersEvent(markers)
  createAllMarkers(markers)

  -- Create thread

  -- while true
    -- Get all markers distance with player

    -- Filter markers when distance less than 1000
    -- For each markers filtered do
      -- Draw marker

    -- Filter markers when distance less than 2.5
    -- For each markers filtered do
      -- Display command label with key
      -- if key presses trigger server event ?? 
end

RegisterNetEvent("Marker:OnReceiveMarkers")
AddEventHandler("Marker:OnReceiveMarkers", triggerOnReceiveMarkersEvent)