---@meta
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright (c) 2025 Linden <https://githom/thelindat/fivem>
]]

if cache.resource == 'mst_lib' then
    error('Can\'t load mst_lib more than once in the same resource.', 2)
end

if GetResourceState('mst_lib') ~= 'started' then
    error('mst_lib must be started before using it.', 2)
end

local export = exports.mst_lib

-- Importing

local require, context = lib.require, lib.context
local function loadModule(self, mod)
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

    self[mod] = retval or noop
    return self[mod]
end

local function import(self, mod, ...)
    local module = rawget(self, mod)
    if not module then
        self[mod] = noop
        module = loadModule(self, mod)

        if not module then
            local function method(...)
                return export[mod](nil, ...)
            end

            if not ... then
                self[mod] = method
            end

            return method
        end
    end
    return module
end

_ENV.mst = setmetatable({}, {
    __index = import,
    __call = import
})

_ENV.bridge = export.getBridge()