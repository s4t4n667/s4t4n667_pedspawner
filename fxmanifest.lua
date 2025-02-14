fx_version 'cerulean'
game 'gta5'
use_experimental_fxv2_oal 'yes'
lua54 'yes'

author "Asgaard Developments | s4t4n667"
description 'Ped spawner using scenarios and animations'
version '1.0.0'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'resource/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'resource/server.lua'
}
