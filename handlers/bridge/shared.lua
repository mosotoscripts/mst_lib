-- Handler (Based on https://github.com/overextended/ox_lib/blob/master/resource/init.lua)

local debug_getinfo, context = debug.getinfo, lib.context

_ENV.bridge = {}

-- Mods

do
    local availableMods = {
        client = {
            'framework'
        },

        server = {
            'framework'
        },

        shared = {
            'framework',
            'notify'
        }
    }

    local defaultPath = '@mst_lib/handlers/bridge/%s/%s'
    for scope, mods in ipairs(availableMods) do
        for i = 1, #mods do
            local mod = mods[i]
            if not bridge[mod] then
                local bridgeMod = require(defaultPath:format(scope, mod))
                bridge = lib.table.merge(bridge, bridgeMod)
            end
        end
    end
end

-- Export

exports('getBridge', function()
    return bridge
end)