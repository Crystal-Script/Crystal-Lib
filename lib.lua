ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

CRYSTAL = {}

function CRYSTAL.gridsystem(params)
    local marker = {
        pos = params.pos,
        rot = params.rot or vector3(90.0, 90.0, 90.0),  -- Imposta la rotazione a valori fissi per evitare il movimento
        scale = params.scale or vector3(1.0, 1.0, 1.0),
        permission = params.permission or ESX.PlayerData.job.name,
        job_grade = params.job_grade or 0,
        textureName = params.textureName or 'marker',  -- Nome della texture nel dizionario
        saltaggio = params.saltaggio or false,
        msg = params.msg or 'Premi [E] per interagire',
        action = params.action,
        key = params.key or 38
    }

    -- Funzione per caricare la texture del marker
    function loadMarkerTexture(dict)
        if not HasStreamedTextureDictLoaded(dict) then
            RequestStreamedTextureDict(dict, false)
            local timeout = 500
            for _ = 1, timeout do
                if HasStreamedTextureDictLoaded(dict) then
                    return dict
                end
                Wait(0)
            end
            print(("ERRORE: TEXTURE NON CARICATA '%s' DOPO %s TEMPO"):format(dict, timeout))
            return nil
        end
        return dict
    end

    function drawMarker(marker)
        local dict = loadMarkerTexture('marker')
        if dict then
            DrawMarker(
                9,
                marker.pos.x, marker.pos.y, marker.pos.z,
                0, 0, 0,
                marker.rot.x, marker.rot.y, marker.rot.z,
                marker.scale.x, marker.scale.y, marker.scale.z,
                255, 255, 255, 255,
                marker.saltaggio,
                true,
                2,
                true,
                dict,
                marker.textureName,
                false
            )
        end
    end

    function isKeyJustPressed(key)
        return IsControlJustReleased(0, key)
    end

    function getPlayerJobAndGrade()
        local playerData = ESX.PlayerData
        local playerJob = playerData.job and playerData.job.name or nil
        local playerJobGrade = playerData.job and playerData.job.grade or 0
        return playerJob, playerJobGrade
    end

    Citizen.CreateThread(function()
        while true do
            Wait(0)

            local playerCoords = GetEntityCoords(PlayerPedId())
            local playerJob, playerJobGrade = getPlayerJobAndGrade()

            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, marker.pos.x, marker.pos.y, marker.pos.z)

            if distance < 20.0 then
                if playerJob == marker.permission and playerJobGrade >= marker.job_grade then
                    drawMarker(marker)

                    if distance < 2.0 then
                        ESX.ShowHelpNotification(params.msg)

                        if isKeyJustPressed(marker.key) then
                            marker.action()
                        end
                    end
                end
            else
                Wait(1000)
            end
        end
    end)
end

exports('CRYSTAL', function ()
    return CRYSTAL
end)
