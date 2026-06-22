-- =============================================================
-- GII CHEAT v5.0 — MOBILE OPTIMIZED | ECU ULTIMATE FIX
-- UI KECIL HP + MINIMIZE ICON + AIMBOT GACOR + ESP + SETTING LENGKAP
-- BY: ECU (Evil Captain Underpants) — RAJA KODING ROBLOX
-- =============================================================

-- =============================================
-- 🔥 SERVICES
-- =============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- =============================================
-- ⚙️ SETTING DEFAULT — BISA DIUBAH LEWAT UI
-- =============================================
local Settings = {
    -- Aimbot
    AimbotEnabled = true,
    TeamCheck = false,
    AliveCheck = true,
    WallCheck = true,
    Smoothness = 0.3,
    LockPart = "Head",
    FOVRadius = 120,
    MaxDistance = 1500,
    AutoShoot = false,
    SilentAim = false,
    
    -- ESP
    ESPEnabled = true,
    ESPBox = true,
    ESPLine = true,
    ESPHealth = true,
    ESPDistance = true,
    ESPName = true,
    
    -- Visual
    FOVColor = Color3.fromRGB(0, 255, 255),
    ESPColor = Color3.fromRGB(255, 0, 0),
    ESPTeamColor = Color3.fromRGB(0, 255, 0),
}

-- =============================================
-- 🎯 FOV CIRCLE
-- =============================================
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = Settings.AimbotEnabled
FOVCircle.Radius = Settings.FOVRadius
FOVCircle.Color = Settings.FOVColor
FOVCircle.Thickness = 1.5
FOVCircle.Filled = false
FOVCircle.Transparency = 0.8

-- =============================================
-- 🧠 AIMBOT ENGINE — FULL POWER
-- =============================================
local Aimbot = {
    Target = nil,
    Locked = false,
    LastTarget = nil
}

local function getClosestTarget()
    local mousePos = UserInputService:GetMouseLocation()
    local closest, closestDist = nil, Settings.FOVRadius
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if Settings.TeamCheck and player.Team == LocalPlayer.Team then continue end
        
        local character = player.Character
        if not character then continue end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid or (Settings.AliveCheck and humanoid.Health <= 0) then continue end
        
        local targetPart = character:FindFirstChild(Settings.LockPart)
        if not targetPart then targetPart = character:FindFirstChild("Head") end
        if not targetPart then targetPart = character:FindFirstChild("HumanoidRootPart") end
        if not targetPart then continue end
        
        local targetPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
        if not onScreen then continue end
        
        local dist = (Vector2.new(targetPos.X, targetPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
        
        -- Wall Check
        if Settings.WallCheck then
            local rayParams = RaycastParams.new()
            rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
            rayParams.FilterType = Enum.RaycastFilterType.Blacklist
            
            local direction = (targetPart.Position - Camera.CFrame.Position).Unit * Settings.MaxDistance
            local ray = workspace:Raycast(Camera.CFrame.Position, direction, rayParams)
            
            if ray then
                local hitChar = ray.Instance:FindFirstAncestorOfClass("Model")
                if hitChar ~= character then continue end
            end
        end
        
        if dist < closestDist then
            closestDist = dist
            closest = player
        end
    end
    return closest
end

local function lockOntoTarget(player)
    if not player or not player.Character then return end
    
    local targetPart = player.Character:FindFirstChild(Settings.LockPart)
    if not targetPart then targetPart = player.Character:FindFirstChild("Head") end
    if not targetPart then targetPart = player.Character:FindFirstChild("HumanoidRootPart") end
    if not targetPart then return end
    
    local targetPos = targetPart.Position
    
    if Settings.SilentAim then
        -- Silent Aim: manipulasi proyektil langsung
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Projectile") and v:GetAttribute("Owner") == LocalPlayer then
                v.CFrame = CFrame.new(v.CFrame.Position, targetPos)
            end
        end
    else
        -- Legit Aim: smooth camera lock
        local smoothFactor = Settings.Smoothness * 10
        local newCFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPos), smoothFactor)
        Camera.CFrame = newCFrame
    end
end

-- =============================================
-- 🎨 ESP SYSTEM — GARIS, BOX, HEALTH, NAME
-- =============================================
local ESPObjects = {}

local function updateESP()
    -- Bersihin ESP lama
    for _, obj in pairs(ESPObjects) do
        for _, drawing in pairs(obj) do
            drawing:Remove()
        end
    end
    ESPObjects = {}
    
    if not Settings.ESPEnabled then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if Settings.TeamCheck and player.Team == LocalPlayer.Team then continue end
        
        local character = player.Character
        if not character then continue end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local head = character:FindFirstChild("Head")
        if not humanoid or not hrp or not head then continue end
        if Settings.AliveCheck and humanoid.Health <= 0 then continue end
        
        local espColor = (player.Team == LocalPlayer.Team) and Settings.ESPTeamColor or Settings.ESPColor
        local drawings = {}
        
        -- Line ESP (garis dari tengah layar ke musuh)
        if Settings.ESPLine then
            local line = Drawing.new("Line")
            line.Color = espColor
            line.Thickness = 1.5
            line.Transparency = 0.7
            table.insert(drawings, line)
        end
        
        -- Box ESP
        if Settings.ESPBox then
            local box = Drawing.new("Square")
            box.Color = espColor
            box.Thickness = 1.5
            box.Filled = false
            box.Transparency = 0.8
            table.insert(drawings, box)
        end
        
        -- Health Bar
        if Settings.ESPHealth then
            local healthBar = Drawing.new("Square")
            healthBar.Color = Color3.fromRGB(0, 255, 0)
            healthBar.Thickness = 1
            healthBar.Filled = true
            table.insert(drawings, healthBar)
            
            local healthBg = Drawing.new("Square")
            healthBg.Color = Color3.fromRGB(40, 40, 40)
            healthBg.Thickness = 1
            healthBg.Filled = true
            table.insert(drawings, healthBg)
        end
        
        -- Name & Distance Text
        if Settings.ESPName then
            local nameText = Drawing.new("Text")
            nameText.Color = Color3.fromRGB(255, 255, 255)
            nameText.Size = 13
            nameText.Center = true
            nameText.Outline = true
            table.insert(drawings, nameText)
        end
        
        if Settings.ESPDistance then
            local distText = Drawing.new("Text")
            distText.Color = Color3.fromRGB(200, 200, 200)
            distText.Size = 12
            distText.Center = true
            distText.Outline = true
            table.insert(drawings, distText)
        end
        
        ESPObjects[player] = drawings
    end
end

local function renderESP()
    if not Settings.ESPEnabled then return end
    
    local screenCenter = Camera.ViewportSize / 2
    
    for player, drawings in pairs(ESPObjects) do
        local character = player.Character
        if not character then continue end
        
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local head = character:FindFirstChild("Head")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not hrp or not head or not humanoid then continue end
        
        local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position)
        local hrpPos, hrpOnScreen = Camera:WorldToViewportPoint(hrp.Position)
        
        if headOnScreen and hrpOnScreen then
            local height = math.abs(headPos.Y - hrpPos.Y) * 1.2
            local width = height * 0.7
            local boxX = hrpPos.X - width / 2
            local boxY = headPos.Y
            
            local idx = 1
            
            -- Line
            if Settings.ESPLine and drawings[idx] then
                drawings[idx].From = Vector2.new(screenCenter.X, Camera.ViewportSize.Y)
                drawings[idx].To = Vector2.new(hrpPos.X, hrpPos.Y)
                idx = idx + 1
            end
            
            -- Box
            if Settings.ESPBox and drawings[idx] then
                drawings[idx].Position = Vector2.new(boxX, boxY)
                drawings[idx].Size = Vector2.new(width, height)
                idx = idx + 1
            end
            
            -- Health
            if Settings.ESPHealth and drawings[idx] and drawings[idx+1] then
                local healthPercent = humanoid.Health / humanoid.MaxHealth
                local barWidth = 3
                local barHeight = height * healthPercent
                
                drawings[idx+1].Position = Vector2.new(boxX - barWidth - 2, boxY)
                drawings[idx+1].Size = Vector2.new(barWidth, height)
                
                drawings[idx].Position = Vector2.new(boxX - barWidth - 2, boxY + height - barHeight)
                drawings[idx].Size = Vector2.new(barWidth, barHeight)
                drawings[idx].Color = Color3.fromHSV(healthPercent * 0.33, 1, 1)
                idx = idx + 2
            end
            
            -- Name
            if Settings.ESPName and drawings[idx] then
                drawings[idx].Text = player.Name
                drawings[idx].Position = Vector2.new(hrpPos.X, boxY - 16)
                idx = idx + 1
            end
            
            -- Distance
            if Settings.ESPDistance and drawings[idx] then
                local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                drawings[idx].Text = string.format("%.0f m", dist)
                drawings[idx].Position = Vector2.new(hrpPos.X, boxY + height + 4)
                idx = idx + 1
            end
        end
    end
end

-- =============================================
-- 🖥️ UI SYSTEM — MOBILE FRIENDLY + MINIMIZE ICON
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = (game:IsLoaded() and game:GetService("CoreGui")) or LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "GII_CHEAT_MOBILE"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- ===== MAIN MENU =====
local MainMenu = Instance.new("Frame")
MainMenu.Parent = ScreenGui
MainMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainMenu.BorderSizePixel = 0
MainMenu.Size = UDim2.new(0, 220, 0, 340) -- UI KECIL BUAT HP
MainMenu.Position = UDim2.new(0.5, -110, 0.5, -170)
MainMenu.ClipsDescendants = true
MainMenu.Visible = false
Instance.new("UICorner", MainMenu).CornerRadius = UDim.new(0, 10)

-- ===== HEADER =====
local Header = Instance.new("Frame")
Header.Parent = MainMenu
Header.BackgroundColor3 = Color3.fromRGB(25, 5, 50)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(1, 0, 0, 35)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local HeaderStroke = Instance.new("UIStroke", Header)
HeaderStroke.Color = Color3.fromRGB(100, 0, 255)
HeaderStroke.Thickness = 1.5

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "🔥 GII CHEAT"
Title.TextColor3 = Color3.fromRGB(255, 80, 120)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.TextStrokeTransparency = 0.5

-- ===== CLOSE BUTTON =====
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 40, 60)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -30, 0, 4)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainMenu, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    wait(0.3)
    MainMenu.Visible = false
    MinimizeIcon.Visible = true
end)

-- ===== DRAG HANDLE =====
local isDragging = false
local dragStart, startPos

MainMenu.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        dragStart = input.Position
        startPos = MainMenu.Position
    end
end)

MainMenu.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainMenu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ===== SCROLLING CONTENT =====
local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Parent = MainMenu
ContentScroll.BackgroundTransparency = 1
ContentScroll.Size = UDim2.new(1, 0, 1, -40)
ContentScroll.Position = UDim2.new(0, 0, 0, 40)
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 700)
ContentScroll.ScrollBarThickness = 3
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 0, 255)
ContentScroll.ScrollingDirection = Enum.ScrollingDirection.Y
ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ContentScroll
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)

-- ===== BUTTON MAKER =====
local function createToggle(name, default, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ContentScroll
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(50, 50, 70)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.Text = "  " .. name .. (default and " ✅" or " ❌")
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local UIStroke = Instance.new("UIStroke", btn)
    UIStroke.Color = Color3.fromRGB(100, 0, 255)
    UIStroke.Thickness = 0.8
    UIStroke.Transparency = 0.7
    
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(50, 50, 70)
        btn.Text = "  " .. name .. (state and " ✅" or " ❌")
        callback(state)
    end)
    
    return btn
end

local function createLabel(text)
    local label = Instance.new("TextLabel")
    label.Parent = ContentScroll
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    return label
end

-- ===== TOMBOL SETTING =====
createLabel("═══ 🎯 AIMBOT ═══")

createToggle("🔒 Enable Aimbot", true, function(s)
    Settings.AimbotEnabled = s
    FOVCircle.Visible = s
end)

createToggle("🎯 Silent Aim", false, function(s)
    Settings.SilentAim = s
    Settings.Smoothness = s and 0.05 or 0.3
end)

createToggle("💀 Team Check", false, function(s)
    Settings.TeamCheck = not s
    updateESP()
end)

createToggle("🧱 Wall Check", true, function(s)
    Settings.WallCheck = s
end)

createToggle("🔫 Auto Shoot", false, function(s)
    Settings.AutoShoot = s
end)

createToggle("📐 Lock Head", true, function(s)
    Settings.LockPart = s and "Head" or "HumanoidRootPart"
end)

createToggle("➕ FOV +20", false, function(s)
    if s then
        Settings.FOVRadius = math.min(Settings.FOVRadius + 20, 250)
        FOVCircle.Radius = Settings.FOVRadius
    end
end)

createToggle("➖ FOV -20", false, function(s)
    if s then
        Settings.FOVRadius = math.max(Settings.FOVRadius - 20, 30)
        FOVCircle.Radius = Settings.FOVRadius
    end
end)

createToggle("📏 Max Dist +200", false, function(s)
    if s then Settings.MaxDistance = math.min(Settings.MaxDistance + 200, 5000) end
end)

createToggle("📏 Max Dist -200", false, function(s)
    if s then Settings.MaxDistance = math.max(Settings.MaxDistance - 200, 300) end
end)

createLabel("═══ 👁️ ESP ═══")

createToggle("👁️ Enable ESP", true, function(s)
    Settings.ESPEnabled = s
    updateESP()
end)

createToggle("📦 ESP Box", true, function(s)
    Settings.ESPBox = s
    updateESP()
end)

createToggle("📏 ESP Line", true, function(s)
    Settings.ESPLine = s
    updateESP()
end)

createToggle("❤️ ESP Health", true, function(s)
    Settings.ESPHealth = s
    updateESP()
end)

createToggle("📛 ESP Name", true, function(s)
    Settings.ESPName = s
    updateESP()
end)

createToggle("📐 ESP Distance", true, function(s)
    Settings.ESPDistance = s
    updateESP()
end)

createLabel("═══ ⚡ MISC ═══")

createToggle("🏃 Speed Boost", false, function(s)
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = s and 32 or 16
    end
end)

createToggle("🦘 High Jump", false, function(s)
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").JumpPower = s and 100 or 50
    end
end)

createLabel("═══ 🎨 FOV COLOR ═══")

local colors = {
    {"💜 Purple", Color3.fromRGB(255, 0, 255)},
    {"❤️ Red", Color3.fromRGB(255, 0, 0)},
    {"💚 Green", Color3.fromRGB(0, 255, 0)},
    {"💙 Blue", Color3.fromRGB(0, 255, 255)},
    {"🤍 White", Color3.fromRGB(255, 255, 255)},
}

for _, colorData in ipairs(colors) do
    createToggle(colorData[1], colorData[1] == "💙 Blue", function(s)
        if s then
            Settings.FOVColor = colorData[2]
            FOVCircle.Color = colorData[2]
        end
    end)
end

-- ===== MINIMIZE ICON =====
local MinimizeIcon = Instance.new("TextButton")
MinimizeIcon.Parent = ScreenGui
MinimizeIcon.BackgroundColor3 = Color3.fromRGB(25, 5, 50)
MinimizeIcon.Size = UDim2.new(0, 40, 0, 40)
MinimizeIcon.Position = UDim2.new(0.85, 0, 0.5, -20)
MinimizeIcon.Text = "😈"
MinimizeIcon.TextScaled = true
MinimizeIcon.Font = Enum.Font.GothamBlack
MinimizeIcon.BorderSizePixel = 0
Instance.new("UICorner", MinimizeIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", MinimizeIcon).Color = Color3.fromRGB(255, 50, 100)
MinimizeIcon.Visible = true

MinimizeIcon.MouseButton1Click:Connect(function()
    MainMenu.Visible = true
    MinimizeIcon.Visible = false
    TweenService:Create(MainMenu, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 220, 0, 340)
    }):Play()
end)

-- Minimize icon drag
local iconDragging = false
local iconDragStart, iconStartPos

MinimizeIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        iconDragging = true
        iconDragStart = input.Position
        iconStartPos = MinimizeIcon.Position
    end
end)

MinimizeIcon.InputEnded:Connect(function(input)
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

-- =============================================
-- 🎮 MAIN LOOP — AIMBOT + ESP
-- =============================================
local function onRenderStep()
    if Settings.ESPEnabled then
        renderESP()
    end
    
    if not Settings.AimbotEnabled then
        Aimbot.Target = nil
        Aimbot.Locked = false
        return
    end
    
    local mousePos = UserInputService:GetMouseLocation()
    FOVCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
    
    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = getClosestTarget()
        if target then
            Aimbot.Target = target
            Aimbot.Locked = true
            FOVCircle.Color = Settings.ESPColor
        end
    else
        Aimbot.Target = nil
        Aimbot.Locked = false
        FOVCircle.Color = Settings.FOVColor
    end
    
    if Aimbot.Locked and Aimbot.Target then
        local char = Aimbot.Target.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                lockOntoTarget(Aimbot.Target)
                if Settings.AutoShoot then
                    -- Trigger auto shoot (simulasi klik kiri)
                    local args = {[1] = "MOUSEBUTTON1", [2] = true}
                    local remotes = game:GetService("ReplicatedStorage"):GetDescendants()
                    for _, v in ipairs(remotes) do
                        if v:IsA("RemoteEvent") and v.Name:lower():find("shoot") then
                            v:FireServer(unpack(args))
                        end
                    end
                end
            else
                Aimbot.Target = nil
                Aimbot.Locked = false
                FOVCircle.Color = Settings.FOVColor
            end
        else
            Aimbot.Target = nil
            Aimbot.Locked = false
            FOVCircle.Color = Settings.FOVColor
        end
    end
    
    -- Update ESP target player list setiap 2 detik
    if tick() % 2 < 0.016 then
        updateESP()
    end
end

-- =============================================
-- 🔑 KEYBIND TOGGLE
-- =============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.L then
        Settings.AimbotEnabled = not Settings.AimbotEnabled
        FOVCircle.Visible = Settings.AimbotEnabled
        StarterGui:SetCore("SendNotification", {
            Title = "GII CHEAT",
            Text = Settings.AimbotEnabled and "🔒 AIMBOT: ON" or "🔓 AIMBOT: OFF",
            Duration = 1.5
        })
    end
    
    if input.KeyCode == Enum.KeyCode.K then
        Settings.ESPEnabled = not Settings.ESPEnabled
        updateESP()
        StarterGui:SetCore("SendNotification", {
            Title = "GII CHEAT",
            Text = Settings.ESPEnabled and "👁️ ESP: ON" or "🚫 ESP: OFF",
            Duration = 1.5
        })
    end
end)

-- =============================================
-- 🚀 INJECT & INIT
-- =============================================
RunService.RenderStepped:Connect(onRenderStep)

-- Auto show UI on load
MainMenu.Visible = true
MinimizeIcon.Visible = false
updateESP()

print("╔══════════════════════════════════════╗")
print("║   🔥 GII CHEAT v5.0 LOADED!        ║")
print("║   🎯 ECU ULTIMATE AIMBOT ENGINE    ║")
print("║   👁️ ESP BOX/LINE/HEALTH ACTIVE   ║")
print("║   📱 MOBILE OPTIMIZED UI           ║")
print("║   😈 GAS BOS! BANTAI SEMUA!       ║")
print("╚══════════════════════════════════════╝")

-- =============================================
-- END — ECU ULTIMATE — GII CHEAT v5.0
-- =============================================
