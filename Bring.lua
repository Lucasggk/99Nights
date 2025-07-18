function bl(nome, caminho)
	local p = game.Players.LocalPlayer
	local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	for _, item in ipairs(workspace.Items:GetChildren()) do
		if item.Name == nome then
			local partes = string.split(caminho, ".")
			local obj = item
			for _, parte in ipairs(partes) do
				obj = obj:FindFirstChild(parte)
				if not obj then break end
			end
			if obj and obj:IsA("BasePart") then
				obj.CFrame = hrp.CFrame + Vector3.new(math.random(-5,5), 0, math.random(-5,5))
			end
		end
	end
end

function bringBerry()
	bl("Berry", "Handle")
end


function bringBolt()
	bl("Bolt", "main")
end

function bringCoal()
	bl("Coal", "Coal")
end

function bringCarrot()
	bl("Carrot", "Handle")
end

function bringCoin()
	bl("Coin Stack", "Mossy Coin.Main")
end

function bringLog()
	bl("Log", "Main")
end

function bringVentilador()
	bl("Broken Fan", "Fans")
end

function bringFlashOld()
	bl("Old Flashlight", "Bulb")
end

function bringSheetMetal()
	bl("Sheet Metal", "Main")
end

function bringAmmo()
	bl("Rifle Ammo", "Main")
	bl("Revolver Ammo", "Main")
end

function bringRifle()
	bl("Rifle", "Adorn")
end

function bringFuel()
	bl("Fuel Canister", "Main")
end

function bringRadio()
	bl("Old Radio", "Main")
end

function bringMicro()
	bl("Broken Microwave", "Main")
end

function bringRoda()
	bl("Tyre", "Main")
end

