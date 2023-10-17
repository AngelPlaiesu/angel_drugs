-- Dependecis
local QBCore = exports['qb-core']:GetCoreObject()
-- Variables

-- RegisterNetEvent
RegisterServerEvent('angel_drugs:WeedPickUp:Server')
--Handle Events
local function pickUpWeed(playerscr)
        local Player = QBCore.Functions.GetPlayer(playerscr)
        local PlayerData = Player.PlayerData;
        if PlayerData.money.cash > Config.Weed.Price then
            Player.Functions.RemoveMoney('cash', Config.Weed.Price)
            Player.Functions.AddItem(Config.Weed.item, 1)
            TriggerClientEvent('qb-inventory:client:ItemBox', playerscr, QBCore.Shared.Items[Config.Weed.item], 'add')
        end

        return;
end

AddEventHandler('angel_drugs:WeedPickUp:Server', function(playerscr)
    if (playerscr <= 0) then return end
    return pickUpWeed(playerscr);
end)