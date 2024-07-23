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

local function triggerOnReceivePedsEvent(peds)
  print("peds", peds)

  for _, ped in ipairs(peds) do
    print("Spawn: ", ped.name)

    spawnPed(ped.model, ped.coordinate, ped.heading)
  end
end

RegisterNetEvent("Ped:OnReceivePeds")
AddEventHandler("Ped:OnReceivePeds", triggerOnReceivePedsEvent)