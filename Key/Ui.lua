local key = loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasggk/99Nights/main/Key/GerKey.lua"))()
local getKeyLink = "https://lucasggk.github.io/99Nights/"
local exec = "https://raw.githubusercontent.com/Lucasggk/99Nights/main/Loader.lua"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local filePath = "LastValidKey.txt"

local function isKeyValid(k)
	if typeof(key) == "function" then
		return key(k)
	else
		return k == key
	end
end

local function readLastKey()
	if isfile and isfile(filePath) then
		return readfile(filePath)
	end
	return nil
end

local function saveLastKey(k)
	if writefile then
		writefile(filePath, k)
	end
end

local lastKey = readLastKey()
if lastKey and isKeyValid(lastKey) then
	loadstring(game:HttpGet(exec))()
	return
end

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "KeySystemUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 350, 0, 230)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -115)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "🔐 Sistema de Key"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

local GetKey = Instance.new("TextButton", MainFrame)
GetKey.Size = UDim2.new(1, -40, 0, 30)
GetKey.Position = UDim2.new(0, 20, 0, 40)
GetKey.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
GetKey.Text = "📋 Get Key"
GetKey.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKey.Font = Enum.Font.Gotham
GetKey.TextSize = 15
Instance.new("UICorner", GetKey).CornerRadius = UDim.new(0, 8)

local InputBox = Instance.new("TextBox", MainFrame)
InputBox.PlaceholderText = "Cole sua key aqui..."
InputBox.Size = UDim2.new(1, -40, 0, 40)
InputBox.Position = UDim2.new(0, 20, 0, 80)
InputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InputBox.BorderSizePixel = 0
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.TextSize = 16
InputBox.Font = Enum.Font.Gotham
Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 8)

local Submit = Instance.new("TextButton", MainFrame)
Submit.Size = UDim2.new(0.5, -25, 0, 35)
Submit.Position = UDim2.new(0.5, 5, 0, 140)
Submit.BackgroundColor3 = Color3.fromRGB(80, 170, 90)
Submit.Text = "Verificar"
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 16
Instance.new("UICorner", Submit).CornerRadius = UDim.new(0, 8)

local Decline = Instance.new("TextButton", MainFrame)
Decline.Size = UDim2.new(0.5, -25, 0, 35)
Decline.Position = UDim2.new(0, 20, 0, 140)
Decline.BackgroundColor3 = Color3.fromRGB(180, 70, 70)
Decline.Text = "Sair"
Decline.TextColor3 = Color3.fromRGB(255, 255, 255)
Decline.Font = Enum.Font.GothamBold
Decline.TextSize = 16
Instance.new("UICorner", Decline).CornerRadius = UDim.new(0, 8)

local function CheckKey()
	local userKey = InputBox.Text
	local isValid = isKeyValid(userKey)
	if isValid then
		saveLastKey(userKey)
		ScreenGui:Destroy()
		loadstring(game:HttpGet(exec))()
	else
		InputBox.Text = ""
		InputBox.PlaceholderText = "Key inválida!"
	end
end

Submit.MouseButton1Click:Connect(CheckKey)
Decline.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

GetKey.MouseButton1Click:Connect(function()
	setclipboard(getKeyLink)
	GetKey.Text = "Copiado ✔"
	task.wait(1)
	GetKey.Text = "📋 Get Key"
end)
