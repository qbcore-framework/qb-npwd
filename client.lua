local QBCore = exports['qb-core']:GetCoreObject()

local function HasPhone()
    return QBCore.Functions.HasItem(Config.PhoneList)
end
  
exports("HasPhone", HasPhone)