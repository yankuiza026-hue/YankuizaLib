local Players = game:GetService("Players")

local Yankuiza
if isfile and isfile("source.luau") then
	Yankuiza = loadstring(readfile("source.luau"))()
else
	Yankuiza = loadstring(game:HttpGet("https://raw.githubusercontent.com/yankuiza026-hue/YankuizaLib/main/source.luau"))()
end

local buildUI
buildUI = function()
	local Window = Yankuiza:CreateWindow({
		Name = "Test",
		ToggleKey = Enum.KeyCode.RightShift,
		AutoShow = true,
		Theme = "Daydream",
	})

	local main = Window:CreateTab("Main")

	local master = main:CreateToggle({
		Name = "Master toggle",
		Desc = "control it with the keybind or the Set calls",
		Default = false,
		Keybind = Enum.KeyCode.M,
		Callback = function(state)
			print("master ->", state)
		end,
	})

	main:CreateButton({
		Name = "Force master on",
		Desc = "calls master.Set(true) from code",
		Callback = function()
			master.Set(true)
			Window:Notify("Master", "forced on from code", 4)
		end,
	})

	main:CreateButton({
		Name = "Force master off",
		Desc = "calls master.Set(false) from code",
		Callback = function()
			master.Set(false)
			Window:Notify("Master", "forced off from code", 4)
		end,
	})

	main:CreateSlider({
		Name = "Walk speed",
		Desc = "writes to your humanoid",
		Min = 16,
		Max = 250,
		Default = 16,
		Step = 1,
		Suffix = " ws",
		Callback = function(value)
			local character = Players.LocalPlayer and Players.LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = value
			end
		end,
	})

	main:CreateButton({
		Name = "Rebuild UI",
		Desc = "destroys this window and respawns it",
		Callback = function()
			Window:Destroy()
			task.wait(0.4)
			buildUI()
		end,
	})

	local extras = Window:CreateTab("Extras")

	local nameInput = extras:CreateInput({
		Name = "Config name",
		Desc = "plain text input",
		Placeholder = "enter a name",
	})

	local skinDropdown = extras:CreateDropdown({
		Name = "Skin",
		Desc = "selector demo",
		Options = { "Default", "Checker Red", "Clown", "Skeleton" },
		Default = "Default",
		Callback = function(option)
			print("skin pick:", option)
		end,
	})

	extras:CreateButton({
		Name = "Refresh dropdown",
		Desc = "swaps the option list to prove Refresh",
		Callback = function()
			skinDropdown.Refresh({ "Option A", "Option B", "Option C" })
			Window:Notify("Refresh", "dropdown options swapped", 3)
		end,
	})

	local count = 0
	extras:CreateButton({
		Name = "Fire notifications",
		Desc = "stacks three toasts to test the pile",
		Callback = function()
			count += 1
			Yankuiza:Notify("Toast one", "count " .. count, 3)
			task.wait(0.3)
			Yankuiza:Notify("Toast two", "they stack up", 3)
			task.wait(0.3)
			Yankuiza:Notify("Toast three", "bottom one oldest", 3)
			_ = nameInput.Get()
		end,
	})

	local themes = Window:CreateTab("Themes")
	for _, themeName in ipairs(Yankuiza:GetThemeNames()) do
		themes:CreateButton({
			Name = themeName,
			Desc = "repaints everything on the spot",
			Callback = function()
				Yankuiza:UseTheme(themeName)
				Window:Notify("Theme", themeName, 3)
			end,
		})
	end

	local stress = Window:CreateTab("Stress")
	for i = 1, 10 do
		stress:CreateToggle({
			Name = "Toggle " .. i,
			Desc = (i % 2 == 0) and "lands in the right column" or "lands in the left column",
		})
	end

	Window:AddConfigTab("Configs")

	local ui = Window:CreateTab("Interface")
	ui:CreateToggle({
		Name = "HUD",
		Desc = "sample keybind toggle",
		Keybind = Enum.KeyCode.H,
	})
	ui:Select()
end

buildUI()
Yankuiza:Notify("test.luau", "rightshift opens and closes the menu", 6)
