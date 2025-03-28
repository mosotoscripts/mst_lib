---@meta
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright (c) 2025 Linden <https://githom/thelindat/fivem>
]]

local debug_getinfo = debug.getinfo

_ENV.mst = setmetatable({}, {
    __newindex = function(self, name, fn)
        rawset(self, name, fn)

        if debug_getinfo(2, 'S').short_src:find('@mst_lib/handlers') then
            exports(name, fn)
        end
    end
})