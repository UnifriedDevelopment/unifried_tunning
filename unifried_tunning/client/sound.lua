PlayBackfire = function(soundData)
    local soundIndex    = math.random(Sound.UseFromRange["Minimum"], Sound.UseFromRange["Maximum"])
    local soundTable    = Sound.List[soundIndex]
    local targetVehicle = soundData["Vehicle"]

    if (General.Debug) then
        print("Sound Generator: Sound Name [" .. soundTable["Name"] .. "] & Sound Parent [" .. soundTable["Parent"] .. "]")
    end

    PlaySoundFromEntity(-1, soundTable["Name"], targetVehicle, soundTable["Parent"], General.Network, 0)
end