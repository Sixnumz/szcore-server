RegisterServerEvent("sz_core:sendReport")
AddEventHandler("sz_core:sendReport", function(subject, details)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local message = {
        username = Config.ServerName .. " | รายงานผู้เล่น",
        embeds = {
            {
                title = "📢 แจ้งรายงาน",
                color = 16711680,
                fields = {
                    {name = "👤 ผู้เล่น", value = xPlayer.getName(), inline = true},
                    {name = "📝 หัวข้อ", value = subject, inline = true},
                    {name = "📄 รายละเอียด", value = details, inline = false}
                },
                footer = {
                    text = os.date("%X")
                }
            }
        }
    }
    PerformHttpRequest(Config.ReportWebhook, function() end, 'POST', json.encode(message), {['Content-Type'] = 'application/json'})
end)