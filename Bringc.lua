function blm(nome, caminho, pos)
	local p = game.Players.LocalPlayer
	if not pos then return end

	local x, y, z = string.match(pos, "([^,]+),%s*([^,]+),%s*([^,]+)")
	local destino = Vector3.new(tonumber(x) or 0, tonumber(y) or 0, tonumber(z) or 0)

	for _, item in ipairs(workspace.Items:GetChildren()) do
		if item.Name == nome then
			local partes = string.split(caminho, ".")
			local obj = item
			for _, parte in ipairs(partes) do
				obj = obj:FindFirstChild(parte)
				if not obj then break end
			end
			if obj and obj:IsA("BasePart") then
				obj.CFrame = CFrame.new(destino)
			end
		end
	end
end

function blmCom()
	blm("Coal", "Coal", "-15, 4, 0")
	blm("Oil Barrel", "Main", "-9, 4, -15")
	blm("Log", "Main", "-7, 4, 14")
	blm("Fuel Canister", "Main", "-30, 4, -0")
	blm("Chair", "Part", "-39, 4, -0")
end
