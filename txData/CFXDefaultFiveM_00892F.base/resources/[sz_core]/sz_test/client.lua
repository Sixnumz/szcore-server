-- โหลด RageUI
local RageUI = exports['RageUI']:GetRageUI()

local menuOpen = false         -- สถานะว่าเมนูกำลังเปิดหรือไม่
local mainMenu = RageUI.CreateMenu("NPC เมนู", "เลือกการกระทำ") -- สร้างเมนูหลัก
mainMenu.Closed = function()
    menuOpen = false           -- เมื่อปิดเมนูจะตั้งค่าให้เป็น false
end

local markerPos = vector3(-267.0, -960.0, 31.2)
local drawDistance = 10.0
local interactDistance = 1.5

-- Thread สำหรับแสดง marker และเปิดเมนูเมื่อกด E
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local dist = #(playerCoords - markerPos)

        if dist < drawDistance then
            DrawMarker(1, markerPos.x, markerPos.y, markerPos.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.0, 0, 153, 255, 180, false, true, 2, false, nil, nil, false)

            if dist < interactDistance then
                DrawText3D(markerPos.x, markerPos.y, markerPos.z + 1.0, "[E] พูดคุยกับ NPC")

                if IsControlJustPressed(0, 38) then -- ถ้ากด E
                    OpenNpcMenu() -- เปิดเมนู
                end
            end
        end
    end
end)

-- Thread แสดงเมนูด้วย RageUI
function OpenNpcMenu()
    if menuOpen then return end
    menuOpen = true

    RageUI.Visible(mainMenu, true) -- เปิดเมนู

    Citizen.CreateThread(function()
        while menuOpen do
            RageUI.IsVisible(mainMenu, function()

                RageUI.Button("🗣️ ทักทาย", nil, {}, true, {
                    onSelected = function()
                        TriggerEvent('chat:addMessage', {
                            args = {"^5[NPC]", "ยินดีที่ได้รู้จัก!"}
                        })
                    end
                })

                RageUI.Button("🎁 ให้ของ", "ให้ของลับ...", {}, true, {
                    onSelected = function()
                        TriggerServerEvent("sz_test:giveItem") -- เรียกฝั่ง server
                    end
                })

                RageUI.Button("🧭 เทเลพอร์ต", "ย้ายไปยังจุดลับ", {}, true, {
                    onSelected = function()
                        SetEntityCoords(PlayerPedId(), 200.0, -920.0, 30.7)
                    end
                })

            end)
            Wait(1)
        end
    end)
end

-- แสดงข้อความ 3 มิติ
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
