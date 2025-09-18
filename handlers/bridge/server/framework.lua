local frameworkName, frameworkData = bridge.frameworkName, bridge.frameworkData

function bridge.getPlayer(src)
    if frameworkData then
        if frameworkName == 'ox_core' then
            return frameworkData.GetPlayer(src)
        elseif frameworkName == 'qb-core' then
            return frameworkData.Functions.GetPlayer(src)
        elseif frameworkName == 'es_extended' then
            return frameworkData.GetPlayerFromId(src)
        elseif frameworkName == 'ND_Core' then
            return frameworkData:getPlayer(src)
        end
    else
        lib.print.error(('Framework data is not available for %s'):format(frameworkName))
    end
end