return {
	Initiate = function(data)
		local character = data.Character
		local humanoid = character:WaitForChild("Humanoid")

		local model = Instance.new("Model")
		model.Name = character.Name.."'s Template"
		model.Parent = workspace.Effects
	end,
	
	Terminate = function(data)
		local character = data.Character
		local humanoid = character:WaitForChild("Humanoid")
		
		local model = workspace.Effects:FindFirstChild(character.Name.."'s Template")
		if model then
			
		end
	end,
}
