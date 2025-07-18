function bl(nome, parte)
	local p = game.Players.LocalPlayer
	local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	for _, item in ipairs(workspace.Items:GetChildren()) do
		if item.Name == nome then
			local obj = item:FindFirstChild(parte)
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
