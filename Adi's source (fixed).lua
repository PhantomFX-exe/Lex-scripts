pcall(function()
    _G.SpeedMaster = false
    _G.SpeedActive = false
    local lp = game:GetService("Players").LocalPlayer
    local pg = lp and lp:FindFirstChild("PlayerGui")
    for _, parent in ipairs({pg, game:GetService("CoreGui")}) do
        if parent then
            for _, n in ipairs({"MockupInterface", "SaturnsMainUI", "SaturnSkinChanger"}) do
                local o = parent:FindFirstChild(n)
                if o then o:Destroy() end
            end
        end
    end
    if gethui then
        local h = gethui()
        for _, n in ipairs({"MockupInterface", "SaturnsMainUI", "SaturnSkinChanger"}) do
            local o = h:FindFirstChild(n)
            if o then o:Destroy() end
        end
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local me = LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UIS = game:GetService('UserInputService')
local cam = workspace.CurrentCamera
local mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local CAS = game:GetService("ContextActionService")
local selectedTeleportUserId = nil
local teleportHeld = false
local teleportLoopConnection = nil
local TriggerBot = {
    MasterEnabled = false,  -- must be ON for the key to work
    Active = false,         -- toggled by the keybind
    Key = Enum.KeyCode.B,
    Delay = 0.08
}
local function isWhitelisted(player)
    return player and _G.Whitelist and _G.Whitelist[player.UserId] == true
end

local Developers = {
    [10266468532] = {name = "adiDiamants", role = "Developer"},
}

game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Adis.UI", Text = "adis main loaded!", Duration = 3 })

local function checkForDevelopers()
    for _, player in ipairs(Players:GetPlayers()) do
        local dev = Developers[player.UserId]
        if dev then
            local roleIcon = dev.role == "Developer" and "👑" or "🛡️"
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = roleIcon .. " " .. dev.role .. " Joined " .. roleIcon,
                Text = dev.name .. " is already in the server!",
                Duration = 10
            })
        end
    end
end

checkForDevelopers()

Players.PlayerAdded:Connect(function(player)
    local dev = Developers[player.UserId]
    if dev then
        task.wait(0.5)
        local roleIcon = dev.role == "Developer" and "👑" or "🛡️"
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = roleIcon .. " " .. dev.role .. " Joined " .. roleIcon,
            Text = dev.name .. " joined the server!",
            Duration = 10
        })
    end
end)

local function scanForUsers()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("Head") then
                local tag = char.Head:FindFirstChild("adis_user")
                if tag and tag:IsA("BoolValue") then
                    if Developers[LocalPlayer.UserId] then
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "User Detected",
                            Text = player.Name .. " is using adis",
                            Duration = 5
                        })
                    end
                end
            end
        end
    end
end

local function teleportToSelectedPlayer()
    if not selectedTeleportUserId then return end
    local target = Players:GetPlayerByUserId(selectedTeleportUserId)
    local character = LocalPlayer.Character
    local targetCharacter = target and target.Character
    if character and targetCharacter then
        local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            character:PivotTo(targetRoot.CFrame * CFrame.new(0, 0, 3))
        end
    end
end

local function stopTeleportLoop()
    teleportHeld = false
    if teleportLoopConnection then
        teleportLoopConnection:Disconnect()
        teleportLoopConnection = nil
    end
end

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or input.KeyCode ~= _G.TeleportKey then return end
    if _G.TeleportMode == "Hold" then
        teleportHeld = true
        if not teleportLoopConnection then
            teleportLoopConnection = RunService.Heartbeat:Connect(function()
                if teleportHeld then teleportToSelectedPlayer() end
            end)
        end
    else
        teleportToSelectedPlayer()
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == _G.TeleportKey and _G.TeleportMode == "Hold" then
        stopTeleportLoop()
    end
end)

_G.FOV_RADIUS = 0
_G.ShowFOV = false
_G.RevolverBypass = false
_G.WallCheck = false
_G.SilentAimEnabled = false
_G.SilentAim_Enabled = false
_G.KnockCheck = false
_G.DeathPositions = {}
_G.ESP_Boxes = false
_G.ESP_Names = false
_G.ESP_DisplayNames = false
_G.ESP_Health = false
_G.ESP_Distance = false
_G.ESP_Tracer = false
_G.ESP_Skeleton = false
_G.ESP_Color = Color3.fromRGB(255, 255, 255)
_G.SpeedMaster = false
_G.SpeedActive = false
_G.SpeedValue = 16
_G.SpeedKey = Enum.KeyCode.X
_G.FlamelockEnabled = false
_G.FlameMode = "Hold"
_G.FlameKey = Enum.KeyCode.Z
_G.FlameRightClick = false
_G.FlameSmoothness = 0
_G.FlamePrediction = 0
_G.FlameLeftOffset = 0
_G.FlameUpOffset = 0
_G.FlameHitPart = "HumanoidRootPart"
_G.FlameActive = false
_G.FPSUnlocker = true
_G.FPSTarget = 240
_G.UIToggleKey = Enum.KeyCode.RightShift
_G.UIVisible = true
_G.ESP_Enabled = false
_G.Whitelist = _G.Whitelist or {}
_G.BulletSpreadAmount = 100
_G.TeleportKey = _G.TeleportKey or Enum.KeyCode.T
_G.TeleportMode = _G.TeleportMode or "Hold"

_G.ForceHitEnabled = false
_G.ForceHitMode = "Fov"
_G.ForceHitFOV = 0
_G.ForceHitTracerEnabled = true
_G.ForceHitFullAutoEnabled = false
_G.ForceHitFireRate = 0

_G.HCSilentAimEnabled = false
_G.HCRevolverBypass = false
_G.HCWallCheck = false
_G.HCKnockCheck = false
_G.HCPrediction = false
_G.HCPredictionAmount = 0
_G.HCFOVRadius = 0
_G.HCShowFOV = false
_G.HCHitPart = "Head"

_G.OldAimEnabled = false
_G.OldAimShowFOV = false
_G.OldAimFOVRadius = 0
_G.OldAimHitChance = 0
_G.OldAimHitPart = "Head"
_G.OldAimClosestPart = false
_G.OldAimWallCheck = false
_G.OldAimKnockCheck = false
_G.OldAimPredictionX = 0
_G.OldAimPredictionY = 0
_G.OldAimPredictionZ = 0
_G.OldAimOffsetX = 0
_G.OldAimOffsetY = 0
_G.OldAimOffsetZ = 0
_G.OldAimMaxDistance = 1000
_G.OldAimUseKeybind = false
_G.OldAimToggleKey = Enum.KeyCode.V
_G.OldAimUIKey = Enum.KeyCode.RightShift

_G.HCGodmodeEnabled = false

_G.ColorCorrectionEnabled = false
_G.FogDensity = 0.45
_G.FogColor = Color3.fromRGB(180, 200, 220)
_G.CurrentTheme = "Cinnamoroll"

_G.CamlockEnabled = false
_G.CamlockToggleKey = "C"
_G.CamlockMode = "Toggle"
_G.CamlockAutoToggle = false
_G.CamlockHitPart = "HumanoidRootPart"
_G.CamlockEasingStyle = "Quad"
_G.CamlockEasingDirection = "Out"
_G.CamlockFOVRadius = 0
_G.CamlockClosestPointMode = "Default"
_G.CamlockClosestPointScale = 0
_G.CamlockSmoothness = 0
_G.CamlockPullStrengthEnabled = false
_G.CamlockPullStrengthBaseValue = 0
_G.CamlockPullStrengthMoveValue = 0
_G.CamlockPredictionEnabled = false
_G.CamlockPredictionX = 0
_G.CamlockPredictionY = 0
_G.CamlockPredictionZ = 0
_G.CamlockMaxDistance = 0
_G.CamlockConditionsForceField = false
_G.CamlockConditionsVisible = false
_G.CamlockConditionsCarried = false
_G.CamlockConditionsKnocked = false
_G.CamlockConditionsSelfKnocked = false

_G.AntiAimViewEnabled = true
_G.AntiModNotification = true
_G.AntiModKick = true
_G.AntiModKickDelay = 0
_G.AntiFallEnabled = true

_G.DelayChangerEnabled = false
_G.DelayChangerRevolver = 0
_G.DelayChangerDoubleBarrel = 0
_G.DelayChangerTacticalShotgun = 0
_G.DelayChangerOthers = 0

_G.HitboxEnabled = false
_G.HitboxSize = 0
_G.HitboxTransparency = 0
_G.HitboxColor = Color3.fromRGB(255, 140, 185)

local HCGodmode_Active = false
local HCGodmode_Track = nil
local HCGodmode_Heartbeat = nil
local HCGodmode_AnimConn = nil
local HCGodmode_EmoteID = "rbxassetid://70883871260184"
local HCGodmode_FreezeTime = 0

local function HCGodmode_Cleanup()
    if HCGodmode_Track then HCGodmode_Track:Stop() HCGodmode_Track:Destroy() HCGodmode_Track = nil end
    if HCGodmode_Heartbeat then HCGodmode_Heartbeat:Disconnect() HCGodmode_Heartbeat = nil end
    if HCGodmode_AnimConn then HCGodmode_AnimConn:Disconnect() HCGodmode_AnimConn = nil end
end

local function HCGodmode_GetHumanoid()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid")
end

local function HCGodmode_Animate()
    if not HCGodmode_Active then return end
    local hum = HCGodmode_GetHumanoid()
    if not hum then return end
    HCGodmode_Cleanup()
    local anim = Instance.new("Animation")
    anim.AnimationId = HCGodmode_EmoteID
    HCGodmode_Track = hum:LoadAnimation(anim)
    HCGodmode_Track:Play(0, 1, 1)
    HCGodmode_Heartbeat = RunService.Heartbeat:Connect(function()
        if HCGodmode_Track and HCGodmode_Active then
            HCGodmode_Track.TimePosition = HCGodmode_FreezeTime
            HCGodmode_Track:AdjustSpeed(0)
        end
    end)
    HCGodmode_AnimConn = hum.AnimationPlayed:Connect(function(newtrack)
        if HCGodmode_Active and HCGodmode_Track and newtrack ~= HCGodmode_Track then
            task.delay(0.02 + math.random() * 0.03, HCGodmode_Animate)
        end
    end)
end

local function HCGodmode_Stop()
    HCGodmode_Cleanup()
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.25)
    if HCGodmode_Active then HCGodmode_Animate() end
end)

local ColorPresets = {
    ["Cinnamoroll"] = {
        AccentColor = Color3.fromRGB(255, 170, 200),
        DimColor = Color3.fromRGB(190, 145, 165),
        HighlightColor = Color3.fromRGB(255, 220, 232),
        BgColor = Color3.fromRGB(0, 0, 0),
        SectionBg = Color3.fromRGB(12, 8, 10),
        TrayColor = Color3.fromRGB(255, 170, 200),
        TextColor = Color3.fromRGB(255, 210, 225),
        DimTextColor = Color3.fromRGB(145, 105, 120),
        BorderColor = Color3.fromRGB(70, 35, 48),
        DarkBg = Color3.fromRGB(0, 0, 0),
        HeaderBg = Color3.fromRGB(8, 5, 7)
    },
    ["Default"] = {
        AccentColor = Color3.fromRGB(230, 180, 255),
        DimColor = Color3.fromRGB(200, 200, 210),
        HighlightColor = Color3.fromRGB(255, 255, 255),
        BgColor = Color3.fromRGB(25, 22, 28),
        SectionBg = Color3.fromRGB(32, 28, 36),
        TrayColor = Color3.fromRGB(55, 50, 60),
        TextColor = Color3.fromRGB(229, 229, 229),
        DimTextColor = Color3.fromRGB(74, 74, 74),
        BorderColor = Color3.fromRGB(31, 31, 31),
        DarkBg = Color3.fromRGB(11, 11, 11),
        HeaderBg = Color3.fromRGB(19, 19, 19)
    },
    ["Rose Gold"] = {
        AccentColor = Color3.fromRGB(255, 179, 186),
        DimColor = Color3.fromRGB(200, 195, 195),
        HighlightColor = Color3.fromRGB(255, 240, 245),
        BgColor = Color3.fromRGB(30, 22, 24),
        SectionBg = Color3.fromRGB(38, 28, 30),
        TrayColor = Color3.fromRGB(60, 50, 52),
        TextColor = Color3.fromRGB(235, 225, 225),
        DimTextColor = Color3.fromRGB(85, 70, 75),
        BorderColor = Color3.fromRGB(50, 35, 40),
        DarkBg = Color3.fromRGB(18, 12, 14),
        HeaderBg = Color3.fromRGB(25, 18, 20)
    },
    ["Ocean Blue"] = {
        AccentColor = Color3.fromRGB(130, 200, 255),
        DimColor = Color3.fromRGB(180, 190, 200),
        HighlightColor = Color3.fromRGB(220, 240, 255),
        BgColor = Color3.fromRGB(18, 22, 28),
        SectionBg = Color3.fromRGB(24, 28, 36),
        TrayColor = Color3.fromRGB(45, 50, 60),
        TextColor = Color3.fromRGB(220, 230, 240),
        DimTextColor = Color3.fromRGB(65, 75, 85),
        BorderColor = Color3.fromRGB(30, 35, 45),
        DarkBg = Color3.fromRGB(10, 12, 18),
        HeaderBg = Color3.fromRGB(15, 18, 24)
    },
    ["Mint Green"] = {
        AccentColor = Color3.fromRGB(150, 255, 200),
        DimColor = Color3.fromRGB(180, 200, 190),
        HighlightColor = Color3.fromRGB(220, 255, 235),
        BgColor = Color3.fromRGB(20, 28, 24),
        SectionBg = Color3.fromRGB(26, 36, 30),
        TrayColor = Color3.fromRGB(48, 60, 52),
        TextColor = Color3.fromRGB(220, 235, 225),
        DimTextColor = Color3.fromRGB(65, 80, 70),
        BorderColor = Color3.fromRGB(30, 42, 36),
        DarkBg = Color3.fromRGB(10, 16, 14),
        HeaderBg = Color3.fromRGB(16, 22, 20)
    },
    ["Neon Pink"] = {
        AccentColor = Color3.fromRGB(255, 100, 180),
        DimColor = Color3.fromRGB(210, 180, 195),
        HighlightColor = Color3.fromRGB(255, 200, 230),
        BgColor = Color3.fromRGB(28, 18, 24),
        SectionBg = Color3.fromRGB(36, 24, 30),
        TrayColor = Color3.fromRGB(58, 45, 50),
        TextColor = Color3.fromRGB(240, 215, 225),
        DimTextColor = Color3.fromRGB(90, 65, 75),
        BorderColor = Color3.fromRGB(48, 30, 40),
        DarkBg = Color3.fromRGB(18, 10, 14),
        HeaderBg = Color3.fromRGB(24, 15, 20)
    },
    ["Sunset Orange"] = {
        AccentColor = Color3.fromRGB(255, 160, 100),
        DimColor = Color3.fromRGB(210, 190, 180),
        HighlightColor = Color3.fromRGB(255, 230, 210),
        BgColor = Color3.fromRGB(28, 22, 18),
        SectionBg = Color3.fromRGB(36, 28, 24),
        TrayColor = Color3.fromRGB(58, 50, 45),
        TextColor = Color3.fromRGB(235, 225, 215),
        DimTextColor = Color3.fromRGB(85, 70, 60),
        BorderColor = Color3.fromRGB(46, 36, 30),
        DarkBg = Color3.fromRGB(16, 12, 10),
        HeaderBg = Color3.fromRGB(24, 18, 15)
    },
    ["Amethyst"] = {
        AccentColor = Color3.fromRGB(200, 140, 255),
        DimColor = Color3.fromRGB(190, 180, 205),
        HighlightColor = Color3.fromRGB(235, 220, 255),
        BgColor = Color3.fromRGB(24, 20, 30),
        SectionBg = Color3.fromRGB(30, 26, 38),
        TrayColor = Color3.fromRGB(52, 48, 62),
        TextColor = Color3.fromRGB(225, 220, 235),
        DimTextColor = Color3.fromRGB(75, 70, 85),
        BorderColor = Color3.fromRGB(38, 34, 48),
        DarkBg = Color3.fromRGB(14, 12, 20),
        HeaderBg = Color3.fromRGB(20, 17, 26)
    },
    ["Blood Red"] = {
        AccentColor = Color3.fromRGB(255, 80, 80),
        DimColor = Color3.fromRGB(200, 170, 170),
        HighlightColor = Color3.fromRGB(255, 200, 200),
        BgColor = Color3.fromRGB(28, 18, 18),
        SectionBg = Color3.fromRGB(36, 22, 22),
        TrayColor = Color3.fromRGB(58, 40, 40),
        TextColor = Color3.fromRGB(235, 210, 210),
        DimTextColor = Color3.fromRGB(90, 60, 60),
        BorderColor = Color3.fromRGB(48, 28, 28),
        DarkBg = Color3.fromRGB(18, 10, 10),
        HeaderBg = Color3.fromRGB(24, 14, 14)
    },
    ["Cyber Yellow"] = {
        AccentColor = Color3.fromRGB(255, 230, 50),
        DimColor = Color3.fromRGB(200, 195, 150),
        HighlightColor = Color3.fromRGB(255, 250, 200),
        BgColor = Color3.fromRGB(25, 24, 15),
        SectionBg = Color3.fromRGB(32, 30, 20),
        TrayColor = Color3.fromRGB(55, 52, 38),
        TextColor = Color3.fromRGB(235, 230, 200),
        DimTextColor = Color3.fromRGB(80, 75, 50),
        BorderColor = Color3.fromRGB(42, 40, 26),
        DarkBg = Color3.fromRGB(15, 14, 8),
        HeaderBg = Color3.fromRGB(22, 20, 12)
    },
    ["Monochrome"] = {
        AccentColor = Color3.fromRGB(200, 200, 200),
        DimColor = Color3.fromRGB(150, 150, 155),
        HighlightColor = Color3.fromRGB(240, 240, 240),
        BgColor = Color3.fromRGB(20, 20, 22),
        SectionBg = Color3.fromRGB(28, 28, 30),
        TrayColor = Color3.fromRGB(50, 50, 52),
        TextColor = Color3.fromRGB(220, 220, 220),
        DimTextColor = Color3.fromRGB(70, 70, 72),
        BorderColor = Color3.fromRGB(36, 36, 38),
        DarkBg = Color3.fromRGB(10, 10, 12),
        HeaderBg = Color3.fromRGB(16, 16, 18)
    }
}

local BulletSpreadSettings = { Enabled = true }
local headlessActive = false
charKorbloxActive = false
charScaleValue = 1
charOriginalLegs = {}
charLoadedDescription = nil
charAvatarEnabled = false
charTargetUserId = nil
charUsernameInput = ""
local espObjects = {}
local aimPart = "Head"

local AllHitPartOptions = {
    "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
    "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg",
    "LeftFoot", "RightFoot", "LeftHand", "RightHand", "Closest Point"
}

local HCForceHitParts = {
    "Head", "UpperTorso", "LowerTorso",
    "LeftUpperArm", "LeftLowerArm", "LeftHand",
    "RightUpperArm", "RightLowerArm", "RightHand",
    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
    "RightUpperLeg", "RightLowerLeg", "RightFoot",
    "HumanoidRootPart"
}

local FogPresets = {
    ["Red"] = {Color = Color3.fromRGB(255, 60, 60), Density = 0.45},
    ["Light Red"] = {Color = Color3.fromRGB(255, 120, 120), Density = 0.44},
    ["Dark Red"] = {Color = Color3.fromRGB(180, 20, 20), Density = 0.48},
    ["Orange"] = {Color = Color3.fromRGB(255, 140, 0), Density = 0.43},
    ["Light Orange"] = {Color = Color3.fromRGB(255, 190, 80), Density = 0.42},
    ["Dark Orange"] = {Color = Color3.fromRGB(200, 90, 0), Density = 0.46},
    ["Yellow"] = {Color = Color3.fromRGB(255, 240, 60), Density = 0.41},
    ["Lime"] = {Color = Color3.fromRGB(140, 255, 60), Density = 0.45},
    ["Green"] = {Color = Color3.fromRGB(50, 255, 50), Density = 0.49},
    ["Cyan"] = {Color = Color3.fromRGB(60, 255, 220), Density = 0.47},
    ["Electric Blue"] = {Color = Color3.fromRGB(0, 255, 255), Density = 0.51},
    ["Blue"] = {Color = Color3.fromRGB(60, 140, 255), Density = 0.50},
    ["Purple"] = {Color = Color3.fromRGB(180, 60, 255), Density = 0.52},
    ["Violet"] = {Color = Color3.fromRGB(138, 43, 226), Density = 0.56},
    ["Pink"] = {Color = Color3.fromRGB(255, 100, 200), Density = 0.48},
    ["Hot Pink"] = {Color = Color3.fromRGB(255, 20, 147), Density = 0.49}
}

local OrigLighting = {
    FogStart = game:GetService("Lighting").FogStart,
    FogEnd = game:GetService("Lighting").FogEnd,
    FogColor = game:GetService("Lighting").FogColor
}

local boneConnections = {
    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"},
    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"},
    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}
}


-- ===== CHAR SYSTEM (from angelbounds) =====
local function applyCharHeadless(character)
    if not character then return end
    local head = character:FindFirstChild("Head")
    if not head then return end
    head.Transparency = headlessActive and 1 or 0
    local face = head:FindFirstChildWhichIsA("Decal")
    if face then face.Transparency = headlessActive and 1 or 0 end
end

local function captureCharLegs(character)
    if not character or next(charOriginalLegs) then return end
    for _, name in ipairs({"RightLowerLeg", "RightUpperLeg", "RightFoot"}) do
        local part = character:FindFirstChild(name)
        if part and part:IsA("MeshPart") then
            charOriginalLegs[name] = {
                MeshId = part.MeshId,
                TextureID = part.TextureID,
                Transparency = part.Transparency
            }
        end
    end
end

local function applyCharKorblox(character)
    if not character then return end
    captureCharLegs(character)
    local lower = character:FindFirstChild("RightLowerLeg")
    local upper = character:FindFirstChild("RightUpperLeg")
    local foot = character:FindFirstChild("RightFoot")
    if not (lower and upper and foot) then return end
    if charKorbloxActive then
        lower.MeshId = "rbxassetid://902942093"
        lower.Transparency = 1
        upper.MeshId = "rbxassetid://902942096"
        upper.TextureID = "rbxassetid://902843398"
        foot.MeshId = "rbxassetid://902942089"
        foot.Transparency = 1
    else
        for name, saved in pairs(charOriginalLegs) do
            local part = character:FindFirstChild(name)
            if part and part:IsA("MeshPart") then
                part.MeshId = saved.MeshId
                part.TextureID = saved.TextureID
                part.Transparency = saved.Transparency
            end
        end
    end
end

local function applyCharState(character)
    applyCharHeadless(character)
    applyCharKorblox(character)
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, name in ipairs({"BodyHeightScale", "BodyWidthScale", "BodyDepthScale", "HeadScale"}) do
            local value = humanoid:FindFirstChild(name)
            if value then value.Value = charScaleValue end
        end
    end
end

local function applyCharAnimations(character, dummyModel)
    local animate = character:FindFirstChild("Animate")
    local dummyAnimate = dummyModel:FindFirstChild("Animate")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not animate or not dummyAnimate or not humanoid then return end

    local animator = humanoid:FindFirstChildOfClass("Animator")
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            pcall(function() track:Stop(0) end)
        end
    end

    for _, dummyChild in ipairs(dummyAnimate:GetChildren()) do
        local targetChild = animate:FindFirstChild(dummyChild.Name)
        if targetChild then
            for _, animation in ipairs(dummyChild:GetChildren()) do
                if animation:IsA("Animation") then
                    local targetAnimation = targetChild:FindFirstChild(animation.Name)
                    if targetAnimation and targetAnimation:IsA("Animation") then
                        targetAnimation.AnimationId = animation.AnimationId
                    else
                        animation:Clone().Parent = targetChild
                    end
                end
            end
        end
    end

    animate.Disabled = true
    task.wait(0.05)
    animate.Disabled = false
end

local function applyCharFullOutfit(character)
    if not character or not charAvatarEnabled or not charTargetUserId then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 5)
    if not humanoid then return false end

    local success, dummyModel = pcall(function()
        return Players:CreateHumanoidModelFromUserId(charTargetUserId)
    end)
    if not success or not dummyModel then return false end

    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Accessory") or child:IsA("Shirt") or child:IsA("Pants")
            or child:IsA("ShirtGraphic") or child:IsA("BodyColors") or child:IsA("CharacterMesh") then
            child:Destroy()
        end
    end

    pcall(function()
        local dummyHumanoid = dummyModel:FindFirstChildOfClass("Humanoid")
        local description = dummyHumanoid and dummyHumanoid:GetAppliedDescription()
        if description then
            charLoadedDescription = description
            humanoid:ApplyDescription(description)
        end
    end)

    local targetColors = dummyModel:FindFirstChildOfClass("BodyColors")
    if targetColors then
        local oldColors = character:FindFirstChildOfClass("BodyColors")
        if oldColors then oldColors:Destroy() end
        targetColors:Clone().Parent = character
    end

    for _, item in ipairs(dummyModel:GetChildren()) do
        if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") or item:IsA("CharacterMesh") then
            item:Clone().Parent = character
        end
    end

    for _, dummyPart in ipairs(dummyModel:GetChildren()) do
        if dummyPart:IsA("MeshPart") and dummyPart.Name ~= "Head" then
            local targetPart = character:FindFirstChild(dummyPart.Name)
            if targetPart and targetPart:IsA("MeshPart") then
                pcall(function()
                    targetPart.MeshId = dummyPart.MeshId
                    targetPart.TextureID = dummyPart.TextureID
                    targetPart.Color = dummyPart.Color
                end)
            end
        end
    end

    local targetHead = dummyModel:FindFirstChild("Head")
    local head = character:FindFirstChild("Head")
    if targetHead and head then
        for _, child in ipairs(head:GetChildren()) do
            if child:IsA("SpecialMesh") or child:IsA("CharacterMesh") or child:IsA("Decal")
                or child:IsA("Texture") or child:IsA("SurfaceAppearance") or child:IsA("WrapTarget") then
                child:Destroy()
            end
        end
        pcall(function() head.Color = targetHead.Color end)

        local meshApplied = false
        if targetHead:IsA("MeshPart") and head:IsA("MeshPart") then
            meshApplied = pcall(function()
                head.MeshId = targetHead.MeshId
                head.TextureID = targetHead.TextureID
            end)
        end
        for _, child in ipairs(targetHead:GetChildren()) do
            if child:IsA("SpecialMesh") or child:IsA("Decal") or child:IsA("SurfaceAppearance") then
                child:Clone().Parent = head
            end
        end

        if targetHead:IsA("MeshPart") and not meshApplied then
            head.Transparency = 1
            local fakeHead = targetHead:Clone()
            fakeHead.Name = "FakeHead"
            fakeHead.CanCollide = false
            fakeHead.Massless = true
            fakeHead.CFrame = head.CFrame
            fakeHead.Parent = character
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = head
            weld.Part1 = fakeHead
            weld.Parent = fakeHead
        end
    end

    for _, item in ipairs(dummyModel:GetChildren()) do
        if item:IsA("Accessory") then
            local accessory = item:Clone()
            local handle = accessory:FindFirstChild("Handle")
            if handle then
                handle.CanCollide = false
                handle.Massless = true
                accessory.Parent = character
                local handleAttachment = handle:FindFirstChildOfClass("Attachment")
                local targetAttachment = handleAttachment and character:FindFirstChild(handleAttachment.Name, true)
                if targetAttachment and targetAttachment.Parent:IsA("BasePart") then
                    handle.CFrame = targetAttachment.Parent.CFrame
                        * targetAttachment.CFrame
                        * handleAttachment.CFrame:Inverse()
                    local weld = Instance.new("Weld")
                    weld.Name = "AccessoryWeld"
                    weld.Part0 = handle
                    weld.Part1 = targetAttachment.Parent
                    weld.C0 = handleAttachment.CFrame
                    weld.C1 = targetAttachment.CFrame
                    weld.Parent = handle
                else
                    local fallbackHead = character:FindFirstChild("Head")
                    if fallbackHead then
                        handle.CFrame = fallbackHead.CFrame
                        local weld = Instance.new("WeldConstraint")
                        weld.Part0 = handle
                        weld.Part1 = fallbackHead
                        weld.Parent = handle
                    end
                end
            else
                accessory:Destroy()
            end
        end
    end

    applyCharAnimations(character, dummyModel)
    dummyModel:Destroy()
    task.wait(0.1)
    applyCharState(character)
    return true
end

local function applyCharDescription(character)
    return applyCharFullOutfit(character)
end

local function loadCharUsername(username)
    username = tostring(username or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if username == "" then return false, "enter a username" end

    username = username:gsub("^@", "")
    local userSuccess, userId = pcall(function()
        local numericId = tonumber(username)
        return numericId or Players:GetUserIdFromNameAsync(username)
    end)
    if not userSuccess or not userId then return false, "user not found" end

    charTargetUserId = userId
    charAvatarEnabled = true
    local character = LocalPlayer.Character
    if not character then return false, "character unavailable" end
    local applied = applyCharFullOutfit(character)
    return applied, applied and ("applied " .. username) or "avatar could not be applied"
end


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MockupInterface"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local WindowOuterBorder = Instance.new("Frame")
WindowOuterBorder.Name = "WindowOuterBorder"
WindowOuterBorder.Size = UDim2.new(0, 680, 0, 420)
WindowOuterBorder.Position = UDim2.new(0.5, -340, 0.5, -210)
WindowOuterBorder.BackgroundColor3 = ColorPresets[_G.CurrentTheme].TrayColor
WindowOuterBorder.BorderSizePixel = 0
WindowOuterBorder.Active = true
WindowOuterBorder.ClipsDescendants = true
WindowOuterBorder.Parent = ScreenGui

local OuterCorner = Instance.new("UICorner")
OuterCorner.CornerRadius = UDim.new(0, 10)
OuterCorner.Parent = WindowOuterBorder

local InnerSpacer = Instance.new("Frame")
InnerSpacer.Name = "InnerSpacer"
InnerSpacer.Size = UDim2.new(1, -2, 1, -2)
InnerSpacer.Position = UDim2.new(0, 1, 0, 1)
InnerSpacer.BackgroundColor3 = ColorPresets[_G.CurrentTheme].DarkBg
InnerSpacer.BorderSizePixel = 0
InnerSpacer.ClipsDescendants = true
InnerSpacer.Parent = WindowOuterBorder

local InnerCorner = Instance.new("UICorner")
InnerCorner.CornerRadius = UDim.new(0, 9)
InnerCorner.Parent = InnerSpacer

local MainBody = Instance.new("Frame")
MainBody.Name = "MainBody"
MainBody.Size = UDim2.new(1, -2, 1, -2)
MainBody.Position = UDim2.new(0, 1, 0, 1)
MainBody.BackgroundColor3 = ColorPresets[_G.CurrentTheme].BgColor
MainBody.BorderColor3 = ColorPresets[_G.CurrentTheme].BorderColor
MainBody.BorderSizePixel = 1
MainBody.ClipsDescendants = true
MainBody.Parent = InnerSpacer

local BodyCorner = Instance.new("UICorner")
BodyCorner.CornerRadius = UDim.new(0, 8)
BodyCorner.Parent = MainBody

local HeaderBar = Instance.new("Frame")
HeaderBar.Name = "HeaderBar"
HeaderBar.Size = UDim2.new(1, 0, 0, 30)
HeaderBar.Position = UDim2.new(0, 0, 1, -30)
HeaderBar.BackgroundColor3 = ColorPresets[_G.CurrentTheme].HeaderBg
HeaderBar.BorderSizePixel = 0
HeaderBar.ZIndex = 5
HeaderBar.Parent = MainBody

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = HeaderBar

-- HELLO KITTY (asset id from Studio Texture property)
local HELLO_KITTY_ICON_ID = "113683233306221" -- top header icon
local HELLO_KITTY_CHAR_ID = "95038566379290" -- bottom corner
local function applyHelloKittyImage(img, assetId)
    if not img then return end
    assetId = tostring(assetId or HELLO_KITTY_ICON_ID)
    img.BackgroundTransparency = 1
    img.ImageTransparency = 0
    img.Visible = true
    img.ScaleType = Enum.ScaleType.Fit
    local formats = {
        "rbxthumb://type=Asset&id=" .. assetId .. "&w=420&h=420",
        "rbxassetid://" .. assetId,
        "http://www.roblox.com/asset/?id=" .. assetId,
        "https://www.roblox.com/asset/?id=" .. assetId,
    }
    img.Image = formats[1]
    task.spawn(function()
        pcall(function()
            game:GetService("ContentProvider"):PreloadAsync({img})
        end)
        for i = 2, #formats do
            task.wait(0.35)
            local loaded = false
            pcall(function() loaded = img.IsLoaded end)
            if loaded then break end
            img.Image = formats[i]
            pcall(function()
                game:GetService("ContentProvider"):PreloadAsync({img})
            end)
        end
    end)
end

local CinnamorollIcon = Instance.new("ImageLabel")
CinnamorollIcon.Name = "HelloKittyIcon"
CinnamorollIcon.Size = UDim2.new(0, 30, 0, 30)
CinnamorollIcon.Position = UDim2.new(0, 8, 0.5, -15)
CinnamorollIcon.BackgroundTransparency = 1
CinnamorollIcon.BorderSizePixel = 0
CinnamorollIcon.ZIndex = 15
CinnamorollIcon.Parent = HeaderBar
applyHelloKittyImage(CinnamorollIcon, HELLO_KITTY_ICON_ID)

local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(0.5, 0, 1, 0)
TitleText.Position = UDim2.new(0, 44, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Adis.UI"
TitleText.TextColor3 = ColorPresets[_G.CurrentTheme].TextColor
TitleText.TextSize = 17
TitleText.Font = Enum.Font.IndieFlower
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.ZIndex = 6
TitleText.Parent = HeaderBar

local DateText = Instance.new("TextLabel")
DateText.Name = "DateText"
DateText.Size = UDim2.new(0.5, 0, 1, 0)
DateText.Position = UDim2.new(1, -120, 0, 0)
DateText.BackgroundTransparency = 1
DateText.Text = ""
DateText.TextColor3 = Color3.fromRGB(200, 160, 200)
DateText.TextSize = 15
DateText.Font = Enum.Font.IndieFlower
DateText.TextXAlignment = Enum.TextXAlignment.Right
DateText.ZIndex = 6
DateText.Parent = HeaderBar

local PinkLineAccent = Instance.new("Frame")
PinkLineAccent.Name = "PinkLineAccent"
PinkLineAccent.Size = UDim2.new(1, 0, 0, 2)
PinkLineAccent.Position = UDim2.new(0, 0, 1, 0)
PinkLineAccent.BackgroundColor3 = ColorPresets[_G.CurrentTheme].AccentColor
PinkLineAccent.BorderSizePixel = 0
PinkLineAccent.ZIndex = 10
PinkLineAccent.Parent = HeaderBar

local PinkHeaderGlow = Instance.new("Frame")
PinkHeaderGlow.Name = "PinkHeaderGlow"
PinkHeaderGlow.Size = UDim2.new(1, 0, 0, 25)
PinkHeaderGlow.Position = UDim2.new(0, 0, 1, 2)
PinkHeaderGlow.BackgroundColor3 = ColorPresets[_G.CurrentTheme].AccentColor
PinkHeaderGlow.BorderSizePixel = 0
PinkHeaderGlow.ZIndex = 4
PinkHeaderGlow.Parent = HeaderBar

local GlowGradient = Instance.new("UIGradient")
GlowGradient.Rotation = 90
GlowGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.60),
    NumberSequenceKeypoint.new(0.5, 0.85),
    NumberSequenceKeypoint.new(1, 1)
})
GlowGradient.Parent = PinkHeaderGlow

local CinnamorollChar = Instance.new("ImageLabel")
CinnamorollChar.Name = "HelloKittyChar"
CinnamorollChar.Size = UDim2.new(0, 80, 0, 80)
CinnamorollChar.Position = UDim2.new(1, -65, 0, -25)
CinnamorollChar.BackgroundTransparency = 1
CinnamorollChar.BorderSizePixel = 0
CinnamorollChar.ZIndex = 90
CinnamorollChar.Parent = MainBody
applyHelloKittyImage(CinnamorollChar, HELLO_KITTY_CHAR_ID)

local function updateClock()
    DateText.Text = os.date("%A, %d %B, %y")
end
updateClock()
task.spawn(function()
    while task.wait(60) do updateClock() end
end)

local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    WindowOuterBorder.Position = UDim2.new(startPos.Width.Scale, startPos.Width.Offset + delta.X, startPos.Height.Scale, startPos.Height.Offset + delta.Y)
end

HeaderBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = WindowOuterBorder.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
HeaderBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

local LayoutContent = Instance.new("Frame")
LayoutContent.Name = "LayoutContent"
LayoutContent.Size = UDim2.new(1, 0, 1, -30)
LayoutContent.Position = UDim2.new(0, 0, 0, 0)
LayoutContent.BackgroundTransparency = 1
LayoutContent.ClipsDescendants = true
LayoutContent.ZIndex = 2
LayoutContent.Parent = MainBody

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 118, 1, 0)
Sidebar.Position = UDim2.new(1, -118, 0, 0)
Sidebar.BackgroundColor3 = ColorPresets[_G.CurrentTheme].BgColor
Sidebar.BorderColor3 = ColorPresets[_G.CurrentTheme].BorderColor
Sidebar.BorderSizePixel = 1
Sidebar.ZIndex = 3
Sidebar.Parent = LayoutContent

local WorkspaceFrame = Instance.new("Frame")
WorkspaceFrame.Name = "WorkspaceFrame"
WorkspaceFrame.Size = UDim2.new(1, -118, 1, 0)
WorkspaceFrame.Position = UDim2.new(0, 0, 0, 0)
WorkspaceFrame.BackgroundTransparency = 1
WorkspaceFrame.ZIndex = 3
WorkspaceFrame.Parent = LayoutContent

local SubTabsHeader = Instance.new("Frame")
SubTabsHeader.Name = "SubTabsHeader"
SubTabsHeader.Size = UDim2.new(1, 0, 0, 30)
SubTabsHeader.BackgroundColor3 = ColorPresets[_G.CurrentTheme].SectionBg
SubTabsHeader.BorderColor3 = ColorPresets[_G.CurrentTheme].BorderColor
SubTabsHeader.BorderSizePixel = 1
SubTabsHeader.ZIndex = 4
SubTabsHeader.Parent = WorkspaceFrame

local SubTabsDivider = Instance.new("Frame")
SubTabsDivider.Size = UDim2.new(1, -24, 0, 1)
SubTabsDivider.Position = UDim2.new(0, 12, 1, -1)
SubTabsDivider.BackgroundColor3 = Color3.fromRGB(210, 230, 240)
SubTabsDivider.BorderSizePixel = 0
SubTabsDivider.Parent = SubTabsHeader

local PanelingSection = Instance.new("Frame")
PanelingSection.Name = "PanelingSection"
PanelingSection.Size = UDim2.new(1, 0, 1, -32)
PanelingSection.Position = UDim2.new(0, 0, 0, 32)
PanelingSection.BackgroundTransparency = 1
PanelingSection.ZIndex = 3
PanelingSection.Parent = WorkspaceFrame

local function ApplyTheme(themeName)
    local theme = ColorPresets[themeName]
    if not theme then return end

    if WindowOuterBorder then WindowOuterBorder.BackgroundColor3 = theme.TrayColor end
    if InnerSpacer then InnerSpacer.BackgroundColor3 = theme.DarkBg end
    if MainBody then
        MainBody.BackgroundColor3 = theme.BgColor
        MainBody.BorderColor3 = theme.BorderColor
    end
    if HeaderBar then HeaderBar.BackgroundColor3 = theme.HeaderBg end
    if TitleText then TitleText.TextColor3 = theme.TextColor end
    if PinkLineAccent then PinkLineAccent.BackgroundColor3 = theme.AccentColor end
    if PinkHeaderGlow then PinkHeaderGlow.BackgroundColor3 = theme.AccentColor end
    if Sidebar then
        Sidebar.BackgroundColor3 = theme.BgColor
        Sidebar.BorderColor3 = theme.BorderColor
    end

    if SubTabsHeader then
        for _, child in ipairs(SubTabsHeader:GetChildren()) do
            if child and child:IsA("TextButton") then
                if child.TextColor3 == Color3.fromRGB(160, 160, 160) then
                    child.TextColor3 = theme.TextColor
                elseif child.TextColor3 == Color3.fromRGB(65, 65, 65) then
                    child.TextColor3 = theme.DimTextColor
                end
            end
        end
    end

    if SubTabsDivider then
        SubTabsDivider.BackgroundColor3 = theme.BorderColor
    end

    if Sidebar then
        for _, child in ipairs(Sidebar:GetChildren()) do
            if child and child:IsA("TextButton") then
                if child.TextColor3 == Color3.fromRGB(229, 229, 229) then
                    child.TextColor3 = theme.TextColor
                elseif child.TextColor3 == Color3.fromRGB(74, 74, 74) then
                    child.TextColor3 = theme.DimTextColor
                end
            end
        end
    end

    if fovCircle then fovCircle.Color = theme.AccentColor end
    if hcFovCircle then hcFovCircle.Color = theme.AccentColor end
    if oldAimFovCircle then oldAimFovCircle.Color = theme.AccentColor end

    if espObjects then
        for plr, objs in pairs(espObjects) do
            if objs and objs.Box then objs.Box.Color = theme.AccentColor end
            if objs and objs.Name then objs.Name.Color = theme.AccentColor end
            if objs and objs.DisplayName then objs.DisplayName.Color = theme.AccentColor end
            if objs and objs.Tracer then objs.Tracer.Color = theme.AccentColor end
            if objs and objs.Skeleton then
                for _, line in pairs(objs.Skeleton) do
                    if line then line.Color = theme.AccentColor end
                end
            end
        end
    end
end

local function CreateColorWheel(parent)
    local WheelFrame = Instance.new("Frame", parent)
    WheelFrame.Size = UDim2.new(1, 0, 0, 80)
    WheelFrame.BackgroundTransparency = 1
    local ColorGrid = Instance.new("UIGridLayout", WheelFrame)
    ColorGrid.CellSize = UDim2.new(0, 30, 0, 30)
    ColorGrid.CellPadding = UDim2.new(0, 4, 0, 4)
    local colors = {
        Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 130, 30), 
        Color3.fromRGB(255, 215, 0), Color3.fromRGB(50, 220, 50),
        Color3.fromRGB(50, 150, 255), Color3.fromRGB(30, 30, 150),
        Color3.fromRGB(160, 50, 215), Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(255, 153, 170), Color3.fromRGB(0, 255, 255),
        Color3.fromRGB(255, 0, 255), Color3.fromRGB(255, 100, 0),
        Color3.fromRGB(100, 255, 0), Color3.fromRGB(0, 100, 255)
    }
    for _, c in ipairs(colors) do
        local btn = Instance.new("TextButton", WheelFrame)
        btn.Size = UDim2.new(0, 26, 0, 26)
        btn.BackgroundColor3 = c
        btn.BorderColor3 = c == _G.ESP_Color and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(20, 20, 20)
        btn.BorderSizePixel = c == _G.ESP_Color and 2 or 1
        btn.Text = ""
        btn.MouseButton1Click:Connect(function()
            _G.ESP_Color = c
            for _, child in ipairs(WheelFrame:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BorderColor3 = child.BackgroundColor3 == c and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(20, 20, 20)
                    child.BorderSizePixel = child.BackgroundColor3 == c and 2 or 1
                end
            end
        end)
    end
end

local function ClearPanel(panel)
    for _, child in ipairs(panel:GetChildren()) do
        child:Destroy()
    end
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 3
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.Parent = panel
    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, 15)
    Padding.PaddingLeft = UDim.new(0, 12)
    Padding.PaddingRight = UDim.new(0, 12)
    Padding.Parent = ScrollFrame
    local List = Instance.new("UIListLayout")
    List.SortOrder = Enum.SortOrder.LayoutOrder
    List.Padding = UDim.new(0, 10)
    List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 20)
    end)
    List.Parent = ScrollFrame
    return ScrollFrame
end

local function CreateToggle(parent, text, state, callback)
    local theme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, 0, 0, 14)
    Row.BackgroundTransparency = 1
    local Box = Instance.new("TextButton", Row)
    Box.Size = UDim2.new(0, 10, 0, 10)
    Box.Position = UDim2.new(0, 4, 0.5, -5)
    Box.BackgroundColor3 = state and theme.AccentColor or Color3.fromRGB(230, 240, 248)
    Box.BorderColor3 = state and theme.AccentColor or theme.BorderColor
    Box.BorderSizePixel = 1
    Box.Text = ""
    local Lbl = Instance.new("TextLabel", Row)
    Lbl.Size = UDim2.new(1, -20, 1, 0)
    Lbl.Position = UDim2.new(0, 20, 0, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text
    Lbl.TextColor3 = state and theme.DimColor or theme.DimTextColor
    Lbl.TextSize = 15
    Lbl.Font = Enum.Font.IndieFlower
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Box.MouseButton1Click:Connect(function()
        local newState = callback()
        local currentTheme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
        Box.BackgroundColor3 = newState and currentTheme.AccentColor or Color3.fromRGB(230, 240, 248)
        Box.BorderColor3 = newState and currentTheme.AccentColor or currentTheme.BorderColor
        Lbl.TextColor3 = newState and currentTheme.DimColor or currentTheme.DimTextColor
    end)
end

local function CreateSlider(parent, text, min, max, default, callback, isFloat)
    local theme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, 0, 0, 24)
    Row.BackgroundTransparency = 1
    local Lbl = Instance.new("TextLabel", Row)
    Lbl.Size = UDim2.new(1, -50, 0, 12)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text .. ": " .. (isFloat and string.format("%.3f", default) or tostring(default))
    Lbl.TextColor3 = theme.DimColor
    Lbl.TextSize = 15
    Lbl.Font = Enum.Font.IndieFlower
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local InputBox = Instance.new("TextBox", Row)
    InputBox.Size = UDim2.new(0, 45, 0, 12)
    InputBox.Position = UDim2.new(1, -45, 0, 0)
    InputBox.BackgroundColor3 = Color3.fromRGB(40, 32, 50)
    InputBox.BorderColor3 = theme.BorderColor
    InputBox.Text = isFloat and string.format("%.3f", default) or tostring(default)
    InputBox.TextColor3 = theme.TextColor
    InputBox.Font = Enum.Font.IndieFlower
    InputBox.TextSize = 14
    InputBox.TextXAlignment = Enum.TextXAlignment.Center
    local Track = Instance.new("Frame", Row)
    Track.Size = UDim2.new(1, 0, 0, 4)
    Track.Position = UDim2.new(0, 0, 0, 16)
    Track.BackgroundColor3 = Color3.fromRGB(235, 242, 248)
    Track.BorderColor3 = theme.BorderColor
    local Fill = Instance.new("Frame", Track)
    local startPct = math.clamp((default - min) / (max - min), 0, 1)
    Fill.Size = UDim2.new(startPct, 0, 1, 0)
    Fill.BackgroundColor3 = theme.AccentColor
    Fill.BorderSizePixel = 0
    local DragBtn = Instance.new("TextButton", Track)
    DragBtn.Size = UDim2.new(0, 6, 0, 10)
    DragBtn.Position = UDim2.new(startPct, -3, 0.5, -5)
    DragBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragBtn.BorderColor3 = theme.AccentColor
    DragBtn.Text = ""
    local function setValue(val)
        val = math.clamp(val, min, max)
        if isFloat then val = tonumber(string.format("%.3f", val)) else val = math.floor(val) end
        local pct = (val - min) / (max - min)
        Fill.Size = UDim2.new(pct, 0, 1, 0)
        DragBtn.Position = UDim2.new(pct, -3, 0.5, -5)
        Lbl.Text = text .. ": " .. (isFloat and string.format("%.3f", val) or tostring(val))
        InputBox.Text = isFloat and string.format("%.3f", val) or tostring(val)
        callback(val)
    end
    local draggingSlider = false
    local function updateSlider(input)
        local pct = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
        local val = min + (max - min) * pct
        setValue(val)
    end
    DragBtn.MouseButton1Down:Connect(function() draggingSlider = true end)
    UIS.InputEnded:Connect(function(ip) if ip.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = false end end)
    UIS.InputChanged:Connect(function(ip) if draggingSlider and ip.UserInputType == Enum.UserInputType.MouseMovement then updateSlider(ip) end end)
    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSlider = true
            updateSlider(input)
        end
    end)
    InputBox.FocusLost:Connect(function()
        local val = tonumber(InputBox.Text)
        if val then setValue(val) else setValue(default) end
    end)
    InputBox.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Return then
            local val = tonumber(InputBox.Text)
            if val then setValue(val) else setValue(default) end
        end
    end)
end

local function CreateButton(parent, text, callback)
    local theme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, 0, 0, 20)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 32, 50)
    Btn.BorderColor3 = theme.BorderColor
    Btn.Text = text
    Btn.TextColor3 = theme.DimColor
    Btn.Font = Enum.Font.IndieFlower
    Btn.TextSize = 15
    Btn.MouseButton1Click:Connect(callback)
end

local keybindListeners = {}
local function CreateKeybind(parent, text, currentKey, callback)
    local theme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, 0, 0, 20)
    Row.BackgroundTransparency = 1
    local Lbl = Instance.new("TextLabel", Row)
    Lbl.Size = UDim2.new(0.6, 0, 1, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text
    Lbl.TextColor3 = theme.DimTextColor
    Lbl.Font = Enum.Font.IndieFlower
    Lbl.TextSize = 15
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local BBtn = Instance.new("TextButton", Row)
    BBtn.Size = UDim2.new(0.4, 0, 1, 0)
    BBtn.Position = UDim2.new(0.6, 0, 0, 0)
    BBtn.BackgroundColor3 = Color3.fromRGB(40, 32, 50)
    BBtn.BorderColor3 = theme.BorderColor
    BBtn.Text = "[" .. currentKey.Name .. "]"
    BBtn.TextColor3 = theme.DimColor
    BBtn.Font = Enum.Font.IndieFlower
    BBtn.TextSize = 15
    local listenerState = { listening = false, button = BBtn, callback = callback }
    BBtn.MouseButton1Click:Connect(function()
        for _, state in ipairs(keybindListeners) do state.listening = false end
        listenerState.listening = true
        BBtn.Text = "..."
    end)
    table.insert(keybindListeners, listenerState)
    if #keybindListeners == 1 then
        UIS.InputBegan:Connect(function(io)
            if io.UserInputType ~= Enum.UserInputType.Keyboard then return end
            for _, state in ipairs(keybindListeners) do
                if state.listening then
                    state.listening = false
                    state.button.Text = "[" .. io.KeyCode.Name .. "]"
                    state.callback(io.KeyCode)
                    break
                end
            end
        end)
    end
end

local function CreateDropdown(parent, text, options, currentVal, callback)
    local theme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, 0, 0, 22)
    Row.BackgroundTransparency = 1
    local Lbl = Instance.new("TextLabel", Row)
    Lbl.Size = UDim2.new(0.5, 0, 1, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text
    Lbl.TextColor3 = theme.DimTextColor
    Lbl.Font = Enum.Font.IndieFlower
    Lbl.TextSize = 15
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local MainBtn = Instance.new("TextButton", Row)
    MainBtn.Size = UDim2.new(0.45, 0, 1, 0)
    MainBtn.Position = UDim2.new(0.55, 0, 0, 0)
    MainBtn.BackgroundColor3 = Color3.fromRGB(40, 32, 50)
    MainBtn.BorderColor3 = theme.BorderColor
    MainBtn.Text = tostring(currentVal)
    MainBtn.TextColor3 = theme.DimColor
    MainBtn.Font = Enum.Font.IndieFlower
    MainBtn.TextSize = 15
    local Container = Instance.new("Frame", parent)
    Container.Size = UDim2.new(0.45, 0, 0, #options * 18)
    Container.Position = UDim2.new(0.55, 0, 0, 22)
    Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Container.BorderColor3 = theme.BorderColor
    Container.Visible = false
    Container.ZIndex = 20
    local List = Instance.new("UIListLayout", Container)
    List.SortOrder = Enum.SortOrder.LayoutOrder
    MainBtn.MouseButton1Click:Connect(function() Container.Visible = not Container.Visible end)
    for _, opt in ipairs(options) do
        local OBtn = Instance.new("TextButton", Container)
        OBtn.Size = UDim2.new(1, 0, 0, 18)
        OBtn.BackgroundColor3 = Color3.fromRGB(248, 251, 254)
        OBtn.BorderSizePixel = 0
        OBtn.Text = tostring(opt)
        OBtn.TextColor3 = theme.TextColor
        OBtn.Font = Enum.Font.IndieFlower
        OBtn.TextSize = 15
        OBtn.ZIndex = 21
        OBtn.MouseButton1Click:Connect(function()
            MainBtn.Text = tostring(opt)
            Container.Visible = false
            callback(opt)
        end)
    end
end

local function CreateTextBox(parent, placeholder, defaultText, callback)
    local theme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, 0, 0, 22)
    Row.BackgroundTransparency = 1
    local Lbl = Instance.new("TextLabel", Row)
    Lbl.Size = UDim2.new(0, 80, 0, 20)
    Lbl.Position = UDim2.new(0, 0, 0, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = placeholder
    Lbl.TextColor3 = theme.DimTextColor
    Lbl.Font = Enum.Font.IndieFlower
    Lbl.TextSize = 15
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local TxtBox = Instance.new("TextBox", Row)
    TxtBox.Size = UDim2.new(1, -85, 0, 20)
    TxtBox.Position = UDim2.new(0, 85, 0, 0)
    TxtBox.BackgroundColor3 = Color3.fromRGB(40, 32, 50)
    TxtBox.BorderColor3 = theme.BorderColor
    TxtBox.Text = defaultText or ""
    TxtBox.PlaceholderText = "..."
    TxtBox.TextColor3 = theme.DimColor
    TxtBox.PlaceholderColor3 = theme.DimTextColor
    TxtBox.Font = Enum.Font.IndieFlower
    TxtBox.TextSize = 15
    TxtBox.ClearTextOnFocus = false
    TxtBox.TextXAlignment = Enum.TextXAlignment.Left
    TxtBox.FocusLost:Connect(function(enterPressed)
        callback(TxtBox.Text)
    end)
    return TxtBox
end

local fovCircle, hcFovCircle

local function IsKnocked(character)
    if not character then return false end
    local bodyEffects = character:FindFirstChild('BodyEffects')
    if bodyEffects then
        local ko = bodyEffects:FindFirstChild('K.O')
        return ko and ko.Value == true
    end
    return false
end

local function isKnocked(character)
    local bodyEffects = character:FindFirstChild("BodyEffects")
    if bodyEffects and bodyEffects:FindFirstChild("K.O") then return bodyEffects["K.O"].Value end
    return false
end

local function IsGrabbed(player)
    return player and player.Character and player.Character:FindFirstChild('GRABBING_CONSTRAINT') ~= nil
end

local function getClosestPartToMouse(char)
    local m = UIS:GetMouseLocation()
    local nearestPart, nearestDist = nil, math.huge
    local parts = {
        "Head", "UpperTorso", "LowerTorso",
        "LeftUpperArm", "LeftLowerArm", "LeftHand",
        "RightUpperArm", "RightLowerArm", "RightHand",
        "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
        "RightUpperLeg", "RightLowerLeg", "RightFoot",
        "HumanoidRootPart"
    }
    for _, name in ipairs(parts) do
        local part = char:FindFirstChild(name)
        if part then
            local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(m.X, m.Y)).Magnitude
                if dist < nearestDist then nearestDist = dist nearestPart = part end
            end
        end
    end
    return nearestPart
end

local function getTargetPosition(player, character)
    if not character then return nil end
    if _G.KnockCheck and isKnocked(character) then return nil end
    if aimPart == "Closest Point" then
        local part = getClosestPartToMouse(character)
        if part then return part.Position end
    else
        local part = character:FindFirstChild(aimPart) or character:FindFirstChild("HumanoidRootPart")
        if part then return part.Position end
    end
    return nil
end

local function setupKnockTracking(player)
    local function onKnockChanged()
        local character = player.Character
        if not character then return end
        local bodyEffects = character:FindFirstChild("BodyEffects")
        if not bodyEffects then return end
        local KO = bodyEffects:FindFirstChild("K.O")
        if not KO then return end
        if KO.Value then
            local part = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
            if part then _G.DeathPositions[player] = part.Position end
        else
            _G.DeathPositions[player] = nil
        end
    end
    player.CharacterAdded:Connect(function(char)
        local bodyEffects = char:WaitForChild("BodyEffects", 5)
        if bodyEffects then
            local KO = bodyEffects:WaitForChild("K.O", 5)
            if KO then
                KO:GetPropertyChangedSignal("Value"):Connect(onKnockChanged)
                if KO.Value then
                    local part = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
                    if part then _G.DeathPositions[player] = part.Position end
                end
            end
        end
    end)
end

for _, plr in pairs(Players:GetPlayers()) do if plr ~= LocalPlayer then setupKnockTracking(plr) end end
Players.PlayerAdded:Connect(function(plr) if plr ~= LocalPlayer then setupKnockTracking(plr) end end)
Players.PlayerRemoving:Connect(function(plr) _G.DeathPositions[plr] = nil end)

local function getClosest()
    if not _G.SilentAim_Enabled then return nil end
    local mousePos = Vector2.new(mouse.X, mouse.Y)
    local best, bestDist = nil, _G.FOV_RADIUS
    for _, v in pairs(Players:GetPlayers()) do
        if v == LocalPlayer or (_G.Whitelist and _G.Whitelist[v.UserId]) then continue end
        local char = v.Character; if not char then continue end
        local targetPos = getTargetPosition(v, char); if not targetPos then continue end
        local screenPos, onScreen = cam:WorldToScreenPoint(targetPos)
        if onScreen then
            local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
            if dist < bestDist then
                if _G.WallCheck then
                    local ray = Ray.new(cam.CFrame.Position, (targetPos - cam.CFrame.Position).Unit * 500)
                    local hit, _ = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, cam})
                    if hit and hit:IsDescendantOf(char) then bestDist = dist; best = targetPos end
                else
                    bestDist = dist; best = targetPos
                end
            end
        end
    end
    return best
end
local handler, oldFunc = nil, nil
pcall(function()
    local modules = ReplicatedStorage:FindFirstChild("Modules")
    if modules then
        local gunHandler = modules:FindFirstChild("GunHandler")
        if gunHandler then
            handler = require(gunHandler)
            if handler and handler.getAim then oldFunc = handler.getAim end
        end
    end
end)

if handler and oldFunc then
    handler.getAim = function(origin, maxDist)
        if not _G.SilentAim_Enabled then return oldFunc(origin, maxDist) end
        if _G.RevolverBypass then
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool and (tool.Name == "[Revolver]" or tool.Name == "Revolver") then return oldFunc(origin, maxDist) end
        end
        local targetPos = getClosest()
        if targetPos then return (targetPos - origin).Unit, math.min((targetPos - origin).Magnitude, maxDist or 200) end
        return oldFunc(origin, maxDist)
    end
end

local function getKeyCode(keyName)
    local keyMap = {
        A = Enum.KeyCode.A, B = Enum.KeyCode.B, C = Enum.KeyCode.C,
        D = Enum.KeyCode.D, E = Enum.KeyCode.E, F = Enum.KeyCode.F,
        G = Enum.KeyCode.G, H = Enum.KeyCode.H, I = Enum.KeyCode.I,
        J = Enum.KeyCode.J, K = Enum.KeyCode.K, L = Enum.KeyCode.L,
        M = Enum.KeyCode.M, N = Enum.KeyCode.N, O = Enum.KeyCode.O,
        P = Enum.KeyCode.P, Q = Enum.KeyCode.Q, R = Enum.KeyCode.R,
        S = Enum.KeyCode.S, T = Enum.KeyCode.T, U = Enum.KeyCode.U,
        V = Enum.KeyCode.V, W = Enum.KeyCode.W, X = Enum.KeyCode.X,
        Y = Enum.KeyCode.Y, Z = Enum.KeyCode.Z,
    }
    return keyMap[keyName] or Enum.KeyCode[keyName] or Enum.KeyCode.V
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
raycastParams.IgnoreWater = true

local function isPartVisible(origin, targetPart, ignoreList)
    if not origin or not targetPart then return false end
    local direction = (targetPart.Position - origin).Unit
    local distance = (targetPart.Position - origin).Magnitude
    local filter = {LocalPlayer.Character}
    if ignoreList then for _, v in ipairs(ignoreList) do table.insert(filter, v) end end
    raycastParams.FilterDescendantsInstances = filter
    local result = workspace:Raycast(origin, direction * distance, raycastParams)
    if not result then return true end
    return result.Instance == targetPart or result.Instance:IsDescendantOf(targetPart.Parent)
end

local function GetClosestPointOnPart(Part, Scale)
    local PartCFrame = Part.CFrame
    local PartSize = Part.Size
    local PartSizeTransformed = PartSize * (Scale / 2)
    local MousePosition = UIS:GetMouseLocation()
    local CurrentCamera = Workspace.CurrentCamera
    local MouseRay = CurrentCamera:ViewportPointToRay(MousePosition.X, MousePosition.Y)
    local Transformed = PartCFrame:PointToObjectSpace(MouseRay.Origin + (MouseRay.Direction * MouseRay.Direction:Dot(PartCFrame.Position - MouseRay.Origin)))
    if mouse.Target == Part then return Vector3.new(mouse.Hit.X, mouse.Hit.Y, mouse.Hit.Z) end
    return PartCFrame * Vector3.new(
        math.clamp(Transformed.X, -PartSizeTransformed.X, PartSizeTransformed.X),
        math.clamp(Transformed.Y, -PartSizeTransformed.Y, PartSizeTransformed.Y),
        math.clamp(Transformed.Z, -PartSizeTransformed.Z, PartSizeTransformed.Z)
    )
end

local function GetClosestPointOnPartBasic(Part)
    if Part then
        local MouseRay = mouse.UnitRay
        MouseRay = MouseRay.Origin + (MouseRay.Direction * (Part.Position - MouseRay.Origin).Magnitude)
        local Point = (MouseRay.Y >= (Part.Position - Part.Size / 2).Y and MouseRay.Y <= (Part.Position + Part.Size / 2).Y) and (Part.Position + Vector3.new(0, -Part.Position.Y + MouseRay.Y, 0)) or Part.Position
        local Check = RaycastParams.new()
        Check.FilterType = Enum.RaycastFilterType.Whitelist
        Check.FilterDescendantsInstances = {Part}
        local Ray = Workspace:Raycast(MouseRay, (Point - MouseRay), Check)
        if mouse.Target == Part then return mouse.Hit.Position end
        if Ray then return Ray.Position else return mouse.Hit.Position end
    end
end

local function GetCamlockHitPosition(Target)
    if not Target or not Target.Character then return nil end
    local Character = Target.Character
    local Humanoid = Character:FindFirstChild("Humanoid")
    if not Humanoid then return nil end
    local NearestPart = getClosestPartToMouse(Character)
    if not NearestPart then return nil end
    local HitPosition
    if _G.CamlockHitPart == "Closest Point" then
        if _G.CamlockClosestPointMode == "Default" then
            HitPosition = GetClosestPointOnPart(NearestPart, _G.CamlockClosestPointScale)
        else
            HitPosition = GetClosestPointOnPartBasic(NearestPart)
        end
    elseif _G.CamlockHitPart == "Closest Part" then
        HitPosition = NearestPart.Position
    else
        local part = Character:FindFirstChild(_G.CamlockHitPart)
        HitPosition = part and part.Position
    end
    if not HitPosition then return nil end
    if _G.CamlockPredictionEnabled then
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        if RootPart then
            local Velocity = RootPart.Velocity
            local PredictionVector = Vector3.new(_G.CamlockPredictionX, _G.CamlockPredictionY, _G.CamlockPredictionZ)
            HitPosition = HitPosition + Velocity * PredictionVector
        end
    end
    return HitPosition
end

local function GetBestCamlockTarget()
    if not _G.CamlockEnabled then return nil end
    local Closest = nil
    local Distance = _G.CamlockFOVRadius > 0 and _G.CamlockFOVRadius or math.huge
    local MousePosition = UIS:GetMouseLocation()
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player == LocalPlayer then continue end
        if not Player.Character then continue end
        local Character = Player.Character
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then continue end
        local Position, OnScreen = cam:WorldToViewportPoint(HumanoidRootPart.Position)
        if not OnScreen then continue end
        if _G.CamlockConditionsForceField and Character:FindFirstChild("Forcefield") then continue end
        if _G.CamlockConditionsVisible then
            local localHead = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
            if localHead and not isPartVisible(localHead.Position, HumanoidRootPart, {Character}) then continue end
        end
        if _G.CamlockConditionsCarried and IsGrabbed(Player) then continue end
        if _G.CamlockConditionsKnocked and IsKnocked(Character) then continue end
        if _G.CamlockConditionsSelfKnocked and IsKnocked(LocalPlayer.Character) then continue end
        local Magnitude = (Vector2.new(Position.X, Position.Y) - MousePosition).Magnitude
        if Magnitude < Distance then Closest = Player Distance = Magnitude end
    end
    return Closest
end

local Camlock = { Target = nil, Active = false, Connection = nil }

local function IsHoldingGun()
    local char = LocalPlayer.Character
    if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return false end
    if tool:FindFirstChild("Ammo") then return true end
    if tool:FindFirstChild("Magazine") then return true end
    local gunModule = ReplicatedStorage:FindFirstChild("Modules")
    if gunModule then
        local gunHandler = gunModule:FindFirstChild("GunHandler")
        if gunHandler then
            local success, module = pcall(function() return require(gunHandler) end)
            if success and module and module.getGun then
                local success2, gun = pcall(function() return module.getGun(tool) end)
                if success2 and gun then return true end
            end
        end
    end
    return false
end

local function UpdateCamlock()
    if not _G.CamlockEnabled then
        Camlock.Active = false
        Camlock.Target = nil
        return
    end
    if _G.CamlockAutoToggle then
        if not IsHoldingGun() then
            Camlock.Active = false
            Camlock.Target = nil
            return
        end
        if not Camlock.Active or not Camlock.Target or not Camlock.Target.Character then
            local target = GetBestCamlockTarget()
            if target then
                Camlock.Target = target
                Camlock.Active = true
            else
                Camlock.Active = false
                Camlock.Target = nil
            end
            return
        end
    else
        if not Camlock.Active then return end
    end
    if not Camlock.Active then return end
    if not Camlock.Target or not Camlock.Target.Character then Camlock.Active = false return end
    local Character = Camlock.Target.Character
    if not Character:FindFirstChild("HumanoidRootPart") then Camlock.Active = false return end
    if _G.CamlockConditionsForceField and Character:FindFirstChild("Forcefield") then return end
    if _G.CamlockConditionsKnocked and IsKnocked(Character) then return end
    if _G.CamlockConditionsSelfKnocked and IsKnocked(LocalPlayer.Character) then return end
    if _G.CamlockConditionsCarried and IsGrabbed(Camlock.Target) then return end
    local HitPosition = GetCamlockHitPosition(Camlock.Target)
    if not HitPosition then return end
    local Smoothing = _G.CamlockSmoothness
    if _G.CamlockPullStrengthEnabled then
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        if RootPart then
            local VelocityMagnitude = RootPart.Velocity.Magnitude
            if VelocityMagnitude > 15 then Smoothing = _G.CamlockPullStrengthMoveValue
            else Smoothing = _G.CamlockPullStrengthBaseValue end
        end
    end
    local EasedSmoothing = TweenService:GetValue(Smoothing, Enum.EasingStyle[_G.CamlockEasingStyle], Enum.EasingDirection[_G.CamlockEasingDirection])
    cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, HitPosition), EasedSmoothing)
end

local function EnableCamlock()
    if not _G.CamlockEnabled then return end
    local target = GetBestCamlockTarget()
    if target then
        Camlock.Target = target
        Camlock.Active = true
        if not Camlock.Connection then Camlock.Connection = RunService.RenderStepped:Connect(UpdateCamlock) end
    end
end

local function DisableCamlock()
    Camlock.Active = false
    Camlock.Target = nil
end

if not Camlock.Connection then Camlock.Connection = RunService.RenderStepped:Connect(UpdateCamlock) end

local oldMouseIndex_HC = nil
-- Improved Hood Customs Silent Aim (from dollies-style logic, FOV up to 1000)
local oldMouseIndex_HC = nil
local hcSilentAimCachedPart = nil

local function isHoldingRevolverHC()
    if not _G.HCRevolverBypass then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        local toolName = string.lower(tool.Name)
        if string.find(toolName, "revolver") or string.find(toolName, "rev") then
            return true
        end
    end
    return false
end

local function hcWallBetween(pos)
    if not _G.HCWallCheck then return false end
    local ro = cam.CFrame.Position
    local rd = pos - ro
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    params.FilterType = Enum.RaycastFilterType.Exclude
    local hit = workspace:Raycast(ro, rd, params)
    if not hit then return false end
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and hit.Instance:IsDescendantOf(p.Character) then return false end
    end
    return true
end

local function hcGetTargetPart(char)
    if not char then return nil end
    if _G.HCHitPart == "Closest Point" then
        local closestPart, shortestDist = nil, math.huge
        local mousePos = UIS:GetMouseLocation()
        local parts = {
            "Head", "UpperTorso", "HumanoidRootPart", "LowerTorso",
            "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
            "LeftHand", "RightHand", "LeftUpperLeg", "RightUpperLeg",
            "LeftLowerLeg", "RightLowerLeg", "LeftFoot", "RightFoot"
        }
        for _, pName in ipairs(parts) do
            local part = char:FindFirstChild(pName)
            if part then
                local sp, onScreen = cam:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(sp.X, sp.Y) - mousePos).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        closestPart = part
                    end
                end
            end
        end
        return closestPart or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
    end
    return char:FindFirstChild(_G.HCHitPart) or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function hcGetClosestPlayerToCursor()
    if isHoldingRevolverHC() then return nil end
    local closestPart = nil
    local shortestDist = _G.HCFOVRadius
    local mousePos = UIS:GetMouseLocation()

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                if _G.HCKnockCheck then
                    local bodyEffects = p.Character:FindFirstChild("BodyEffects")
                    if bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value then
                        continue
                    end
                end
                if _G.Whitelist and _G.Whitelist[p.UserId] then continue end

                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local sp, onScreen = cam:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        local dist2D = (Vector2.new(sp.X, sp.Y) - mousePos).Magnitude
                        if dist2D < shortestDist then
                            local part = hcGetTargetPart(p.Character)
                            if part and not hcWallBetween(part.Position) then
                                shortestDist = dist2D
                                closestPart = part
                            end
                        end
                    end
                end
            end
        end
    end
    return closestPart
end

local function enableHCSilentAim(enable)
    if enable then
        if oldMouseIndex_HC then return end

        -- Cache target every frame
        if not _G.__hcSilentAimLoop then
            _G.__hcSilentAimLoop = RunService.RenderStepped:Connect(function()
                if _G.HCSilentAimEnabled then
                    hcSilentAimCachedPart = hcGetClosestPlayerToCursor()
                else
                    hcSilentAimCachedPart = nil
                end
            end)
        end

        oldMouseIndex_HC = hookmetamethod(game, "__index", function(self, idx)
            if not checkcaller() and _G.HCSilentAimEnabled and self == mouse and (idx == "Hit" or idx == "Target" or idx == "UnitRay") then
                if hcSilentAimCachedPart and not isHoldingRevolverHC() then
                    local origin = cam.CFrame.Position
                    local hitPos = hcSilentAimCachedPart.Position

                    -- Prediction
                    if _G.HCPrediction and _G.HCPredictionAmount > 0 then
                        local vel = hcSilentAimCachedPart.AssemblyLinearVelocity
                        hitPos = hitPos + Vector3.new(
                            vel.X * _G.HCPredictionAmount,
                            vel.Y * _G.HCPredictionAmount,
                            vel.Z * _G.HCPredictionAmount
                        )
                    end

                    if idx == "UnitRay" then
                        return Ray.new(origin, (hitPos - origin).Unit)
                    elseif idx == "Hit" then
                        return CFrame.new(hitPos)
                    elseif idx == "Target" then
                        return hcSilentAimCachedPart
                    end
                end
            end
            return oldMouseIndex_HC(self, idx)
        end)
    else
        if oldMouseIndex_HC then
            hookmetamethod(game, "__index", oldMouseIndex_HC)
            oldMouseIndex_HC = nil
        end
        hcSilentAimCachedPart = nil
    end
end

local oldAimBodyParts = {
    "Head", "UpperTorso", "HumanoidRootPart", "LowerTorso",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
    "LeftHand", "RightHand", "LeftUpperLeg", "RightUpperLeg",
    "LeftLowerLeg", "RightLowerLeg", "LeftFoot", "RightFoot"
}
local oldAimCachedPart = nil
local oldAimOldMouseIndex = nil

local function oldAimIsAlive(p)
    local c = p.Character
    local h = c and c:FindFirstChildOfClass("Humanoid")
    return h and h.Health > 0
end

local function oldAimWallBetween(pos)
    if not _G.OldAimWallCheck then return false end
    local ro = cam.CFrame.Position
    local rd = pos - ro
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    params.FilterType = Enum.RaycastFilterType.Exclude
    local hit = workspace:Raycast(ro, rd, params)
    if not hit then return false end
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and hit.Instance:IsDescendantOf(p.Character) then return false end
    end
    return true
end

local function oldAimGetClosestBodyPart(char)
    local closest, shortest = nil, math.huge
    local mousePos = UIS:GetMouseLocation()
    for _, name in ipairs(oldAimBodyParts) do
        local part = char:FindFirstChild(name)
        if part then
            local sp, on = cam:WorldToViewportPoint(part.Position)
            if on then
                local d = (Vector2.new(sp.X, sp.Y) - mousePos).Magnitude
                if d < shortest then
                    shortest = d
                    closest = part
                end
            end
        end
    end
    return closest or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function oldAimGetTargetPart(char)
    if not char then return nil end
    if _G.OldAimClosestPart then
        return oldAimGetClosestBodyPart(char)
    end
    return char:FindFirstChild(_G.OldAimHitPart) or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function oldAimGetClosestPlayerPart()
    local closest, shortest = nil, _G.OldAimFOVRadius
    local mousePos = UIS:GetMouseLocation()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and oldAimIsAlive(p) then
            local char = p.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then continue end
            if _G.OldAimKnockCheck then
                local be = char:FindFirstChild("BodyEffects")
                if be and be:FindFirstChild("K.O") and be["K.O"].Value then continue end
            end
            if _G.Whitelist and _G.Whitelist[p.UserId] then continue end
            local dist3 = (hrp.Position - cam.CFrame.Position).Magnitude
            if dist3 > _G.OldAimMaxDistance then continue end
            local sp, on = cam:WorldToViewportPoint(hrp.Position)
            if not on then continue end
            local dist2 = (Vector2.new(sp.X, sp.Y) - mousePos).Magnitude
            if dist2 < shortest then
                local part = oldAimGetTargetPart(char)
                if part and not oldAimWallBetween(part.Position) then
                    shortest = dist2
                    closest = part
                end
            end
        end
    end
    return closest
end

local function oldAimPredictedPos(part)
    local vel = part.AssemblyLinearVelocity or Vector3.zero
    return part.Position
        + Vector3.new(vel.X * _G.OldAimPredictionX, vel.Y * _G.OldAimPredictionY, vel.Z * _G.OldAimPredictionZ)
        + Vector3.new(_G.OldAimOffsetX, _G.OldAimOffsetY, _G.OldAimOffsetZ)
end

local function enableOldAim(enable)
    if enable then
        if oldAimOldMouseIndex then return end
        if not _G.__oldAimLoop then
            _G.__oldAimLoop = RunService.RenderStepped:Connect(function()
                if _G.OldAimEnabled then
                    oldAimCachedPart = oldAimGetClosestPlayerPart()
                else
                    oldAimCachedPart = nil
                end
            end)
        end
        oldAimOldMouseIndex = hookmetamethod(game, "__index", function(self, idx)
            if not checkcaller() and _G.OldAimEnabled and self == mouse and (idx == "Hit" or idx == "Target" or idx == "UnitRay") then
                if oldAimCachedPart and math.random(1, 100) <= _G.OldAimHitChance then
                    local origin = cam.CFrame.Position
                    local hitPos = oldAimPredictedPos(oldAimCachedPart)
                    if idx == "UnitRay" then
                        return Ray.new(origin, (hitPos - origin).Unit)
                    elseif idx == "Hit" then
                        return CFrame.new(hitPos)
                    elseif idx == "Target" then
                        return oldAimCachedPart
                    end
                end
            end
            return oldAimOldMouseIndex(self, idx)
        end)
    else
        if oldAimOldMouseIndex then
            hookmetamethod(game, "__index", oldAimOldMouseIndex)
            oldAimOldMouseIndex = nil
        end
        oldAimCachedPart = nil
    end
end

local ForceHitHighlightTarget = nil
local ForceHitHighlightLine = Drawing.new("Line")
ForceHitHighlightLine.Thickness = 1.5
ForceHitHighlightLine.Color = Color3.fromRGB(165, 201, 255)
ForceHitHighlightLine.Transparency = 0.3
ForceHitHighlightLine.Visible = false

local ForceHitFullAutoActive = false
local ForceHitIsHoldingMouse = false
local ForceHitLastFireTime = 0

local ForceHitAllowedTools = {
    "[DoubleBarrel]", "[Revolver]", "[Shotgun]",
    "[SMG]", "[Silencer]", "[TacticalShotgun]"
}

local function ForceHit_IsValidTarget(pl)
    if not pl or pl == LocalPlayer then return false end
    if not pl.Character then return false end
    local hum = pl.Character:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    if _G.KnockCheck and isKnocked(pl) then return false end
    return true
end

local function ForceHit_GetClosestPartToMouse(pl)
    local m = UIS:GetMouseLocation()
    local nearestPart, nearestDist = nil, math.huge
    for _, name in ipairs(HCForceHitParts) do
        local part = pl.Character and pl.Character:FindFirstChild(name)
        if part then
            local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(m.X, m.Y)).Magnitude
                if dist < nearestDist then nearestDist = dist nearestPart = part end
            end
        end
    end
    return nearestPart
end

local function ForceHit_GetFovTarget()
    local m = UIS:GetMouseLocation()
    local bestPart, bestDist = nil, _G.ForceHitFOV
    for _, pl in ipairs(Players:GetPlayers()) do
        if ForceHit_IsValidTarget(pl) then
            local part = ForceHit_GetClosestPartToMouse(pl)
            if part then
                local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(m.X, m.Y)).Magnitude
                    if dist < bestDist then bestDist = dist bestPart = part end
                end
            end
        end
    end
    return bestPart
end

local function ForceHit_GetBarrelPosition()
    local char = LocalPlayer.Character
    if not char then return nil end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        local h = tool:FindFirstChild("Handle") or tool:FindFirstChild("Barrel") or tool:FindFirstChild("Muzzle")
        if h and h:IsA("BasePart") then return h.Position end
    end
    local arm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightUpperArm")
    if arm and arm:IsA("BasePart") then return arm.Position end
    return char:GetPivot().Position
end

local function ForceHit_SpawnTracer(startPos, endPos)
    if (endPos - startPos).Magnitude < 0.1 then return end
    local beam = Instance.new("Beam")
    local attach0 = Instance.new("Attachment")
    local attach1 = Instance.new("Attachment")
    beam.Segments = 1
    beam.Width0 = 0.1
    beam.Width1 = 0.1
    beam.Color = ColorSequence.new(Color3.fromRGB(255, 200, 0))
    beam.Transparency = NumberSequence.new(0.4)
    beam.FaceCamera = true
    attach0.Position = startPos
    attach1.Position = endPos
    attach0.Parent = workspace.Terrain
    attach1.Parent = workspace.Terrain
    beam.Attachment0 = attach0
    beam.Attachment1 = attach1
    beam.Parent = workspace.Terrain
    task.delay(0.08, function()
        beam:Destroy() attach0:Destroy() attach1:Destroy()
    end)
end

local function ForceHit_Fire(targetPart)
    if not targetPart then return end
    local impactPos = targetPart.Position
    local hrpPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position or Vector3.zero
    ReplicatedStorage.MainEvent:FireServer(unpack({
        "Shoot",
        {
            {{ Normal = impactPos, Instance = targetPart, Position = impactPos }, { Normal = impactPos, Instance = targetPart, Position = impactPos }, { Normal = impactPos, Instance = targetPart, Position = impactPos }, { Normal = impactPos, Instance = targetPart, Position = impactPos }, { Normal = impactPos, Instance = targetPart, Position = impactPos }},
            {{ thePart = targetPart, theOffset = Vector3.new(0, 0, 0) }, { thePart = targetPart, theOffset = Vector3.new(0, 0, 0) }, { thePart = targetPart, theOffset = Vector3.new(0, 0, 0) }, { thePart = targetPart, theOffset = Vector3.new(0, 0, 0) }, { thePart = targetPart, theOffset = Vector3.new(0, 0, 0) }},
            hrpPos, hrpPos, workspace:GetServerTimeNow()
        }
    }))
    if _G.ForceHitTracerEnabled then
        local barrelPos = ForceHit_GetBarrelPosition()
        if barrelPos then ForceHit_SpawnTracer(barrelPos, impactPos) end
    end
end

local function ForceHit_MouseClick(action, state, input)
    if state ~= Enum.UserInputState.Begin then return Enum.ContextActionResult.Pass end
    if not _G.ForceHitEnabled then return Enum.ContextActionResult.Pass end
    local char = LocalPlayer.Character
    if not char then return Enum.ContextActionResult.Pass end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool or not table.find(ForceHitAllowedTools, tool.Name) then return Enum.ContextActionResult.Pass end
    if _G.ForceHitMode == "Fov" then
        local part = ForceHit_GetFovTarget()
        if part then ForceHit_Fire(part) end
    elseif _G.ForceHitMode == "Manual" then
        if ForceHitHighlightTarget and ForceHitHighlightTarget.Character then
            local part = ForceHit_GetClosestPartToMouse(ForceHitHighlightTarget)
            if part then ForceHit_Fire(part) end
        end
    end
    return Enum.ContextActionResult.Sink
end

CAS:BindAction("NHForceHit", ForceHit_MouseClick, false, Enum.UserInputType.MouseButton1)

local function getFlameTarget()
    local mousePos = Vector2.new(mouse.X, mouse.Y)
    local closestPart = nil
    local closestDist = math.huge
    
    for _, v in pairs(Players:GetPlayers()) do
        if v == LocalPlayer then continue end
        if _G.Whitelist and _G.Whitelist[v.UserId] then continue end
        local char = v.Character
        if not char then continue end
        
        local part = char:FindFirstChild(_G.FlameHitPart) or char:FindFirstChild("HumanoidRootPart")
        if not part then continue end
        
        local screenPos, onScreen = cam:WorldToScreenPoint(part.Position)
        if onScreen then
            local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
            if dist < closestDist then
                closestDist = dist
                closestPart = part
            end
        end
    end
    
    return closestPart
end

local flameTargetPart = nil

local function runTriggerBot()
    if not TriggerBot.MasterEnabled or not TriggerBot.Active then return end

    if not IsHoldingGun() then return end

    local target = mouse.Target
    if not target then return end

    local model = target:FindFirstAncestorOfClass("Model")
    if not model or model == me.Character then return end

    local humanoid = model:FindFirstChildOfClass("Humanoid")
    local player = Players:GetPlayerFromCharacter(model)
    if not humanoid or humanoid.Health <= 0 or not player or isWhitelisted(player) then return end

    local tool = me.Character and me.Character:FindFirstChildOfClass("Tool")
    if not tool then return end

    tool:Activate()
    task.wait(math.max(0, tonumber(TriggerBot.Delay) or 0))
end

UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then ForceHitIsHoldingMouse = true end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == TriggerBot.Key then
        -- Only allow the key to toggle Active if the master toggle is ON
        if TriggerBot.MasterEnabled then
            TriggerBot.Active = not TriggerBot.Active
        end
    end
    -- UI toggle must run even when gameProcessed (so it can reopen after close)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == _G.UIToggleKey then
        local show = not WindowOuterBorder.Visible
        WindowOuterBorder.Visible = show
        _G.UIVisible = show
        return
    end
    if _G.OldAimUseKeybind and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == _G.OldAimToggleKey then
        _G.OldAimEnabled = not _G.OldAimEnabled
        enableOldAim(_G.OldAimEnabled)
    end
    if gameProcessed then return end
    if _G.CamlockEnabled and not _G.CamlockAutoToggle then
        local camlockKey = getKeyCode(_G.CamlockToggleKey)
        if input.KeyCode == camlockKey then
            if _G.CamlockMode == "Toggle" then
                if Camlock.Active then DisableCamlock() else EnableCamlock() end
            elseif _G.CamlockMode == "Hold" then EnableCamlock() end
        end
    end
    if _G.FlamelockEnabled then
        local isTriggered = (_G.FlameRightClick and input.UserInputType == Enum.UserInputType.MouseButton2) or (not _G.FlameRightClick and input.KeyCode == _G.FlameKey)
        if isTriggered then
            if _G.FlameMode == "Hold" then
                _G.FlameActive = true
            else
                _G.FlameActive = not _G.FlameActive
            end
            if _G.FlameActive then
                local target = getFlameTarget()
                if target then
                    flameTargetPart = target
                else
                    _G.FlameActive = false
                    flameTargetPart = nil
                end
            else
                flameTargetPart = nil
            end
        end
    end
    if input.KeyCode == _G.SpeedKey then
        if _G.SpeedMaster then
            _G.SpeedActive = not _G.SpeedActive
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                if _G.SpeedActive then
                    hum.WalkSpeed = tonumber(_G.SpeedValue) or 16
                else
                    hum.WalkSpeed = 16
                end
            end
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then ForceHitIsHoldingMouse = false end
    if _G.CamlockEnabled and not _G.CamlockAutoToggle then
        local camlockKey = getKeyCode(_G.CamlockToggleKey)
        if input.KeyCode == camlockKey and _G.CamlockMode == "Hold" then DisableCamlock() end
    end
    if _G.FlamelockEnabled and _G.FlameMode == "Hold" then
        local isTriggered = (_G.FlameRightClick and input.UserInputType == Enum.UserInputType.MouseButton2) or (not _G.FlameRightClick and input.KeyCode == _G.FlameKey)
        if isTriggered then
            _G.FlameActive = false
            flameTargetPart = nil
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if Camlock.Target == player then DisableCamlock() end
end)

LocalPlayer.CharacterAdded:Connect(function()
    DisableCamlock()
    if headlessActive then
        local char = LocalPlayer.Character
        if char then
            local head = char:WaitForChild("Head", 5)
            if head then head.Transparency = 1 end
        end
    end
end)

-- Speed: re-apply every frame (Da Hood resets WalkSpeed often)
local _speedHum = nil
LocalPlayer.CharacterAdded:Connect(function(char)
    _speedHum = nil
    task.defer(function()
        if not (_G.SpeedMaster and _G.SpeedActive) then return end
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            _speedHum = hum
            hum.WalkSpeed = tonumber(_G.SpeedValue) or 16
        end
    end)
end)
RunService.Heartbeat:Connect(function()
    if not (_G.SpeedMaster and _G.SpeedActive) then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = _speedHum
    if not hum or hum.Parent ~= char then
        hum = char:FindFirstChildOfClass("Humanoid")
        _speedHum = hum
    end
    if not hum then return end
    local target = tonumber(_G.SpeedValue) or 16
    if target < 16 then target = 16 end
    -- always set (game scripts overwrite WalkSpeed constantly)
    hum.WalkSpeed = target
end)
RunService.RenderStepped:Connect(function()
    if not (_G.SpeedMaster and _G.SpeedActive) then return end
    local hum = _speedHum
    if hum and hum.Parent then
        local target = tonumber(_G.SpeedValue) or 16
        if target < 16 then target = 16 end
        hum.WalkSpeed = target
    end
end)

RunService.Heartbeat:Connect(function()
    if _G.AntiFallEnabled and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum and hum.Health > 1 and hum:GetState() == Enum.HumanoidStateType.FallingDown then hum:ChangeState("GettingUp") end
    end
    if _G.ForceHitFullAutoEnabled and ForceHitIsHoldingMouse and _G.ForceHitEnabled then
        local now = tick()
        if now - ForceHitLastFireTime < _G.ForceHitFireRate then return end
        ForceHitLastFireTime = now
        local char = LocalPlayer.Character
        if not char then return end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool or not table.find(ForceHitAllowedTools, tool.Name) then return end
        if _G.ForceHitMode == "Fov" then
            local part = ForceHit_GetFovTarget()
            if part then ForceHit_Fire(part) end
        elseif _G.ForceHitMode == "Manual" then
            if ForceHitHighlightTarget and ForceHitHighlightTarget.Character then
                local part = ForceHit_GetClosestPartToMouse(ForceHitHighlightTarget)
                if part then ForceHit_Fire(part) end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    runTriggerBot()
end)

RunService.RenderStepped:Connect(function()
    if not (_G.ForceHitEnabled and _G.ForceHitMode == "Manual") then
        if ForceHitHighlightLine and ForceHitHighlightLine.Visible then
            ForceHitHighlightLine.Visible = false
        end
        return
    end
    if _G.ForceHitEnabled and _G.ForceHitMode == "Manual" then
        if ForceHitHighlightTarget and ForceHitHighlightTarget.Character then
            local part = ForceHit_GetClosestPartToMouse(ForceHitHighlightTarget)
            if part then
                local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
                if onScreen then
                    ForceHitHighlightLine.From = UIS:GetMouseLocation()
                    ForceHitHighlightLine.To = Vector2.new(screenPos.X, screenPos.Y)
                    ForceHitHighlightLine.Visible = true
                else ForceHitHighlightLine.Visible = false end
            else ForceHitHighlightLine.Visible = false end
        else ForceHitHighlightLine.Visible = false end
    else ForceHitHighlightLine.Visible = false end
end)

local _0x9ba38e
_0x9ba38e = hookfunction(math.random, function(...)
    local args = {...}
    if checkcaller() then return _0x9ba38e(...) end
    if (#args == 0) or (args[1] == -0.05 and args[2] == 0.05) or (args[1] == -0.1) or (args[1] == -0.05) then
        if BulletSpreadSettings.Enabled then return _0x9ba38e(...) * (_G.BulletSpreadAmount / 100) end
    end
    return _0x9ba38e(...)
end)

local function createESP(plr)
    if espObjects[plr] then return end
    local box = Drawing.new("Square") box.Thickness = 1 box.Filled = false box.Color = _G.ESP_Color box.Visible = false
    local name = Drawing.new("Text") name.Size = 13 name.Center = true name.Outline = true name.Color = _G.ESP_Color name.Visible = false
    local displayName = Drawing.new("Text") displayName.Size = 13 displayName.Center = true displayName.Outline = true displayName.Color = _G.ESP_Color displayName.Visible = false
    local health = Drawing.new("Text") health.Size = 13 health.Center = false health.Outline = true health.Color = Color3.fromRGB(50, 255, 50) health.Visible = false
    local distance = Drawing.new("Text") distance.Size = 12 distance.Center = true distance.Outline = true distance.Color = Color3.fromRGB(200, 200, 200) distance.Visible = false
    local tracer = Drawing.new("Line") tracer.Thickness = 1 tracer.Color = _G.ESP_Color tracer.Visible = false
    local skeleton = {}
    espObjects[plr] = {Box = box, Name = name, DisplayName = displayName, Health = health, Distance = distance, Tracer = tracer, Skeleton = skeleton}
end

for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then createESP(p) end end
Players.PlayerAdded:Connect(function(p) if p ~= LocalPlayer then createESP(p) end end)
Players.PlayerRemoving:Connect(function(p)
    if espObjects[p] then
        espObjects[p].Box:Remove() espObjects[p].Name:Remove() if espObjects[p].DisplayName then espObjects[p].DisplayName:Remove() end espObjects[p].Health:Remove() espObjects[p].Distance:Remove() espObjects[p].Tracer:Remove()
        for _, v in pairs(espObjects[p].Skeleton) do v:Remove() end
        espObjects[p] = nil
    end
end)

fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1
fovCircle.NumSides = 60
fovCircle.Radius = _G.FOV_RADIUS
fovCircle.Filled = false
fovCircle.Color = ColorPresets[_G.CurrentTheme].AccentColor
fovCircle.Visible = false

hcFovCircle = Drawing.new("Circle")
hcFovCircle.Thickness = 1
hcFovCircle.NumSides = 60
hcFovCircle.Radius = _G.HCFOVRadius
hcFovCircle.Filled = false
hcFovCircle.Color = ColorPresets[_G.CurrentTheme].AccentColor
hcFovCircle.Visible = false

oldAimFovCircle = Drawing.new("Circle")
oldAimFovCircle.Thickness = 1
oldAimFovCircle.NumSides = 60
oldAimFovCircle.Radius = _G.OldAimFOVRadius
oldAimFovCircle.Filled = false
oldAimFovCircle.Color = ColorPresets[_G.CurrentTheme].AccentColor
oldAimFovCircle.Visible = false

-- setfpscap once (calling it every frame tanks FPS)
task.spawn(function()
    task.wait(1)
    if _G.FPSUnlocker and setfpscap then
        pcall(setfpscap, _G.FPSTarget or 240)
    end
end)

local _espWasOn = false
RunService.RenderStepped:Connect(function()
    local showAnyFov = (_G.ShowFOV and _G.SilentAim_Enabled and (_G.FOV_RADIUS or 0) > 0)
        or (_G.HCShowFOV and _G.HCSilentAimEnabled and (_G.HCFOVRadius or 0) > 0)
        or (_G.OldAimShowFOV and _G.OldAimEnabled and (_G.OldAimFOVRadius or 0) > 0)
    if showAnyFov then
        local mid = Vector2.new(cam.ViewportSize.X * 0.5, cam.ViewportSize.Y * 0.5)
        local accent = (ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]).AccentColor
        fovCircle.Radius = _G.FOV_RADIUS
        hcFovCircle.Radius = _G.HCFOVRadius
        oldAimFovCircle.Radius = _G.OldAimFOVRadius
        fovCircle.Color = accent
        hcFovCircle.Color = accent
        oldAimFovCircle.Color = accent
        fovCircle.Position = mid
        hcFovCircle.Position = mid
        oldAimFovCircle.Position = mid
    end
    fovCircle.Visible = _G.ShowFOV and _G.SilentAim_Enabled and (_G.FOV_RADIUS or 0) > 0
    hcFovCircle.Visible = _G.HCShowFOV and _G.HCSilentAimEnabled and (_G.HCFOVRadius or 0) > 0
    oldAimFovCircle.Visible = _G.OldAimShowFOV and _G.OldAimEnabled and (_G.OldAimFOVRadius or 0) > 0

    if _G.FlamelockEnabled and _G.FlameActive then
        if not flameTargetPart or not flameTargetPart.Parent then
            local target = getFlameTarget()
            if target then
                flameTargetPart = target
            else
                _G.FlameActive = false
            end
        end
        if flameTargetPart and flameTargetPart.Parent then
            local targetPlayer = Players:GetPlayerFromCharacter(flameTargetPart.Parent)
            if targetPlayer and not (_G.Whitelist and _G.Whitelist[targetPlayer.UserId]) then
                local predPos = flameTargetPart.Position + (flameTargetPart.Velocity * _G.FlamePrediction)
                local offsetPos = predPos + (cam.CFrame.RightVector * _G.FlameLeftOffset) + Vector3.new(0, _G.FlameUpOffset, 0)
                local sp, on = cam:WorldToViewportPoint(offsetPos)
                if on then
                    local deltaX = (sp.X - mouse.X) * _G.FlameSmoothness
                    local deltaY = (sp.Y - mouse.Y) * _G.FlameSmoothness
                    mousemoverel(deltaX, deltaY)
                end
            else
                flameTargetPart = nil
                _G.FlameActive = false
            end
        end
    end

    -- Skip expensive ESP work when fully disabled
    local espOn = _G.ESP_Enabled and (_G.ESP_Boxes or _G.ESP_Names or _G.ESP_DisplayNames or _G.ESP_Health or _G.ESP_Distance or _G.ESP_Tracer or _G.ESP_Skeleton)
    if not espOn then
        if _espWasOn then
            for _, objs in pairs(espObjects) do
                if objs.Box then objs.Box.Visible = false end
                if objs.Name then objs.Name.Visible = false end
                if objs.DisplayName then objs.DisplayName.Visible = false end
                if objs.Health then objs.Health.Visible = false end
                if objs.Distance then objs.Distance.Visible = false end
                if objs.Tracer then objs.Tracer.Visible = false end
                if objs.Skeleton then
                    for _, line in pairs(objs.Skeleton) do line.Visible = false end
                end
            end
            _espWasOn = false
        end
        return
    end
    _espWasOn = true

    for plr, objs in pairs(espObjects) do
        local isWhitelisted = _G.Whitelist and _G.Whitelist[plr.UserId] or false
        if _G.ESP_Enabled and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and not isWhitelisted then
            local char = plr.Character local hrp = char.HumanoidRootPart local hum = char:FindFirstChild("Humanoid")
            local rootPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
            if onScreen and hum and hum.Health > 0 then
                local head = char:FindFirstChild("Head") or hrp
                local headPos = cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                local legPos = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                local boxHeight = math.abs(headPos.Y - legPos.Y)
                local topLeft = Vector2.new(rootPos.X - (boxHeight / 2) / 2, rootPos.Y - boxHeight / 2)
                if _G.ESP_Boxes then
                    objs.Box.Size = Vector2.new(boxHeight / 2, boxHeight) objs.Box.Position = topLeft objs.Box.Color = _G.ESP_Color objs.Box.Visible = true
                else objs.Box.Visible = false end
                if _G.ESP_Names and _G.ESP_DisplayNames then
                    -- Display name on top, username under it
                    if objs.DisplayName then
                        objs.DisplayName.Position = Vector2.new(rootPos.X, topLeft.Y - 30)
                        objs.DisplayName.Text = plr.DisplayName
                        objs.DisplayName.Color = _G.ESP_Color
                        objs.DisplayName.Visible = true
                    end
                    objs.Name.Position = Vector2.new(rootPos.X, topLeft.Y - 16)
                    objs.Name.Text = plr.Name
                    objs.Name.Color = _G.ESP_Color
                    objs.Name.Visible = true
                elseif _G.ESP_Names then
                    objs.Name.Position = Vector2.new(rootPos.X, topLeft.Y - 16)
                    objs.Name.Text = plr.Name
                    objs.Name.Color = _G.ESP_Color
                    objs.Name.Visible = true
                    if objs.DisplayName then objs.DisplayName.Visible = false end
                elseif _G.ESP_DisplayNames then
                    objs.Name.Visible = false
                    if objs.DisplayName then
                        objs.DisplayName.Position = Vector2.new(rootPos.X, topLeft.Y - 16)
                        objs.DisplayName.Text = plr.DisplayName
                        objs.DisplayName.Color = _G.ESP_Color
                        objs.DisplayName.Visible = true
                    end
                else
                    objs.Name.Visible = false
                    if objs.DisplayName then objs.DisplayName.Visible = false end
                end
                if _G.ESP_Health then
                    local healthPercent = hum.Health / hum.MaxHealth
                    objs.Health.Position = Vector2.new(topLeft.X - 24, topLeft.Y) 
                    objs.Health.Text = tostring(math.floor(healthPercent * 100)) .. "%" 
                    objs.Health.Color = healthPercent > 0.5 and Color3.fromRGB(50, 255, 50) or (healthPercent > 0.25 and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(255, 50, 50))
                    objs.Health.Visible = true
                else objs.Health.Visible = false end
                if _G.ESP_Distance then
                    local dist = math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) or 0)
                    objs.Distance.Position = Vector2.new(rootPos.X, topLeft.Y + boxHeight + 4) 
                    objs.Distance.Text = tostring(dist) .. "m" 
                    objs.Distance.Color = _G.ESP_Color
                    objs.Distance.Visible = true
                else objs.Distance.Visible = false end
                if _G.ESP_Tracer then
                    objs.Tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y) 
                    objs.Tracer.To = Vector2.new(rootPos.X, rootPos.Y) 
                    objs.Tracer.Color = _G.ESP_Color 
                    objs.Tracer.Visible = true
                else objs.Tracer.Visible = false end
                if _G.ESP_Skeleton then
                    for _, conn in ipairs(boneConnections) do
                        local part1 = char:FindFirstChild(conn[1]) local part2 = char:FindFirstChild(conn[2])
                        if part1 and part2 then
                            local p1, on1 = cam:WorldToViewportPoint(part1.Position)
                            local p2, on2 = cam:WorldToViewportPoint(part2.Position)
                            if on1 and on2 then
                                if not objs.Skeleton[conn[1] .. conn[2]] then
                                    objs.Skeleton[conn[1] .. conn[2]] = Drawing.new("Line")
                                    objs.Skeleton[conn[1] .. conn[2]].Thickness = 1.5
                                    objs.Skeleton[conn[1] .. conn[2]].Transparency = 0.6
                                end
                                local line = objs.Skeleton[conn[1] .. conn[2]]
                                line.From = Vector2.new(p1.X, p1.Y) line.To = Vector2.new(p2.X, p2.Y) line.Color = _G.ESP_Color line.Visible = true
                            end
                        end
                    end
                else
                    for _, line in pairs(objs.Skeleton) do line.Visible = false end
                end
            else
                objs.Box.Visible = false objs.Name.Visible = false if objs.DisplayName then objs.DisplayName.Visible = false end objs.Health.Visible = false objs.Distance.Visible = false objs.Tracer.Visible = false
                for _, line in pairs(objs.Skeleton) do line.Visible = false end
            end
        else
            if espObjects[plr] then
                espObjects[plr].Box.Visible = false espObjects[plr].Name.Visible = false if espObjects[plr].DisplayName then espObjects[plr].DisplayName.Visible = false end espObjects[plr].Health.Visible = false espObjects[plr].Distance.Visible = false espObjects[plr].Tracer.Visible = false
                for _, line in pairs(espObjects[plr].Skeleton) do line.Visible = false end
            end
        end
    end
end)

local function SaveConfig(configName)
    if not isfolder("adis_configs") then makefolder("adis_configs") end
    local configData = {}
    for k, v in pairs(_G) do
        if type(k) == "string" and k ~= "Whitelist" and type(v) ~= "function" and type(v) ~= "table" and type(v) ~= "userdata" then
            configData[k] = v
        end
    end
    configData.Whitelist = _G.Whitelist
    local json = game:GetService("HttpService"):JSONEncode(configData)
    writefile("adis_configs/" .. configName .. ".json", json)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Adis.UI", Text = "Config saved: " .. configName, Duration = 3 })
    end)
end

local function LoadConfig(configName)
    local path = "adis_configs/" .. configName .. ".json"
    if not isfile(path) then return false end
    local json = readfile(path)
    local configData = game:GetService("HttpService"):JSONDecode(json)
    for k, v in pairs(configData) do
        if k ~= "Whitelist" then
            _G[k] = v
        else
            for uid, val in pairs(v) do _G.Whitelist[uid] = val end
        end
    end
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Adis.UI", Text = "Config loaded: " .. configName, Duration = 3 })
    end)
    return true
end

local function DeleteConfig(configName)
    local path = "adis_configs/" .. configName .. ".json"
    if isfile(path) then delfile(path) return true end
    return false
end

local function GetConfigs()
    if not isfolder("adis_configs") then makefolder("adis_configs") return {} end
    local files = listfiles("adis_configs")
    local configs = {}
    for _, filePath in ipairs(files) do
        local name = filePath:match("adis_configs[/\\](.+)%.json$")
        if name then table.insert(configs, name) end
    end
    return configs
end

local configNameInput = ""
local selectedConfig = nil

local whitelistSearchText = ""

shared.Glory = shared.Glory or {skins = {enabled = true, weapons = {
    ["[Knife]"] = "",
    ["[TacticalShotgun]"] = "",
    ["[Shotgun]"] = "",
    ["[Revolver]"] = "",
    ["[Double-Barrel SG]"] = "",
    ["[LMG]"] = "",
}}}
if not shared.Glory.skins.weapons["[Knife]"] then shared.Glory.skins.weapons["[Knife]"] = "" end
if not shared.Glory.skins.weapons["[TacticalShotgun]"] then shared.Glory.skins.weapons["[TacticalShotgun]"] = "" end
if not shared.Glory.skins.weapons["[Shotgun]"] then shared.Glory.skins.weapons["[Shotgun]"] = "" end
if not shared.Glory.skins.weapons["[Revolver]"] then shared.Glory.skins.weapons["[Revolver]"] = "" end
if not shared.Glory.skins.weapons["[Double-Barrel SG]"] then shared.Glory.skins.weapons["[Double-Barrel SG]"] = "" end
if not shared.Glory.skins.weapons["[LMG]"] then shared.Glory.skins.weapons["[LMG]"] = "" end
local skinConfig = shared.Glory
local knifeData = {}
local skinToolRegistry = {}
local selectedSkin = nil

local knifeSkins = {
    ["Golden Age Tanto"] = {soundid = "rbxassetid://5917819099", animationid = "rbxassetid://13473404819", positionoffset = Vector3.new(0, -0.20, -1.2), rotationoffset = Vector3.new(90, 263.7, 180)},
    ["GPO-Knife"] = {soundid = "rbxassetid://4604390759", animationid = "rbxassetid://14014278925", positionoffset = Vector3.new(0, -0.32, -1.07), rotationoffset = Vector3.new(90, -97.4, 90)},
    ["GPO-Knife Prestige"] = {soundid = "rbxassetid://4604390759", animationid = "rbxassetid://14014278925", positionoffset = Vector3.new(0, -0.32, -1.07), rotationoffset = Vector3.new(90, -97.4, 90)},
    ["Heaven"] = {soundid = "rbxassetid://14489860007", animationid = "rbxassetid://14500266726", positionoffset = Vector3.new(-0.02, -0.82, 0.20), rotationoffset = Vector3.new(64.42, 3.79, 0)},
    ["Love Kukri"] = {soundid = "", animationid = "", positionoffset = Vector3.new(-0.14, 0.14, -1.62), rotationoffset = Vector3.new(-90, 180, -4.97), particle = true, textureid = "rbxassetid://12124159284"},
    ["Purple Dagger"] = {soundid = "rbxassetid://17822743153", animationid = "rbxassetid://17824999722", positionoffset = Vector3.new(-0.13, -0.24, -1.80), rotationoffset = Vector3.new(89.05, 96.63, 180)},
    ["Blue Dagger"] = {soundid = "rbxassetid://17822737046", animationid = "rbxassetid://17824995184", positionoffset = Vector3.new(-0.13, -0.24, -1.80), rotationoffset = Vector3.new(89.05, 96.63, 180)},
    ["Green Dagger"] = {soundid = "rbxassetid://17822741762", animationid = "rbxassetid://17825004320", positionoffset = Vector3.new(-0.13, -0.24, -1.07), rotationoffset = Vector3.new(89.05, 96.63, 180)},
    ["Red Dagger"] = {soundid = "rbxassetid://17822952417", animationid = "rbxassetid://17825008844", positionoffset = Vector3.new(-0.13, -0.24, -1.07), rotationoffset = Vector3.new(89.05, 96.63, 180)},
    ["Portal"] = {soundid = "rbxassetid://16058846352", animationid = "rbxassetid://16058633881", positionoffset = Vector3.new(-0.13, -0.35, -0.57), rotationoffset = Vector3.new(89.05, 96.63, 180)},
    ["Emerald Butterfly"] = {soundid = "rbxassetid://14931902491", animationid = "rbxassetid://14918231706", positionoffset = Vector3.new(-0.02, -0.30, -0.65), rotationoffset = Vector3.new(180, 90.95, 180)},
    ["Boy"] = {soundid = "rbxassetid://18765078331", animationid = "rbxassetid://18789158908", positionoffset = Vector3.new(-0.02, -0.09, -0.73), rotationoffset = Vector3.new(89.05, -88.11, 180)},
    ["Girl"] = {soundid = "rbxassetid://18765078331", animationid = "rbxassetid://18789162944", positionoffset = Vector3.new(-0.02, -0.16, -0.73), rotationoffset = Vector3.new(89.05, -88.11, 180)},
    ["Dragon"] = {soundid = "rbxassetid://14217789230", animationid = "rbxassetid://14217804400", positionoffset = Vector3.new(-0.02, -0.32, -0.98), rotationoffset = Vector3.new(89.05, 90.95, 180)},
    ["Void"] = {soundid = "rbxassetid://14756591763", animationid = "rbxassetid://14774699952", positionoffset = Vector3.new(-0.02, -0.22, -0.85), rotationoffset = Vector3.new(180, 90.95, 180)},
    ["Wild West"] = {soundid = "rbxassetid://16058689026", animationid = "rbxassetid://16058148839", positionoffset = Vector3.new(-0.02, -0.24, -1.15), rotationoffset = Vector3.new(-91.89, 90.95, 180)},
    ["Iced Out"] = {soundid = "rbxassetid://14924261405", animationid = "rbxassetid://18465353361", positionoffset = Vector3.new(0.02, -0.08, 0.99), rotationoffset = Vector3.new(180, -90.95, -180)},
    ["Reptile"] = {soundid = "rbxassetid://18765103349", animationid = "rbxassetid://18788955930", positionoffset = Vector3.new(-0.03, -0.06, -0.92), rotationoffset = Vector3.new(168.63, 90, -180)},
    ["Emerald"] = {soundid = "", animationid = "", positionoffset = Vector3.new(-0.03, -0.06, -0.92), rotationoffset = Vector3.new(168.63, 90, 108)},
    ["Ribbon"] = {soundid = "rbxassetid://130974579277249", animationid = "rbxassetid://124102609796063", positionoffset = Vector3.new(0.02, -0.25, -0.05), rotationoffset = Vector3.new(90, 0, 180)},
}

local function getEquippedSkinTool()
    local character = LocalPlayer.Character
    if not character then return nil end
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Tool") then return child end
    end
end

local function cleanKnife(tool)
    if not tool then return end
    local data = knifeData[tool]
    if data then
        if data.track then pcall(function() data.track:Stop(); data.track:Destroy() end) end
        for _, object in ipairs(data.welds or {}) do pcall(function() object:Destroy() end) end
        for _, object in ipairs(data.sounds or {}) do pcall(function() object:Destroy() end) end
    end
    local mesh = tool:FindFirstChild("Default")
    if mesh then
        for _, child in ipairs(mesh:GetChildren()) do
            if child.Name == "Handle.R" or child:IsA("Model") or (child:IsA("BasePart") and child.Name ~= "Default") then pcall(function() child:Destroy() end) end
        end
        mesh.Transparency = 0
    end
    knifeData[tool] = nil
    tool:SetAttribute("CurrentKnifeSkin", nil)
end

local function applyKnife(character, tool, skin)
    local skinSettings = knifeSkins[skin]
    if not skinSettings or not character or not tool then return false end
    if tool:GetAttribute("CurrentKnifeSkin") == skin and knifeData[tool] then
        return true
    end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
    local modules = ReplicatedStorage:FindFirstChild("SkinModules")
    local knives = modules and modules:FindFirstChild("Knives")
    local skinModel = knives and knives:FindFirstChild(skin)
    local mesh = tool:FindFirstChild("Default")
    if not humanoid or not rightHand or not skinModel or not mesh then return false end
    cleanKnife(tool)
    knifeData[tool] = {welds = {}, sounds = {}}
    local data = knifeData[tool]
    mesh.Transparency = 1

    local handPart = Instance.new("Part")
    handPart.Name = "Handle.R"
    handPart.Size = Vector3.new(0.001, 0.001, 0.001)
    handPart.Transparency = 1
    handPart.CanCollide = false
    handPart.Massless = true
    handPart.Parent = mesh
    local motor = Instance.new("Motor6D")
    motor.Name = "Handle.R"
    motor.Part0 = rightHand
    motor.Part1 = handPart
    motor.Parent = handPart

    local offset = CFrame.new(skinSettings.positionoffset) * CFrame.Angles(math.rad(skinSettings.rotationoffset.X), math.rad(skinSettings.rotationoffset.Y), math.rad(skinSettings.rotationoffset.Z))
    local clone = skinModel:Clone()
    clone.Name = skin
    if clone:IsA("Model") then
        clone.PrimaryPart = clone.PrimaryPart or clone:FindFirstChildWhichIsA("BasePart", true)
        if clone.PrimaryPart then
            for _, part in ipairs(clone:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    part.Massless = true
                    part.Anchored = false
                    local weld = Instance.new("Weld")
                    weld.Part0 = handPart
                    weld.Part1 = part
                    weld.C0 = offset
                    weld.C1 = part.CFrame:ToObjectSpace(clone.PrimaryPart.CFrame)
                    weld.Parent = part
                    table.insert(data.welds, weld)
                end
            end
        end
    elseif clone:IsA("BasePart") then
        clone.CanCollide = false
        clone.Massless = true
        clone.Anchored = false
        if clone:IsA("MeshPart") and skinSettings.textureid then clone.TextureID = skinSettings.textureid end
        if skinSettings.particle then
            local skinAssets = ReplicatedStorage:FindFirstChild("SkinAssets")
            local particleFolder = skinAssets and skinAssets:FindFirstChild("GunHandleParticle")
            local particleSource = particleFolder and particleFolder:FindFirstChild(skin)
            local particle = particleSource and particleSource:FindFirstChild("ParticleEmitter")
            if particle then particle:Clone().Parent = clone end
        end
        local weld = Instance.new("Weld")
        weld.Part0 = handPart
        weld.Part1 = clone
        weld.C0 = offset
        weld.Parent = clone
        table.insert(data.welds, weld)
    end
    clone.Parent = mesh

    if skinSettings.animationid and skinSettings.animationid ~= "" then
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator")
        animator.Parent = humanoid
        local animation = Instance.new("Animation")
        animation.AnimationId = skinSettings.animationid
        local track = animator:LoadAnimation(animation)
        track.Looped = false
        track:Play()
        data.track = track
        animation:Destroy()
    end
    if skinSettings.soundid and skinSettings.soundid ~= "" then
        local sound = Instance.new("Sound")
        sound.SoundId = skinSettings.soundid
        sound.Parent = Workspace
        sound:Play()
        table.insert(data.sounds, sound)
        sound.Ended:Connect(function() pcall(function() sound:Destroy() end) end)
    end
    tool:SetAttribute("CurrentKnifeSkin", skin)
    return true
end

local function getSavedSkin(toolName)
    if not skinConfig or not skinConfig.skins or not skinConfig.skins.enabled then return nil end
    local skin = skinConfig.skins.weapons and skinConfig.skins.weapons[toolName]
    if typeof(skin) ~= "string" or skin == "" then return nil end
    return skin
end

local function applySavedSkinToTool(tool, force)
    if not tool or not tool:IsA("Tool") then return end
    local skin = getSavedSkin(tool.Name)
    if not skin then return end

    -- Guns can be skinned in backpack; knife only when equipped
    if tool.Name == "[Knife]" then
        local char = LocalPlayer.Character
        if char and tool.Parent == char then
            pcall(function() applyKnife(char, tool, skin) end)
        end
        return
    end

    -- Retry a few times — after reset tools / meshes may not be ready yet
    task.spawn(function()
        for attempt = 1, 6 do
            if not tool.Parent then return end
            local ok = false
            pcall(function() ok = applygun(tool, skin) end)
            if ok then return end
            task.wait(0.1 * attempt)
        end
    end)
end

local function setupSkinTool(tool)
    if not tool:IsA("Tool") or skinToolRegistry[tool] then return end
    skinToolRegistry[tool] = true

    tool.Equipped:Connect(function()
        if not skinConfig.skins.enabled then return end
        local skin = getSavedSkin(tool.Name)
        if not skin then return end
        task.defer(function()
            -- wait so character hand / mesh exist
            task.wait(0.08)
            if tool.Parent ~= LocalPlayer.Character then return end
            if tool.Name == "[Knife]" then
                pcall(function() applyKnife(LocalPlayer.Character, tool, skin) end)
            else
                -- re-apply every equip so reset/server copies stay skinned
                pcall(function() applygun(tool, skin) end)
            end
        end)
    end)

    tool.Unequipped:Connect(function()
        if tool.Name == "[Knife]" then
            pcall(function() cleanKnife(tool) end)
        end
    end)

    -- If already equipped when we hook up (common on respawn), apply now
    if tool.Parent == LocalPlayer.Character then
        applySavedSkinToTool(tool, true)
    elseif tool.Parent == LocalPlayer:FindFirstChild("Backpack") then
        -- Pre-skin guns in backpack so they stay after reset
        if tool.Name ~= "[Knife]" then
            applySavedSkinToTool(tool, true)
        end
    end
end

local function watchSkinCharacter(character)
    if not character then return end
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Tool") then setupSkinTool(child) end
    end
    character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            setupSkinTool(child)
            -- ChildAdded happens on equip AFTER Equipped sometimes — force apply
            task.defer(function()
                task.wait(0.1)
                if child.Parent == character then
                    applySavedSkinToTool(child, true)
                end
            end)
        end
    end)
end

local function watchSkinBackpack(backpack)
    if not backpack then return end
    for _, child in ipairs(backpack:GetChildren()) do
        if child:IsA("Tool") then setupSkinTool(child) end
    end
    backpack.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            setupSkinTool(child)
            -- New tool after reset — apply saved gun skin immediately
            task.defer(function()
                task.wait(0.15)
                if child.Parent then
                    applySavedSkinToTool(child, true)
                end
            end)
        end
    end)
end

local function refreshSkinTools()
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then watchSkinBackpack(bp) end
    if LocalPlayer.Character then watchSkinCharacter(LocalPlayer.Character) end
end

-- Keep watching backpack across respawns (Backpack is recreated sometimes)
LocalPlayer.ChildAdded:Connect(function(child)
    if child.Name == "Backpack" and child:IsA("Backpack") then
        task.defer(function()
            task.wait(0.1)
            watchSkinBackpack(child)
        end)
    end
end)

if LocalPlayer:FindFirstChild("Backpack") then
    watchSkinBackpack(LocalPlayer.Backpack)
end
if LocalPlayer.Character then
    watchSkinCharacter(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(function(char)
    -- Clear old knife weld data for destroyed tools
    for tool in pairs(knifeData) do
        if not tool.Parent then
            knifeData[tool] = nil
        end
    end
    -- skinToolRegistry: drop dead tool refs so new instances can register
    for tool in pairs(skinToolRegistry) do
        if not tool.Parent then
            skinToolRegistry[tool] = nil
        end
    end
    task.defer(function()
        task.wait(0.2)
        watchSkinCharacter(char)
        local bp = LocalPlayer:FindFirstChild("Backpack")
        if bp then watchSkinBackpack(bp) end
        -- Re-apply all saved gun skins on tools that already exist
        if bp then
            for _, t in ipairs(bp:GetChildren()) do
                if t:IsA("Tool") then applySavedSkinToTool(t, true) end
            end
        end
        for _, t in ipairs(char:GetChildren()) do
            if t:IsA("Tool") then applySavedSkinToTool(t, true) end
        end
    end)
end)
refreshSkinTools()

local BULLET_COLORS = {
    ["Galaxy"] = Color3.fromRGB(107, 96, 255),
    ["Electric"] = Color3.fromRGB(0, 255, 255),
    ["Luck"] = Color3.fromRGB(80, 255, 120),
    ["Snow"] = Color3.fromRGB(220, 240, 255),
    ["Heaven"] = Color3.fromRGB(255, 245, 200),
    ["Dragon"] = Color3.fromRGB(255, 90, 40),
    ["Void"] = Color3.fromRGB(120, 60, 200),
    ["Portal"] = Color3.fromRGB(160, 80, 255),
    ["Ribbon"] = Color3.fromRGB(255, 140, 200),
    ["Love Kukri"] = Color3.fromRGB(255, 100, 160),
}

local function isFX(inst)
    return inst:IsA("ParticleEmitter") or inst:IsA("Fire") or inst:IsA("Smoke")
        or inst:IsA("Sparkles") or inst:IsA("Trail") or inst:IsA("Beam")
end

local function clearAllSkinFX(tool)
    if not tool then return end
    local toDestroy = {}
    for _, v in ipairs(tool:GetDescendants()) do
        if isFX(v) or (v:IsA("Attachment") and v:GetAttribute("SaturnSkinFX")) then
            table.insert(toDestroy, v)
        end
    end
    for _, v in ipairs(toDestroy) do pcall(function() v:Destroy() end) end
end

local function clearmesh(tool, exclude)
    if not tool then return end
    for _, v in ipairs(tool:GetChildren()) do
        if v ~= exclude and (v.Name == "CurrentSkin" or v:GetAttribute("SaturnSkin")
            or (v:IsA("MeshPart") and v.Name ~= "Handle" and v.Name ~= "Default")
            or (v:IsA("Model") and v.Name ~= "Default")) then
            pcall(function() v:Destroy() end)
        end
    end
    clearAllSkinFX(tool)
end

local function applyBulletColor(tool, skinName, info)
    if not tool then return end
    local bulletCol = nil
    if info then
        local c = info.BulletColor or info.ShootColor or info.Color or info.BeamColor
        if typeof(c) == "Color3" then bulletCol = c end
        if typeof(c) == "ColorSequence" and c.Keypoints and c.Keypoints[1] then bulletCol = c.Keypoints[1].Value end
    end
    if not bulletCol and skinName then
        bulletCol = BULLET_COLORS[skinName]
        if not bulletCol then
            local lower = string.lower(skinName)
            for n, col in pairs(BULLET_COLORS) do
                if string.lower(n) == lower then bulletCol = col break end
            end
        end
    end
    if typeof(bulletCol) ~= "Color3" then return end
    pcall(function()
        tool:SetAttribute("BulletColor", bulletCol)
        tool:SetAttribute("ShootColor", bulletCol)
        for _, v in ipairs(tool:GetDescendants()) do
            local n = string.lower(v.Name)
            if v:IsA("Color3Value") and (n:find("bullet") or n:find("shoot") or n == "color") then
                v.Value = bulletCol
            elseif v:IsA("Beam") or v:IsA("Trail") then
                v.Color = ColorSequence.new(bulletCol)
            elseif v:IsA("ParticleEmitter") and (n:find("bullet") or n:find("muzzle") or n:find("shoot")) then
                v.Color = ColorSequence.new(bulletCol)
            end
        end
    end)
end

local function rememberDefaultGunSounds(tool)
    if not tool then return end
    local handle = tool:FindFirstChild("Handle")
    if not handle then return end
    for _, s in ipairs(handle:GetDescendants()) do
        if s:IsA("Sound") then
            local key = "SaturnDefaultSound_" .. s.Name
            if not tool:GetAttribute(key) then
                tool:SetAttribute(key, s.SoundId)
            end
        end
    end
    -- also common shoot sounds on tool root
    for _, s in ipairs(tool:GetChildren()) do
        if s:IsA("Sound") then
            local key = "SaturnDefaultSound_" .. s.Name
            if not tool:GetAttribute(key) then
                tool:SetAttribute(key, s.SoundId)
            end
        end
    end
end

local function restoreDefaultGunSounds(tool)
    if not tool then return end
    local function restoreOn(parent)
        if not parent then return end
        for _, s in ipairs(parent:GetDescendants()) do
            if s:IsA("Sound") then
                local key = "SaturnDefaultSound_" .. s.Name
                local def = tool:GetAttribute(key)
                if typeof(def) == "string" and def ~= "" then
                    pcall(function() s.SoundId = def end)
                end
            end
        end
        for _, s in ipairs(parent:GetChildren()) do
            if s:IsA("Sound") then
                local key = "SaturnDefaultSound_" .. s.Name
                local def = tool:GetAttribute(key)
                if typeof(def) == "string" and def ~= "" then
                    pcall(function() s.SoundId = def end)
                end
            end
        end
    end
    restoreOn(tool:FindFirstChild("Handle"))
    restoreOn(tool)
end

local function applyGunShootSound(tool, skinName)
    if not tool then return end
    rememberDefaultGunSounds(tool)
    -- ALWAYS reset to defaults first so old skin sound never sticks
    restoreDefaultGunSounds(tool)

    local handle = tool:FindFirstChild("Handle")
    if not handle then return end

    local skinassets = ReplicatedStorage:FindFirstChild("SkinAssets")
    local gunsounds = skinassets and skinassets:FindFirstChild("GunShootSounds")
    local soundsFolder = gunsounds and gunsounds:FindFirstChild(tool.Name)
    if not soundsFolder then return end

    local obj = soundsFolder:FindFirstChild(skinName)
    if not obj then
        for _, ch in ipairs(soundsFolder:GetChildren()) do
            if string.lower(ch.Name) == string.lower(skinName) then
                obj = ch
                break
            end
        end
    end
    if not obj then return end -- keep defaults (already restored)

    local newId = nil
    if obj:IsA("StringValue") or obj:IsA("Sound") then
        newId = obj.Value or obj.SoundId
    elseif typeof(obj) == "Instance" and obj:GetAttribute("SoundId") then
        newId = obj:GetAttribute("SoundId")
    end
    if typeof(newId) ~= "string" or newId == "" then return end

    -- apply only to shoot-like sounds
    local function maybeSet(snd)
        if not snd or not snd:IsA("Sound") then return end
        local n = string.lower(snd.Name)
        if n:find("shoot") or n:find("fire") or n:find("gun") or n == "sound" or n:find("blast") then
            snd.SoundId = newId
        end
    end
    maybeSet(handle:FindFirstChild("ShootSound"))
    maybeSet(handle:FindFirstChild("FireSound"))
    maybeSet(handle:FindFirstChild("GunSound"))
    for _, s in ipairs(handle:GetChildren()) do
        if s:IsA("Sound") then maybeSet(s) end
    end
end

local function applygun(tool, name)
    if not name or name == "" or not tool then return false end
    local handle = tool:FindFirstChild("Handle")
    local orig = tool:FindFirstChildOfClass("MeshPart") or tool:FindFirstChildWhichIsA("MeshPart")
        or (handle and handle:IsA("MeshPart") and handle) or handle
    if not orig then return false end
    local skinmodules = ReplicatedStorage:FindFirstChild("SkinModules")
    if not skinmodules then return false end
    local ok, skinmodulesreq = pcall(function() return require(skinmodules) end)
    if not ok or not skinmodulesreq then return false end
    local toolData = skinmodulesreq[tool.Name]
    if not toolData then return false end
    local info = toolData[name]
    if not info then
        for skinName, skinInfo in pairs(toolData) do
            if string.lower(tostring(skinName)) == string.lower(name) then
                info = skinInfo; name = skinName; break
            end
        end
    end
    if not info then return false end

    rememberDefaultGunSounds(tool)
    clearmesh(tool, orig)

    if handle then
        for _, existing in ipairs(handle:GetChildren()) do
            if existing:IsA("ParticleEmitter") or existing:GetAttribute("SaturnSkinFX") then
                pcall(function() existing:Destroy() end)
            end
        end
    end

    local skinpart = info.TextureID
    if typeof(skinpart) == "Instance" then
        local clone = skinpart:Clone()
        clone.Name = "CurrentSkin"
        clone:SetAttribute("SaturnSkin", true)
        clone.Parent = tool
        if clone:IsA("BasePart") and orig:IsA("BasePart") then
            clone.CFrame = orig.CFrame
            local w = Instance.new("Weld")
            w.Part0 = clone
            w.Part1 = orig
            if info.CFrame then w.C0 = info.CFrame:Inverse() end
            w.Parent = clone
            orig.Transparency = 1
        end
    elseif typeof(skinpart) == "string" and orig:IsA("MeshPart") then
        orig.TextureID = skinpart
        orig.Transparency = 0
    end

    -- force sound swap: reset defaults then apply this skin's sound only if it has one
    applyGunShootSound(tool, name)

    if handle then
        local skinassets = ReplicatedStorage:FindFirstChild("SkinAssets")
        local pf = skinassets and skinassets:FindFirstChild("GunHandleParticle")
        local src = pf and pf:FindFirstChild(name)
        if not src and pf then
            for _, ch in ipairs(pf:GetChildren()) do
                if string.lower(ch.Name) == string.lower(name) then src = ch break end
            end
        end
        if src then
            for _, pe in ipairs(src:GetDescendants()) do
                if pe:IsA("ParticleEmitter") then
                    local c = pe:Clone()
                    c:SetAttribute("SaturnSkinFX", true)
                    c.Parent = handle
                end
            end
        end
        handle:SetAttribute("SkinName", name)
    end
    applyBulletColor(tool, name, info)
    tool:SetAttribute("CurrentGunSkin", name)
    return true
end

-- ==================== SKIN PERSIST (knife-style: re-apply after reset/equip) ====================
-- Knife works because applyKnife runs again every Equipped.
-- Guns get fresh tools after reset; we must re-apply the saved name the same way.

local function getSavedWeaponSkin(toolName)
    if not skinConfig or not skinConfig.skins then return nil end
    if skinConfig.skins.enabled == false then return nil end
    local w = skinConfig.skins.weapons
    if not w then return nil end
    local skin = w[toolName]
    if typeof(skin) == "string" and skin ~= "" then return skin end
    return nil
end

local function toolNeedsGunSkin(tool, skin)
    if not tool then return false end
    if tool:GetAttribute("CurrentGunSkin") == skin and tool:FindFirstChild("CurrentSkin") then
        return false
    end
    -- Texture-only skins may not have CurrentSkin child
    if tool:GetAttribute("CurrentGunSkin") == skin then
        local handle = tool:FindFirstChild("Handle")
        if handle and handle:GetAttribute("SkinName") == skin then
            return false
        end
    end
    return true
end

local function applySkinKnifeStyle(tool, force)
    if not tool or not tool:IsA("Tool") then return end
    local skin = getSavedWeaponSkin(tool.Name)
    if not skin then return end

    if tool.Name == "[Knife]" then
        local char = LocalPlayer.Character
        if char and tool.Parent == char then
            -- knife: always re-apply on equip (same as original knife path)
            pcall(function() applyKnife(char, tool, skin) end)
        end
        return
    end

    -- Guns: force on equip/reset; otherwise only if skin missing
    if force or toolNeedsGunSkin(tool, skin) then
        pcall(function() applygun(tool, skin) end)
    end
end

-- Re-bind Equipped on every tool with delayed multi-apply (matches knife reliability)
local skinHooked = setmetatable({}, { __mode = "k" })

local function hookToolSkinPersist(tool)
    if not tool or not tool:IsA("Tool") or skinHooked[tool] then return end
    skinHooked[tool] = true

    if tool.Name == "[Knife]" then
        return
    end

    tool.Equipped:Connect(function()
        -- Knife-style: apply several times after equip (meshes/replicate lag after reset)
        task.spawn(function()
            for _, delayTime in ipairs({ 0.05, 0.15, 0.35, 0.7, 1.2 }) do
                task.wait(delayTime)
                if not tool.Parent then return end
                if tool.Parent == LocalPlayer.Character or tool.Parent == LocalPlayer:FindFirstChild("Backpack") then
                    applySkinKnifeStyle(tool, true)
                end
            end
        end)
    end)

    -- Apply once as soon as we see the tool (backpack after reset)
    task.defer(function()
        task.wait(0.1)
        if tool.Parent then
            applySkinKnifeStyle(tool, true)
        end
    end)
end

local function scanAllToolsForSkins()
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") then
                hookToolSkinPersist(t)
                applySkinKnifeStyle(t, true)
            end
        end
    end
    local char = LocalPlayer.Character
    if char then
        for _, t in ipairs(char:GetChildren()) do
            if t:IsA("Tool") then
                hookToolSkinPersist(t)
                applySkinKnifeStyle(t, true)
            end
        end
    end
end

-- Watch backpack + character forever
local function bindContainer(container)
    if not container then return end
    for _, t in ipairs(container:GetChildren()) do
        if t:IsA("Tool") then hookToolSkinPersist(t) end
    end
    container.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            hookToolSkinPersist(child)
            task.defer(function()
                task.wait(0.05)
                applySkinKnifeStyle(child, true)
            end)
        end
    end)
end

if LocalPlayer:FindFirstChild("Backpack") then
    bindContainer(LocalPlayer.Backpack)
end
LocalPlayer.ChildAdded:Connect(function(c)
    if c.Name == "Backpack" then
        task.defer(function()
            task.wait(0.05)
            bindContainer(c)
            scanAllToolsForSkins()
        end)
    end
end)
if LocalPlayer.Character then
    bindContainer(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(function(char)
    task.defer(function()
        task.wait(0.25)
        bindContainer(char)
        local bp = LocalPlayer:FindFirstChild("Backpack")
        if bp then bindContainer(bp) end
        scanAllToolsForSkins()
        -- extra passes after reset (tools often spawn late)
        for _, w in ipairs({ 0.5, 1.0, 2.0 }) do
            task.wait(w)
            scanAllToolsForSkins()
        end
    end)
end)

-- Keep skins on while equipped (game sometimes strips TextureID)
task.spawn(function()
    while not _G.AdisKilled do
        task.wait(0.4)
        local char = LocalPlayer.Character
        if char then
        for _, t in ipairs(char:GetChildren()) do
            if t:IsA("Tool") then
                local skin = getSavedWeaponSkin(t.Name)
                if skin and t.Name ~= "[Knife]" and toolNeedsGunSkin(t, skin) then
                    pcall(function() applygun(t, skin) end)
                elseif skin and t.Name == "[Knife]" then
                    if t:GetAttribute("CurrentKnifeSkin") ~= skin then
                        pcall(function() applyKnife(char, t, skin) end)
                    end
                end
            end
        end
        end
        local bp = LocalPlayer:FindFirstChild("Backpack")
        if bp then
            for _, t in ipairs(bp:GetChildren()) do
                if t:IsA("Tool") and t.Name ~= "[Knife]" then
                    local skin = getSavedWeaponSkin(t.Name)
                    if skin and toolNeedsGunSkin(t, skin) then
                        pcall(function() applygun(t, skin) end)
                    end
                end
            end
        end
    end
end)

scanAllToolsForSkins()


local function RenderWorkspacePanels(leftTitle, rightTitle)
    PanelingSection:ClearAllChildren()
    local theme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]

    local PanelLeft = Instance.new("Frame")
    PanelLeft.Name = "PanelLeft"
    PanelLeft.Size = UDim2.new(0.5, -7, 1, 0)
    PanelLeft.BackgroundColor3 = theme.SectionBg
    PanelLeft.BorderColor3 = theme.BorderColor
    PanelLeft.BorderSizePixel = 1
    PanelLeft.Parent = PanelingSection

    local LeftTitleLabel = Instance.new("TextLabel")
    LeftTitleLabel.Size = UDim2.new(0, 110, 0, 14)
    LeftTitleLabel.Position = UDim2.new(0.5, -55, 0, -7)
    LeftTitleLabel.BackgroundColor3 = theme.SectionBg
    LeftTitleLabel.Text = leftTitle
    LeftTitleLabel.TextColor3 = theme.DimTextColor
    LeftTitleLabel.TextSize = 15
    LeftTitleLabel.Font = Enum.Font.IndieFlower
    LeftTitleLabel.Parent = PanelLeft

    local PanelRight = Instance.new("Frame")
    PanelRight.Name = "PanelRight"
    PanelRight.Size = UDim2.new(0.5, -7, 1, 0)
    PanelRight.Position = UDim2.new(0.5, 7, 0, 0)
    PanelRight.BackgroundColor3 = theme.SectionBg
    PanelRight.BorderColor3 = theme.BorderColor
    PanelRight.BorderSizePixel = 1
    PanelRight.Parent = PanelingSection

    local RightTitleLabel = Instance.new("TextLabel")
    RightTitleLabel.Size = UDim2.new(0, 90, 0, 14)
    RightTitleLabel.Position = UDim2.new(0.5, -45, 0, -7)
    RightTitleLabel.BackgroundColor3 = theme.SectionBg
    RightTitleLabel.Text = rightTitle
    RightTitleLabel.TextColor3 = theme.DimTextColor
    RightTitleLabel.TextSize = 15
    RightTitleLabel.Font = Enum.Font.IndieFlower
    RightTitleLabel.Parent = PanelRight

    local LeftContent = ClearPanel(PanelLeft)
    local RightContent = ClearPanel(PanelRight)

    if leftTitle == "Silent Aim" then
        CreateToggle(LeftContent, "Silent Aim", _G.SilentAim_Enabled, function()
            _G.SilentAim_Enabled = not _G.SilentAim_Enabled
            _G.SilentAimEnabled = _G.SilentAim_Enabled
            return _G.SilentAim_Enabled
        end)
        CreateToggle(LeftContent, "Show FOV", _G.ShowFOV, function()
            _G.ShowFOV = not _G.ShowFOV; return _G.ShowFOV
        end)
        CreateToggle(LeftContent, "Revolver Bypass", _G.RevolverBypass, function()
            _G.RevolverBypass = not _G.RevolverBypass; return _G.RevolverBypass
        end)
        CreateToggle(LeftContent, "Wall Check", _G.WallCheck, function()
            _G.WallCheck = not _G.WallCheck; return _G.WallCheck
        end)
        CreateToggle(LeftContent, "Knock Check", _G.KnockCheck, function()
            _G.KnockCheck = not _G.KnockCheck; return _G.KnockCheck
        end)
        CreateSlider(LeftContent, "FOV Radius", 0, 1000, _G.FOV_RADIUS, function(v) _G.FOV_RADIUS = v end)
        CreateSlider(LeftContent, "Bullet Spread", 0, 100, _G.BulletSpreadAmount, function(v) _G.BulletSpreadAmount = v end)
        CreateDropdown(LeftContent, "Hit Part", AllHitPartOptions, aimPart, function(v) aimPart = v end)

        CreateToggle(RightContent, "Old Aim Enabled", _G.OldAimEnabled, function()
            _G.OldAimEnabled = not _G.OldAimEnabled
            enableOldAim(_G.OldAimEnabled)
            return _G.OldAimEnabled
        end)
        CreateToggle(RightContent, "Old Show FOV", _G.OldAimShowFOV, function()
            _G.OldAimShowFOV = not _G.OldAimShowFOV; return _G.OldAimShowFOV
        end)
        CreateToggle(RightContent, "Old Closest Part", _G.OldAimClosestPart, function()
            _G.OldAimClosestPart = not _G.OldAimClosestPart; return _G.OldAimClosestPart
        end)
        CreateToggle(RightContent, "Old Wall Check", _G.OldAimWallCheck, function()
            _G.OldAimWallCheck = not _G.OldAimWallCheck; return _G.OldAimWallCheck
        end)
        CreateToggle(RightContent, "Old Knock Check", _G.OldAimKnockCheck, function()
            _G.OldAimKnockCheck = not _G.OldAimKnockCheck; return _G.OldAimKnockCheck
        end)
        CreateToggle(RightContent, "Use Old Keybind", _G.OldAimUseKeybind, function()
            _G.OldAimUseKeybind = not _G.OldAimUseKeybind; return _G.OldAimUseKeybind
        end)

        CreateSlider(RightContent, "Old FOV", 0, 1000, _G.OldAimFOVRadius, function(v) _G.OldAimFOVRadius = v end)
        CreateSlider(RightContent, "Old Hit Chance", 0, 100, _G.OldAimHitChance, function(v) _G.OldAimHitChance = v end)
        CreateSlider(RightContent, "Max Distance", 0, 1000, _G.OldAimMaxDistance, function(v) _G.OldAimMaxDistance = v end)
        CreateDropdown(RightContent, "Old Hit Part", AllHitPartOptions, _G.OldAimHitPart, function(v) _G.OldAimHitPart = v end)
        CreateSlider(RightContent, "Offset X", -20, 20, _G.OldAimOffsetX, function(v) _G.OldAimOffsetX = v end)
        CreateSlider(RightContent, "Offset Y", -20, 20, _G.OldAimOffsetY, function(v) _G.OldAimOffsetY = v end)
        CreateSlider(RightContent, "Offset Z", -20, 20, _G.OldAimOffsetZ, function(v) _G.OldAimOffsetZ = v end)
        CreateSlider(RightContent, "Pred X", 0, 1, _G.OldAimPredictionX, function(v) _G.OldAimPredictionX = v end, true)
        CreateSlider(RightContent, "Pred Y", 0, 1, _G.OldAimPredictionY, function(v) _G.OldAimPredictionY = v end, true)
        CreateSlider(RightContent, "Pred Z", 0, 1, _G.OldAimPredictionZ, function(v) _G.OldAimPredictionZ = v end, true)
        CreateKeybind(RightContent, "Old Toggle Key", _G.OldAimToggleKey, function(k) _G.OldAimToggleKey = k end)
    elseif leftTitle == "Trigger Bot" then
        CreateToggle(LeftContent, "Trigger Bot", TriggerBot.MasterEnabled, function()
            TriggerBot.MasterEnabled = not TriggerBot.MasterEnabled
            if not TriggerBot.MasterEnabled then
                TriggerBot.Active = false  -- force off when master is turned off
            end
            return TriggerBot.MasterEnabled
        end)
        CreateSlider(LeftContent, "Delay", 0, 0.5, TriggerBot.Delay, function(v) TriggerBot.Delay = v end, true)
        CreateKeybind(LeftContent, "Toggle Key", TriggerBot.Key, function(key) TriggerBot.Key = key end)
    elseif leftTitle == "Hood Customs" then
        CreateToggle(LeftContent, "HC Silent Aim", _G.HCSilentAimEnabled, function()
            _G.HCSilentAimEnabled = not _G.HCSilentAimEnabled
            enableHCSilentAim(_G.HCSilentAimEnabled)
            return _G.HCSilentAimEnabled
        end)
        CreateToggle(LeftContent, "HC Show FOV", _G.HCShowFOV, function()
            _G.HCShowFOV = not _G.HCShowFOV
            return _G.HCShowFOV
        end)
        CreateToggle(LeftContent, "HC Revolver Bypass", _G.HCRevolverBypass, function()
            _G.HCRevolverBypass = not _G.HCRevolverBypass; return _G.HCRevolverBypass
        end)
        CreateToggle(LeftContent, "HC Wall Check", _G.HCWallCheck, function()
            _G.HCWallCheck = not _G.HCWallCheck; return _G.HCWallCheck
        end)
        CreateToggle(LeftContent, "HC Knock Check", _G.HCKnockCheck, function()
            _G.HCKnockCheck = not _G.HCKnockCheck; return _G.HCKnockCheck
        end)
        CreateSlider(LeftContent, "HC FOV Radius", 0, 1000, _G.HCFOVRadius, function(v) _G.HCFOVRadius = v end)
        CreateDropdown(LeftContent, "HC Hit Part", AllHitPartOptions, _G.HCHitPart, function(v) _G.HCHitPart = v end)
        CreateToggle(LeftContent, "HC Prediction", _G.HCPrediction, function()
            _G.HCPrediction = not _G.HCPrediction; return _G.HCPrediction
        end)
        CreateSlider(LeftContent, "HC Pred Amount", 0, 0.5, _G.HCPredictionAmount, function(v) _G.HCPredictionAmount = v end, true)
        CreateToggle(LeftContent, "HC Godmode", _G.HCGodmodeEnabled, function()
            _G.HCGodmodeEnabled = not _G.HCGodmodeEnabled
            if _G.HCGodmodeEnabled then HCGodmode_Active = true HCGodmode_Animate() else HCGodmode_Active = false HCGodmode_Stop() end
            return _G.HCGodmodeEnabled
        end)
        CreateToggle(RightContent, "Force Hit", _G.ForceHitEnabled, function()
            _G.ForceHitEnabled = not _G.ForceHitEnabled; return _G.ForceHitEnabled
        end)
        CreateDropdown(RightContent, "FH Mode", {"Fov", "Manual"}, _G.ForceHitMode, function(v) _G.ForceHitMode = v end)
        CreateSlider(RightContent, "FH FOV Radius", 0, 1000, _G.ForceHitFOV, function(v) _G.ForceHitFOV = v end)
        CreateToggle(RightContent, "FH Tracer", _G.ForceHitTracerFalse, function()
            _G.ForceHitTracerEnabled = not _G.ForceHitTracerEnabled; return _G.ForceHitTracerEnabled
        end)
        CreateToggle(RightContent, "FH Full Auto", _G.ForceHitFullAutoEnabled, function()
            _G.ForceHitFullAutoEnabled = not _G.ForceHitFullAutoEnabled; return _G.ForceHitFullAutoEnabled
        end)
        CreateSlider(RightContent, "FH Fire Rate", 0.01, 0.5, _G.ForceHitFireRate, function(v) _G.ForceHitFireRate = v end, true)
    elseif leftTitle == "Hitbox Expander" then
        CreateToggle(LeftContent, "Hitbox Expander", _G.HitboxEnabled, function()
            _G.HitboxEnabled = not _G.HitboxEnabled
            if not _G.HitboxEnabled then
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character then
                        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.Size = Vector3.new(2, 2, 1)
                            hrp.Transparency = 1
                        end
                    end
                end
            end
            return _G.HitboxEnabled
        end)
        CreateSlider(RightContent, "Hitbox Size", 0, 20, _G.HitboxSize, function(v) _G.HitboxSize = v end)
        CreateSlider(RightContent, "Visibility", 0, 1, _G.HitboxTransparency, function(v) _G.HitboxTransparency = v end, true)
    elseif leftTitle == "Flamelock" then
        CreateToggle(LeftContent, "Flamelock", _G.FlamelockEnabled, function()
            _G.FlamelockEnabled = not _G.FlamelockEnabled
            if not _G.FlamelockEnabled then
                _G.FlameActive = false
                flameTargetPart = nil
            end
            return _G.FlamelockEnabled
        end)
        CreateToggle(LeftContent, "Right Click Lock", _G.FlameRightClick, function()
            _G.FlameRightClick = not _G.FlameRightClick; return _G.FlameRightClick
        end)
        CreateDropdown(LeftContent, "Activation Mode", {"Hold", "Toggle"}, _G.FlameMode, function(v) _G.FlameMode = v end)
        CreateKeybind(LeftContent, "Flamelock Key", _G.FlameKey, function(k) _G.FlameKey = k end)
        CreateDropdown(LeftContent, "Hit Part", {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"}, _G.FlameHitPart, function(v) _G.FlameHitPart = v end)
        CreateSlider(RightContent, "Smoothness", 0, 1, _G.FlameSmoothness, function(v) _G.FlameSmoothness = v end, true)
        CreateSlider(RightContent, "Prediction", 0, 0.5, _G.FlamePrediction, function(v) _G.FlamePrediction = v end, true)
        CreateSlider(RightContent, "Left Offset", -5, 5, _G.FlameLeftOffset, function(v) _G.FlameLeftOffset = v end, true)
        CreateSlider(RightContent, "Up Offset", -20, 5, _G.FlameUpOffset, function(v) _G.FlameUpOffset = v end, true)
    elseif leftTitle == "Camlock" then
        CreateToggle(LeftContent, "Camlock Enabled", _G.CamlockEnabled, function()
            _G.CamlockEnabled = not _G.CamlockEnabled
            if not _G.CamlockEnabled then DisableCamlock() end
            return _G.CamlockEnabled
        end)
        CreateToggle(LeftContent, "Auto Toggle (Gun)", _G.CamlockAutoToggle, function()
            _G.CamlockAutoToggle = not _G.CamlockAutoToggle
            return _G.CamlockAutoToggle
        end)
        if not _G.CamlockAutoToggle then
            CreateKeybind(LeftContent, "Toggle Key", getKeyCode(_G.CamlockToggleKey), function(k) _G.CamlockToggleKey = k.Name end)
            CreateDropdown(LeftContent, "Mode", {"Hold", "Toggle"}, _G.CamlockMode, function(v) _G.CamlockMode = v DisableCamlock() end)
        end
        CreateDropdown(LeftContent, "Hit Part", AllHitPartOptions, _G.CamlockHitPart, function(v) _G.CamlockHitPart = v end)
        CreateDropdown(LeftContent, "Closest Point Mode", {"Default", "Basic"}, _G.CamlockClosestPointMode, function(v) _G.CamlockClosestPointMode = v end)
        CreateSlider(LeftContent, "Closest Point Scale", 0, 1, _G.CamlockClosestPointScale, function(v) _G.CamlockClosestPointScale = v end, true)
        CreateSlider(LeftContent, "FOV Radius", 0, 1000, _G.CamlockFOVRadius, function(v) _G.CamlockFOVRadius = v end)
        CreateSlider(LeftContent, "Max Distance", 0, 100000, _G.CamlockMaxDistance, function(v) _G.CamlockMaxDistance = v end)
        CreateDropdown(RightContent, "Easing Style", {"Linear", "Quad", "Sine", "Back", "Elastic", "Bounce"}, _G.CamlockEasingStyle, function(v) _G.CamlockEasingStyle = v end)
        CreateDropdown(RightContent, "Easing Direction", {"In", "Out", "InOut"}, _G.CamlockEasingDirection, function(v) _G.CamlockEasingDirection = v end)
        CreateSlider(RightContent, "Smoothness", 0, 1, _G.CamlockSmoothness, function(v) _G.CamlockSmoothness = v end, true)
        CreateToggle(RightContent, "Pull Strength", _G.CamlockPullStrengthEnabled, function()
            _G.CamlockPullStrengthEnabled = not _G.CamlockPullStrengthEnabled; return _G.CamlockPullStrengthEnabled
        end)
        CreateSlider(RightContent, "Pull Base Value", 0.001, 0.2, _G.CamlockPullStrengthBaseValue, function(v) _G.CamlockPullStrengthBaseValue = v end, true)
        CreateSlider(RightContent, "Pull Move Value", 0.001, 0.2, _G.CamlockPullStrengthMoveValue, function(v) _G.CamlockPullStrengthMoveValue = v end, true)
        CreateToggle(RightContent, "Prediction", _G.CamlockPredictionEnabled, function()
            _G.CamlockPredictionEnabled = not _G.CamlockPredictionEnabled; return _G.CamlockPredictionEnabled
        end)
        CreateSlider(RightContent, "Prediction X", 0.001, 0.1, _G.CamlockPredictionX, function(v) _G.CamlockPredictionX = v end, true)
        CreateSlider(RightContent, "Prediction Y", 0.001, 0.1, _G.CamlockPredictionY, function(v) _G.CamlockPredictionY = v end, true)
        CreateSlider(RightContent, "Prediction Z", 0.001, 0.1, _G.CamlockPredictionZ, function(v) _G.CamlockPredictionZ = v end, true)
        CreateToggle(LeftContent, "Force Field Check", _G.CamlockConditionsForceField, function()
            _G.CamlockConditionsForceField = not _G.CamlockConditionsForceField; return _G.CamlockConditionsForceField
        end)
        CreateToggle(LeftContent, "Visible Check", _G.CamlockConditionsVisible, function()
            _G.CamlockConditionsVisible = not _G.CamlockConditionsVisible; return _G.CamlockConditionsVisible
        end)
        CreateToggle(LeftContent, "Carried Check", _G.CamlockConditionsCarried, function()
            _G.CamlockConditionsCarried = not _G.CamlockConditionsCarried; return _G.CamlockConditionsCarried
        end)
        CreateToggle(LeftContent, "Knocked Check", _G.CamlockConditionsKnocked, function()
            _G.CamlockConditionsKnocked = not _G.CamlockConditionsKnocked; return _G.CamlockConditionsKnocked
        end)
        CreateToggle(LeftContent, "Self Knocked Check", _G.CamlockConditionsSelfKnocked, function()
            _G.CamlockConditionsSelfKnocked = not _G.CamlockConditionsSelfKnocked; return _G.CamlockConditionsSelfKnocked
        end)
    elseif leftTitle == "Whitelist" then
        local SearchRow = Instance.new("Frame", PanelLeft)
        SearchRow.Size = UDim2.new(1, 0, 0, 22)
        SearchRow.Position = UDim2.new(0, 0, 0, 8)
        SearchRow.BackgroundTransparency = 1
        
        local SearchBox = Instance.new("TextBox", SearchRow)
        SearchBox.Size = UDim2.new(1, -20, 0, 20)
        SearchBox.Position = UDim2.new(0, 10, 0, 0)
        SearchBox.BackgroundColor3 = Color3.fromRGB(40, 32, 50)
        SearchBox.BorderColor3 = theme.BorderColor
        SearchBox.PlaceholderText = "Search User ID..."
        SearchBox.Text = whitelistSearchText
        SearchBox.TextColor3 = theme.TextColor
        SearchBox.PlaceholderColor3 = theme.DimTextColor
        SearchBox.Font = Enum.Font.IndieFlower
        SearchBox.TextSize = 14
        SearchBox.ClearTextOnFocus = false

        local ScrollContainer = Instance.new("ScrollingFrame", PanelLeft)
        ScrollContainer.Size = UDim2.new(1, 0, 1, -30)
        ScrollContainer.Position = UDim2.new(0, 0, 0, 32)
        ScrollContainer.BackgroundTransparency = 1
        ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollContainer.ScrollBarThickness = 3
        local ScrollLayout = Instance.new("UIListLayout", ScrollContainer)
        ScrollLayout.Padding = UDim.new(0, 4)
        ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, ScrollLayout.AbsoluteContentSize.Y + 10)
        end)

        local function populateWhitelist()
            for _, child in ipairs(ScrollContainer:GetChildren()) do
                if child ~= ScrollLayout then child:Destroy() end
            end
            local searchQuery = whitelistSearchText:lower()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local playerIdStr = tostring(p.UserId)
                    local playerName = p.Name:lower()
                    local displayName = p.DisplayName:lower()
                    if searchQuery ~= "" and not playerIdStr:find(searchQuery) and not playerName:find(searchQuery) and not displayName:find(searchQuery) then
                        continue
                    end
                    local isWhitelisted = _G.Whitelist[p.UserId] or false
                    local currentTheme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
                    local Row = Instance.new("TextButton", ScrollContainer)
                    Row.Size = UDim2.new(1, -6, 0, 42)
                    Row.BackgroundColor3 = isWhitelisted and currentTheme.HeaderBg or currentTheme.SectionBg
                    Row.BorderColor3 = isWhitelisted and currentTheme.AccentColor or currentTheme.BorderColor
                    Row.BorderSizePixel = 1
                    Row.Text = ""
                    Row.AutoButtonColor = false
                    local Avatar = Instance.new("ImageLabel", Row)
                    Avatar.Size = UDim2.new(0, 32, 0, 32)
                    Avatar.Position = UDim2.new(0, 6, 0.5, -16)
                    Avatar.BackgroundColor3 = currentTheme.BorderColor
                    Avatar.BorderSizePixel = 0
                    Avatar.ScaleType = Enum.ScaleType.Crop
                    task.spawn(function()
                        local ok, image = pcall(function()
                            return Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                        end)
                        if ok and Row.Parent then Avatar.Image = image end
                    end)
                    local Lbl = Instance.new("TextLabel", Row)
                    Lbl.Size = UDim2.new(1, -50, 1, 0)
                    Lbl.Position = UDim2.new(0, 46, 0, 0)
                    Lbl.BackgroundTransparency = 1
                    Lbl.Text = p.DisplayName .. "  @" .. p.Name .. "  (" .. p.UserId .. ")"
                    Lbl.TextColor3 = isWhitelisted and currentTheme.TextColor or currentTheme.DimTextColor
                    Lbl.TextSize = 15
                    Lbl.Font = Enum.Font.IndieFlower
                    Lbl.TextXAlignment = Enum.TextXAlignment.Left
                    Row.MouseButton1Click:Connect(function()
                        _G.Whitelist[p.UserId] = not _G.Whitelist[p.UserId]
                        local newState = _G.Whitelist[p.UserId]
                        local newTheme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
                        Row.BackgroundColor3 = newState and newTheme.HeaderBg or newTheme.SectionBg
                        Row.BorderColor3 = newState and newTheme.AccentColor or newTheme.BorderColor
                        Lbl.TextColor3 = newState and newTheme.TextColor or newTheme.DimTextColor
                    end)
                end
            end
        end

        SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            whitelistSearchText = SearchBox.Text
            populateWhitelist()
        end)

        CreateButton(RightContent, "Refresh List", function()
            whitelistSearchText = ""
            SearchBox.Text = ""
            populateWhitelist()
        end)
        CreateButton(RightContent, "Scan Users", function()
            scanForUsers()
        end)
        populateWhitelist()
        Players.PlayerAdded:Connect(function()
            task.wait(0.5)
            populateWhitelist()
        end)
        Players.PlayerRemoving:Connect(function()
            task.wait(0.1)
            populateWhitelist()
        end)
    elseif leftTitle == "Teleport" then
        local teleportList = Instance.new("ScrollingFrame", PanelLeft)
        teleportList.Size = UDim2.new(1, -10, 1, -12)
        teleportList.Position = UDim2.new(0, 5, 0, 8)
        teleportList.BackgroundTransparency = 1
        teleportList.BorderSizePixel = 0
        teleportList.CanvasSize = UDim2.new(0, 0, 0, 0)
        teleportList.ScrollBarThickness = 3
        local teleportLayout = Instance.new("UIListLayout", teleportList)
        teleportLayout.Padding = UDim.new(0, 4)
        teleportLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            teleportList.CanvasSize = UDim2.new(0, 0, 0, teleportLayout.AbsoluteContentSize.Y + 10)
        end)

        local selectedLabel = Instance.new("TextLabel", PanelRight)
        selectedLabel.Size = UDim2.new(1, -20, 0, 26)
        selectedLabel.Position = UDim2.new(0, 10, 0, 25)
        selectedLabel.BackgroundTransparency = 1
        selectedLabel.TextColor3 = theme.TextColor
        selectedLabel.Font = Enum.Font.IndieFlower
        selectedLabel.TextSize = 15
        selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
        selectedLabel.Text = "Selected: None"

        local function refreshTeleportList()
            for _, child in ipairs(teleportList:GetChildren()) do
                if child ~= teleportLayout then child:Destroy() end
            end
            local currentTheme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local selected = selectedTeleportUserId == p.UserId
                    local row = Instance.new("TextButton", teleportList)
                    row.Size = UDim2.new(1, -6, 0, 42)
                    row.BackgroundColor3 = selected and currentTheme.HeaderBg or currentTheme.SectionBg
                    row.BorderColor3 = selected and currentTheme.AccentColor or currentTheme.BorderColor
                    row.BorderSizePixel = 1
                    row.Text = ""
                    row.AutoButtonColor = false

                    local avatar = Instance.new("ImageLabel", row)
                    avatar.Size = UDim2.new(0, 32, 0, 32)
                    avatar.Position = UDim2.new(0, 6, 0.5, -16)
                    avatar.BackgroundColor3 = currentTheme.BorderColor
                    avatar.BorderSizePixel = 0
                    avatar.ScaleType = Enum.ScaleType.Crop
                    task.spawn(function()
                        local ok, image = pcall(function()
                            return Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                        end)
                        if ok and row.Parent then avatar.Image = image end
                    end)

                    local label = Instance.new("TextLabel", row)
                    label.Size = UDim2.new(1, -50, 1, 0)
                    label.Position = UDim2.new(0, 46, 0, 0)
                    label.BackgroundTransparency = 1
                    label.Text = p.DisplayName .. "  @" .. p.Name
                    label.TextColor3 = selected and currentTheme.TextColor or currentTheme.DimTextColor
                    label.Font = Enum.Font.IndieFlower
                    label.TextSize = 15
                    label.TextXAlignment = Enum.TextXAlignment.Left

                    row.MouseButton1Click:Connect(function()
                        selectedTeleportUserId = selectedTeleportUserId == p.UserId and nil or p.UserId
                        selectedLabel.Text = selectedTeleportUserId and "Selected: " .. p.DisplayName .. "  @" .. p.Name or "Selected: None"
                        refreshTeleportList()
                    end)
                end
            end
        end

        CreateDropdown(PanelRight, "Mode", {"Toggle", "Hold"}, _G.TeleportMode, function(value)
            _G.TeleportMode = value
            stopTeleportLoop()
        end)
        local teleportKeyLabel = Instance.new("TextLabel", PanelRight)
        teleportKeyLabel.Size = UDim2.new(1, -20, 0, 20)
        teleportKeyLabel.Position = UDim2.new(0, 10, 0, 57)
        teleportKeyLabel.BackgroundTransparency = 1
        teleportKeyLabel.Text = "Teleport Toggle Key"
        teleportKeyLabel.TextColor3 = theme.DimTextColor
        teleportKeyLabel.Font = Enum.Font.IndieFlower
        teleportKeyLabel.TextSize = 15
        teleportKeyLabel.TextXAlignment = Enum.TextXAlignment.Left
        teleportKeyLabel.ZIndex = 5

        local teleportKeyButton = Instance.new("TextButton", PanelRight)
        teleportKeyButton.Size = UDim2.new(0, 90, 0, 24)
        teleportKeyButton.Position = UDim2.new(1, -100, 0, 55)
        teleportKeyButton.BackgroundColor3 = theme.HeaderBg
        teleportKeyButton.BorderColor3 = theme.BorderColor
        teleportKeyButton.Text = "[" .. _G.TeleportKey.Name .. "]"
        teleportKeyButton.TextColor3 = theme.TextColor
        teleportKeyButton.Font = Enum.Font.IndieFlower
        teleportKeyButton.TextSize = 15
        teleportKeyButton.ZIndex = 5

        local choosingTeleportKey = false
        teleportKeyButton.MouseButton1Click:Connect(function()
            choosingTeleportKey = true
            teleportKeyButton.Text = "[...]"
        end)

        UIS.InputBegan:Connect(function(input)
            if choosingTeleportKey and input.UserInputType == Enum.UserInputType.Keyboard then
                _G.TeleportKey = input.KeyCode
                teleportKeyButton.Text = "[" .. input.KeyCode.Name .. "]"
                choosingTeleportKey = false
                stopTeleportLoop()
            end
        end)
        CreateButton(PanelRight, "Refresh Players", refreshTeleportList)
        refreshTeleportList()
        Players.PlayerAdded:Connect(function()
            task.wait(0.5)
            refreshTeleportList()
        end)
        Players.PlayerRemoving:Connect(function(player)
            if selectedTeleportUserId == player.UserId then
                selectedTeleportUserId = nil
                selectedLabel.Text = "Selected: None"
            end
            task.wait(0.1)
            refreshTeleportList()
        end)
    elseif leftTitle == "Double Barrel" or leftTitle == "Revolver" or leftTitle == "Tactical"
        or leftTitle == "Shotgun" or leftTitle == "Knife" or leftTitle == "LMG" then

        local toolByTitle = {
            ["Double Barrel"] = "[Double-Barrel SG]",
            ["Revolver"] = "[Revolver]",
            ["Tactical"] = "[TacticalShotgun]",
            ["Shotgun"] = "[Shotgun]",
            ["Knife"] = "[Knife]",
            ["LMG"] = "[LMG]",
        }
        local toolName = toolByTitle[leftTitle]

        CreateToggle(LeftContent, "Skins Enabled", skinConfig.skins.enabled, function()
            skinConfig.skins.enabled = not skinConfig.skins.enabled
            return skinConfig.skins.enabled
        end)

        local function getSkinNamesForTool(tn)
            local names = {}
            if tn == "[Knife]" then
                for name in pairs(knifeSkins) do table.insert(names, name) end
            else
                local skinmodules = ReplicatedStorage:FindFirstChild("SkinModules")
                if skinmodules then
                    local ok, mod = pcall(function() return require(skinmodules) end)
                    if ok and type(mod) == "table" and type(mod[tn]) == "table" then
                        for skinName in pairs(mod[tn]) do
                            if type(skinName) == "string" and skinName ~= "" then
                                table.insert(names, skinName)
                            end
                        end
                    end
                end
            end
            table.sort(names, function(a, b) return string.lower(a) < string.lower(b) end)
            return names
        end

        local current = skinConfig.skins.weapons[toolName] or ""
        local statusLbl = Instance.new("TextLabel")
        statusLbl.Size = UDim2.new(1, -8, 0, 18)
        statusLbl.BackgroundTransparency = 1
        statusLbl.Text = (current ~= "" and ("selected: " .. current)) or "click a skin to apply"
        statusLbl.TextColor3 = theme.DimTextColor
        statusLbl.TextSize = 15
        statusLbl.Font = Enum.Font.IndieFlower
        statusLbl.TextXAlignment = Enum.TextXAlignment.Left
        statusLbl.Parent = LeftContent

        CreateButton(LeftContent, "Clear Skin", function()
            skinConfig.skins.weapons[toolName] = ""
            if toolName == "[Knife]" then
                local tool = getEquippedSkinTool()
                if tool and tool.Name == "[Knife]" then cleanKnife(tool) end
            end
            statusLbl.Text = "cleared"
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Skin Changer", Text = "Cleared " .. leftTitle, Duration = 2})
        end)

        local skins = getSkinNamesForTool(toolName)
        if #skins == 0 then
            local empty = Instance.new("TextLabel")
            empty.Size = UDim2.new(1, -8, 0, 36)
            empty.BackgroundTransparency = 1
            empty.Text = "no skins found\n(join game / SkinModules)"
            empty.TextColor3 = theme.DimTextColor
            empty.TextSize = 15
            empty.Font = Enum.Font.IndieFlower
            empty.TextXAlignment = Enum.TextXAlignment.Left
            empty.TextWrapped = true
            empty.Parent = LeftContent
        else
            for _, skinName in ipairs(skins) do
                local label = skinName
                if current ~= "" and string.lower(current) == string.lower(skinName) then
                    label = "★ " .. skinName
                end
                CreateButton(LeftContent, label, function()
                    skinConfig.skins.enabled = true
                    skinConfig.skins.weapons[toolName] = skinName
                    local char = LocalPlayer.Character
                    local tool = char and char:FindFirstChild(toolName)
                    if not tool and LocalPlayer.Backpack then
                        tool = LocalPlayer.Backpack:FindFirstChild(toolName)
                    end
                    local msg = "saved · equip " .. toolName
                    if toolName == "[Knife]" then
                        if char and tool and tool.Parent == char then
                            local ok = applyKnife(char, tool, skinName)
                            msg = ok and ("applied " .. skinName) or "skin not found"
                        else
                            msg = "saved · equip [Knife] to see"
                        end
                    else
                        if tool then
                            local applied = false
                            pcall(function() applied = applygun(tool, skinName) end)
                            if applied then
                                msg = "applied " .. skinName
                            else
                                msg = "saved · equip to use"
                            end
                        end
                    end
                    statusLbl.Text = msg
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Skin Changer",
                        Text = msg,
                        Duration = 2
                    })
                end)
            end
        end
    elseif leftTitle == "Atmosphere" then
        local Lighting = game:GetService("Lighting")

        if not _G.__AngelFogLoop then
            _G.FogActive = false
            local _fogAccum = 0
            _G.__AngelFogLoop = RunService.Heartbeat:Connect(function(dt)
                if _G.AdisKilled then return end
                if not _G.FogActive then return end
                _fogAccum = _fogAccum + (dt or 0.016)
                if _fogAccum < 0.1 then return end -- ~10 updates/sec
                _fogAccum = 0
                local color = _G.FogColor or Color3.fromRGB(180, 200, 220)
                local density = math.clamp(tonumber(_G.FogDensity) or 0.45, 0, 1)
                Lighting.FogColor = color
                Lighting.FogStart = 0
                Lighting.FogEnd = 200
                local atm = Lighting:FindFirstChildOfClass("Atmosphere")
                if atm then
                    atm.Color = color
                    atm.Decay = color
                    atm.Density = density
                    atm.Haze = math.clamp(density * 8, 0, 10)
                end
            end)
        end

        local function getAtmosphere()
            local atm = Lighting:FindFirstChildOfClass("Atmosphere")
            if not atm then
                atm = Instance.new("Atmosphere")
                atm.Parent = Lighting
            end
            return atm
        end

        local function applyFog()
            _G.FogActive = true
            local color = _G.FogColor or Color3.fromRGB(180, 200, 220)
            local density = math.clamp(tonumber(_G.FogDensity) or 0.45, 0, 1)
            _G.FogColor = color
            _G.FogDensity = density

            Lighting.FogColor = color
            Lighting.FogStart = 0
            Lighting.FogEnd = 200

            local atm = getAtmosphere()
            atm.Color = color
            atm.Decay = color
            atm.Density = density
            atm.Haze = math.clamp(density * 8, 0, 10)
            atm.Glare = 0
            atm.Offset = 0
        end

        if _G.FogDensity == nil then _G.FogDensity = 0.45 end
        if _G.FogColor == nil then _G.FogColor = Color3.fromRGB(180, 200, 220) end

        CreateSlider(LeftContent, "Fog Density", 0, 1, _G.FogDensity, function(v)
            _G.FogDensity = v
            applyFog()
        end, true)

        for name, config in pairs(FogPresets) do
            CreateButton(LeftContent, name, function()
                _G.FogColor = config.Color
                applyFog()
            end)
        end

        CreateButton(LeftContent, "Reset Lighting", function()
            _G.FogActive = false
            for _, v in ipairs(Lighting:GetChildren()) do
                if v:IsA("Atmosphere") then v:Destroy() end
            end
            Lighting.FogStart = OrigLighting.FogStart
            Lighting.FogEnd = OrigLighting.FogEnd
            Lighting.FogColor = OrigLighting.FogColor
            _G.FogDensity = 0.45
            _G.FogColor = OrigLighting.FogColor
        end)

        CreateToggle(RightContent, "Color Correction", _G.ColorCorrectionEnabled, function()
            _G.ColorCorrectionEnabled = not _G.ColorCorrectionEnabled
            local Lighting = game:GetService("Lighting")
            local colorCorrection = Lighting:FindFirstChild("ValColorEffect")
            if _G.ColorCorrectionEnabled then
                if not colorCorrection then colorCorrection = Instance.new("ColorCorrectionEffect") end
                colorCorrection.Name = "ValColorEffect"
                colorCorrection.Enabled = true
                colorCorrection.Saturation = 0
                colorCorrection.Contrast = 0
                colorCorrection.Brightness = 0
                colorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
                colorCorrection.Parent = Lighting
            else
                if colorCorrection then colorCorrection.Enabled = false end
            end
            return _G.ColorCorrectionEnabled
        end)
        CreateSlider(RightContent, "Saturation", 0, 2, 0.5, function(v)
            local Lighting = game:GetService("Lighting")
            local colorCorrection = Lighting:FindFirstChild("ValColorEffect") or Instance.new("ColorCorrectionEffect")
            colorCorrection.Name = "ValColorEffect"
            colorCorrection.Enabled = true
            colorCorrection.Saturation = v
            colorCorrection.Contrast = 0
            colorCorrection.Brightness = 0
            colorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
            colorCorrection.Parent = Lighting
        end, true)
    elseif leftTitle == "ESP" then
        CreateToggle(LeftContent, "ESP", _G.ESP_Enabled, function() _G.ESP_Enabled = not _G.ESP_Enabled; return _G.ESP_Enabled end)
        CreateToggle(LeftContent, "Box", _G.ESP_Boxes, function() _G.ESP_Boxes = not _G.ESP_Boxes; return _G.ESP_Boxes end)
        CreateToggle(LeftContent, "Username", _G.ESP_Names, function() _G.ESP_Names = not _G.ESP_Names; return _G.ESP_Names end)
        CreateToggle(LeftContent, "Display Name", _G.ESP_DisplayNames, function() _G.ESP_DisplayNames = not _G.ESP_DisplayNames; return _G.ESP_DisplayNames end)
        CreateToggle(LeftContent, "Distance", _G.ESP_Distance, function() _G.ESP_Distance = not _G.ESP_Distance; return _G.ESP_Distance end)
        CreateToggle(LeftContent, "Health", _G.ESP_Health, function() _G.ESP_Health = not _G.ESP_Health; return _G.ESP_Health end)
        CreateToggle(LeftContent, "Snapline", _G.ESP_Tracer, function() _G.ESP_Tracer = not _G.ESP_Tracer; return _G.ESP_Tracer end)
        CreateToggle(LeftContent, "Skeleton", _G.ESP_Skeleton, function() _G.ESP_Skeleton = not _G.ESP_Skeleton; return _G.ESP_Skeleton end)
        CreateColorWheel(RightContent)
    elseif leftTitle == "Headless" then
        CreateToggle(LeftContent, "Headless Mode", headlessActive, function()
            headlessActive = not headlessActive
            if applyCharHeadless then applyCharHeadless(LocalPlayer.Character) end
            return headlessActive
        end)
    elseif leftTitle == "Char" then
        CreateToggle(LeftContent, "Enable Avatar", charAvatarEnabled, function()
            charAvatarEnabled = not charAvatarEnabled
            return charAvatarEnabled
        end)
        charUsernameInput = charUsernameInput or ""
        charUsernameBox = CreateTextBox(LeftContent, "Username", charUsernameInput, function(value)
            charUsernameInput = value
        end)
        CreateButton(LeftContent, "Apply Username Avatar", function()
            local success, message = loadCharUsername(charUsernameBox.Text)
            charUsernameInput = charUsernameBox.Text
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Char",
                Text = tostring(message),
                Duration = 3
            })
        end)
        CreateToggle(LeftContent, "Headless Mode", headlessActive, function()
            headlessActive = not headlessActive
            if applyCharHeadless then applyCharHeadless(LocalPlayer.Character) end
            return headlessActive
        end)
        CreateToggle(LeftContent, "Korblox Leg", charKorbloxActive, function()
            charKorbloxActive = not charKorbloxActive
            if applyCharKorblox then applyCharKorblox(LocalPlayer.Character) end
            return charKorbloxActive
        end)
        CreateSlider(LeftContent, "Body Scale", 0.5, 1.5, charScaleValue, function(value)
            charScaleValue = value
            if applyCharState then applyCharState(LocalPlayer.Character) end
        end, true)
        CreateButton(LeftContent, "Reset Character", function()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.Health = 0 end
        end)
        CreateButton(RightContent, "Restore Visuals", function()
            headlessActive = false
            charKorbloxActive = false
            charScaleValue = 1
            if applyCharState then applyCharState(LocalPlayer.Character) end
        end)
        CreateButton(RightContent, "Reapply Character", function()
            if not (applyCharDescription and applyCharDescription(LocalPlayer.Character)) then
                if applyCharState then applyCharState(LocalPlayer.Character) end
            end
        end)

    elseif leftTitle == "Speed" then
        CreateToggle(LeftContent, "Speed Master", _G.SpeedMaster, function()
            _G.SpeedMaster = not _G.SpeedMaster
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if _G.SpeedMaster then
                -- ON immediately — no notification; key still toggles off/on
                _G.SpeedActive = true
                if hum then
                    _speedHum = hum
                    hum.WalkSpeed = tonumber(_G.SpeedValue) or 16
                end
            else
                _G.SpeedActive = false
                if hum then hum.WalkSpeed = 16 end
            end
            return _G.SpeedMaster
        end)
        CreateKeybind(LeftContent, "Speed Key", _G.SpeedKey, function(k) _G.SpeedKey = k end)
        CreateSlider(RightContent, "Speed Value", 16, 1000, _G.SpeedValue, function(v)
            _G.SpeedValue = v
            if _G.SpeedMaster and _G.SpeedActive then
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum then
                    _speedHum = hum
                    hum.WalkSpeed = v
                end
            end
        end)
    elseif leftTitle == "Anti Fall" then
        CreateToggle(LeftContent, "Anti Fall", _G.AntiFallEnabled, function()
            _G.AntiFallEnabled = not _G.AntiFallEnabled; return _G.AntiFallEnabled
        end)
    elseif leftTitle == "Anti Aim View" then
        CreateToggle(LeftContent, "Anti Aim View", _G.AntiAimViewEnabled, function()
            _G.AntiAimViewEnabled = not _G.AntiAimViewEnabled; return _G.AntiAimViewEnabled
        end)
        CreateToggle(LeftContent, "0% Aim Accuracy", true, function() return true end)
        CreateToggle(RightContent, "Anti Mod Notify", _G.AntiModNotification, function()
            _G.AntiModNotification = not _G.AntiModNotification; return _G.AntiModNotification
        end)
        CreateToggle(RightContent, "Anti Mod Kick", _G.AntiModKick, function()
            _G.AntiModKick = not _G.AntiModKick; return _G.AntiModKick
        end)
        CreateSlider(RightContent, "Kick Delay", 1, 10, _G.AntiModKickDelay, function(v) _G.AntiModKickDelay = v end)
    elseif leftTitle == "Delay Changer" then
        CreateToggle(LeftContent, "Delay Changer", _G.DelayChangerEnabled, function()
            _G.DelayChangerEnabled = not _G.DelayChangerEnabled
            if _G.DelayChangerEnabled then
                game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Delay Changer", Text = "Respawn to apply delay changes!", Duration = 3 })
            end
            return _G.DelayChangerEnabled
        end)
        CreateSlider(LeftContent, "[Revolver] Delay", 0, 0.5, _G.DelayChangerRevolver, function(v) _G.DelayChangerRevolver = v end, true)
        CreateSlider(LeftContent, "[Double-Barrel SG] Delay", 0, 0.5, _G.DelayChangerDoubleBarrel, function(v) _G.DelayChangerDoubleBarrel = v end, true)
        CreateSlider(LeftContent, "[TacticalShotgun] Delay", 0, 0.5, _G.DelayChangerTacticalShotgun, function(v) _G.DelayChangerTacticalShotgun = v end, true)
        CreateSlider(LeftContent, "Others Delay", 0, 0.5, _G.DelayChangerOthers, function(v) _G.DelayChangerOthers = v end, true)
    elseif leftTitle == "FPS" then
        CreateSlider(LeftContent, "Target FPS", 240, 1000, _G.FPSTarget, function(v)
            _G.FPSTarget = v
            if setfpscap then setfpscap(v) end
        end)
    elseif leftTitle == "UI Toggle" then
        CreateKeybind(LeftContent, "UI Toggle Key", _G.UIToggleKey, function(k) _G.UIToggleKey = k end)
        CreateToggle(LeftContent, "Show UI", WindowOuterBorder.Visible, function()
            local show = not WindowOuterBorder.Visible
            WindowOuterBorder.Visible = show
            _G.UIVisible = show
            return show
        end)
    elseif leftTitle == "Config" then
        CreateTextBox(LeftContent, "Config Name", configNameInput, function(v) configNameInput = v end)
        CreateButton(LeftContent, "Save Config", function()
            if configNameInput == "" then return end
            SaveConfig(configNameInput)
            configNameInput = ""
        end)
        CreateDropdown(LeftContent, "Saved Configs", GetConfigs(), selectedConfig or "", function(v) selectedConfig = v end)
        CreateButton(LeftContent, "Load Config", function()
            if selectedConfig then LoadConfig(selectedConfig) end
        end)
        CreateButton(LeftContent, "Delete Config", function()
            if selectedConfig then DeleteConfig(selectedConfig) selectedConfig = nil end
        end)
        CreateButton(LeftContent, "Refresh List", function() end)
    elseif leftTitle == "Credits" then
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -30, 0, 30)
        titleLabel.Position = UDim2.new(0, 15, 0, 10)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = "adis"
        titleLabel.TextColor3 = theme.AccentColor
        titleLabel.TextSize = 22
        titleLabel.Font = Enum.Font.IndieFlower
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = LeftContent

        local devList = {}
        local modList = {}
        for userId, data in pairs(Developers) do
            if data.role == "Developer" then
                table.insert(devList, {name = data.name, role = data.role, userId = userId})
            else
                table.insert(modList, {name = data.name, role = data.role, userId = userId})
            end
        end
        table.sort(devList, function(a, b) return a.name:lower() < b.name:lower() end)
        table.sort(modList, function(a, b) return a.name:lower() < b.name:lower() end)

        local yPos = 50
        for i, data in ipairs(devList) do
            local roleIcon = "👑"
            local creditBtn = Instance.new("TextButton")
            creditBtn.Size = UDim2.new(1, -30, 0, 24)
            creditBtn.Position = UDim2.new(0, 15, 0, yPos)
            creditBtn.BackgroundColor3 = Color3.fromRGB(40, 32, 50)
            creditBtn.BorderColor3 = theme.BorderColor
            creditBtn.Text = "  " .. roleIcon .. " " .. data.name .. " - " .. data.role
            creditBtn.TextColor3 = theme.DimColor
            creditBtn.Font = Enum.Font.IndieFlower
            creditBtn.TextSize = 15
            creditBtn.TextXAlignment = Enum.TextXAlignment.Left
            creditBtn.Parent = LeftContent
            creditBtn.MouseButton1Click:Connect(function()
                pcall(function()
                    setclipboard("https://www.roblox.com/users/" .. data.userId .. "/profile")
                    game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Copied!", Text = data.name .. "'s profile link copied!", Duration = 2 })
                end)
            end)
            yPos = yPos + 28
        end

        yPos = yPos + 10

        for i, data in ipairs(modList) do
            local roleIcon = "🛡️"
            local creditBtn = Instance.new("TextButton")
            creditBtn.Size = UDim2.new(1, -30, 0, 24)
            creditBtn.Position = UDim2.new(0, 15, 0, yPos)
            creditBtn.BackgroundColor3 = Color3.fromRGB(40, 32, 50)
            creditBtn.BorderColor3 = theme.BorderColor
            creditBtn.Text = "  " .. roleIcon .. " " .. data.name .. " - " .. data.role
            creditBtn.TextColor3 = theme.DimColor
            creditBtn.Font = Enum.Font.IndieFlower
            creditBtn.TextSize = 15
            creditBtn.TextXAlignment = Enum.TextXAlignment.Left
            creditBtn.Parent = LeftContent
            creditBtn.MouseButton1Click:Connect(function()
                pcall(function()
                    setclipboard("https://www.roblox.com/users/" .. data.userId .. "/profile")
                    game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Copied!", Text = data.name .. "'s profile link copied!", Duration = 2 })
                end)
            end)
            yPos = yPos + 28
        end
    end
end

local dataStructure = {
    ["combat"] = {
        ["silent aim"] = {titleLeft = "Silent Aim", titleRight = ""},
        ["camlock"] = {titleLeft = "Camlock", titleRight = "Settings"},
        ["trigger bot"] = {titleLeft = "Trigger Bot", titleRight = "Settings"},
        ["hood customs"] = {titleLeft = "Hood Customs", titleRight = "Force Hit"},
        ["hitbox expander"] = {titleLeft = "Hitbox Expander", titleRight = "Settings"},
        ["flamelock"] = {titleLeft = "Flamelock", titleRight = "Settings"}
    },
    ["camlock"] = {
        ["camlock"] = {titleLeft = "Camlock", titleRight = "Settings"}
    },
    ["visuals"] = {
        ["esp"] = {titleLeft = "ESP", titleRight = "Color"},
        ["atmosphere"] = {titleLeft = "Atmosphere", titleRight = "Colouring"}
    },
    ["whitelist"] = {
        ["whitelist"] = {titleLeft = "Whitelist", titleRight = "Controls"}
    },
    ["teleport"] = {
        ["teleport"] = {titleLeft = "Teleport", titleRight = "Controls"}
    },
    ["skin changer"] = {
        ["double barrel"] = {titleLeft = "Double Barrel", titleRight = ""},
        ["revolver"] = {titleLeft = "Revolver", titleRight = ""},
        ["tactical"] = {titleLeft = "Tactical", titleRight = ""},
        ["shotgun"] = {titleLeft = "Shotgun", titleRight = ""},
        ["knife"] = {titleLeft = "Knife", titleRight = ""},
        ["lmg"] = {titleLeft = "LMG", titleRight = ""},
    },
    ["avatar"] = {
        ["headless"] = {titleLeft = "Headless", titleRight = ""},
        ["char"] = {titleLeft = "Char", titleRight = "Character Tools"}
    },
    ["misc"] = {
        ["speed"] = {titleLeft = "Speed", titleRight = "Settings"},
        ["anti fall"] = {titleLeft = "Anti Fall", titleRight = ""},
        ["delay changer"] = {titleLeft = "Delay Changer", titleRight = ""}
    },
    ["protection"] = {
        ["anti aim view"] = {titleLeft = "Anti Aim View", titleRight = "Anti Mod"}
    },
    ["settings"] = {
        ["fps"] = {titleLeft = "FPS", titleRight = ""},
        ["ui toggle"] = {titleLeft = "UI Toggle", titleRight = ""},
        ["config"] = {titleLeft = "Config", titleRight = "Settings"},
        ["credits"] = {titleLeft = "Credits", titleRight = "Info"}
    }
}

local currentCategory = "combat"
local currentSubTab

local function RefreshSubTabs(categoryKey)
    for _, child in ipairs(SubTabsHeader:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local tabData = dataStructure[categoryKey]
    local sortedKeys = {}
    if categoryKey == "combat" then
        local combatOrder = {"silent aim", "hood customs", "hitbox expander", "camlock", "trigger bot", "flamelock"}
        for _, key in ipairs(combatOrder) do
            if tabData[key] then table.insert(sortedKeys, key) end
        end
    elseif categoryKey == "skin changer" then
        local skinOrder = {"double barrel", "revolver", "tactical", "shotgun", "knife", "lmg"}
        for _, key in ipairs(skinOrder) do
            if tabData[key] then table.insert(sortedKeys, key) end
        end
    else
        for k in pairs(tabData) do table.insert(sortedKeys, k) end
        table.sort(sortedKeys)
    end
    local totalKeys = #sortedKeys
    for index, subTabKey in ipairs(sortedKeys) do
        local theme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
        local SubTabBtn = Instance.new("TextButton")
        SubTabBtn.Size = UDim2.new(1 / totalKeys, 0, 1, -4)
        SubTabBtn.Position = UDim2.new((index - 1) / totalKeys, 0, 0, 2)
        SubTabBtn.BackgroundColor3 = theme.BgColor
        SubTabBtn.BorderColor3 = theme.BorderColor
        SubTabBtn.BorderSizePixel = 0
        SubTabBtn.Text = subTabKey
        SubTabBtn.Font = Enum.Font.IndieFlower
        SubTabBtn.TextSize = 15
        SubTabBtn.ZIndex = 6
        if index == 1 then
            currentSubTab = subTabKey
            SubTabBtn.TextColor3 = theme.TextColor
            local currentPanelData = tabData[subTabKey]
            RenderWorkspacePanels(currentPanelData.titleLeft, currentPanelData.titleRight)
        else
            SubTabBtn.TextColor3 = theme.DimTextColor
        end
        SubTabBtn.MouseButton1Click:Connect(function()
            currentSubTab = subTabKey
            local newTheme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
            for _, btn in ipairs(SubTabsHeader:GetChildren()) do
                if btn:IsA("TextButton") then btn.TextColor3 = newTheme.DimTextColor end
            end
            SubTabBtn.TextColor3 = newTheme.TextColor
            local activePanelData = dataStructure[categoryKey][subTabKey]
            RenderWorkspacePanels(activePanelData.titleLeft, activePanelData.titleRight)
        end)
        SubTabBtn.Parent = SubTabsHeader
    end
end

local categories = {"combat", "visuals", "whitelist", "teleport", "skin changer", "avatar", "misc", "protection", "settings"}
for index, catName in ipairs(categories) do
    local theme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
    local NavItem = Instance.new("TextButton")
    NavItem.Name = "NavItem_" .. catName
    NavItem.Size = UDim2.new(1, 0, 0, 26)
    NavItem.Position = UDim2.new(0, 0, 0, 15 + ((index - 1) * 26))
    NavItem.BackgroundTransparency = 1
    NavItem.Text = "   " .. catName
    NavItem.Font = Enum.Font.IndieFlower
    NavItem.TextSize = 15
    NavItem.TextXAlignment = Enum.TextXAlignment.Left
    NavItem.ZIndex = 6
    local IndicatorTick = Instance.new("Frame")
    IndicatorTick.Name = "Tick"
    IndicatorTick.Size = UDim2.new(0, 2, 0, 10)
    IndicatorTick.Position = UDim2.new(0, 10, 0.5, -5)
    IndicatorTick.BackgroundColor3 = theme.AccentColor
    IndicatorTick.BorderSizePixel = 0
    IndicatorTick.Visible = false
    IndicatorTick.Parent = NavItem
    if catName == currentCategory then
        NavItem.TextColor3 = theme.TextColor
        IndicatorTick.Visible = true
        RefreshSubTabs(catName)
    else
        NavItem.TextColor3 = theme.DimTextColor
    end
    NavItem.MouseButton1Click:Connect(function()
        currentCategory = catName
        local newTheme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
        for _, item in ipairs(Sidebar:GetChildren()) do
            if item:IsA("TextButton") then
                item.TextColor3 = newTheme.DimTextColor
                if item:FindFirstChild("Tick") then item.Tick.Visible = false end
            end
        end
        NavItem.TextColor3 = newTheme.TextColor
        IndicatorTick.Visible = true
        RefreshSubTabs(catName)
    end)
    NavItem.Parent = Sidebar
end

-- ==================== KILL SWITCH ====================
local KillSwitchBtn = Instance.new("TextButton")
KillSwitchBtn.Name = "KillSwitch"
KillSwitchBtn.Size = UDim2.new(1, -10, 0, 28)
KillSwitchBtn.Position = UDim2.new(0, 5, 1, -36)
KillSwitchBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
KillSwitchBtn.BorderSizePixel = 0
KillSwitchBtn.Text = "KILL SWITCH"
KillSwitchBtn.TextColor3 = Color3.fromRGB(30, 30, 30)
KillSwitchBtn.Font = Enum.Font.IndieFlower
KillSwitchBtn.TextSize = 15
KillSwitchBtn.ZIndex = 10
KillSwitchBtn.Parent = Sidebar
local KillCorner = Instance.new("UICorner")
KillCorner.CornerRadius = UDim.new(0, 6)
KillCorner.Parent = KillSwitchBtn

local function FullyUnloadScript()
    -- Stop all features
    _G.SilentAim_Enabled = false
    _G.SilentAimEnabled = false
    _G.HCSilentAimEnabled = false
    _G.ShowFOV = false
    _G.HCShowFOV = false
    _G.CamlockEnabled = false
    _G.FlamelockEnabled = false
    _G.FlameActive = false
    _G.SpeedMaster = false
    _G.SpeedActive = false
    _G.HitboxEnabled = false
    _G.ESP_Enabled = false
    _G.ESP_Boxes = false
    _G.ESP_Names = false
    _G.ESP_DisplayNames = false
    _G.ESP_Health = false
    _G.ESP_Distance = false
    _G.ESP_Tracer = false
    _G.ESP_Skeleton = false
    _G.ForceHitEnabled = false
    _G.HCGodmodeEnabled = false
    _G.DelayChangerEnabled = false
    TriggerBot.MasterEnabled = false
    TriggerBot.Active = false
    HCGodmode_Active = false

    pcall(function()
        if enableHCSilentAim then enableHCSilentAim(false) end
    end)
    pcall(function()
        if DisableCamlock then DisableCamlock() end
    end)
    pcall(function()
        if HCGodmode_Stop then HCGodmode_Stop() end
    end)

    -- Reset hitboxes
    pcall(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                    hrp.CanCollide = false
                    hrp.Material = Enum.Material.Plastic
                end
            end
        end
    end)

    -- Remove ESP drawings
    pcall(function()
        for plr, objs in pairs(espObjects) do
            pcall(function()
                if objs.Box then objs.Box:Remove() end
                if objs.Name then objs.Name:Remove() end
                if objs.DisplayName then objs.DisplayName:Remove() end
                if objs.Health then objs.Health:Remove() end
                if objs.Distance then objs.Distance:Remove() end
                if objs.Tracer then objs.Tracer:Remove() end
                if objs.Skeleton then
                    for _, line in pairs(objs.Skeleton) do
                        pcall(function() line:Remove() end)
                    end
                end
            end)
        end
        table.clear(espObjects)
    end)

    -- Remove FOV circles / force hit line
    pcall(function()
        if fovCircle then fovCircle.Visible = false fovCircle:Remove() end
    end)
    pcall(function()
        if hcFovCircle then hcFovCircle.Visible = false hcFovCircle:Remove() end
    end)
    pcall(function()
        if ForceHitHighlightLine then ForceHitHighlightLine.Visible = false ForceHitHighlightLine:Remove() end
    end)

    -- Reset lighting fog
    pcall(function()
        _G.FogActive = false
        local Lighting = game:GetService("Lighting")
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("Atmosphere") then v:Destroy() end
            if v.Name == "ValColorEffect" then v:Destroy() end
        end
        if OrigLighting then
            Lighting.FogStart = OrigLighting.FogStart
            Lighting.FogEnd = OrigLighting.FogEnd
            Lighting.FogColor = OrigLighting.FogColor
        end
    end)

    -- Destroy entire UI
    pcall(function()
        if ScreenGui then ScreenGui:Destroy() end
    end)

    _G.AdisKilled = true

    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Adis.UI",
            Text = "Adis.UI unloaded.",
            Duration = 4
        })
    end)
end

KillSwitchBtn.MouseButton1Click:Connect(FullyUnloadScript)
KillSwitchBtn.Activated:Connect(FullyUnloadScript)

task.spawn(function()
    task.wait(1)
    ApplyTheme(_G.CurrentTheme)
    if _G.HCSilentAimEnabled then
        enableHCSilentAim(true)
    end
end)

ScreenGui.Parent = PlayerGui

local function UpdateHitboxes()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and not _G.Whitelist[plr.UserId] and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if _G.HitboxEnabled then
                    hrp.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                    hrp.Transparency = 1 - _G.HitboxTransparency
                    hrp.Color = Color3.fromRGB(255, 140, 185)
                    hrp.Material = Enum.Material.Neon
                    hrp.CanCollide = false
                else
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
            end
        end
    end
end

Players.PlayerAdded:Connect(function(plr)
    if plr ~= LocalPlayer then
        plr.CharacterAdded:Connect(function()
            task.wait(0.5)
            UpdateHitboxes()
        end)
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if _G.HitboxEnabled then
            UpdateHitboxes()
        end
    end
end)

DelayChanger = { 
    Enabled = true, 
    ["[Revolver]"] = 0.03, 
    ["[Double-Barrel SG]"] = 0.3, 
    ["[TacticalShotgun]"] = 0.0, 
    ["Others"] = 0.095 
}

function applyCustomDelay(v)
    if not _G.DelayChangerEnabled then return end
    if (v.Name == "ShootingCooldown" or v.Name == "ToleranceCooldown") and v:IsA("ValueBase") then
        local tool = v:FindFirstAncestorOfClass("Tool")
        local delayValue = _G.DelayChangerOthers
        if tool then
            if tool.Name == "[Revolver]" then delayValue = _G.DelayChangerRevolver
            elseif tool.Name == "[Double-Barrel SG]" then delayValue = _G.DelayChangerDoubleBarrel
            elseif tool.Name == "[TacticalShotgun]" then delayValue = _G.DelayChangerTacticalShotgun end
        end
        v.Value = delayValue
        v:GetPropertyChangedSignal("Value"):Connect(function()
            if v.Value ~= delayValue then v.Value = delayValue end
        end)
    end
end

-- Only watch tools in local backpack/character (game:GetDescendants tanks FPS)
function scanToolDelays(tool)
    if not tool or not tool:IsA("Tool") then return end
    for _, v in ipairs(tool:GetDescendants()) do
        applyCustomDelay(v)
    end
    tool.DescendantAdded:Connect(function(v)
        applyCustomDelay(v)
    end)
end
function scanPlayerTools()
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do scanToolDelays(t) end
        bp.ChildAdded:Connect(scanToolDelays)
    end
    local ch = LocalPlayer.Character
    if ch then
        for _, t in ipairs(ch:GetChildren()) do scanToolDelays(t) end
    end
end
scanPlayerTools()
LocalPlayer.CharacterAdded:Connect(function(ch)
    task.defer(function()
        for _, t in ipairs(ch:GetChildren()) do scanToolDelays(t) end
        ch.ChildAdded:Connect(scanToolDelays)
    end)
end)
LocalPlayer.ChildAdded:Connect(function(c)
    if c.Name == "Backpack" then
        for _, t in ipairs(c:GetChildren()) do scanToolDelays(t) end
        c.ChildAdded:Connect(scanToolDelays)
    end
end)

task.spawn(function()
    task.wait(2)
    local antiStaffGroupId = 10604500
    local function antiStaffNotify(message)
        if _G.AntiModNotification then
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Anti-Mod", Text = message, Duration = 5 })
            end)
        end
    end

    local function isStaff(player)
        if not player or not player:IsInGroup(antiStaffGroupId) then return false end
        local success, role = pcall(function() return player:GetRoleInGroup(antiStaffGroupId) end)
        return success and role ~= "" and role ~= "Guest"
    end

    local function handleStaffDetected(player)
        local staffName = player.Name
        antiStaffNotify(string.format("STAFF DETECTED: %s has joined!", staffName))
        if _G.AntiModKick then
            task.wait(_G.AntiModKickDelay)
            if isStaff(player) and player.Parent then
                LocalPlayer:Kick(string.format("Anti-Mod: Staff member %s detected. Protection activated.", staffName))
            end
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isStaff(player) then
            antiStaffNotify(string.format("STAFF ALREADY IN GAME: %s", player.Name))
            if _G.AntiModKick then
                task.wait(_G.AntiModKickDelay)
                LocalPlayer:Kick(string.format("Anti-Mod: Staff member %s is already in game.", player.Name))
            end
            break
        end
    end

    Players.PlayerAdded:Connect(function(player)
        task.wait(0.5)
        if isStaff(player) then handleStaffDetected(player) end
        player:GetPropertyChangedSignal("GroupRank"):Connect(function()
            task.wait(0.5)
            if isStaff(player) then antiStaffNotify(string.format("STAFF DETECTED: %s was promoted!", player.Name)) handleStaffDetected(player) end
        end)
    end)
end)

AntiAimViewEnabled = true
AccuracyTarget = 0

antiAimConnections = {}

function toggleAntiAimView(enable)
    for _, conn in ipairs(antiAimConnections) do
        pcall(function()
            conn:Disconnect()
        end)
    end
    antiAimConnections = {}

    if not enable then
        return
    end

    local dataFolder = LocalPlayer:FindFirstChild("DataFolder")
    if not dataFolder then
        dataFolder = LocalPlayer:WaitForChild("DataFolder", 5)
    end
    if not dataFolder then
        return
    end

    local shotland = dataFolder:FindFirstChild("ShotLand")
    local shottotal = dataFolder:FindFirstChild("ShotTotal")
    local warning = dataFolder:FindFirstChild("Warning")
    local lockflagged = dataFolder:FindFirstChild("LockFlagged")

    local function safeConnect(obj, callback)
        if obj then
            local conn = obj:GetPropertyChangedSignal("Value"):Connect(callback)
            table.insert(antiAimConnections, conn)
        end
    end

    safeConnect(shottotal, function()
        if shottotal and shotland then
            local total = shottotal.Value
            if total > 0 then
                local targetLand = math.floor(total * (AccuracyTarget / 100))
                shotland.Value = targetLand
            end
        end
    end)

    safeConnect(warning, function()
        if warning then
            warning.Value = 0
        end
    end)

    safeConnect(lockflagged, function()
        if lockflagged then
            lockflagged.Value = 0
        end
    end)

    local function onCharacterAdded(char)
        local bodyEffects = char:FindFirstChild("BodyEffects")
        if bodyEffects then
            local gf = bodyEffects:FindFirstChild("GunFiring")
            local gsc = bodyEffects:FindFirstChild("GunShotChanges")
            if gf then
                local conn = gf:GetPropertyChangedSignal("Value"):Connect(function()
                    if gf then
                        gf.Value = false
                    end
                end)
                table.insert(antiAimConnections, conn)
            end
            if gsc then
                local conn = gsc:GetPropertyChangedSignal("Value"):Connect(function()
                    if gsc then
                        gsc.Value = 0
                    end
                end)
                table.insert(antiAimConnections, conn)
            end
        end
    end

    if LocalPlayer.Character then
        onCharacterAdded(LocalPlayer.Character)
    end

    local playerAddedConn = LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
    table.insert(antiAimConnections, playerAddedConn)
end

antiModConnections = {}

function setupAntiMod()
    for _, conn in ipairs(antiModConnections) do
        pcall(function()
            conn:Disconnect()
        end)
    end
    antiModConnections = {}

    local function adjustAccuracy()
        local dataFolder = LocalPlayer:FindFirstChild("DataFolder")
        if not dataFolder then
            return
        end

        local shotland = dataFolder:FindFirstChild("ShotLand")
        local shottotal = dataFolder:FindFirstChild("ShotTotal")
        local warning = dataFolder:FindFirstChild("Warning")
        local lockflagged = dataFolder:FindFirstChild("LockFlagged")

        pcall(function()
            if shottotal and shotland then
                local total = shottotal.Value
                if total > 0 then
                    local targetLand = math.floor(total * (AccuracyTarget / 100))
                    shotland.Value = targetLand
                end
            end
        end)
        pcall(function()
            if warning then warning.Value = 0 end
        end)
        pcall(function()
            if lockflagged then lockflagged.Value = 0 end
        end)

        local ReportersFolder = dataFolder:FindFirstChild("Reporters")
        if ReportersFolder then
            for _, reporter in ipairs(ReportersFolder:GetChildren()) do
                pcall(function()
                    reporter:Destroy()
                end)
            end
        end
    end

    local function onCharacterAdded(char)
        task.wait(0.5)
        adjustAccuracy()

        local bodyEffects = char:FindFirstChild("BodyEffects")
        if bodyEffects then
            local gf = bodyEffects:FindFirstChild("GunFiring")
            local gsc = bodyEffects:FindFirstChild("GunShotChanges")

            if gf then
                local conn = gf:GetPropertyChangedSignal("Value"):Connect(function()
                    if gf then
                        gf.Value = false
                    end
                end)
                table.insert(antiModConnections, conn)
            end
            if gsc then
                local conn = gsc:GetPropertyChangedSignal("Value"):Connect(function()
                    if gsc then
                        gsc.Value = 0
                    end
                end)
                table.insert(antiModConnections, conn)
            end
        end
    end

    adjustAccuracy()

    if LocalPlayer.Character then
        onCharacterAdded(LocalPlayer.Character)
    end

    local conn = LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
    table.insert(antiModConnections, conn)
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
    if AntiAimViewEnabled then
        toggleAntiAimView(true)
    end
    setupAntiMod()
end)

task.spawn(function()
    task.wait(1)
    if AntiAimViewEnabled then
        toggleAntiAimView(true)
    end
    setupAntiMod()
end)

LocalPlayer.CharacterAdded:Connect(function(newChar)
    task.wait(0.35)
    charOriginalLegs = {}
    if applyCharDescription and not applyCharDescription(newChar) then
        if applyCharState then applyCharState(newChar) end
    elseif applyCharState then
        applyCharState(newChar)
    end
end)
