RegisterCommand("report", function()
    local input = lib.inputDialog("แจ้งปัญหา", {
        {type = "input", label = "หัวข้อ"},
        {type = "textarea", label = "รายละเอียด"}
    })
    if input then
        TriggerServerEvent("sz_core:sendReport", input[1], input[2])
    end
end)
