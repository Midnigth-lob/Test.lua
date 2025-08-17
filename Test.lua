local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Crear GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScriptPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Name = "Main Frame"
Frame.BackgroundColor3 = Color3.new(1, 0.117647, 0)
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Name = "TitleLabel"
Title.Text = "DuxG3n Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 19
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.TextColor3 = Color3.new(1,1,1)
Title.Parent = Frame

local function ButtonsCreates(name, text, positionY)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Text = text
	button.Font = Enum.Font.Gotham
	button.TextSize = 16
	button.TextColor3 = Color3.new(1, 1, 1)
	button.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
	button.Size = UDim2.new(0.8, 0, 0.08, 0)
	button.Position = UDim2.new(0.1, 0, positionY, 0)
	button.Parent = Frame
	return button
end

-- Botones
local flyBtn = ButtonsCreates("Volar", "Fly: OFF", 0.2)
local upBtn = ButtonsCreates("FlyUp", "Subir", 0.3)
local downBtn = ButtonsCreates("FlyDown", "Bajar", 0.38)
local jumpMinus = ButtonsCreates("JumpMinus", "- Jump", 0.48)
local jumpPlus = ButtonsCreates("JumpPlus", "+ Jump", 0.56)
local speedMinus = ButtonsCreates("SpeedMinus", "- Speed", 0.66)
local speedPlus = ButtonsCreates("SpeedPlus", "+ Speed", 0.74)
local closeBtn = ButtonsCreates("CloseButton", "Cerrar", 0.85)

-- Botón flotante
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

closeBtn.MouseButton1Click:Connect(function()
	Frame.Visible = false
	FloatingButton.Visible = true
end)
FloatingButton.MouseButton1Click:Connect(function()
	Frame.Visible = true
	FloatingButton.Visible = false
end)

-- Variables
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local flying = false
local flySpeed = 50
local flyY = 0

-- BodyVelocity para fly
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(1e5,1e5,1e5)
bodyVelocity.Velocity = Vector3.new(0,0,0)
bodyVelocity.Parent = hrp

-- Fly toggle
flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	flyBtn.Text = flying and "Fly: ON" or "Fly: OFF"
	if not flying then flyY = 0 end
end)

-- Botones Fly Up/Down
upBtn.MouseButton1Click:Connect(function()
	if flying then flyY = flySpeed end
end)
downBtn.MouseButton1Click:Connect(function()
	if flying then flyY = -flySpeed end
end)

-- JumpHeight y WalkSpeed
local baseJump = humanoid.JumpHeight
local baseSpeed = humanoid.WalkSpeed

jumpPlus.MouseButton1Click:Connect(function()
	humanoid.JumpHeight = humanoid.JumpHeight + 5
end)
jumpMinus.MouseButton1Click:Connect(function()
	humanoid.JumpHeight = math.max(0, humanoid.JumpHeight - 5)
end)
speedPlus.MouseButton1Click:Connect(function()
	humanoid.WalkSpeed = humanoid.WalkSpeed + 5
end)
speedMinus.MouseButton1Click:Connect(function()
	humanoid.WalkSpeed = math.max(0, humanoid.WalkSpeed - 5)
end)

-- Fly loop
RunService.RenderStepped:Connect(function()
	if flying then
		local moveDir = humanoid.MoveDirection
		bodyVelocity.Velocity = moveDir * flySpeed + Vector3.new(0,flyY,0)
	else
		bodyVelocity.Velocity = Vector3.new(0,0,0)
	end
end)
