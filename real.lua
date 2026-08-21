-- LocalScript: RealHub
-- Расположение: StarterPlayerScripts (или StarterGui)
-- Ждёт BindableEvent "AdminLoginSuccess" от скрипта LoginScreen,
-- после этого плавно появляется меню Real Hub.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============ НАСТРОЙКИ ============
local GAMES = {
	{ Name = "San Diego", Icon = "rbxassetid://0" },
}
-- ====================================

-- Событие связи между скриптами
local loginSuccessEvent = ReplicatedStorage:FindFirstChild("AdminLoginSuccess")
if not loginSuccessEvent then
	loginSuccessEvent = Instance.new("BindableEvent")
	loginSuccessEvent.Name = "AdminLoginSuccess"
	loginSuccessEvent.Parent = ReplicatedStorage
end

-- ===================== ScreenGui =====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RealHubGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 90
screenGui.Parent = playerGui

local hubFrame = Instance.new("Frame")
hubFrame.Name = "HubFrame"
hubFrame.Size = UDim2.new(1, 0, 1, 0)
hubFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
hubFrame.BackgroundTransparency = 1
hubFrame.Visible = false
hubFrame.Parent = screenGui

local hubTitle = Instance.new("TextLabel")
hubTitle.Name = "HubTitle"
hubTitle.Text = "Real Hub"
hubTitle.Font = Enum.Font.GothamBold
hubTitle.TextSize = 48
hubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
hubTitle.BackgroundTransparency = 1
hubTitle.TextTransparency = 1
hubTitle.AnchorPoint = Vector2.new(0.5, 0)
hubTitle.Position = UDim2.new(0.5, 0, 0.12, 0)
hubTitle.Size = UDim2.new(0, 400, 0, 60)
hubTitle.Parent = hubFrame

local hubTitleGradient = Instance.new("UIGradient")
hubTitleGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 130, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
})
hubTitleGradient.Rotation = 90
hubTitleGradient.Parent = hubTitle

local hubSubtitle = Instance.new("TextLabel")
hubSubtitle.Text = "Выбери игру"
hubSubtitle.Font = Enum.Font.Gotham
hubSubtitle.TextSize = 18
hubSubtitle.TextColor3 = Color3.fromRGB(170, 170, 180)
hubSubtitle.BackgroundTransparency = 1
hubSubtitle.TextTransparency = 1
hubSubtitle.AnchorPoint = Vector2.new(0.5, 0)
hubSubtitle.Position = UDim2.new(0.5, 0, 0.12, 62)
hubSubtitle.Size = UDim2.new(0, 300, 0, 26)
hubSubtitle.Parent = hubFrame

-- Панель с играми снизу
local gamesBar = Instance.new("Frame")
gamesBar.Name = "GamesBar"
gamesBar.AnchorPoint = Vector2.new(0.5, 1)
gamesBar.Position = UDim2.new(0.5, 0, 1, -30)
gamesBar.Size = UDim2.new(0, 900, 0, 150)
gamesBar.BackgroundTransparency = 1
gamesBar.Parent = hubFrame

local gamesLayout = Instance.new("UIListLayout")
gamesLayout.FillDirection = Enum.FillDirection.Horizontal
gamesLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
gamesLayout.VerticalAlignment = Enum.VerticalAlignment.Center
gamesLayout.Padding = UDim.new(0, 16)
gamesLayout.Parent = gamesBar

local gameCards = {}

for i, gameData in ipairs(GAMES) do
	local card = Instance.new("TextButton")
	card.Name = "GameCard_" .. gameData.Name
	card.Text = ""
	card.Size = UDim2.new(0, 130, 0, 150)
	card.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
	card.BackgroundTransparency = 1
	card.AutoButtonColor = false
	card.LayoutOrder = i
	card.Parent = gamesBar

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 14)
	cardCorner.Parent = card

	local cardStroke = Instance.new("UIStroke")
	cardStroke.Color = Color3.fromRGB(90, 90, 255)
	cardStroke.Thickness = 1.5
	cardStroke.Transparency = 1
	cardStroke.Parent = card

	local icon = Instance.new("ImageLabel")
	icon.Image = gameData.Icon
	icon.BackgroundTransparency = 1
	icon.ImageTransparency = 1
	icon.Size = UDim2.new(0, 64, 0, 64)
	icon.AnchorPoint = Vector2.new(0.5, 0)
	icon.Position = UDim2.new(0.5, 0, 0, 18)
	icon.Parent = card

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Text = gameData.Name
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextSize = 14
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameLabel.TextTransparency = 1
	nameLabel.BackgroundTransparency = 1
	nameLabel.Size = UDim2.new(1, -10, 0, 40)
	nameLabel.Position = UDim2.new(0, 5, 0, 96)
	nameLabel.TextWrapped = true
	nameLabel.Parent = card

	table.insert(gameCards, {
		Card = card,
		Stroke = cardStroke,
		Icon = icon,
		Label = nameLabel,
	})

	card.MouseEnter:Connect(function()
		TweenService:Create(card, TweenInfo.new(0.2), { Size = UDim2.new(0, 138, 0, 158) }):Play()
		TweenService:Create(cardStroke, TweenInfo.new(0.2), { Transparency = 0.3 }):Play()
	end)
	card.MouseLeave:Connect(function()
		TweenService:Create(card, TweenInfo.new(0.2), { Size = UDim2.new(0, 130, 0, 150) }):Play()
		TweenService:Create(cardStroke, TweenInfo.new(0.2), { Transparency = 1 }):Play()
	end)

	card.MouseButton1Click:Connect(function()
		-- Сюда позже добавишь свою логику (телепорт, смена карты и т.д.)
		print("Выбрана игра: " .. gameData.Name)

		local originalSize = UDim2.new(0, 130, 0, 150)
		TweenService:Create(card, TweenInfo.new(0.08), { Size = UDim2.new(0, 118, 0, 138) }):Play()
		task.wait(0.08)
		TweenService:Create(card, TweenInfo.new(0.12), { Size = originalSize }):Play()
	end)
end

-- ===================== АНИМАЦИЯ ПОЯВЛЕНИЯ =====================

local function fadeInHub()
	hubFrame.Visible = true
	local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	TweenService:Create(hubFrame, tweenInfo, { BackgroundTransparency = 0 }):Play()
	task.wait(0.1)
	TweenService:Create(hubTitle, tweenInfo, { TextTransparency = 0 }):Play()
	task.wait(0.1)
	TweenService:Create(hubSubtitle, tweenInfo, { TextTransparency = 0 }):Play()

	task.wait(0.15)
	for i, entry in ipairs(gameCards) do
		task.spawn(function()
			local cardTween = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
			TweenService:Create(entry.Card, cardTween, { BackgroundTransparency = 0.05 }):Play()
			TweenService:Create(entry.Icon, TweenInfo.new(0.4), { ImageTransparency = 0 }):Play()
			TweenService:Create(entry.Label, TweenInfo.new(0.4), { TextTransparency = 0 }):Play()
		end)
		task.wait(0.08)
	end
end

-- ===================== ОЖИДАНИЕ СОБЫТИЯ =====================

loginSuccessEvent.Event:Connect(function()
	fadeInHub()
end)
