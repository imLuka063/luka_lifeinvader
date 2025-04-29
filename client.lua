ESX = exports["es_extended"]:getSharedObject()

local lifeCoords = vector3(-1081.7017, -248.0774, 37.7633)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - lifeCoords)
        if distance <= 10.0 then
            DrawMarker(21, lifeCoords.x, lifeCoords.y, lifeCoords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 128, 0, 128, 200, false, false, 2, false, nil, nil, false)
            if distance <= 2.0 then
                ESX.ShowHelpNotification("um den Lifeinvader zu öffnen")
                if IsControlJustPressed(1, 38) then
                    openLife()
                end
            end
        end
        
    end
end)

function openLife()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openLife"
    }) 
end

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "closeLife"
    })
    cb('ok')
end)

RegisterNUICallback('leer', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "closeLife"
    })
    cb('ok')
    ESX.ShowNotification('Deine Eingabe war leer!')
    cb('ok')
end)

RegisterNUICallback('over100', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "closeLife"
    })
    cb('ok')
    ESX.ShowNotification('Du hast zu viele Zeichen benutzt!')
    cb('ok')
end)

RegisterNUICallback('announce', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "closeLife"
    })
    cb('ok')


    
    local playerName = data.player
    local message = data.message
    local isAnonym = data.isAnonym -- Der Status der "Anonym"-Checkbox

    -- Hier kannst du entscheiden, was mit dem Anonym-Status passiert
    if isAnonym then
        mauriceleckteier = true -- Wenn Anonym aktiviert, dann den Namen auf "Anonym" setzen
    end

    -- Jetzt Server Event triggern
    TriggerServerEvent('lukalife:announceToAll', playerName, message, mauriceleckteier)

    cb('ok')
end)




RegisterNetEvent('lukalife:showAnnounce')
AddEventHandler('lukalife:showAnnounce', function(name, message, mauriceleckteier)

    local fullMessage
    if mauriceleckteier == true then
        fullMessage = "Annonym : " .. message
    else
        fullMessage = name .. ": " .. message
    end
    SendNUIMessage({
        type = "showAnnounce",
        message = fullMessage
    })
end)


RegisterNetEvent('lukalife:closeEvent')
AddEventHandler('lukalife:closeEvent', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "closeLife"
    })
    -- Kein cb('ok') hier!
end)
