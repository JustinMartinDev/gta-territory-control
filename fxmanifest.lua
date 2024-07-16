fx_version 'cerulean'
game 'gta5'

author 'An awesome dude'
description 'An awesome, but short, description'
version '1.0.0'

resource_type 'gametype' { name = 'My awesome game type!' }

dependencies {
    "utils"
}

client_script {
    'utils.lua',
    'zone-config.lua',
    'polyzone-client.lua',
    'client.lua'
}
