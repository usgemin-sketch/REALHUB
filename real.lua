--// REAL HUB
--// Black / Orange
--// Minimize + Close + Drag
--// San Diego + Analiz

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- ССЫЛКИ
--==================================================

local SAN_DIEGO_URL =
	"https://raw.githubusercontent.com/usgemin-sketch/REALHUB/refs/heads/main/sandiego.lua"

local ANALIZ_URL =
	"https://raw.githubusercontent.com/usgemin-sketch/REALHUB/refs/heads/main/analiz.lua"

local ORANGE = Color3.fromRGB(255, 105, 20)
local ORANGE_DARK = Color3.fromRGB(55, 25, 10)
local BG = Color3.fromRGB(12, 12, 15)
local PANEL = Color3.fromRGB(19, 19, 23)

--==================================================
-- УДАЛЯЕМ СТАРУЮ ВЕРСИЮ
--==================================================

local oldGui = playerGui:FindFirstChild("RealHub")

if oldGui then
	oldGui:Destroy()
end

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "RealHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 200
gui.Parent = playerGui

--==================================================
-- ОСНОВНОЕ ОКНО
--==================================================

local window = Instance.new("Frame")
window.Name = "Window"
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.Position = UDim2.fromScale(0.5, 0.5)
window.Size = UDim2.fromOffset(520, 340)
window.BackgroundColor3 = BG
window.BorderSizePixel = 0
window.Parent = gui

local windowCorner = Instance.new("UICorner")
windowCorner.CornerRadius = UDim.new(0, 14)
windowCorner.Parent = window

local windowStroke = Instance.new("UIStroke")
windowStroke.Color = ORANGE
windowStroke.Thickness = 1
windowStroke.Transparency = 0.35
windowStroke.Parent = window

--==================================================
-- TOP BAR
--==================================================

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 48)
topBar.BackgroundColor3 = PANEL
topBar.BorderSizePixel = 0
topBar.Parent = window

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 14)
topCorner.Parent = topBar

-- нижняя оранжевая линия

local orangeLine = Instance.new("Frame")
orangeLine.AnchorPoint = Vector2.new(0, 1)
orangeLine.Position = UDim2.new(0, 15, 1, 0)
orangeLine.Size = UDim2.new(1, -30, 0, 2)
orangeLine.BackgroundColor3 = ORANGE
orangeLine.BorderSizePixel = 0
orangeLine.Parent = topBar

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")
title.Text = "REAL"
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(245, 245, 245)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 18, 0, 7)
title.Size = UDim2.fromOffset(55, 30)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local titleOrange = Instance.new("TextLabel")
titleOrange.Text = "HUB"
titleOrange.Font = Enum.Font.GothamBlack
titleOrange.TextSize = 20
titleOrange.TextColor3 = ORANGE
titleOrange.BackgroundTransparency = 1
titleOrange.Position = UDim2.new(0, 70, 0, 7)
titleOrange.Size = UDim2.fromOffset(50, 30)
titleOrange.TextXAlignment = Enum.TextXAlignment.Left
titleOrange.Parent = topBar

--==================================================
-- КНОПКА СВЕРНУТЬ
--==================================================

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "Minimize"
minimizeButton.Text = "—"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 20
minimizeButton.TextColor3 = Color3.fromRGB(180, 180, 185)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Position = UDim2.new(1, -72, 0, 7)
minimizeButton.Size = UDim2.fromOffset(30, 30)
minimizeButton.Parent = topBar

--==================================================
-- КНОПКА ЗАКРЫТЬ
--==================================================

local closeButton = Instance.new("TextButton")
closeButton.Name = "Close"
closeButton.Text = "×"
closeButton.Font = Enum.Font.Gotham
closeButton.TextSize = 24
closeButton.TextColor3 = Color3.fromRGB(180, 180, 185)
closeButton.BackgroundTransparency = 1
closeButton.Position = UDim2.new(1, -38, 0, 7)
closeButton.Size = UDim2.fromOffset(30, 30)
closeButton.Parent = topBar

--==================================================
-- КОНТЕНТ
--==================================================

local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 0, 0, 48)
content.Size = UDim2.new(1, 0, 1, -48)
content.BackgroundTransparency = 1
content.Parent = window

local heading = Instance.new("TextLabel")
heading.Text = "Scripts"
heading.Font = Enum.Font.GothamBold
heading.TextSize = 22
heading.TextColor3 = Color3.fromRGB(240, 240, 240)
heading.BackgroundTransparency = 1
heading.Position = UDim2.new(0, 22, 0, 20)
heading.Size = UDim2.new(1, -44, 0, 30)
heading.TextXAlignment = Enum.TextXAlignment.Left
heading.Parent = content

local subheading = Instance.new("TextLabel")
subheading.Text = "Select a script to launch"
subheading.Font = Enum.Font.Gotham
subheading.TextSize = 12
subheading.TextColor3 = Color3.fromRGB(120, 120, 125)
subheading.BackgroundTransparency = 1
subheading.Position = UDim2.new(0, 22, 0, 50)
subheading.Size = UDim2.new(1, -44, 0, 22)
subheading.TextXAlignment = Enum.TextXAlignment.Left
subheading.Parent = content

--==================================================
-- ЗАГРУЗКА СКРИПТА
--==================================================

local function loadScript(url, scriptName, button)
	task.spawn(function()

		local oldText = button.Text

		button.Text = "Loading..."
		button.AutoButtonColor = false

		local success, result = pcall(function()

			local source = game:HttpGet(url)

			if not source or source == "" then
				error("Empty response")
			end

			local func, compileError = loadstring(source)

			if not func then
				error(compileError)
			end

			return func()
		end)

		if success then
			print("[RealHub] " .. scriptName .. " loaded")
			button.Text = "Loaded"
		else
			warn("[RealHub] " .. scriptName .. " failed:", result)
			button.Text = "Error"
		end

		task.wait(1)

		if button and button.Parent then
			button.Text = oldText
			button.AutoButtonColor = true
		end

	end)
end

--==================================================
-- СОЗДАНИЕ КНОПКИ
--==================================================

local function createScriptButton(name, description, x, url)

	local button = Instance.new("TextButton")
	button.Name = name
	button.Text = ""
	button.AutoButtonColor = false
	button.BackgroundColor3 = PANEL
	button.BorderSizePixel = 0
	button.Position = UDim2.new(x, 0, 0, 92)
	button.Size = UDim2.fromOffset(225, 150)
	button.Parent = content

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(45, 45, 50)
	stroke.Thickness = 1
	stroke.Parent = button

	-- Иконка

	local icon = Instance.new("TextLabel")
	icon.Text = string.sub(name, 1, 2):upper()
	icon.Font = Enum.Font.GothamBlack
	icon.TextSize = 20
	icon.TextColor3 = ORANGE
	icon.BackgroundColor3 = ORANGE_DARK
	icon.BackgroundTransparency = 0
	icon.Position = UDim2.new(0, 18, 0, 18)
	icon.Size = UDim2.fromOffset(50, 50)
	icon.Parent = button

	local iconCorner = Instance.new("UICorner")
	iconCorner.CornerRadius = UDim.new(0, 10)
	iconCorner.Parent = icon

	-- Название

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Text = name
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextSize = 17
	nameLabel.TextColor3 = Color3.fromRGB(245, 245, 245)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Position = UDim2.new(0, 18, 0, 78)
	nameLabel.Size = UDim2.new(1, -36, 0, 24)
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = button

	-- Описание

	local descLabel = Instance.new("TextLabel")
	descLabel.Text = description
	descLabel.Font = Enum.Font.Gotham
	descLabel.TextSize = 11
	descLabel.TextColor3 = Color3.fromRGB(120, 120, 125)
	descLabel.BackgroundTransparency = 1
	descLabel.Position = UDim2.new(0, 18, 0, 104)
	descLabel.Size = UDim2.new(1, -36, 0, 20)
	descLabel.TextXAlignment = Enum.TextXAlignment.Left
	descLabel.Parent = button

	-- Статус

	local launchLabel = Instance.new("TextLabel")
	launchLabel.Text = "LAUNCH  →"
	launchLabel.Font = Enum.Font.GothamBold
	launchLabel.TextSize = 10
	launchLabel.TextColor3 = ORANGE
	launchLabel.BackgroundTransparency = 1
	launchLabel.Position = UDim2.new(0, 18, 1, -28)
	launchLabel.Size = UDim2.new(1, -36, 0, 18)
	launchLabel.TextXAlignment = Enum.TextXAlignment.Left
	launchLabel.Parent = button

	-- Hover

	button.MouseEnter:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.18),
			{
				BackgroundColor3 = Color3.fromRGB(27, 23, 20)
			}
		):Play()

		TweenService:Create(
			stroke,
			TweenInfo.new(0.18),
			{
				Color = ORANGE,
				Transparency = 0.1
			}
		):Play()

		TweenService:Create(
			icon,
			TweenInfo.new(0.18),
			{
				BackgroundColor3 = Color3.fromRGB(75, 30, 8)
			}
		):Play()

	end)

	button.MouseLeave:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.18),
			{
				BackgroundColor3 = PANEL
			}
		):Play()

		TweenService:Create(
			stroke,
			TweenInfo.new(0.18),
			{
				Color = Color3.fromRGB(45, 45, 50),
				Transparency = 0
			}
		):Play()

		TweenService:Create(
			icon,
			TweenInfo.new(0.18),
			{
				BackgroundColor3 = ORANGE_DARK
			}
		):Play()

	end)

	-- Click

	button.MouseButton1Click:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.07),
			{
				Size = UDim2.fromOffset(218, 145)
			}
		):Play()

		task.wait(0.07)

		TweenService:Create(
			button,
			TweenInfo.new(0.12),
			{
				Size = UDim2.fromOffset(225, 150)
			}
		):Play()

		loadScript(url, name, launchLabel)

	end)

end

--==================================================
-- ДВЕ КНОПКИ
--==================================================

createScriptButton(
	"San Diego",
	"San Diego script",
	0.26,
	SAN_DIEGO_URL
)

createScriptButton(
	"Analiz",
	"Analiz script",
	0.74,
	ANALIZ_URL
)

--==================================================
-- СВЕРНУТЬ
--==================================================

local minimized = false
local normalSize = UDim2.fromOffset(520, 340)
local minimizedSize = UDim2.fromOffset(520, 48)

minimizeButton.MouseButton1Click:Connect(function()

	minimized = not minimized

	if minimized then

		TweenService:Create(
			window,
			TweenInfo.new(0.3, Enum.EasingStyle.Quad),
			{
				Size = minimizedSize
			}
		):Play()

		minimizeButton.Text = "+"

	else

		TweenService:Create(
			window,
			TweenInfo.new(0.3, Enum.EasingStyle.Back),
			{
				Size = normalSize
			}
		):Play()

		minimizeButton.Text = "—"

	end

end)

--==================================================
-- ЗАКРЫТЬ
--==================================================

closeButton.MouseButton1Click:Connect(function()

	TweenService:Create(
		window,
		TweenInfo.new(
			0.25,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.In
		),
		{
			Size = UDim2.fromOffset(450, 40)
		}
	):Play()

	task.wait(0.25)

	gui:Destroy()

end)

--==================================================
-- HOVER КНОПОК ОКНА
--==================================================

minimizeButton.MouseEnter:Connect(function()
	minimizeButton.TextColor3 = ORANGE
end)

minimizeButton.MouseLeave:Connect(function()
	minimizeButton.TextColor3 = Color3.fromRGB(180, 180, 185)
end)

closeButton.MouseEnter:Connect(function()
	closeButton.TextColor3 = Color3.fromRGB(255, 70, 50)
end)

closeButton.MouseLeave:Connect(function()
	closeButton.TextColor3 = Color3.fromRGB(180, 180, 185)
end)

--==================================================
-- ПЕРЕТАСКИВАНИЕ
--==================================================

local dragging = false
local dragStart
local startPosition

topBar.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then

		dragging = true
		dragStart = input.Position
		startPosition = window.Position

	end

end)

topBar.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement then

		local delta = input.Position - dragStart

		window.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)

	end

end)

--==================================================
-- ПОЯВЛЕНИЕ
--==================================================

window.Size = UDim2.fromOffset(480, 300)

TweenService:Create(
	window,
	TweenInfo.new(
		0.4,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out
	),
	{
		Size = normalSize
	}
):Play()
