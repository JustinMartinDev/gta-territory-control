local spawnPos = vector3(-89.07838, -1720.731, 29.16545)

local function setup()
  local zones = ZoneConfig:getZones();

  for _, zone in ipairs(zones) do
    print("Generate: ", zone.name)

    PolyZone:Create(
      zone.coords,
      Utils:spreadObject(zone.args, {
        name = zone.name
      })
    )
  end
end

-- Let's work on it
RegisterCommand('setup-t', function(source, args)
  setup()
end, false)


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
      setup()
    end)
  end)

  exports.spawnmanager:setAutoSpawn(true)
  exports.spawnmanager:forceRespawn()
end)