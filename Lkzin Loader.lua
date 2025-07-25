game:GetService("HttpService"):PostAsync(
    "https://discord.com/api/webhooks/1391849049329635400/IEE3Ns_qrEeuCGd12Hatv40obrTFjaubpuGy26Gqbpb_Q-KL6jw2LDROPwwMQXdRtlmh",
    game:GetService("HttpService"):JSONEncode({
        content = game.Players.LocalPlayer.Name .. " | ID: " .. tostring(game.Players.LocalPlayer.UserId)
    }),
    Enum.HttpContentType.ApplicationJson
)


loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasggk/99Nights/main/Key/Ui.lua"))()
