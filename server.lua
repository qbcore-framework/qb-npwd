local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('QBCore:Server:PlayerLoaded', function(qbPlayer)
  local playerIdent = qbPlayer.PlayerData.citizenid
  local phoneNumber = tostring(qbPlayer.PlayerData.charinfo.phone)
  local charInfo = qbPlayer.PlayerData.charinfo
  local playerSrc = qbPlayer.PlayerData.source

  MySQL.Sync.fetchAll('UPDATE players SET phone_number = ? WHERE citizenid = ?', { phoneNumber, playerIdent })

  exports.npwd:newPlayer({
    source = playerSrc,
    phoneNumber = tostring(charInfo.phone),
    identifier = playerIdent,
    firstname = charInfo.firstname,
    lastname = charInfo.lastname
  })
  debugPrint(('Loaded new player. S: %s, Iden: %s, Num: %s'):format(playerSrc, playerIdent, phoneNumber))
end)

RegisterNetEvent("qb-npwd:server:UnloadPlayer", function()
  local src = source
  exports.npwd:unloadPlayer(src)
end)

local currentResName = GetCurrentResourceName()

AddEventHandler('onServerResourceStart', function(resName)
  if resName ~= currentResName then return end

  debugPrint('Launched with debug mode on')
  local players = QBCore.Functions.GetQBPlayers()

  for _,v in pairs(players) do
    exports.npwd:newPlayer({
      source = v.PlayerData.source,
      identifier = v.PlayerData.citizenid,
      phoneNumber = tostring(v.PlayerData.charinfo.phone),
      firstname = v.PlayerData.charinfo.firstname,
      lastname = v.PlayerData.charinfo.lastname,
    })
  end
end)

QBCore.Functions.CreateUseableItem(getTableKeys(Config.PhoneList), function(source, item)
  TriggerClientEvent('qb-npwd:client:setPhoneVisible', source, true)
end)
