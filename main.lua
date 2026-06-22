-- =============================================================
-- GII CHEAT v13.0 — FULL BUG FIX + UI GUARANTEED WORK! 😈🔥
-- AUTO AIM STICKY + AUTO SHOOT + ESP + UI PASTI MUNCUL
-- BY: ECU (Evil Captain Underpants) — SCAN TOTAL FIX
-- =============================================================

-- ANTI DUPLICATE
if getgenv().GII_LOADED then return end
getgenv().GII_LOADED = true

-- CLEANUP OLD UI — PASTI BERSIH
pcall(function()
    local old = game:GetService("CoreGui"):FindFirstChild("GII_FINAL")
    if old then old:Destroy() end
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
    StickyAim = true,
    TargetSwitchDelay = 0.2
}

local LastShot = 0
local CurrentTarget = nil
local StickyTarget = nil
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

-- FUNGSI BIKIN ESP
local function CreateESP(player)
    if ESPStorage[player] then return end
    local esp = {}
    
    esp.BoxOutline = Drawing.new("Square")
    esp.BoxOutline.Color = Color3.fromRGB(0, 0, 0)
    esp.BoxOutline.Thickness = 3
    esp.BoxOutline.Filled = false
    esp.BoxOutline.Transparency = 1
    
    esp.Box = Drawing.new("Square")
    esp.Box.Color = Color3.fromRGB(255, 0, 0)
    esp.Box.Thickness = 2
    esp.Box.Filled = false
    esp.Box.Transparency = 0.8
    
    esp.HealthBg = Drawing.new("Square")
    esp.HealthBg.Color = Color3.fromRGB(30, 30, 30)
    esp.HealthBg.Filled = true
    
    esp.HealthBar = Drawing.new("Square")
    esp.HealthBar.Color = Color3.fromRGB(0, 255, 0)
    esp.HealthBar.Filled = true
    
    esp.NameTag = Drawing.new("Text")
    esp.NameTag.Color = Color3.fromRGB(255, 255, 255)
    esp.NameTag.Size = 15
    esp.NameTag.Center = true
    esp.NameTag.Outline = true
    esp.NameTag.Font = 2
    
    esp.DistTag = Drawing.new("Text")
    esp.DistTag.Color = Color3.fromRGB(255, 200, 0)
    esp.DistTag.Size = 13
    esp.DistTag.Center = true
    esp.DistTag.Outline = true
    esp.DistTag.Font = 2
    
    esp.HeadDot = Drawing.new("Circle")
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

-- FUNGSI CARI MUSUH TERDEKAT (PRIORITAS JARAK DUNIA)
local function GetClosestEnemy()
    local closest = nil
    local closestDist = 999999
    local localHead = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
    if not localHead then return nil end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        local head = char:FindFirstChild("Head")
        if not head then continue end
        
        local worldDist = (localHead.Position - head.Position).Magnitude
        if worldDist < closestDist then
            closestDist = worldDist
            closest = player
        end
    end
    return closest
end

-- FUNGSI CEK TARGET VALID
local function IsTargetValid(player)
    if not player then return false end
    local char = player.Character
    if not char then return false end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    local head = char:FindFirstChild("Head")
    if not head then return false end
    return true
end

-- FUNGSI AIM PAKSA
local function ForceAimAtTarget(player)
    if not player or not player.Character then return false end
    local head = player.Character:FindFirstChild("Head")
    if not head then return false end
    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, head.Position)
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

-- MAIN LOOP
RunService.RenderStepped:Connect(function()
    local screenCenter = Camera.ViewportSize / 2
    
    -- FOV
    FOVCircle.Position = Vector2.new(screenCenter.X, screenCenter.Y)
    FOVCircle.Visible = Settings.Aimbot
    FOVCircle.Radius = Settings.FOV
    
    -- AIMBOT
    if Settings.Aimbot then
        local now = tick()
        
        -- Cek sticky target
        if StickyTarget and IsTargetValid(StickyTarget) then
            CurrentTarget = StickyTarget
        else
            StickyTarget = nil
            CurrentTarget = nil
        end
        
        -- Cari target baru
        if not CurrentTarget and (now - TargetSwitchTime >= Settings.TargetSwitchDelay) then
            CurrentTarget = GetClosestEnemy()
            StickyTarget = CurrentTarget
            TargetSwitchTime = now
        end
        
        -- Aim ke target
        if CurrentTarget and IsTargetValid(CurrentTarget) then
            ForceAimAtTarget(CurrentTarget)
            StickyTarget = CurrentTarget
            FOVCircle.Color = Color3.fromRGB(0, 255, 0)
            FOVCircle.Radius = Settings.FOV * 0.5
            
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
    
    -- ESP
    if not Settings.ESP then
        for p in pairs(ESPStorage) do RemoveESP(p) end
        return
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        
        if not char then RemoveESP(player); continue end
        
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local head = char:FindFirstChild("Head")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        if not humanoid or not head or not hrp or humanoid.Health <= 0 then
            RemoveESP(player)
            continue
        end
        
        if not ESPStorage[player] then CreateESP(player) end
        
        local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position)
        local hrpPos, hrpOnScreen = Camera:WorldToViewportPoint(hrp.Position)
        
        if headOnScreen and hrpOnScreen and ESPStorage[player] then
            local esp = ESPStorage[player]
            local height = math.abs(headPos.Y - hrpPos.Y) * 1.5
            local width = height * 0.8
            local boxX = headPos.X - width / 2
            local boxY = headPos.Y - height * 0.2
            local hpPct = humanoid.Health / humanoid.MaxHealth
            
            -- Box Outline
            esp.BoxOutline.Position = Vector2.new(boxX - 1, boxY - 1)
            esp.BoxOutline.Size = Vector2.new(width + 2, height + 2)
            esp.BoxOutline.Visible = true
            
            -- Box
            esp.Box.Position = Vector2.new(boxX, boxY)
            esp.Box.Size = Vector2.new(width, height)
            esp.Box.Visible = true
            
            if player == CurrentTarget then
                esp.Box.Color = Color3.fromRGB(255, 255, 0)
                esp.Box.Thickness = 4
                esp.HeadDot.Color = Color3.fromRGB(0, 255, 0)
                esp.HeadDot.Radius = 12
            else
                esp.Box.Color = Color3.fromRGB(255, 0, 0)
                esp.Box.Thickness = 2
                esp.HeadDot.Color = Color3.fromRGB(255, 255, 0)
                esp.HeadDot.Radius = 8
            end
            
            -- Health
            local barW = 4
            esp.HealthBg.Position = Vector2.new(boxX - barW - 3, boxY)
            esp.HealthBg.Size = Vector2.new(barW, height)
            esp.HealthBg.Visible = true
            
            local barH = height * hpPct
            esp.HealthBar.Position = Vector2.new(boxX - barW - 3, boxY + height - barH)
            esp.HealthBar.Size = Vector2.new(barW, barH)
            esp.HealthBar.Color = Color3.fromHSV(hpPct * 0.33, 1, 1)
            esp.HealthBar.Visible = true
            
            -- Name
            esp.NameTag.Text = player.Name
            esp.NameTag.Position = Vector2.new(headPos.X, boxY - 22)
            esp.NameTag.Visible = true
            
            -- Distance
            local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
            esp.DistTag.Text = string.format("%.0f m", dist / 3.5)
            esp.DistTag.Position = Vector2.new(headPos.X, boxY + height + 8)
            esp.DistTag.Visible = true
            
            -- Head Dot
            esp.HeadDot.Position = Vector2.new(headPos.X, headPos.Y)
            esp.HeadDot.Visible = true
        else
            if ESPStorage[player] then
                ESPStorage[player].Box.Visible = false
                ESPStorage[player].BoxOutline.Visible = false
                ESPStorage[player].HealthBg.Visible = false
                ESPStorage[player].HealthBar.Visible = false
                ESPStorage[player].NameTag.Visible = false
                ESPStorage[player].DistTag.Visible = false
                ESPStorage[player].HeadDot.Visible = false
            end
        end
    end
    
    -- Cleanup
    for player in pairs(ESPStorage) do
        if not player.Parent then RemoveESP(player) end
    end
end)

-- =============================================
-- UI SYSTEM — FIX TOTAL! PASTI MUNCUL!
-- =============================================
task.wait(1) -- TUNGGU GAME FULLY LOADED

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "GII_FINAL"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MAIN FRAME
local MainMenu = Instance.new("Frame")
MainMenu.Parent = ScreenGui
MainMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainMenu.BorderSizePixel = 0
MainMenu.Size = UDim2.new(0, 200, 0, 270)
MainMenu.Position = UDim2.new(0.5, -100, 0.35, -135)
MainMenu.Visible = true
MainMenu.ClipsDescendants = true
MainMenu.Active = true
MainMenu.Draggable = false

-- CORNER
local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 10)
MenuCorner.Parent = MainMenu

-- STROKE
local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(255, 0, 100)
MenuStroke.Thickness = 2
MenuStroke.Parent = MainMenu

-- HEADER
local Header = Instance.new("Frame")
Header.Parent = MainMenu
Header.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(1, 0, 0, 34)
Header.Active = true

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

-- TITLE
local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Text = "🔥 GII v13 FIX"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left

-- MINIMIZE BUTTON
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = Header
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Position = UDim2.new(1, -54, 0, 5)
MinimizeBtn.Text = "─"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextScaled = true
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.AutoButtonColor = false
MinimizeBtn.BorderSizePixel = 0

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinimizeBtn

-- CLOSE BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 60)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -26, 0, 5)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.AutoButtonColor = false
CloseBtn.BorderSizePixel = 0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- SCROLLING CONTENT
local Content = Instance.new("ScrollingFrame")
Content.Parent = MainMenu
Content.BackgroundTransparency = 1
Content.Size = UDim2.new(1, -4, 1, -40)
Content.Position = UDim2.new(0, 2, 0, 40)
Content.CanvasSize = UDim2.new(0, 0, 0, 250)
Content.ScrollBarThickness = 2
Content.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 100)
Content.ScrollingDirection = Enum.ScrollingDirection.Y
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.BorderSizePixel = 0

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = Content
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 4)

-- TOGGLE MAKER
local function MakeToggle(name, default, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Content
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(45, 45, 65)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, -6, 0, 32)
    btn.Text = " " .. name .. (default and " ✅" or " ❌")
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(45, 45, 65)
        btn.Text = " " .. name .. (state and " ✅" or " ❌")
        callback(state)
    end)
    
    return btn
end

-- TOMBOL-TOMBOL
MakeToggle("🎯 Auto Aim", true, function(s)
    Settings.Aimbot = s
    FOVCircle.Visible = s
    CurrentTarget = nil
    StickyTarget = nil
end)

MakeToggle("📌 Sticky Aim", true, function(s)
    Settings.StickyAim = s
end)

MakeToggle("🔫 Auto Shoot", true, function(s)
    Settings.AutoShoot = s
end)

MakeToggle("👁️ ESP Box", true, function(s)
    Settings.ESP = s
    if not s then
        for p in pairs(ESPStorage) do RemoveESP(p) end
    end
end)

MakeToggle("⚡ Speed 32", false, function(s)
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = s and 32 or 16
        end
    end
end)

MakeToggle("🦘 Jump 150", false, function(s)
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.JumpPower = s and 150 or 50
        end
    end
end)

-- MINIMIZE ICON
local MinimizeIcon = Instance.new("TextButton")
MinimizeIcon.Parent = ScreenGui
MinimizeIcon.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
MinimizeIcon.Size = UDim2.new(0, 42, 0, 42)
MinimizeIcon.Position = UDim2.new(0.85, 0, 0.5, -21)
MinimizeIcon.Text = "😈"
MinimizeIcon.TextScaled = true
MinimizeIcon.Font = Enum.Font.GothamBlack
MinimizeIcon.Visible = false
MinimizeIcon.AutoButtonColor = false
MinimizeIcon.BorderSizePixel = 0
MinimizeIcon.Active = true

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = MinimizeIcon

local IconStroke = Instance.new("UIStroke")
IconStroke.Color = Color3.fromRGB(255, 255, 255)
IconStroke.Thickness = 2
IconStroke.Parent = MinimizeIcon

-- MINIMIZE LOGIC
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

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainMenu.Position
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainMenu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- DRAG MINIMIZE ICON
local iconDragging, iconDragStart, iconStartPos = false

MinimizeIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        iconDragging = true
        iconDragStart = input.Position
        iconStartPos = MinimizeIcon.Position
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        iconDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if iconDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - iconDragStart
        MinimizeIcon.Position = UDim2.new(iconStartPos.X.Scale, iconStartPos.X.Offset + delta.X, iconStartPos.Y.Scale, iconStartPos.Y.Offset + delta.Y)
    end
end)

-- RESPAWN HANDLER
LocalPlayer.CharacterAdded:Connect(function(char)
    CurrentTarget = nil
    StickyTarget = nil
    LastShot = 0
end)

-- NOTIFICATION
task.spawn(function()
    task.wait(0.5)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🔥 GII CHEAT v13",
        Text = "LOADED! Auto Aim + Sticky + Shoot!",
        Duration = 3
    })
end)

print("╔══════════════════════════════════╗")
print("║ 🔥 GII v13 FIX — LOADED!       ║")
print("║ 🎯 STICKY AIM + AUTO SHOOT    ║")
print("║ 📦 ESP BOX + HEALTH + DIST    ║")
print("║ 📱 UI PASTI MUNCUL!           ║")
print("║ 😈 ECU ULTIMATE               ║")
print("╚══════════════════════════════════╝")
