local QBCore = exports['qb-core']:GetCoreObject()
local hasPhone = false

local function DoPhoneCheck(PlayerData)
    local _hasPhone = false
    local PlayerItems = PlayerData.items or {}
    local metadata = PlayerData.metadata or {}
    for _, item in pairs(PlayerItems) do
        if Config.PhoneList[item.name] then
            _hasPhone = true
            break;
        end
    end

    hasPhone = _hasPhone
    local isDead = (metadata["isdead"] or metadata['inlaststand']) or false
    local isCuffed = metadata["ishandcuffed"] or false
    local disabled = false
    if not Config.UseWhileDead and isDead then
        disabled = true
    end
    if not Config.UseWhileCuffed and isCuffed then
        disabled = true
    end
    if exports['npwd']:isPhoneVisible() and disabled then
        exports['npwd']:setPhoneVisible(false)
    end
    exports['npwd']:setPhoneDisabled(disabled)
end

local function HasPhone()
    return hasPhone
end

exports("HasPhone", HasPhone)

-- Handles state right when the player selects their character and location.
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    DoPhoneCheck(QBCore.Functions.GetPlayerData())
end)

-- Resets state on logout, in case of character change.
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    DoPhoneCheck({})
    TriggerServerEvent("qb-npwd:server:UnloadPlayer")
end)

-- Handles state when PlayerData is changed. We're just looking for inventory updates.
RegisterNetEvent('QBCore:Player:SetPlayerData', function(PlayerData)
    DoPhoneCheck(PlayerData)
end)

-- Handles state if resource is restarted live.
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource and GetResourceState('npwd') == 'started' then
        DoPhoneCheck(QBCore.Functions.GetPlayerData())
    end
end)

-- Allows use of phone as an item.
RegisterNetEvent('qb-npwd:client:setPhoneVisible', function(isPhoneVisible)
    exports['npwd']:setPhoneVisible(isPhoneVisible)
end)
