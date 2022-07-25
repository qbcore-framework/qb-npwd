local QBCore = exports['qb-core']:GetCoreObject()
local hasPhone = false

local function DoPhoneCheck(PlayerItems)
    local _hasPhone = false

    for _,item in pairs(PlayerItems) do
        if Config.PhoneList[item.name] then
            _hasPhone = true
            break;
        end
    end

    hasPhone = _hasPhone
    exports['npwd']:setPhoneDisabled(not hasPhone)
end

local function HasPhone()
    return hasPhone
end
  
exports("HasPhone", HasPhone)

-- Handles state right when the player selects their character and location.
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    DoPhoneCheck(QBCore.Functions.GetPlayerData().items)
end)

-- Resets state on logout, in case of character change.
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    DoPhoneCheck({})
    TriggerServerEvent("qb-npwd:server:UnloadPlayer")
end)

-- Handles state when PlayerData is changed. We're just looking for inventory updates.
RegisterNetEvent('QBCore:Player:SetPlayerData', function(PlayerData)
    DoPhoneCheck(PlayerData.items)
end)

-- Handles state if resource is restarted live.
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource and GetResourceState('npwd') == 'started' then
        DoPhoneCheck(QBCore.Functions.GetPlayerData().items)
    end
end)

-- Allows use of phone as an item.
RegisterNetEvent('qb-npwd:client:setPhoneVisible', function(isPhoneVisible)
    exports['npwd']:setPhoneVisible(isPhoneVisible)
end)
