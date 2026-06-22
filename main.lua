-- =============================================================
-- GII CHEAT FINAL v11.0 — AUTO AIM + AUTO SHOOT + ANTI DUPE 😈🔥
-- FITUR: AUTO TEMBAK OTOMATIS + UI MUNCUL SEKALI DOANG!
-- BY: ECU (Evil Captain Underpants)
-- =============================================================

-- ANTI DUPLICATE — KALO UDAH DI EKSEKUSI, GAK MUNCUL LAGI!
if getgenv().GII_LOADED then
    return -- Udah jalan, gak usah muncul lagi!
end
getgenv().GII_LOADED = true

-- CLEANUP OLD UI
pcall(function()
    game:GetService("CoreGui"):FindFirstChild("GII_FINAL"):Destroy()
end)

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

-- SETTINGS
local Settings = {
    Aimbot = true,
    ESP = true,
    AutoShoot = true,
    ShootDelay = 0.1,
    FOV = 300,
    AimPart = "Head"
}

local LastShot = 0

-- FOV CIRCLE
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = true
FOVCircle.Radius = Settings.FOV
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Transparency = 0.7

-- ESP STORAGE
local ESPStorage = {}
local CurrentTarget = nil

-- FUNGSI BIKIN ESP BOX GEDE
local function CreateESP(player)
    if ESPStorage[player] then return end
    
    local esp = {
        Box = Drawing.new("Square"),
        BoxOutline = Drawing.new("Square"),
        HealthBg = Drawing.new("Square"),
        HealthBar = Drawing.new("Square"),
        NameTag = Drawing.new("Text"),
        HeadDot = Drawing.new("Circle")
    }
    
    esp.BoxOutline.Color = Color3.fromRGB(0, 0, 0)
    esp.BoxOutline.Thickness = 3
    esp.BoxOutline.Filled = false
    esp.BoxOutline.Transparency = 1
    
    esp.Box.Color = Color3.fromRGB(255, 0, 0)
    esp.Box.Thickness = 2
    esp.Box.Filled = false
    esp.Box.Transparency = 0.8
    
    esp.HealthBg.Color = Color3.fromRGB(30, 30, 30)
    esp.HealthBg.Filled = true
    
    esp.HealthBar.Color = Color3.fromRGB(0, 255, 0)
    esp.HealthBar.Filled = true
    
    esp.NameTag.Color = Color3.fromRGB(255, 255, 255)
    esp.NameTag.Size = 15
    esp.NameTag.Center = true
    esp.NameTag.Outline = true
    esp.NameTag.Font = 2
    
    esp.HeadDot.Color = Color3.fromRGB(255, 255, 0)
    esp.HeadDot.Radius = 8
    esp.HeadDot.Filled = true
    esp.HeadDot.Transparency = 0.8
    
    ESPStorage[player] = esp
end

local function RemoveESP(player)
    if ESPStorage[player] then
        for _, v in pairs(ESPStorage[player]) do
            pcall(function() v:Remove() end)
        end
        ESPStorage[player] = nil
    end
end

-- FUNGSI CARI MUSUH TERDEKAT
local function GetClosestEnemy()
    local closest = nil
    local closestDist = Settings.FOV
    local screenCenter = Camera.ViewportSize / 2
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local character = player.Character
        if not character then continue end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        
        local head = character:FindFirstChild("Head")
        if not head then continue end
        
        local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
        if not onScreen then continue end
        
        local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(screenCenter.X, screenCenter.Y)).Magnitude
        
        if distance < closestDist then
            closestDist = distance
            closest = player
        end
    end
    
    return closest
end

-- FUNGSI AIM KE TARGET
local function AimAtTarget(player)
    if not player or not player.Character then return end
    
    local head = player.Character:FindFirstChild("Head")
    if not head then return end
    
    Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
end

-- FUNGSI AUTO SHOOT
local function AutoShoot()
    local now = tick()
    if now - LastShot >= Settings.ShootDelay then
        -- Simulasi klik kiri / tap tembak
        VirtualUser:CaptureController()
        VirtualUser:Button1Down(Vector2.new())
        task.wait(0.05)
        VirtualUser:Button1Up(Vector2.new())
        LastShot = now
    end
end

-- MAIN LOOP
RunService.RenderStepped:Connect(function()
    local screenCenter = Camera.ViewportSize / 2
    
    -- Update FOV Circle
    FOVCircle.Position = Vector2.new(screenCenter.X, screenCenter.Y)
    FOVCircle.Visible = Settings.Aimbot
    FOVCircle.Radius = Settings.FOV
    
    -- AUTO AIM + AUTO SWITCH + AUTO SHOOT
    if Settings.Aimbot then
        -- Cek target sekarang
        if CurrentTarget then
            local char = CurrentTarget.Character
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            
            if not char or not humanoid or humanoid.Health <= 0 then
                CurrentTarget = nil
            end
        end
        
        -- Cari target baru
        if not CurrentTarget then
            CurrentTarget = GetClosestEnemy()
        end
        
        -- Aim & Shoot
        if CurrentTarget then
            AimAtTarget(CurrentTarget)
            FOVCircle.Color = Color3.fromRGB(0, 255, 0)
            
            -- AUTO SHOOT!
            if Settings.AutoShoot then
                AutoShoot()
            end
        else
            FOVCircle.Color = Color3.fromRGB(255, 0, 0)
        end
    else
        CurrentTarget = nil
        FOVCircle.Color = Color3.fromRGB(255, 0, 0)
    end
    
    -- ESP RENDER
    if not Settings.ESP then
        for p in pairs(ESPStorage) do RemoveESP(p) end
        return
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local character = player.Character
        if not character then
            RemoveESP(player)
            continue
        end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local head = character:FindFirstChild("Head")
        local hrp = character:FindFirstChild("HumanoidRootPart")
        
        if not humanoid or not head or not hrp or humanoid.Health <= 0 then
            RemoveESP(player)
            continue
        end
        
        if not ESPStorage[player] then
            CreateESP(player)
        end
        
        local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position)
        local hrpPos, hrpOnScreen = Camera:WorldToViewportPoint(hrp.Position)
        
        if headOnScreen and hrpOnScreen and ESPStorage[player] then
            local esp = ESPStorage[player]
            local height = math.abs(headPos.Y - hrpPos.Y) * 1.5
            local width = height * 0.8
            local boxX = headPos.X - width / 2
            local boxY = headPos.Y - height * 0.2
            local healthPercent = humanoid.Health / humanoid.MaxHealth
            
            -- Box
            esp.BoxOutline.Position = Vector2.new(boxX - 1, boxY - 1)
            esp.BoxOutline.Size = Vector2.new(width + 2, height + 2)
            esp.BoxOutline.Visible = true
            
            esp.Box.Position = Vector2.new(boxX, boxY)
            esp.Box.Size = Vector2.new(width, height)
            
            if player == CurrentTarget then
                esp.Box.Color = Color3.fromRGB(255, 255, 0)
                esp.Box.Thickness = 3
            else
                esp.Box.Color = Color3.fromRGB(255, 0, 0)
                esp.Box.Thickness = 2
            end
            esp.Box.Visible = true
            
            -- Health
            local barWidth = 4
            esp.HealthBg.Position = Vector2.new(boxX - barWidth - 3, boxY)
            esp.HealthBg.Size = Vector2.new(barWidth, height)
            esp.HealthBg.Visible = true
            
            local barHeight = height * healthPercent
            esp.HealthBar.Position = Vector2.new(boxX - barWidth - 3, boxY + height - barHeight)
            esp.HealthBar.Size = Vector2.new(barWidth, barHeight)
            esp.HealthBar.Color = Color3.fromHSV(healthPercent * 0.33, 1, 1)
            esp.HealthBar.Visible = true
            
            -- Nama
            esp.NameTag.Text = player.Name
            esp.NameTag.Position = Vector2.new(headPos.X, boxY - 20)
            esp.NameTag.Visible = true
            
            -- Head Dot
            esp.HeadDot.Position = Vector2.new(headPos.X, headPos.Y)
            esp.HeadDot.Visible = true
        elseif ESPStorage[player] then
            for _, v in pairs(ESPStorage[player]) do
                v.Visible = false
            end
        end
    end
    
    -- Cleanup
    for player in pairs(ESPStorage) do
        if not player.Parent then
            RemoveESP(player)
        end
    end
end)

-- =============================================
-- UI SYSTEM — ANTI DUPLICATE!
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "GII_FINAL"
ScreenGui.ResetOnSpawn = false

-- Main Menu
local MainMenu = Instance.new("Frame")
MainMenu.Parent = ScreenGui
MainMenu.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
MainMenu.BorderSizePixel = 0
MainMenu.Size = UDim2.new(0, 190, 0, 250)
MainMenu.Position = UDim2.new(0.5, -95, 0.4, -125)
MainMenu.Visible = true
MainMenu.ClipsDescendants = true

Instance.new("UICorner", MainMenu).CornerRadius = UDim.new(0, 10)
local MenuStroke = Instance.new("UIStroke", MainMenu)
MenuStroke.Color = Color3.fromRGB(255, 0, 100)
MenuStroke.Thickness = 1.5

-- Header
local Header = Instance.new("Frame")
Header.Parent = MainMenu
Header.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(1, 0, 0, 32)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "🔥 GII FINAL v11"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = Header
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Position = UDim2.new(1, -52, 0, 4)
MinimizeBtn.Text = "─"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextScaled = true
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.AutoButtonColor = false
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0)

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 60)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -24, 0, 4)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.AutoButtonColor = false
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

-- Content
local Content = Instance.new("ScrollingFrame")
Content.Parent = MainMenu
Content.BackgroundTransparency = 1
Content.Size = UDim2.new(1, 0, 1, -37)
Content.Position = UDim2.new(0, 0, 0, 37)
Content.CanvasSize = UDim2.new(0, 0, 0, 220)
Content.ScrollBarThickness = 2
Content.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 100)

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = Content
ListLayout.Padding = UDim.new(0, 3)

-- Toggle Maker
local function MakeToggle(name, default, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Content
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(45, 45, 65)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Text = " " .. name .. (default and " ✅" or " ❌")
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(45, 45, 65)
        btn.Text = " " .. name .. (state and " ✅" or " ❌")
        callback(state)
    end)
end

-- TOMBOL
MakeToggle("🎯 Auto Aim", true, function(s) Settings.Aimbot = s; FOVCircle.Visible = s; CurrentTarget = nil end)
MakeToggle("🔫 Auto Shoot", true, function(s) Settings.AutoShoot = s end)
MakeToggle("👁️ ESP Box", true, function(s) Settings.ESP = s; if not s then for p in pairs(ESPStorage) do RemoveESP(p) end end end)
MakeToggle("⚡ Speed 32", false, function(s)
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = s and 32 or 16
    end
end)
MakeToggle("🦘 Jump 150", false, function(s)
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").JumpPower = s and 150 or 50
    end
end)

-- Minimize Icon
local MinimizeIcon = Instance.new("TextButton")
MinimizeIcon.Parent = ScreenGui
MinimizeIcon.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
MinimizeIcon.Size = UDim2.new(0, 38, 0, 38)
MinimizeIcon.Position = UDim2.new(0.85, 0, 0.5, -19)
MinimizeIcon.Text = "😈"
MinimizeIcon.TextScaled = true
MinimizeIcon.Font = Enum.Font.GothamBlack
MinimizeIcon.Visible = false
MinimizeIcon.AutoButtonColor = false
Instance.new("UICorner", MinimizeIcon).CornerRadius = UDim.new(1, 0)
local IconStroke = Instance.new("UIStroke", MinimizeIcon)
IconStroke.Color = Color3.fromRGB(255, 255, 255)
IconStroke.Thickness = 1.5

-- Minimize Logic
MinimizeBtn.MouseButton1Click:Connect(function()
    MainMenu.Visible = false
    MinimizeIcon.Visible = true
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainMenu.Visible = false
    MinimizeIcon.Visible = true
end)

MinimizeIcon.MouseButton1Click:Connect(function()
    MainMenu.Visible = true
    MinimizeIcon.Visible = false
end)

-- DRAG UI
local dragging, dragStart, startPos = false
MainMenu.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainMenu.Position
    end
end)
MainMenu.InputEnded:Connect(function() dragging = false end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainMenu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- DRAG ICON
local iconDragging, iconDragStart, iconStartPos = false
MinimizeIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        iconDragging = true; iconDragStart = input.Position; iconStartPos = MinimizeIcon.Position
    end
end)
MinimizeIcon.InputEnded:Connect(function() iconDragging = false end)
UserInputService.InputChanged:Connect(function(input)
    if iconDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - iconDragStart
        MinimizeIcon.Position = UDim2.new(iconStartPos.X.Scale, iconStartPos.X.Offset + delta.X, iconStartPos.Y.Scale, iconStartPos.Y.Offset + delta.Y)
    end
end)

-- RESPAWN HANDLER
LocalPlayer.CharacterAdded:Connect(function()
    CurrentTarget = nil
    LastShot = 0
end)

print("╔══════════════════════════════════╗")
print("║ 🔥 GII FINAL v11 — LOADED!     ║")
print("║ 🎯 AUTO AIM + AUTO SHOOT      ║")
print("║ 💀 AUTO SWITCH TARGET         ║")
print("║ 📦 BOX GEDE + HEALTH          ║")
print("║ 🛡️ ANTI DUPLICATE UI         ║")
print("║ 😈 ECU ULTIMATE               ║")
print("╚══════════════════════════════════╝")
