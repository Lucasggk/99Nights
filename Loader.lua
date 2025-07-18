repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui") 

loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasggk/BlueLock/refs/heads/main/Fix.name.ui.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasggk/99Nights/main/Bring.lua"))()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "99 Nights In The Forest |",
    SubTitle = "by Lucas",
    TabWidth = 180,
    Size = UDim2.fromOffset(600, 350),
    Acrylic = false,
    Theme = "Dark",
    Center = true,
    IsDraggable = true,
    Keybind = Enum.KeyCode.LeftControl
})

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local decalId = "rbxassetid://122755768466240"

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DraggableImageButtonGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local imageButton = Instance.new("ImageButton")
imageButton.Name = "DraggableButton"
imageButton.Image = decalId
imageButton.Size = UDim2.new(0, 65, 0, 65)
imageButton.AnchorPoint = Vector2.new(0.5, 0.5)
imageButton.Position = UDim2.new(0, 100, 1, -400)
imageButton.BackgroundTransparency = 0
imageButton.AutoButtonColor = false
imageButton.Parent = screenGui

local dragging, dragInput, mousePos, buttonPos = false

imageButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging, mousePos, buttonPos = true, input.Position, imageButton.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

imageButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - mousePos
		imageButton.Position = UDim2.new(
			buttonPos.X.Scale, buttonPos.X.Offset + delta.X,
			buttonPos.Y.Scale, buttonPos.Y.Offset + delta.Y
		)
	end
end)

imageButton.MouseButton1Click:Connect(function()
	Window:Minimize()
end)

local gui = Fluent.GUI
local playerGui = player.PlayerGui

if _G.fluentLoopRunning then
    _G.fluentLoopRunning = _G.fluentLoopRunning + 1
else
    _G.fluentLoopRunning = 1
end
local runId = _G.fluentLoopRunning

task.spawn(function()
    while gui and gui:IsDescendantOf(game) do
        if _G.fluentLoopRunning ~= runId then break end
        task.wait(0.05)
    end
    if _G.fluentLoopRunning == runId then
        local drag = playerGui:FindFirstChild("DraggableImageButtonGui")
        if drag then drag.Enabled = true end
    end
end)

task.spawn(function()
    while true do
        if _G.fluentLoopRunning ~= runId then break end
        if not gui or not gui:IsDescendantOf(game) then
            local drag = playerGui:FindFirstChild("DraggableImageButtonGui")
            if drag then drag:Destroy() end
            break
        end
        local minimized = Fluent and Fluent.Window and Fluent.Window.Minimized
        local drag = playerGui:FindFirstChild("DraggableImageButtonGui")
        if drag then drag.Enabled = minimized end
        task.wait(0.025)
    end
    if _G.fluentLoopRunning == runId then
        local drag = playerGui:FindFirstChild("DraggableImageButtonGui")
        if drag then drag.Enabled = true end
    end
end)










































-- script: tabs
local player = Window:AddTab({ Title = "User", Icon = "user" })
local bring = Window:AddTab({ Title = "Brings", Icon = "" })
local tps = Window:AddTab({ Title = "Teleports", Icon = "" })

-- script: Script 

player:AddSection("WalkSpeed")

player:AddButton({
	Title = "Speed Button",
	Description = "Cria botão que altera a velocidade entre 30 ou 100",
	Callback = function(v)
		local p = game:GetService("Players").LocalPlayer
		local g = p:WaitForChild("PlayerGui")
		local s = g:FindFirstChild("SpeedGui") or Instance.new("ScreenGui", g)
		s.Name = "SpeedGui"
		s.ResetOnSpawn = false
		local b = Instance.new("TextButton", s)
		b.Size = UDim2.new(0, 60, 0, 60)
		b.Position = UDim2.new(0, 10, 0, 10)
		b.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		b.Text = "WalkSpeed"
		b.Draggable = true
		b.Active = true
		local v = 30
		local function h()
			return (p.Character or p.CharacterAdded:Wait()):WaitForChild("Humanoid")
		end
		h().WalkSpeed = v
		b.MouseButton1Click:Connect(function()
			v = (v == 30) and 100 or 30
			h().WalkSpeed = v
			b.Text = ("vel: ".. v)
		end)
	end
})



local manterVelocidade = false
player:AddToggle("", {
	Title = "Nunca manter velocidade abaixo de 30",
	Description = "Caso cair em uma trap velocidade não reduz",
	Default = false,
	Callback = function(v)
		manterVelocidade = v
		if v then
			task.spawn(function()
				while manterVelocidade do
					local h = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
					if h and h.WalkSpeed < 30 then
						h.WalkSpeed = 30.1
					end
					task.wait(0.25)
				end
			end)
		end
	end
})

player:AddSection("Jump")

local jumpPower = 50
local JumpInput

JumpInput = player:AddInput("JumpInput", {
	Title = "Pulo",
	Description = "Digite o valor do pulo (50 a 200)",
	Default = 50,
	Placeholder = "Ex: 100",
	Numeric = true,
	Finished = true,
	Callback = function(v)
		local n = tonumber(v)
		if not n then return end
		if n < 50 then
			jumpPower = 50
			JumpInput:SetValue(50)
		elseif n > 200 then
			jumpPower = 200
			JumpInput:SetValue(200)
		else
			jumpPower = n
		end
	end
})

player:AddButton({
	Title = "Aplicar Pulo",
	Description = "Define o valor do pulo",
	Callback = function()
		game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = jumpPower
	end
})

player:AddToggle("", {
	Title = "Infinite Jump",
	Description = "Auto se explica",
	Default = false,
	Callback = function(v)
		if v then
			_G.InfJump = game:GetService("UserInputService").JumpRequest:Connect(function()
				local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
				if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
			end)
		else
			if _G.InfJump then _G.InfJump:Disconnect() _G.InfJump = nil end
		end
	end
})

--





local itens = {
    "Ammo (Rev & Rif)",
    "Bandage",
    "Berry",
    "Bolt",
    "Broken Fan",
    "Broken Microwave",
    "Cake",
    "Carrot",
    "Chair",
    "Coal",
    "Coin Stack",
    "Fuel Canister",
    "Iron Body",
    "Leather Armor",
    "Log",
    "MedKit",
    "Oil Barrel",
    "Old Car Engine",
    "Old Flashlight",
    "Old Radio",
    "Revolver",
    "Rifle",
    "Sheet Metal",
    "Tyre"
}

local selectedItem

local bringdrop = bring:AddDropdown("Dropdown", {
    Title = "Item que ele traz",
    Description = "Escolha o item que o bring traz",
    Values = itens,
    Multi = false,
    Default = nil,
})

bringdrop:OnChanged(function(value)
    selectedItem = value
end)

bring:AddButton({
    Title = "Bring traz o item",
    Description = "Faz o bring trazer o item selecionado",
    Callback = function()
        if selectedItem == "Ammo (Rev & Rif)" then
            bringAmmo()
        elseif selectedItem == "Bandage" then
            bringBandage()
        elseif selectedItem == "Berry" then
            bringBerry()
        elseif selectedItem == "Bolt" then
            bringBolt()
        elseif selectedItem == "Broken Fan" then
            bringVentilador()
        elseif selectedItem == "Broken Microwave" then
            bringMicro()
        elseif selectedItem == "Cake" then
            bringCake()
        elseif selectedItem == "Carrot" then
            bringCarrot()
        elseif selectedItem == "Chair" then
            bringChair()
        elseif selectedItem == "Coal" then
            bringCoal()
        elseif selectedItem == "Coin Stack" then
            bringCoin()
        elseif selectedItem == "Fuel Canister" then
            bringFuel()
        elseif selectedItem == "Iron Body" then
            bringArm2()
        elseif selectedItem == "Leather Armor" then
            bringArm1()
        elseif selectedItem == "Log" then
            bringLog()
        elseif selectedItem == "MedKit" then
            bringMedKit()
        elseif selectedItem == "Oil Barrel" then
            bringBarril()
        elseif selectedItem == "Old Car Engine" then
            bringEngine()
        elseif selectedItem == "Old Flashlight" then
            bringFlashOld()
        elseif selectedItem == "Old Radio" then
            bringRadio()
        elseif selectedItem == "Revolver" then
            bringRevolver()
        elseif selectedItem == "Rifle" then
            bringRifle()
        elseif selectedItem == "Sheet Metal" then
            bringSheetMetal()
        elseif selectedItem == "Tyre" then
            bringRoda()
        end
    end
})


tps:AddButton({
	Title = "Teleport to center (fogo)",
	Description = "Ao clicar te Teleporta para o fogo",
	Callback = function() 
		tpfire() 
	end
})
