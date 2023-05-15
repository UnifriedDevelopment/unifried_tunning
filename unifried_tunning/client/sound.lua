PlayBackfire = function(soundData)
    local soundIndex    = math.random(Sound.UseFromRange["Minimum"], Sound.UseFromRange["Maximum"])
    local soundTable    = Sound.List[soundIndex]
    local targetVehicle = soundData["Vehicle"]

    PlaySoundFromEntity(-1, soundTable["Name"], targetVehicle, soundTable["Parent"], General.Network, 0)
end