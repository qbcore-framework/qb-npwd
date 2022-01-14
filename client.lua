local QBCore = exports['qb-core']:GetCoreObject()

local function HasPhone()
    local _hasPhone = nil
    QBCore.Functions.TriggerCallback('qb-npwd:HasPhone', function(hasPhone) _hasPhone = hasPhone end)
    while _hasPhone == nil do Wait(100) end
    return _hasPhone
end
  
exports("HasPhone", HasPhone)