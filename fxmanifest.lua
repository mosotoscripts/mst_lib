fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

name 'mst_lib'
author 'te6ka_ninja'
version '0.0.1'
description 'A FiveM library which helps handle some of the Mosoto Scripts key features.'

shared_scripts {
    '@ox_lib/init.lua',
    'handlers/shared.lua',
    'handlers/**/shared.lua'
}

client_scripts {
    'handlers/**/client.lua'
}

server_scripts {
    'handlers/**/server.lua'
}

files {
    'api.lua',
    'modules/**'
}

dependencies {
    '/server:7290',
    'ox_lib'
}