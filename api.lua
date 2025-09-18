---@meta
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright (c) 2025 Linden <https://githom/thelindat/fivem>
]]

if GetCurrentResourceName() == 'mst_lib' then
    error('Can\'t load mst_lib more than once in the same resource.', 2)
end

if GetResourceState('mst_lib') ~= 'started' then
    error('mst_lib must be started before using it.', 2)
end

local noop = function() end
local export = exports.mst_lib

-- Importing

local LoadResourceFile = LoadResourceFile
local context = IsDuplicityVersion() and 'server' or 'client'

local function loadModule(self, module)
    local dir = ('imports/%s'):format(module)
    local chunk = LoadResourceFile('mst_lib', ('%s/%s.lua'):format(dir, context))
    local shared = LoadResourceFile('mst_lib', ('%s/shared.lua'):format(dir))

    if shared then
        chunk = (chunk and ('%s\n%s'):format(shared, chunk)) or shared
    end

    if chunk then
        local fn, err = load(chunk, ('@@mst_lib/imports/%s/%s.lua'):format(module, context))

        if not fn or err then
            if shared then
                fn, err = load(shared, ('@@mst_lib/imports/%s/shared.lua'):format(module))
            end

            if not fn or err then
                return error(('\n^1Error importing module (%s): %s^0'):format(dir, err), 3)
            end
        end

        local result = fn()
        self[module] = result or noop
        return self[module]
    end
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