local E = require(script.E)

return {
	Keys = {
		V = {
			Hold = true,
			FaceMouse = true,
			FullOrientation = true,
			FaceSpeed = 2,

			Initiate = function(...)
				E.Initiate(...)
			end,

			Terminate = function(...)
				E.Terminate(...)
			end,
		}
	},
}

