fx_version 'cerulean'

game 'gta5'

author 'Mr_Zain#4139'

description 'mz-lumberjack - Progression based tree chopping (with or without mz-skills integration)'

version '2.0.2'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua'
}

server_scripts {'server/*.lua'}

shared_scripts {
	'@qb-core/shared/locale.lua',
	'config.lua',
	'locales/en.lua',
}

dependencies {
    'PolyZone',
    'qb-menu',
    'qb-target',
}