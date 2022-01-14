local QBCore = exports['qb-core']:GetCoreObject()

local function HasPhone()
    local p = promise.new()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem) p:resolve(hasItem) end, Config.PhoneList)
    return Citizen.Await(p)
end
  
exports("HasPhone", HasPhone)