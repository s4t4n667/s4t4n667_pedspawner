local config = require('config')

local function spawnPeds()
    for _, pedConfig in ipairs(config.ped) do
        lib.requestModel(pedConfig.model)
        while not HasModelLoaded(pedConfig.model) do
            Wait(50)
        end
        local ped = CreatePed(28, pedConfig.model, pedConfig.coords.x, pedConfig.coords.y, pedConfig.coords.z - 1, pedConfig.coords.w, false, false)
        while not DoesEntityExist(ped) do
            Wait(50)
        end
        SetEntityVisible(ped, true, false)
        SetEntityAlpha(ped, 255, false)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetPedCanBeTargetted(ped, false)
        SetBlockingOfNonTemporaryEvents(ped, true)
        if pedConfig.animation then
            RequestAnimDict(pedConfig.animation.dict)
            while not HasAnimDictLoaded(pedConfig.animation.dict) do
                Wait(50)
            end
            TaskPlayAnim(ped, pedConfig.animation.dict, pedConfig.animation.name, 8.0, -8.0, -1, 1, 0, false, false, false)
        elseif pedConfig.scenario then
            TaskStartScenarioInPlace(ped, pedConfig.scenario, 0.0, true)
        end
        SetModelAsNoLongerNeeded(pedConfig.model)
    end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    spawnPeds()
end)

RegisterNetEvent('esx:playerLoaded', function()
    spawnPeds()
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        spawnPeds()
    end
end)