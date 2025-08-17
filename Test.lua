local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local PlayerGui = player:WaitForChild("PlayerGui")

-- Crear GUI
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "ScriptPanel"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0,300,0,300)
Frame.Position = UDim2.new(0.5,-150,0.5,-150)
Frame.BackgroundColor3 = Color3.fromRGB(200,30,30)
Frame.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0.1,0)
Title.BackgroundTransparency = 1
Title.Text = "DuxG3n Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.new(1,1,1)

local function CreateButton(name,text,posY)
    local btn = Instance.new("TextButton", Frame)
    btn.Name = name
    btn.Text = text
    btn.Size = UDim2.new(0.8,0,0.1,0)
    btn.Position = UDim2.new(0.1,posY,0,0)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(150,0,0)
    return btn
end

local flyBtn = CreateButton("FlyBtn","Fly: OFF",60)
local jumpPlus = CreateButton("JumpPlus","+ Jump",120)
local jumpMinus = CreateButton("JumpMinus","- Jump",160)
local speedPlus = CreateButton("SpeedPlus","+ Speed",220)
local speedMinus = CreateButton("SpeedMinus","- Speed",260)
local closeBtn = CreateButton("CloseBtn","Cerrar",300)

-- Variables
local flying = false
local flySpeed = 50
local baseJump = humanoid.JumpHeight
local baseSpeed = humanoid.WalkSpeed

-- BodyVelocity para fly
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(1e5,1e5,1e5)
bodyVelocity.Velocity = Vector3.new(0,0,0)
bodyVelocity.Parent = hrp

-- Fly toggle
flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    flyBtn.Text = flying and "Fly: ON" or "Fly: OFF"
    if not flying then
        bodyVelocity.Velocity = Vector3.new(0,0,0)
    end
end)

-- Jump botones
jumpPlus.MouseButton1Click:Connect(function()
    humanoid.JumpHeight = humanoid.JumpHeight + 5
end)
jumpMinus.MouseButton1Click:Connect(function()
    humanoid.JumpHeight = math.max(baseJump, humanoid.JumpHeight - 5)
end)

-- Speed botones
speedPlus.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = math.clamp(humanoid.WalkSpeed + 5, baseSpeed, 100)
end)
speedMinus.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = math.clamp(humanoid.WalkSpeed - 5, baseSpeed, 100)
end)

-- Cerrar panel
closeBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false
end)

-- Loop fly
RunService.RenderStepped:Connect(function()
    if flying then
        bodyVelocity.Velocity = Vector3.new(0,flySpeed,0)
    else
        bodyVelocity.Velocity = Vector3.new(0,0,0)
    end
end)
