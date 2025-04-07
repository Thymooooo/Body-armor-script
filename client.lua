RegisterCommand('vest', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    
    exports['progressBars']:startUI(Config.Vest.duration, "Vest aantrekken")
    
    DisableAllControlActions(0)
    
    RequestAnimDict("clothingtie")
    while not HasAnimDictLoaded("clothingtie") do
        Citizen.Wait(100)
    end
    TaskPlayAnim(playerPed, "clothingtie", "try_tie_positive_a", 8.0, -8.0, Config.Vest.duration, 49, 0, false, false, false)
    
    Citizen.Wait(Config.Vest.duration)
    
    SetPedComponentVariation(playerPed, 9, Config.Vest.drawable, Config.Vest.texture, 0)
    
    SetPedArmour(playerPed, Config.Vest.armorAmount)
    print(SetPedArmour)
    
    EnableAllControlActions(0)
    
    ClearPedTasks(playerPed)
    
    if Config.Vest.notification then
        TriggerEvent('chat:addMessage', {
            color = {0, 255, 0},
            multiline = true,
            args = {"[SYSTEEM]", "Je hebt je vest aangetrokken!"}
        })
    end
end, false)

RegisterCommand(Config.RemoveVest.commandName, function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    
    exports['progressBars']:startUI(Config.Vest.duration2, "Vest uittrekken!")
    
    DisableAllControlActions(0)

    TaskPlayAnim(playerPed, "clothingtie", "try_tie_positive_a", 8.0, -8.0, Config.Vest.duration2, 49, 0, false, false, false)

    SetPedComponentVariation(playerPed, 9, 0, 0, 0)
    
    SetPedArmour(playerPed, 0)
    print(SetPedArmour)
    
    if Config.RemoveVest.notification then
        TriggerEvent('chat:addMessage', {
            color = {0, 255, 0},
            multiline = true,
            args = {"[SYSTEEM]", "Je hebt je vest uitgetrokken!"}
        })
    end
end, false)

TriggerEvent('chat:addSuggestion', '/vest', 'Om zwaar vest aan te trekken')
TriggerEvent('chat:addSuggestion', '/' .. Config.RemoveVest.commandName, 'Om vest te verwijderen')
print(TriggerEvent)
