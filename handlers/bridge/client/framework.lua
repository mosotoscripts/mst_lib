local playerUnloaded, playerLoaded, playerJobUpdate = (function()
    if frameworkName == 'ox_core' then
        return 'ox:playerLogout', 'ox:playerLoaded', 'ox:setGroup'
    elseif frameworkName == 'qb-core' then
        return 'QBCore:Client:OnPlayerUnload', 'QBCore:Client:OnPlayerLoaded', 'QBCore:Client:OnJobUpdate'
    elseif frameworkName == 'es_extended' then
        return 'esx:onPlayerLogout', 'esx:playerLoaded', 'esx:setJob'
    elseif frameworkName == 'ND_Core' then
        return 'ND:characterUnloaded', 'ND:characterLoaded', 'ND:updateCharacter'
    end
end)()

bridge.playerUnloaded = playerUnloaded
bridge.playerLoaded = playerLoaded
bridge.playerJobUpdate = playerJobUpdate