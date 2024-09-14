-- Load config.lua using LoadResourceFile and load
local configFile = LoadResourceFile(GetCurrentResourceName(), "config.lua")
assert(load(configFile))()

-- Register event for sending a report
RegisterNetEvent('report:send')
AddEventHandler('report:send', function(reportType, message, coords)
    local src = source
    local playerName = GetPlayerName(src)
    local x, y, z = table.unpack(coords)

    -- Format the message
    local reportMessage = string.format("**Report Type:** %s\n**Player:** %s\n**Location:** X: %.2f, Y: %.2f, Z: %.2f\n**Message:** %s", 
        reportType, playerName, x, y, z, message)

    -- Send to Discord
    sendToDiscord(reportType, reportMessage, Config.DiscordWebhook)

    -- Notify player
    TriggerClientEvent('report:notify', src)
end)

-- Function to send the report to Discord
function sendToDiscord(type, message, webhookURL)
    local embed = {
        {
            ["color"] = 3447003,
            ["title"] = "**" .. type .. " Report**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Report System",
                ["icon_url"] = Config.DiscordImageURL,
            },
        }
    }

    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({username = Config.ServerName, embeds = embed}), { ['Content-Type'] = 'application/json' })
end
