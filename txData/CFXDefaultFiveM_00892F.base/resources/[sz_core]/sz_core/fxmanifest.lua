fx_version 'cerulean'
game 'gta5'

author 'SzCore Dev'
description 'Core system for SzCore Server'
version '1.0.0'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}