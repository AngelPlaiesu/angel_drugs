-- Dependesies
local QBCore = exports['qb-core']:GetCoreObject()
local QBTarget = exports['qtarget'];

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

local function createWeedBoxZone(weedPlant, weedPlantCords)
    local WeedPlantIDString = json.encode(WeedPlant);

    local WeedAddBoxZoneCords = vector3(weedPlantCords.x, weedPlantCords.y, weedPlantCords.z) + vector3(0, 0, 1)

    local WeedAddBoxZone = exports['qtarget']:AddBoxZone("WeedBox-" .. WeedPlantIDString, WeedAddBoxZoneCords, 1, 1, {
            name = "WeedBox-" .. WeedPlantIDString,
            heading = 11.0,
            debugPoly = true,
            minZ = weedPlantCords.z,
            maxZ = weedPlantCords.z + 2,
        },
        {
            options = {
                {
                    type = "client",
                    event = "angel_drugs:weedPickUp",
                    icon = "fas fa-hand-holding-water",
                    label = "Test2",
                },
            },
            distance = 2.0,
        })

    return WeedAddBoxZone
end

local function createWeedPlant(plantData)
    local weedPlatCords = vector3(plantData.x, plantData.y, plantData.z)
    local weedPlant = CreateObjectNoOffset(plantData.ObjectHash, weedPlatCords, false);
    if weedPlant == 0 then
        print("WeedPlantFailed")
        return false
    end
    local BoxZone = createWeedBoxZone(WeedPlant, weedPlatCords);
    return weedPlant;
end

local function deleteWeedPlot(weedPlot)
    for k, v in pairs(weedPlot) do
        if v ~= 0 then DeleteObject(v) end
    end
    print("WeedPlotDeleted")
    return true;
end

local function createWeedPlot(plotLocation)
    local weedPlot = {};
    local PlantData = {
        x = plotLocation.x,
        y = plotLocation.y,
        z = plotLocation.z,
        ObjectHash = Config.WeedPlant.ObjectHash
    };
    for i = 1, Config.WeedPlotData.Size, 1 do
        PlantData.y = PlantData.y - 1;
        local weedPlant = createWeedPlant(PlantData);
        if weedPlant then weedPlot[#weedPlot + 1] = weedPlant else return false end;
    end
    if not checkIfPlantCreated(weedPlot) then
        deleteWeedPlot(weedPlot)
        print("WeedPlotFailed")
        return false;
    end

    return weedPlot;
end

local function createWeedPlots()
    for k, plot in pairs(Config.WeedPlotData.Locations) do
        local weedPlot = createWeedPlot(plot)
        if not createWeedPlot(plot) then
            return false
        else
            weedPlots[#weedPlots + 1] = weedPlot
        end
    end

    return true
end

local function callback()

end
-- Handel Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    if createWeedPlots() then print("WeedPlotCreated") else print("Failed") end;
end)

AddEventHandler("angel_drugs:weedPickUp", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.money.cash > Config.Weed.Price then
        QBCore.Functions.Progressbar('WeedPickUp', 'Collecting Weed', 2000, false, true, {

            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = false
            }, {}, {}, {}, function()
                TriggerServerEvent('angel_drugs:WeedPickUp:Server',PlayerData.source)
            end, function()
                return -- progres fails
        end)

    end

end)

