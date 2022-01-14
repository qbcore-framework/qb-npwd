local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-npwd:HasPhone', function(source, cb)
  local Player = QBCore.Functions.GetPlayer(source)

  local hasPhone = false
  for _,phone in ipairs(Config.PhoneList) do
    if Player.Functions.GetItemByName(phone) then 
      hasPhone = true 
      break;
    end
  end
  cb(hasPhone)
end)

AddEventHandler('QBCore:Server:PlayerLoaded', function(qbPlayer)
  local playerIdent = qbPlayer.PlayerData.citizenid
  local phoneNumber = tostring(qbPlayer.PlayerData.charinfo.phone)
  local charInfo = qbPlayer.PlayerData.charinfo
  local playerSrc = qbPlayer.PlayerData.source

  exports.oxmysql:executeSync('UPDATE players SET phone_number = ? WHERE citizenid = ?', { phoneNumber, playerIdent })

  exports.npwd:newPlayer({
    source = playerSrc,
    phoneNumber = charInfo.phone,
    identifier = playerIdent,
    firstname = charInfo.firstname,
    lastname = charInfo.lastname
  })
  debugPrint(('Loaded new player. S: %s, Iden: %s, Num: %s'):format(playerSrc, playerIdent, phoneNumber))
end)

AddEventHandler('QBCore:Client:OnPlayerUnload', function(src)
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
      phoneNumber = v.PlayerData.charinfo.phone,
      firstname = v.PlayerData.charinfo.firstname,
      lastname = v.PlayerData.charinfo.lastname,
    })
  end
end)
