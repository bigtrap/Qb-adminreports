fx_version 'cerulean'
game 'gta5'

author 'BigTrap Customs'
description 'TrapReports Script'
version '1.0.0'

lua54 'yes' -- Ensure this line is present to specify Lua 5.4

-- Main script files
client_script 'client.lua'
server_script 'server.lua'

escrow_ignore{
    'config.lua'
}
