-- LocalScript dentro de StarterPlayerScripts
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Crear ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Crear Frame del slider
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 50)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui

-- Barra de fondo
local barBackground = Instance.new("Frame")
barBackground.Size = UDim2.new(1, 0, 0, 10)
barBackground.Position = UDim2.new(0, 0, 0.5, -5)
barBackground.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
barBackground.Parent = frame

-- Slider (se puede mover)
local slider = Instance.new("Frame")
slider.Size = UDim2.new(0, 20, 0, 20)
slider.Position = UDim2.new(0, 0, 0.5, -10)
slider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
slider.Parent = frame
slider.AnchorPoint = Vector2.new(0.5, 0.5)

-- Variables para drag
local dragging = false
local mouse = game.Players.LocalPlayer:GetMouse()

slider.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
	end
end)

slider.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local newX = math.clamp(input.Position.X - frame.AbsolutePosition.X, 0, frame.AbsoluteSize.X)
		slider.Position = UDim2.new(0, newX, 0.5, 0)
		
		-- Calcular valor entre 0 y 1
		local scrollValue = newX / frame.AbsoluteSize.X
		
		-- Ajustar JumpHeight
		humanoid.JumpHeight = scrollValue * 100 -- 100 = altura máxima
	end
end)
