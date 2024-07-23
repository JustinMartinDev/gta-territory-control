local spawnPos = vector3(-89.07838, -1720.731, 29.16545)

-- Let's work on it
RegisterCommand('setup-zone', function(source, args)
  TriggerServerEvent("ZoneConfig:RequestZones")
end, false)

RegisterCommand('setup-ped', function()
  TriggerServerEvent("Ped:RequestPeds")
end, false)

RegisterCommand('setup-marker', function()
  TriggerServerEvent("Marker:RequestMarkers")
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

      GiveWeaponToPed(
        PlayerPedId(),
        984333226,
        15,
        false,
        true
      )
    end)
  end)

  exports.spawnmanager:setAutoSpawn(true)
  exports.spawnmanager:forceRespawn()
end)