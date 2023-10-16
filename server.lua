local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("createWeedPlotEvent")


RegisterCommand("createweedplot", function()
    TriggerClientEvent("createWeedPlotEvent", -1);
    
    return print("Event Sendt");
end)
