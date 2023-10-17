-- Dependecis
local QBCore = exports['qb-core']:GetCoreObject()
-- Variables

-- RegisterNetEvent
RegisterNetEvent('my_custom_event')
--Handle Events


AddEventHandler('my_custom_event', function()
    print('Received data from client: ')
    -- Process the data received from the client
end)
