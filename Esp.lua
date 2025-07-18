function Aesp(nome)
	local itens = workspace:WaitForChild("Items")

	for _, item in ipairs(itens:GetChildren()) do
		if item.Name == nome then
			local parte = nil
			if item:IsA("BasePart") then
				parte = item
			elseif item:IsA("Model") then
				parte = item:FindFirstChildWhichIsA("BasePart")
			end

			if parte then
				if parte:FindFirstChild("ESPTexto") then continue end -- evita duplicar

				local esp = Instance.new("BillboardGui")
				esp.Name = "ESPTexto"
				esp.Adornee = parte
				esp.Size = UDim2.new(0, 100, 0, 20)
				esp.StudsOffset = Vector3.new(0, 2, 0)
				esp.AlwaysOnTop = true

				local texto = Instance.new("TextLabel", esp)
				texto.Size = UDim2.new(1, 0, 1, 0)
				texto.BackgroundTransparency = 1
				texto.Text = item.Name
				texto.TextColor3 = Color3.fromRGB(255, 255, 0)
				texto.TextStrokeTransparency = 0.2
				texto.TextScaled = true
				texto.Font = Enum.Font.SourceSansBold

				esp.Parent = parte
			end
		end
	end
end

function Desp(nome)
	local itens = workspace:WaitForChild("Items")

	for _, item in ipairs(itens:GetChildren()) do
		if item.Name == nome then
			local parte = nil
			if item:IsA("BasePart") then
				parte = item
			elseif item:IsA("Model") then
				parte = item:FindFirstChildWhichIsA("BasePart")
			end

			if parte then
				for _, gui in ipairs(parte:GetChildren()) do
					if gui:IsA("BillboardGui") and gui.Name == "ESPTexto" then
						gui:Destroy()
					end
				end
			end
		end
	end
end
