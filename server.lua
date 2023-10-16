-- Dependecis
local QBCore = exports['qb-core']:GetCoreObject()
-- RegisterNetEvent
RegisterServerEvent("createWeedPlotEvent")
RegisterServerEvent("removeWeedPlotEvent")

-- Register Commands
RegisterCommand("createweedplot", function()
    return TriggerClientEvent("createWeedPlotEvent", -1);
end)

RegisterCommand("removeweedplot", function()
    return TriggerClientEvent("removeWeedPlotEvent", -1);
end)

