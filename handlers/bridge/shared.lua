-- Handler (Based on https://github.com/overextended/ox_lib/blob/master/resource/init.lua)

local debug_getinfo, context = debug.getinfo, lib.context

_ENV.bridge = setmetatable({}, {
    __newindex = function(self, name, fn)
        rawset(self, name, fn)

        if debug_getinfo(2, 'S').short_src:find('@mst_lib/handlers/bridge') then
            exports(name, fn)
        end
    end,

    __index = function(self, mod)
        local shared = LoadResourceFile('mst_lib', ('modules/%s/shared'):format(mod))
        local path = ('@mst_lib/modules/%s/%s'):format(mod, context)

        local success, retval

        if shared then
            success, retval = pcall(require, ('@mst_lib/modules/%s/shared'):format(mod))
            if not success then
                return error(('Error importing shared module (%s): %s'):format(mod, retval), 3)
            end
        end
    
        if not shared or not retval then
            success, retval = pcall(require, path)
            if not success then
                return error(('Error importing module (%s): %s'):format(mod, retval), 3)
            end
        end
        rawset(self, mod, retval or noop)

        return self[mod]
    end
})

-- Mods

do
    local availableMods = {
        client = {
            'target',
            'textUI',
            'progressBar'
        },

        server = {

        },

        shared = {
            'notify'
        }
    }

    local defaultPath = 'mst_lib/handlers/bridge/%s/%s'
    for scope, mods in ipairs(availableMods) do
        for i = 1, #mods do
            local mod = mods[i]
            if not bridge[mod] then
                bridge[mod] = require(defaultPath:format(scope, mod))
            end
        end
    end
end

-- Export

exports('getBridge', function()
    return bridge
end)