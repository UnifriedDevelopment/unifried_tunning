VehicleHandler = function(currentVehicle, vehiclePlate, vehicleModel)
    local currentVehicle = currentVehicle
    local vehiclePlate   = vehiclePlate
    local vehicleModel   = vehicleModel
    local waitTimer      = nil

    local engineRPM = GetVehicleCurrentRpm(currentVehicle)
    local cutoffRPM = nil

    local hasTune     = false
    local vehicleTune = vehicleTunes[vehiclePlate]
    
    local TwoStepEnabled = false 

    if (vehicleTune ~= nil) then
        hasTune = true

        if (vehicleTune["TwoStep"] ~= nil) then
            if (Upgrades.Twostep.Enabled) then
                TwoStepEnabled = vehicleTune["TwoStep"]
            else
                TwoStepEnabled = false
            end
        else
            TwoStepEnabled = false
        end
    end

    ---------------------->> GUARD STATEMENTS <<--------------------

    local logicControlPressed = (IsControlPressed(0, 71) or IsControlPressed(0, 72))
    local logicTwoStepEnabled = ((engineRPM > Upgrades.Twostep.LevelRPM[TwoStepEnabled]) and (TwoStepEnabled ~= 0))

    if ((logicControlPressed) and (logicTwoStepEnabled == false)) then
        if (General.Debug) then
            print(print(Messages.Error["5"]))
        end

        return waitTimer
    end

    if (General.UseStaticMinimumRPM and (engineRPM < General.StaticMinimumRPM)) then
        if (General.Debug) then
            print(print(Messages.Error["6"]))
        end

        return waitTimer
    elseif (General.UseStaticMinimumRPM ~= true and (math.random(General.DynamicMinimumRPM["Minimum"], General.DynamicMinimumRPM["Maximum"]) / 100)) then
        if (General.Debug) then
            print(print(Messages.Error["6"]))
        end

        return waitTimer
    end

    ---------------------->> GUARD STATEMENTS <<--------------------

    ---------------------->> PROBABILITY CALCULATION <<--------------------

    local vehicleMods = {
        ["Turbo"] = {
            ["Installed"] = -1,
            ["Pressure"]  = GetVehicleTurboPressure(currentVehicle)
        },
        ["Engine"] = GetVehicleMod(currentVehicle, General.ModReferences["Engine"])
    }

	if (vehicleMods["Turbo"]["Pressure"] ~= 0.0) then
		vehicleMods["Turbo"]["Installed"] = 1
	end

    local calculatedWeights = {}

    calculatedWeights.engine        = Weighting.Engine * vehicleMods["Engine"]
    calculatedWeights.turbo         = 0
    calculatedWeights.turboPressure = 0
    calculatedWeights.fuel          = 0
    calculatedWeights.antilag       = 0

    if (hasTune) then
        calculatedWeights.fuel = vehicleTune["Fuel"] * Weighting.Fuel
    end

    if (vehicleMods["Turbo"]["Installed"] ~= -1) then
        calculatedWeights.turbo         = vehicleMods["Turbo"]["Installed"] * Weighting.Turbo
        calculatedWeights.turboPressure = vehicleMods["Turbo"]["Pressure"]  * Weighting.TurboPressure

        if hasTune then
            calculatedWeights.antilag = vehicleTune["Antilag"] * Weighting.Antilag
        end
    end

    local finalProbability = (calculatedWeights.engine + calculatedWeights.turbo + calculatedWeights.turboPressure + calculatedWeights.fuel + calculatedWeights.antilag) * Weighting.Master

    if (finalProbability < 0) then
        finalProbability = 0
    elseif (finalProbability > 1) then
        finalProbability = 1
    end

    ---------------------->> PROBABILITY CALCULATION <<--------------------
    local handlerData = {
        ["Vehicle"] = {
            ["Identifier"] = currentVehicle,
            ["Model"]      = vehicleModel,
            ["RPM"]        = engineRPM,
        },
        ["Mods"] = {
            ["Engine"]  = vehicleMods["Engine"],
            ["Turbo"]   = vehicleMods["Turbo"]["Installed"],
            ["TurboPressure"] = vehicleMods["Turbo"]["Pressure"],
            ["TwoStep"] = vehicleTune["TwoStep"],
            ["Fuel"]    = vehicleTune["Fuel"],
            ["Antilag"] = vehicleTune["Antilag"],
            ["Muffler"] = vehicleTune["Muffler"],
        },
        ["Probability"] = finalProbability
    }

    FlameHandler(handlerData)

    if (hasTune and (vehicleMods["Turbo"]["Installed"] ~= -1) and (Timers.Antilag[vehicleTune["Antilag"]] ~= nil)) then
        local timerTable = Timers.Antilag[vehicleTune["Antilag"]]
        local minWait = timerTable["Minimum"]
        local maxWait = timerTable["Maximum"]

        waitTimer = math.random(minWait, maxWait)
    else
        waitTimer = math.random(Timers.Default["Minimum"], Timers.Default["Maximum"])
    end

    local timer = Timers.SafeWait + (waitTimer * (1 - (engineRPM - 0.4)))

    return timer
end