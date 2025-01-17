ESX = exports["es_extended"]:getSharedObject()

local function GetCashFromInventory()
    local cash = 0

    if exports.ox_inventory then
        local inventory = exports.ox_inventory:Search('count', 'money') -- Name of your item : 'money, cash, ...'
        cash = inventory or 0
    end

    return cash
end

-- Fonction pour mettre à jour le HUD
local function UpdateHUD()
    local playerData = ESX.GetPlayerData()

    local cash = GetCashFromInventory()
    local bank = 0
    local job = "Sans Emploi"
    local jobGrade = "Aucun"

    if playerData ~= nil then
        if playerData.accounts then
            for _, account in ipairs(playerData.accounts) do
                if account.name == 'bank' then
                    bank = account.money
                end
            end
        end

        if playerData.job then
            if playerData.job.label then
                job = playerData.job.label
            end

            if playerData.job.grade_label then
                jobGrade = playerData.job.grade_label
            end
        end
    end

    SendNUIMessage({
        type = 'updateHUD',
        cash = cash,
        bank = bank,
        job = job,
        jobGrade = jobGrade
    })
end

CreateThread(function()
    while true do
        UpdateHUD()
        Citizen.Wait(1000)
    end
end)
