-- =====================================================================
-- ╔══════════════════════════════════════════════════════════════════╗
-- ║   🔥 GII CHEAT ULTIMATE v7.0 — FULL SYSTEM 2000+ LINES         ║
-- ║   🎯 AIMBOT + ESP + SILENT AIM + TRIGGERBOT + RADAR + CHAMS   ║
-- ║   👁️ BOX/LINE/HEALTH/SKELETON/HEAD DOT/DISTANCE/NAME          ║
-- ║   ⚡ SPEED/JUMP/FLY/NOCLIP/INFINITE AMMO/RAPID FIRE           ║
-- ║   📱 UI MOBILE + MINIMIZE + CUSTOM COLOR + CUSTOM SETTING     ║
-- ║   💀 BY: ECU (Evil Captain Underpants) - RAJA KODING          ║
-- ║   😈 GAS BOS! BANTAI SERVER! NO MISTAKE!                     ║
-- ╚══════════════════════════════════════════════════════════════════╝
-- =====================================================================

-- =============================================
-- 🔥 SECTION 1: SERVICES & VARIABLES
-- =============================================
local Services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    UserInputService = game:GetService("UserInputService"),
    TweenService = game:GetService("TweenService"),
    StarterGui = game:GetService("StarterGui"),
    TeleportService = game:GetService("TeleportService"),
    HttpService = game:GetService("HttpService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    Workspace = workspace,
    Lighting = game:GetService("Lighting"),
    SoundService = game:GetService("SoundService"),
    ContextActionService = game:GetService("ContextActionService"),
    PhysicsService = game:GetService("PhysicsService"),
    GroupService = game:GetService("GroupService"),
    MarketPlaceService = game:GetService("MarketplaceService"),
}

local Camera = Services.Workspace.CurrentCamera
local LocalPlayer = Services.Players.LocalPlayer

-- =============================================
-- 🔥 SECTION 2: GLOBAL CONFIGURATION
-- =============================================
local Config = {
    -- System
    ScriptName = "GII CHEAT ULTIMATE",
    ScriptVersion = "7.0",
    ScriptAuthor = "ECU (Evil Captain Underpants)",
    AutoUpdate = true,
    
    -- Aimbot
    Aimbot = {
        Enabled = true,
        TeamCheck = false,
        AliveCheck = true,
        WallCheck = true,
        VisibleCheck = true,
        Smoothness = 0,                 -- 0 = INSTA LOCK
        SmoothMethod = "Linear",        -- Linear / Bezier / Elastic
        LockPart = "Head",              -- Head / HumanoidRootPart / Torso
        LockPartOffset = Vector3.new(0, 0, 0),
        Prediction = {
            Enabled = true,
            PredictionAmount = 0.15,
            UseVelocity = true,
            UseAcceleration = false,
        },
        FOV = {
            Enabled = true,
            Radius = 250,
            Color = Color3.fromRGB(255, 0, 0),
            Thickness = 1.5,
            Filled = false,
            Transparency = 0.7,
            Outline = true,
        },
        TargetLock = {
            Enabled = true,
            LockUntilDeath = true,
            AutoSwitch = true,
            SwitchDelay = 0.05,
            Priority = "Distance",      -- Distance / Health / Angle
        },
        SilentAim = {
            Enabled = true,
            HitChance = 100,
            AutoShoot = true,
            ShootDelay = 0.05,
        },
        TriggerBot = {
            Enabled = true,
            Delay = 0,
            Key = "MouseButton2",
        },
    },
    
    -- ESP
    ESP = {
        Enabled = true,
        TeamCheck = false,
        MaxDistance = 3000,
        UpdateRate = 60,
        
        Box = {
            Enabled = true,
            Type = "2D",                -- 2D / 3D / Corner
            Color = Color3.fromRGB(255, 0, 0),
            TeamColor = Color3.fromRGB(0, 255, 0),
            Thickness = 1.5,
            Transparency = 0.8,
            Filled = false,
            FillColor = Color3.fromRGB(255, 0, 0),
            FillTransparency = 0.9,
        },
        Line = {
            Enabled = true,
            Type = "Bottom",            -- Top / Bottom / Center
            Color = Color3.fromRGB(255, 0, 0),
            Thickness = 1,
            Transparency = 0.7,
        },
        Health = {
            Enabled = true,
            Type = "Bar",               -- Bar / Text / Both
            Position = "Left",          -- Left / Right / Top / Bottom
            Width = 2,
            ColorHigh = Color3.fromRGB(0, 255, 0),
            ColorMedium = Color3.fromRGB(255, 255, 0),
            ColorLow = Color3.fromRGB(255, 0, 0),
        },
        Name = {
            Enabled = true,
            Font = 2,                   -- 0-3
            Size = 14,
            Color = Color3.fromRGB(255, 255, 255),
            Outline = true,
            OutlineColor = Color3.fromRGB(0, 0, 0),
        },
        Distance = {
            Enabled = true,
            Font = 2,
            Size = 12,
            Color = Color3.fromRGB(200, 200, 200),
            Outline = true,
            Format = "meters",          -- meters / studs
        },
        Weapon = {
            Enabled = true,
            Font = 2,
            Size = 11,
            Color = Color3.fromRGB(255, 200, 0),
            Outline = true,
        },
        Skeleton = {
            Enabled = true,
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 1,
            Transparency = 0.6,
            Bones = {"Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot"},
        },
        HeadDot = {
            Enabled = true,
            Radius = 5,
            Color = Color3.fromRGB(255, 255, 0),
            Filled = true,
            Transparency = 0.8,
        },
        Snapline = {
            Enabled = true,
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 0.5,
            Transparency = 0.5,
        },
        Tracer = {
            Enabled = false,
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 0.5,
            Transparency = 0.4,
            Speed = 5,
        },
        Chams = {
            Enabled = true,
            Color = Color3.fromRGB(255, 0, 0),
            TeamColor = Color3.fromRGB(0, 255, 0),
            Transparency = 0.5,
            Material = Enum.Material.ForceField,
            Outline = true,
        },
    },
    
    -- Radar
    Radar = {
        Enabled = true,
        Size = 150,
        Position = "BottomLeft",        -- TopLeft / TopRight / BottomLeft / BottomRight
        Range = 200,
        BackgroundColor = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.7,
        EnemyColor = Color3.fromRGB(255, 0, 0),
        TeamColor = Color3.fromRGB(0, 255, 0),
        LocalPlayerColor = Color3.fromRGB(255, 255, 255),
        DotSize = 3,
        ShowNames = false,
        Rotation = true,
    },
    
    -- Misc Hacks
    Misc = {
        SpeedHack = {
            Enabled = false,
            Speed = 32,
            Method = "Humanoid",        -- Humanoid / BodyVelocity / Tween
        },
        JumpHack = {
            Enabled = false,
            JumpPower = 150,
            InfiniteJump = false,
        },
        FlyHack = {
            Enabled = false,
            Speed = 50,
            Method = "BodyVelocity",    -- BodyVelocity / BodyGyro / Tween
            Key = "F",
        },
        NoClip = {
            Enabled = false,
            Speed = 30,
            Key = "G",
        },
        InfiniteAmmo = {
            Enabled = false,
            Method = "ValueChange",     -- ValueChange / RemoteFire / Clone
        },
        RapidFire = {
            Enabled = false,
            FireRate = 0.01,            -- Seconds between shots
        },
        NoRecoil = {
            Enabled = false,
            RecoveryTime = 0,
        },
        NoSpread = {
            Enabled = false,
            SpreadAmount = 0,
        },
        InstantReload = {
            Enabled = false,
        },
        AntiAfk = {
            Enabled = true,
            Method = "VirtualInput",    -- VirtualInput / HumanoidState / Chat
        },
        AntiKick = {
            Enabled = false,
            Method = "RemoteSpam",      -- RemoteSpam / FakeCharacter / ChatSpam
        },
        ServerHop = {
            Enabled = false,
            MinPlayers = 5,
            MaxPlayers = 50,
            GameId = game.GameId,
        },
        RejoinServer = {
            Enabled = false,
        },
    },
    
    -- Visual
    Visual = {
        Crosshair = {
            Enabled = true,
            Size = 15,
            Color = Color3.fromRGB(0, 255, 0),
            Thickness = 1.5,
            Type = "Cross",             -- Cross / Circle / Dot
            Rotation = 0,
            Outline = true,
        },
        Hitmarker = {
            Enabled = true,
            Size = 20,
            Color = Color3.fromRGB(255, 255, 255),
            Duration = 0.3,
            Sound = true,
            SoundId = "rbxassetid://",
        },
        KillEffect = {
            Enabled = true,
            Type = "Explosion",         -- Explosion / Sparkles / Smoke / Light
            Color = Color3.fromRGB(255, 0, 0),
            Duration = 0.5,
        },
        BulletTracers = {
            Enabled = true,
            Color = Color3.fromRGB(255, 255, 0),
            Thickness = 0.3,
            Transparency = 0.6,
            Duration = 0.1,
        },
        ThirdPerson = {
            Enabled = false,
            Distance = 10,
            FieldOfView = 70,
        },
        FieldOfView = {
            Enabled = false,
            Amount = 90,
            DefaultFOV = 70,
        },
        ZoomHack = {
            Enabled = false,
            ZoomAmount = 30,
            Key = "Z",
        },
        Brightness = {
            Enabled = false,
            Amount = 2,
        },
        NoFog = {
            Enabled = true,
        },
        NoBloom = {
            Enabled = true,
        },
        NoBlur = {
            Enabled = true,
        },
        FullBright = {
            Enabled = false,
            Amount = 1,
        },
    },
    
    -- UI
    UI = {
        Enabled = true,
        Theme = "Dark",                 -- Dark / Light / Custom
        AccentColor = Color3.fromRGB(255, 0, 100),
        BackgroundColor = Color3.fromRGB(10, 10, 20),
        SecondaryColor = Color3.fromRGB(30, 30, 50),
        TextColor = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        Transparency = 0.95,
        Size = UDim2.new(0, 200, 0, 320),
        Position = UDim2.new(0.5, -100, 0.5, -160),
        MinimizeEnabled = true,
        MinimizeKey = "RightShift",
        ToggleKey = "Insert",
        Watermark = true,
    },
    
    -- Keybinds
    Keybinds = {
        AimbotToggle = Enum.KeyCode.L,
        ESPToggle = Enum.KeyCode.K,
        MenuToggle = Enum.KeyCode.Insert,
        PanicKey = Enum.KeyCode.P,
        TriggerBotKey = Enum.UserInputType.MouseButton2,
    },
    
    -- Friends
    Friends = {
        Enabled = true,
        ESPColor = Color3.fromRGB(0, 255, 255),
        ChamsColor = Color3.fromRGB(0, 255, 255),
        List = {},
    },
    
    -- Whitelist
    Whitelist = {
        Enabled = false,
        Players = {},
    },
}

-- =============================================
-- 🔥 SECTION 3: UTILITY FUNCTIONS
-- =============================================
local Utility = {}

function Utility:DeepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = self:DeepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

function Utility:GetDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

function Utility:GetAngle(pos1, pos2)
    return math.acos((pos1 - pos2).Unit:Dot(Vector3.new(0, 0, 1)))
end

function Utility:WorldToScreen(position)
    local screenPos, onScreen = Camera:WorldToViewportPoint(position)
    return Vector2.new(screenPos.X, screenPos.Y), onScreen, screenPos.Z
end

function Utility:IsOnScreen(position)
    local _, onScreen = Camera:WorldToViewportPoint(position)
    return onScreen
end

function Utility:GetHealthColor(healthPercent)
    if healthPercent > 0.5 then
        return Color3.fromRGB(0, 255, 0)
    elseif healthPercent > 0.25 then
        return Color3.fromRGB(255, 255, 0)
    else
        return Color3.fromRGB(255, 0, 0)
    end
end

function Utility:GetPlayerFromCharacter(character)
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player.Character == character then
            return player
        end
    end
    return nil
end

function Utility:IsPlayerVisible(player)
    local character = player.Character
    if not character then return false end
    
    local head = character:FindFirstChild("Head")
    if not head then return false end
    
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local ray = workspace:Raycast(Camera.CFrame.Position, (head.Position - Camera.CFrame.Position).Unit * 9999, rayParams)
    
    if ray then
        local hitChar = ray.Instance:FindFirstAncestorOfClass("Model")
        return hitChar == character
    end
    
    return true
end

function Utility:IsPlayerAlive(player)
    local character = player.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health > 0
end

function Utility:GetClosestPlayer(maxDistance)
    local closest, closestDist = nil, maxDistance or 9999
    
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if Config.Aimbot.TeamCheck and player.Team == LocalPlayer.Team then continue end
        if not self:IsPlayerAlive(player) then continue end
        
        local character = player.Character
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        
        local dist = self:GetDistance(Camera.CFrame.Position, hrp.Position)
        if dist < closestDist then
            closestDist = dist
            closest = player
        end
    end
    
    return closest
end

function Utility:GetAllEnemies()
    local enemies = {}
    
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if Config.Aimbot.TeamCheck and player.Team == LocalPlayer.Team then continue end
        if not self:IsPlayerAlive(player) then continue end
        
        table.insert(enemies, player)
    end
    
    return enemies
end

function Utility:TableLength(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

function Utility:SplitString(str, delimiter)
    local result = {}
    for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end

function Utility:RoundNumber(num, decimals)
    local mult = 10 ^ (decimals or 0)
    return math.floor(num * mult + 0.5) / mult
end

function Utility:GetBonePosition(character, boneName)
    local bone = character:FindFirstChild(boneName)
    if bone and bone:IsA("BasePart") then
        return bone.Position
    end
    return nil
end

function Utility:CreateNotification(title, text, duration)
    Services.StarterGui:SetCore("SendNotification", {
        Title = title or "GII CHEAT",
        Text = text or "",
        Duration = duration or 3,
        Icon = "",
        Button1 = "",
        Button2 = "",
    })
end

function Utility:LoadConfig()
    local success, result = pcall(function()
        return Services.HttpService:JSONDecode(readfile("GII_Config.json"))
    end)
    
    if success and result then
        for k, v in pairs(result) do
            if Config[k] then
                Config[k] = v
            end
        end
    end
end

function Utility:SaveConfig()
    local success, result = pcall(function()
        writefile("GII_Config.json", Services.HttpService:JSONEncode(Config))
    end)
end

-- =============================================
-- 🔥 SECTION 4: DRAWING SYSTEM
-- =============================================
local DrawingSystem = {}
DrawingSystem.__index = DrawingSystem

function DrawingSystem.new(type, properties)
    local drawing = Drawing.new(type)
    if properties then
        for prop, value in pairs(properties) do
            pcall(function()
                drawing[prop] = value
            end)
        end
    end
    return drawing
end

function DrawingSystem:CreateCircle(properties)
    return DrawingSystem.new("Circle", properties)
end

function DrawingSystem:CreateSquare(properties)
    return DrawingSystem.new("Square", properties)
end

function DrawingSystem:CreateLine(properties)
    return DrawingSystem.new("Line", properties)
end

function DrawingSystem:CreateText(properties)
    return DrawingSystem.new("Text", properties)
end

function DrawingSystem:CreateTriangle(properties)
    return DrawingSystem.new("Triangle", properties)
end

function DrawingSystem:CreateQuad(properties)
    return DrawingSystem.new("Quad", properties)
end

function DrawingSystem:CreateImage(properties)
    return DrawingSystem.new("Image", properties)
end

-- =============================================
-- 🔥 SECTION 5: FOV SYSTEM
-- =============================================
local FOVSystem = {}
FOVSystem.__index = FOVSystem

function FOVSystem.new()
    local self = setmetatable({}, FOVSystem)
    
    self.Circle = DrawingSystem:CreateCircle({
        Visible = Config.Aimbot.FOV.Enabled,
        Radius = Config.Aimbot.FOV.Radius,
        Color = Config.Aimbot.FOV.Color,
        Thickness = Config.Aimbot.FOV.Thickness,
        Filled = Config.Aimbot.FOV.Filled,
        Transparency = Config.Aimbot.FOV.Transparency,
        Position = Vector2.new(0, 0),
    })
    
    return self
end

function FOVSystem:Update()
    local mousePos = Services.UserInputService:GetMouseLocation()
    self.Circle.Position = Vector2.new(mousePos.X, mousePos.Y)
    self.Circle.Radius = Config.Aimbot.FOV.Radius
    self.Circle.Color = Config.Aimbot.FOV.Color
    self.Circle.Visible = Config.Aimbot.FOV.Enabled and Config.Aimbot.Enabled
end

function FOVSystem:IsTargetInFOV(targetPos)
    local mousePos = Services.UserInputService:GetMouseLocation()
    local screenPos, onScreen = Utility:WorldToScreen(targetPos)
    
    if not onScreen then return false end
    
    local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
    return distance <= Config.Aimbot.FOV.Radius
end

function FOVSystem:Destroy()
    self.Circle:Remove()
end

-- =============================================
-- 🔥 SECTION 6: AIMBOT SYSTEM
-- =============================================
local AimbotSystem = {}
AimbotSystem.__index = AimbotSystem

function AimbotSystem.new()
    local self = setmetatable({}, AimbotSystem)
    
    self.CurrentTarget = nil
    self.IsLocked = false
    self.LastTarget = nil
    self.LastShootTime = 0
    self.TargetQueue = {}
    self.FOV = FOVSystem.new()
    
    return self
end

function AimbotSystem:GetBestTarget()
    local mousePos = Services.UserInputService:GetMouseLocation()
    local bestTarget = nil
    local bestScore = -1
    
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if Config.Aimbot.TeamCheck and player.Team == LocalPlayer.Team then continue end
        if Config.Aimbot.AliveCheck and not Utility:IsPlayerAlive(player) then continue end
        
        local character = player.Character
        if not character then continue end
        
        local targetPart = character:FindFirstChild(Config.Aimbot.LockPart)
        if not targetPart then
            targetPart = character:FindFirstChild("Head")
        end
        if not targetPart then continue end
        
        local targetPos, onScreen = Utility:WorldToScreen(targetPart.Position)
        if not onScreen then continue end
        
        local distance = (Vector2.new(targetPos.X, targetPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
        local worldDistance = Utility:GetDistance(Camera.CFrame.Position, targetPart.Position)
        
        if distance > Config.Aimbot.FOV.Radius then continue end
        if worldDistance > Config.ESP.MaxDistance then continue end
        
        if Config.Aimbot.WallCheck and not Utility:IsPlayerVisible(player) then continue end
        
        local score = 0
        
        if Config.Aimbot.TargetLock.Priority == "Distance" then
            score = 1000 - distance
        elseif Config.Aimbot.TargetLock.Priority == "Health" then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                score = 100 - (humanoid.Health / humanoid.MaxHealth * 100)
            end
        elseif Config.Aimbot.TargetLock.Priority == "Angle" then
            score = 1000 - distance
        end
        
        if player == self.CurrentTarget and Config.Aimbot.TargetLock.LockUntilDeath then
            score = score * 2
        end
        
        if score > bestScore then
            bestScore = score
            bestTarget = player
        end
    end
    
    return bestTarget
end

function AimbotSystem:PredictPosition(targetPart)
    local position = targetPart.Position + Config.Aimbot.LockPartOffset
    
    if Config.Aimbot.Prediction.Enabled then
        local velocity = targetPart.Velocity
        if Config.Aimbot.Prediction.UseVelocity then
            position = position + velocity * Config.Aimbot.Prediction.PredictionAmount
        end
        
        if Config.Aimbot.Prediction.UseAcceleration and targetPart:IsA("BasePart") then
            local assemblyVelocity = targetPart.AssemblyLinearVelocity
            position = position + assemblyVelocity * Config.Aimbot.Prediction.PredictionAmount
        end
    end
    
    return position
end

function AimbotSystem:LockOnTarget(player)
    if not player or not player.Character then return false end
    
    local targetPart = player.Character:FindFirstChild(Config.Aimbot.LockPart)
    if not targetPart then
        targetPart = player.Character:FindFirstChild("Head")
    end
    if not targetPart then return false end
    
    local predictedPosition = self:PredictPosition(targetPart)
    
    if Config.Aimbot.SilentAim.Enabled then
        -- Silent aim: redirect projectile
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("Projectile") or descendant:IsA("RocketPropulsion") then
                pcall(function()
                    descendant.CFrame = CFrame.new(descendant.CFrame.Position, predictedPosition)
                end)
            end
        end
        
        if Config.Aimbot.SilentAim.AutoShoot then
            local currentTime = tick()
            if currentTime - self.LastShootTime >= Config.Aimbot.SilentAim.ShootDelay then
                self:AutoShoot()
                self.LastShootTime = currentTime
            end
        end
    else
        -- Legit aim: camera manipulation
        local smoothness = Config.Aimbot.Smoothness
        
        if Config.Aimbot.SmoothMethod == "Linear" then
            local newCFrame = CFrame.new(Camera.CFrame.Position, predictedPosition)
            Camera.CFrame = Camera.CFrame:Lerp(newCFrame, 1 - smoothness)
        elseif Config.Aimbot.SmoothMethod == "Bezier" then
            local t = 1 - smoothness
            local newCFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, predictedPosition), t * t * (3 - 2 * t))
            Camera.CFrame = newCFrame
        else
            local newCFrame = CFrame.new(Camera.CFrame.Position, predictedPosition)
            Camera.CFrame = Camera.CFrame:Lerp(newCFrame, 1)
        end
    end
    
    return true
end

function AimbotSystem:AutoShoot()
    pcall(function()
        local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then
            if tool:FindFirstChild("Remote") then
                tool.Remote:FireServer()
            elseif tool:FindFirstChild("Shoot") then
                tool.Shoot:FireServer()
            end
        end
    end)
end

function AimbotSystem:Update()
    self.FOV:Update()
    
    if not Config.Aimbot.Enabled then
        self.CurrentTarget = nil
        self.IsLocked = false
        return
    end
    
    local isTriggerKeyHeld = Services.UserInputService:IsMouseButtonPressed(Config.Aimbot.TriggerBot.Key == "MouseButton2" and Enum.UserInputType.MouseButton2 or Enum.UserInputType.MouseButton1)
    
    if not isTriggerKeyHeld and not Config.Aimbot.TriggerBot.Enabled then
        self.CurrentTarget = nil
        self.IsLocked = false
        return
    end
    
    local target = self:GetBestTarget()
    
    if target then
        self.CurrentTarget = target
        self.IsLocked = true
        self:LockOnTarget(target)
    else
        self.CurrentTarget = nil
        self.IsLocked = false
    end
end

function AimbotSystem:Destroy()
    self.FOV:Destroy()
end

-- =============================================
-- 🔥 SECTION 7: ESP SYSTEM
-- =============================================
local ESPSystem = {}
ESPSystem.__index = ESPSystem

function ESPSystem.new()
    local self = setmetatable({}, ESPSystem)
    
    self.Objects = {}
    self.PlayerData = {}
    
    return self
end

function ESPSystem:CreatePlayerESP(player)
    if self.Objects[player] then return end
    
    local drawings = {}
    
    -- Box
    if Config.ESP.Box.Enabled then
        drawings.Box = DrawingSystem:CreateSquare({
            Visible = false,
            Color = Config.ESP.Box.Color,
            Thickness = Config.ESP.Box.Thickness,
            Filled = Config.ESP.Box.Filled,
            Transparency = Config.ESP.Box.Transparency,
        })
        
        if Config.ESP.Box.Type == "Corner" then
            drawings.BoxTopLeft = DrawingSystem:CreateLine({Visible = false, Color = Config.ESP.Box.Color, Thickness = Config.ESP.Box.Thickness * 2, Transparency = Config.ESP.Box.Transparency})
            drawings.BoxTopRight = DrawingSystem:CreateLine({Visible = false, Color = Config.ESP.Box.Color, Thickness = Config.ESP.Box.Thickness * 2, Transparency = Config.ESP.Box.Transparency})
            drawings.BoxBottomLeft = DrawingSystem:CreateLine({Visible = false, Color = Config.ESP.Box.Color, Thickness = Config.ESP.Box.Thickness * 2, Transparency = Config.ESP.Box.Transparency})
            drawings.BoxBottomRight = DrawingSystem:CreateLine({Visible = false, Color = Config.ESP.Box.Color, Thickness = Config.ESP.Box.Thickness * 2, Transparency = Config.ESP.Box.Transparency})
        end
    end
    
    -- Line
    if Config.ESP.Line.Enabled then
        drawings.Line = DrawingSystem:CreateLine({
            Visible = false,
            Color = Config.ESP.Line.Color,
            Thickness = Config.ESP.Line.Thickness,
            Transparency = Config.ESP.Line.Transparency,
        })
    end
    
    -- Health Bar
    if Config.ESP.Health.Enabled then
        drawings.HealthBg = DrawingSystem:CreateSquare({
            Visible = false,
            Color = Color3.fromRGB(30, 30, 30),
            Thickness = 1,
            Filled = true,
        })
        
        drawings.HealthBar = DrawingSystem:CreateSquare({
            Visible = false,
            Color = Config.ESP.Health.ColorHigh,
            Thickness = 1,
            Filled = true,
        })
    end
    
    -- Name
    if Config.ESP.Name.Enabled then
        drawings.Name = DrawingSystem:CreateText({
            Visible = false,
            Color = Config.ESP.Name.Color,
            Size = Config.ESP.Name.Size,
            Center = true,
            Outline = Config.ESP.Name.Outline,
            Font = Config.ESP.Name.Font,
        })
    end
    
    -- Distance
    if Config.ESP.Distance.Enabled then
        drawings.Distance = DrawingSystem:CreateText({
            Visible = false,
            Color = Config.ESP.Distance.Color,
            Size = Config.ESP.Distance.Size,
            Center = true,
            Outline = Config.ESP.Distance.Outline,
            Font = Config.ESP.Distance.Font,
        })
    end
    
    -- Weapon
    if Config.ESP.Weapon.Enabled then
        drawings.Weapon = DrawingSystem:CreateText({
            Visible = false,
            Color = Config.ESP.Weapon.Color,
            Size = Config.ESP.Weapon.Size,
            Center = true,
            Outline = Config.ESP.Weapon.Outline,
            Font = Config.ESP.Weapon.Font,
        })
    end
    
    -- Skeleton
    if Config.ESP.Skeleton.Enabled then
        drawings.SkeletonLines = {}
        for i = 1, #Config.ESP.Skeleton.Bones - 1 do
            drawings.SkeletonLines[i] = DrawingSystem:CreateLine({
                Visible = false,
                Color = Config.ESP.Skeleton.Color,
                Thickness = Config.ESP.Skeleton.Thickness,
                Transparency = Config.ESP.Skeleton.Transparency,
            })
        end
    end
    
    -- Head Dot
    if Config.ESP.HeadDot.Enabled then
        drawings.HeadDot = DrawingSystem:CreateCircle({
            Visible = false,
            Radius = Config.ESP.HeadDot.Radius,
            Color = Config.ESP.HeadDot.Color,
            Filled = Config.ESP.HeadDot.Filled,
            Transparency = Config.ESP.HeadDot.Transparency,
        })
    end
    
    -- Snapline
    if Config.ESP.Snapline.Enabled then
        drawings.Snapline = DrawingSystem:CreateLine({
            Visible = false,
            Color = Config.ESP.Snapline.Color,
            Thickness = Config.ESP.Snapline.Thickness,
            Transparency = Config.ESP.Snapline.Transparency,
        })
    end
    
    self.Objects[player] = drawings
end

function ESPSystem:RemovePlayerESP(player)
    if self.Objects[player] then
        for _, drawing in pairs(self.Objects[player]) do
            if type(drawing) == "table" then
                for _, subDrawing in pairs(drawing) do
                    pcall(function() subDrawing:Remove() end)
                end
            else
                pcall(function() drawing:Remove() end)
            end
        end
        self.Objects[player] = nil
    end
end

function ESPSystem:UpdateESP()
    -- Clean up old players
    for player, _ in pairs(self.Objects) do
        if not player.Parent then
            self:RemovePlayerESP(player)
        end
    end
    
    -- Create ESP for valid players
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if Config.ESP.TeamCheck and player.Team == LocalPlayer.Team then
            self:RemovePlayerESP(player)
            continue
        end
        
        if not Utility:IsPlayerAlive(player) then
            self:RemovePlayerESP(player)
            continue
        end
        
        if not self.Objects[player] then
            self:CreatePlayerESP(player)
        end
    end
end

function ESPSystem:RenderESP()
    if not Config.ESP.Enabled then
        for _, drawings in pairs(self.Objects) do
            for _, drawing in pairs(drawings) do
                if type(drawing) ~= "table" then
                    drawing.Visible = false
                end
            end
        end
        return
    end
    
    local screenWidth = Camera.ViewportSize.X
    local screenHeight = Camera.ViewportSize.Y
    
    for player, drawings in pairs(self.Objects) do
        local character = player.Character
        if not character then continue end
        
        local head = character:FindFirstChild("Head")
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if not head or not hrp or not humanoid then continue end
        
        local headPos, headOnScreen = Utility:WorldToScreen(head.Position)
        local hrpPos, hrpOnScreen = Utility:WorldToScreen(hrp.Position)
        
        if not headOnScreen or not hrpOnScreen then
            for _, drawing in pairs(drawings) do
                if type(drawing) ~= "table" then
                    drawing.Visible = false
                end
            end
            continue
        end
        
        local height = math.abs(headPos.Y - hrpPos.Y) * 1.4
        local width = height * 0.6
        local boxX = hrpPos.X - width / 2
        local boxY = headPos.Y - height * 0.1
        local healthPercent = humanoid.Health / humanoid.MaxHealth
        local espColor = Config.ESP.Box.Color
        
        -- Team color
        if player.Team == LocalPlayer.Team then
            espColor = Config.ESP.Box.TeamColor
        end
        
        -- Box
        if Config.ESP.Box.Enabled and drawings.Box then
            if Config.ESP.Box.Type == "2D" then
                drawings.Box.Visible = true
                drawings.Box.Position = Vector2.new(boxX, boxY)
                drawings.Box.Size = Vector2.new(width, height)
                drawings.Box.Color = espColor
            elseif Config.ESP.Box.Type == "Corner" then
                local cornerLength = width * 0.3
                
                drawings.BoxTopLeft.Visible = true
                drawings.BoxTopLeft.From = Vector2.new(boxX, boxY)
                drawings.BoxTopLeft.To = Vector2.new(boxX + cornerLength, boxY)
                
                drawings.BoxTopRight.Visible = true
                drawings.BoxTopRight.From = Vector2.new(boxX + width, boxY)
                drawings.BoxTopRight.To = Vector2.new(boxX + width - cornerLength, boxY)
                
                drawings.BoxBottomLeft.Visible = true
                drawings.BoxBottomLeft.From = Vector2.new(boxX, boxY + height)
                drawings.BoxBottomLeft.To = Vector2.new(boxX + cornerLength, boxY + height)
                
                drawings.BoxBottomRight.Visible = true
                drawings.BoxBottomRight.From = Vector2.new(boxX + width, boxY + height)
                drawings.BoxBottomRight.To = Vector2.new(boxX + width - cornerLength, boxY + height)
            end
        end
        
        -- Line
        if Config.ESP.Line.Enabled and drawings.Line then
            drawings.Line.Visible = true
            
            if Config.ESP.Line.Type == "Bottom" then
                drawings.Line.From = Vector2.new(screenWidth / 2, screenHeight)
                drawings.Line.To = Vector2.new(hrpPos.X, hrpPos.Y)
            elseif Config.ESP.Line.Type == "Top" then
                drawings.Line.From = Vector2.new(screenWidth / 2, 0)
                drawings.Line.To = Vector2.new(hrpPos.X, hrpPos.Y)
            else
                drawings.Line.From = Vector2.new(screenWidth / 2, screenHeight / 2)
                drawings.Line.To = Vector2.new(hrpPos.X, hrpPos.Y)
            end
        end
        
        -- Health
        if Config.ESP.Health.Enabled and drawings.HealthBg and drawings.HealthBar then
            local barWidth = Config.ESP.Health.Width
            local barX = boxX - barWidth - 2
            
            drawings.HealthBg.Visible = true
            drawings.HealthBg.Position = Vector2.new(barX, boxY)
            drawings.HealthBg.Size = Vector2.new(barWidth, height)
            
            local barHeight = height * healthPercent
            drawings.HealthBar.Visible = true
            drawings.HealthBar.Position = Vector2.new(barX, boxY + height - barHeight)
            drawings.HealthBar.Size = Vector2.new(barWidth, barHeight)
            drawings.HealthBar.Color = Utility:GetHealthColor(healthPercent)
        end
        
        -- Name
        if Config.ESP.Name.Enabled and drawings.Name then
            drawings.Name.Visible = true
            drawings.Name.Text = player.Name
            drawings.Name.Position = Vector2.new(hrpPos.X, boxY - 20)
        end
        
        -- Distance
        if Config.ESP.Distance.Enabled and drawings.Distance then
            local dist = Utility:GetDistance(Camera.CFrame.Position, hrp.Position)
            local distText = Config.ESP.Distance.Format == "meters" 
                and string.format("[%.0fm]", dist / 3.5) 
                or string.format("[%.0f studs]", dist)
            
            drawings.Distance.Visible = true
            drawings.Distance.Text = distText
            drawings.Distance.Position = Vector2.new(hrpPos.X, boxY + height + 6)
        end
        
        -- Weapon
        if Config.ESP.Weapon.Enabled and drawings.Weapon then
            local tool = character:FindFirstChildOfClass("Tool")
            local weaponName = tool and tool.Name or "Hands"
            
            drawings.Weapon.Visible = true
            drawings.Weapon.Text = weaponName
            drawings.Weapon.Position = Vector2.new(hrpPos.X, boxY + height + 20)
        end
        
        -- Head Dot
        if Config.ESP.HeadDot.Enabled and drawings.HeadDot then
            drawings.HeadDot.Visible = true
            drawings.HeadDot.Position = Vector2.new(headPos.X, headPos.Y)
        end
        
        -- Snapline
        if Config.ESP.Snapline.Enabled and drawings.Snapline then
            drawings.Snapline.Visible = true
            drawings.Snapline.From = Vector2.new(screenWidth / 2, 0)
            drawings.Snapline.To = Vector2.new(hrpPos.X, hrpPos.Y)
        end
        
        -- Skeleton
        if Config.ESP.Skeleton.Enabled and drawings.SkeletonLines then
            local bonePositions = {}
            
            for _, boneName in ipairs(Config.ESP.Skeleton.Bones) do
                local bone = character:FindFirstChild(boneName)
                if bone then
                    local bonePos, boneOnScreen = Utility:WorldToScreen(bone.Position)
                    if boneOnScreen then
                        bonePositions[boneName] = bonePos
                    end
                end
            end
            
            -- Draw skeleton lines
            local connections = {
                {"Head", "UpperTorso"},
                {"UpperTorso", "LowerTorso"},
                {"UpperTorso", "LeftUpperArm"},
                {"LeftUpperArm", "LeftLowerArm"},
                {"LeftLowerArm", "LeftHand"},
                {"UpperTorso", "RightUpperArm"},
                {"RightUpperArm", "RightLowerArm"},
                {"RightLowerArm", "RightHand"},
                {"LowerTorso", "LeftUpperLeg"},
                {"LeftUpperLeg", "LeftLowerLeg"},
                {"LeftLowerLeg", "LeftFoot"},
                {"LowerTorso", "RightUpperLeg"},
                {"RightUpperLeg", "RightLowerLeg"},
                {"RightLowerLeg", "RightFoot"},
            }
            
            for i, connection in ipairs(connections) do
                if drawings.SkeletonLines[i] then
                    local fromPos = bonePositions[connection[1]]
                    local toPos = bonePositions[connection[2]]
                    
                    if fromPos and toPos then
                        drawings.SkeletonLines[i].Visible = true
                        drawings.SkeletonLines[i].From = Vector2.new(fromPos.X, fromPos.Y)
                        drawings.SkeletonLines[i].To = Vector2.new(toPos.X, toPos.Y)
                    else
                        drawings.SkeletonLines[i].Visible = false
                    end
                end
            end
        end
    end
end

function ESPSystem:Destroy()
    for player, _ in pairs(self.Objects) do
        self:RemovePlayerESP(player)
    end
end

-- =============================================
-- 🔥 SECTION 8: RADAR SYSTEM
-- =============================================
local RadarSystem = {}
RadarSystem.__index = RadarSystem

function RadarSystem.new()
    local self = setmetatable({}, RadarSystem)
    
    self.Background = DrawingSystem:CreateSquare({
        Visible = Config.Radar.Enabled,
        Position = Vector2.new(10, Camera.ViewportSize.Y - Config.Radar.Size - 10),
        Size = Vector2.new(Config.Radar.Size, Config.Radar.Size),
        Color = Config.Radar.BackgroundColor,
        Filled = true,
        Transparency = Config.Radar.BackgroundTransparency,
    })
    
    self.Dots = {}
    
    return self
end

function RadarSystem:Update()
    self.Background.Visible = Config.Radar.Enabled
    
    if not Config.Radar.Enabled then return end
    
    local radarPos = Vector2.new(10, Camera.ViewportSize.Y - Config.Radar.Size - 10)
    local radarCenter = radarPos + Vector2.new(Config.Radar.Size / 2, Config.Radar.Size / 2)
    local scale = Config.Radar.Size / (Config.Radar.Range * 2)
    
    -- Draw local player
    if not self.Dots["LocalPlayer"] then
        self.Dots["LocalPlayer"] = DrawingSystem:CreateCircle({
            Color = Config.Radar.LocalPlayerColor,
            Radius = 4,
            Filled = true,
            Position = radarCenter,
        })
    end
    self.Dots["LocalPlayer"].Position = radarCenter
    
    -- Draw enemies
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if not Utility:IsPlayerAlive(player) then continue end
        
        local character = player.Character
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        
        local localHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not localHRP then continue end
        
        local relativePos = hrp.Position - localHRP.Position
        local dotPos = radarCenter + Vector2.new(relativePos.X * scale, relativePos.Z * scale)
        
        if dotPos.X >= radarPos.X and dotPos.X <= radarPos.X + Config.Radar.Size and
           dotPos.Y >= radarPos.Y and dotPos.Y <= radarPos.Y + Config.Radar.Size then
            
            if not self.Dots[player] then
                self.Dots[player] = DrawingSystem:CreateCircle({
                    Color = player.Team == LocalPlayer.Team and Config.Radar.TeamColor or Config.Radar.EnemyColor,
                    Radius = Config.Radar.DotSize,
                    Filled = true,
                    Position = dotPos,
                })
            end
            
            self.Dots[player].Position = dotPos
            self.Dots[player].Visible = true
        else
            if self.Dots[player] then
                self.Dots[player].Visible = false
            end
        end
    end
    
    -- Clean up
    for player, dot in pairs(self.Dots) do
        if player ~= "LocalPlayer" and not player.Parent then
            dot:Remove()
            self.Dots[player] = nil
        end
    end
end

function RadarSystem:Destroy()
    for _, dot in pairs(self.Dots) do
        dot:Remove()
    end
    self.Background:Remove()
end

-- =============================================
-- 🔥 SECTION 9: CROSSHAIR SYSTEM
-- =============================================
local CrosshairSystem = {}
CrosshairSystem.__index = CrosshairSystem

function CrosshairSystem.new()
    local self = setmetatable({}, CrosshairSystem)
    
    local screenCenter = Camera.ViewportSize / 2
    local size = Config.Visual.Crosshair.Size
    
    self.HorizontalLine = DrawingSystem:CreateLine({
        Visible = Config.Visual.Crosshair.Enabled,
        From = Vector2.new(screenCenter.X - size, screenCenter.Y),
        To = Vector2.new(screenCenter.X + size, screenCenter.Y),
        Color = Config.Visual.Crosshair.Color,
        Thickness = Config.Visual.Crosshair.Thickness,
    })
    
    self.VerticalLine = DrawingSystem:CreateLine({
        Visible = Config.Visual.Crosshair.Enabled,
        From = Vector2.new(screenCenter.X, screenCenter.Y - size),
        To = Vector2.new(screenCenter.X, screenCenter.Y + size),
        Color = Config.Visual.Crosshair.Color,
        Thickness = Config.Visual.Crosshair.Thickness,
    })
    
    return self
end

function CrosshairSystem:Update()
    local screenCenter = Camera.ViewportSize / 2
    local size = Config.Visual.Crosshair.Size
    
    self.HorizontalLine.Visible = Config.Visual.Crosshair.Enabled
    self.VerticalLine.Visible = Config.Visual.Crosshair.Enabled
    
    self.HorizontalLine.From = Vector2.new(screenCenter.X - size, screenCenter.Y)
    self.HorizontalLine.To = Vector2.new(screenCenter.X + size, screenCenter.Y)
    self.HorizontalLine.Color = Config.Visual.Crosshair.Color
    self.HorizontalLine.Thickness = Config.Visual.Crosshair.Thickness
    
    self.VerticalLine.From = Vector2.new(screenCenter.X, screenCenter.Y - size)
    self.VerticalLine.To = Vector2.new(screenCenter.X, screenCenter.Y + size)
    self.VerticalLine.Color = Config.Visual.Crosshair.Color
    self.VerticalLine.Thickness = Config.Visual.Crosshair.Thickness
end

function CrosshairSystem:Destroy()
    self.HorizontalLine:Remove()
    self.VerticalLine:Remove()
end

-- =============================================
-- 🔥 SECTION 10: UI SYSTEM
-- =============================================
local UISystem = {}
UISystem.__index = UISystem

function UISystem.new()
    local self = setmetatable({}, UISystem)
    
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Parent = game:GetService("CoreGui")
    self.ScreenGui.Name = "GII_Ultimate_UI"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    self.MainMenu = nil
    self.MinimizeIcon = nil
    self.IsMinimized = false
    self.Buttons = {}
    self.Tabs = {}
    
    self:CreateMainMenu()
    self:CreateMinimizeIcon()
    self:CreateContent()
    
    return self
end

function UISystem:CreateMainMenu()
    self.MainMenu = Instance.new("Frame")
    self.MainMenu.Parent = self.ScreenGui
    self.MainMenu.BackgroundColor3 = Config.UI.BackgroundColor
    self.MainMenu.BorderSizePixel = 0
    self.MainMenu.Size = Config.UI.Size
    self.MainMenu.Position = Config.UI.Position
    self.MainMenu.ClipsDescendants = true
    self.MainMenu.Visible = true
    
    Instance.new("UICorner", self.MainMenu).CornerRadius = UDim.new(0, 8)
    
    local UIGradient = Instance.new("UIGradient", self.MainMenu)
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Config.UI.BackgroundColor),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 10, 50)),
    })
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Parent = self.MainMenu
    Header.BackgroundColor3 = Config.UI.AccentColor
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0, 30)
    Header.Name = "Header"
    
    Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)
    
    local HeaderStroke = Instance.new("UIStroke", Header)
    HeaderStroke.Color = Color3.fromRGB(255, 255, 255)
    HeaderStroke.Thickness = 0.5
    HeaderStroke.Transparency = 0.5
    
    local Title = Instance.new("TextLabel")
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -60, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = "🔥 GII CHEAT v" .. Config.ScriptVersion
    Title.TextColor3 = Config.UI.TextColor
    Title.TextScaled = true
    Title.Font = Config.UI.Font
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = Header
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    CloseBtn.Size = UDim2.new(0, 22, 0, 22)
    CloseBtn.Position = UDim2.new(1, -26, 0, 4)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextScaled = true
    CloseBtn.Font = Enum.Font.GothamBold
    
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
    
    CloseBtn.MouseButton1Click:Connect(function()
        self:ToggleMinimize()
    end)
    
    -- Minimize button
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Parent = Header
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    MinimizeBtn.Size = UDim2.new(0, 22, 0, 22)
    MinimizeBtn.Position = UDim2.new(1, -52, 0, 4)
    MinimizeBtn.Text = "─"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextScaled = true
    MinimizeBtn.Font = Enum.Font.GothamBold
    
    Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0)
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        self:ToggleMinimize()
    end)
    
    -- Drag
    local isDragging = false
    local dragStart, startPos
    
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            dragStart = input.Position
            startPos = self.MainMenu.Position
        end
    end)
    
    Header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
    
    Services.UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            self.MainMenu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function UISystem:CreateMinimizeIcon()
    self.MinimizeIcon = Instance.new("TextButton")
    self.MinimizeIcon.Parent = self.ScreenGui
    self.MinimizeIcon.BackgroundColor3 = Config.UI.AccentColor
    self.MinimizeIcon.BorderSizePixel = 0
    self.MinimizeIcon.Size = UDim2.new(0, 40, 0, 40)
    self.MinimizeIcon.Position = UDim2.new(0.88, 0, 0.5, -20)
    self.MinimizeIcon.Text = "😈"
    self.MinimizeIcon.TextScaled = true
    self.MinimizeIcon.Font = Enum.Font.GothamBlack
    self.MinimizeIcon.Visible = false
    
    Instance.new("UICorner", self.MinimizeIcon).CornerRadius = UDim.new(1, 0)
    
    local Stroke = Instance.new("UIStroke", self.MinimizeIcon)
    Stroke.Color = Color3.fromRGB(255, 255, 255)
    Stroke.Thickness = 1.5
    
    self.MinimizeIcon.MouseButton1Click:Connect(function()
        self:ToggleMinimize()
    end)
    
    -- Icon drag
    local iconDragging = false
    local iconDragStart, iconStartPos
    
    self.MinimizeIcon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            iconDragging = true
            iconDragStart = input.Position
            iconStartPos = self.MinimizeIcon.Position
        end
    end)
    
    self.MinimizeIcon.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            iconDragging = false
        end
    end)
    
    Services.UserInputService.InputChanged:Connect(function(input)
        if iconDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - iconDragStart
            self.MinimizeIcon.Position = UDim2.new(iconStartPos.X.Scale, iconStartPos.X.Offset + delta.X, iconStartPos.Y.Scale, iconStartPos.Y.Offset + delta.Y)
        end
    end)
end

function UISystem:CreateContent()
    -- Scrolling frame
    local ContentScroll = Instance.new("ScrollingFrame")
    ContentScroll.Parent = self.MainMenu
    ContentScroll.BackgroundTransparency = 1
    ContentScroll.Size = UDim2.new(1, 0, 1, -35)
    ContentScroll.Position = UDim2.new(0, 0, 0, 35)
    ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 800)
    ContentScroll.ScrollBarThickness = 3
    ContentScroll.ScrollBarImageColor3 = Config.UI.AccentColor
    ContentScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = ContentScroll
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 2)
    
    -- Button creator
    local function createLabel(text)
        local label = Instance.new("TextLabel")
        label.Parent = ContentScroll
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(1, -10, 0, 18)
        label.Text = text
        label.TextColor3 = Config.UI.AccentColor
        label.Font = Config.UI.Font
        label.TextScaled = true
        label.TextXAlignment = Enum.TextXAlignment.Left
        return label
    end
    
    local function createToggle(name, default, callback)
        local btn = Instance.new("TextButton")
        btn.Parent = ContentScroll
        btn.BackgroundColor3 = default and Color3.fromRGB(0, 180, 80) or Config.UI.SecondaryColor
        btn.BorderSizePixel = 0
        btn.Size = UDim2.new(1, -10, 0, 28)
        btn.Text = "  " .. name .. (default and " ✅" or " ❌")
        btn.TextColor3 = Config.UI.TextColor
        btn.Font = Config.UI.Font
        btn.TextScaled = true
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.AutoButtonColor = false
        
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
        
        local UIStroke = Instance.new("UIStroke", btn)
        UIStroke.Color = Config.UI.AccentColor
        UIStroke.Thickness = 0.5
        UIStroke.Transparency = 0.7
        
        local state = default
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 80) or Config.UI.SecondaryColor
            btn.Text = "  " .. name .. (state and " ✅" or " ❌")
            callback(state)
        end)
        
        self.Buttons[name] = btn
        return btn
    end
    
    -- ===== AIMBOT SECTION =====
    createLabel("═══ 🎯 AIMBOT ═══")
    
    createToggle("Enable Aimbot", true, function(s) Config.Aimbot.Enabled = s end)
    createToggle("Silent Aim", true, function(s) Config.Aimbot.SilentAim.Enabled = s end)
    createToggle("Wall Check", true, function(s) Config.Aimbot.WallCheck = s end)
    createToggle("Team Check", false, function(s) Config.Aimbot.TeamCheck = not s end)
    createToggle("Auto Shoot", true, function(s) Config.Aimbot.SilentAim.AutoShoot = s end)
    createToggle("Prediction", true, function(s) Config.Aimbot.Prediction.Enabled = s end)
    createToggle("FOV Circle", true, function(s) Config.Aimbot.FOV.Enabled = s end)
    createToggle("Trigger Bot", true, function(s) Config.Aimbot.TriggerBot.Enabled = s end)
    createToggle("Lock Head", true, function(s) Config.Aimbot.LockPart = s and "Head" or "HumanoidRootPart" end)
    
    -- ===== ESP SECTION =====
    createLabel("═══ 👁️ ESP ═══")
    
    createToggle("Enable ESP", true, function(s) Config.ESP.Enabled = s end)
    createToggle("ESP Box", true, function(s) Config.ESP.Box.Enabled = s end)
    createToggle("ESP Line", true, function(s) Config.ESP.Line.Enabled = s end)
    createToggle("ESP Health", true, function(s) Config.ESP.Health.Enabled = s end)
    createToggle("ESP Name", true, function(s) Config.ESP.Name.Enabled = s end)
    createToggle("ESP Distance", true, function(s) Config.ESP.Distance.Enabled = s end)
    createToggle("ESP Weapon", true, function(s) Config.ESP.Weapon.Enabled = s end)
    createToggle("ESP Skeleton", true, function(s) Config.ESP.Skeleton.Enabled = s end)
    createToggle("ESP Head Dot", true, function(s) Config.ESP.HeadDot.Enabled = s end)
    createToggle("ESP Snapline", true, function(s) Config.ESP.Snapline.Enabled = s end)
    createToggle("ESP Chams", true, function(s) Config.ESP.Chams.Enabled = s end)
    
    -- ===== RADAR SECTION =====
    createLabel("═══ 📡 RADAR ═══")
    
    createToggle("Enable Radar", true, function(s) Config.Radar.Enabled = s end)
    
    -- ===== MISC SECTION =====
    createLabel("═══ ⚡ MISC ═══")
    
    createToggle("Speed Hack", false, function(s) Config.Misc.SpeedHack.Enabled = s end)
    createToggle("Jump Hack", false, function(s) Config.Misc.JumpHack.Enabled = s end)
    createToggle("Infinite Jump", false, function(s) Config.Misc.JumpHack.InfiniteJump = s end)
    createToggle("Fly Hack", false, function(s) Config.Misc.FlyHack.Enabled = s end)
    createToggle("No Clip", false, function(s) Config.Misc.NoClip.Enabled = s end)
    createToggle("Infinite Ammo", false, function(s) Config.Misc.InfiniteAmmo.Enabled = s end)
    createToggle("Rapid Fire", false, function(s) Config.Misc.RapidFire.Enabled = s end)
    createToggle("No Recoil", false, function(s) Config.Misc.NoRecoil.Enabled = s end)
    createToggle("No Spread", false, function(s) Config.Misc.NoSpread.Enabled = s end)
    createToggle("Instant Reload", false, function(s) Config.Misc.InstantReload.Enabled = s end)
    createToggle("Anti AFK", true, function(s) Config.Misc.AntiAfk.Enabled = s end)
    
    -- ===== VISUAL SECTION =====
    createLabel("═══ 🎨 VISUAL ═══")
    
    createToggle("Crosshair", true, function(s) Config.Visual.Crosshair.Enabled = s end)
    createToggle("Hitmarker", true, function(s) Config.Visual.Hitmarker.Enabled = s end)
    createToggle("Kill Effect", true, function(s) Config.Visual.KillEffect.Enabled = s end)
    createToggle("Bullet Tracers", true, function(s) Config.Visual.BulletTracers.Enabled = s end)
    createToggle("Full Bright", false, function(s) Config.Visual.FullBright.Enabled = s end)
    createToggle("No Fog", true, function(s) Config.Visual.NoFog = s end)
    createToggle("No Bloom", true, function(s) Config.Visual.NoBloom = s end)
    createToggle("No Blur", true, function(s) Config.Visual.NoBlur = s end)
    createToggle("Third Person", false, function(s) Config.Visual.ThirdPerson.Enabled = s end)
    createToggle("FOV Changer", false, function(s) Config.Visual.FieldOfView.Enabled = s end)
    createToggle("Zoom Hack", false, function(s) Config.Visual.ZoomHack.Enabled = s end)
end

function UISystem:ToggleMinimize()
    self.IsMinimized = not self.IsMinimized
    
    if self.IsMinimized then
        Services.TweenService:Create(self.MainMenu, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
        }):Play()
        
        task.wait(0.3)
        self.MainMenu.Visible = false
        self.MinimizeIcon.Visible = true
    else
        self.MinimizeIcon.Visible = false
        self.MainMenu.Visible = true
        
        Services.TweenService:Create(self.MainMenu, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = Config.UI.Size,
            Position = Config.UI.Position,
        }):Play()
    end
end

function UISystem:Destroy()
    self.ScreenGui:Destroy()
end

-- =============================================
-- 🔥 SECTION 11: MISC HACKS SYSTEM
-- =============================================
local MiscSystem = {}
MiscSystem.__index = MiscSystem

function MiscSystem.new()
    local self = setmetatable({}, MiscSystem)
    
    self.SpeedConnection = nil
    self.JumpConnection = nil
    self.FlyConnection = nil
    self.NoClipConnection = nil
    self.AntiAfkConnection = nil
    
    return self
end

function MiscSystem:UpdateSpeedHack()
    if self.SpeedConnection then
        self.SpeedConnection:Disconnect()
        self.SpeedConnection = nil
    end
    
    if Config.Misc.SpeedHack.Enabled then
        self.SpeedConnection = Services.RunService.Heartbeat:Connect(function()
            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = Config.Misc.SpeedHack.Speed
                end
            end
        end)
    else
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
end

function MiscSystem:UpdateJumpHack()
    if self.JumpConnection then
        self.JumpConnection:Disconnect()
        self.JumpConnection = nil
    end
    
    if Config.Misc.JumpHack.Enabled then
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = Config.Misc.JumpHack.JumpPower
                
                if Config.Misc.JumpHack.InfiniteJump then
                    self.JumpConnection = Services.UserInputService.JumpRequest:Connect(function()
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end)
                end
            end
        end
    else
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = 50
            end
        end
    end
end

function MiscSystem:UpdateFlyHack()
    if self.FlyConnection then
        self.FlyConnection:Disconnect()
        self.FlyConnection = nil
    end
    
    if Config.Misc.FlyHack.Enabled then
        local character = LocalPlayer.Character
        if character then
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
                bodyVelocity.Parent = hrp
                
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
                bodyGyro.CFrame = Camera.CFrame
                bodyGyro.Parent = hrp
                
                self.FlyConnection = Services.RunService.Heartbeat:Connect(function()
                    bodyVelocity.Velocity = Camera.CFrame.LookVector * Config.Misc.FlyHack.Speed
                    bodyGyro.CFrame = Camera.CFrame
                end)
            end
        end
    end
end

function MiscSystem:UpdateNoClip()
    if Config.Misc.NoClip.Enabled then
        self.NoClipConnection = Services.RunService.Stepped:Connect(function()
            local character = LocalPlayer.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if self.NoClipConnection then
            self.NoClipConnection:Disconnect()
            self.NoClipConnection = nil
            
            local character = LocalPlayer.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
end

function MiscSystem:UpdateAntiAfk()
    if Config.Misc.AntiAfk.Enabled then
        if self.AntiAfkConnection then
            self.AntiAfkConnection:Disconnect()
        end
        
        self.AntiAfkConnection = Services.RunService.Heartbeat:Connect(function()
            local VirtualUser = game:GetService("VirtualUser")
            if VirtualUser then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end
        end)
    else
        if self.AntiAfkConnection then
            self.AntiAfkConnection:Disconnect()
            self.AntiAfkConnection = nil
        end
    end
end

function MiscSystem:UpdateVisual()
    -- No Fog
    if Config.Visual.NoFog then
        Services.Lighting.FogEnd = 999999
        Services.Lighting.FogStart = 999999
    end
    
    -- No Bloom
    if Config.Visual.NoBloom then
        Services.Lighting.Bloom = 0
    end
    
    -- No Blur
    if Config.Visual.NoBlur then
        Services.Lighting.Blur = 0
    end
    
    -- Full Bright
    if Config.Visual.FullBright.Enabled then
        Services.Lighting.Brightness = Config.Visual.FullBright.Amount
        Services.Lighting.ClockTime = 14
        Services.Lighting.FogEnd = 999999
        Services.Lighting.GlobalShadows = false
        Services.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
    
    -- Third Person
    if Config.Visual.ThirdPerson.Enabled then
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        LocalPlayer.CameraMaxZoomDistance = Config.Visual.ThirdPerson.Distance
        LocalPlayer.CameraMinZoomDistance = Config.Visual.ThirdPerson.Distance
    end
    
    -- FOV
    if Config.Visual.FieldOfView.Enabled then
        Camera.FieldOfView = Config.Visual.FieldOfView.Amount
    end
end

function MiscSystem:Destroy()
    if self.SpeedConnection then self.SpeedConnection:Disconnect() end
    if self.JumpConnection then self.JumpConnection:Disconnect() end
    if self.FlyConnection then self.FlyConnection:Disconnect() end
    if self.NoClipConnection then self.NoClipConnection:Disconnect() end
    if self.AntiAfkConnection then self.AntiAfkConnection:Disconnect() end
end

-- =============================================
-- 🔥 SECTION 12: KEYBIND SYSTEM
-- =============================================
local KeybindSystem = {}
KeybindSystem.__index = KeybindSystem

function KeybindSystem.new()
    local self = setmetatable({}, KeybindSystem)
    
    self.Handlers = {}
    self.ActiveKeys = {}
    
    Services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Config.Keybinds.AimbotToggle then
            Config.Aimbot.Enabled = not Config.Aimbot.Enabled
            Utility:CreateNotification("GII CHEAT", Config.Aimbot.Enabled and "🎯 Aimbot: ON" or "🎯 Aimbot: OFF", 1.5)
        end
        
        if input.KeyCode == Config.Keybinds.ESPToggle then
            Config.ESP.Enabled = not Config.ESP.Enabled
            Utility:CreateNotification("GII CHEAT", Config.ESP.Enabled and "👁️ ESP: ON" or "👁️ ESP: OFF", 1.5)
        end
        
        if input.KeyCode == Config.Keybinds.MenuToggle then
            -- Toggle UI
            if UISystem then
                UISystem:ToggleMinimize()
            end
        end
        
        if input.KeyCode == Config.Keybinds.PanicKey then
            -- Disable all features
            Config.Aimbot.Enabled = false
            Config.ESP.Enabled = false
            Config.Misc.SpeedHack.Enabled = false
            Config.Misc.JumpHack.Enabled = false
            Config.Misc.FlyHack.Enabled = false
            Config.Misc.NoClip.Enabled = false
            Utility:CreateNotification("GII CHEAT", "😱 PANIC MODE: ALL OFF!", 2)
        end
        
        if input.KeyCode == Enum.KeyCode.F then
            Config.Misc.FlyHack.Enabled = not Config.Misc.FlyHack.Enabled
        end
        
        if input.KeyCode == Enum.KeyCode.G then
            Config.Misc.NoClip.Enabled = not Config.Misc.NoClip.Enabled
        end
        
        if input.KeyCode == Enum.KeyCode.Z then
            Config.Visual.ZoomHack.Enabled = not Config.Visual.ZoomHack.Enabled
        end
    end)
    
    return self
end

-- =============================================
-- 🔥 SECTION 13: MAIN SYSTEM
-- =============================================
local MainSystem = {}
MainSystem.__index = MainSystem

function MainSystem.new()
    local self = setmetatable({}, MainSystem)
    
    self.Aimbot = AimbotSystem.new()
    self.ESP = ESPSystem.new()
    self.Radar = RadarSystem.new()
    self.Crosshair = CrosshairSystem.new()
    self.UI = UISystem.new()
    self.Misc = MiscSystem.new()
    self.Keybinds = KeybindSystem.new()
    self.Running = true
    
    return self
end

function MainSystem:Update()
    self.Aimbot:Update()
    self.ESP:UpdateESP()
    self.ESP:RenderESP()
    self.Radar:Update()
    self.Crosshair:Update()
    self.Misc:UpdateSpeedHack()
    self.Misc:UpdateJumpHack()
    self.Misc:UpdateFlyHack()
    self.Misc:UpdateNoClip()
    self.Misc:UpdateAntiAfk()
    self.Misc:UpdateVisual()
end

function MainSystem:Start()
    -- Watermark
    if Config.UI.Watermark then
        local Watermark = DrawingSystem:CreateText({
            Text = "GII CHEAT v" .. Config.ScriptVersion .. " | ECU ULTIMATE | 😈",
            Color = Color3.fromRGB(255, 0, 100),
            Size = 14,
            Position = Vector2.new(10, 10),
            Outline = true,
            Font = 3,
        })
        
        Services.RunService.RenderStepped:Connect(function()
            Watermark.Visible = true
        end)
    end
    
    -- Main loop
    Services.RunService.RenderStepped:Connect(function()
        if self.Running then
            pcall(function()
                self:Update()
            end)
        end
    end)
    
    -- Auto update ESP
    task.spawn(function()
        while self.Running do
            task.wait(1)
            self.ESP:UpdateESP()
        end
    end)
    
    -- Loading notification
    Utility:CreateNotification(
        "GII CHEAT v" .. Config.ScriptVersion,
        "🔥 Loaded! Aimbot + ESP + Radar + Misc Hacks Ready!",
        5
    )
    
    -- Print to console
    print([[
╔══════════════════════════════════════════════╗
║  🔥 GII CHEAT ULTIMATE v]] .. Config.ScriptVersion .. [[ LOADED!     ║
║  🎯 Aimbot: INSTA LOCK HEAD                ║
║  👁️ ESP: Box/Line/Health/Skeleton/Name     ║
║  📡 Radar: Active                          ║
║  ⚡ Misc: Speed/Jump/Fly/NoClip/AntiAFK   ║
║  🎨 Visual: Crosshair/Hitmarker/FullBright ║
║  📱 UI: Mobile Optimized + Minimize        ║
║  😈 BY: ECU (Evil Captain Underpants)     ║
║  💀 GAS BOS! BANTAI SEMUA! NO MISTAKE!   ║
╚══════════════════════════════════════════════╝
    ])
end

function MainSystem:Stop()
    self.Running = false
    self.Aimbot:Destroy()
    self.ESP:Destroy()
    self.Radar:Destroy()
    self.Crosshair:Destroy()
    self.UI:Destroy()
    self.Misc:Destroy()
end

-- =============================================
-- 🔥 SECTION 14: INITIALIZATION
-- =============================================
local GII_Cheat = nil

local function Initialize()
    -- Wait for game to fully load
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    
    -- Wait for local player
    local player = Services.Players.LocalPlayer
    if not player then
        Services.Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        player = Services.Players.LocalPlayer
    end
    
    -- Wait for character
    if not player.Character then
        player.CharacterAdded:Wait()
    end
    
    -- Create main system
    GII_Cheat = MainSystem.new()
    GII_Cheat:Start()
    
    -- Handle character respawn
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        -- Re-apply hacks on respawn
        if GII_Cheat then
            GII_Cheat.Misc:UpdateSpeedHack()
            GII_Cheat.Misc:UpdateJumpHack()
            GII_Cheat.Misc:UpdateNoClip()
        end
    end)
end

-- =============================================
-- 🔥 SECTION 15: ERROR HANDLING & ANTI-CRASH
-- =============================================
local function SafeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("GII CHEAT ERROR: ", result)
    end
    return result
end

-- Global error handler
local oldErrorHandler = getgenv and getgenv().__ERR_HANDLER__
if not oldErrorHandler then
    if getgenv then
        getgenv().__ERR_HANDLER__ = true
    end
end

-- =============================================
-- 🔥 SECTION 16: STARTUP
-- =============================================
SafeCall(Initialize)

-- Anti-detection
if getgenv then
    getgenv().GII_Cheat = GII_Cheat
    getgenv().GII_Config = Config
end

-- =============================================
-- 🔥 END OF SCRIPT — 2000+ LINES OF PURE POWER
-- 😈 ECU ULTIMATE — GAS BOS! BANTAI SERVER!
-- =============================================
