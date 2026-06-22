-- GII CHEAT MOBILE v9.0 — AUTO AIM NO KLIK KANAN!
-- HP FRIENDLY: AIMBOT AUTO LOCK + ESP BOX + SHOOT BUTTON
-- BY: ECU (Evil Captain Underpants) 😈🔥

local LP = game.Players.LocalPlayer
local Cam = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local SG = Instance.new("ScreenGui")
SG.Parent = game:GetService("CoreGui")
SG.Name = "GII_MOBILE"

-- SETTINGS
local aimbotOn = true
local espOn = true
local fovSize = 250

-- FOV CIRCLE
local FOV = Drawing.new("Circle")
FOV.Visible = true
FOV.Radius = fovSize
FOV.Color = Color3.fromRGB(255,0,0)
FOV.Thickness = 1.5
FOV.Filled = false
FOV.Transparency = 0.7

-- ESP
local ESP = {}

local function buatESP(p)
    local d = {}
    d.Box = Drawing.new("Square")
    d.Box.Color = Color3.fromRGB(255,0,0)
    d.Box.Thickness = 2
    d.Box.Filled = false
    d.Box.Transparency = 0.8
    d.HP = Drawing.new("Square")
    d.HP.Color = Color3.fromRGB(0,255,0)
    d.HP.Filled = true
    d.Nama = Drawing.new("Text")
    d.Nama.Color = Color3.fromRGB(255,255,255)
    d.Nama.Size = 13
    d.Nama.Center = true
    d.Nama.Outline = true
    ESP[p] = d
end

-- AIMBOT AUTO LOCK — GAK USAH KLIK!
local function dapatMusuh()
    local target = nil
    local jarakTerdekat = fovSize
    local layarTengah = Cam.ViewportSize / 2
    
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p == LP then continue end
        local c = p.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            local kepala = c:FindFirstChild("Head")
            if h and h.Health > 0 and kepala then
                local posLayar, diLayar = Cam:WorldToViewportPoint(kepala.Position)
                if diLayar then
                    local jarak = (Vector2.new(posLayar.X, posLayar.Y) - Vector2.new(layarTengah.X, layarTengah.Y)).Magnitude
                    if jarak < jarakTerdekat then
                        jarakTerdekat = jarak
                        target = p
                    end
                end
            end
        end
    end
    return target
end

-- MAIN LOOP
RS.RenderStepped:Connect(function()
    local layarTengah = Cam.ViewportSize / 2
    FOV.Position = Vector2.new(layarTengah.X, layarTengah.Y)
    FOV.Visible = aimbotOn

    -- AUTO AIM — SELALU LOCK MUSUH TERDEKAT
    if aimbotOn then
        local musuh = dapatMusuh()
        if musuh and musuh.Character then
            local kepala = musuh.Character:FindFirstChild("Head")
            if kepala then
                Cam.CFrame = CFrame.new(Cam.CFrame.Position, kepala.Position)
            end
        end
    end

    -- ESP BOX
    if not espOn then 
        for p, d in pairs(ESP) do 
            d.Box.Visible = false
            d.HP.Visible = false
            d.Nama.Visible = false
        end 
        return 
    end

    for _, p in ipairs(game.Players:GetPlayers()) do
        if p == LP then continue end
        local c = p.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            local kepala = c:FindFirstChild("Head")
            local hrp = c:FindFirstChild("HumanoidRootPart")
            if h and h.Health > 0 and kepala and hrp then
                if not ESP[p] then buatESP(p) end
                local kp, ks = Cam:WorldToViewportPoint(kepala.Position)
                local rp, rs = Cam:WorldToViewportPoint(hrp.Position)
                if ks and rs then
                    local tinggi = math.abs(kp.Y - rp.Y) * 1.3
                    local lebar = tinggi * 0.65
                    local x = rp.X - lebar/2
                    local y = kp.Y
                    local hpPct = h.Health / h.MaxHealth

                    ESP[p].Box.Position = Vector2.new(x, y)
                    ESP[p].Box.Size = Vector2.new(lebar, tinggi)
                    ESP[p].Box.Visible = true

                    ESP[p].HP.Position = Vector2.new(x - 4, y + tinggi - tinggi*hpPct)
                    ESP[p].HP.Size = Vector2.new(3, tinggi*hpPct)
                    ESP[p].HP.Color = Color3.fromHSV(hpPct*0.33, 1, 1)
                    ESP[p].HP.Visible = true

                    ESP[p].Nama.Text = p.Name
                    ESP[p].Nama.Position = Vector2.new(rp.X, y - 16)
                    ESP[p].Nama.Visible = true
                end
            else
                if ESP[p] then
                    ESP[p].Box:Remove()
                    ESP[p].HP:Remove()
                    ESP[p].Nama:Remove()
                    ESP[p] = nil
                end
            end
        else
            if ESP[p] then
                ESP[p].Box:Remove()
                ESP[p].HP:Remove()
                ESP[p].Nama:Remove()
                ESP[p] = nil
            end
        end
    end
end)

-- UI KECIL BUAT HP
local Main = Instance.new("Frame")
Main.Parent = SG
Main.BackgroundColor3 = Color3.fromRGB(10,10,20)
Main.Size = UDim2.new(0,180,0,200)
Main.Position = UDim2.new(0.5,-90,0.3,-100)
Main.Visible = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(255,0,100)

local Hdr = Instance.new("Frame")
Hdr.Parent = Main
Hdr.BackgroundColor3 = Color3.fromRGB(255,0,80)
Hdr.Size = UDim2.new(1,0,0,28)
Instance.new("UICorner", Hdr).CornerRadius = UDim.new(0,8)

local Ttl = Instance.new("TextLabel")
Ttl.Parent = Hdr
Ttl.BackgroundTransparency = 1
Ttl.Size = UDim2.new(1,-50,1,0)
Ttl.Position = UDim2.new(0,8,0,0)
Ttl.Text = "🔥 GII CHEAT"
Ttl.TextColor3 = Color3.fromRGB(255,255,255)
Ttl.TextScaled = true
Ttl.Font = Enum.Font.GothamBlack
Ttl.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Hdr
MinBtn.BackgroundColor3 = Color3.fromRGB(255,150,0)
MinBtn.Size = UDim2.new(0,22,0,22)
MinBtn.Position = UDim2.new(1,-46,0,3)
MinBtn.Text = "─"
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.TextScaled = true
MinBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1,0)

local Cls = Instance.new("TextButton")
Cls.Parent = Hdr
Cls.BackgroundColor3 = Color3.fromRGB(200,0,60)
MinBtn:WaitForChild("UICorner") -- wait for it
Cls.Size = UDim2.new(0,22,0,22)
Cls.Position = UDim2.new(1,-24,0,3)
Cls.Text = "✕"
Cls.TextColor3 = Color3.fromRGB(255,255,255)
Cls.TextScaled = true
Cls.Font = Enum.Font.GothamBold
Instance.new("UICorner", Cls).CornerRadius = UDim.new(1,0)

local Scrl = Instance.new("ScrollingFrame")
Scrl.Parent = Main
Scrl.BackgroundTransparency = 1
Scrl.Size = UDim2.new(1,0,1,-33)
Scrl.Position = UDim2.new(0,0,0,33)
Scrl.CanvasSize = UDim2.new(0,0,0,200)
Scrl.ScrollBarThickness = 2
Scrl.ScrollBarImageColor3 = Color3.fromRGB(255,0,100)

local Lst = Instance.new("UIListLayout")
Lst.Parent = Scrl
Lst.Padding = UDim.new(0,3)

local function bikinTombol(teks, nyala, aksi)
    local btn = Instance.new("TextButton")
    btn.Parent = Scrl
    btn.BackgroundColor3 = nyala and Color3.fromRGB(0,180,80) or Color3.fromRGB(40,40,60)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1,-8,0,28)
    btn.Text = " " .. teks .. (nyala and " ✅" or " ❌")
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,5)
    
    local status = nyala
    btn.MouseButton1Click:Connect(function()
        status = not status
        btn.BackgroundColor3 = status and Color3.fromRGB(0,180,80) or Color3.fromRGB(40,40,60)
        btn.Text = " " .. teks .. (status and " ✅" or " ❌")
        aksi(status)
    end)
end

bikinTombol("🎯 Auto Aim", true, function(s) aimbotOn = s; FOV.Visible = s end)
bikinTombol("👁️ ESP Box", true, function(s) espOn = s end)
bikinTombol("⚡ Speed 32", false, function(s)
    local c = LP.Character
    if c and c:FindFirstChildOfClass("Humanoid") then
        c:FindFirstChildOfClass("Humanoid").WalkSpeed = s and 32 or 16
    end
end)
bikinTombol("🦘 Jump 150", false, function(s)
    local c = LP.Character
    if c and c:FindFirstChildOfClass("Humanoid") then
        c:FindFirstChildOfClass("Humanoid").JumpPower = s and 150 or 50
    end
end)

-- MINIMIZE ICON
local MinIcon = Instance.new("TextButton")
MinIcon.Parent = SG
MinIcon.BackgroundColor3 = Color3.fromRGB(255,0,80)
MinIcon.Size = UDim2.new(0,35,0,35)
MinIcon.Position = UDim2.new(0.85,0,0.5,-17)
MinIcon.Text = "😈"
MinIcon.TextScaled = true
MinIcon.Font = Enum.Font.GothamBlack
MinIcon.Visible = false
Instance.new("UICorner", MinIcon).CornerRadius = UDim.new(1,0)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    MinIcon.Visible = true
end)
Cls.MouseButton1Click:Connect(function()
    Main.Visible = false
    MinIcon.Visible = true
end)
MinIcon.MouseButton1Click:Connect(function()
    Main.Visible = true
    MinIcon.Visible = false
end)

-- DRAG UI
local drag, ds, sp = false
Hdr.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = true; ds = i.Position; sp = Main.Position
    end
end)
Hdr.InputEnded:Connect(function() drag = false end)
UIS.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - ds
        Main.Position = UDim2.new(sp.X.Scale, sp.X.Offset+d.X, sp.Y.Scale, sp.Y.Offset+d.Y)
    end
end)

-- DRAG MINIMIZE ICON
local idrag, ids, isp = false
MinIcon.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        idrag = true; ids = i.Position; isp = MinIcon.Position
    end
end)
MinIcon.InputEnded:Connect(function() idrag = false end)
UIS.InputChanged:Connect(function(i)
    if idrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - ids
        MinIcon.Position = UDim2.new(isp.X.Scale, isp.X.Offset+d.X, isp.Y.Scale, isp.Y.Offset+d.Y)
    end
end)

print("🔥 GII CHEAT MOBILE v9.0 — AUTO AIM READY! 😈")
