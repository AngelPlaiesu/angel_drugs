-- Dependecis
local QBCore = exports['qb-core']:GetCoreObject()

-- RegisterNetEvent
RegisterNetEvent("createWeedPlotEvent");
RegisterNetEvent("removeWeedPlotEvent");

-- Variables
local modelHash = GetHashKey ("prop_weed_01")
local weedPlots = {}
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
    local location = Config.WeedPlotData.Location;
    local result;

    loadModel();
    for i = 1, Config.WeedPlotData.Size, 1 do
        local weedPlant = CreateObjectNoOffset(modelHash, vector3(location.x, location.y - i, location.z), false);
        table.insert(weedPlot, weedPlant);
    end
    if not checkIfPlantCreated(weedPlot) then
        for k,v in pairs(weedPlot) do
            if v ~= 0 then DeleteObject(v) end
        end
        print("WeedPlotFailed")
        return;
    end

    print("WeedPlotCreated")
    table.insert(weedPlots, weedPlot);
    return;
end

local function removeWeedPlots()
    for k,plot in pairs(weedPlots) do
        for k,plant in pairs(plot) do
            if plant then DeleteObject(plant) end
        end
    end
end


-- Handel Events
AddEventHandler("createWeedPlotEvent", function() 
    return createWeedPlot();
end);

AddEventHandler("removeWeedPlotEvent", function() 
    return removeWeedPlots();
end);