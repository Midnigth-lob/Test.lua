local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local player = game.Players.LocalPlayer
local PlayerGui = plr:WaitForChild("PlayerGui")

-- Crear ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScriptPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Frame principal
local Frame = Instance.new("Frame")
Frame.Name = "Main Frame"
Frame.BackgroundColor3 = Color3.new(1, 0.117647, 0)
Frame.Size = UDim2.new(0, 300, 0, 300)
Frame.Position = UDim2.new(0.5, -150, 0.5, -150)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- Título
local Tittle = Instance.new("TextLabel")
Tittle.Name = "TitleLabel"
Tittle.Text = "DuxG3n Hub"
Tittle.Font = Enum.Font.GothamBold
Tittle.TextSize = 19
Tittle.BackgroundTransparency = 1
Tittle.Size = UDim2.new(1, 0, 0.1, 0)
Tittle.Parent = Frame

-- Función para crear botones
local function ButtonsCreates(name, text, positionY)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Text = text
	button.Font = Enum.Font.Gotham
	button.TextSize = 16
	button.TextColor3 = Color3.new(1, 1, 1)
	button.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
	button.Size = UDim2.new(0.8, 0, 0.1, 0)
	button.Position = UDim2.new(0.1, 0, positionY, 0)
	button.Parent = Frame
	return button
end

-- Botones principales
local flyBtn = ButtonsCreates("Volar", "Fly: OFF", 0.2)
local jumpMinus = ButtonsCreates("JumpMinus", "- Jump", 0.35)
local jumpPlus = ButtonsCreates("JumpPlus", "+ Jump", 0.45)
local speedMinus = ButtonsCreates("SpeedMinus", "- Speed", 0.6)
local speedPlus = ButtonsCreates("SpeedPlus", "+ Speed", 0.7)
local closeBtn = ButtonsCreates("CloseButton", "Cerrar", 0.85)

-- Floating button
local FloatingButton = Instance.new("TextButton")
FloatingButton.Name = "FloatingButton"
FloatingButton.Text = "Abrir Panel"
FloatingButton.Font = Enum.Font.GothamBold
FloatingButton.TextSize = 14
FloatingButton.TextColor3 = Color3.new(1, 1, 1)
FloatingButton.BackgroundColor3 = Color3.fromRGB(88, 6, 6)
FloatingButton.Size = UDim2.new(0, 120, 0, 30)
FloatingButton.Position = UDim2.new(0, 10, 0, 10)
FloatingButton.Visible = false
FloatingButton.Parent = ScreenGui

-- Funcionalidad cerrar/abrir panel
closeBtn.MouseButton1Click:Connect(function()
	Frame.Visible = false
	FloatingButton.Visible = true
end)

FloatingButton.MouseButton1Click:Connect(function()
	Frame.Visible = true
	FloatingButton.Visible = false
end)

-- Variables de control
local character = plr.Character or plr.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local flying = false
local flySpeed = 50

-- Botón Fly
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
bodyVelocity.Velocity = Vector3.new(0,0,0)
bodyVelocity.Parent = hrp

flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	flyBtn.Text = flying and "Fly: ON" or "Fly: OFF"
end)

-- Botones JumpHeight
jumpPlus.MouseButton1Click:Connect(function()
	humanoid.JumpHeight = humanoid.JumpHeight + 5
end)
jumpMinus.MouseButton1Click:Connect(function()
	humanoid.JumpHeight = math.max(0, humanoid.JumpHeight - 5)
end)

-- Botones WalkSpeed
speedPlus.MouseButton1Click:Connect(function()
	humanoid.WalkSpeed = humanoid.WalkSpeed + 5
end)
speedMinus.MouseButton1Click:Connect(function()
	humanoid.WalkSpeed = math.max(0, humanoid.WalkSpeed - 5)
end)

-- Fly loop
game:GetService("RunService").RenderStepped:Connect(function()
	if flying then
		bodyVelocity.Velocity = Vector3.new(0, flySpeed, 0)
	else
		bodyVelocity.Velocity = Vector3.new(0,0,0)
	end
end)
