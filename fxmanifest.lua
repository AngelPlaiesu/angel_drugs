fx_version 'cerulean'
game 'gta5'

shared_scripts {
    'config.lua',
}

-- Specify the resource's dependencies
dependencies {
    'qb-core',
}

-- Specify the main script file
client_script 'client.lua'
server_script 'server.lua'


lua54 'yes'