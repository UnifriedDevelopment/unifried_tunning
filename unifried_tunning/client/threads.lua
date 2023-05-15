Citizen.CreateThread(function()
    TriggerServerEvent("unifried_tunning:server:connection")

    while true do
        local playerPed      = PlayerPedId()
        local vehiclePlate   = nil
        local waitTimer      = nil
        local currentVehicle = GetVehiclePedIsIn(playerPed, false)
        local vehiclePlate   = nil
        local vehicleModel   = nil

        if (currentVehicle == 0) or (GetPedInVehicleSeat(currentVehicle, -1) ~= playerPed) then

            if (General.Debug) then
                print(Messages.Error["1"])
            end

            waitTimer = Timers.LongerWait

            goto continue
        end

        vehiclePlate = GetVehicleNumberPlateText(currentVehicle)

        if ((vehiclePlate == nil) or (vehiclePlate == '')) then

            if (General.Debug) then
                print(Messages.Error["2"])
            end

            waitTimer = Timers.LongerWait

            goto continue
        end

        vehicleModel = GetEntityModel(currentVehicle)

        if (GetVehicleMod(currentVehicle, General.ModReferences["Exhaust"]) ~= -1) then

            if (General.Debug) then
                print(Messages.Error["3"])
            end

            waitTimer = Timers.LongerWait

            goto continue
        end
        
        if (Upgrades.Muffler.Enabled) then
            local vehicleTune = vehicleTunes[vehiclePlate]
            if (vehicleTune == nil) or (vehicleTune["Muffler"] ~= 1) then
                if (General.Debug) then
                    print(Messages.Error["4"])
                end

                waitTimer = Timers.LongerWait

                goto continue
            end
        end

        -->> Valid Vehicle
        waitTimer = VehicleHandler(currentVehicle, vehiclePlate, vehicleModel)

        ::continue::

        if (waitTimer == nil) then
            waitTimer = math.random(Timers.Default["Minimum"], Timers.Default["Maximum"])
        end

        Citizen.Wait(waitTimer)
    end
end)

---------------------------------------------------------------------------------------------------->> COMMAND SUGGESTIONS <<-----------------------------------------

TriggerEvent('chat:addSuggestion', '/' .. Commands.Tune["Command"], Commands.Tune["Description"], {
    { name = Commands.Tune["Suggestions"]["1"]["Name"], help = Commands.Tune["Suggestions"]["1"]["Help"] },
    { name = Commands.Tune["Suggestions"]["2"]["Name"], help = Commands.Tune["Suggestions"]["2"]["Help"] }
})

TriggerEvent('chat:addSuggestion', '/' .. Commands.CheckTune["Command"], Commands.Tune["Description"], {
    { name = Commands.CheckTune["Suggestions"]["1"]["Name"], help = Commands.Tune["Suggestions"]["1"]["Help"] },
})

---------------------------------------------------------------------------------------------------->> NOTIFICATIONS <<-----------------------------------------
RegisterNetEvent("unifried_tunning:client:notify")
AddEventHandler("unifried_tunning:client:notify", function(text, value)
    local text  = text
    local value = value

    Notify.Create(text, value)
end)