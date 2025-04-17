RegisterNUICallback("sendReport", function(data, cb)
    local msg = data.message
    TriggerServerEvent("sz_reports:sendReportToDiscord", msg)
    SetNuiFocus(false, false)
    cb("ok")
end)

RegisterNetEvent("sz_reports:reportStatus")
AddEventHandler("sz_reports:reportStatus", function(msg)
    SendNUIMessage({
        type = "reportStatus",
        message = msg
    })
end)

RegisterCommand("report", function()
    SetNuiFocus(true, true)
end)
