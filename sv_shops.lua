Esx = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('wozztv:buycash')
AddEventHandler('wozztv:buycash', function(item, price)
     local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= price then
        xPlayer.addInventoryItem(item, 1) 
        xPlayer.removeMoney(price)
        TriggerClientEvent("esx:showColoredNotification", source, "~g~Vous avez bien effectuer un achat", 18)
    else
        TriggerClientEvent("esx:showColoredNotification", source, "~r~Vous n'avez pas assez d'argent!", 6)
    end
end)

RegisterServerEvent('wozztv:buybanque')
AddEventHandler('wozztv:buybanque', function(item, price)
 	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getAccount('bank').money >= tonumber(price) then 
        xPlayer.addInventoryItem(item, 1) 
        xPlayer.removeAccountMoney('bank', tonumber(price))  
        TriggerClientEvent("esx:showColoredNotification", source, "~g~Vous avez bien effectuer un achat", 18)
    else
        TriggerClientEvent("esx:showColoredNotification", source, "~r~Vous n'avez pas assez d'argent!", 6)
    end
end)