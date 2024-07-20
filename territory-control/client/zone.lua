local function triggerOnReceiveZonesEvent(zones)
  for _, zone in ipairs(zones) do
    print("Generate: ", zone.name)

    PolyZone:Create(
      zone.coordinates,
      exports.utils:spreadObject({
        minZ = 29,
        maxZ = 50,
        debugPoly = true,
      }, {
        name = zone.name,
        debugColors = {
          walls = zone.colors
        }
      })
    )
  end
end

RegisterNetEvent("ZoneConfig:OnReceiveZones")
AddEventHandler("ZoneConfig:OnReceiveZones", triggerOnReceiveZonesEvent)