local webhook = "https://discord.com/api/webhooks/1360563935505551447/Ad989pkVUaLfWSZsyZIEK_nZXuKmbIqJsxHSyKgq5iCMF0kN7s3VJQWRMBYiNekcv42N" -- แก้ให้เป็นของคุณ

RegisterServerEvent("sz_reports:sendReportToDiscord")
AddEventHandler("sz_reports:sendReportToDiscord", function(message)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName = xPlayer.getName()

    -- สร้าง Embed
    local data = {
        embeds = {{
            title = "รายงานจากผู้เล่น",
            description = "**ชื่อ:** " .. playerName .. "\n**ข้อความ:** " .. message,
            color = 16711680, -- แดง
            footer = { text = "ระบบแจ้งปัญหา | ZxCore" }
        }}
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, "POST", json.encode(data), {
        ["Content-Type"] = "application/json"
    })

    -- แจ้งกลับ Client
    TriggerClientEvent("my_script:reportStatus", source, "ส่งรายงานสำเร็จ ขอบคุณที่แจ้งปัญหา!")
end)
