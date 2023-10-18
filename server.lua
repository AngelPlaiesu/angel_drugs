-- Dependecis
local QBCore = exports['qb-core']:GetCoreObject()
-- Variables

-- RegisterNetEvent
RegisterServerEvent('angel_drugs:WeedPickUp:Server')
RegisterServerEvent('angel_drugs:refineWeed:Server')
--Handle Events
local function pickUpWeed(playerscr)
        local Player = QBCore.Functions.GetPlayer(playerscr)
        local PlayerData = Player.PlayerData;
        if PlayerData.money.cash > Config.Weed.Price then
            Player.Functions.RemoveMoney('cash', Config.Weed.Price)
            Player.Functions.AddItem(Config.Weed.item, 1)
        end

        return;
end

local function refienWeed(playerscr)
    local Player = QBCore.Functions.GetPlayer(playerscr)
    local PlayerData = Player.PlayerData;
    if QBCore.Functions.HasItem(Config.Weed.item) then
        --  Player.Functions.RemoveItem(Config.Weed.item, 1)
        Player.Functions.AddItem(Config.Weed.RefinedItem, 5)
    end
    return;
end

AddEventHandler('angel_drugs:WeedPickUp:Server', function(playerscr)
    if (playerscr <= 0) then return end
    return pickUpWeed(playerscr);
end)

AddEventHandler('angel_drugs:refineWeed:Server', function(playerscr)
    if (playerscr <= 0) then return end
    return refienWeed(playerscr);
end)