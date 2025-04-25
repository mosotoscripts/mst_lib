if lib.context == 'server' then
    function bridge.notify(src, ...)
        TriggerClientEvent('mst_bridge:notify', src, ...)
    end

    return
end

local notify = GetConvar('mst:notify', 'ox_lib')
function bridge.notify(msg, _type)
    if msg and _type then
        if notify == 'ox_lib' then
            lib.notify({
                description = msg,
                type = _type
            })
        end
    else
        lib.print.warn(('[Bridge] Notification parameter missmatch msg: %s, nType: %s'):format(msg, _type))
    end
end
RegisterNetEvent('mst_bridge:notify', bridge.notify)