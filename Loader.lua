repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui") 

loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasggk/BlueLock/refs/heads/main/Fix.name.ui.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasggk/99Nights/main/Bring.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasggk/99Nights/main/Bringc.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasggk/99Nights/main/Esp.lua"))()

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
local esp = Window:AddTab({ Title = "Esp", Icon = "" })
local Combat = Window:AddTab({ Title = "Combat", Icon = "" })

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
    Description = "Caso cair em uma trap velocidade não reduz\n-> Se sua velocidade for menos que 30 ela muda pra 50!",
    Default = false,
    Callback = function(v)
        manterVelocidade = v
        if manterVelocidade then
            task.spawn(function()
                while manterVelocidade do
                    local char = game.Players.LocalPlayer.Character
                    local h = char and char:FindFirstChild("Humanoid")
                    if h and h.WalkSpeed < 30 then
                        h.WalkSpeed = 50
                    end
                    task.wait(0.1)
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
    "Metal Chair",
    "Oil Barrel",
    "Old Car Engine",
    "Old Flashlight",
    "Old Radio",
    "Revolver",
    "Rifle",
    "Sheet Metal",
    "Tyre",
    "Washing Machine"
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
	elseif selectedItem == "Washing Machine" then
	    bringLavar()
	elseif selectedItem == "Metal Chair" then
	    bringMChair()
        end
    end
})

bring:AddSection("Auto Bring - Combustíveis/Fogo")

local abff = false
local abffThread = nil

bring:AddToggle("", {
	Title = "Auto Bring Combustíveis",
	Description = "puxa tudo que e possivel queimar para um pouco a frente do fogo",
	Default = false,
	Callback = function(l)
		abff = l
		if abff and not abffThread then
			abffThread = task.spawn(function()
				while abff do
					task.wait(0.2)
					blmCom()
				end
				abffThread = nil
			end)
		end
	end
})

bring:AddButton({
	Title = "Auto Bring Combustíveis (Manual)", 
	Description = "Mesma função do Toggle porem ele so bring 1 vez por click\nE não automaticamente",
	Callback = function() blmCom() end})
					
bring:AddSection("Auto Bring - Metais")

local abfg = false
local abfgThread = nil

bring:AddToggle("", {
	Title = "Auto Bring Metais",
	Description = "puxa tudo que é metal para trás da bancada de trabalho",
	Default = false,
	Callback = function(l)
		abfg = l
		if abfg and not abfgThread then
			abfgThread = task.spawn(function()
				while abfg do
					task.wait(0.02)
					blmMet()
				end
				abfgThread = nil
			end)
		end
	end
})

bring:AddButton({
	Title = "Auto Bring metais (Manual)", 
	Description = "Mesma função do Toggle porem ele so bring 1 vez por click\nE não automaticamente",
	Callback = function() blmMet() end})

       


--
tps:AddSection("Tps prontos")


tps:AddButton({
	Title = "Teleport to center (fogo)",
	Description = "Ao clicar te Teleporta para o fogo",
	Callback = function() 
		tpfire() 
	end
})


tps:AddSection("Tps Pos")


local tv = {}
function gp() local p=game.Players.LocalPlayer.Character.HumanoidRootPart.Position return ("%d, %d, %d"):format(p.X, p.Y, p.Z) end
local tpd

local Dropdown = tps:AddDropdown("Dropdown", {
    Title = "Locais para teleport",
    Description = "",
    Values = tv,
    Multi = false,
    Default = nil,
    Callback = function(v)
	tpd = v
    end
})

tps:AddButton({
    Title = "Salvar novo local",
    Description = "Adiciona nova posição no Dropdown",
    Callback = function()
        table.insert(tv, gp())
        Dropdown:SetValues(tv)
    end
})

tps:AddButton({
    Title = "Limpar Locais salvos",
    Description = "Limpa todas posições salva no Dropdown",
    Callback = function()
	tv = {}
        Dropdown:SetValues(tv)
    end
})

tps:AddButton({
    Title = "Teleportar para posição selecionada",
    Description = "",
    Callback = function()
        if tpd then
            local x, y, z = tpd:match("(-?%d+), (-?%d+), (-?%d+)")
            if x and y and z then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(tonumber(x), tonumber(y), tonumber(z))
            end
        end
    end
})

--

local ie = {"Coal", "Log"}
local vde = {}

local espdown = esp:AddDropdown("a", {
   Title = "Itens",
   Description = "Selecione para o esp",
   Values = ie,
   Multi = true,
   Default = {},
})

espdown:OnChanged(function(val)
	table.clear(vde)
	for i, state in next, val do
		if state then
			vde[#vde + 1] = i
		end
	end
end)

esp:AddButton({
	Title = "Adicionar esp",
	Description = "Adiciona os itens selecionados em esp",
	Callback = function()
		for _, i in vde do
			Aesp(i)
		end
	end
})

esp:AddButton({
	Title = "Remover esp",
	Description = "Remove todos esp",
	Callback = function()
		for _, i in vde do
			Desp(i)
		end
		table.clear(vde)
		espdown:SetValue(vde)
	end
})

--

_G.killaura = nil
Combat:AddToggle("", {
	Title = "Kill Aura (OP)",
	Description = "Ataca automaticamente qualquer NPC\nPorem você tem que estar com machado na mão\n*Funciona com todos machados*\nEle ataca todos NPCs que foram gerados no mapa!",
	Default = false,
	Callback = function(value)
		local Players = game:GetService("Players")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RunService = game:GetService("RunService")

		local LocalPlayer = Players.LocalPlayer
		local evento = ReplicatedStorage.RemoteEvents:FindFirstChild("ToolDamageObject")
		local caminho = workspace:FindFirstChild("Characters") or workspace

		local machados = {
			["Old Axe"] = true,
			["Good Axe"] = true,
			["Strong Axe"] = true
		}

		local function getMachado()
			local inv = LocalPlayer:FindFirstChild("Inventory")
			if not inv then return nil end
			for _, item in pairs(inv:GetChildren()) do
				if machados[item.Name] then
					return item
				end
			end
			return nil
		end

		local function gerarID()
			return "2_" .. LocalPlayer.UserId
		end

		if value then
			_G.killaura = RunService.RenderStepped:Connect(function()
				local arma = getMachado()
				if not arma or not evento then return end

				local c = LocalPlayer.Character
				if not c then return end
				local hrp = c:FindFirstChild("HumanoidRootPart")
				if not hrp then return end

				for _, alvo in pairs(caminho:GetChildren()) do
					if alvo ~= c then
						local alvoRoot = alvo:FindFirstChild("HumanoidRootPart")
						if alvoRoot and alvo:FindFirstChildWhichIsA("Humanoid") then
							evento:InvokeServer(alvo, arma, gerarID(), hrp.CFrame)
						end
					end
				end
			end)
		else
			if _G.killaura then
				_G.killaura:Disconnect()
				_G.killaura = nil
			end
		end
	end
})
