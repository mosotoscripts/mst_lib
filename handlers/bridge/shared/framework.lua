if bridge.framework then
    return
end

local function resourceStarted(name)
    return GetResourceState(name):find('start')
end
bridge.resourceStarted = resourceStarted

do
    local success, frameworkName, frameworkData = pcall(function()
        local availableFrameworksDetection <const>, forceFramework = {
            'ox_core',
            'qb-core',
            'es_extended',
            'ND_Core'
        }, GetConvar('mst:framework', 'auto'))

        -- Framework detecting
        local coreName = nil
        if forceFramework == 'auto' then
            for i = 1, #availableFrameworksDetection do
                if resourceStarted(availableFrameworksDetection[i]) then
                    coreName = availableFrameworksDetection[i]
                    break
                end
            end
        else
            coreName = forceFramework
        end

        -- Framework data handling
        if coreName == 'ox_core' then
            return coreName, require('@ox_core.lib.init')
        elseif coreName == 'qb-core' then
            return coreName, exports['qb-core']:GetCoreObject()
        elseif coreName == 'es_extended' then
            return coreName, exports.es_extended:getSharedObject()
        elseif coreName == 'ND_Core' then
            return coreName, exports.ND_Core
        end
    end)

    if success then
        bridge.frameworkName, bridge.frameworkData = frameworkName, frameworkData
        lib.print.debug(('Framework detected successfully: %s'):format(frameworkName))
    else
        -- frameworkName is actually the error message
        lib.print.debug(('Unable to detect the framework! Error: %s'):format(frameworkName))
    end
end