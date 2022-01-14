local QBCore = exports['qb-core']:GetCoreObject()

local function HasPhone()
    local _hasPhone = nil
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem) _hasPhone = hasItem end, Config.PhoneList)
    while _hasPhone == nil do Wait(100) end
    return _hasPhone
end
  
exports("HasPhone", HasPhone)