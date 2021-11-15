local RunService =  game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Abilities = {}
for _, moduleScript in ipairs(script:GetChildren()) do
	if moduleScript:IsA("ModuleScript") then
		Abilities[moduleScript.Name] = require(moduleScript)
	end
end

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local mouse = player:GetMouse()
mouse.TargetFilter = workspace.Effects

local abilityName = "TheSocialCrediter"

local cooldowns = {}
local holding = false

UserInputService.InputBegan:Connect(function(input, gameProccessedEvent)
	if gameProccessedEvent then
		return
	end
	
	local ability = Abilities[abilityName]
	if ability then
		local abilityKey = ability.Keys[input.KeyCode.Name] or ability.Keys[input.UserInputType.Name]
		if abilityKey then
			if not cooldowns[input.KeyCode.Name] or os.clock() - cooldowns[input.KeyCode.Name] >= abilityKey.CooldownTime then
				if abilityKey.Hold then
					if not holding then
						holding = true
						
						humanoid.PlatformStand = true
						
						local connection; connection = RunService.RenderStepped:Connect(function(dt)
							if holding then
								local direction = abilityKey.FullOrientation and mouse.Hit.Position or Vector3.new(mouse.Hit.X, humanoid.RootPart.Position.Y, mouse.Hit.Z)
								
								humanoid.RootPart.CFrame = humanoid.RootPart.CFrame:Lerp(
									CFrame.lookAt(humanoid.RootPart.Position, direction),
									dt * abilityKey.FaceSpeed
								)
								
								humanoid.RootPart.Anchored = true
							else
								connection:Disconnect()
								connection = nil
							end
						end)
						
						abilityKey.Initiate({
							Character = character,
							Mouse = mouse,
						})
					end
				else
					cooldowns[input.KeyCode.Name] = os.clock()
				end
			end
		end
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProccessedEvent)
	if gameProccessedEvent then
		return
	end
	
	local ability = Abilities[abilityName]
	if ability then
		local abilityKey = ability.Keys[input.KeyCode.Name] or ability.Keys[input.UserInputType.Name]
		if abilityKey then
			if abilityKey.Hold then
				if holding then
					holding = false
					cooldowns[input.KeyCode.Name] = os.clock()
					humanoid.PlatformStand = false
					
					abilityKey.Terminate({
						Character = character,
						Mouse = mouse,
					})
					
					humanoid.RootPart.Anchored = false
				end
			end
		end
	end
end)
