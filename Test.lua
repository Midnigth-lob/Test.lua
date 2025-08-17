local remotes = {
    " "
}

for _, name in pairs(remotes) do
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild(name)
    if remote and remote:IsA("RemoteEvent") then
        
        remote:Destroy()
        print("[ANTIKICK] Remote destruido: " .. name)
    end
end


local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScriptPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui


local Frame = Instance.new("Frame")
Frame.Name = "Main Frame"
Frame.BackgroundColor3 = Color3.new(1, 0.117647, 0)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Tittle = Instance.new("TextLabel")
Tittle.Name = "TitleLabel"
Tittle.Text = "DuxG3n Hub"
Tittle.Font = Enum.Font.GothamBold
Tittle.TextSize = 19
Tittle.BackgroundTransparency = 1
Tittle.Size = UDim2.new(1, 0, 0.2, 0)
Tittle.Parent = Frame

local function ButtonsCreates(name, text, positionY)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Text = text
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	button.TextColor3 = Color3.new(0.952941, 0.952941, 0.952941)
	button.BackgroundColor3 = Color3.fromRGB(1, 0, 0)
	button.Size = UDim2.new(0.8, 0, 0.15, 0)
	button.Position = UDim2.new(0.1, 0, positionY, 0)
	button.Parent = Frame
	return button
end

ButtonsCreates("Volar", "Fly", 0.25)
ButtonsCreates("Saltar", "JumpHeight", 0.45)
ButtonsCreates("Velocidad", "Speed", 0.65)


local closeBtn = ButtonsCreates("CloseButton", "Cerrar", 0.85)


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


local dragging = false
local dragInput, mousePos, framePos

FloatingButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		mousePos = input.Position
		framePos = FloatingButton.Position
	end
end)

FloatingButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
		local delta = input.Position - mousePos
		FloatingButton.Position = UDim2.new(
			framePos.X.Scale,
			framePos.X.Offset + delta.X,
			framePos.Y.Scale,
			framePos.Y.Offset + delta.Y
		)
	end
end)

FloatingButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

ButtonsCreates("Volar").MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local speed = 50 -- velocidad de vuelo
    local flying = false
    
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(400000,400000,400000) -- fuerza máxima
    bodyVelocity.Velocity = Vector3.new(0,0,0)
    bodyVelocity.Parent = hrp
    
    local UserInputService = game:GetService("UserInputService")
    local keysPressed = {}
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        
        if gameProcessed then return end
        
        keysPressed[input.KeyCode] = true
        
        if input.KeyCode == Enum.KeyCode.F then
            flying = not flying
            
        if not flying then
            bodyVelocity.Velocity = Vector3.new(0,0,0)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    keysPressed[input.KeyCode] = nil
end)


game:GetService("RunService").RenderStepped:Connect(function()
    if flying then
        local direction = Vector3.new(0,0,0)

        
        if keysPressed[Enum.KeyCode.W] then direction = direction + hrp.CFrame.LookVector end
        if keysPressed[Enum.KeyCode.S] then direction = direction - hrp.CFrame.LookVector end
        if keysPressed[Enum.KeyCode.A] then direction = direction - hrp.CFrame.RightVector end
        if keysPressed[Enum.KeyCode.D] then direction = direction + hrp.CFrame.RightVector end

        
        if keysPressed[Enum.KeyCode.Space] then direction = direction + Vector3.new(0,1,0) end
        if keysPressed[Enum.KeyCode.LeftShift] then direction = direction - Vector3.new(0,1,0) end

        
        bodyVelocity.Velocity = direction.Unit * speed
    end
end)    
end)

ButtonsCreates("Saltar").MouseButton1Click:Connect(function()


local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")


local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")


local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 50)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui


local barBackground = Instance.new("Frame")
barBackground.Size = UDim2.new(1, 0, 0, 10)
barBackground.Position = UDim2.new(0, 0, 0.5, -5)
barBackground.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
barBackground.Parent = frame


local slider = Instance.new("Frame")
slider.Size = UDim2.new(0, 20, 0, 20)
slider.Position = UDim2.new(0, 0, 0.5, -10)
slider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
slider.Parent = frame
slider.AnchorPoint = Vector2.new(0.5, 0.5)


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
		
		
		local scrollValue = newX / frame.AbsoluteSize.X
		
		
		humanoid.JumpHeight = scrollValue * 100 
	end
end)
end)


ButtonsCreates("Velocidad").MouseButton1Click:Connect(function()


local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")


local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")


local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 50)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui


local barBackground = Instance.new("Frame")
barBackground.Size = UDim2.new(1, 0, 0, 10)
barBackground.Position = UDim2.new(0, 0, 0.5, -5)
barBackground.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
barBackground.Parent = frame


local slider = Instance.new("Frame")
slider.Size = UDim2.new(0, 20, 0, 20)
slider.Position = UDim2.new(0, 0, 0.5, -10)
slider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
slider.Parent = frame
slider.AnchorPoint = Vector2.new(0.5, 0.5)


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
		
		
		local scrollValue = newX / frame.AbsoluteSize.X
		
		
		humanoid.JumpHeight = scrollValue * 100
	end
end)


end)
