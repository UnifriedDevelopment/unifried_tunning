local Vehicle_Tunes = {}

local tuneTemplate = {
    ["TwoStep"] = Upgrades.Twostep.Levels["Minimum"],
    ["Fuel"]    = Upgrades.Fuel.Levels["Minimum"],
    ["Antilag"] = Upgrades.Antilag.Levels["Minimum"],
    ["Muffler"] = 0
}

local ReadData = function()
    local resourcePath = GetResourcePath(GetCurrentResourceName()) .. '/data/Vehicle_Tunes.txt'
    
    local file = io.open(resourcePath, "r")
    local fileContent = file:read()

    local decodedData = json.decode(fileContent)
    
    if fileContent ~= nil then
        Vehicle_Tunes = decodedData
    end

    Citizen.Wait(100)

    local sentData = json.encode(Vehicle_Tunes)
    TriggerClientEvent("unifried_tunning:client:tunes", -1, sentData)
end

local SaveData = function()
    local resourcePath = GetResourcePath(GetCurrentResourceName()) .. '/data/Vehicle_Tunes.txt'
    
    local file = io.open(resourcePath, "w+")

    local encodedData = json.encode(Vehicle_Tunes)

    file:write(encodedData)
    file:close()
end

RegisterCommand(Commands.Tune["Command"], function(source, args, rawCommand)
    local source = source
    if (source > 0) then
        local tuneParameter  = args[1]
        local valueParameter = tonumber(args[2])
        local validTuneNames = Commands.Tune["TuneNames"]

        if (tuneParameter ~= validTuneNames["Antilag"]) and (tuneParameter ~= validTuneNames["TwoStep"]) and (tuneParameter ~= validTuneNames["Fuel"]) and (tuneParameter ~= validTuneNames["Muffler"]) then
            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["InvalidTuneParameter"], "")
            return
        end

        local permissionRequired = Permissions.PermissionForUpgrade[tuneParameter]
        if (Permissions.Enable and ((permissionRequired ~= nil) and (permissionRequired ~= ""))) then
            if (tuneParameter ~= "muffler") then
                permissionRequired = Permissions.PermissionForUpgrade[tuneParameter][valueParameter]
            end

            if ((permissionRequired ~= nil) and (permissionRequired ~= "")) then
                if (IsPlayerAceAllowed(source, permissionRequired) == false) then
                    TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["NoPermission"], "")
                    return
                end
            end
        end

        local itemRequired = Items.UpgradeItem[tuneParameter]

        if (Items.Enable and ((itemRequired ~= nil) or (itemRequired ~= ""))) then
            if (tuneParameter ~= "muffler") then
                itemRequired = Items.UpgradeItem[tuneParameter][valueParameter]
            end

            if ((itemRequired ~= nil) and (itemRequired ~= "")) then
                if (ItemCheck(source, itemRequired) == false) then
                    TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["NoItem"], "")
                    return
                end

                if (Items.UseItem[tuneParameter] == true) then
                    RemoveItem(source, Items.UpgradeItem[tuneParameter][valueParameter])
                end
            end
        end

        local playerVehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)
        local vehiclePlate  = GetVehicleNumberPlateText(playerVehicle)

        if ((vehiclePlate == nil) or (vehiclePlate == '')) then
            return
        end

        local tuneTable = Vehicle_Tunes[vehiclePlate]

        if (tuneTable == nil) then
            tuneTable = tuneTemplate
        end

        valueParameter = math.round(valueParameter)

        if (tuneParameter == validTuneNames["Muffler"]) then
            if (valueParameter < 0) then
                valueParameter = 0
            elseif (valueParameter > 1) then
                valueParameter = 1
            end

            tuneTable["Muffler"] = valueParameter
            Vehicle_Tunes[vehiclePlate] = tuneTable

            SaveData()

            Citizen.Wait(100)

            local sentData = json.encode(Vehicle_Tunes)

            TriggerClientEvent("unifried_tunning:client:tunes", -1, sentData)

            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["MufflerTuned"], valueParameter)
        elseif (tuneParameter == validTuneNames["TwoStep"]) then
            if (valueParameter < Upgrades.Twostep.Levels["Minimum"]) then
                valueParameter = Upgrades.Twostep.Levels["Minimum"]
            elseif (valueParameter > Upgrades.Twostep.Levels["Maximum"]) then
                valueParameter = Upgrades.Twostep.Levels["Maximum"]
            end

            tuneTable["TwoStep"] = valueParameter
            Vehicle_Tunes[vehiclePlate] = tuneTable

            SaveData()

            Citizen.Wait(100)

            local sentData = json.encode(Vehicle_Tunes)
            TriggerClientEvent("unifried_tunning:client:tunes", -1, sentData)

            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["TwoStepTuned"], valueParameter)
        elseif (tuneParameter == validTuneNames["Antilag"]) then
            if (valueParameter < Upgrades.Antilag.Levels["Minimum"]) then
                valueParameter = Upgrades.Antilag.Levels["Minimum"]
            elseif (valueParameter > Upgrades.Antilag.Levels["Maximum"]) then
                valueParameter = Upgrades.Antilag.Levels["Maximum"]
            end

            tuneTable["Antilag"] = valueParameter
            Vehicle_Tunes[vehiclePlate] = tuneTable

            SaveData()

            Citizen.Wait(100)

            local sentData = json.encode(Vehicle_Tunes)
            TriggerClientEvent("unifried_tunning:client:tunes", -1, sentData)

            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["AntilagTuned"], valueParameter)
        elseif (tuneParameter == validTuneNames["Fuel"]) then
            if (valueParameter < Upgrades.Fuel.Levels["Minimum"]) then
                valueParameter = Upgrades.Fuel.Levels["Minimum"]
            elseif (valueParameter > Upgrades.Fuel.Levels["Maximum"]) then
                valueParameter = Upgrades.Fuel.Levels["Maximum"]
            end

            tuneTable["Fuel"] = valueParameter
            Vehicle_Tunes[vehiclePlate] = tuneTable

            SaveData()

            Citizen.Wait(100)

            local sentData = json.encode(Vehicle_Tunes)
            TriggerClientEvent("unifried_tunning:client:tunes", -1, sentData)

            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["FuelTuned"], valueParameter)
        else
            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["InvalidTuneParameter"], "")
            return
        end
    end
end, false)

RegisterCommand(Commands.CheckTune["Command"], function(source, args, rawCommand)
    local source = source
    if (source > 0) then
        local validTuner = true

        local tuneParameter  = args[1]

        local validTuneNames = Commands.Tune["TuneNames"]

        if (tuneParameter ~= validTuneNames["Antilag"]) and (tuneParameter ~= validTuneNames["TwoStep"]) and (tuneParameter ~= validTuneNames["Fuel"]) and (tuneParameter ~= validTuneNames["Muffler"]) then
            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["InvalidTuneParameter"], "")
            return
        end


        local playerVehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)
        local vehiclePlate  = GetVehicleNumberPlateText(playerVehicle)

        if ((vehiclePlate == nil) or (vehiclePlate == '')) then
            return
        end

        local tuneTable = Vehicle_Tunes[vehiclePlate]

        if (tuneTable == nil) then
            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["NoTune"], "")
            return
        end

        if (tuneParameter == validTuneNames["Muffler"]) then
            local tune = tuneTable["Muffler"]
            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["MufflerTune"], tune)
        elseif (tuneParameter == validTuneNames["TwoStep"]) then
            local tune = tuneTable["TwoStep"]
            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["TwoStepTune"], tune)
        elseif (tuneParameter == validTuneNames["Antilag"]) then
            local tune = tuneTable["Antilag"]
            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["AntilagTune"], tune)
        elseif (tuneParameter == validTuneNames["Fuel"]) then
            local tune = tuneTable["Fuel"]
            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["FuelTune"], tune)
        else
            TriggerClientEvent("unifried_tunning:client:notify", source, Messages.Notify["NoTune"], "")
        end
    end
end, false)

RegisterServerEvent("unifried_tunning:server:connection")
AddEventHandler("unifried_tunning:server:connection", function()
    if (source > 0) then
        return
    end

    TriggerClientEvent("unifried_tunning:client:tunes", -1, sentData)
end)

Citizen.CreateThread(function()
    ReadData()
end)
