ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('lukalife:announceToAll')
AddEventHandler('lukalife:announceToAll', function(playerName, message, mauriceleckteier)
    local source = source -- 'source' is already local within the event handler
    local xPlayer = ESX.GetPlayerFromId(source) -- Assuming you're using ESX
    if xPlayer then
        local name = xPlayer:getName() -- Correct way to call the method
        -- Server sendet an ALLE Spieler
        TriggerClientEvent('lukalife:showAnnounce', -1, name, message, mauriceleckteier)

        local webhook = "https://discord.com/api/webhooks/1366500873903276052/_Kjdzti7tjZ1NUsDe7H6NW1H0oqfiYgjgVePgiKf-X5vxqBaw8_FWfKFM2pn6uECEE-_"
        local formattedMessage = 'Der Spieler ** ' .. name  .. ' ** hat bei Lifeinvader geschalten ** ' .. message .. '**'
        SendWebhookMessage(webhook, formattedMessage)
        local account = 'bank'
        local money = 500
        xPlayer.removeAccountMoney(account, money)
    end
end)

function SendWebhookMessage(webhook, message)
    if webhook ~= "false" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
            embeds = {{
                title = "**Lifeinvader**",
                description = message,
                color = tonumber("822fac", 16),
                footer = {
                    text = "Coded by Luka"
                }
            }}
        }), { ['Content-Type'] = 'application/json' })
    end
end