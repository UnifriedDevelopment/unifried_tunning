local ImportedFramework = {}

Citizen.CreateThread(function()
    if General.Framework == "ESX" then
        ImportedFramework = exports['es_extended']:getSharedObject()
    elseif General.Framework == "QBCORE" then
        ImportedFramework = exports['qb-core']:GetCoreObject()
    end
end)

RemoveItem = function(source, itemName)
    local targetPlayer = nil
    if General.Framework == "ESX" then
        targetPlayer = ESX.GetPlayerFromId(source)
        targetPlayer.removeInventoryItem(itemName, 1)
    elseif General.Framework == "QBCORE" then
        targetPlayer = ImportedFramework.Functions.GetPlayer(source)
        targetPlayer.Functions.RemoveItem(itemName, 1)
    end
end

ItemCheck = function(source, itemName)
    if (General.Framework == "STANDALONE") then
        return true
    end

    local targetPlayer = nil

    if General.Framework == "ESX" then
        targetPlayer = ESX.GetPlayerFromId(source)
        local result = targetPlayer.hasItem(itemName)

        if result ~= nil then
            result = true
        else
            result = false
        end

        return result
    elseif General.Framework == "QBCORE" then
        targetPlayer = ImportedFramework.Functions.GetPlayer(source)
        local result = targetPlayer.Functions.HasItem(source, itemName, 1)

        return result
    end

    return false
end