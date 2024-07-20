-- Function to spawn a ped
function spawnPed(model, coord, heading) 
  -- Load the ped model
  RequestModel(model)
  while not HasModelLoaded(model) do
      Wait(500)
  end

  -- Create the ped
  local ped = CreatePed(4, model, coord.x, coord.y, coord.z, heading, true, false)
    
  -- Set ped as no longer needed to free up memory
  SetEntityAsNoLongerNeeded(ped)

  -- Optionally set some properties for the ped
  SetPedRandomComponentVariation(ped, true)

  TaskStandStill(ped, -1)
  disablePedMovement(ped)
 end

 -- Function to disable ped movement and fleeing
function disablePedMovement(ped)
  -- Disable fleeing
  SetBlockingOfNonTemporaryEvents(ped, true)
  SetPedFleeAttributes(ped, 0, false)

  SetEntityInvincible(ped, true)

  -- Disable movement
  SetPedCombatAttributes(ped, 46, true) -- Prevents ped from moving when in combat
  SetPedCombatAttributes(ped, 17, true) -- Prevents ped from using cover
  SetPedCanRagdoll(ped, false)
  SetPedCanBeTargetted(ped, false)
  SetPedCanBeTargettedByTeam(ped, false)
  SetPedCanBeTargettedByPlayer(ped, false, false)
  SetPedAsEnemy(ped, false)
  SetPedCanEvasiveDive(ped, false)
end


-- Example of rotating a vehicle 360 degrees
RegisterCommand('rotate', function(_, args)
  local vehicle = tonumber(args[1])
  local degres = tonumber(args[2])

  local rot = GetEntityRotation(vehicle, 2)
  local roll, pitch, yaw = rot.x, rot.y, rot.z


  local finalYaw = yaw + degres
  local steps = 12 -- Reduced the number of steps so each rotation is larger
  -- Function to perform the rotation gradually
  local function doRotation()
      local currentYaw = yaw
      -- Loop to adjust the rotation in steps
      for i = 1, steps do
          Citizen.Wait(20) -- Increases the delay between each adjustment to make the animation slower
          currentYaw = currentYaw + (degres / steps) -- Increments the rotation
          if currentYaw >= finalYaw then
              currentYaw = finalYaw
          end
          -- Apply the current rotation
          SetEntityRotation(vehicle, roll, pitch, currentYaw % degres, 2, true)
          SetEntityHeading(vehicle, currentYaw % degres)
          if currentYaw == finalYaw then
              break -- Stops the loop once the rotation is complete
          end
      end
  end
  -- Execute the rotation in a coroutine to not block the main thread
  Citizen.CreateThread(doRotation)
end, false)

local function triggerOnReceivePedsEvent(peds)
  print("peds", peds)

  for _, ped in ipairs(peds) do
    print("Spawn: ", ped.name)

    spawnPed(ped.model, ped.coordinate, ped.heading)
  end
end

RegisterNetEvent("Ped:OnReceivePeds")
AddEventHandler("Ped:OnReceivePeds", triggerOnReceivePedsEvent)