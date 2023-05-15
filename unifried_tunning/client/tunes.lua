vehicleTunes = {}

RegisterNetEvent("unifried_tunning:client:tunes")
AddEventHandler("unifried_tunning:client:tunes", function(tuneTable)
    local tuneTable = json.decode(tuneTable)

    if (tuneTable ~= nil) then
        if (General.Debug) then
            print("Vehicle Tunes Updated!")
        end

        vehicleTunes = tuneTable
    else
        if (General.Debug) then
            print("Vehicle Tunes Could Not Update! : Nil table passed")
        end
    end
end)