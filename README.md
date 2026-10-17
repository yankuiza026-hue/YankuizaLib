# YankuizaLib

UI library for roblox scripts. The menu is a small pill bar with two columns of cards underneath that stack as you add things, and every control accepts an optional keybind. If you have seen daydreamer's menu, this looks a lot like it.

Works on executors with the usual `writefile`/`readfile`/`isfile` functions. On ones without them, the config tab just says it can't save, and everything else keeps working.

`test.luau` exercises every function listed here, run it if you want to check your executor before using the lib.

## Loading it

Keep `source.luau` anywhere in your repo and load with:

```lua
local Yankuiza = loadstring(game:HttpGet("https://raw.githubusercontent.com/yankuiza026-hue/YankuizaLib/main/source.luau"))()
```

## Quick example

```lua
local Window = Yankuiza:CreateWindow({
	Name = "My Script",
	ToggleKey = Enum.KeyCode.RightShift,
})

local Tab = Window:CreateTab("Main")

Tab:CreateToggle({
	Name = "Infinite Jump",
	Desc = "jump mid air by holding space",
	Default = false,
	Keybind = Enum.KeyCode.J,
	Callback = function(state)
		print("infinite jump:", state)
	end,
})

Tab:Select()
```

Press RightShift (or your `ToggleKey`) to open and close the menu. Drag it around by the bar. The dots menu (`...`) on each card is where you bind or remove keybinds for that element, it waits for your next keypress when you hit Change.

## Window options

```lua
local Window = Yankuiza:CreateWindow({
	Name = "My Script",                   -- also used as the config folder name
	ToggleKey = Enum.KeyCode.RightShift,  -- key that shows/hides the menu
	AutoShow = true,                      -- false starts the menu hidden
	AutoLoad = "default",                 -- optional, loads this config on start
	Theme = "Daydream",                   -- Daydream, Midnight, Ivory or Ember
})
```

Methods on the window:

- `Window:Toggle()`, `Window:Show()`, `Window:Hide()`
- `Window:SetToggleKey(key)` to change the toggle key at runtime
- `Window:Destroy()` closes everything and disconnects the lib for that window
- `Window:SaveConfig(name)`, `Window:LoadConfig(name)` return `success, message`
- `Window:GetConfigs()` returns a table of saved config names
- `Window:DeleteConfig(name)`, also `Window:AddConfigTab(title)` to build a ready config tab

Configs are saved as plain JSON under `YankuizaLib/<Window Name>/` in the executor workspace.

## Elements

All of these live on a tab and return the element, so you can read or set the value from code later. Every element saves its value in configs and re-fires its callback (silently) when a config loads.

### Toggle

```lua
local elem = Tab:CreateToggle({
	Name = "Speed",
	Desc = "short description under the name", -- optional
	Default = true,                            -- optional, false by default
	Keybind = Enum.KeyCode.K,                  -- optional
	Flag = "speed_enabled",                    -- optional key used in config files
	Callback = function(state) end,
})

elem.Set(false)  -- updates the switch and the callback
elem.Toggle()    -- flips it
elem.Get()       -- returns the current state
```

### Button

```lua
Tab:CreateButton({
	Name = "Rejoin",
	Desc = "leave and rejoin the server",
	Keybind = Enum.KeyCode.J,
	Callback = function()
		-- runs on click, or when the keybind fires
	end,
})
```

No value gets saved for buttons, they are just actions.

### Slider

```lua
Tab:CreateSlider({
	Name = "Walk Speed",
	Desc = "changes movement speed",
	Min = 16,
	Max = 200,
	Default = 16,
	Step = 1,          -- optional rounding, 1 by default
	Suffix = " ws",    -- optional text after the number
	Callback = function(value) end,
})
```

`elem.Get()` returns the current number, `elem.Set(100)` sets it.

### Dropdown

```lua
local elem = Tab:CreateDropdown({
	Name = "Skin",
	Desc = "pick a skin",
	Options = { "Default", "Clown", "Skeleton" },
	Default = "Default",   -- falls back to the first option
	Callback = function(option) end,
})

elem.Get()                     -- current option
elem.Set("Clown")              -- select an option
elem.Refresh({ "A", "B" })     -- replace the option list
```

### Input

```lua
local elem = Tab:CreateInput({
	Name = "Webhook URL",
	Desc = "where logs go",
	Placeholder = "https://...",
	Default = "",          -- starting text
	Callback = function(text) end,
})

elem.Get()      -- typed text
elem.Set("hi")  -- replaces it, callback fires unless silent
```

## Themes and notifications

```lua
Yankuiza:GetThemeNames()      -- { "Daydream", "Midnight", "Ivory", "Ember" }
Yankuiza:UseTheme("Midnight") -- repaints every open window right away
Yankuiza:Notify("Title", "small text", 4) -- seconds, window has Window:Notify too
```

Toasts stack bottom right and push each other up as they expire.

## Notes

- Default font is Work Sans, which ships with Roblox, nothing to download.
- Two toggles bound to the same key both fire, so no surprises if you share keys by accident.
- The `test.luau` at the root rebuilds its own menu, try the rebuild button a few times, if nothing breaks or leaks you are good.