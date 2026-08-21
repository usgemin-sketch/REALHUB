-- LocalScript: LoginScreen
-- Расположение: StarterPlayerScripts (или StarterGui)
-- Показывает экран входа. При верном пароле фейдит логин
-- и вызывает BindableEvent "AdminLoginSuccess", на который подписан RealHub скрипт.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============ НАСТРОЙКИ ============
local ADMIN_PASSWORD = "MySecretPassword123" -- поменяй на свой пароль
-- ====================================

-- Событие связи между скриптами (чисто локально, без сервера)
local loginSuccessEvent = ReplicatedStorage:FindFirstChild("AdminLoginSuccess")
if not loginSuccessEvent then
	loginSuccessEvent = Instance.new("BindableEvent")
	loginSuccessEvent.Name = "AdminLoginSuccess"
	loginSuccessEvent.Parent = ReplicatedStorage
end

-- ===================== ScreenGui =====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoginGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 100
screenGui.Parent = playerGui

local loginFrame = Instance.new("Frame")
loginFrame.Name = "LoginFrame"
loginFrame.Size = UDim2.new(1, 0, 1, 0)
loginFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
loginFrame.BackgroundTransparency = 1
loginFrame.Parent = screenGui

local loginCard = Instance.new("Frame")
loginCard.Name = "LoginCard"
loginCard.AnchorPoint = Vector2.new(0.5, 0.5)
loginCard.Position = UDim2.new(0.5, 0, 0.5, 0)
loginCard.Size = UDim2.new(0, 340, 0, 220)
loginCard.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
loginCard.BackgroundTransparency = 1
loginCard.Parent = loginFrame

local loginCorner = Instance.new("UICorner")
loginCorner.CornerRadius = UDim.new(0, 16)
loginCorner.Parent = loginCard

local loginStroke = Instance.new("UIStroke")
loginStroke.Color = Color3.fromRGB(90, 90, 255)
loginStroke.Thickness = 1.5
loginStroke.Transparency = 1
loginStroke.Parent = loginCard

local loginTitle = Instance.new("TextLabel")
loginTitle.Text = "Admin Access"
loginTitle.Font = Enum.Font.GothamBold
loginTitle.TextSize = 22
loginTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loginTitle.BackgroundTransparency = 1
loginTitle.TextTransparency = 1
loginTitle.Size = UDim2.new(1, 0, 0, 30)
loginTitle.Position = UDim2.new(0, 0, 0, 24)
loginTitle.Parent = loginCard

local passwordBox = Instance.new("TextBox")
passwordBox.Name = "PasswordBox"
passwordBox.PlaceholderText = "Введите пароль..."
passwordBox.Text = ""
passwordBox.Font = Enum.Font.Gotham
passwordBox.TextSize = 16
passwordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
passwordBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 160)
passwordBox.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
passwordBox.BackgroundTransparency = 1
passwordBox.TextTransparency = 1
passwordBox.ClearTextOnFocus = false
passwordBox.TextEditable = true
passwordBox.Size = UDim2.new(1, -48, 0, 44)
passwordBox.Position = UDim2.new(0, 24, 0, 74)
passwordBox.Parent = loginCard

local passwordBoxCorner = Instance.new("UICorner")
passwordBoxCorner.CornerRadius = UDim.new(0, 10)
passwordBoxCorner.Parent = passwordBox

local loginButton = Instance.new("TextButton")
loginButton.Name = "LoginButton"
loginButton.Text = "Войти"
loginButton.Font = Enum.Font.GothamBold
loginButton.TextSize = 16
loginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loginButton.BackgroundColor3 = Color3.fromRGB(90, 90, 255)
loginButton.BackgroundTransparency = 1
loginButton.TextTransparency = 1
loginButton.Size = UDim2.new(1, -48, 0, 42)
loginButton.Position = UDim2.new(0, 24, 0, 132)
loginButton.Parent = loginCard

local loginButtonCorner = Instance.new("UICorner")
loginButtonCorner.CornerRadius = UDim.new(0, 10)
loginButtonCorner.Parent = loginButton

local errorLabel = Instance.new("TextLabel")
errorLabel.Text = "Неверный пароль"
errorLabel.Font = Enum.Font.Gotham
errorLabel.TextSize = 13
errorLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
errorLabel.BackgroundTransparency = 1
errorLabel.TextTransparency = 1
errorLabel.Size = UDim2.new(1, 0, 0, 18)
errorLabel.Position = UDim2.new(0, 0, 0, 184)
errorLabel.Parent = loginCard

-- ===================== АНИМАЦИИ =====================

local function fadeInLogin()
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	TweenService:Create(loginFrame, tweenInfo, { BackgroundTransparency = 0.15 }):Play()
	TweenService:Create(loginCard, tweenInfo, { BackgroundTransparency = 0 }):Play()
	TweenService:Create(loginStroke, tweenInfo, { Transparency = 0.4 }):Play()

	task.wait(0.15)
	TweenService:Create(loginTitle, tweenInfo, { TextTransparency = 0 }):Play()
	task.wait(0.08)
	TweenService:Create(passwordBox, tweenInfo, { BackgroundTransparency = 0, TextTransparency = 0 }):Play()
	task.wait(0.08)
	TweenService:Create(loginButton, tweenInfo, { BackgroundTransparency = 0, TextTransparency = 0 }):Play()
end

local function showError()
	errorLabel.TextTransparency = 0
	local shakeInfo = TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 3, true)
	TweenService:Create(loginCard, shakeInfo, { Position = loginCard.Position + UDim2.new(0, 8, 0, 0) }):Play()
	task.wait(1.5)
	TweenService:Create(errorLabel, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
end

local function fadeOutLogin()
	local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	TweenService:Create(loginCard, tweenInfo, { BackgroundTransparency = 1 }):Play()
	TweenService:Create(loginStroke, tweenInfo, { Transparency = 1 }):Play()
	TweenService:Create(loginTitle, tweenInfo, { TextTransparency = 1 }):Play()
	TweenService:Create(passwordBox, tweenInfo, { BackgroundTransparency = 1, TextTransparency = 1 }):Play()
	TweenService:Create(loginButton, tweenInfo, { BackgroundTransparency = 1, TextTransparency = 1 }):Play()
	TweenService:Create(loginFrame, tweenInfo, { BackgroundTransparency = 1 }):Play()
	task.wait(0.4)
	screenGui:Destroy()
end

-- ===================== ЛОГИКА ВХОДА =====================

local function attemptLogin()
	local entered = passwordBox.Text

	if entered == ADMIN_PASSWORD then
		fadeOutLogin()
		-- Сообщаем второму скрипту (RealHub), что вход выполнен успешно
		loginSuccessEvent:Fire()
	else
		showError()
	end
end

loginButton.MouseButton1Click:Connect(attemptLogin)

passwordBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		attemptLogin()
	end
end)

fadeInLogin()
