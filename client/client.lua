local inVehicle = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = PlayerId()
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        
        if Config.AntiFireOnVehicle then
            if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
                inVehicle = true
            else
                inVehicle = false
            end

            if inVehicle then
                -- プレイヤーが車の中にいる場合
                if not IsPlayerDead(player) then
                    SetPlayerCanDoDriveBy(player, false)
                    DisableControlAction(0, 24, true) -- 攻撃ボタンを無効にする
                end
            else
                -- プレイヤーが車の外にいる場合
                if not IsPlayerDead(player) then
                    SetPlayerCanDoDriveBy(player, true)
                    EnableControlAction(0, 24, true) -- 攻撃ボタンを有効にする
                end
            end
        end
    end
end)