local ModuleScripts = {}

for _, moduleScript in ipairs(script:GetChildren()) do
	if moduleScript:IsA("ModuleScript") then
		ModuleScripts[moduleScript.Name] = require(moduleScript)
	end
end

return ModuleScripts
