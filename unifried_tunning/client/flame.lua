local CalculateFlame = function(flameData)
    local maxFlameSize = 0
    local engineLevel  = flameData["Mods"]["Engine"]
    local turboLevel   = flameData["Mods"]["Turbo"]
    local fuelLevel    = flameData["Mods"]["Fuel"]

    -->> Calculates & Sets max flame size
    if (Particle.UseVehicles) then
        local vehicleModel    = flameData["Vehicle"]["Model"]
        local targetFlameSize = Particle.Vehicles[vehicleModel]

        if (targetFlameSize == nil) then
            targetFlameSize = Particle.Vehicles["Default"]
        end
    else
        if (engineLevel < 0) then
            engineLevel = 0
        end

        if (turboLevel < 0) then
            turboLevel = 0
        end

        if (fuelLevel < 0) then
            fuelLevel = 0
        end

        maxFlameSize = (0 + (engineLevel * Particle.Mods["Engine"]) + (turboLevel * Particle.Mods["Turbo"]) + (fuelLevel * Particle.Mods["Fuel"]))
    end

    local returnFlameSize = 0

    if (Particle.VarySizeWithRPM) then
        returnFlameSize = maxFlameSize * flameData["Probability"] * flameData["Vehicle"]["RPM"]
        if (Particle.VariationDifference ~= 0.0 and Particle.VariationDifference ~= nil) then
            returnFlameSize = returnFlameSize + (math.random(0, Particle.VariationDifference) / 100)
        end
    else
        returnFlameSize = maxFlameSize * flameData["Probability"]
        if (Particle.VariationDifference ~= 0.0 and Particle.VariationDifference ~= nil) then
            returnFlameSize = returnFlameSize + (math.random(0, Particle.VariationDifference) / 100)
        end
    end

    if (returnFlameSize < 0) then
        returnFlameSize = 0
    end

    return returnFlameSize
end

FlameHandler = function(functionData)
    local targetVehicle = functionData["Vehicle"]["Identifier"]
    local probability   = functionData["Probability"]
    local engineRPM     = functionData["Vehicle"]["RPM"]
    local hasTurbo      = functionData["Mods"]["Turbo"]
    local hasAnti       = functionData["Mods"]["Antilag"]

    local setPressure = false
    local soundNeeded = false

    for boneIndex = Exhaust.CheckRange["Minimum"], Exhaust.CheckRange["Maximum"] do
        local vehicleBone = GetEntityBoneIndexByName(targetVehicle, Exhaust.List[boneIndex])

        -->> Checks if bone is active
        if (vehicleBone <= 0) then
            goto continue
        end

        local flameData = {
            ["Vehicle"] = {
                ["RPM"]   = functionData["Vehicle"]["RPM"],
                ["Model"] = functionData["Vehicle"]["Model"]
            },
            ["Mods"] = {
                ["Engine"] = functionData["Mods"]["Engine"],
                ["Turbo"]  = functionData["Mods"]["Turbo"],
                ["Fuel"]   = functionData["Mods"]["Fuel"]
            },
            ["Probability"] = probability
        }

        local flameSize = CalculateFlame(flameData)

        if (flameSize > Particle.Parameters["SmallFlame"]) then
            local largeParticle = 1

            if (Particle.LargeListSize > 1) then
                largeParticle = math.random(1, Particle.LargeListSize)
            end

            local particleTable = Particle.List["Large"][largeParticle]
            UseParticleFxAssetNextCall(particleTable["Libary"])
            StartNetworkedParticleFxNonLoopedOnEntityBone(particleTable["Name"], targetVehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, vehicleBone, flameSize, false, false, false)

            if Sound.SoundPerFlame then
                PlayBackfire({["Vehicle"] = targetVehicle})
            else
                soundNeeded = true
            end
            
            setPressure = true
        elseif (flameSize > Particle.Parameters["JustSound"]) then
            local smallParticle = 1

            if (Particle.SmallListSize > 1) then
                smallParticle = math.random(1, Particle.SmallListSize)
            end

            local particleTable = Particle.List["Small"][smallParticle]
            UseParticleFxAssetNextCall(particleTable["Libary"])
            StartNetworkedParticleFxNonLoopedOnEntityBone(particleTable["Name"], targetVehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, vehicleBone, flameSize, false, false, false)
            
            if Sound.SoundPerFlame then
                PlayBackfire({["Vehicle"] = targetVehicle})
            else
                soundNeeded = true
            end
            
            setPressure = true
        elseif (flameSize > Particle.Parameters["NoAction"]) then
            if Sound.SoundPerFlame then
                PlayBackfire({["Vehicle"] = targetVehicle})
            else
                soundNeeded = true
            end
        end

        if soundNeeded then
            PlayBackfire({["Vehicle"] = targetVehicle})
        end

        ::continue::
    end

    if (hasTurbo == -1 or (hasAnti == 0 or hasAnti == "Default")) then
        setPressure = false
    end

    if (Upgrades.Antilag.PinTurbo and setPressure) then
        SetVehicleTurboPressure(targetVehicle, Upgrades.Antilag.MaxPressure)
    end
end