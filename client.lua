-- Dependesies
local QBCore = exports['qb-core']:GetCoreObject()
local QBTarget = exports[Config.Target];

-- RegisterNetEvent

-- Variables
local weedPlots = {}

-- Functions
local function checkIfPlantCreated(WeedPlotTabel)
    for i, crop in ipairs(WeedPlotTabel) do
        if crop == 0 then
            return false
        end
    end
    return true
end

local function createWeedPlant(PlantData)
    local weedPlant = CreateObjectNoOffset(PlantData.ObjectHash, vector3(PlantData.x, PlantData.y, PlantData.z), false);
    if weedPlant == 0 then print("WeedPlantFailed") return false end

    return weedPlant;
end

local function deleteWeedPlot(weedPlot)
    for k, v in pairs(weedPlot) do
        if v ~= 0 then DeleteObject(v) end
    end
    print("WeedPlotDeleted")
    return true;
end

local function createWeedPlot()
    local weedPlot = {};
    local PlantData = {
        x = Config.WeedPlotData.Location.x,
        y = Config.WeedPlotData.Location.y,
        z = Config.WeedPlotData.Location.z,
        ObjectHash = Config.WeedPlant.ObjectHash
    };
    for i = 1, Config.WeedPlotData.Size, 1 do
        PlantData.y = PlantData.y - 1;
        local weedPlant = createWeedPlant(PlantData);
        if weedPlant then table.insert(weedPlot, weedPlant) else return false end
    end
    if not checkIfPlantCreated(weedPlot) then
        deleteWeedPlot(weedPlot)
        print("WeedPlotFailed")
        return false;
    end

    table.insert(weedPlots, weedPlot);
    return true;
end

-- Handel Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        if createWeedPlot() then print("WeedPlotCreated") else print("Failed")  end;
end)
-- Play Gound
