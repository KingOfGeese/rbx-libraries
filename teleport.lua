local Teleport = {}
Teleport.Style = {
	Linear = 1,
	Distance = 2,
	Instant = 3,
}
Teleport.Type = {
	Regular = 1,
	Mouse = 2
}
Teleport.Settings = {
	CustomStudSpeed = 200,
	MinimumInstantTeleport = 0,
	MaximumInstantTeleport = 500,
}

function Teleport:Distance(v)
	local lp = game.Players.LocalPlayer 
	local postion = Vector3.new(v.X, v.Y, v.Z)
	local distance = (lp.Character.HumanoidRootPart.Position - postion).Magnitude
	return distance
end

function Teleport:Advanced(...)
	local lp = game.Players.LocalPlayer
	local TweenService = game:GetService("TweenService")
	local TweenAnim = nil
	local params = {...}

	if (lp.Character == nil) then return print("Cannot find localplayer") end
	if (TweenAnim ~= nil) then TweenAnim:Cancel() end

	print(typeof(params[3]))
	if (params[1] == Teleport.Type.Mouse) then 
		local mouse = lp:GetMouse()
		local hit = mouse.Hit.p + Vector3.new(0, 5, 0)

		if (params[2] == Teleport.Style.Distance) then 
			if (params[3] ~= nil) then print("No need for this silly! It's automatic!") end

			local Speed = Teleport:Distance(hit) / Teleport.Settings.CustomStudSpeed
			TweenAnim = TweenService:Create(
				lp.Character.HumanoidRootPart,
				TweenInfo.new(Speed, Enum.EasingStyle.Linear),
				{ CFrame = CFrame.new(hit) }
			)
			TweenAnim:Play(); TweenAnim.Completed:Wait(); TweenAnim = nil
		elseif (params[2] == Teleport.Style.Instant) then
			if (params[3] ~= nil) then print("No need for this silly! It's instant!") end
			lp.Character.HumanoidRootPart.CFrame = CFrame.new(hit)
		else
			if (params[3] == nil) then params[3] = 1.5 end
			TweenAnim = TweenService:Create(
				lp.Character.HumanoidRootPart.CFrame,
				TweenInfo.new(params[4], Enum.EasingStyle.Linear),
				{ CFrame = CFrame.new(hit) }
			)
			TweenAnim:Play(); TweenAnim.Completed:Wait(); TweenAnim = nil
		end
	else
		if (params[3] == nil) then return print("You need a CFrame or Instance to teleport to.") end
		if (typeof(params[3]) == "CFrame") then
			if (params[2] == Teleport.Style.Distance) then 
				if (params[3] ~= nil) then print("No need for this silly! It's automatic!") end
	
				local Speed = Teleport:Distance(params[3]) / Teleport.Settings.CustomStudSpeed
				TweenAnim = TweenService:Create(
					lp.Character.HumanoidRootPart,
					TweenInfo.new(Speed, Enum.EasingStyle.Linear),
					{ CFrame = params[3] }
				)
				TweenAnim:Play(); TweenAnim.Completed:Wait(); TweenAnim = nil
			elseif (params[2] == Teleport.Style.Instant) then
				if (params[3] ~= nil) then print("No need for this silly! It's instant!") end
				lp.Character.HumanoidRootPart.CFrame = params[3]
			else
				if (params[4] == nil) then params[4] = 1.5 end
				TweenAnim = TweenService:Create(
					lp.Character.HumanoidRootPart.CFrame,
					TweenInfo.new(params[4], Enum.EasingStyle.Linear),
					{ CFrame = params[3] }
				)
				TweenAnim:Play(); TweenAnim.Completed:Wait(); TweenAnim = nil
			end
		elseif (typeof(params[3]) == "Instance") then
			if (params[2] == Teleport.Style.Distance) then 
				if (params[3] ~= nil) then print("No need for this silly! It's automatic!") end
	
				local Speed = Teleport:Distance(params[3].CFrame) / Teleport.Settings.CustomStudSpeed
				TweenAnim = TweenService:Create(
					lp.Character.HumanoidRootPart,
					TweenInfo.new(Speed, Enum.EasingStyle.Linear),
					{ CFrame = params[3].CFrame }
				)
				TweenAnim:Play(); TweenAnim.Completed:Wait(); TweenAnim = nil
			elseif (params[2] == Teleport.Style.Instant) then
				if (params[3] ~= nil) then print("No need for this silly! It's instant!") end
				lp.Character.HumanoidRootPart.CFrame = params[3].CFrame
			else
				if (params[3] == nil) then params[3] = 1.5 end
				TweenAnim = TweenService:Create(
					lp.Character.HumanoidRootPart.CFrame,
					TweenInfo.new(params[4], Enum.EasingStyle.Linear),
					{ CFrame = params[3].CFrame }
				)
				TweenAnim:Play(); TweenAnim.Completed:Wait(); TweenAnim = nil
			end
		else
			print("Sorry, there is no support for: ".. typeof(params[3]).. " currently.")
		end
	end
end
function Teleport:Smart(...)
	local lp = game.Players.LocalPlayer
	local TweenService = game:GetService("TweenService")
	local TweenAnim = nil
	local params = {...}

	if (lp.Character == nil) then return print("Cannot find localplayer") end
	if (TweenAnim ~= nil) then TweenAnim:Cancel() end

	if (params[3] == nil) then return print("You need a CFrame or Instance to teleport to.") end
	if (typeof(params[3]) == "CFrame") then
		if (Teleport:Distance(params[3]) <= Teleport.Settings.MinimumInstant and Teleport:Distance(params[3]) <= Teleport.Settings.MaximumInstantTeleport) then
			lp.Character.HumanoidRootPart.CFrame = params[3]; return
		end

		local Speed = Teleport:Distance(params[3]) / Teleport.Settings.CustomStudSpeed
		TweenAnim = TweenService:Create(
			lp.Character.HumanoidRootPart,
			TweenInfo.new(Speed, Enum.EasingStyle.Linear),
			{ CFrame = params[3] }
		)
		TweenAnim:Play(); TweenAnim.Completed:Wait(); TweenAnim = nil
	elseif (typeof(params[3]) == "Instance") then
		if (Teleport:Distance(params[3].CFrame) <= Teleport.Settings.MinimumInstant and Teleport:Distance(params[3].CFrame) <= Teleport.Settings.MaximumInstantTeleport) then
			lp.Character.HumanoidRootPart.CFrame = params[3].CFrame; return
		end

		local Speed = Teleport:Distance(params[3].CFrame) / Teleport.Settings.CustomStudSpeed
		TweenAnim = TweenService:Create(
			lp.Character.HumanoidRootPart,
			TweenInfo.new(Speed, Enum.EasingStyle.Linear),
			{ CFrame = params[3].CFrame }
		)
		TweenAnim:Play(); TweenAnim.Completed:Wait(); TweenAnim = nil
	else
		print("Sorry, there is no support for: ".. typeof(params[3]).. " currently.")
	end
end
return Teleport
