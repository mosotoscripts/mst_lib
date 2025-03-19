-- Based on https://github.com/overextended/ox_lib/blob/master/resource/init.lua

local debug_getinfo = debug.getinfo

_ENV.mst = setmetatable({}, {
    __newindex = function(self, name, fn)
        rawset(self, name, fn)

        if debug_getinfo(2, 'S').short_src:find('@mst_lib/handlers') then
            exports(name, fn)
        end
    end
})