fx_version 'cerulean'
game 'gta5'

description 'A simple bridge resource for QB Compatibility for NPWD'
version '1.0.0'

client_script 'client.lua'

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'sv_utils.lua',
  'server.lua'
}

shared_script 'config.lua'

lua54 'yes'
