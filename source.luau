--[[
	YankuizaLib
	daydream-inspired UI library
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Yankuiza = {
	Version = "Alpha",
	Theme = {},
	Windows = {},
	Bindings = {},
	ToastStack = {},
	_ActivePopup = nil,
	_Capturing = false,
}

Yankuiza.ThemePresets = {}

local THEME_PRESETS = Yankuiza.ThemePresets

THEME_PRESETS.Daydream = {
	Font = Font.new("rbxasset://fonts/families/WorkSans.json", Enum.FontWeight.Bold),
	FontMedium = Font.new("rbxasset://fonts/families/WorkSans.json", Enum.FontWeight.Medium),
	FontNormal = Font.new("rbxasset://fonts/families/WorkSans.json"),
	TextColor = Color3.fromRGB(255, 255, 255),
	SubTextColor = Color3.fromRGB(168, 168, 168),
	Background = Color3.fromRGB(5, 5, 5),
	Card = Color3.fromRGB(0, 0, 0),
	CardHover = Color3.fromRGB(19, 19, 19),
	Pill = Color3.fromRGB(43, 43, 43),
	Knob = Color3.fromRGB(255, 255, 255),
	KnobOn = Color3.fromRGB(105, 210, 235),
	TrackOn = Color3.fromRGB(238, 246, 249),
	TrackOff = Color3.fromRGB(64, 64, 64),
	SliderBack = Color3.fromRGB(52, 52, 52),
	SliderFill = Color3.fromRGB(255, 255, 255),
	Selector = Color3.fromRGB(21, 21, 21),
	Popup = Color3.fromRGB(11, 11, 11),
	PopupHover = Color3.fromRGB(30, 30, 30),
	CardWidth = 365,
	ColumnGap = 15,
	RowGap = 13,
	ToggleKey = Enum.KeyCode.RightShift,
}

THEME_PRESETS.Midnight = {
	Font = Font.new("rbxasset://fonts/families/WorkSans.json", Enum.FontWeight.Bold),
	FontMedium = Font.new("rbxasset://fonts/families/WorkSans.json", Enum.FontWeight.Medium),
	FontNormal = Font.new("rbxasset://fonts/families/WorkSans.json"),
	TextColor = Color3.fromRGB(235, 240, 252),
	SubTextColor = Color3.fromRGB(146, 158, 184),
	Background = Color3.fromRGB(7, 10, 18),
	Card = Color3.fromRGB(3, 5, 10),
	CardHover = Color3.fromRGB(12, 17, 28),
	Pill = Color3.fromRGB(36, 46, 68),
	Knob = Color3.fromRGB(244, 248, 255),
	KnobOn = Color3.fromRGB(96, 190, 255),
	TrackOn = Color3.fromRGB(18, 30, 52),
	TrackOff = Color3.fromRGB(46, 54, 74),
	SliderBack = Color3.fromRGB(38, 46, 66),
	SliderFill = Color3.fromRGB(102, 182, 255),
	Selector = Color3.fromRGB(13, 18, 30),
	Popup = Color3.fromRGB(6, 9, 16),
	PopupHover = Color3.fromRGB(20, 27, 42),
	CardWidth = THEME_PRESETS.Daydream.CardWidth,
	ColumnGap = THEME_PRESETS.Daydream.ColumnGap,
	RowGap = THEME_PRESETS.Daydream.RowGap,
	ToggleKey = THEME_PRESETS.Daydream.ToggleKey,
}

THEME_PRESETS.Ivory = {
	Font = Font.new("rbxasset://fonts/families/WorkSans.json", Enum.FontWeight.Bold),
	FontMedium = Font.new("rbxasset://fonts/families/WorkSans.json", Enum.FontWeight.Medium),
	FontNormal = Font.new("rbxasset://fonts/families/WorkSans.json"),
	TextColor = Color3.fromRGB(26, 27, 33),
	SubTextColor = Color3.fromRGB(128, 129, 140),
	Background = Color3.fromRGB(255, 255, 255),
	Card = Color3.fromRGB(246, 246, 249),
	CardHover = Color3.fromRGB(236, 237, 242),
	Pill = Color3.fromRGB(226, 227, 235),
	Knob = Color3.fromRGB(255, 255, 255),
	KnobOn = Color3.fromRGB(64, 196, 232),
	TrackOn = Color3.fromRGB(36, 38, 46),
	TrackOff = Color3.fromRGB(203, 204, 214),
	SliderBack = Color3.fromRGB(222, 223, 231),
	SliderFill = Color3.fromRGB(36, 38, 46),
	Selector = Color3.fromRGB(240, 240, 244),
	Popup = Color3.fromRGB(252, 252, 254),
	PopupHover = Color3.fromRGB(232, 233, 240),
	CardWidth = THEME_PRESETS.Daydream.CardWidth,
	ColumnGap = THEME_PRESETS.Daydream.ColumnGap,
	RowGap = THEME_PRESETS.Daydream.RowGap,
	ToggleKey = THEME_PRESETS.Daydream.ToggleKey,
}

THEME_PRESETS.Ember = {
	Font = Font.new("rbxasset://fonts/families/WorkSans.json", Enum.FontWeight.Bold),
	FontMedium = Font.new("rbxasset://fonts/families/WorkSans.json", Enum.FontWeight.Medium),
	FontNormal = Font.new("rbxasset://fonts/families/WorkSans.json"),
	TextColor = Color3.fromRGB(252, 246, 240),
	SubTextColor = Color3.fromRGB(178, 146, 132),
	Background = Color3.fromRGB(10, 6, 4),
	Card = Color3.fromRGB(4, 2, 1),
	CardHover = Color3.fromRGB(24, 13, 9),
	Pill = Color3.fromRGB(72, 38, 22),
	Knob = Color3.fromRGB(255, 255, 255),
	KnobOn = Color3.fromRGB(255, 122, 74),
	TrackOn = Color3.fromRGB(252, 238, 228),
	TrackOff = Color3.fromRGB(66, 44, 32),
	SliderBack = Color3.fromRGB(66, 44, 32),
	SliderFill = Color3.fromRGB(255, 122, 74),
	Selector = Color3.fromRGB(4, 2, 1),
	Popup = Color3.fromRGB(12, 7, 4),
	PopupHover = Color3.fromRGB(34, 20, 12),
	CardWidth = THEME_PRESETS.Daydream.CardWidth,
	ColumnGap = THEME_PRESETS.Daydream.ColumnGap,
	RowGap = THEME_PRESETS.Daydream.RowGap,
	ToggleKey = THEME_PRESETS.Daydream.ToggleKey,
}

for key, value in pairs(THEME_PRESETS.Daydream) do
	Yankuiza.Theme[key] = value
end

local HAS_FS = (type(writefile) == "function")
	and (type(readfile) == "function")
	and (type(isfolder) == "function")
	and (type(makefolder) == "function")
	and (type(listfiles) == "function")

local Motion = {
	Fast = 0.11,
	Base = 0.18,
	Slow = 0.28,
}

local Layer = {
	Content = 1,
	Bar = 2,
	Toast = 3000,
	Popup = 9000,
	Capture = 9500,
}

local DRAG_THRESHOLD = 6

local ThemeBindings = {}
local ThemeHooks = {}

local TweenInfoCache = {}
local function cachedInfo(duration, style, direction)
	local key = string.format("%s|%s|%s", duration, tostring(style), tostring(direction))
	local cached = TweenInfoCache[key]
	if not cached then
		cached = TweenInfo.new(duration, style or Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out)
		TweenInfoCache[key] = cached
	end
	return cached
end

local function alive(object)
	return typeof(object) == "Instance" and object.Parent ~= nil
end

local function add(parent, class, props)
	local object = Instance.new(class)
	for key, value in pairs(props or {}) do
		if key ~= "Parent" then
			if typeof(value) == "Instance" and value:IsA("Font") then
				object.FontFace = value
			else
				object[key] = value
			end
		end
	end
	object.Parent = parent
	return object
end

local function corner(parent, radius)
	if radius >= 100 then
		radius = nil
	end
	return add(parent, "UICorner", { CornerRadius = radius and UDim.new(0, radius) or UDim.new(1, 0) })
end

local function tween(object, props, info)
	if not alive(object) then
		return nil
	end
	local ok, result = pcall(function()
		local t = TweenService:Create(object, info or cachedInfo(Motion.Base), props)
		t:Play()
		return t
	end)
	return ok and result or nil
end

local function protect(object)
	if typeof(syn) == "table" and syn.protect_gui then
		pcall(syn.protect_gui, object)
	end
	local ok = pcall(function()
		object.Parent = (typeof(gethui) == "function" and gethui()) or game:GetService("CoreGui")
	end)
	if not ok and LocalPlayer then
		pcall(function()
			object.Parent = LocalPlayer:WaitForChild("PlayerGui", 3)
		end)
	end
end

local function sanitize(text)
	return tostring(text):gsub("[^%w_%s%-]", "")
end

local function bind(object, property, key)
	if typeof(object) ~= "Instance" then
		return
	end
	local color = Yankuiza.Theme[key]
	if color then
		pcall(function()
			object[property] = color
		end)
	end
	local map = ThemeBindings[object]
	if not map then
		map = {}
		ThemeBindings[object] = map
	end
	map[property] = key
end

local function bindAll(object, keys)
	for property, key in pairs(keys) do
		bind(object, property, key)
	end
end

local function paintHook(fn)
	table.insert(ThemeHooks, fn)
	return fn
end

local function paintTheme()
	for object, map in pairs(ThemeBindings) do
		if typeof(object) == "Instance" and object.Parent ~= nil then
			for property, key in pairs(map) do
				local color = Yankuiza.Theme[key]
				if color then
					pcall(function()
						object[property] = color
					end)
				end
			end
		else
			ThemeBindings[object] = nil
		end
	end
	for index = #ThemeHooks, 1, -1 do
		local ok, keep = pcall(ThemeHooks[index])
		if not ok or keep == false then
			table.remove(ThemeHooks, index)
		end
	end
end

function Yankuiza:UseTheme(name)
	local preset = THEME_PRESETS[name or "Daydream"]
	if not preset then
		return false, "unknown theme"
	end
	for key, value in pairs(preset) do
		self.Theme[key] = value
	end
	paintTheme()
	return true
end

function Yankuiza:GetThemeNames()
	local names = {}
	for name in pairs(THEME_PRESETS) do
		table.insert(names, name)
	end
	return names
end

Yankuiza._NativeGui = Instance.new("ScreenGui")
Yankuiza._NativeGui.Name = "YankuizaNative"
Yankuiza._NativeGui.ResetOnSpawn = false
Yankuiza._NativeGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Yankuiza._NativeGui.IgnoreGuiInset = false
Yankuiza._NativeGui.DisplayOrder = 2147483646
protect(Yankuiza._NativeGui)

local function closePopup()
	if Yankuiza._ActivePopup then
		local overlay = Yankuiza._ActivePopup
		Yankuiza._ActivePopup = nil
		pcall(function()
			overlay:Destroy()
		end)
	end
end

local function openPopup(anchorButton, width, items)
	closePopup()
	local theme = Yankuiza.Theme
	local overlay = add(Yankuiza._NativeGui, "TextButton", {
		Name = "PopupOverlay",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		ZIndex = Layer.Popup,
	})
	Yankuiza._ActivePopup = overlay
	overlay.MouseButton1Click:Connect(closePopup)

	local popup = add(overlay, "CanvasGroup", {
		Name = "Popup",
		BackgroundColor3 = theme.Popup,
		BorderSizePixel = 0,
		Size = UDim2.new(0, width, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		ClipsDescendants = false,
		ZIndex = Layer.Popup + 1,
	})
	corner(popup, 16)

	local listParent = popup
	if #items > 7 then
		listParent = add(popup, "ScrollingFrame", {
			Name = "Scroll",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 7 * 32 + 8),
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = theme.TrackOff,
			BorderSizePixel = 0,
			ZIndex = Layer.Popup + 1,
		})
	end

	add(listParent, "UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 2),
	})
	add(popup, "UIPadding", {
		PaddingTop = UDim.new(0, 6),
		PaddingBottom = UDim.new(0, 6),
		PaddingLeft = UDim.new(0, 6),
		PaddingRight = UDim.new(0, 6),
	})

	local viewport = (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize) or Vector2.new(1920, 1080)
	local abs = anchorButton.AbsolutePosition
	local x = abs.X + anchorButton.AbsoluteSize.X - width
	local y = abs.Y + anchorButton.AbsoluteSize.Y + 6
	if y + 250 > viewport.Y then
		y = math.max(abs.Y - 215, 8)
	end
	popup.Position = UDim2.new(0, math.clamp(x, 8, viewport.X - width - 8), 0, y)
	popup.GroupTransparency = 1
	tween(popup, { GroupTransparency = 0 }, cachedInfo(0.12, Enum.EasingStyle.Quart))

	for index, item in ipairs(items) do
		local button = add(listParent, "TextButton", {
			Name = item.Text,
			LayoutOrder = index,
			AutoButtonColor = false,
			BackgroundColor3 = theme.PopupHover,
			BackgroundTransparency = 1,
			Font = theme.FontMedium,
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = item.Disabled and theme.SubTextColor or theme.TextColor,
			Text = item.Text,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Size = UDim2.new(1, 0, 0, 30),
			ZIndex = Layer.Popup + 2,
		})
		corner(button, 11)
		add(button, "UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) })
		if not item.Disabled then
			button.MouseEnter:Connect(function()
				tween(button, { BackgroundTransparency = 0 }, cachedInfo(0.1))
			end)
			button.MouseLeave:Connect(function()
				tween(button, { BackgroundTransparency = 1 }, cachedInfo(0.1))
			end)
			button.MouseButton1Click:Connect(function()
				closePopup()
				task.spawn(item.Action)
			end)
		end
	end
	return overlay
end

local function repositionToasts()
	local offsetY = 24
	for index = #Yankuiza.ToastStack, 1, -1 do
		local toast = Yankuiza.ToastStack[index]
		if alive(toast) then
			tween(toast, { Position = UDim2.new(1, -24, 1, -offsetY) }, cachedInfo(Motion.Base))
			offsetY += toast.AbsoluteSize.Y + 10
		else
			table.remove(Yankuiza.ToastStack, index)
		end
	end
end

function Yankuiza:Notify(title, desc, seconds)
	local theme = self.Theme
	local toast = add(self._NativeGui, "CanvasGroup", {
		Name = "Toast",
		BackgroundColor3 = theme.Background,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, 40, 1, -24),
		Size = UDim2.new(0, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.XY,
		ZIndex = Layer.Toast,
		LayoutOrder = #self.ToastStack + 1,
	})
	corner(toast, 14)
	add(toast, "UIPadding", {
		PaddingTop = UDim.new(0, 12),
		PaddingBottom = UDim.new(0, 12),
		PaddingLeft = UDim.new(0, 16),
		PaddingRight = UDim.new(0, 16),
	})
	bind(toast, "BackgroundColor3", "Background")
	add(toast, "TextLabel", {
		BackgroundTransparency = 1,
		Font = theme.Font,
		TextSize = 14,
		TextColor3 = theme.TextColor,
		Text = tostring(title or "Notification"),
		TextXAlignment = Enum.TextXAlignment.Left,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 0, 18),
		LayoutOrder = 1,
	})
	if desc and desc ~= "" then
		add(toast, "TextLabel", {
			BackgroundTransparency = 1,
			Font = theme.FontNormal,
			TextSize = 12,
			TextColor3 = theme.SubTextColor,
			Text = tostring(desc),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Size = UDim2.new(0, 260, 0, 16),
			LayoutOrder = 2,
		})
	end
	add(toast, "UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 2),
	})

	table.insert(self.ToastStack, toast)
	task.defer(repositionToasts)
	toast:GetPropertyChangedSignal("AbsoluteSize"):Connect(repositionToasts)

	local lifetime = task.delay(seconds or 4, function()
		local index = table.find(self.ToastStack, toast)
		if index then
			table.remove(self.ToastStack, index)
		end
		tween(
			toast,
			{ GroupTransparency = 1, Position = UDim2.new(1, 40, toast.Position.Y.Scale, toast.Position.Y.Offset) },
			cachedInfo(Motion.Base, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
		)
		repositionToasts()
		task.wait(Motion.Base)
		pcall(function()
			toast:Destroy()
		end)
	end)
	return toast, lifetime
end

local function captureKeybind(callback)
	closePopup()
	Yankuiza._Capturing = true
	local theme = Yankuiza.Theme
	local overlay = add(Yankuiza._NativeGui, "TextButton", {
		Name = "KeybindCapture",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.45,
		AutoButtonColor = false,
		Text = "",
		ZIndex = Layer.Capture,
		Visible = true,
	})
	local prompt = add(overlay, "CanvasGroup", {
		Name = "Prompt",
		BackgroundColor3 = theme.Background,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 260, 0, 74),
		ZIndex = Layer.Capture + 1,
	})
	corner(prompt, 18)
	add(prompt, "TextLabel", {
		BackgroundTransparency = 1,
		Font = theme.Font,
		TextSize = 15,
		TextColor3 = theme.TextColor,
		Text = "Press any key",
		Size = UDim2.new(1, -24, 0, 26),
		Position = UDim2.new(0, 12, 0, 14),
	})
	add(prompt, "TextLabel", {
		BackgroundTransparency = 1,
		Font = theme.FontNormal,
		TextSize = 12,
		TextColor3 = theme.SubTextColor,
		Text = "ESC to cancel",
		Size = UDim2.new(1, -24, 0, 18),
		Position = UDim2.new(0, 12, 0, 42),
	})

	local connection
	connection = UserInputService.InputBegan:Connect(function(input, isProcessed)
		if isProcessed then
			return
		end
		if input.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end
		connection:Disconnect()
		Yankuiza._Capturing = false
		pcall(function()
			overlay:Destroy()
		end)
		if input.KeyCode == Enum.KeyCode.Escape then
			return
		end
		callback(input.KeyCode)
	end)
	return overlay
end

UserInputService.InputBegan:Connect(function(input, isProcessed)
	if isProcessed or input.UserInputType ~= Enum.UserInputType.Keyboard then
		return
	end
	if Yankuiza._Capturing then
		return
	end
	local key = input.KeyCode
	for _, window in pairs(Yankuiza.Windows) do
		if window.ToggleKey == key then
			window:Toggle()
		end
	end
	local element = Yankuiza.Bindings[key]
	if element then
		element:OnKeybind()
	end
end)

function Yankuiza:CreateWindow(config)
	config = config or {}
	if config.Theme then
		self:UseTheme(tostring(config.Theme))
	end
	local theme = self.Theme

	local window = {
		Name = config.Name or "Yankuiza",
		ToggleKey = config.ToggleKey or theme.ToggleKey,
		SavePath = "YankuizaLib/" .. sanitize(config.Name or "Yankuiza"),
		Elements = {},
		Flags = {},
		Tabs = {},
		Visible = false,
		_ActiveTab = nil,
		_Connections = {},
		_Gui = nil,
	}
	self.Windows[window.Name] = window
	window.Notify = function(_, title, desc, seconds)
		return Yankuiza:Notify(title, desc, seconds)
	end

	local tracked = function(connection)
		table.insert(window._Connections, connection)
		return connection
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = "YankuizaRoot_" .. sanitize(window.Name)
	gui.ResetOnSpawn = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.IgnoreGuiInset = false
	gui.DisplayOrder = 2000
	protect(gui)
	window._Gui = gui

	local totalWidth = theme.CardWidth * 2 + theme.ColumnGap

	local root = add(gui, "CanvasGroup", {
		Name = "Root",
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 22),
		Size = UDim2.new(0, totalWidth, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		GroupTransparency = 1,
		BorderSizePixel = 0,
	})

	local bar = add(root, "Frame", {
		Name = "TabBar",
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 0, 40),
		BackgroundColor3 = theme.Background,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 0),
		ZIndex = Layer.Bar,
	})
	corner(bar, 20)
	bind(bar, "BackgroundColor3", "Background")
	add(bar, "UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 4),
		VerticalAlignment = Enum.VerticalAlignment.Center,
	})
	add(bar, "UIPadding", {
		PaddingTop = UDim.new(0, 6),
		PaddingBottom = UDim.new(0, 6),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	local content = add(root, "Frame", {
		Name = "Content",
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 64),
		Size = UDim2.new(0, totalWidth, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = Layer.Content,
	})

	local dragging = false
	local dragMoved = false
	local dragStart = nil
	local startPosition = nil
	tracked(bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragMoved = false
			dragStart = input.Position
			startPosition = root.Position
		end
	end))
	tracked(UserInputService.InputChanged:Connect(function(input)
		if not dragging or not dragStart then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			local delta = input.Position - dragStart
			if math.abs(delta.X) >= DRAG_THRESHOLD or math.abs(delta.Y) >= DRAG_THRESHOLD then
				dragMoved = true
			end
			if not dragMoved then
				return
			end
			local viewport = (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize) or Vector2.new(1920, 1080)
			local targetX = startPosition.X.Offset + delta.X
			local width = root.AbsoluteSize.X
			targetX = math.clamp(targetX, -width / 2 + 16, viewport.X - width / 2 - 16)
			root.Position = UDim2.new(
				startPosition.X.Scale,
				targetX,
				startPosition.Y.Scale,
				startPosition.Y.Offset + delta.Y
			)
		end
	end))
	tracked(UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			dragStart = nil
		end
	end))

	local function makeCard(tab, cfg, height, tall)
		tab._count = (tab._count or 0) + 1
		local column = (tab._count % 2 == 1) and tab._colLeft or tab._colRight
		local card = add(column, "CanvasGroup", {
			Name = cfg.Name or "Element",
			LayoutOrder = tab._count,
			Size = UDim2.new(0, theme.CardWidth, 0, height),
			BackgroundColor3 = theme.Card,
			BorderSizePixel = 0,
			ZIndex = Layer.Content,
		})
		corner(card, 16)
		bind(card, "BackgroundColor3", "Card")
		table.insert(tab._cards, card)
		card.MouseEnter:Connect(function()
			tween(card, { BackgroundColor3 = theme.CardHover }, cachedInfo(Motion.Fast))
		end)
		card.MouseLeave:Connect(function()
			tween(card, { BackgroundColor3 = theme.Card }, cachedInfo(Motion.Fast))
		end)

		local title = add(card, "TextLabel", {
			Name = "Title",
			BackgroundTransparency = 1,
			Font = theme.Font,
			TextSize = 16,
			TextColor3 = theme.TextColor,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = cfg.Name or "Element",
			TextTruncate = Enum.TextTruncate.AtEnd,
			Position = UDim2.new(0, 14, 0, 11),
			Size = UDim2.new(0, theme.CardWidth - 120, 0, 20),
		})
		if not cfg.Desc then
			if tall then
				title.Position = UDim2.new(0, 14, 0, 11)
			else
				title.Position = UDim2.new(0, 14, 0, 0)
				title.Size = UDim2.new(0, theme.CardWidth - 120, 1, 0)
			end
		end
		if cfg.Desc then
			local descY = tall and 32 or 35
			add(card, "TextLabel", {
				Name = "Plus",
				BackgroundTransparency = 1,
				Font = theme.FontMedium,
				TextSize = 14,
				TextColor3 = theme.SubTextColor,
				Text = "+",
				Position = UDim2.new(0, 14, 0, descY),
				Size = UDim2.new(0, 14, 0, 18),
			})
			local desc = add(card, "TextLabel", {
				Name = "Desc",
				BackgroundTransparency = 1,
				Font = theme.FontNormal,
				TextSize = 13,
				TextColor3 = theme.SubTextColor,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = cfg.Desc,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Position = UDim2.new(0, 32, 0, descY),
				Size = UDim2.new(0, theme.CardWidth - 46, 0, 18),
			})
			bind(desc, "TextColor3", "SubTextColor")
		end
		return card, title
	end

	local function makeSwitch(card, state, yOffset)
		local switch = add(card, "TextButton", {
			Name = "Switch",
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			Text = "",
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -12, 0, yOffset or 10),
			Size = UDim2.new(0, 46, 0, 26),
		})
		local track = add(switch, "Frame", {
			Name = "Track",
			BackgroundColor3 = state and theme.TrackOn or theme.TrackOff,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
		})
		corner(track, 999)
		local knob = add(track, "Frame", {
			Name = "Knob",
			BackgroundColor3 = state and theme.KnobOn or theme.Knob,
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = state and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
			Size = UDim2.new(0, 20, 0, 20),
		})
		corner(knob, 999)

		local function render(animated)
			local on = state
			if animated then
				tween(track, { BackgroundColor3 = on and theme.TrackOn or theme.TrackOff }, cachedInfo(Motion.Base))
				tween(
					knob,
					{
						Position = on and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
						BackgroundColor3 = on and theme.KnobOn or theme.Knob,
					},
					cachedInfo(Motion.Base)
				)
			else
				track.BackgroundColor3 = on and theme.TrackOn or theme.TrackOff
				knob.Position = on and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
				knob.BackgroundColor3 = on and theme.KnobOn or theme.Knob
			end
		end

		local control = {
			Switch = switch,
			Set = function(value, animated)
				state = value and true or false
				render(animated ~= false)
			end,
			Get = function()
				return state
			end,
			Zone = nil,
			OnToggle = nil,
		}

		paintHook(function()
			if not alive(track) or not alive(knob) then
				return false
			end
			state = state and true or false
			local on = state
			track.BackgroundColor3 = on and theme.TrackOn or theme.TrackOff
			knob.BackgroundColor3 = on and theme.KnobOn or theme.Knob
		end)

		return control
	end

	local function elementary(target, elem, cfg)
		elem.Flag = cfg.Flag or cfg.Name
		elem.Callback = cfg.Callback
		table.insert(target.Elements, elem)
		target.Flags[elem.Flag] = elem
		if cfg.Keybind then
			elem.Bind(cfg.Keybind)
		end
	end

	local function bindableMenu(elem, dots)
		local bindLabel = elem._Bind and ("Keybind: " .. elem._Bind.Name) or "Keybind: none"
		local items = {
			{ Text = bindLabel, Disabled = true },
			{ Text = "Change keybind", Action = function() end },
		}
		items[2].Action = function()
			captureKeybind(function(key)
				if elem._Bind then
					Yankuiza.Bindings[elem._Bind] = nil
				end
				elem._Bind = key
				Yankuiza.Bindings[key] = elem
				Yankuiza:Notify("Keybind set", elem.Name .. " -> " .. key.Name, 3)
			end)
		end
		if elem._Bind then
			table.insert(items, {
				Text = "Remove keybind",
				Action = function()
					Yankuiza.Bindings[elem._Bind] = nil
					elem._Bind = nil
					Yankuiza:Notify("Keybind removed", elem.Name, 3)
				end,
			})
		end
		openPopup(dots, 170, items)
	end

	local function makeDots(card, yOffset)
		local dots = add(card, "TextButton", {
			Name = "Dots",
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			Font = theme.FontMedium,
			TextSize = 14,
			TextColor3 = Color3.fromRGB(224, 224, 224),
			Text = "•••",
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -64, 0, yOffset or 10),
			Size = UDim2.new(0, 30, 0, 26),
		})
		return dots
	end

	local function makeToggleOnCard(card, cfg, state, yOffset)
		local leftZone = add(card, "TextButton", {
			Name = "HitZone",
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			Text = "",
			Size = UDim2.new(1, -100, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
		})
		local control = makeSwitch(card, state, yOffset)
		control.Zone = leftZone
		local function press()
			if control.OnToggle then
				control.OnToggle(not control.Get())
			end
		end
		control.Switch.MouseButton1Click:Connect(press)
		leftZone.MouseButton1Click:Connect(press)
		return control
	end

	function window:CreateTab(name)
		local tab = {
			Name = name,
			Elements = {},
			Flags = {},
			_cards = {},
			_count = 0,
		}
		tab._holder = add(content, "Frame", {
			Name = name,
			Size = UDim2.new(0, totalWidth, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = Layer.Content,
		})
		tab._colLeft = add(tab._holder, "Frame", {
			Name = "Left",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0, theme.CardWidth, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
		})
		tab._colRight = add(tab._holder, "Frame", {
			Name = "Right",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0, theme.CardWidth + theme.ColumnGap, 0, 0),
			Size = UDim2.new(0, theme.CardWidth, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
		})
		for _, column in ipairs({ tab._colLeft, tab._colRight }) do
			add(column, "UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, theme.RowGap),
			})
		end

		local button = add(bar, "TextButton", {
			Name = name,
			LayoutOrder = #window.Tabs + 1,
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			Font = theme.FontMedium,
			TextSize = 16,
			TextColor3 = theme.TextColor,
			Text = name,
			Size = UDim2.new(0, 0, 0, 28),
			AutomaticSize = Enum.AutomaticSize.X,
		})
		corner(button, 999)
		add(button, "UIPadding", {
			PaddingLeft = UDim.new(0, 20),
			PaddingRight = UDim.new(0, 20),
		})
		tab._button = button

		function tab.Select()
			if window._ActiveTab == tab then
				return
			end
			if window._ActiveTab then
				window._ActiveTab._holder.Visible = false
				tween(window._ActiveTab._button, { BackgroundTransparency = 1 }, cachedInfo(Motion.Fast))
			end
			window._ActiveTab = tab
			tab._holder.Visible = true
			tween(button, { BackgroundColor3 = theme.Pill, BackgroundTransparency = 0 }, cachedInfo(Motion.Fast))
			for index, card in ipairs(tab._cards) do
				card.GroupTransparency = 1
				task.delay((index - 1) * 0.03, function()
					if alive(card) then
						tween(card, { GroupTransparency = 0 }, cachedInfo(Motion.Slow))
					end
				end)
			end
		end

		paintHook(function()
			if not alive(button) then
				return false
			end
			if window._ActiveTab == tab then
				button.BackgroundColor3 = theme.Pill
			end
		end)

		button.MouseButton1Click:Connect(function()
			if not dragMoved then
				tab.Select()
			end
		end)

		function tab.CreateToggle(cfg)
			cfg = cfg or {}
			local state = cfg.Default and true or false
			local card, title = makeCard(tab, cfg, cfg.Desc and 62 or 46)
			card.Name = cfg.Name or "Toggle"
			local dots = makeDots(card, cfg.Desc and 11 or 10)
			local control = makeToggleOnCard(card, cfg, state)

			local elem = {
				Name = cfg.Name or "Toggle",
				_Bind = nil,
				Get = function()
					return control.Get()
				end,
				Set = function(value, animated)
					control.Set(value, animated)
					if cfg.Callback then
						cfg.Callback(control.Get())
					end
				end,
				Toggle = function()
					control.Set(not control.Get())
					if cfg.Callback then
						cfg.Callback(control.Get())
					end
				end,
				Bind = function(key)
					if elem._Bind then
						Yankuiza.Bindings[elem._Bind] = nil
					end
					elem._Bind = key
					Yankuiza.Bindings[key] = elem
				end,
				Unbind = function()
					if elem._Bind then
						Yankuiza.Bindings[elem._Bind] = nil
						elem._Bind = nil
					end
				end,
				Save = function()
					return control.Get()
				end,
				Load = function(value)
					elem.Set(value == true, false)
				end,
			}
			function elem:OnKeybind()
				elem.Toggle()
			end
			table.insert(tab.Elements, elem)
			elementary(window, elem, cfg)
			control.OnToggle = function(value)
				elem.Set(value)
			end
			dots.MouseButton1Click:Connect(function()
				bindableMenu(elem, dots)
			end)
			return elem
		end

		function tab.CreateButton(cfg)
			cfg = cfg or {}
			local card, title = makeCard(tab, cfg, cfg.Desc and 62 or 46)
			card.Name = cfg.Name or "Button"
			local layer = add(card, "TextButton", {
				Name = "HitZone",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				Text = "",
				Size = UDim2.new(1, -100, 1, 0),
			})
			local dots = makeDots(card, cfg.Desc and 11 or 10)
			add(card, "TextLabel", {
				Name = "Arrow",
				BackgroundTransparency = 1,
				Font = theme.Font,
				TextSize = 16,
				TextColor3 = theme.TextColor,
				Text = ">",
				AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.new(1, -30, 0, cfg.Desc and 11 or 10),
				Size = UDim2.new(0, 22, 0, 26),
			})

			local elem = {
				Name = cfg.Name or "Button",
				_Bind = nil,
				Click = function()
					tween(card, { BackgroundColor3 = theme.CardHover }, cachedInfo(0.08))
					task.delay(0.1, function()
						if alive(card) then
							tween(card, { BackgroundColor3 = theme.Card }, cachedInfo(Motion.Fast))
						end
					end)
					if cfg.Callback then
						cfg.Callback()
					end
				end,
				Bind = function(key)
					if elem._Bind then
						Yankuiza.Bindings[elem._Bind] = nil
					end
					elem._Bind = key
					Yankuiza.Bindings[key] = elem
				end,
				Unbind = function()
					if elem._Bind then
						Yankuiza.Bindings[elem._Bind] = nil
						elem._Bind = nil
					end
				end,
			}
			function elem:OnKeybind()
				elem.Click()
			end
			table.insert(tab.Elements, elem)
			elementary(window, elem, cfg)
			layer.MouseButton1Click:Connect(function()
				elem.Click()
			end)
			dots.MouseButton1Click:Connect(function()
				bindableMenu(elem, dots)
			end)
			return elem
		end

		function tab.CreateSlider(cfg)
			cfg = cfg or {}
			local min = tonumber(cfg.Min) or 0
			local max = tonumber(cfg.Max) or 100
			local value = tonumber(cfg.Default) or min
			local suffix = cfg.Suffix or ""
			local step = tonumber(cfg.Step) or 0

			local card, title = makeCard(tab, cfg, 84, true)
			card.Name = cfg.Name or "Slider"
			local trackY = cfg.Desc and 62 or 58
			local display = add(card, "TextLabel", {
				Name = "Value",
				BackgroundTransparency = 1,
				Font = theme.Font,
				TextSize = 15,
				TextColor3 = theme.TextColor,
				TextXAlignment = Enum.TextXAlignment.Right,
				AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.new(1, -12, 0, 10),
				Size = UDim2.new(0, 80, 0, 20),
			})
			local track = add(card, "Frame", {
				Name = "Track",
				BackgroundColor3 = theme.SliderBack,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 16, 0, trackY),
				Size = UDim2.new(1, -32, 0, 6),
			})
			corner(track, 999)
			bind(track, "BackgroundColor3", "SliderBack")
			local fill = add(track, "Frame", {
				Name = "Fill",
				BackgroundColor3 = theme.SliderFill,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 0, 1, 0),
			})
			corner(fill, 999)
			bind(fill, "BackgroundColor3", "SliderFill")
			local knob = add(track, "Frame", {
				Name = "Knob",
				BackgroundColor3 = theme.Knob,
				BorderSizePixel = 0,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0, 0, 0.5, 0),
				Size = UDim2.new(0, 14, 0, 14),
			})
			corner(knob, 999)
			bind(knob, "BackgroundColor3", "Knob")
			local grabber = add(card, "TextButton", {
				Name = "Grabber",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				Text = "",
				Position = UDim2.new(0, 8, 0, trackY - 14),
				Size = UDim2.new(1, -16, 0, 28),
			})

			local function render()
				local alpha = (value - min) / math.max(max - min, 1e-9)
				display.Text = string.format("%g%s", value, suffix)
				fill.Size = UDim2.new(alpha, 0, 1, 0)
				knob.Position = UDim2.new(alpha, 0, 0.5, 0)
			end

			local function fromX(x)
				local alpha = math.clamp(
					(x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1e-9),
					0,
					1
				)
				local pending = min + (max - min) * alpha
				if step > 0 then
					pending = math.floor(pending / step + 0.5) * step
				end
				pending = math.clamp(pending, min, max)
				if pending ~= value then
					value = pending
					render()
					if cfg.Callback then
						cfg.Callback(value)
					end
				end
			end

			render()
			local active = false
			tracked(grabber.MouseButton1Down:Connect(function(input)
				active = true
				fromX(input.Position.X)
			end))
			tracked(UserInputService.InputChanged:Connect(function(input)
				if active and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					fromX(input.Position.X)
				end
			end))
			tracked(UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					active = false
				end
			end))

			local elem = {
				Name = cfg.Name or "Slider",
				Get = function()
					return value
				end,
				Set = function(v, silent)
					local pending = math.clamp(tonumber(v) or min, min, max)
					if step > 0 then
						pending = math.floor(pending / step + 0.5) * step
					end
					if pending ~= value then
						value = pending
						render()
						if cfg.Callback and not silent then
							cfg.Callback(value)
						end
					end
				end,
				Save = function()
					return value
				end,
				Load = function(v)
					elem.Set(tonumber(v))
				end,
			}
			table.insert(tab.Elements, elem)
			elementary(window, elem, cfg)
			return elem
		end

		function tab.CreateDropdown(cfg)
			cfg = cfg or {}
			local options = cfg.Options or {}
			local selected = cfg.Default or options[1]

			local card, title = makeCard(tab, cfg, 84, true)
			card.Name = cfg.Name or "Dropdown"
			local boxY = cfg.Desc and 52 or 42
			local selector = add(card, "TextButton", {
				Name = "Selector",
				AutoButtonColor = false,
				BackgroundColor3 = theme.Selector,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 16, 0, boxY),
				Size = UDim2.new(1, -32, 0, 26),
			})
			corner(selector, 8)
			bind(selector, "BackgroundColor3", "Selector")
			local label = add(selector, "TextLabel", {
				BackgroundTransparency = 1,
				Font = theme.FontMedium,
				TextSize = 13,
				TextColor3 = theme.TextColor,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = selected or "Select...",
				Position = UDim2.new(0, 12, 0, 0),
				Size = UDim2.new(1, -40, 1, 0),
				TextTruncate = Enum.TextTruncate.AtEnd,
			})
			add(selector, "TextLabel", {
				Name = "Chevron",
				BackgroundTransparency = 1,
				Font = theme.Font,
				TextSize = 8,
				TextColor3 = theme.SubTextColor,
				Text = "V",
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -10, 0.5, 0),
				Size = UDim2.new(0, 16, 0, 16),
			})

			local elem = {
				Name = cfg.Name or "Dropdown",
				Get = function()
					return selected
				end,
				Set = function(option, silent)
					selected = option
					label.Text = tostring(option)
					if cfg.Callback and not silent then
						cfg.Callback(option)
					end
				end,
				Refresh = function(newOptions)
					options = newOptions or {}
					if selected and not table.find(options, selected) then
						selected = options[1]
						label.Text = selected or "Select..."
					end
				end,
				Save = function()
					return selected
				end,
				Load = function(v)
					if v ~= nil then
						elem.Set(v)
					end
				end,
			}
			table.insert(tab.Elements, elem)
			elementary(window, elem, cfg)
			selector.MouseButton1Click:Connect(function()
				local items = {}
				for index, option in ipairs(options) do
					items[#items + 1] = {
						Text = option,
						Action = function()
							elem.Set(option)
						end,
					}
				end
				if #items > 0 then
					openPopup(selector, selector.AbsoluteSize.X, items)
				end
			end)
			return elem
		end

		function tab.CreateInput(cfg)
			cfg = cfg or {}
			local text = cfg.Default or ""

			local card, title = makeCard(tab, cfg, 84, true)
			card.Name = cfg.Name or "Input"
			local boxY = cfg.Desc and 52 or 42
			local box = add(card, "TextBox", {
				Name = "Box",
				BackgroundColor3 = theme.Selector,
				Text = "",
				PlaceholderText = cfg.Placeholder or "Type here",
				PlaceholderColor3 = theme.SubTextColor,
				TextColor3 = theme.TextColor,
				Font = theme.FontMedium,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				ClearTextOnFocus = false,
				Position = UDim2.new(0, 16, 0, boxY),
				Size = UDim2.new(1, -32, 0, 26),
			})
			corner(box, 8)
			bind(box, "BackgroundColor3", "Selector")
			add(box, "UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) })

			local elem = {
				Name = cfg.Name or "Input",
				_Silent = false,
				Get = function()
					return text
				end,
				Set = function(value, silent)
					elem._Silent = silent and true or false
					text = tostring(value or "")
					box.Text = text
				end,
				Save = function()
					return text
				end,
				Load = function(v)
					elem.Set(v)
				end,
			}
			table.insert(tab.Elements, elem)
			elementary(window, elem, cfg)
			tracked(box:GetPropertyChangedSignal("Text"):Connect(function()
				text = box.Text
				if elem._Silent then
					elem._Silent = false
					return
				end
				if cfg.Callback then
					cfg.Callback(text)
				end
			end))
			return elem
		end

		table.insert(window.Tabs, tab)
		if #window.Tabs == 1 then
			task.defer(function()
				tab.Select()
			end)
		end
		return tab
	end

	function window:SaveConfig(name)
		if not HAS_FS then
			return false, "filesystem is not available in this executor"
		end
		name = sanitize(name)
		if name == "" then
			return false, "config name is empty"
		end
		pcall(function()
			if not isfolder("YankuizaLib") then
				makefolder("YankuizaLib")
			end
			if not isfolder(self.SavePath) then
				makefolder(self.SavePath)
			end
		end)
		local data = {}
		for _, elem in ipairs(self.Elements) do
			if elem.Save then
				local value = elem.Save()
				if value ~= nil then
					data[elem.Flag or elem.Name] = value
				end
			end
		end
		local ok, err = pcall(function()
			writefile(self.SavePath .. "/" .. name .. ".json", HttpService:JSONEncode(data))
		end)
		return ok, err
	end

	function window:LoadConfig(name)
		if not HAS_FS then
			return false, "filesystem is not available in this executor"
		end
		name = sanitize(name)
		local path = self.SavePath .. "/" .. name .. ".json"
		if not isfile(path) then
			return false, "config not found"
		end
		local ok, decoded = pcall(function()
			return HttpService:JSONDecode(readfile(path))
		end)
		if not ok then
			return false, "config is corrupted"
		end
		for _, elem in ipairs(self.Elements) do
			local value = decoded[elem.Flag or elem.Name]
			if value ~= nil and elem.Load then
				pcall(function()
					elem.Load(value)
				end)
			end
		end
		return true
	end

	function window:GetConfigs()
		local names = {}
		if HAS_FS then
			local files = { pcall(listfiles, self.SavePath) }
			for _, file in ipairs(files) do
				if type(file) == "string" and file:sub(-5) == ".json" then
					table.insert(names, file:match("[\\/]" .. "([^\\/]*)%.json$") or file)
				end
			end
		end
		return names
	end

	function window:DeleteConfig(name)
		if not HAS_FS then
			return false, "filesystem is not available in this executor"
		end
		name = sanitize(name)
		local path = self.SavePath .. "/" .. name .. ".json"
		if name == "" or not isfile(path) then
			return false, "config not found"
		end
		pcall(delfile, path)
		return true
	end

	function window:AddConfigTab(title)
		local tab = window:CreateTab(title or "Configs")
		local nameInput
		local listDropdown

		nameInput = tab.CreateInput({
			Name = "Config name",
			Desc = "used when saving",
			Placeholder = "Config name",
		})
		listDropdown = tab.CreateDropdown({
			Name = "Load config",
			Desc = "pick a saved config",
			Options = window:GetConfigs(),
			Callback = function(option)
				nameInput.Set(option)
			end,
		})
		tab.CreateButton({
			Name = "Save config",
			Callback = function()
				local name = sanitize(nameInput.Get())
				if name == "" then
					Library:Notify("Save config", "type a config name first", 4)
					return
				end
				local ok, err = window:SaveConfig(name)
				if ok then
					Yankuiza:Notify("Config saved", name, 4)
					listDropdown.Refresh(window:GetConfigs())
				else
					Yankuiza:Notify("Config error", tostring(err), 5)
				end
			end,
		})
		tab.CreateButton({
			Name = "Load config",
			Callback = function()
				local name = sanitize(listDropdown.Get() or nameInput.Get() or "")
				if name == "" then
					Yankuiza:Notify("Load config", "select a config first", 4)
					return
				end
				local ok, err = window:LoadConfig(name)
				if ok then
					Yankuiza:Notify("Config loaded", name, 4)
				else
					Yankuiza:Notify("Config error", tostring(err), 5)
				end
			end,
		})
		tab.CreateButton({
			Name = "Delete config",
			Callback = function()
				local name = sanitize(listDropdown.Get() or nameInput.Get() or "")
				if name == "" then
					Yankuiza:Notify("Delete config", "select a config first", 4)
					return
				end
				local ok, err = window:DeleteConfig(name)
				if ok then
					Yankuiza:Notify("Config deleted", name, 4)
					listDropdown.Refresh(window:GetConfigs())
				else
					Yankuiza:Notify("Config error", tostring(err), 5)
				end
			end,
		})
		return tab
	end

	function window:Destroy()
		closePopup()
		for index = #self._Connections, 1, -1 do
			local connection = self._Connections[index]
			connection:Disconnect()
			self._Connections[index] = nil
		end
		for _, elem in ipairs(self.Elements) do
			if elem.Unbind then
				elem.Unbind()
			end
		end
		if alive(gui) then
			gui:Destroy()
		end
		Yankuiza.Windows[self.Name] = nil
	end

	function window:Toggle()
		window.Visible = not window.Visible
		if window.Visible then
			root.Visible = true
			root.GroupTransparency = 1
			tween(root, { GroupTransparency = 0 }, cachedInfo(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
		else
			closePopup()
			tween(root, { GroupTransparency = 1 }, cachedInfo(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.In))
			task.delay(0.2, function()
				if not window.Visible then
					root.Visible = false
				end
			end)
		end
	end

	function window:Show()
		if not window.Visible then
			window:Toggle()
		end
	end

	function window:Hide()
		if window.Visible then
			window:Toggle()
		end
	end

	function window:SetToggleKey(key)
		window.ToggleKey = key
	end

	window.Visible = config.AutoShow ~= false
	root.Visible = window.Visible
	root.GroupTransparency = window.Visible and 0 or 1

	if config.AutoLoad and HAS_FS then
		task.spawn(function()
			if not isfolder("YankuizaLib") then
				makefolder("YankuizaLib")
			end
			if not isfolder(window.SavePath) then
				makefolder(window.SavePath)
			end
			window:LoadConfig(config.AutoLoad)
		end)
	end

	return window
end

Yankuiza.Create = function(config)
	return Yankuiza:CreateWindow(config)
end

return Yankuiza
