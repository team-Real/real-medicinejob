ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('real-medicinejob:sellItem')
AddEventHandler('real-medicinejob:sellItem', function ()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local money = math.random(Real.Settings.minSellPrice, Real.Settings.maxSellPrice)

    xPlayer.addAccountMoney('money', money)
    TriggerClientEvent('esx:showNotification', source, _U('selled', money))
end)

RegisterServerEvent('real-medicinejob:giveMoney')
AddEventHandler('real-medicinejob:giveMoney', function (money)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    xPlayer.addAccountMoney('money', money)
end)