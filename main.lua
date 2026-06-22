-- =============================================================
-- GII CHEAT v12.0 — AUTO AIM STICKY + PRIORITY TERDEKAT 😈🔥
-- AIMBOT TETAP NEMPEL MESKI LAYAR DIGERAKIN!
-- PRIORITAS: MUSUH TERDEKAT DULU BARU YANG LAIN!
-- BY: ECU (Evil Captain Underpants)
-- =============================================================

-- ANTI DUPLICATE
if getgenv().GII_LOADED then return end
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
    ShootDelay = 0.08,
    FOV = 350,
    AimPart = "Head",
    StickyAim = true,        -- AIM TETAP NEMPEL!
    TargetSwitchDelay = 0.3  -- Delay ganti target (hindarin geter)
}

local LastShot = 0
local TargetSwitchTime = 0

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
local StickyTarget = nil

-- FUNGSI BIKIN ESP BOX GEDE
local function CreateESP(player)
    if ESPStorage[player] then return end
    
    local esp = {
        Box = Drawing.new("Square"),
        BoxOutline = Drawing.new("Square"),
        HealthBg = Drawing.new("Square"),
        HealthBar = Drawing.new("Square"),
        NameTag = Drawing.new("Text"),
        DistTag = Drawing.new("Text"),
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
    
    esp.DistTag.Color = Color3.fromRGB(255, 200, 0)
    esp.DistTag.Size = 13
    esp.DistTag.Center = true
    esp.DistTag.Outline = true
    esp.DistTag.Font = 2
    
    esp.HeadDot.Color = Color3.fromRGB(255, 255, 0)
    esp.HeadDot.Radius = 10
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

-- FUNGSI CARI MUSUH TERDEKAT (PRIORITY: JARAK DUNIA NYATA)
local function GetClosestEnemy()
    local closest = nil
    local closestDist = 999999 -- Jarak dunia nyata, bukan layar!
    local localHead = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
    
    if not localHead then return nil end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local character = player.Character
        if not character then continue end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        
        local head = character:FindFirstChild("Head")
        if not head then continue end
        
        -- Cek jarak dunia nyata (bukan layar)
        local worldDist = (localHead.Position - head.Position).Magnitude
        
        -- Cek apakah musuh di depan kita (gak di belakang)
        local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
        
        -- Prioritas: musuh terdekat yang visible
        if worldDist < closestDist then
            closestDist = worldDist
            closest = player
        end
    end
    
    return closest
end

-- FUNGSI CARI MUSUH TERDEKAT DI FOV (BUAT STICKY AIM)
local function GetClosestInFOV()
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

-- FUNGSI AIM KE TARGET (PAKSA NEMPEL MESKI LAYAR DIGERAKIN)
local function ForceAimAtTarget(player)
    if not player or not player.Character then return false end
    
    local head = player.Character:FindFirstChild("Head")
    if not head then return false end
    
    -- PAKSA KAMERA LOCK KE KEPALA MUSUH!
    -- Pake CFrame langsung, gak peduli input user!
    local lookAt = CFrame.lookAt(Camera.CFrame.Position, head.Position)
    Camera.CFrame = lookAt
    
    return true
end

-- FUNGSI AUTO SHOOT
local function AutoShoot()
    local now = tick()
    if now - LastShot >= Settings.ShootDelay then
        VirtualUser:CaptureController()
        VirtualUser:Button1Down(Vector2.new())
        task.wait(0.03)
        VirtualUser:Button1Up(Vector2.new())
        LastShot = now
    end
end

-- FUNGSI CEK APAKAH TARGET MASIH VALID
local function IsTargetValid(player)
    if not player then return false
    local char = player.Character
    if not char then return false
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false
    local head = char:FindFirstChild("Head")
    if not head then return false
    return true
end

-- MAIN LOOP
RunService.RenderStepped:Connect(function()
    local screenCenter = Camera.ViewportSize / 2
    
    -- Update FOV Circle
    FOVCircle.Position = Vector2.new(screenCenter.X, screenCenter.Y)
    FOVCircle.Visible = Settings.Aimbot
    FOVCircle.Radius = Settings.FOV
    
    -- =============================================
    -- AIMBOT SYSTEM — STICKY + PRIORITY TERDEKAT!
    -- =============================================
    if Settings.Aimbot then
        local now = tick()
        
        -- Cek apakah sticky target masih valid
        if StickyTarget and IsTargetValid(StickyTarget) then
            -- Tetap nempel ke target!
            CurrentTarget = StickyTarget
        else
            -- Target mati atau invalid, reset
            StickyTarget = nil
            CurrentTarget = nil
        end
        
        -- Kalau gak ada target, cari yang TERDEKAT (dunia nyata)
        if not CurrentTarget and (now - TargetSwitchTime >= Settings.TargetSwitchDelay) then
            CurrentTarget = GetClosestEnemy()
            StickyTarget = CurrentTarget
            TargetSwitchTime = now
        end
        
        -- PAKSA AIM KE TARGET!
        if CurrentTarget and IsTargetValid(CurrentTarget) then
            ForceAimAtTarget(CurrentTarget)
            StickyTarget = CurrentTarget -- Update sticky
            
            FOVCircle.Color = Color3.fromRGB(0, 255, 0)
            FOVCircle.Radius = Settings.FOV * 0.5 -- FOV mengecil pas lock
            
            -- AUTO SHOOT!
            if Settings.AutoShoot then
                AutoShoot()
            end
        else
            CurrentTarget = nil
            StickyTarget = nil
            FOVCircle.Color = Color3.fromRGB(255, 0, 0)
            FOVCircle.Radius = Settings.FOV
        end
    else
        CurrentTarget = nil
        StickyTarget = nil
        FOVCircle.Color = Color3.fromRGB(255, 0, 0)
    end
    
    -- =============================================
    -- ESP RENDER
    -- =============================================
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
            
            -- WARNA BOX: TARGET = KUNING TERANG, MUSUH LAIN = MERAH
            if player == CurrentTarget then
                esp.Box.Color = Color3.fromRGB(255, 255, 0)
                esp.Box.Thickness = 4 -- Lebih tebel buat target
            else
                esp.Box.Color = Color3.fromRGB(255, 0, 0)
                esp.Box.Thickness = 2
            end
            esp.Box.Visible = true
            
            -- Health bar
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
            esp.NameTag.Position = Vector2.new(headPos.X, boxY - 22)
            esp.NameTag.Visible = true
            
            -- Distance
            local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
            esp.DistTag.Text = string.format("%.0f m", dist / 3.5)
            esp.DistTag.Position = Vector2.new(headPos.X, boxY + height + 8)
            esp.DistTag.Visible = true
            
            -- Head Dot - lebih gede buat target
            if player == CurrentTarget then
                esp.HeadDot.Radius = 12
                esp.HeadDot.Color = Color3.fromRGB(0, 255, 0)
            else
                esp.HeadDot.Radius = 8
                esp.HeadDot.Color = Color3.fromRGB(255, 255, 0)
            end
            esp.HeadDot.Position = Vector2.new(headPos.X, headPos.Y)
            esp.HeadDot.Visible = true
        elseif ESPStorage[player] then
            for _, v in pairs(ESPStorage[player]) do
                v.Visible = false
            end
        end
    end
    
    -- Cleanup player leave
    for player in pairs(ESPStorage) do
        if not player.Parent then
            RemoveESP(player)
        end
    end
end)

-- =============================================
-- UI SYSTEM
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "GII_FINAL"
ScreenGui.ResetOnSpawn = false

local MainMenu = Instance.new("Frame")
MainMenu.Parent = ScreenGui
MainMenu.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
MainMenu.BorderSizePixel = 0
MainMenu.Size = UDim2.new(0, 195, 0, 260)
MainMenu.Position = UDim2.new(0.5, -97, 0.4, -130)
MainMenu.Visible = true
MainMenu.ClipsDescendants = true

Instance.new("UICorner", MainMenu).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainMenu).Color = Color3.fromRGB(255, 0, 100)

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
Title.Text = "🔥 GII v12 STICKY"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize
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

-- Close
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
Content.CanvasSize = UDim2.new(0, 0, 0, 230)
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
MakeToggle("🎯 Auto Aim", true, function(s) 
    Settings.Aimbot = s; FOVCircle.Visible = s; CurrentTarget = nil; StickyTarget = nil
end)
MakeToggle("📌 Sticky Aim", true, function(s) Settings.StickyAim = s end)
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
MinimizeIcon.Size = UDim2.new(0, 40, 0, 40)
MinimizeIcon.Position = UDim2.new(0.85, 0, 0.5, -20)
MinimizeIcon.Text = "😈"
MinimizeIcon.TextScaled = true
MinimizeIcon.Font = Enum.Font.GothamBlack
MinimizeIcon.Visible = false
MinimizeIcon.AutoButtonColor = false
Instance.new("UICorner", MinimizeIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", MinimizeIcon).Color = Color3.fromRGB(255, 255, 255)

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

-- RESPAWN
LocalPlayer.CharacterAdded:Connect(function()
    CurrentTarget = nil
    StickyTarget = nil
    LastShot = 0
end)

print("╔══════════════════════════════════╗")
print("║ 🔥 GII v12 — STICKY AIM!       ║")
print("║ 🎯 AIM TETAP NEMPEL!           ║")
print("║ 💀 PRIORITAS MUSUH TERDEKAT!   ║")
print("║ 🔫 AUTO SHOOT!                 ║")
print("║ 😈 ECU ULTIMATE                ║")
print("╚══════════════════════════════════╝")
