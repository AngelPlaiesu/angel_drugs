-- Dependecis
local QBCore = exports['qb-core']:GetCoreObject()

-- RegisterNetEvent
RegisterNetEvent("createWeedPlotEvent");

-- Variables
local modelHash = GetHashKey ("prop_weed_01")

-- Functions
local function loadModel()
    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(1)
        end
    end
end

local function checkIfPlantCreated(WeedPlotTabel)
    for i, crop in ipairs(WeedPlotTabel) do
        if crop == 0 then
            return false
        end
    end
    return true
end

local function createWeedPlot()
    local weedPlot = {};
    local location = Config.WeedPlotLocation;
    loadModel();
    for i = 0, 5, 1 do
        local weedPlant = CreateObjectNoOffset(modelHash, vector3(location.x, location.y - i, location.z), true);
        table.insert(weedPlot, weedPlant);
    end

    local result = checkIfPlantCreated(weedPlot) and "WeedPlotCreated" or "WeedPlotFailed";

    return print("Result: " .. result);
end

-- Handel Events
AddEventHandler("createWeedPlotEvent", function() 
    print("Event Recived");
    return
    --[[ return createWeedPlot(); ]]
end);
