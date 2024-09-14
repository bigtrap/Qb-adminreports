local reportType = nil

RegisterCommand('report', function()
    exports['qb-menu']:openMenu({
        {
            header = "Report System",
            isMenuHeader = true
        },
        {
            header = "Admin Report",
            txt = "Report an issue with an admin",
            params = {
                event = "report:openBox",
                args = { type = 'admin' }
            }
        },
        {
            header = "Staff Report",
            txt = "Report an issue with staff",
            params = {
                event = "report:openBox",
                args = { type = 'staff' }
            }
        },
        {
            header = "City Report",
            txt = "Report an issue within the city",
            params = {
                event = "report:openBox",
                args = { type = 'city' }
            }
        },
    })
end, false)

RegisterNetEvent('report:openBox')
AddEventHandler('report:openBox', function(data)
    reportType = data.type
    local dialog = exports['qb-input']:ShowInput({
        header = 'Submit a Report',
        submitText = 'Send Report',
        inputs = {
            {
                text = 'Describe your issue', -- Input description
                name = 'message', -- Variable name
                type = 'text', -- Input type (text, number, etc)
                isRequired = true -- Mandatory field
            }
        }
    })

    if dialog ~= nil then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        TriggerServerEvent('report:send', reportType, dialog.message, coords)
    end
end)

RegisterNetEvent('report:notify')
AddEventHandler('report:notify', function()
    -- Default QBcore Notification
    TriggerEvent('QBCore:Notify', 'Report Sent! An admin will contact you soon.', 'success')

    -- If using ps-ui notifications, uncomment the line below:
    -- exports['ps-ui']:Notify("Report Sent! An admin will contact you soon.", "success", 5000)
end)

