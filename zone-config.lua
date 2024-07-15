-- This file only contain method to return territories list
-- You have to update this file to return data from you data

ZoneConfig = {}

function ZoneConfig:getZones()
    return {
        {
            owner = "phenixos",
            name = "fd2",
            coords = {
                vector2(-29.238744735718, -1615.0500488281),
                vector2(-27.867151260376, -1604.5345458984),
                vector2(-228.95095825195, -1436.3778076172),
                vector2(-116.63549041748, -1370.453125),
                vector2(100.55031585693, -1365.3785400391),
                vector2(151.92407226562, -1395.3004150391)
            },
            args = {
                minZ = 29,
                maxZ = 50,
                debugPoly = true,
                debugColors = {
                    walls = {
                        0,
                        255,
                        0
                    }
                }
            }
        },
        {
            owner = "",
            name = "fm-ballas",
            coords = {
                vector2(155.50811767578, -1394.1446533203),
                vector2(240.63139343262, -1446.3013916016),
                vector2(318.87905883789, -1512.0625),
                vector2(155.46807861328, -1610.2868652344),
                vector2(46.54207611084, -1669.4981689453),
                vector2(-25.240659713745, -1613.8848876953)
            },
            args = {
                minZ = 29,
                maxZ = 50,
                debugPoly = true,
                debugColors = {
                    walls = {
                        255,
                        0,
                        0
                    }
                }
            }
        },
        {
            owner = "",
            name = "ballas2",
            coords = {
                vector2(49.910140991211, -1671.1374511719),
                vector2(275.22314453125, -1861.3327636719),
                vector2(370.13916015625, -1748.0247802734),
                vector2(189.62725830078, -1591.3520507812)
            },
            args = {
                minZ = 29,
                maxZ = 50,
                debugPoly = true,
                debugColors = {
                    walls = {
                        255,
                        0,
                        0
                    }
                }
            }
        },
    }
end