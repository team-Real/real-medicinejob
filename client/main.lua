local m = Real.Settings.marker
local d = Real.Settings.drawTxt

local blip = nil
local npc = nil
local oldTarget = nil
local Delivery = false
local salary = 0
local sellingInProgress = false

Citizen.CreateThread(function ()
    while true do
        local ply = PlayerPedId()
        local pCoord = GetEntityCoords(ply)
        local sleep = 1000

        for k, v in pairs(Real.Company.coords) do
            local dst = #(pCoord - v)

            if dst < 10.0 then
                sleep = 10

                if dst < 5.0 then
                    if m.toggle then
                        DrawMarker(m.type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, m.scale.x, m.scale.y, m.scale.z, m.color.r, m.color.g, m.color.b, m.color.a, m.upAndDown, m.faceCamera, 2, m.rotate, nil, nil)
                    end

                    if dst < 2.5 then
                        if d.toggle then
                            if Delivery then
                                DrawText3D(v.x, v.y, v.z, _U('press_to_stop'))
                            else
                                DrawText3D(v.x, v.y, v.z, _U('press_to_start'))
                            end
                        end

                        if IsControlJustReleased(0, Real.Settings.Key) then
                            if Delivery then
                                Delivery = false
                                TriggerEvent('real-medicinejob:giveMoney', salary)
                                exports['mythic_notify']:SendAlert('inform', _U('stopped', salary))
                                salary = 0
                            else
                                Delivery = true
                                SetNewRoute()
                            end
                        end
                    end
                end
            end
        end

        if Delivery then
            local dst = #(pCoord - vector3(oldTarget.x, oldTarget.y, oldTarget.z))

            if dst < 10.0 then
                sleep = 10

                if dst < 5.0 then
                    if m.toggle then
                        DrawMarker(m.type, oldTarget.x, oldTarget.y, oldTarget.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, m.scale.x, m.scale.y, m.scale.z, m.color.r, m.color.g, m.color.b, m.color.a, m.upAndDown, m.faceCamera, 2, m.rotate, nil, nil)
                    end

                    if dst < 2.5 then
                        if d.toggle then
                            DrawText3D(oldTarget.x, oldTarget.y, oldTarget.z, _U('press_to_sell'))
                        end

                        if IsControlJustReleased(0, Real.Settings.Key) and not sellingInProgress then
                            sellingInProgress = true
                            exports['mythic_progbar']:Progress({
                                name = "selling_item",
                                duration = 5000,
                                label = _U('talking_with_customer'),
                                useWhileDead = true,
                                canCancel = true,
                                controlDisables = {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                },
                                animation = {
                                    animDict = "mp_common",
                                    anim = "givetake1_a",
                                    flags = 17,
                                }
                            }, function(cancelled)
                                if not cancelled then
                                    SetNewRoute()
                                    ClearPedTasks(PlayerPedId())
                                    TriggerServerEvent('real-medicinejob:sellItem')
                                    salary = salary + math.random(Real.Settings.minSalaryIncrease, Real.Settings.maxSalaryIncrease)
                                    sellingInProgress = false
                                end
                            end)
                        elseif IsControlJustReleased(0, Real.Settings.Key) and sellingInProgress then
                            exports['mythic_notify']:DoHudText('inform', _U('selling_already'))
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function ()
    for k, v in pairs(Real.Company.coords) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)

        SetBlipSprite(blip, 51)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.75)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(_U('company_title'))
        EndTextCommandSetBlipName(blip)
    end
end)

function DrawText3D(x, y, z, text)
	SetTextScale(d.scale[1], d.scale[2])
    SetTextFont(d.font)
    SetTextProportional(d.proportional)
    SetTextColour(d.color.r, d.color.g, d.color.b, d.color.a)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 425
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 125)
    ClearDrawOrigin()
end

function SetNewRoute()
    local target = Real.Customers[math.random(1, #Real.Customers)]

    if target ~= nil then
        if target ~= oldTarget then
            exports["mythic_notify"]:DoHudText('inform', _U('starting'))
            Wait(5000)

            exports["mythic_notify"]:DoHudText('inform', _U('started'))
            oldTarget = target

            if not Delivery then
                Delivery = true
            end

            if blip ~= nil then
                RemoveBlip(blip)
            end

            SetNewWaypoint(oldTarget.x, oldTarget.y)
            AddBlip(oldTarget)
            if npc then
                DeletePed(npc)
                npc = nil
            end
            CreateNPC(oldTarget, oldTarget.y)
        else
            SetNewRoute()
        end
    end
end

function AddBlip(coords)
    blip = AddBlipForCoord(coords.x, coords.y, coords.z)

    SetBlipSprite(blip, 514)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.75)
    SetBlipColour(blip, 3)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(_U('company_title'))
    EndTextCommandSetBlipName(blip)
end

function CreateNPC(coords, heading)
    local model = Real.peds[math.random(1, #Real.peds)]

    RequestModel(GetHashKey(model))

    while not HasModelLoaded(GetHashKey(model)) do
        Citizen.Wait(1)
    end

    ClearAreaOfPeds(coords, 5.0, 1)

    npc = CreatePed(1, GetHashKey(model), coords.x, coords.y, coords.z - 1.0, heading, false, true)
    SetPedCombatAttributes(npc, 46, true)
    SetPedFleeAttributes(npc, 0, 0)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetEntityAsMissionEntity(npc, true, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetPedDefaultComponentVariation(npc)
    playAnim(npc, Real.anims[math.random(1, #Real.anims)].dict, Real.anims[math.random(1, #Real.anims)].anim, -1, 1)
end

function playAnim(target, animDict, animName, duration, flag)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(target, animDict, animName, 1.0, -1.0, duration, flag, 1, false, false, false)
	RemoveAnimDict(animDict)
end
