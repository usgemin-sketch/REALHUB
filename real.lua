--// REAL HUB
--// Dark Glass / Orange
--// San Diego / Analiz / Ink Game
--// No fullscreen overlay

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local SAN_DIEGO_URL =
	"https://raw.githubusercontent.com/usgemin-sketch/REALHUB/refs/heads/main/sandiego.lua"

local ANALIZ_URL =
	"https://raw.githubusercontent.com/usgemin-sketch/REALHUB/refs/heads/main/analiz.lua"

local INK_GAME_URL =
	"https://raw.githubusercontent.com/usgemin-sketch/REALHUB/refs/heads/main/inkgame.lua"

local ORANGE = Color3.fromRGB(255, 105, 25)

--==================================================
-- REMOVE OLD GUI
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
-- MAIN WINDOW
--==================================================

local window = Instance.new("Frame")
window.Name = "Window"
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.Position = UDim2.fromScale(0.5, 0.5)
window.Size = UDim2.fromOffset(650, 350)
window.BackgroundColor3 = Color3.fromRGB(14, 14, 17)
window.BackgroundTransparency = 0.12
window.BorderSizePixel = 0
window.Parent = gui

local windowCorner = Instance.new("UICorner")
windowCorner.CornerRadius = UDim.new(0, 16)
windowCorner.Parent = window

local windowStroke = Instance.new("UIStroke")
windowStroke.Color = ORANGE
windowStroke.Thickness = 1
windowStroke.Transparency = 0.65
windowStroke.Parent = window

--==================================================
-- TOP BAR
--==================================================

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 58)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
topBar.BackgroundTransparency = 0.08
topBar.BorderSizePixel = 0
topBar.Parent = window

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 16)
topCorner.Parent = topBar

local accent = Instance.new("Frame")
accent.AnchorPoint = Vector2.new(0, 1)
accent.Position = UDim2.new(0, 20, 1, -1)
accent.Size = UDim2.new(0, 85, 0, 2)
accent.BackgroundColor3 = ORANGE
accent.BorderSizePixel = 0
accent.Parent = topBar

local accentCorner = Instance.new("UICorner")
accentCorner.CornerRadius = UDim.new(1, 0)
accentCorner.Parent = accent

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")
title.Text = "REAL"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(245, 245, 245)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 20, 0, 8)
title.Size = UDim2.fromOffset(55, 25)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local titleOrange = Instance.new("TextLabel")
titleOrange.Text = "HUB"
titleOrange.Font = Enum.Font.GothamBold
titleOrange.TextSize = 20
titleOrange.TextColor3 = ORANGE
titleOrange.BackgroundTransparency = 1
titleOrange.Position = UDim2.new(0, 72, 0, 8)
titleOrange.Size = UDim2.fromOffset(50, 25)
titleOrange.TextXAlignment = Enum.TextXAlignment.Left
titleOrange.Parent = topBar

local version = Instance.new("TextLabel")
version.Text = "v1.0"
version.Font = Enum.Font.Gotham
version.TextSize = 10
version.TextColor3 = Color3.fromRGB(110, 110, 115)
version.BackgroundTransparency = 1
version.Position = UDim2.new(0, 20, 0, 32)
version.Size = UDim2.fromOffset(100, 18)
version.TextXAlignment = Enum.TextXAlignment.Left
version.Parent = topBar

--==================================================
-- MINIMIZE
--==================================================

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "Minimize"
minimizeButton.Text = "—"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 18
minimizeButton.TextColor3 = Color3.fromRGB(160, 160, 165)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Position = UDim2.new(1, -72, 0, 13)
minimizeButton.Size = UDim2.fromOffset(28, 28)
minimizeButton.Parent = topBar

--==================================================
-- CLOSE
--==================================================

local closeButton = Instance.new("TextButton")
closeButton.Name = "Close"
closeButton.Text = "×"
closeButton.Font = Enum.Font.Gotham
closeButton.TextSize = 23
closeButton.TextColor3 = Color3.fromRGB(160, 160, 165)
closeButton.BackgroundTransparency = 1
closeButton.Position = UDim2.new(1, -39, 0, 12)
closeButton.Size = UDim2.fromOffset(28, 28)
closeButton.Parent = topBar

--==================================================
-- CONTENT
--==================================================

local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 0, 0, 58)
content.Size = UDim2.new(1, 0, 1, -58)
content.BackgroundTransparency = 1
content.Parent = window

local heading = Instance.new("TextLabel")
heading.Text = "Scripts"
heading.Font = Enum.Font.GothamBold
heading.TextSize = 19
heading.TextColor3 = Color3.fromRGB(235, 235, 238)
heading.BackgroundTransparency = 1
heading.Position = UDim2.new(0, 22, 0, 18)
heading.Size = UDim2.new(1, -44, 0, 25)
heading.TextXAlignment = Enum.TextXAlignment.Left
heading.Parent = content

local description = Instance.new("TextLabel")
description.Text = "Select a module to launch"
description.Font = Enum.Font.Gotham
description.TextSize = 11
description.TextColor3 = Color3.fromRGB(125, 125, 130)
description.BackgroundTransparency = 1
description.Position = UDim2.new(0, 22, 0, 45)
description.Size = UDim2.new(1, -44, 0, 20)
description.TextXAlignment = Enum.TextXAlignment.Left
description.Parent = content

--==================================================
-- CARDS CONTAINER
--==================================================

local cardsContainer = Instance.new("Frame")
cardsContainer.Name = "CardsContainer"
cardsContainer.Position = UDim2.new(0, 20, 0, 78)
cardsContainer.Size = UDim2.new(1, -40, 0, 190)
cardsContainer.BackgroundTransparency = 1
cardsContainer.Parent = content

local grid = Instance.new("UIGridLayout")
grid.CellSize = UDim2.fromOffset(190, 175)
grid.CellPadding = UDim2.fromOffset(12, 0)
grid.FillDirection = Enum.FillDirection.Horizontal
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.SortOrder = Enum.SortOrder.LayoutOrder
grid.Parent = cardsContainer

--==================================================
-- SCRIPT LOADER
--==================================================

local function loadScript(url, name, statusLabel)

	statusLabel.Text = "LOADING..."
	statusLabel.TextColor3 = ORANGE

	task.spawn(function()

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

			print("[RealHub] " .. name .. " loaded")

			statusLabel.Text = "LOADED"
			statusLabel.TextColor3 = Color3.fromRGB(100, 220, 130)

		else

			warn("[RealHub] " .. name .. " error:", result)

			statusLabel.Text = "ERROR"
			statusLabel.TextColor3 = Color3.fromRGB(255, 80, 70)

		end

		task.wait(1.5)

		if statusLabel and statusLabel.Parent then
			statusLabel.Text = "LAUNCH  →"
			statusLabel.TextColor3 = ORANGE
		end

	end)
end

--==================================================
-- CREATE CARD
--==================================================

local function createCard(name, shortName, desc, url, order)

	local card = Instance.new("TextButton")
	card.Name = name .. "Card"
	card.Text = ""
	card.AutoButtonColor = false
	card.Size = UDim2.fromOffset(190, 175)
	card.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
	card.BackgroundTransparency = 0.12
	card.BorderSizePixel = 0
	card.LayoutOrder = order
	card.Parent = cardsContainer

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 13)
	corner.Parent = card

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(55, 55, 60)
	stroke.Thickness = 1
	stroke.Transparency = 0.25
	stroke.Parent = card

	-- ICON

	local iconFrame = Instance.new("Frame")
	iconFrame.Position = UDim2.new(0, 16, 0, 16)
	iconFrame.Size = UDim2.fromOffset(44, 44)
	iconFrame.BackgroundColor3 = Color3.fromRGB(38, 23, 15)
	iconFrame.BackgroundTransparency = 0.15
	iconFrame.BorderSizePixel = 0
	iconFrame.Parent = card

	local iconCorner = Instance.new("UICorner")
	iconCorner.CornerRadius = UDim.new(0, 10)
	iconCorner.Parent = iconFrame

	local icon = Instance.new("TextLabel")
	icon.Text = shortName
	icon.Font = Enum.Font.GothamBold
	icon.TextSize = 13
	icon.TextColor3 = ORANGE
	icon.BackgroundTransparency = 1
	icon.Size = UDim2.fromScale(1, 1)
	icon.Parent = iconFrame

	-- TITLE

	local cardTitle = Instance.new("TextLabel")
	cardTitle.Text = name
	cardTitle.Font = Enum.Font.GothamBold
	cardTitle.TextSize = 15
	cardTitle.TextColor3 = Color3.fromRGB(240, 240, 242)
	cardTitle.BackgroundTransparency = 1
	cardTitle.Position = UDim2.new(0, 16, 0, 72)
	cardTitle.Size = UDim2.new(1, -32, 0, 23)
	cardTitle.TextXAlignment = Enum.TextXAlignment.Left
	cardTitle.Parent = card

	-- DESCRIPTION

	local cardDesc = Instance.new("TextLabel")
	cardDesc.Text = desc
	cardDesc.Font = Enum.Font.Gotham
	cardDesc.TextSize = 10
	cardDesc.TextColor3 = Color3.fromRGB(125, 125, 130)
	cardDesc.BackgroundTransparency = 1
	cardDesc.Position = UDim2.new(0, 16, 0, 100)
	cardDesc.Size = UDim2.new(1, -32, 0, 25)
	cardDesc.TextWrapped = true
	cardDesc.TextXAlignment = Enum.TextXAlignment.Left
	cardDesc.Parent = card

	-- STATUS

	local launch = Instance.new("TextLabel")
	launch.Text = "LAUNCH  →"
	launch.Font = Enum.Font.GothamBold
	launch.TextSize = 9
	launch.TextColor3 = ORANGE
	launch.BackgroundTransparency = 1
	launch.Position = UDim2.new(0, 16, 1, -30)
	launch.Size = UDim2.new(1, -32, 0, 18)
	launch.TextXAlignment = Enum.TextXAlignment.Left
	launch.Parent = card

	--==================================================
	-- HOVER
	--==================================================

	card.MouseEnter:Connect(function()

		TweenService:Create(
			card,
			TweenInfo.new(0.18),
			{
				BackgroundColor3 = Color3.fromRGB(27, 24, 22),
				BackgroundTransparency = 0.03
			}
		):Play()

		TweenService:Create(
			stroke,
			TweenInfo.new(0.18),
			{
				Color = ORANGE,
				Transparency = 0.2
			}
		):Play()

		TweenService:Create(
			iconFrame,
			TweenInfo.new(0.18),
			{
				BackgroundColor3 = Color3.fromRGB(58, 29, 12)
			}
		):Play()

	end)

	card.MouseLeave:Connect(function()

		TweenService:Create(
			card,
			TweenInfo.new(0.18),
			{
				BackgroundColor3 = Color3.fromRGB(22, 22, 26),
				BackgroundTransparency = 0.12
			}
		):Play()

		TweenService:Create(
			stroke,
			TweenInfo.new(0.18),
			{
				Color = Color3.fromRGB(55, 55, 60),
				Transparency = 0.25
			}
		):Play()

		TweenService:Create(
			iconFrame,
			TweenInfo.new(0.18),
			{
				BackgroundColor3 = Color3.fromRGB(38, 23, 15)
			
