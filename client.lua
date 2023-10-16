-- Dependesies
local QBCore = exports['qb-core']:GetCoreObject()
local QBTarget = exports[Config.Target];

-- RegisterNetEvent


-- Variables
local weedPlots = {}

-- Functions
local function loadModel()
    if not HasModelLoaded(Config.WeedPlant.ObjetHash) then
        RequestModel(Config.WeedPlant.ObjetHash)
        while not HasModelLoaded(Config.WeedPlant.ObjetHash) do
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

local function createWeedPlant(datae)
    loadModel();
    local weedPlant = CreateObjectNoOffset(table.unpack(datae));
    if weedPlant == 0 then return end;

    return weedPlant;
end

local function createWeedPlot()
    local weedPlot = {};
    local location = Config.WeedPlotData.Location;
    local result;

    loadModel();
    for i = 1, Config.WeedPlotData.Size, 1 do
        local weedPlant = CreateObjectNoOffset(Config.WeedPlant.ObjetHash, vector3(location.x, location.y - i, location.z), false);
        table.insert(weedPlot, weedPlant);
    end
    if not checkIfPlantCreated(weedPlot) then
        for k, v in pairs(weedPlot) do
            if v ~= 0 then DeleteObject(v) end
        end
        print("WeedPlotFailed")
        return;
    end

    print("WeedPlotCreated")
    table.insert(weedPlots, weedPlot);
    return;
end


-- Handel Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    return createWeedPlot();
end)


AddEventHandler("plukkweed", function()
    print("plukkweedEventTriggerd")
end);

-- Play Gound
--[[ local weedPlant = CreateObjectNoOffset(modelHash,vector3(Config.WeedPlotData.Location.x, Config.WeedPlotData.Location.y, Config.WeedPlotData.Location.z), true);
local weedPlantCords = vector3(Config.WeedPlotData.Location.x, Config.WeedPlotData.Location.y, Config.WeedPlotData.Location.z);

exports[Config.Target]:AddBoxZone("WeedPlant", weedPlantCords, 
    { name="WeedPlant", heading = 3.68, debugPoly = false, minZ = 110.0, maxZ = 116.0 }, 
    { options = { {  event = "angel_drugs:client:plukkweed", icon = "fas fa-box", label = "Plukk weed",}, },  distance = 2.0 }) ]]