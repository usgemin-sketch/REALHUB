--// REAL HUB
--// Black / Orange UI
--// Supports:
--// San Diego
--// Analiz

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

local ORANGE = Color3.fromRGB(255, 110, 20)
local ORANGE_LIGHT = Color3.fromRGB(255, 145, 55)

--==================================================
-- CLEAN OLD GUI
--==================================================

local oldGui = playerGui:FindFirstChild("RealHub")
if oldGui then
	oldGui:Destroy()
end

--==================================================
-- HELPERS
--==================================================

local function tween(object, time, properties, style, direction)
	local info = TweenInfo.new(
		time or 0.3,
		style or Enum.EasingStyle.Quad,
		direction or Enum.EasingDirection.Out
	)

	return TweenService:Create(object, info, properties)
end

local function loadScript(url, name)
	task.spawn(function()

		local success, result = pcall(function()

			local source = game:HttpGet(url)

			if not source or source == "" then
				error(name .. " returned empty source")
			end

			local func, compileError = loadstring(source)

			if not func then
				error(compileError)
			end

			return func()

		end)

		if success then
			print("[RealHub] " .. name .. " loaded")
		else
			warn("[RealHub] " .. name .. " error:", result)
		end

	end)
end

--==================================================
-- SCREEN GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "RealHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 200
gui.Parent = playerGui

--==================================================
-- BACKGROUND
--==================================================

local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.fromScale(1, 1)
background.BackgroundColor3 = Color3.fromRGB(7, 7, 9)
background.BackgroundTransparency = 1
background.BorderSizePixel = 0
background.Parent = gui

-- subtle orange glow

local glow = Instance.new("Frame")
glow.Name = "Glow"
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.Position = UDim2.fromScale(0.5, 0.5)
glow.Size = UDim2.fromOffset(700, 700)
glow.BackgroundColor3 = Color3.fromRGB(120, 45, 5)
glow.BackgroundTransparency = 0.94
glow.BorderSizePixel = 0
glow.Parent = background

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(1, 0)
glowCorner.Parent = glow

--==================================================
-- MAIN WINDOW
--==================================================

local window = Instance.new("Frame")
window.Name = "Window"
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.Position = UDim2.fromScale(0.5, 0.53)
window.Size = UDim2.fromOffset(760, 480)
window.BackgroundColor3 = Color3.fromRGB(13, 13, 16)
window.BackgroundTransparency = 1
window.BorderSizePixel = 0
window.Parent = background

local windowCorner = Instance.new("UICorner")
windowCorner.CornerRadius = UDim.new(0, 18)
windowCorner.Parent = window

local windowStroke = Instance.new("UIStroke")
windowStroke.Color = ORANGE
windowStroke.Thickness = 1
windowStroke.Transparency = 1
windowStroke.Parent = window

--==================================================
-- TOP BAR
--==================================================

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 70)
topBar.BackgroundColor3 = Color3.fromRGB(17, 17, 21)
topBar.BackgroundTransparency = 1
topBar.BorderSizePixel = 0
topBar.Parent = window

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 18)
topCorner.Parent = topBar

-- orange line

local line = Instance.new("Frame")
line.Name = "OrangeLine"
line.Position = UDim2.new(0, 24, 1, -2)
line.Size = UDim2.new(0, 0, 0, 2)
line.BackgroundColor3 = ORANGE
line.BorderSizePixel = 0
line.Parent = topBar

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "REAL"
title.Font = Enum.Font.GothamBlack
title.TextSize = 25
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.TextTransparency = 1
title.Position = UDim2.new(0, 25, 0, 12)
title.Size = UDim2.fromOffset(100, 30)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local titleOrange = Instance.new("TextLabel")
titleOrange.Name = "TitleOrange"
titleOrange.Text = "HUB"
titleOrange.Font = Enum.Font.GothamBlack
titleOrange.TextSize = 25
titleOrange.TextColor3 = ORANGE
titleOrange.BackgroundTransparency = 1
titleOrange.TextTransparency = 1
titleOrange.Position = UDim2.new(0, 91, 0, 12)
titleOrange.Size = UDim2.fromOffset(100, 30)
titleOrange.TextXAlignment = Enum.TextXAlignment.Left
titleOrange.Parent = topBar

local subtitle = Instance.new("TextLabel")
subtitle.Text = "SCRIPT HUB"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 10
subtitle.TextColor3 = Color3.fromRGB(120, 120, 125)
subtitle.BackgroundTransparency = 1
subtitle.TextTransparency = 1
subtitle.Position = UDim2.new(0, 27, 0, 42)
subtitle.Size = UDim2.fromOffset(150, 18)
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = topBar

--==================================================
-- STATUS
--==================================================

local status = Instance.new("TextLabel")
status.Text = "● ONLINE"
status.Font = Enum.Font.GothamBold
status.TextSize = 11
status.TextColor3 = ORANGE
status.BackgroundTransparency = 1
status.TextTransparency = 1
status.AnchorPoint = Vector2.new(1, 0.5)
status.Position = UDim2.new(1, -25, 0.5, 0)
status.Size = UDim2.fromOffset(100, 25)
status.TextXAlignment = Enum.TextXAlignment.Right
status.Parent = topBar

--==================================================
-- CONTENT
--==================================================

local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 0, 0, 70)
content.Size = UDim2.new(1, 0, 1, -70)
content.BackgroundTransparency = 1
content.Parent = window

local welcome = Instance.new("TextLabel")
welcome.Text = "Select a script"
welcome.Font = Enum.Font.GothamBold
welcome.TextSize = 20
welcome.TextColor3 = Color3.fromRGB(235, 235, 235)
welcome.BackgroundTransparency = 1
welcome.TextTransparency = 1
welcome.Position = UDim2.new(0, 30, 0, 25)
welcome.Size = UDim2.new(1, -60, 0, 30)
welcome.TextXAlignment = Enum.TextXAlignment.Left
welcome.Parent = content

local description = Instance.new("TextLabel")
description.Text = "Choose one of the available modules below"
description.Font = Enum.Font.Gotham
description.TextSize = 12
description.TextColor3 = Color3.fromRGB(120, 120, 125)
description.BackgroundTransparency = 1
description.TextTransparency = 1
description.Position = UDim2.new(0, 30, 0, 55)
description.Size = UDim2.new(1, -60, 0, 25)
description.TextXAlignment = Enum.TextXAlignment.Left
description.Parent = content

--==================================================
-- CARD CREATOR
--==================================================

local cards = {}

local function createCard(name, desc, iconText, url, position)

	local card = Instance.new("TextButton")
	card.Name = name .. "Card"
	card.Text = ""
	card.AutoButtonColor = false
	card.AnchorPoint = Vector2.new(0.5, 0)
	card.Position = position
	card.Size = UDim2.fromOffset(310, 220)
	card.BackgroundColor3 = Color3.fromRGB(19, 19, 23)
	card.BackgroundTransparency = 1
	card.BorderSizePixel = 0
	card.Parent = content

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 15)
	corner.Parent = card

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(45, 45, 52)
	stroke.Thickness = 1
	stroke.Transparency = 1
	stroke.Parent = card

	-- icon background

	local iconBackground = Instance.new("Frame")
	iconBackground.AnchorPoint = Vector2.new(0.5, 0)
	iconBackground.Position = UDim2.new(0.5, 0, 0, 25)
	iconBackground.Size = UDim2.fromOffset(64, 64)
	iconBackground.BackgroundColor3 = Color3.fromRGB(30, 20, 15)
	iconBackground.BackgroundTransparency = 1
	iconBackground.BorderSizePixel = 0
	iconBackground.Parent = card

	local iconCorner = Instance.new("UICorner")
	iconCorner.CornerRadius = UDim.new(0, 14)
	iconCorner.Parent = iconBackground

	local icon = Instance.new("TextLabel")
	icon.Text = iconText
	icon.Font = Enum.Font.GothamBlack
	icon.TextSize = 25
	icon.TextColor3 = ORANGE
	icon.BackgroundTransparency = 1
	icon.TextTransparency = 1
	icon.Size = UDim2.fromScale(1, 1)
	icon.Parent = iconBackground

	-- name

	local cardTitle = Instance.new("TextLabel")
	cardTitle.Text = name
	cardTitle.Font = Enum.Font.GothamBold
	cardTitle.TextSize = 18
	cardTitle.TextColor3 = Color3.fromRGB(245, 245, 245)
	cardTitle.BackgroundTransparency = 1
	cardTitle.TextTransparency = 1
	cardTitle.Position = UDim2.new(0, 20, 0, 102)
	cardTitle.Size = UDim2.new(1, -40, 0, 25)
	cardTitle.Parent = card

	-- description

	local cardDescription = Instance.new("TextLabel")
	cardDescription.Text = desc
	cardDescription.Font = Enum.Font.Gotham
	cardDescription.TextSize = 11
	cardDescription.TextColor3 = Color3.fromRGB(125, 125, 132)
	cardDescription.BackgroundTransparency = 1
	cardDescription.TextTransparency = 1
	cardDescription.TextWrapped = true
	cardDescription.Position = UDim2.new(0, 20, 0, 130)
	cardDescription.Size = UDim2.new(1, -40, 0, 38)
	cardDescription.Parent = card

	-- button text

	local launch = Instance.new("TextLabel")
	launch.Text = "LAUNCH  →"
	launch.Font = Enum.Font.GothamBold
	launch.TextSize = 11
	launch.TextColor3 = ORANGE
	launch.BackgroundTransparency = 1
	launch.TextTransparency = 1
	launch.Position = UDim2.new(0, 20, 1, -40)
	launch.Size = UDim2.new(1, -40, 0, 20)
	launch.TextXAlignment = Enum.TextXAlignment.Left
	launch.Parent = card

	table.insert(cards, {
		Card = card,
		Stroke = stroke,
		IconBackground = iconBackground,
		Icon = icon,
		Title = cardTitle,
		Description = cardDescription,
		Launch = launch
	})

	--==================================================
	-- HOVER
	--==================================================

	card.MouseEnter:Connect(function()

		tween(card, 0.2, {
			BackgroundColor3 = Color3.fromRGB(25, 22, 20)
		}):Play()

		tween(stroke, 0.2, {
			Color = ORANGE,
			Transparency = 0.15
		}):Play()

		tween(iconBackground, 0.2, {
			BackgroundColor3 = Color3.fromRGB(55, 27, 10)
		}):Play()

		tween(icon, 0.2, {
			TextColor3 = ORANGE_LIGHT
		}):Play()

		tween(launch, 0.2, {
			TextColor3 = Color3.fromRGB(255, 155, 70)
		}):Play()

	end)

	card.MouseLeave:Connect(function()

		tween(card, 0.2, {
			BackgroundColor3 = Color3.fromRGB(19, 19, 23)
		}):Play()

		tween(stroke, 0.2, {
			Color = Color3.fromRGB(45, 45, 52),
			Transparency = 0.2
		}):Play()

		tween(iconBackground, 0.2, {
			BackgroundColor3 = Color3.fromRGB(30, 20, 15)
		}):Play()

		tween(icon, 0.2, {
			TextColor3 = ORANGE
		}):Play()

	end)

	--==================================================
	-- CLICK
	--==================================================

	card.MouseButton1Click:Connect(function()

		-- click animation

		tween(card, 0.08, {
			Size = UDim2.fromOffset(300, 212)
		}):Play()

		task.wait(0.08)

		tween(card, 0.12, {
			Size = UDim2.fromOffset(310, 220)
		}):Play()

		-- loading state

		local oldText = launch.Text

		launch.Text = "LOADING..."
		launch.TextColor3 = ORANGE

		loadScript(url, name)

		task.delay(1, function()
			if launch and launch.Parent then
				launch.Text = oldText
			end
		end)

	end)

end

--==================================================
-- CREATE CARDS
--==================================================

createCard(
	"San Diego",
	"San Diego script module",
	"SD",
	SAN_DIEGO_URL,
	UDim2.new(0.29, 0, 0, 105)
)

createCard(
	"Analiz",
	"Analiz script module",
	"AN",
	ANALIZ_URL,
	UDim2.new(0.71, 0, 0, 105)
)

--==================================================
-- CLOSE BUTTON
--==================================================

local closeButton = Instance.new("TextButton")
closeButton.Text = "×"
closeButton.Font = Enum.Font.Gotham
closeButton.TextSize = 25
closeButton.TextColor3 = Color3.fromRGB(130, 130, 135)
closeButton.BackgroundTransparency = 1
closeButton.Position = UDim2.new(1, -48, 0, 20)
closeButton.Size = UDim2.fromOffset(30, 30)
closeButton.Parent = topBar

closeButton.MouseEnter:Connect(function()
	tween(closeButton, 0.15, {
		TextColor3 = Color3.fromRGB(255, 80, 60)
	}):Play()
end)

closeButton.MouseLeave:Connect(function()
	tween(closeButton, 0.15, {
		TextColor3 = Color3.fromRGB(130, 130, 135)
	}):Play()
end)

closeButton.MouseButton1Click:Connect(function()

	local info = TweenInfo.new(
		0.35,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.In
	)

	tween(window, 0.35, {
		Size = UDim2.fromOffset(700, 420),
		BackgroundTransparency = 1
	}, Enum.EasingStyle.Back, Enum.EasingDirection.In):Play()

	tween(background, 0.35, {
		BackgroundTransparency = 1
	}):Play()

	task.wait(0.4)

	gui:Destroy()

end)

--==================================================
-- DRAG WINDOW
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
-- OPEN ANIMATION
--==================================================

window.Size = UDim2.fromOffset(680, 420)
window.Position = UDim2.fromScale(0.5, 0.56)

task.spawn(function()

	tween(background, 0.5, {
		BackgroundTransparency = 0
	}):Play()

	tween(window, 0.65, {
		Size = UDim2.fromOffset(760, 480),
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundTransparency = 0
	}, Enum.EasingStyle.Back):Play()

	tween(windowStroke, 0.5, {
		Transparency = 0.15
	}):Play()

	task.wait(0.15)

	tween(topBar, 0.35, {
		BackgroundTransparency = 0
	}):Play()

	tween(line, 0.5, {
		Size = UDim2.new(1, -48, 0, 2)
	}):Play()

	task.wait(0.1)

	tween(title, 0.35, {
		TextTransparency = 0
	}):Play()

	tween(titleOrange, 0.35, {
		TextTransparency = 0
	}):Play()

	tween(subtitle, 0.35, {
		TextTransparency = 0
	}):Play()

	tween(status, 0.35, {
		TextTransparency = 0
	}):Play()

	task.wait(0.15)

	tween(welcome, 0.35, {
		TextTransparency = 0
	}):Play()

	tween(description, 0.35, {
		TextTransparency = 0
	}):Play()

	task.wait(0.15)

	for _, card in ipairs(cards) do

		tween(card.Card, 0.4, {
			BackgroundTransparency = 0
		}, Enum.EasingStyle.Back):Play()

		tween(card.Stroke, 0.4, {
			Transparency = 0.2
		}):Play()

		tween(card.IconBackground, 0.4, {
			BackgroundTransparency = 0
		}):Play()

		tween(card.Icon, 0.4, {
			TextTransparency = 0
		}):Play()

		tween(card.Title, 0.4, {
			TextTransparency = 0
		}):Play()

		tween(card.Description, 0.4, {
			TextTransparency = 0
		}):Play()

		tween(card.Launch, 0.4, {
			TextTransparency = 0
		}):Play()

		task.wait(0.12)

	end

end)
