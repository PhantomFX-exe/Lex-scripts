pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/rizemtech0123/all/refs/heads/main/bypass"))()
end)

local Lexhancements = _G.Lexhancements or (getgenv and getgenv().Lexhancements) or _G.KraviX or (getgenv and getgenv().KraviX) or loadstring(game:HttpGet("https://raw.githubusercontent.com/PhantomFX-exe/Lex-scripts/refs/heads/main/ui"))()
local KraviX = Lexhancements

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TeleportService   = game:GetService("TeleportService")
local TweenService      = game:GetService("TweenService")
local Lighting          = game:GetService("Lighting")
local StatsService      = game:GetService("Stats")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer       = Players.LocalPlayer
local Camera            = workspace.CurrentCamera

local _scriptUnloaded = false

getgenv().CamLockSettings = getgenv().CamLockSettings or {
    Enabled           = false,
    MobileActive      = false,
    Smoothness        = 0.450,
    Prediction        = 0.100,
    PredictionEnabled = true,
    AutoPrediction    = false,
    AntiGroundShot    = true,
    AirCheck          = false,
    AirPart           = "HumanoidRootPart",
    DeadzoneEnabled   = false,
    Deadzone          = 15,
    ShakeEnabled      = false,
    ShakeAmount       = 2,
    WallCheck         = true,
    KOCheck           = true,
    TargetPart        = "HumanoidRootPart",
    Sticky            = false,
    StickyTarget      = nil,
    ShowFOV           = false,
    FOVMode           = "Mouse",
    FOV               = 200,
    FOVColor          = Color3.fromRGB(255, 255, 255),
    FOVFill           = false,
    FOVFillColor      = Color3.fromRGB(255, 255, 255),
    FOVFillTransparency = 0.1,
    Whitelist         = {},
}
local CamLockSettings = getgenv().CamLockSettings
CamLockSettings.Whitelist = CamLockSettings.Whitelist or {}

local SilentAimSettings = {
    Enabled        = false,
    FOVMode        = "Mouse",
    FOV            = 150,
    ShowFOV        = false,
    FOVColor       = Color3.fromRGB(255, 255, 255),
    FOVFill        = false,
    FOVFillColor   = Color3.fromRGB(255, 255, 255),
    FOVFillTransparency = 0.1,
    HitpartMode    = "Single Part",
    TargetPart     = "Head",
    MaxDistance    = 500,
    HitChance      = 100,
    PredictEnabled = false,
    PredictAmount  = 0.15,
    IgnoreKO       = true,
    WallCheck      = true,
    Whitelist      = {},
}

local RapidFireSettings = {
    Enabled = false,
    Delay   = 0.08,
}

local TriggerSettings = {
    Enabled        = false,
    Active         = false,
    Keybind        = nil,
    Delay          = 0.5,
    FireInterval   = 0.05,
    Blacklist      = {
        ["[Knife]"] = true,
        ["Combat"] = true,
        ["[Phone]"] = true,
        ["[Wallet]"] = true,
        ["TipJar"] = true,
        ["[Bat]"] = true,
        ["[Shovel]"] = true,
        ["[LockPicker]"] = true,
    },
    PredictEnabled = false,
    PredictAmount  = 0.1,
    ShowHitbox     = false,
    HitboxSize     = 5,
    HitboxColor    = Color3.fromRGB(255, 80, 80),
}

local SpeedSettings = { Enabled = false, Value = 16, KeybindActive = false }
local FlySettings   = { Enabled = false, Speed = 50 }
local _hidden       = false

local NoClipEnabled = false
RunService.Heartbeat:Connect(function()
    if _scriptUnloaded then return end
    if NoClipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

local LightingMods = false
local OrigLighting = {
    Ambient              = Lighting.Ambient,
    OutdoorAmbient       = Lighting.OutdoorAmbient,
    FogStart             = Lighting.FogStart,
    FogEnd               = Lighting.FogEnd,
    FogColor             = Lighting.FogColor,
    Brightness           = Lighting.Brightness,
    ExposureCompensation = Lighting.ExposureCompensation,
    ClockTime            = Lighting.ClockTime,
}
local LightingMod = {
    Ambient              = Color3.new(0, 0, 0),
    OutdoorAmbient       = Color3.fromRGB(80, 120, 200),
    FogStart             = 50,
    FogEnd               = 1000,
    FogColor             = Color3.fromRGB(80, 120, 200),
    Brightness           = 2,
    ExposureCompensation = -0.3,
    ClockTime            = 14,
}
RunService.Heartbeat:Connect(function()
    if _scriptUnloaded or not LightingMods or _hidden then return end
    Lighting.Ambient              = LightingMod.Ambient
    Lighting.OutdoorAmbient       = LightingMod.OutdoorAmbient
    Lighting.FogStart             = LightingMod.FogStart
    Lighting.FogEnd               = LightingMod.FogEnd
    Lighting.FogColor             = LightingMod.FogColor
    Lighting.Brightness           = LightingMod.Brightness
    Lighting.ExposureCompensation = LightingMod.ExposureCompensation
    Lighting.ClockTime            = LightingMod.ClockTime
end)

local selectedSkybox = "Default"
local applySkybox
do
    local predefinedSkyboxes = {
        Rainy={Bk=1666456837,Dn=1666455881,Ft=1666457447,Lf=1666455318,Rt=1666456385,Up=1666458034},
        ["Space v2"]={Bk=76948125119932,Dn=117865148129754,Ft=77181996912050,Lf=130317898320211,Rt=105669495538162,Up=128363212769327},
        Cosmo={Bk=15753305495,Dn=15753362674,Ft=15753305823,Lf=15753310707,Rt=15753304774,Up=15753304473},
        Neon={Bk=271042516,Dn=271077243,Ft=271042556,Lf=271042310,Rt=271042467,Up=271077958},
        Minecraft={Bk=1876545003,Dn=1876544331,Ft=1876542941,Lf=1876543392,Rt=1876543764,Up=1876544642},
        Nightless={Bk=48020371,Dn=48020144,Ft=48020234,Lf=48020211,Rt=48020254,Up=48020383},
        Retro={Bk="rbxasset://Sky/null_plainsky512_bk.jpg",Dn="rbxasset://Sky/null_plainsky512_dn.jpg",Ft="rbxasset://Sky/null_plainsky512_ft.jpg",Lf="rbxasset://Sky/null_plainsky512_lf.jpg",Rt="rbxasset://Sky/null_plainsky512_rt.jpg",Up="rbxasset://Sky/null_plainsky512_up.jpg",raw=true},
        ["Crimson Night"]={Bk="http://www.roblox.com/asset/?id=570555736",Dn="http://www.roblox.com/asset/?id=570555964",Ft="http://www.roblox.com/asset/?id=570555800",Lf="http://www.roblox.com/asset/?id=570555840",Rt="http://www.roblox.com/asset/?id=570555882",Up="http://www.roblox.com/asset/?id=570555929",raw=true},
        ["Orange Sunset"]={Bk="http://www.roblox.com/asset/?id=458016711",Dn="http://www.roblox.com/asset/?id=458016826",Ft="http://www.roblox.com/asset/?id=458016532",Lf="http://www.roblox.com/asset/?id=458016655",Rt="http://www.roblox.com/asset/?id=458016782",Up="http://www.roblox.com/asset/?id=458016792",raw=true},
        ["Blue Galaxy"]={Bk="rbxassetid://393845394",Dn="rbxassetid://393845204",Ft="rbxassetid://393845629",Lf="rbxassetid://393845750",Rt="rbxassetid://393845533",Up="rbxassetid://393845287",raw=true},
        ["Abyssal Blues"]={Bk="rbxassetid://16269815885",Dn="rbxassetid://16269839652",Ft="rbxassetid://16269798011",Lf="rbxassetid://16269813852",Rt="rbxassetid://16269814948",Up="rbxassetid://16269829700",raw=true},
        Sunrise={Bk="http://www.roblox.com/asset/?id=158664655",Dn="http://www.roblox.com/asset/?id=158664673",Ft="http://www.roblox.com/asset/?id=158664598",Lf="http://www.roblox.com/asset/?id=158664558",Rt="http://www.roblox.com/asset/?id=158664624",Up="http://www.roblox.com/asset/?id=158664465",raw=true},
        ["Stormy Night"]={Bk="rbxassetid://323479840",Dn="rbxassetid://323481190",Ft="rbxassetid://323480314",Lf="rbxassetid://323480786",Rt="rbxassetid://323480131",Up="rbxassetid://323478865",raw=true},
        Snowy={Bk="http://www.roblox.com/asset/?id=155657655",Dn="http://www.roblox.com/asset/?id=155674246",Ft="http://www.roblox.com/asset/?id=155657609",Lf="http://www.roblox.com/asset/?id=155657671",Rt="http://www.roblox.com/asset/?id=155657619",Up="http://www.roblox.com/asset/?id=155674931",raw=true},
        Spongebob={Bk="http://www.roblox.com/asset/?id=277099484",Dn="http://www.roblox.com/asset/?id=277099500",Ft="http://www.roblox.com/asset/?id=277099554",Lf="http://www.roblox.com/asset/?id=277099531",Rt="http://www.roblox.com/asset/?id=277099589",Up="http://www.roblox.com/asset/?id=277101591",raw=true},
    }
    local originalSky = Lighting:FindFirstChildOfClass("Sky")
    local currentSky  = nil
    function applySkybox(name)
        selectedSkybox = name
        if currentSky then currentSky:Destroy(); currentSky = nil end
        if name == "Default" then
            if originalSky then originalSky.Parent = Lighting end
        else
            if originalSky then originalSky.Parent = nil end
            local d = predefinedSkyboxes[name]
            if d then
                currentSky = Instance.new("Sky")
                if d.raw then
                    currentSky.SkyboxBk = d.Bk; currentSky.SkyboxDn = d.Dn
                    currentSky.SkyboxFt = d.Ft; currentSky.SkyboxLf = d.Lf
                    currentSky.SkyboxRt = d.Rt; currentSky.SkyboxUp = d.Up
                else
                    currentSky.SkyboxBk = "rbxassetid://"..d.Bk; currentSky.SkyboxDn = "rbxassetid://"..d.Dn
                    currentSky.SkyboxFt = "rbxassetid://"..d.Ft; currentSky.SkyboxLf = "rbxassetid://"..d.Lf
                    currentSky.SkyboxRt = "rbxassetid://"..d.Rt; currentSky.SkyboxUp = "rbxassetid://"..d.Up
                end
                currentSky.Parent = Lighting
            end
        end
    end
end

local CFrameSpeedSettings = {
    Enabled       = false,
    Value         = 150,
    KeybindActive = false
}
local _cframeSpeedBindObj = nil

RunService.Heartbeat:Connect(function(dt)
    if (CFrameSpeedSettings.Enabled or CFrameSpeedSettings.KeybindActive) and LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid")
        if hrp and hum then
            local moveDir = hum.MoveDirection
            if moveDir.Magnitude == 0 then
                local isW = UserInputService:IsKeyDown(Enum.KeyCode.W)
                local isS = UserInputService:IsKeyDown(Enum.KeyCode.S)
                local isA = UserInputService:IsKeyDown(Enum.KeyCode.A)
                local isD = UserInputService:IsKeyDown(Enum.KeyCode.D)
                if isW or isS or isA or isD then
                    local camCF = Camera.CFrame
                    local forward = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z)
                    local right = Vector3.new(camCF.RightVector.X, 0, camCF.RightVector.Z)
                    if forward.Magnitude > 0 then forward = forward.Unit end
                    if right.Magnitude > 0 then right = right.Unit end
                    local dir = Vector3.zero
                    if isW then dir = dir + forward end
                    if isS then dir = dir - forward end
                    if isD then dir = dir + right end
                    if isA then dir = dir - right end
                    if dir.Magnitude > 0 then moveDir = dir.Unit end
                end
            end
            if moveDir.Magnitude > 0 then
                local mv = moveDir.Unit * CFrameSpeedSettings.Value * dt
                hrp.CFrame = hrp.CFrame + mv
            end
        end
    end
end)

local _tpEnabled = false
local _tpHolding = false
local _tpOrbit = false
local _tpOrbitSpeed = 3
local _tpOrbitRadius = 8
local _tpOrbitAngle = 0
local _tpMode = "Hold"

local scEnabled       = false
local scColor         = Color3.fromRGB(155, 125, 175)
local scTrans         = 0
local scReflect       = 0
local scMat           = "ForceField"
local scEffect        = "none"
local scParticles     = "none"
local scParticleColor = Color3.fromRGB(255, 255, 255)

local scRemoveParticles, scApplyStars, scApplySpecks, scApply, scEnable, scDisable
do
    local scParticleTrans = 0
    local scCharConn
    local scHeatConn
    local scHeatTime      = 0
    local scHeatLast      = 0
    local scOriginal      = {}

    local scR15 = {
        "LeftFoot","LeftLowerLeg","LeftUpperLeg","RightFoot","RightLowerLeg","RightUpperLeg",
        "LeftHand","LeftLowerArm","LeftUpperArm","RightHand","RightLowerArm","RightUpperArm",
        "LowerTorso","UpperTorso","Head"
    }
    local scHeatMap = {
        LeftFoot=0.7, LeftLowerLeg=0.3, LeftUpperLeg=0.5, RightFoot=0.7, RightLowerLeg=0.3, RightUpperLeg=0.5,
        LeftHand=0.7, LeftLowerArm=0.3, LeftUpperArm=0.5, RightHand=0.7, RightLowerArm=0.3, RightUpperArm=0.5,
        LowerTorso=0.3, UpperTorso=0.5, Head=0.5
    }

    function scRemoveParticles(char)
        if not char then return end
        for _, pn in ipairs(scR15) do
            local p = char:FindFirstChild(pn)
            if p then
                local s1 = p:FindFirstChild("SC_Stars")
                local s2 = p:FindFirstChild("SC_Specks")
                if s1 then pcall(function() s1:Destroy() end) end
                if s2 then pcall(function() s2:Destroy() end) end
            end
        end
    end

    function scApplyStars(char)
        if not char then return end
        for _, pn in ipairs(scR15) do
            local p = char:FindFirstChild(pn)
            if not p then continue end
            pcall(function()
                local e = Instance.new("ParticleEmitter")
                e.Name = "SC_Stars"
                e.Lifetime = NumberRange.new(0.45, 0.9)
                e.LockedToPart = true
                e.LightEmission = 1
                e.Color = ColorSequence.new(scParticleColor)
                e.Speed = NumberRange.new(0.001, 0.001)
                e.Brightness = 3
                e.ZOffset = 1
                e.Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(0.508, 0.05, 0.05),
                    NumberSequenceKeypoint.new(1, 0)
                })
                e.Rate = 150
                e.Texture = "rbxassetid://1084996976"
                e.Transparency = NumberSequence.new(scParticleTrans)
                e.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                e.Parent = p
            end)
        end
    end

    function scApplySpecks(char)
        if not char then return end
        for _, pn in ipairs(scR15) do
            local p = char:FindFirstChild(pn)
            if not p then continue end
            pcall(function()
                local e = Instance.new("ParticleEmitter")
                e.Name = "SC_Specks"
                e.Lifetime = NumberRange.new(0.22, 0.22)
                e.SpreadAngle = Vector2.new(90, 90)
                e.LightEmission = 1
                e.Color = ColorSequence.new(scParticleColor)
                e.Speed = NumberRange.new(1, 1)
                e.Brightness = 4.2
                e.Size = NumberSequence.new(0.15)
                local t = scParticleTrans
                e.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, math.min(1, t + 0.8)),
                    NumberSequenceKeypoint.new(0.25, math.max(0, t - 0.1)),
                    NumberSequenceKeypoint.new(1, math.min(1, t + 0.8))
                })
                e.Rate = 100
                e.Texture = "rbxassetid://7216849703"
                e.Acceleration = Vector3.new(0, -15, 0)
                e.Parent = p
            end)
        end
    end

    local function scCacheChar(char)
        if not char then return end
        scOriginal = {}
        for _, pn in ipairs(scR15) do
            local p = char:FindFirstChild(pn)
            if p and (p:IsA("MeshPart") or p:IsA("BasePart")) then
                scOriginal[pn] = {
                    Material     = p.Material,
                    Color        = p.Color,
                    Transparency = p.Transparency,
                    Reflectance  = p.Reflectance,
                    TextureID    = p:IsA("MeshPart") and p.TextureID or nil
                }
            end
        end
        for _, d in ipairs(char:GetDescendants()) do
            if d:IsA("Shirt") then scOriginal._shirt = d.ShirtTemplate end
            if d:IsA("Pants") then scOriginal._pants = d.PantsTemplate end
        end
    end

    function scApply(char)
        if not char then return end
        for _, d in ipairs(char:GetDescendants()) do
            if d:IsA("Pants") or d:IsA("Shirt") then pcall(function() d:Destroy() end) end
        end
        for _, pn in ipairs(scR15) do
            local p = char:FindFirstChild(pn)
            if not p then continue end
            pcall(function()
                p.Material = Enum.Material[scMat] or Enum.Material.ForceField
                p.Color = scColor
                p.Reflectance = scReflect
                if p:IsA("MeshPart") then p.TextureID = "" end
                if scEffect ~= "heat" then p.Transparency = scTrans end
            end)
        end
        scRemoveParticles(char)
        if scParticles == "stars" then
            scApplyStars(char)
        elseif scParticles == "specks" then
            scApplySpecks(char)
        end
    end

    local function scRestore(char)
        if not char then return end
        scRemoveParticles(char)
        for _, pn in ipairs(scR15) do
            local p = char:FindFirstChild(pn)
            local d = scOriginal[pn]
            if p and d then
                pcall(function()
                    p.Material     = d.Material
                    p.Color        = d.Color
                    p.Transparency = d.Transparency
                    p.Reflectance  = d.Reflectance
                    if p:IsA("MeshPart") and d.TextureID then p.TextureID = d.TextureID end
                end)
            end
        end
        if scOriginal._shirt then
            pcall(function()
                local s = Instance.new("Shirt")
                s.ShirtTemplate = scOriginal._shirt
                s.Parent = char
            end)
        end
        if scOriginal._pants then
            pcall(function()
                local p = Instance.new("Pants")
                p.PantsTemplate = scOriginal._pants
                p.Parent = char
            end)
        end
    end

    local function scStopHeat()
        if scHeatConn then scHeatConn:Disconnect(); scHeatConn = nil end
        scHeatTime = 0; scHeatLast = 0
    end

    local function scStartHeat(char)
        scStopHeat()
        scHeatLast = tick()
        scHeatConn = RunService.Heartbeat:Connect(function()
            if not scEnabled or scEffect ~= "heat" then scStopHeat(); return end
            if not char or not char.Parent then return end
            local now = tick()
            local dt = now - scHeatLast
            scHeatLast = now
            scHeatTime = scHeatTime + dt
            local pulse = math.sin(scHeatTime * 2) * 0.5 + 0.5
            for _, pn in ipairs(scR15) do
                local p = char:FindFirstChild(pn)
                if p and scHeatMap[pn] then
                    local base = scHeatMap[pn]
                    pcall(function() p.Transparency = base + (math.min(base + 0.2, 1) - base) * pulse end)
                end
            end
        end)
    end

    function scEnable()
        local char = LocalPlayer.Character
        scCacheChar(char)
        scApply(char)
        if scEffect == "heat" then scStartHeat(char) end
        if scCharConn then scCharConn:Disconnect() end
        scCharConn = LocalPlayer.CharacterAdded:Connect(function(c)
            c:WaitForChild("Humanoid")
            task.wait(1.1)
            if not scEnabled then return end
            scCacheChar(c)
            scApply(c)
            if scEffect == "heat" then scStartHeat(c) end
        end)
    end

    function scDisable()
        scStopHeat()
        if scCharConn then scCharConn:Disconnect(); scCharConn = nil end
        scRestore(LocalPlayer.Character)
    end
end

local HitChamsSettings = {
    Enabled      = false,
    Material     = "Neon",
    Color        = Color3.fromRGB(255, 0, 0),
    Transparency = 0.5,
    Duration     = 2
}
local createHitChams
do
    local lastChamsTime = 0
    local hcBodyParts = {
        "Head","UpperTorso","LowerTorso",
        "LeftUpperArm","LeftLowerArm","LeftHand",
        "RightUpperArm","RightLowerArm","RightHand",
        "LeftUpperLeg","LeftLowerLeg","LeftFoot",
        "RightUpperLeg","RightLowerLeg","RightFoot",
        "Torso","Left Arm","Right Arm","Left Leg","Right Leg"
    }
    function createHitChams(target)
        if not HitChamsSettings.Enabled then return end
        local now = tick()
        if now - lastChamsTime < 0.15 then return end
        lastChamsTime = now
        if not target or not target.Character then return end
        local char = target.Character
        pcall(function()
            char.Archivable = true
            local clone = char:Clone()
            clone.Name = "HitChams_Clone"
            for _, child in ipairs(clone:GetChildren()) do
                if child:IsA("BasePart") then
                    local keep = false
                    for _, name in ipairs(hcBodyParts) do
                        if child.Name == name then keep = true; break end
                    end
                    if not keep then child:Destroy() end
                elseif child:IsA("Accessory") or child:IsA("Tool") or child:IsA("Shirt") or child:IsA("Pants") or child:IsA("Hat") then
                    child:Destroy()
                end
            end
            if clone:FindFirstChildOfClass("Humanoid") then clone:FindFirstChildOfClass("Humanoid"):Destroy() end
            local mat = Enum.Material[HitChamsSettings.Material] or Enum.Material.Neon
            for _, part in ipairs(clone:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    part.Anchored = true
                    part.Transparency = HitChamsSettings.Transparency
                    part.Color = HitChamsSettings.Color
                    part.Material = mat
                    if part.Name == "Head" and part:FindFirstChild("face") then
                        part.face:Destroy()
                    end
                end
            end
            clone.Parent = workspace
            local twInfo = TweenInfo.new(HitChamsSettings.Duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            for _, part in ipairs(clone:GetChildren()) do
                if part:IsA("BasePart") then
                    TweenService:Create(part, twInfo, {Transparency = 1}):Play()
                end
            end
            task.delay(HitChamsSettings.Duration, function()
                if clone and clone.Parent then clone:Destroy() end
            end)
        end)
    end
end

local DamageNumbersSettings = {
    Enabled = false,
    Color   = Color3.fromRGB(255, 255, 255)
}
local function showDamage(player, amount)
    if not DamageNumbersSettings.Enabled or not player or not player.Character then return end
    local head = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
    if not head then return end
    pcall(function()
        local gui = head:FindFirstChild("LexhancementsDamageContainer")
        if not gui then
            gui = Instance.new("BillboardGui")
            gui.Name = "LexhancementsDamageContainer"
            gui.Parent = head
            gui.Adornee = head
            gui.Size = UDim2.new(0, 100, 0, 50)
            gui.StudsOffset = Vector3.new(0, 2, 0)
            gui.AlwaysOnTop = true
            gui.MaxDistance = 500
            gui.Enabled = true
        end
        local lbl = Instance.new("TextLabel", gui)
        lbl.Text = tostring(math.floor(amount))
        lbl.TextColor3 = DamageNumbersSettings.Color
        lbl.TextSize = 28 + math.clamp(amount / 5, 0, 14)
        lbl.Font = Enum.Font.SourceSansBold
        lbl.BackgroundTransparency = 1
        lbl.Size = UDim2.new(1, 0, 0, 32)
        lbl.TextStrokeTransparency = 0.3
        lbl.Position = UDim2.new(0.5, -50 + math.random(-20, 20), 0, math.random(-15, 15))
        local t1 = TweenService:Create(lbl, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -50, 0, -80)})
        t1:Play()
        t1.Completed:Connect(function()
            local t2 = TweenService:Create(lbl, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextTransparency = 1, TextStrokeTransparency = 1})
            t2:Play()
            t2.Completed:Connect(function() lbl:Destroy() end)
        end)
    end)
end

local ChinaHatSettings = {
    Enabled            = false,
    Color              = Color3.fromRGB(128, 18, 255),
    Rainbow            = false,
    Radius             = 1,
    Height             = 0.75,
    HatTransparency    = 0.35,
    CircleTransparency = 1
}
local chinaLines = {}
local chinaTris = {}
for i = 1, 25 do
    chinaLines[i] = Drawing.new("Line")
    chinaLines[i].ZIndex = 2
    chinaLines[i].Thickness = 2
    chinaLines[i].Visible = false

    chinaTris[i] = Drawing.new("Triangle")
    chinaTris[i].ZIndex = 1
    chinaTris[i].Filled = true
    chinaTris[i].Visible = false
end

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local head = char and char:FindFirstChild("Head")
    local hum  = char and char:FindFirstChildOfClass("Humanoid")
    local pass = ChinaHatSettings.Enabled and head and hum and hum.Health > 0 and not _hidden

    if pass then
        local pos = head.Position + Vector3.new(0, 0.75, 0)
        local topWorld = pos + Vector3.new(0, ChinaHatSettings.Height, 0)
        local tau = math.pi * 2

        for i = 1, 25 do
            local color = ChinaHatSettings.Rainbow and Color3.fromHSV((tick() % 5 / 5 - (i / 25)) % 1, 0.5, 1) or ChinaHatSettings.Color
            local a1 = (i / 25) * tau
            local a2 = ((i + 1) / 25) * tau

            local w1 = pos + Vector3.new(math.cos(a1), 0, math.sin(a1)) * ChinaHatSettings.Radius
            local w2 = pos + Vector3.new(math.cos(a2), 0, math.sin(a2)) * ChinaHatSettings.Radius

            local s1, on1 = Camera:WorldToViewportPoint(w1)
            local s2, on2 = Camera:WorldToViewportPoint(w2)
            local st, ont = Camera:WorldToViewportPoint(topWorld)

            if on1 and on2 and ont and s1.Z > 0 and s2.Z > 0 and st.Z > 0 then
                chinaLines[i].From = Vector2.new(s1.X, s1.Y)
                chinaLines[i].To   = Vector2.new(s2.X, s2.Y)
                chinaLines[i].Color = color
                chinaLines[i].Transparency = ChinaHatSettings.CircleTransparency
                chinaLines[i].Visible = true

                chinaTris[i].PointA = Vector2.new(st.X, st.Y)
                chinaTris[i].PointB = Vector2.new(s1.X, s1.Y)
                chinaTris[i].PointC = Vector2.new(s2.X, s2.Y)
                chinaTris[i].Color = color
                chinaTris[i].Transparency = ChinaHatSettings.HatTransparency
                chinaTris[i].Visible = true
            else
                chinaLines[i].Visible = false
                chinaTris[i].Visible = false
            end
        end
    else
        for i = 1, 25 do
            chinaLines[i].Visible = false
            chinaTris[i].Visible = false
        end
    end
end)

local SelfAuraSettings = {
    Enabled = false,
    Type    = "Cloak Aura",
    Color   = Color3.fromRGB(133, 220, 255)
}
local sa2Clear, sa2UpdateColor, sa2Refresh
do
    local sa2Attachments = {}
    local sa2Models      = {}
    local sa2ParticleAuraCache = {}

    local sa2ModelIDs = {
        ["Cloak Aura"]   = 99046723611000,
        ["Sweet Hearth"] = 91724768175470,
        ["Ethereal"]     = 97041568674250,
    }
    local sa2ParticleAuraIDs = {
        ["Starlight"] = 134645216613107,
        ["Heavenly"]  = 139300897520961,
        ["Ribbon"]    = 132069507632161,
        ["Sakura"]    = 81755778619404,
        ["Angel"]     = 97658130917593,
        ["Wind"]      = 80694081850877,
        ["Flow"]      = 119913533725648,
        ["Star"]      = 73754563740680,
    }

    function sa2Clear()
    for _, a in ipairs(sa2Attachments) do pcall(function() a:Destroy() end) end
    sa2Attachments = {}
    for _, m in ipairs(sa2Models) do pcall(function() m:Destroy() end) end
    sa2Models = {}
end

local function sa2MakeAtt(parent, cf)
    local a = Instance.new("Attachment")
    a.CFrame = cf
    a.Parent = parent
    table.insert(sa2Attachments, a)
    return a
end

local function sa2AttachModel(assetId)
    local char = LocalPlayer.Character; if not char then return end
    local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"); if not torso then return end
    local ok, model = pcall(function() return game:GetObjects("rbxassetid://"..assetId)[1] end)
    if not ok or not model then return end
    model.Parent = char
    if model:IsA("Accessory") then
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then hum:AddAccessory(model); table.insert(sa2Models, model) end
        return
    end
    for _, p in ipairs(model:GetDescendants()) do
        if p:IsA("BasePart") then
            p.CanCollide = false; p.Massless = true; p.Anchored = false; p.CanTouch = false; p.CanQuery = false
        end
    end
    if model:IsA("Model") then
        model:PivotTo(torso.CFrame)
        for _, p in ipairs(model:GetDescendants()) do
            if p:IsA("BasePart") then
                local m6 = Instance.new("Motor6D")
                m6.Part0 = torso; m6.Part1 = p; m6.C0 = torso.CFrame:ToObjectSpace(p.CFrame); m6.Parent = torso
            end
        end
    elseif model:IsA("BasePart") then
        model.CFrame = torso.CFrame
        local m6 = Instance.new("Motor6D")
        m6.Part0 = torso; m6.Part1 = model; m6.C0 = torso.CFrame:ToObjectSpace(model.CFrame); m6.Parent = torso
    end
    table.insert(sa2Models, model)
end

local function sa2AttachParticleAura(name, assetId)
    local char = LocalPlayer.Character; if not char then return end
    local source = sa2ParticleAuraCache[name]
    if not source then
        local ok, obj = pcall(function() return game:GetObjects("rbxassetid://"..assetId)[1] end)
        if not ok or not obj then return end
        sa2ParticleAuraCache[name] = obj
        source = obj
    end
    local ok, cloned = pcall(function() return source:Clone() end)
    if not ok or not cloned then return end
    for _, part in ipairs(cloned:GetChildren()) do
        local target = char:FindFirstChild(part.Name)
        if target then
            for _, child in ipairs(part:GetChildren()) do
                child.Parent = target
                table.insert(sa2Attachments, child)
            end
        end
    end
    cloned:Destroy()
end

local function sa2CreateAngelic(char)
    local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"); if not torso then return end
    local a1 = sa2MakeAtt(torso, CFrame.new(-1.012,0.5,0.852,0.966,0,0.259,0,1,0,-0.259,0,0.966))
    local function makeE(parent, dir)
        local e = Instance.new("ParticleEmitter")
        e.Lifetime = NumberRange.new(1, 1); e.LockedToPart = true; e.LightEmission = 1
        e.Color = ColorSequence.new(SelfAuraSettings.Color); e.Speed = NumberRange.new(0.05, 0.05)
        e.Size = NumberSequence.new(2.75, 3.5); e.Rate = 4
        e.Texture = "http://www.roblox.com/asset/?id=13267054240"
        e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.2,0),NumberSequenceKeypoint.new(0.8,0),NumberSequenceKeypoint.new(1,1)})
        e.EmissionDirection = dir; e.Orientation = Enum.ParticleOrientation.VelocityPerpendicular; e.Parent = parent
    end
    makeE(a1, Enum.NormalId.Back)
    local a2 = sa2MakeAtt(torso, CFrame.new(1.167,0.5,0.852,0.966,0,-0.259,0,1,0,0.259,0,0.966))
    makeE(a2, Enum.NormalId.Front)
    local a3 = sa2MakeAtt(torso, CFrame.new(0,0.3,0))
    local e3 = Instance.new("ParticleEmitter")
    e3.Lifetime = NumberRange.new(2, 2); e3.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
    e3.SpreadAngle = Vector2.new(180, 180); e3.LockedToPart = true; e3.LightEmission = 1
    e3.Color = ColorSequence.new(SelfAuraSettings.Color); e3.Speed = NumberRange.new(0.5, 0.5); e3.Brightness = 2
    e3.Size = NumberSequence.new(3, 4); e3.Rate = 5; e3.Texture = "rbxassetid://11402221943"
    e3.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    e3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.5,0.3),NumberSequenceKeypoint.new(1,1)})
    e3.Parent = a3
end

local function sa2CreateAmbient(char)
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local a = sa2MakeAtt(hrp, CFrame.new(0,-2.75,0))
    local e = Instance.new("ParticleEmitter")
    e.Lifetime = NumberRange.new(2, 2); e.SpreadAngle = Vector2.new(0.001, 0.001); e.LockedToPart = true
    e.LightEmission = 1; e.Color = ColorSequence.new(SelfAuraSettings.Color); e.Speed = NumberRange.new(0.001, 0.001)
    e.Brightness = 2; e.RotSpeed = NumberRange.new(-600, 600)
    e.Texture = "https://assetgame.roblox.com/asset/?id=12713358087"
    e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.3,1),NumberSequenceKeypoint.new(0.6,2.5),NumberSequenceKeypoint.new(0.8,4),NumberSequenceKeypoint.new(1,6)})
    e.Orientation = Enum.ParticleOrientation.VelocityPerpendicular; e.Parent = a
end

local function sa2CreateNimb(char)
    local head = char:FindFirstChild("Head"); if not head then return end
    local a = sa2MakeAtt(head, CFrame.new(-0.25,0.933,0.259,0.469,-0.25,-0.847,-0.117,0.933,-0.34,0.875,0.259,0.408))
    local e = Instance.new("ParticleEmitter")
    e.Lifetime = NumberRange.new(1, 1); e.SpreadAngle = Vector2.new(5, 5); e.LockedToPart = true
    e.LightEmission = 1; e.Color = ColorSequence.new(SelfAuraSettings.Color); e.Speed = NumberRange.new(0.001, 0.001)
    e.Brightness = 2; e.Size = NumberSequence.new(2.5, 3); e.RotSpeed = NumberRange.new(-400, 400); e.Rate = 7
    e.Texture = "rbxassetid://8819682608"
    e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.2,0),NumberSequenceKeypoint.new(0.8,0),NumberSequenceKeypoint.new(1,1)})
    e.Orientation = Enum.ParticleOrientation.VelocityPerpendicular; e.Parent = a
end

local function sa2CreateTornado(char)
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local a = sa2MakeAtt(hrp, CFrame.new(0,-3,0))
    local e = Instance.new("ParticleEmitter")
    e.LightEmission = 1; e.LockedToPart = true; e.Color = ColorSequence.new(SelfAuraSettings.Color)
    e.Speed = NumberRange.new(0.01, 0.01); e.Size = NumberSequence.new(6, 10)
    e.RotSpeed = NumberRange.new(360, 360); e.Rate = 1
    e.Texture = "http://www.roblox.com/asset/?id=8553497052"
    e.Orientation = Enum.ParticleOrientation.VelocityPerpendicular; e.Parent = a
end

local function sa2CreateSwirl(char)
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local a = sa2MakeAtt(hrp, CFrame.new(0,0,0))
    local e1 = Instance.new("ParticleEmitter")
    e1.Brightness = 10; e1.LockedToPart = true; e1.Lifetime = NumberRange.new(1, 1)
    e1.LightEmission = 0.4; e1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
    e1.Rate = 10; e1.RotSpeed = NumberRange.new(200, 400); e1.Rotation = NumberRange.new(-180, 180)
    e1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,3.0625),NumberSequenceKeypoint.new(0.642055,2),NumberSequenceKeypoint.new(1,0.75)})
    e1.Speed = NumberRange.new(3, 6); e1.SpreadAngle = Vector2.new(10, -10)
    e1.Texture = "rbxassetid://8047533775"; e1.Color = ColorSequence.new(SelfAuraSettings.Color)
    e1.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.170245,0.7),NumberSequenceKeypoint.new(0.22546,0.03125),
        NumberSequenceKeypoint.new(0.285276,0),NumberSequenceKeypoint.new(0.702454,0),NumberSequenceKeypoint.new(0.837423,0.9125),
        NumberSequenceKeypoint.new(1,1)
    })
    e1.Parent = a
end

local function sa2CreateBubble2(char)
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local a = sa2MakeAtt(hrp, CFrame.new(0,0,0))
    local e1 = Instance.new("ParticleEmitter")
    e1.LockedToPart = true; e1.Lifetime = NumberRange.new(0.333, 0.333); e1.LightEmission = 1
    e1.Rate = 12; e1.Rotation = NumberRange.new(-180, 180)
    e1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,4.8),NumberSequenceKeypoint.new(1,4.8)})
    e1.Speed = NumberRange.new(0, 0); e1.Texture = "rbxassetid://1084955012"; e1.Color = ColorSequence.new(SelfAuraSettings.Color)
    e1.Parent = a
end

local function sa2CreateAir(char)
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local a = sa2MakeAtt(hrp, CFrame.new(0,0,0))
    local e = Instance.new("ParticleEmitter")
    e.Brightness = 15; e.Lifetime = NumberRange.new(2, 2); e.LightEmission = 1
    e.Orientation = Enum.ParticleOrientation.VelocityParallel; e.Rate = 75
    e.RotSpeed = NumberRange.new(200, 200); e.ShapeInOut = Enum.ParticleEmitterShapeInOut.InAndOut
    e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,7),NumberSequenceKeypoint.new(1,7)})
    e.Speed = NumberRange.new(0.01, 0.01); e.SpreadAngle = Vector2.new(-360, 360)
    e.Texture = "rbxassetid://10558425570"; e.LockedToPart = true; e.Color = ColorSequence.new(SelfAuraSettings.Color)
    e.Parent = a
end

local function sa2CreateRitual(char)
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local a = sa2MakeAtt(hrp, CFrame.new(0,-2.99,0))
    local e1 = Instance.new("ParticleEmitter")
    e1.Brightness = 7; e1.LockedToPart = true; e1.Lifetime = NumberRange.new(1, 1); e1.LightEmission = 1
    e1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular; e1.Rate = 1
    e1.RotSpeed = NumberRange.new(300, 300)
    e1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,5),NumberSequenceKeypoint.new(1,5)})
    e1.Speed = NumberRange.new(0.001, 0.001); e1.Texture = "rbxassetid://8920073892"; e1.ZOffset = 1
    e1.Color = ColorSequence.new(SelfAuraSettings.Color)
    e1.Parent = a
end

local function sa2CreateRain(char)
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local a = sa2MakeAtt(hrp, CFrame.new(0,3.5,0))
    local e = Instance.new("ParticleEmitter")
    e.Color = ColorSequence.new(SelfAuraSettings.Color)
    e.EmissionDirection = Enum.NormalId.Bottom
    e.Lifetime = NumberRange.new(2, 2); e.LightInfluence = 1; e.Rate = 100
    e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.5),NumberSequenceKeypoint.new(1,0.5)})
    e.Speed = NumberRange.new(25, 25); e.Texture = "rbxassetid://419625073"
    e.Parent = a
end

    function sa2UpdateColor(c)
    SelfAuraSettings.Color = c
    if not SelfAuraSettings.Enabled then return end
    for _, att in ipairs(sa2Attachments) do
        if att and att.Parent then
            for _, desc in ipairs(att:GetDescendants()) do
                if desc:IsA("ParticleEmitter") or desc:IsA("Beam") or desc:IsA("Trail") then
                    pcall(function() desc.Color = ColorSequence.new(c) end)
                end
            end
            if att:IsA("ParticleEmitter") or att:IsA("Beam") or att:IsA("Trail") then
                pcall(function() att.Color = ColorSequence.new(c) end)
            end
        end
    end
end

    local function sa2ApplyOne(t, char)
        if t == "Angelic" then sa2CreateAngelic(char)
        elseif t == "Ambient" then sa2CreateAmbient(char)
        elseif t == "Nimb" then sa2CreateNimb(char)
        elseif t == "Tornado" then sa2CreateTornado(char)
        elseif t == "Swirl" then sa2CreateSwirl(char)
        elseif t == "Bubble" then sa2CreateBubble2(char)
        elseif t == "Air" then sa2CreateAir(char)
        elseif t == "Ritual" then sa2CreateRitual(char)
        elseif t == "Rain" then sa2CreateRain(char)
        elseif sa2ModelIDs[t] then sa2AttachModel(sa2ModelIDs[t])
        elseif sa2ParticleAuraIDs[t] then sa2AttachParticleAura(t, sa2ParticleAuraIDs[t])
        end
    end

    function sa2Refresh()
        sa2Clear()
        if not SelfAuraSettings.Enabled then return end
        local char = LocalPlayer.Character; if not char then return end
        local t = SelfAuraSettings.Type
        if type(t) == "table" then
            for name, active in pairs(t) do
                if active == true or type(name) == "number" then
                    local aName = type(name) == "number" and active or name
                    sa2ApplyOne(aName, char)
                end
            end
        elseif type(t) == "string" then
            sa2ApplyOne(t, char)
        end
        sa2UpdateColor(SelfAuraSettings.Color)
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    if SelfAuraSettings.Enabled then
        char:WaitForChild("Humanoid", 5)
        task.wait(1)
        if SelfAuraSettings.Enabled then sa2Refresh() end
    end
end)

local ToolChamsSettings = {
    Enabled       = false,
    Color         = Color3.fromRGB(155, 125, 175),
    Transparency  = 0,
    Reflectance   = 0,
    Material      = "ForceField",
    Particles     = "none",
    ParticleColor = Color3.fromRGB(255, 255, 255),
    ParticleTrans = 0
}
local tcTracked = {}
local tcRemoveParticles, tcApplyStars, tcApplySpecks, tcApply, tcEnable, tcDisable
do
    local tcCached  = {}
    local tcCharConn, tcAddedConn, tcRemovedConn

    function tcRemoveParticles(tool)
        if not tool then return end
        for _, p in ipairs(tool:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("MeshPart") then
                local s1 = p:FindFirstChild("TC_Stars")
                local s2 = p:FindFirstChild("TC_Specks")
                if s1 then pcall(function() s1:Destroy() end) end
                if s2 then pcall(function() s2:Destroy() end) end
            end
        end
    end

    function tcApplyStars(tool)
        if not tool then return end
        for _, p in ipairs(tool:GetDescendants()) do
            if (p:IsA("BasePart") or p:IsA("MeshPart")) and p.Name ~= "Handle" then
                pcall(function()
                    local e = Instance.new("ParticleEmitter")
                    e.Name = "TC_Stars"; e.Lifetime = NumberRange.new(0.45, 0.9); e.LockedToPart = true; e.LightEmission = 1
                    e.Color = ColorSequence.new(ToolChamsSettings.ParticleColor); e.Speed = NumberRange.new(0.001, 0.001); e.Brightness = 3; e.ZOffset = 1
                    e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.508,0.05,0.05),NumberSequenceKeypoint.new(1,0)})
                    e.Rate = 150; e.Texture = "rbxassetid://1084996976"; e.Transparency = NumberSequence.new(ToolChamsSettings.ParticleTrans)
                    e.Orientation = Enum.ParticleOrientation.VelocityPerpendicular; e.Parent = p
                end)
            end
        end
    end

    function tcApplySpecks(tool)
        if not tool then return end
        for _, p in ipairs(tool:GetDescendants()) do
            if (p:IsA("BasePart") or p:IsA("MeshPart")) and p.Name ~= "Handle" then
                pcall(function()
                    local e = Instance.new("ParticleEmitter")
                    e.Name = "TC_Specks"; e.Lifetime = NumberRange.new(0.22, 0.22); e.SpreadAngle = Vector2.new(90, 90); e.LightEmission = 1
                    e.Color = ColorSequence.new(ToolChamsSettings.ParticleColor); e.Speed = NumberRange.new(1, 1); e.Brightness = 4.2
                    e.Size = NumberSequence.new(0.15); local t = ToolChamsSettings.ParticleTrans
                    e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,math.min(1,t+0.8)),NumberSequenceKeypoint.new(0.25,math.max(0,t-0.1)),NumberSequenceKeypoint.new(1,math.min(1,t+0.8))})
                    e.Rate = 100; e.Texture = "rbxassetid://7216849703"; e.Acceleration = Vector3.new(0, -15, 0); e.Parent = p
                end)
            end
        end
    end

    function tcApply(tool)
        if not tool or not ToolChamsSettings.Enabled then return end
        for _, p in ipairs(tool:GetDescendants()) do
            if (p:IsA("BasePart") or p:IsA("MeshPart")) and p.Name ~= "Handle" then
                pcall(function()
                    p.Material = Enum.Material[ToolChamsSettings.Material] or Enum.Material.ForceField
                    p.Color = ToolChamsSettings.Color
                    p.Transparency = ToolChamsSettings.Transparency
                    p.Reflectance = ToolChamsSettings.Reflectance
                    if p:IsA("MeshPart") then p.TextureID = "" end
                end)
            end
        end
        tcRemoveParticles(tool)
        if ToolChamsSettings.Particles == "stars" then
            tcApplyStars(tool)
        elseif ToolChamsSettings.Particles == "specks" then
            tcApplySpecks(tool)
        end
    end

    local function tcCacheTool(tool)
        if not tool or tcCached[tool] then return end
        tcCached[tool] = {}
        for _, p in ipairs(tool:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("MeshPart") then
                tcCached[tool][p] = {Material = p.Material, Color = p.Color, Transparency = p.Transparency, Reflectance = p.Reflectance, TextureID = p:IsA("MeshPart") and p.TextureID or nil}
            end
        end
    end

    local function tcRestoreTool(tool)
        if not tool then return end
        tcRemoveParticles(tool)
        local cache = tcCached[tool]
        if not cache then return end
        for p, d in pairs(cache) do
            if p and p.Parent then
                pcall(function()
                    p.Material = d.Material; p.Color = d.Color; p.Transparency = d.Transparency; p.Reflectance = d.Reflectance
                    if p:IsA("MeshPart") and d.TextureID then p.TextureID = d.TextureID end
                end)
            end
        end
    end

    local function tcApplyAll()
        local char = LocalPlayer.Character; if not char then return end
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Tool") and not tcTracked[child] then tcCacheTool(child); tcTracked[child] = true end
            if child:IsA("Tool") then tcApply(child) end
        end
    end

    local function tcSetupChar(char)
        if tcAddedConn then tcAddedConn:Disconnect() end
        if tcRemovedConn then tcRemovedConn:Disconnect() end
        tcAddedConn = char.ChildAdded:Connect(function(c)
            if c:IsA("Tool") and ToolChamsSettings.Enabled then
                task.wait(0.1)
                tcCacheTool(c); tcTracked[c] = true; tcApply(c)
            end
        end)
        tcRemovedConn = char.ChildRemoved:Connect(function(c)
            if c:IsA("Tool") then tcTracked[c] = nil end
        end)
    end

    function tcEnable()
        tcTracked = {}; tcCached = {}
        local char = LocalPlayer.Character
        if char then tcApplyAll(); tcSetupChar(char) end
        if tcCharConn then tcCharConn:Disconnect() end
        tcCharConn = LocalPlayer.CharacterAdded:Connect(function(c)
            tcTracked = {}; tcCached = {}
            task.wait(0.5)
            if ToolChamsSettings.Enabled then tcApplyAll(); tcSetupChar(c) end
        end)
    end

    function tcDisable()
        if tcCharConn then tcCharConn:Disconnect(); tcCharConn = nil end
        if tcAddedConn then tcAddedConn:Disconnect(); tcAddedConn = nil end
        if tcRemovedConn then tcRemovedConn:Disconnect(); tcRemovedConn = nil end
        for tool in pairs(tcTracked) do
            if tool and tool.Parent then tcRestoreTool(tool) end
        end
        tcTracked = {}; tcCached = {}
    end
end

local lastLocalShotTime = 0
local function listenLocalToolActivation(char)
    if not char then return end
    local function bindTool(tool)
        if tool:IsA("Tool") then
            tool.Activated:Connect(function()
                lastLocalShotTime = tick()
            end)
        end
    end
    for _, child in ipairs(char:GetChildren()) do bindTool(child) end
    char.ChildAdded:Connect(bindTool)
end
if LocalPlayer.Character then listenLocalToolActivation(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(listenLocalToolActivation)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Tool") then
            lastLocalShotTime = tick()
        end
    end
end)

pcall(function()
    local rawmt = getrawmetatable and getrawmetatable(game)
    if rawmt then
        local setreadonly = setreadonly or make_writeable
        local oldNamecall = rawmt.__namecall
        if setreadonly then setreadonly(rawmt, false) end
        rawmt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod and getnamecallmethod()
            if method == "FireServer" then
                lastLocalShotTime = tick()
            end
            return oldNamecall(self, ...)
        end)
        if setreadonly then setreadonly(rawmt, true) end
    end
end)

do
    local function bindTool(tool)
        if tool:IsA("Tool") then
            tool.Activated:Connect(function()
                lastLocalShotTime = tick()
            end)
        end
    end
    if LocalPlayer.Character then
        for _, item in ipairs(LocalPlayer.Character:GetChildren()) do bindTool(item) end
        LocalPlayer.Character.ChildAdded:Connect(bindTool)
    end
    LocalPlayer.CharacterAdded:Connect(function(char)
        for _, item in ipairs(char:GetChildren()) do bindTool(item) end
        char.ChildAdded:Connect(bindTool)
    end)
end

local function bindPlayerHealth(plr)
    if plr == LocalPlayer then return end
    local function onChar(char)
        local hum = char:WaitForChild("Humanoid", 3)
        if not hum then return end
        local lastHp = hum.Health
        hum.HealthChanged:Connect(function(newHp)
            if newHp < lastHp then
                local dmg = math.floor(lastHp - newHp)
                local myChar = LocalPlayer.Character
                local myTool = myChar and myChar:FindFirstChildOfClass("Tool")
                if myChar and myTool then
                    local myHrp = myChar:FindFirstChild("HumanoidRootPart")
                    local targetHrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
                    local timeSinceAttack = tick() - lastLocalShotTime
                    local isMeleeRange = false
                    if myHrp and targetHrp then
                        isMeleeRange = (targetHrp.Position - myHrp.Position).Magnitude <= 14
                    end
                    if timeSinceAttack <= 0.6 or isMeleeRange then
                        createHitChams(plr)
                        showDamage(plr, dmg)
                    end
                end
            end
            lastHp = newHp
        end)
    end
    if plr.Character then task.spawn(onChar, plr.Character) end
    plr.CharacterAdded:Connect(onChar)
end

for _, p in ipairs(Players:GetPlayers()) do bindPlayerHealth(p) end
Players.PlayerAdded:Connect(bindPlayerHealth)

local CamFOVCircle = Drawing.new("Circle")
CamFOVCircle.Thickness    = 1.5
CamFOVCircle.NumSides     = 64
CamFOVCircle.Filled       = false
CamFOVCircle.Transparency = 1
CamFOVCircle.Color        = CamLockSettings.FOVColor
CamFOVCircle.Visible      = false
CamFOVCircle.ZIndex       = 2

local CamFOVCircleFill = Drawing.new("Circle")
CamFOVCircleFill.Thickness    = 1
CamFOVCircleFill.NumSides     = 64
CamFOVCircleFill.Filled       = true
CamFOVCircleFill.Transparency = CamLockSettings.FOVFillTransparency or 0.1
CamFOVCircleFill.Color        = CamLockSettings.FOVFillColor or CamLockSettings.FOVColor
CamFOVCircleFill.Visible      = false
CamFOVCircleFill.ZIndex       = 1

local SilentCircle = Drawing.new("Circle")
SilentCircle.Thickness = 2
SilentCircle.NumSides  = 64
SilentCircle.Filled    = false
SilentCircle.Visible   = false
SilentCircle.ZIndex    = 2

local SilentCircleFill = Drawing.new("Circle")
SilentCircleFill.Thickness    = 1
SilentCircleFill.NumSides     = 64
SilentCircleFill.Filled       = true
SilentCircleFill.Transparency = SilentAimSettings.FOVFillTransparency or 0.1
SilentCircleFill.Color        = SilentAimSettings.FOVFillColor or SilentAimSettings.FOVColor
SilentCircleFill.Visible      = false
SilentCircleFill.ZIndex       = 1

local GunHandler = nil
local OriginalGetAim = nil
local OriginalGetCanShoot = nil

pcall(function()
    local modules = ReplicatedStorage:FindFirstChild("Modules") or ReplicatedStorage
    local gh = modules:FindFirstChild("GunHandler") or modules:FindFirstChild("Framework")
    if gh then
        GunHandler = require(gh)
        OriginalGetAim = GunHandler and GunHandler.getAim
        OriginalGetCanShoot = GunHandler and GunHandler.getCanShoot
    end
end)

task.spawn(function()
    if not GunHandler then
        pcall(function()
            local modules = ReplicatedStorage:WaitForChild("Modules", 5) or ReplicatedStorage
            local gh = modules and (modules:WaitForChild("GunHandler", 5) or modules:FindFirstChild("Framework"))
            if gh then
                GunHandler = require(gh)
                OriginalGetAim = GunHandler and GunHandler.getAim
                OriginalGetCanShoot = GunHandler and GunHandler.getCanShoot
                if SilentAimSettings.Enabled and _applyGunHandlerHook then
                    _applyGunHandlerHook()
                end
            end
        end)
    end
end)

local TriggerBoxTop   = Drawing.new("Line")
local TriggerBoxBot   = Drawing.new("Line")
local TriggerBoxLeft  = Drawing.new("Line")
local TriggerBoxRight = Drawing.new("Line")
for _, l in ipairs({TriggerBoxTop, TriggerBoxBot, TriggerBoxLeft, TriggerBoxRight}) do
    l.Thickness = 1.5; l.Visible = false; l.ZIndex = 5
end

local _camBindState = false
local _camMode      = "Hold"
local _camBindObj   = nil

local _silentBindObj    = nil
local _silentGetNearest = nil
local _applyGunHandlerHook = nil
local _removeGunHandlerHook = nil

local SILENT_HITPARTS = {
    "Head", "HumanoidRootPart", "UpperTorso", "LowerTorso", "Torso",
    "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm",
    "LeftFoot", "RightFoot", "LeftLowerLeg", "RightLowerLeg", "LeftUpperLeg", "RightUpperLeg"
}

local CLOSEST_PARTS_LIST = {
    "Head", "HumanoidRootPart", "UpperTorso", "LowerTorso",
    "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm",
    "LeftFoot", "RightFoot", "LeftLowerLeg", "RightLowerLeg", "LeftUpperLeg", "RightUpperLeg"
}

local function getPart(char, name)
    if not char then return nil end
    local p = char:FindFirstChild(name)
    if p then return p end
    if name == "Torso" then
        return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
    elseif name == "UpperTorso" then
        return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
    elseif name == "LowerTorso" then
        return char:FindFirstChild("LowerTorso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    elseif name == "Legs" then
        return char:FindFirstChild("LeftLowerLeg") or char:FindFirstChild("RightLowerLeg") or char:FindFirstChild("Left Leg") or char:FindFirstChild("Right Leg") or char:FindFirstChild("HumanoidRootPart")
    elseif name == "LeftLowerArm" or name == "LeftUpperArm" or name == "LeftHand" then
        return char:FindFirstChild(name) or char:FindFirstChild("Left Arm") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("HumanoidRootPart")
    elseif name == "RightLowerArm" or name == "RightUpperArm" or name == "RightHand" then
        return char:FindFirstChild(name) or char:FindFirstChild("Right Arm") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("HumanoidRootPart")
    elseif name == "LeftLowerLeg" or name == "LeftUpperLeg" or name == "LeftFoot" then
        return char:FindFirstChild(name) or char:FindFirstChild("Left Leg") or char:FindFirstChild("LowerTorso") or char:FindFirstChild("HumanoidRootPart")
    elseif name == "RightLowerLeg" or name == "RightUpperLeg" or name == "RightFoot" then
        return char:FindFirstChild(name) or char:FindFirstChild("Right Leg") or char:FindFirstChild("LowerTorso") or char:FindFirstChild("HumanoidRootPart")
    end
    return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function isDeadOrKO(char)
    if not char then return true end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return true end
    local be = char:FindFirstChild("BodyEffects")
    if be then
        local ko = (be:FindFirstChild("K.O") and be["K.O"].Value == true)
            or (be:FindFirstChild("KO") and be.KO.Value == true)
            or (be:FindFirstChild("SDeath") and be.SDeath.Value == true)
            or (be:FindFirstChild("Dead") and be.Dead.Value == true)
        if ko then return true end
    end
    return false
end

local function isKO(plr)
    if not plr or not plr.Character then return true end
    return isDeadOrKO(plr.Character)
end

local function getPredictedPos(char, partName, amt)
    local part = getPart(char, partName); if not part then return nil end
    local hrp  = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return part.Position end
    local vel = hrp.AssemblyLinearVelocity
    if not vel or vel.Magnitude == 0 then pcall(function() vel = hrp.Velocity end) end
    if not vel then return part.Position end
    return part.Position + vel * amt
end

_G.Lexhancements_GlobalWhitelist = _G.Lexhancements_GlobalWhitelist or _G.KraviX_GlobalWhitelist or {}
_G.KraviX_GlobalWhitelist        = _G.Lexhancements_GlobalWhitelist

local function matchesWhitelist(whitelist, plr)
    if not plr or not whitelist then return false end
    if plr.UserId and (whitelist[plr.UserId] == true or whitelist[tostring(plr.UserId)] == true) then
        return true
    end
    if whitelist[plr.Name] == true or (plr.DisplayName and whitelist[plr.DisplayName] == true) then
        return true
    end
    local nameLower    = plr.Name:lower()
    local displayLower = plr.DisplayName and plr.DisplayName:lower() or ""
    if whitelist[nameLower] == true or (displayLower ~= "" and whitelist[displayLower] == true) then
        return true
    end
    for entry, val in pairs(whitelist) do
        if val then
            local e = tostring(entry):lower()
            if nameLower == e or (displayLower ~= "" and displayLower == e) then
                return true
            end
        end
    end
    return false
end

local function isWhitelisted(plr)
    if not plr then return false end
    if _G.Lexhancements_GlobalWhitelist and matchesWhitelist(_G.Lexhancements_GlobalWhitelist, plr) then
        return true
    end
    if CamLockSettings and CamLockSettings.Whitelist and matchesWhitelist(CamLockSettings.Whitelist, plr) then
        return true
    end
    if SilentAimSettings and SilentAimSettings.Whitelist and matchesWhitelist(SilentAimSettings.Whitelist, plr) then
        return true
    end
    if HitboxSettings and HitboxSettings.Whitelist and matchesWhitelist(HitboxSettings.Whitelist, plr) then
        return true
    end
    if ESPSettings and ESPSettings.Whitelist and matchesWhitelist(ESPSettings.Whitelist, plr) then
        return true
    end
    return false
end

local function findPlayersByPrefix(prefix)
    local p = prefix:lower()
    local found = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Name:lower():sub(1, #p) == p or plr.DisplayName:lower():sub(1, #p) == p then
            table.insert(found, plr)
        end
    end
    return found
end

local function getPing()
    local ping = 100
    local success, result = pcall(function()
        return LocalPlayer:GetNetworkPing() * 1000
    end)
    if success and result and result > 0 then
        return result
    end
    pcall(function()
        local item = StatsService.Network.ServerStatsItem["Data Ping"]
        if item then ping = item:GetValue() end
    end)
    return ping
end

local function getAutoPrediction()
    local ping = getPing()
    if ping < 40 then
        return 0.110
    elseif ping < 60 then
        return 0.123
    elseif ping < 80 then
        return 0.134
    elseif ping < 100 then
        return 0.143
    elseif ping < 130 then
        return 0.152
    elseif ping < 160 then
        return 0.162
    else
        return math.clamp(0.165 + ((ping - 160) / 1000) * 0.2, 0.165, 0.220)
    end
end

local function isCharInAir(char)
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        if hum.FloorMaterial == Enum.Material.Air then return true end
        local state = hum:GetState()
        if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall then
            return true
        end
    end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local velY = (hrp:IsA("BasePart") and hrp.AssemblyLinearVelocity and hrp.AssemblyLinearVelocity.Y) or hrp.Velocity.Y
        if math.abs(velY) > 5 then
            return true
        end
    end
    return false
end

local function resolveTargetPart(char, partName)
    if not char then return nil end
    local p = char:FindFirstChild(partName)
    if p then return p end
    if partName == "Legs" then
        return char:FindFirstChild("LeftLowerLeg") or char:FindFirstChild("RightLowerLeg") or char:FindFirstChild("Left Leg") or char:FindFirstChild("Right Leg") or char:FindFirstChild("HumanoidRootPart")
    elseif partName == "Torso" or partName == "UpperTorso" or partName == "LowerTorso" then
        return char:FindFirstChild("UpperTorso") or char:FindFirstChild("LowerTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    elseif partName == "LeftLowerArm" then
        return char:FindFirstChild("LeftLowerArm") or char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftHand") or char:FindFirstChild("HumanoidRootPart")
    elseif partName == "RightLowerArm" then
        return char:FindFirstChild("RightLowerArm") or char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand") or char:FindFirstChild("HumanoidRootPart")
    elseif partName == "LeftFoot" then
        return char:FindFirstChild("LeftFoot") or char:FindFirstChild("LeftLowerLeg") or char:FindFirstChild("Left Leg") or char:FindFirstChild("HumanoidRootPart")
    elseif partName == "RightFoot" then
        return char:FindFirstChild("RightFoot") or char:FindFirstChild("RightLowerLeg") or char:FindFirstChild("Right Leg") or char:FindFirstChild("HumanoidRootPart")
    end
    return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function GetCamLockFOVOrigin()
    if CamLockSettings.FOVMode == "Mouse" or CamLockSettings.FOVMode == "mouse" then
        return UserInputService:GetMouseLocation()
    else
        return Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    end
end

local function GetSilentFOVOrigin()
    if SilentAimSettings.FOVMode == "Center" then
        return Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    end
    return UserInputService:GetMouseLocation()
end

local _silentRayParams = RaycastParams.new()
_silentRayParams.FilterType = Enum.RaycastFilterType.Exclude

local function silentWallCheck(targetPart)
    if not targetPart or not targetPart.Parent then return false end
    local rayOrigin = Camera.CFrame.Position
    local rayDir = targetPart.Position - rayOrigin
    local ignoreList = {LocalPlayer.Character, targetPart.Parent, Camera}
    if workspace:FindFirstChild("Ignored") then
        table.insert(ignoreList, workspace.Ignored)
    end
    _silentRayParams.FilterDescendantsInstances = ignoreList
    local hit = workspace:Raycast(rayOrigin, rayDir, _silentRayParams)
    return hit == nil
end

local function toggleSilentAim()
    SilentAimSettings.Enabled = not SilentAimSettings.Enabled
    if SilentAimSettings.Enabled then
        _applyGunHandlerHook()
        notify("Silent Aim", "Silent Aim Enabled", 2, "success")
    else
        _removeGunHandlerHook()
    end
    if W.silentEnabled and W.silentEnabled.Set then
        pcall(function() W.silentEnabled:Set(SilentAimSettings.Enabled) end)
    end
end

local function GetCamLockTarget()
    local origin = GetCamLockFOVOrigin()
    local bestTarget, bestDist = nil, CamLockSettings.FOV or 200
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if not isWhitelisted(plr) then
                local partName = CamLockSettings.TargetPart
                if CamLockSettings.AirCheck and isCharInAir(plr.Character) then
                    partName = CamLockSettings.AirPart or "HumanoidRootPart"
                end
                local part = resolveTargetPart(plr.Character, partName)
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                if part and hum and hum.Health > 0 then
                    if not (CamLockSettings.KOCheck and isDeadOrKO(plr.Character)) then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                        if onScreen then
                            local mousePos = origin
                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                            if dist < bestDist then
                                if CamLockSettings.WallCheck then
                                    local rayOrigin = Camera.CFrame.Position
                                    local rayDir = part.Position - rayOrigin
                                    local rayParams = RaycastParams.new()
                                    rayParams.FilterType = Enum.RaycastFilterType.Exclude
                                    local ignoreList = {LocalPlayer.Character, plr.Character, Camera}
                                    if workspace:FindFirstChild("Ignored") then table.insert(ignoreList, workspace.Ignored) end
                                    rayParams.FilterDescendantsInstances = ignoreList
                                    local hitResult = workspace:Raycast(rayOrigin, rayDir, rayParams)
                                    if not hitResult then
                                        bestDist = dist
                                        bestTarget = part
                                    end
                                else
                                    bestDist = dist
                                    bestTarget = part
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return bestTarget
end

local function GetPlayerAtCrosshair()
    local closest, best = nil, math.huge
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and not isWhitelisted(plr) then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local sp, on = Camera:WorldToViewportPoint(hrp.Position)
                if on then
                    local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if d < best then closest = plr; best = d end
                end
            end
        end
    end
    return closest
end

local function matchesBind(inp, bind)
    if not bind then return false end
    while type(bind) == "table" and bind.Value ~= nil do bind = bind.Value end
    if typeof(bind) == "EnumItem" then
        if inp.UserInputType == Enum.UserInputType.Keyboard and bind.EnumType == Enum.KeyCode then
            return inp.KeyCode == bind
        end
        return inp.UserInputType == bind
    end
    if type(bind) == "string" then
        local raw = bind:match("%.([^%..]+)$") or bind
        if inp.UserInputType == Enum.UserInputType.Keyboard then
            return inp.KeyCode.Name:lower() == raw:lower()
        end
        return inp.UserInputType.Name:lower() == raw:lower()
    end
    if type(bind) == "table" then
        local btype = bind.type or bind.btype
        local bval  = bind.value
        while type(bval) == "table" and bval.Value ~= nil do bval = bval.Value end
        if not btype and not bval then return false end
        if btype == "mouse" or (bval and typeof(bval) == "EnumItem" and bval.EnumType == Enum.UserInputType) then
            if typeof(bval) == "EnumItem" then
                return inp.UserInputType == bval
            elseif type(bval) == "string" then
                local raw = bval:match("%.([^%..]+)$") or bval
                return inp.UserInputType.Name:lower() == raw:lower()
            end
        else
            if inp.UserInputType ~= Enum.UserInputType.Keyboard then return false end
            if typeof(bval) == "EnumItem" then
                return inp.KeyCode == bval
            elseif type(bval) == "string" then
                local raw = bval:match("%.([^%..]+)$") or bval
                return inp.KeyCode.Name:lower() == raw:lower()
            end
        end
    end
    return false
end

local function matchesMenuBind(inp, bind)
    if not bind then return false end
    if bind.type ~= "key" then return false end
    if inp.UserInputType ~= Enum.UserInputType.Keyboard then return false end
    if inp.KeyCode ~= bind.value then return false end
    if bind.value == Enum.KeyCode.Unknown then return false end
    return true
end

local mouse = LocalPlayer:GetMouse()

local function getGun()
    local char = LocalPlayer.Character; if not char then return nil end
    return char:FindFirstChildWhichIsA("Tool")
end

local function getTargetFromInst(inst)
    if not inst then return nil end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if inst == plr.Character or inst:IsDescendantOf(plr.Character) then
                if not isKO(plr) then return plr end
            end
        end
    end
    return nil
end

local function updateTriggerHitbox()
    local show = TriggerSettings.Enabled and TriggerSettings.ShowHitbox and not _hidden
    local target = getTargetFromInst(mouse.Target)
    if show and target and not isWhitelisted(target) and target.Character then
        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local sp, on = Camera:WorldToViewportPoint(hrp.Position)
            if on then
                local sz = TriggerSettings.HitboxSize; local cx, cy = sp.X, sp.Y
                local L, R, T2, B = cx - sz, cx + sz, cy - sz, cy + sz
                TriggerBoxTop.From   = Vector2.new(L, T2); TriggerBoxTop.To   = Vector2.new(R, T2)
                TriggerBoxBot.From   = Vector2.new(L, B);  TriggerBoxBot.To   = Vector2.new(R, B)
                TriggerBoxLeft.From  = Vector2.new(L, T2); TriggerBoxLeft.To  = Vector2.new(L, B)
                TriggerBoxRight.From = Vector2.new(R, T2); TriggerBoxRight.To = Vector2.new(R, B)
                for _, l in ipairs({TriggerBoxTop, TriggerBoxBot, TriggerBoxLeft, TriggerBoxRight}) do
                    l.Color = TriggerSettings.HitboxColor; l.Transparency = 1; l.Visible = true
                end
                return
            end
        end
    end
    for _, l in ipairs({TriggerBoxTop, TriggerBoxBot, TriggerBoxLeft, TriggerBoxRight}) do l.Visible = false end
end

local _lastTrigFire = 0
RunService.Heartbeat:Connect(function()
    updateTriggerHitbox()
    if not TriggerSettings.Active then return end
    local now = tick()
    if now - _lastTrigFire < TriggerSettings.FireInterval then return end
    local tp = getTargetFromInst(mouse.Target); if not tp or isWhitelisted(tp) then return end
    local tool = getGun(); if not tool then return end

    local isBlacklisted = false
    if type(TriggerSettings.Blacklist) == "table" then
        for name, enabled in pairs(TriggerSettings.Blacklist) do
            if enabled == true or type(name) == "number" then
                local pattern = type(name) == "number" and enabled or name
                if tool.Name:find(pattern, 1, true) then
                    isBlacklisted = true
                    break
                end
            end
        end
    end
    if isBlacklisted then return end

    task.spawn(function()
        local delayTime = TriggerSettings.Delay or 0
        if delayTime > 0 then task.wait(delayTime) end
        if TriggerSettings.Active and tp == getTargetFromInst(mouse.Target) then
            _lastTrigFire = tick()
            if TriggerSettings.PredictEnabled and tp.Character then
                local pos = getPredictedPos(tp.Character, "HumanoidRootPart", TriggerSettings.PredictAmount)
                if pos then Camera.CFrame = CFrame.new(Camera.CFrame.Position, pos) end
            end
            pcall(function() tool:Activate() end)
        end
    end)
end)

UserInputService.InputBegan:Connect(function(inp, proc)
    if UserInputService:GetFocusedTextBox() or not TriggerSettings.Enabled then return end
    if TriggerSettings.Keybind and matchesBind(inp, TriggerSettings.Keybind.Value) then
        TriggerSettings.Active = not TriggerSettings.Active
    end
end)

RunService.RenderStepped:Connect(function()
    if CamLockSettings.ShowFOV and CamLockSettings.Enabled and not _hidden then
        local origin = GetCamLockFOVOrigin()
        CamFOVCircle.Position = origin
        CamFOVCircle.Radius   = CamLockSettings.FOV
        CamFOVCircle.Color    = CamLockSettings.FOVColor
        CamFOVCircle.Visible  = true

        if CamLockSettings.FOVFill then
            CamFOVCircleFill.Position     = origin
            CamFOVCircleFill.Radius       = CamLockSettings.FOV
            CamFOVCircleFill.Color        = CamLockSettings.FOVFillColor
            CamFOVCircleFill.Transparency = CamLockSettings.FOVFillTransparency
            CamFOVCircleFill.Visible      = true
        else
            CamFOVCircleFill.Visible      = false
        end
    else
        CamFOVCircle.Visible     = false
        CamFOVCircleFill.Visible = false
    end

    local sOrigin = GetSilentFOVOrigin()
    local sVisible = SilentAimSettings.ShowFOV and SilentAimSettings.Enabled and not _hidden
    SilentCircle.Position = sOrigin
    SilentCircle.Radius   = SilentAimSettings.FOV
    SilentCircle.Color    = SilentAimSettings.FOVColor
    SilentCircle.Visible  = sVisible

    if sVisible and SilentAimSettings.FOVFill then
        SilentCircleFill.Position     = sOrigin
        SilentCircleFill.Radius       = SilentAimSettings.FOV
        SilentCircleFill.Color        = SilentAimSettings.FOVFillColor
        SilentCircleFill.Transparency = SilentAimSettings.FOVFillTransparency
        SilentCircleFill.Visible      = true
    else
        SilentCircleFill.Visible      = false
    end

    if SilentAimSettings.Enabled then
        if _silentGetNearest then _silentGetNearest() end
    else
        _silentTargetPart = nil
        _silentTargetPos  = nil
    end

    local isHolding = CamLockSettings.Enabled and (CamLockSettings.MobileActive or _camBindState)
    if isHolding then
        local targetPart = nil
        if CamLockSettings.Sticky and CamLockSettings.StickyTarget and CamLockSettings.StickyTarget.Parent then
            local stickyChar = CamLockSettings.StickyTarget.Parent
            local stickyPlr  = Players:GetPlayerFromCharacter(stickyChar)
            local stickyHum  = stickyChar:FindFirstChildOfClass("Humanoid")
            if stickyPlr and isWhitelisted(stickyPlr) then
                CamLockSettings.StickyTarget = nil
                targetPart = GetCamLockTarget()
                if CamLockSettings.Sticky then
                    CamLockSettings.StickyTarget = targetPart
                end
            elseif stickyHum and stickyHum.Health > 0 and not (CamLockSettings.KOCheck and isDeadOrKO(stickyChar)) then
                targetPart = CamLockSettings.StickyTarget
            else
                CamLockSettings.StickyTarget = nil
                targetPart = GetCamLockTarget()
                if CamLockSettings.Sticky then
                    CamLockSettings.StickyTarget = targetPart
                end
            end
        else
            targetPart = GetCamLockTarget()
            if CamLockSettings.Sticky then
                CamLockSettings.StickyTarget = targetPart
            end
        end

        if targetPart then
            local targetChar = targetPart.Parent
            local targetPlr  = targetChar and Players:GetPlayerFromCharacter(targetChar)
            if targetPlr and isWhitelisted(targetPlr) then
                CamLockSettings.StickyTarget = nil
                targetPart = nil
            end
        end

        if targetPart then
            local targetChar = targetPart.Parent
            local resolvedPart = targetPart
            if CamLockSettings.AirCheck and targetChar and isCharInAir(targetChar) then
                local airPartName = CamLockSettings.AirPart or "HumanoidRootPart"
                local p = resolveTargetPart(targetChar, airPartName)
                if p then resolvedPart = p end
            else
                local mainPartName = CamLockSettings.TargetPart or "HumanoidRootPart"
                local p = resolveTargetPart(targetChar, mainPartName)
                if p then resolvedPart = p end
            end

            local inDeadzone = false
            if CamLockSettings.DeadzoneEnabled then
                local screenPos, onScreen = Camera:WorldToViewportPoint(resolvedPart.Position)
                if onScreen then
                    local origin = GetCamLockFOVOrigin()
                    local distToCrosshair = (Vector2.new(screenPos.X, screenPos.Y) - origin).Magnitude
                    if distToCrosshair <= (CamLockSettings.Deadzone or 15) then
                        inDeadzone = true
                    end
                end
            end

            local targetPos = resolvedPart.Position
            local predAmount = CamLockSettings.Prediction
            if CamLockSettings.AutoPrediction then
                predAmount = getAutoPrediction()
            end

            if CamLockSettings.PredictionEnabled then
                local vel = resolvedPart.Velocity or Vector3.zero
                if resolvedPart:IsA("BasePart") and resolvedPart.AssemblyLinearVelocity and resolvedPart.AssemblyLinearVelocity.Magnitude > 0 then
                    vel = resolvedPart.AssemblyLinearVelocity
                end

                if CamLockSettings.AntiGroundShot and vel.Y < -5 then
                    vel = Vector3.new(vel.X, math.max(vel.Y * 0.1, -4), vel.Z)
                end

                targetPos = targetPos + (vel * predAmount)
            end

            if not inDeadzone then
                local currentCF = Camera.CFrame
                local diff = targetPos - currentCF.Position
                if diff.Magnitude > 0.001 then
                    local aimDir = diff.Unit
                    if CamLockSettings.ShakeEnabled and (CamLockSettings.ShakeAmount or 0) > 0 then
                        local shakePower = (CamLockSettings.ShakeAmount or 2) * 0.005
                        local shaken = aimDir + Vector3.new(
                            (math.random() - 0.5) * shakePower,
                            (math.random() - 0.5) * shakePower,
                            (math.random() - 0.5) * shakePower
                        )
                        if shaken.Magnitude > 0.001 then
                            aimDir = shaken.Unit
                        end
                    end
                    local targetCF = CFrame.lookAt(currentCF.Position, currentCF.Position + aimDir)
                    Camera.CFrame = currentCF:Lerp(targetCF, math.clamp(CamLockSettings.Smoothness, 0.01, 1))
                end
            end
        end
    else
        CamLockSettings.StickyTarget = nil
    end
end)

local function isCamInput(inp)
    if not _camBindObj then return false end
    return matchesBind(inp, _camBindObj.Value)
end

UserInputService.InputBegan:Connect(function(inp, proc)
    if UserInputService:GetFocusedTextBox() then return end
    if isCamInput(inp) and CamLockSettings.Enabled then
        if _camMode == "Toggle" then
            _camBindState = not _camBindState
            if not _camBindState then CamLockSettings.StickyTarget = nil end
        else
            _camBindState = true
        end
    end
    if _silentBindObj and matchesBind(inp, _silentBindObj.Value) then
        toggleSilentAim()
    end
end)

UserInputService.InputEnded:Connect(function(inp)
    if isCamInput(inp) and _camMode == "Hold" then
        _camBindState = false
        CamLockSettings.StickyTarget = nil
    end
end)

local _silentTargetPart = nil
local _silentTargetPos  = nil
local _silentHookActive = false

_silentGetNearest = function()

    local best = SilentAimSettings.FOV or 150
    local origin = GetSilentFOVOrigin()
    local foundPart, foundPos = nil, nil

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LocalPlayer or not plr.Character then continue end
        if isWhitelisted(plr) then continue end
        if SilentAimSettings.IgnoreKO and isDeadOrKO(plr.Character) then continue end
        local hum = plr.Character:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end

        local hrp = plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character:FindFirstChild("Head")
        if hrp then
            local dist = (hrp.Position - Camera.CFrame.Position).Magnitude
            if dist > (SilentAimSettings.MaxDistance or 500) then continue end
        end

        if SilentAimSettings.HitpartMode == "Closest Part" then
            for _, pName in ipairs(CLOSEST_PARTS_LIST) do
                local p = plr.Character:FindFirstChild(pName)
                if p then
                    local pDist = (p.Position - Camera.CFrame.Position).Magnitude
                    if pDist <= (SilentAimSettings.MaxDistance or 500) then
                        local sp, on = Camera:WorldToViewportPoint(p.Position)
                        if on then
                            local d = (Vector2.new(sp.X, sp.Y) - origin).Magnitude
                            if d <= best then
                                if not SilentAimSettings.WallCheck or silentWallCheck(p) then
                                    best = d
                                    foundPart = p
                                    foundPos = SilentAimSettings.PredictEnabled
                                        and getPredictedPos(plr.Character, pName, SilentAimSettings.PredictAmount)
                                        or p.Position
                                end
                            end
                        end
                    end
                end
            end
        else
            local part = getPart(plr.Character, SilentAimSettings.TargetPart)
            if part then
                local pDist = (part.Position - Camera.CFrame.Position).Magnitude
                if pDist <= (SilentAimSettings.MaxDistance or 500) then
                    local sp, on = Camera:WorldToViewportPoint(part.Position)
                    if on then
                        local d = (Vector2.new(sp.X, sp.Y) - origin).Magnitude
                        if d <= best then
                            if not SilentAimSettings.WallCheck or silentWallCheck(part) then
                                best = d
                                foundPart = part
                                foundPos = SilentAimSettings.PredictEnabled
                                    and getPredictedPos(plr.Character, SilentAimSettings.TargetPart, SilentAimSettings.PredictAmount)
                                    or part.Position
                            end
                        end
                    end
                end
            end
        end
    end

    _silentTargetPart = foundPart
    _silentTargetPos  = foundPos
end

_applyGunHandlerHook = function()
    if _silentHookActive then return end
    _silentHookActive = true

    if GunHandler and OriginalGetAim then
        GunHandler.getAim = function(origin, range)
            lastLocalShotTime = tick()
            if SilentAimSettings.Enabled and math.random(1, 100) <= SilentAimSettings.HitChance then
                if _silentGetNearest then _silentGetNearest() end
                if _silentTargetPart then
                    local tChar = _silentTargetPart.Parent
                    local tPlr = tChar and Players:GetPlayerFromCharacter(tChar)
                    if tPlr and isWhitelisted(tPlr) then
                        _silentTargetPart = nil
                        _silentTargetPos = nil
                    end
                end
                local aimPos = (_silentTargetPart and _silentTargetPos) or nil
                if aimPos then
                    local dir = aimPos - origin
                    if dir.Magnitude > 0.001 then
                        return dir.Unit, range
                    end
                end
            end
            local ok, a, b = pcall(OriginalGetAim, origin, range)
            if ok and a then
                return a, b
            end
            local defaultDir = Camera.CFrame.LookVector
            return defaultDir, range
        end
    end
end

_removeGunHandlerHook = function()
    _silentHookActive = false
    if GunHandler and OriginalGetAim then
        GunHandler.getAim = OriginalGetAim
    end
    _silentTargetPart = nil
    _silentTargetPos  = nil
end

local applyRapidFire
do
local State_RF = {
    rapidFireHooks      = {},
    rapidFireChildConns = {},
    isHolding           = false,
}
local Refs_RF = {
    rapidFireLoopRunning = false,
    rapidFireLoopThread  = nil,
}

local function hookToolForRapidFire(tool)
    if not tool or not tool:IsA("Tool") then return end
    local getconnections = getconnections or (debug and debug.getconnections)
    local getinfo        = debug.getinfo or (debug and debug.getinfo)
    local getupvalue     = debug.getupvalue or (debug and debug.getupvalue)
    local setupvalue     = debug.setupvalue or (debug and debug.setupvalue)

    local cd = tool:FindFirstChild("Cooldown") or tool:FindFirstChild("FireRate")
    if cd and cd:IsA("NumberValue") then
        pcall(function() cd.Value = 0 end)
    end

    if not getconnections or not getinfo or not getupvalue or not setupvalue then return end

    pcall(function()
        local conns = getconnections(tool.Activated)
        if not conns or #conns == 0 then
            conns = getconnections(tool.Equipped)
        end
        if not conns then return end

        for _, conn in ipairs(conns) do
            if conn and conn.Function then
                local info = getinfo(conn.Function, "u")
                if info then
                    for i = 1, info.nups do
                        local v = getupvalue(conn.Function, i)
                        if type(v) == "number" then
                            table.insert(State_RF.rapidFireHooks, {conn = conn, fn = conn.Function, index = i, original = v})
                            setupvalue(conn.Function, i, 0)
                        end
                    end
                end
            end
        end
    end)
end

local function startRapidFireLoop()
    if Refs_RF.rapidFireLoopRunning then return end
    Refs_RF.rapidFireLoopRunning = true
    Refs_RF.rapidFireLoopThread = task.spawn(function()
        while Refs_RF.rapidFireLoopRunning do
            local isPressed = State_RF.isHolding or UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
            if isPressed and RapidFireSettings.Enabled then
                local c = LocalPlayer.Character
                if c then
                    local t = c:FindFirstChildOfClass("Tool")
                    if t then
                        local a = t:FindFirstChild("Ammo")
                        if not a or (a:IsA("NumberValue") and a.Value > 0) or (a:IsA("IntValue") and a.Value > 0) then
                            pcall(function() t:Activate() end)
                        end
                    end
                end
            end
            local delayVal = RapidFireSettings.Delay or 0.08
            task.wait(delayVal)
        end
    end)
end

local function stopRapidFireLoop()
    Refs_RF.rapidFireLoopRunning = false
    if Refs_RF.rapidFireLoopThread then
        task.cancel(Refs_RF.rapidFireLoopThread)
        Refs_RF.rapidFireLoopThread = nil
    end
end

function applyRapidFire()
    if GunHandler then
        local origCanShoot = OriginalGetCanShoot or GunHandler.getCanShoot
        if type(origCanShoot) == "function" then
            GunHandler.getCanShoot = function(c, ...)
                if RapidFireSettings.Enabled then
                    return true
                end
                return origCanShoot(c, ...)
            end
        end
    end

    local setupvalue = debug.setupvalue or (debug and debug.setupvalue)
    for _, hook in ipairs(State_RF.rapidFireHooks) do
        pcall(function()
            if setupvalue and hook.fn then
                setupvalue(hook.fn, hook.index, hook.original)
            end
        end)
    end
    State_RF.rapidFireHooks = {}
    for _, conn in ipairs(State_RF.rapidFireChildConns) do
        if conn and conn.Disconnect then pcall(function() conn:Disconnect() end) end
    end
    State_RF.rapidFireChildConns = {}
    stopRapidFireLoop()

    if not RapidFireSettings.Enabled then
        if GunHandler and OriginalGetCanShoot then
            GunHandler.getCanShoot = OriginalGetCanShoot
        end
        return
    end

    local c = LocalPlayer.Character
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if c then
        for _, t in ipairs(c:GetChildren()) do hookToolForRapidFire(t) end
        local conn = c.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then task.wait(0.1); hookToolForRapidFire(child) end
        end)
        table.insert(State_RF.rapidFireChildConns, conn)
    end
    if bp then
        for _, t in ipairs(bp:GetChildren()) do hookToolForRapidFire(t) end
        local conn = bp.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then task.wait(0.1); hookToolForRapidFire(child) end
        end)
        table.insert(State_RF.rapidFireChildConns, conn)
    end
    startRapidFireLoop()
end

UserInputService.InputBegan:Connect(function(input, gp)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        State_RF.isHolding = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        State_RF.isHolding = false
    end
end)
end

RunService.Heartbeat:Connect(function()
    if SpeedSettings.Enabled and SpeedSettings.KeybindActive then
        local char = LocalPlayer.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = SpeedSettings.Value end
    end
end)

local _flyToggled = false
local startFly, stopFly
do
    local flyCore, flyWeld, flyPos, flyGyro
    local flyConnections = {}

    function startFly()
        if getgenv().Flying then return end
        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end

        getgenv().Flying = true

        if workspace:FindFirstChild("IgnoredVelocity") then pcall(function() workspace.IgnoredVelocity:Destroy() end) end

        flyCore = Instance.new("Part")
        flyCore.Name = "IgnoredVelocity"
        flyCore.Size = Vector3.new(0.05, 0.05, 0.05)
        flyCore.Anchored = false
        flyCore.CanCollide = false
        flyCore.CFrame = root.CFrame
        flyCore.Parent = workspace

        flyWeld = Instance.new("Weld", flyCore)
        flyWeld.Part0 = root
        flyWeld.Part1 = flyCore
        flyWeld.C0 = CFrame.new(0, 0, 0)
        flyWeld.C1 = CFrame.new(0, 0, 0)

        flyPos = Instance.new("BodyPosition", flyCore)
        flyPos.Name = "IgnoredVelocity"
        flyPos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
        flyPos.position = root.Position

        flyGyro = Instance.new("BodyGyro", flyCore)
        flyGyro.Name = "IgnoredVelocity"
        flyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyGyro.P = 9e4
        flyGyro.cframe = root.CFrame

        hum.PlatformStand = true
        hum.AutoJumpEnabled = false

        local conn = RunService.RenderStepped:Connect(function(dt)
            if not getgenv().Flying or UserInputService:GetFocusedTextBox() or not flyPos or not flyGyro then return end
            local cam = Camera
            if not cam then return end
            local speed = (FlySettings.Speed or 50) * dt * 2.5
            local currentPos = flyPos.position

            local dir = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end

            if dir.Magnitude > 0 then
                flyPos.position = currentPos + (dir.Unit * speed)
            end
            flyGyro.cframe = cam.CFrame
        end)
        table.insert(flyConnections, conn)
    end

    function stopFly()
        getgenv().Flying = false
        for _, conn in ipairs(flyConnections) do pcall(function() conn:Disconnect() end) end
        flyConnections = {}

        if flyCore then pcall(function() flyCore:Destroy() end) flyCore = nil end
        if workspace:FindFirstChild("IgnoredVelocity") then pcall(function() workspace.IgnoredVelocity:Destroy() end) end

        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.PlatformStand = false
                hum.AutoJumpEnabled = true
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                pcall(function()
                    root.AssemblyLinearVelocity = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero
                end)
            end
        end
    end
end

local HitboxSettings = {
    Enabled             = false,
    Size                = 15,
    Color               = Color3.fromRGB(255, 255, 255),
    Transparency        = 0.5,
    SingleTargetEnabled = false,
    SingleTargetPlayer  = nil,
    MultiTargetEnabled  = false,
    MultiTargetPlayers  = {},
    Whitelist           = {},
}
local revertAllHitboxes
local getPlayerUnderMouse
local _hitboxBindObj = nil

do
    local HitboxOriginal = {}
    local HitboxVisuals = {}

    local function applyToHRP(HRP)
        if not HitboxOriginal[HRP] then
            HitboxOriginal[HRP] = {
                Size = HRP.Size,
                CanCollide = HRP.CanCollide
            }
        end

        HRP.Size = Vector3.new(HitboxSettings.Size, HitboxSettings.Size, HitboxSettings.Size)
        HRP.CanCollide = false

        local sphere = HitboxVisuals[HRP]
        if not sphere or not sphere.Parent then
            sphere = Instance.new("Part")
            sphere.Name = "HitboxVisualizer"
            sphere.Material = Enum.Material.ForceField
            sphere.Color = HitboxSettings.Color
            sphere.Transparency = HitboxSettings.Transparency
            sphere.Size = Vector3.new(HitboxSettings.Size, HitboxSettings.Size, HitboxSettings.Size)
            sphere.Anchored = false
            sphere.CanCollide = false
            sphere.Massless = true
            sphere.Parent = workspace

            HitboxVisuals[HRP] = sphere
        else
            sphere.Color = HitboxSettings.Color
            sphere.Transparency = HitboxSettings.Transparency
            sphere.Size = Vector3.new(HitboxSettings.Size, HitboxSettings.Size, HitboxSettings.Size)
        end
    end

    local function revertHRP(HRP)
        local data = HitboxOriginal[HRP]
        if data then
            if HRP and HRP.Parent then
                pcall(function()
                    HRP.Size = data.Size
                    HRP.CanCollide = data.CanCollide
                end)
            end
            HitboxOriginal[HRP] = nil
        end

        if HitboxVisuals[HRP] then
            pcall(function() HitboxVisuals[HRP]:Destroy() end)
            HitboxVisuals[HRP] = nil
        end
    end

    revertAllHitboxes = function()
        for HRP, _ in pairs(HitboxOriginal) do
            revertHRP(HRP)
        end
        for HRP, vis in pairs(HitboxVisuals) do
            if vis then pcall(function() vis:Destroy() end) end
        end
        HitboxOriginal = {}
        HitboxVisuals = {}
    end

    local function shouldExpandPlayer(Player)
        if not HitboxSettings.Enabled then return false end
        if not Player or Player == LocalPlayer then return false end
        if isWhitelisted and isWhitelisted(Player) then return false end

        if HitboxSettings.SingleTargetEnabled and HitboxSettings.MultiTargetEnabled then
            local isSingle = (HitboxSettings.SingleTargetPlayer == Player)
            local isMulti = (HitboxSettings.MultiTargetPlayers[Player.Name] == true)
            return isSingle or isMulti
        elseif HitboxSettings.SingleTargetEnabled then
            return (HitboxSettings.SingleTargetPlayer == Player)
        elseif HitboxSettings.MultiTargetEnabled then
            return (HitboxSettings.MultiTargetPlayers[Player.Name] == true)
        end

        return true
    end

    getPlayerUnderMouse = function()
        local mousePos = UserInputService:GetMouseLocation()
        local closestPlr = nil
        local closestDist = 150
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and (not isWhitelisted or not isWhitelisted(plr)) then
                local char = plr.Character
                local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head"))
                if root then
                    local scrPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                    if onScreen then
                        local dist = (Vector2.new(scrPos.X, scrPos.Y) - mousePos).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closestPlr = plr
                        end
                    end
                end
            end
        end
        return closestPlr
    end

    RunService.RenderStepped:Connect(function()
        if _scriptUnloaded then
            if next(HitboxOriginal) ~= nil then revertAllHitboxes() end
            return
        end

        if not HitboxSettings.Enabled then
            if next(HitboxOriginal) ~= nil then
                revertAllHitboxes()
            end
            return
        end

        for _, Player in ipairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer then
                local char = Player.Character
                local HRP = char and char:FindFirstChild("HumanoidRootPart")
                if HRP then
                    if shouldExpandPlayer(Player) then
                        applyToHRP(HRP)
                        local visual = HitboxVisuals[HRP]
                        if visual and visual.Parent then
                            visual.CFrame = HRP.CFrame
                        end
                    else
                        if HitboxOriginal[HRP] then
                            revertHRP(HRP)
                        end
                    end
                end
            end
        end
    end)

    Players.PlayerRemoving:Connect(function(plr)
        if HitboxSettings.SingleTargetPlayer == plr then
            HitboxSettings.SingleTargetPlayer = nil
        end
        HitboxSettings.MultiTargetPlayers[plr.Name] = nil
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp and HitboxOriginal[hrp] then
            revertHRP(hrp)
        end
    end)
end

local ESPSettings = {
    Enabled                  = false,
    MaxDist                  = 1000,
    Whitelist                = {},
    Box                      = false,
    BoxColor                 = Color3.fromRGB(255, 255, 255),
    Box3D                    = false,
    Box3DColor               = Color3.fromRGB(255, 255, 255),
    BoxFill                  = false,
    BoxFillColor             = Color3.fromRGB(255, 255, 255),
    BoxFillTrans             = 0.45,
    GradientFill             = false,
    GradientTopColor         = Color3.fromRGB(65, 105, 205),
    GradientBottomColor      = Color3.fromRGB(15, 20, 35),
    HealthBar                = false,
    HealthBarSide            = "Left",
    HealthText               = false,
    HpColorFull              = Color3.fromRGB(0, 255, 0),
    HpColorMid               = Color3.fromRGB(255, 170, 0),
    HpColorEmpty             = Color3.fromRGB(255, 0, 0),
    ArmorBar                 = false,
    ArmorColorFull           = Color3.fromRGB(80, 160, 255),
    ArmorColorEmpty          = Color3.fromRGB(30, 60, 120),
    Names                    = false,
    NameColor                = Color3.fromRGB(255, 255, 255),
    Distance                 = false,
    DistanceColor            = Color3.fromRGB(200, 200, 200),
    Tool                     = false,
    ToolColor                = Color3.fromRGB(255, 255, 255),
    Tracers                  = false,
    TracerColor              = Color3.fromRGB(255, 255, 255),
    TracerOrigin             = "Bottom",
    Skeleton                 = false,
    SkeletonColor            = Color3.fromRGB(255, 255, 255),
}

local esp = (function()
    local ESP = {}
    local lp = Players.LocalPlayer
    local cam = workspace.CurrentCamera
    local enabled = false
    local maxDist = 1000
    local boxEnabled = false
    local boxColor = Color3.fromRGB(255, 255, 255)
    local box3DEnabled = false
    local box3DColor = Color3.fromRGB(255, 255, 255)
    local boxFill = false
    local boxFillColor = Color3.fromRGB(255, 255, 255)
    local boxFillTransparency = 0.45
    local gradientFill = false
    local gradientTopColor = Color3.fromRGB(65, 105, 205)
    local gradientBottomColor = Color3.fromRGB(15, 20, 35)
    local healthBarEnabled = false
    local healthBarSide = 'Left'
    local hpColorFull  = Color3.fromRGB(0, 255, 0)
    local hpColorMid   = Color3.fromRGB(255, 170, 0)
    local hpColorEmpty = Color3.fromRGB(255, 0, 0)
    local armorBarEnabled = false
    local armorColorFull  = Color3.fromRGB(80, 160, 255)
    local armorColorEmpty = Color3.fromRGB(30, 60, 120)
    local namesEnabled = false
    local namesColor = Color3.fromRGB(255, 255, 255)
    local distanceEnabled = false
    local distanceColor = Color3.fromRGB(200, 200, 200)
    local toolEnabled = false
    local toolColor = Color3.fromRGB(255, 255, 255)
    local tracersEnabled = false
    local tracerColor = Color3.fromRGB(255, 255, 255)
    local tracerOrigin = 'Bottom'
    local skeletonEnabled = false
    local skeletonColor = Color3.fromRGB(255, 255, 255)

    local espGui = Instance.new("ScreenGui")
    espGui.Name = "LexhancementsBoxFillGui"
    espGui.ResetOnSpawn = false
    espGui.DisplayOrder = 10000
    espGui.IgnoreGuiInset = true
    pcall(function()
        if gethui then
            espGui.Parent = gethui()
        elseif game:GetService("CoreGui") then
            espGui.Parent = game:GetService("CoreGui")
        else
            espGui.Parent = lp:WaitForChild("PlayerGui")
        end
    end)

    local vertices = {
        {-0.5, -0.5, -0.5}, {-0.5, 0.5, -0.5}, {0.5, -0.5, -0.5}, {0.5, 0.5, -0.5},
        {-0.5, -0.5, 0.5}, {-0.5, 0.5, 0.5}, {0.5, -0.5, 0.5}, {0.5, 0.5, 0.5}
    }

    local box3DEdges = {
        {1, 2}, {1, 3}, {1, 5}, {2, 4}, {2, 6}, {3, 4}, {3, 7}, {4, 8}, {5, 6}, {5, 7}, {6, 8}, {7, 8}
    }

    local skeletonBones = {
        {'Head', 'UpperTorso'}, {'UpperTorso', 'LowerTorso'},
        {'UpperTorso', 'RightUpperArm'}, {'RightUpperArm', 'RightLowerArm'}, {'RightLowerArm', 'RightHand'},
        {'UpperTorso', 'LeftUpperArm'}, {'LeftUpperArm', 'LeftLowerArm'}, {'LeftLowerArm', 'LeftHand'},
        {'LowerTorso', 'RightUpperLeg'}, {'RightUpperLeg', 'RightLowerLeg'}, {'RightLowerLeg', 'RightFoot'},
        {'LowerTorso', 'LeftUpperLeg'}, {'LeftUpperLeg', 'LeftLowerLeg'}, {'LeftLowerLeg', 'LeftFoot'},
    }

    local espFolder = Instance.new('Folder')
    espFolder.Name = 'SymbolESP'
    espFolder.Parent = workspace:FindFirstChild("Ignored") or workspace
    local playerESP = {}
    local connections = {}

    local function newLine(thickness, color, zindex)
        local ok, l = pcall(function()
            local obj = Drawing.new('Line')
            obj.Thickness = thickness or 1
            obj.Color = color or Color3.new(1, 1, 1)
            obj.Transparency = 1
            obj.ZIndex = zindex or 1
            obj.Visible = false
            return obj
        end)
        if ok and l then return l end
        local dummy = { From = Vector2.zero, To = Vector2.zero, Color = color or Color3.new(1, 1, 1), Thickness = 1, Transparency = 1, ZIndex = zindex or 1, Visible = false }
        function dummy:Remove() end
        return dummy
    end

    local function newText(size, color, zindex)
        local ok, t = pcall(function()
            local obj = Drawing.new('Text')
            obj.Size = size or 13
            obj.Color = color or Color3.new(1, 1, 1)
            obj.Outline = true
            obj.Center = true
            obj.Font = 2
            obj.ZIndex = zindex or 2
            obj.Visible = false
            return obj
        end)
        if ok and t then return t end
        local dummy = { Text = "", Size = size or 13, Color = color or Color3.new(1, 1, 1), Center = true, Outline = true, Position = Vector2.zero, TextBounds = Vector2.new(30, 14), ZIndex = zindex or 2, Visible = false }
        function dummy:Remove() end
        return dummy
    end

    local function newSquare(filled, thickness, color, zindex)
        local ok, s = pcall(function()
            local obj = Drawing.new('Square')
            obj.Filled = filled or false
            obj.Thickness = thickness or 1
            obj.Color = color or Color3.new(1, 1, 1)
            obj.ZIndex = zindex or 1
            obj.Visible = false
            return obj
        end)
        if ok and s then return s end
        local dummy = { Size = Vector2.zero, Position = Vector2.zero, Color = color or Color3.new(1, 1, 1), Filled = filled or false, Thickness = 1, Transparency = 1, ZIndex = zindex or 1, Visible = false }
        function dummy:Remove() end
        return dummy
    end

    local function newQuad(color, transparency, zindex)
        local ok, q = pcall(function()
            local obj = Drawing.new('Quad')
            obj.Color = color or Color3.new(1, 1, 1)
            obj.Filled = true
            obj.Transparency = transparency or 1
            obj.ZIndex = zindex or 1
            obj.Visible = false
            return obj
        end)
        if ok and q then return q end
        local dummy = { PointA = Vector2.zero, PointB = Vector2.zero, PointC = Vector2.zero, PointD = Vector2.zero, Color = color or Color3.new(1, 1, 1), Filled = true, Transparency = transparency or 1, ZIndex = zindex or 1, Visible = false }
        function dummy:Remove() end
        return dummy
    end

    local function customBounds(char)
        local minB = Vector3.new(math.huge, math.huge, math.huge)
        local maxB = Vector3.new(-math.huge, -math.huge, -math.huge)
        local minWidth = 2.5
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA('BasePart') and part.Name ~= "HitboxVisualizer" then
                local cf, sz = part.CFrame, part.Size
                if part.Name == "HumanoidRootPart" then
                    sz = Vector3.new(2, 2, 1)
                end
                for _, v in ipairs(vertices) do
                    local w = cf:PointToWorldSpace(Vector3.new(v[1] * sz.X, (v[2] + 0.2) * (sz.Y + 0.2), v[3] * sz.Z))
                    minB = Vector3.new(math.min(minB.X, w.X), math.min(minB.Y, w.Y), math.min(minB.Z, w.Z))
                    maxB = Vector3.new(math.max(maxB.X, w.X), math.max(maxB.Y, w.Y), math.max(maxB.Z, w.Z))
                end
            end
        end
        if minB.X == math.huge then return nil end
        local size = maxB - minB
        size = Vector3.new(math.max(size.X, minWidth), size.Y, size.Z)
        local center = (minB + maxB) / 2
        return CFrame.new(center), size, center
    end

    local function w2s(pos)
        local sp, on = cam:WorldToViewportPoint(pos)
        return Vector2.new(sp.X, sp.Y), on, sp.Z
    end

    local function getSkeletonPart(char, name)
        local p = char:FindFirstChild(name)
        if p then return p end
        if name == "UpperTorso" or name == "LowerTorso" then
            return char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
        elseif name == "RightUpperArm" or name == "RightLowerArm" or name == "RightHand" then
            return char:FindFirstChild("Right Arm")
        elseif name == "LeftUpperArm" or name == "LeftLowerArm" or name == "LeftHand" then
            return char:FindFirstChild("Left Arm")
        elseif name == "RightUpperLeg" or name == "RightLowerLeg" or name == "RightFoot" then
            return char:FindFirstChild("Right Leg")
        elseif name == "LeftUpperLeg" or name == "LeftLowerLeg" or name == "LeftFoot" then
            return char:FindFirstChild("Left Leg")
        end
        return nil
    end

    local function createPlayerESP(player)
        if playerESP[player] then return end

        local fillFrame = Instance.new("Frame")
        fillFrame.Name = "BoxFill_" .. player.Name
        fillFrame.Visible = false
        fillFrame.BorderSizePixel = 0
        fillFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        fillFrame.BackgroundTransparency = 0
        if espGui then fillFrame.Parent = espGui end

        local fillGrad = Instance.new("UIGradient")
        fillGrad.Rotation = 90
        fillGrad.Color = ColorSequence.new(gradientTopColor, gradientBottomColor)
        local t0 = math.clamp(boxFillTransparency, 0, 1)
        fillGrad.Transparency = NumberSequence.new(t0, t0)
        fillGrad.Parent = fillFrame

        local hpBg = Instance.new("Frame")
        hpBg.Name = "HpBar_" .. player.Name
        hpBg.Visible = false
        hpBg.BorderSizePixel = 0
        hpBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        hpBg.BackgroundTransparency = 0
        local hpBgCorner = Instance.new("UICorner"); hpBgCorner.CornerRadius = UDim.new(0, 2); hpBgCorner.Parent = hpBg
        if espGui then hpBg.Parent = espGui end

        local hpFill = Instance.new("Frame")
        hpFill.Name = "Fill"
        hpFill.BorderSizePixel = 0
        hpFill.AnchorPoint = Vector2.new(0, 1)
        hpFill.Position = UDim2.new(0, 1, 1, -1)
        hpFill.Size = UDim2.new(1, -2, 1, -2)
        hpFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        local hpFillCorner = Instance.new("UICorner"); hpFillCorner.CornerRadius = UDim.new(0, 2); hpFillCorner.Parent = hpFill
        hpFill.Parent = hpBg

        local hpGrad = Instance.new("UIGradient")
        hpGrad.Rotation = 90
        hpGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, hpColorFull),
            ColorSequenceKeypoint.new(0.5, hpColorMid),
            ColorSequenceKeypoint.new(1, hpColorEmpty),
        })
        hpGrad.Parent = hpFill

        local d = {
            box              = newSquare(false, 1, boxColor, 3),
            boxOutline       = newSquare(false, 1, Color3.new(0, 0, 0), 2),
            boxFillQ         = newQuad(boxFillColor, boxFillTransparency, 1),
            boxFillFrame     = fillFrame,
            boxFillGrad      = fillGrad,
            box3DLines       = {},
            hpBg             = hpBg,
            hpFill           = hpFill,
            hpGrad           = hpGrad,
            hpGradKey        = nil,
            armorBarBg       = newSquare(false, 1, Color3.fromRGB(0, 0, 0), 1),
            armorBar         = newSquare(true, 1, armorColorFull, 3),
            name             = newText(13, namesColor, 4),
            distance         = newText(13, distanceColor, 4),
            tool             = newText(13, toolColor, 4),
            tracer           = newLine(1, tracerColor, 1),
            skeleton         = {},
        }
        for i = 1, 12 do
            d.box3DLines[i] = newLine(1, box3DColor, 3)
        end
        for i = 1, #skeletonBones do
            d.skeleton[i] = newLine(1, skeletonColor, 2)
        end
        playerESP[player] = d
    end

    local function removePlayerESP(player)
        local d = playerESP[player]
        if not d then return end
        pcall(function() d.box:Remove() end)
        pcall(function() d.boxOutline:Remove() end)
        pcall(function() d.boxFillQ:Remove() end)
        if d.boxFillFrame then
            pcall(function() d.boxFillFrame:Destroy() end)
            d.boxFillFrame = nil
            d.boxFillGrad = nil
        end
        for _, line3d in ipairs(d.box3DLines or {}) do pcall(function() line3d:Remove() end) end
        if d.hpBg then
            pcall(function() d.hpBg:Destroy() end)
            d.hpBg = nil; d.hpFill = nil; d.hpGrad = nil
        end
        pcall(function() d.armorBarBg:Remove() end)
        pcall(function() d.armorBar:Remove() end)
        pcall(function() d.name:Remove() end)
        pcall(function() d.distance:Remove() end)
        pcall(function() d.tool:Remove() end)
        pcall(function() d.tracer:Remove() end)
        for _, l in ipairs(d.skeleton or {}) do pcall(function() l:Remove() end) end
        playerESP[player] = nil
    end

    local function hideAll(d)
        d.box.Visible = false
        d.boxOutline.Visible = false
        d.boxFillQ.Visible = false
        if d.boxFillFrame then d.boxFillFrame.Visible = false end
        for _, l in ipairs(d.box3DLines or {}) do l.Visible = false end
        if d.hpBg then d.hpBg.Visible = false end
        d.armorBarBg.Visible = false
        d.armorBar.Visible = false
        d.name.Visible = false
        d.distance.Visible = false
        d.tool.Visible = false
        d.tracer.Visible = false
        for _, l in ipairs(d.skeleton or {}) do l.Visible = false end
    end

    local function updatePlayer(player, d)
        if isWhitelisted and isWhitelisted(player) then
            hideAll(d)
            return
        end
        local char = player.Character
        if not char then hideAll(d); return end
        local hrp = char:FindFirstChild('HumanoidRootPart')
        local hum = char:FindFirstChildOfClass('Humanoid')
        if not hrp or not hum or hum.Health <= 0 then hideAll(d); return end

        local cf, size, center = customBounds(char)
        if not cf then hideAll(d); return end

        local screenPos, visible = cam:WorldToViewportPoint(center)
        if not visible then hideAll(d); return end

        local tl = cam:WorldToViewportPoint((cf * CFrame.new(-size.X / 2, size.Y / 2, 0)).Position)
        local tr = cam:WorldToViewportPoint((cf * CFrame.new(size.X / 2, size.Y / 2, 0)).Position)
        local bl = cam:WorldToViewportPoint((cf * CFrame.new(-size.X / 2, -size.Y / 2, 0)).Position)
        local br = cam:WorldToViewportPoint((cf * CFrame.new(size.X / 2, -size.Y / 2, 0)).Position)

        local boxW = math.max(math.abs(tr.X - tl.X), 3)
        local boxH = math.max(math.abs(bl.Y - tl.Y), 3)
        local boxPos = Vector2.new(
            math.min(tl.X, tr.X, bl.X, br.X),
            math.min(tl.Y, tr.Y, bl.Y, br.Y)
        )

        local dist = math.floor((hrp.Position - cam.CFrame.Position).Magnitude)
        if dist > maxDist then hideAll(d); return end

        if boxEnabled and enabled then
            d.box.Size = Vector2.new(boxW, boxH)
            d.box.Position = boxPos
            d.box.Color = boxColor
            d.box.Visible = true
            d.boxOutline.Size = Vector2.new(boxW + 2, boxH + 2)
            d.boxOutline.Position = Vector2.new(boxPos.X - 1, boxPos.Y - 1)
            d.boxOutline.Color = Color3.fromRGB(0, 0, 0)
            d.boxOutline.Visible = true

            if gradientFill then
                d.boxFillQ.Visible = false
                if d.boxFillFrame and d.boxFillGrad then
                    d.boxFillFrame.Position = UDim2.fromOffset(math.floor(boxPos.X), math.floor(boxPos.Y))
                    d.boxFillFrame.Size = UDim2.fromOffset(math.floor(boxW), math.floor(boxH))
                    d.boxFillGrad.Color = ColorSequence.new(gradientTopColor, gradientBottomColor)
                    local t = math.clamp(boxFillTransparency, 0, 1)
                    d.boxFillGrad.Transparency = NumberSequence.new(t, t)
                    d.boxFillFrame.Visible = true
                end
            else
                if d.boxFillFrame then d.boxFillFrame.Visible = false end
                if boxFill then
                    d.boxFillQ.PointA = Vector2.new(boxPos.X, boxPos.Y)
                    d.boxFillQ.PointB = Vector2.new(boxPos.X + boxW, boxPos.Y)
                    d.boxFillQ.PointC = Vector2.new(boxPos.X + boxW, boxPos.Y + boxH)
                    d.boxFillQ.PointD = Vector2.new(boxPos.X, boxPos.Y + boxH)
                    d.boxFillQ.Color = boxFillColor
                    d.boxFillQ.Transparency = boxFillTransparency
                    d.boxFillQ.Visible = true
                else
                    d.boxFillQ.Visible = false
                end
            end
        else
            d.box.Visible = false
            d.boxOutline.Visible = false
            d.boxFillQ.Visible = false
            if d.boxFillFrame then d.boxFillFrame.Visible = false end
        end

        if box3DEnabled and enabled then
            local points3D = {}
            for i, v in ipairs(vertices) do
                local w = cf:PointToWorldSpace(Vector3.new(v[1] * size.X, v[2] * size.Y, v[3] * size.Z))
                local sPos, on = w2s(w)
                points3D[i] = {pos = sPos, vis = on}
            end
            for idx, edge in ipairs(box3DEdges) do
                local p1 = points3D[edge[1]]
                local p2 = points3D[edge[2]]
                local line = d.box3DLines[idx]
                if line then
                    if p1 and p2 and (p1.vis or p2.vis) then
                        line.From = p1.pos
                        line.To = p2.pos
                        line.Color = box3DColor
                        line.Visible = true
                    else
                        line.Visible = false
                    end
                end
            end
        else
            for _, l in ipairs(d.box3DLines or {}) do l.Visible = false end
        end

        if healthBarEnabled and enabled and d.hpBg then
            local ratio = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
            local barX = healthBarSide == 'Left' and (boxPos.X - 8) or (boxPos.X + boxW + 2)
            d.hpBg.Position = UDim2.fromOffset(math.floor(barX), math.floor(boxPos.Y - 1))
            d.hpBg.Size = UDim2.fromOffset(6, math.floor(boxH + 2))
            d.hpFill.Size = UDim2.new(1, -2, ratio, -2 * ratio)
            local key = tostring(hpColorFull) .. tostring(hpColorMid) .. tostring(hpColorEmpty)
            if d.hpGradKey ~= key then
                d.hpGradKey = key
                d.hpGrad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, hpColorFull),
                    ColorSequenceKeypoint.new(0.5, hpColorMid),
                    ColorSequenceKeypoint.new(1, hpColorEmpty),
                })
            end
            d.hpFill.Visible = ratio > 0
            d.hpBg.Visible = true
        elseif d.hpBg then
            d.hpBg.Visible = false
        end

        if armorBarEnabled and enabled then
            local armorVal = 0
            local be2 = char:FindFirstChild('BodyEffects')
            if be2 then
                local a = be2:FindFirstChild('Armor')
                if a then armorVal = a.Value end
            end
            local ratio = math.clamp(armorVal / 100, 0, 1)
            local armorColor = armorColorEmpty:Lerp(armorColorFull, ratio)
            local barX2 = healthBarSide == 'Right' and (boxPos.X - 8) or (boxPos.X + boxW + 4)
            d.armorBarBg.Size = Vector2.new(6, boxH + 2)
            d.armorBarBg.Position = Vector2.new(barX2 - 1, boxPos.Y - 1)
            d.armorBarBg.Color = Color3.fromRGB(0, 0, 0)
            d.armorBarBg.Visible = true
            d.armorBar.Size = Vector2.new(4, boxH * ratio)
            d.armorBar.Position = Vector2.new(barX2, boxPos.Y + boxH * (1 - ratio))
            d.armorBar.Color = armorColor
            d.armorBar.Visible = true
        else
            d.armorBarBg.Visible = false
            d.armorBar.Visible = false
        end

        if namesEnabled and enabled then
            local dName = player.DisplayName or player.Name
            d.name.Text = dName .. " (@" .. player.Name .. ")"
            d.name.Color = namesColor
            d.name.Position = Vector2.new(boxPos.X + boxW / 2, boxPos.Y - d.name.TextBounds.Y - 2)
            d.name.Visible = true
        else
            d.name.Visible = false
        end

        if distanceEnabled and enabled then
            d.distance.Text = dist .. ' studs'
            d.distance.Color = distanceColor
            d.distance.Position = Vector2.new(boxPos.X + boxW / 2, boxPos.Y + boxH + d.distance.TextBounds.Y)
            d.distance.Visible = true
        else
            d.distance.Visible = false
        end

        if toolEnabled and enabled then
            local tool = char:FindFirstChildOfClass('Tool')
            d.tool.Text = tool and tool.Name or ''
            d.tool.Color = toolColor
            local distOffset = distanceEnabled and (d.distance.TextBounds.Y * 2 + 2) or d.tool.TextBounds.Y
            d.tool.Position = Vector2.new(boxPos.X + boxW / 2, boxPos.Y + boxH + distOffset)
            d.tool.Visible = tool ~= nil
        else
            d.tool.Visible = false
        end

        if tracersEnabled and enabled then
            local vpS = cam.ViewportSize
            local oy = tracerOrigin == 'Bottom' and vpS.Y or tracerOrigin == 'Center' and vpS.Y / 2 or 0
            local sBot, _ = w2s(Vector3.new(center.X, center.Y - size.Y / 2, center.Z))
            d.tracer.From = Vector2.new(vpS.X / 2, oy)
            d.tracer.To = sBot
            d.tracer.Color = tracerColor
            d.tracer.Transparency = 1
            d.tracer.Visible = true
        else
            d.tracer.Visible = false
        end

        if skeletonEnabled and enabled then
            for i, bone in ipairs(skeletonBones) do
                local p0 = getSkeletonPart(char, bone[1])
                local p1 = getSkeletonPart(char, bone[2])
                if p0 and p1 then
                    local s0, on0 = w2s(p0.Position)
                    local s1, on1 = w2s(p1.Position)
                    if on0 and on1 then
                        d.skeleton[i].From = s0
                        d.skeleton[i].To = s1
                        d.skeleton[i].Color = skeletonColor
                        d.skeleton[i].Transparency = 1
                        d.skeleton[i].Visible = true
                    else
                        d.skeleton[i].Visible = false
                    end
                else
                    d.skeleton[i].Visible = false
                end
            end
        else
            for _, l in ipairs(d.skeleton or {}) do l.Visible = false end
        end
    end

    local function onPlayerAdded(player)
        if player == lp then return end
        createPlayerESP(player)
    end

    for _, p in ipairs(Players:GetPlayers()) do onPlayerAdded(p) end
    local pAddedConn = Players.PlayerAdded:Connect(onPlayerAdded)
    local pRemovedConn = Players.PlayerRemoving:Connect(function(p) removePlayerESP(p) end)
    table.insert(connections, pAddedConn)
    table.insert(connections, pRemovedConn)

    local renderConn = RunService.RenderStepped:Connect(function()
        if not enabled or _hidden then
            for _, d in pairs(playerESP) do
                hideAll(d)
            end
            return
        end
        for player, d in pairs(playerESP) do
            updatePlayer(player, d)
        end
    end)
    table.insert(connections, renderConn)

    function ESP:setEnabled(v)                     enabled = v end
    function ESP:setMaxDist(v)                     maxDist = v end
    function ESP:setBoxEnabled(v)                  boxEnabled = v end
    function ESP:setBoxColor(c)                    boxColor = c end
    function ESP:setBox3DEnabled(v)                box3DEnabled = v end
    function ESP:setBox3DColor(c)                  box3DColor = c end
    function ESP:setBoxFill(v)                     boxFill = v end
    function ESP:setBoxFillColor(c)                boxFillColor = c end
    function ESP:setBoxFillTransparency(t)         boxFillTransparency = t end
    function ESP:setGradientFill(v)                gradientFill = v end
    function ESP:setGradientTopColor(c)            gradientTopColor = c end
    function ESP:setGradientBottomColor(c)         gradientBottomColor = c end
    function ESP:setHealthBarEnabled(v)            healthBarEnabled = v end
    function ESP:setHealthBarSide(s)               healthBarSide = s end
    function ESP:setHpColorFull(c)                 hpColorFull = c end
    function ESP:setHpColorMid(c)                  hpColorMid = c end
    function ESP:setHpColorEmpty(c)                hpColorEmpty = c end
    function ESP:setArmorBarEnabled(v)             armorBarEnabled = v end
    function ESP:setArmorColorFull(c)              armorColorFull = c end
    function ESP:setArmorColorEmpty(c)             armorColorEmpty = c end
    function ESP:setNamesEnabled(v)                namesEnabled = v end
    function ESP:setNamesColor(c)                  namesColor = c end
    function ESP:setDistanceEnabled(v)             distanceEnabled = v end
    function ESP:setDistanceColor(c)               distanceColor = c end
    function ESP:setToolEnabled(v)                 toolEnabled = v end
    function ESP:setToolColor(c)                   toolColor = c end
    function ESP:setTracersEnabled(v)              tracersEnabled = v end
    function ESP:setTracerColor(c)                 tracerColor = c end
    function ESP:setTracerOrigin(o)                tracerOrigin = o end
    function ESP:setSkeletonEnabled(v)             skeletonEnabled = v end
    function ESP:setSkeletonColor(c)               skeletonColor = c end
    function ESP:destroy()
        enabled = false
        for _, conn in ipairs(connections) do
            pcall(function() conn:Disconnect() end)
        end
        connections = {}
        for player, _ in pairs(playerESP) do
            removePlayerESP(player)
        end
        playerESP = {}
        pcall(function()
            if espFolder and espFolder.Parent then
                espFolder:Destroy()
            end
        end)
        pcall(function()
            if espGui and espGui.Parent then
                espGui:Destroy()
            end
        end)
    end

    return ESP
end)()

local Window = Lexhancements:CreateWindow({
    Name        = "Das Hood",
    Url         = "discord.gg/Lexhancements",
    Version     = "v2.0",
    LoaderTitle = "DAS HOOD",
    Accent      = Color3.fromRGB(124, 58, 237),
    Keybind     = Enum.KeyCode.RightControl,
})

pcall(function()
    local rawCreateTab = Window.CreateTab
    Window.CreateTab = function(self, tabName)
        local tab = rawCreateTab(self, tabName)
        local rawAddSubTab = tab.AddSubTab
        tab.AddSubTab = function(tSelf, subName)
            local sub = rawAddSubTab(tSelf, subName)
            local rawAddSection = sub.AddSection
            sub.AddSection = function(sSelf, sName, sCol)
                local sec = rawAddSection(sSelf, sName, sCol)
                local rawAddDropdown = sec.AddDropdown
                sec.AddDropdown = function(secSelf, cfg)
                    if cfg and type(cfg.Default) == "table" and not (cfg.Multi or cfg.multi) then
                        cfg.Default = cfg.Default[1] or "Select"
                    end
                    local ok, res = pcall(function() return rawAddDropdown(secSelf, cfg) end)
                    if ok and res then return res end
                    local ok2, res2 = pcall(function()
                        local safeCfg = {}
                        for k, v in pairs(cfg or {}) do safeCfg[k] = v end
                        if type(safeCfg.Default) == "table" then
                            safeCfg.Default = safeCfg.Default[1] or "Select"
                        end
                        return rawAddDropdown(secSelf, safeCfg)
                    end)
                    if ok2 and res2 then return res2 end
                    return {
                        Value = cfg and cfg.Default,
                        Set = function() end,
                        Get = function() return cfg and cfg.Default end
                    }
                end
                return sec
            end
            return sub
        end
        return tab
    end
end)

pcall(function()
    if Window.BindESPPreview then
        Window:BindESPPreview(ESPSettings)
    elseif Window.ESPPreview and Window.ESPPreview.Bind then
        Window.ESPPreview:Bind(ESPSettings)
    end
end)

local function notify(title, text, dur, ntype)
    if Window and Window.Notify then
        pcall(function()
            if ntype == "success" and Window.NotifySuccess then
                Window:NotifySuccess(title, text, dur)
            elseif ntype == "error" and Window.NotifyError then
                Window:NotifyError(title, text, dur)
            elseif ntype == "info" and Window.NotifyInfo then
                Window:NotifyInfo(title, text, dur)
            else
                Window:Notify(title, text, dur)
            end
        end)
    end
end

local function fullUnload()
    _scriptUnloaded = true

    CamLockSettings.Enabled   = false; _camBindState = false; CamLockSettings.StickyTarget = nil
    SilentAimSettings.Enabled = false; _removeGunHandlerHook()
    RapidFireSettings.Enabled = false; _isFiring = false; applyRapidFire()
    TriggerSettings.Enabled   = false; TriggerSettings.Active = false

    HitboxSettings.Enabled = false
    if revertAllHitboxes then revertAllHitboxes() end

    SpeedSettings.Enabled     = false; SpeedSettings.KeybindActive = false
    CFrameSpeedSettings.Enabled = false; CFrameSpeedSettings.KeybindActive = false
    FlySettings.Enabled       = false; _flyToggled = false; stopFly()
    if flyCore then pcall(function() flyCore:Destroy() end) flyCore = nil end
    if workspace:FindFirstChild("IgnoredVelocity") then pcall(function() workspace.IgnoredVelocity:Destroy() end) end

    _tpEnabled                = false; _tpHolding = false; _tpOrbit = false
    _hidden                   = false; NoClipEnabled = false; LightingMods = false

    HitChamsSettings.Enabled      = false
    DamageNumbersSettings.Enabled = false
    ChinaHatSettings.Enabled      = false
    for i = 1, 25 do
        if chinaLines and chinaLines[i] then chinaLines[i].Visible = false; pcall(function() chinaLines[i]:Remove() end) end
        if chinaTris and chinaTris[i] then chinaTris[i].Visible = false; pcall(function() chinaTris[i]:Remove() end) end
    end
    SelfAuraSettings.Enabled      = false
    pcall(sa2Clear)
    ToolChamsSettings.Enabled     = false
    pcall(tcDisable)
    if _currentEffectConn then pcall(function() _currentEffectConn:Disconnect() end) _currentEffectConn = nil end

    Lighting.Ambient              = OrigLighting.Ambient
    Lighting.OutdoorAmbient       = OrigLighting.OutdoorAmbient
    Lighting.FogStart             = OrigLighting.FogStart
    Lighting.FogEnd               = OrigLighting.FogEnd
    Lighting.FogColor             = OrigLighting.FogColor
    Lighting.Brightness           = OrigLighting.Brightness
    Lighting.ExposureCompensation = OrigLighting.ExposureCompensation
    Lighting.ClockTime            = OrigLighting.ClockTime
    pcall(function() applySkybox("Default") end)

    if scEnabled then scDisable() end; scEnabled = false
    local char = LocalPlayer.Character
    local hum  = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16; hum.PlatformStand = false; hum.AutoJumpEnabled = true end

    ESPSettings.Enabled = false
    if esp then
        pcall(function() esp:destroy() end)
    end
    if playerESP then
        for _, d in pairs(playerESP) do pcall(function() destroyESPEntry(d) end) end
        playerESP = {}
    end
    pcall(function() if espFolder and espFolder.Parent then espFolder:Destroy() end end)

    if CamFOVCircle then CamFOVCircle.Visible = false; pcall(function() CamFOVCircle:Remove() end) end
    if CamFOVCircleFill then CamFOVCircleFill.Visible = false; pcall(function() CamFOVCircleFill:Remove() end) end
    if SilentCircle then SilentCircle.Visible = false; pcall(function() SilentCircle:Remove() end) end
    if SilentCircleFill then SilentCircleFill.Visible = false; pcall(function() SilentCircleFill:Remove() end) end
    for _, l in ipairs({TriggerBoxTop, TriggerBoxBot, TriggerBoxLeft, TriggerBoxRight}) do
        if l then l.Visible = false; pcall(function() l:Remove() end) end
    end

    if _G.Lexhancements_ViewingPlayer or _G.KraviX_ViewingPlayer then
        _G.Lexhancements_ViewingPlayer = nil
        _G.KraviX_ViewingPlayer = nil
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            end
        end)
    end
    if Window and Window.MiniPlayers and Window.MiniPlayers.Frame and Window.MiniPlayers.Frame.Parent then
        pcall(function() Window.MiniPlayers.Frame:Destroy() end)
    end

    task.wait(0.05)
    if Window and Window._ScreenGui and Window._ScreenGui.Parent then
        pcall(function() Window._ScreenGui:Destroy() end)
    end
end

local W = {}
local _speedBindObj  = nil
local _flyBindObj    = nil
local _tpBindObj     = nil
local _menuBindObj   = nil
local _hideBindObj   = nil
local _unloadBindObj = nil

do
    local TabCombat = Window:CreateTab("Combat")

    do
        local SubCamLock = TabCombat:AddSubTab("CamLock")
        local secCamL = SubCamLock:AddSection("CamLock System", "Left")

W.camLockEnabled = secCamL:AddToggle({
    Name = "Enable CamLock",
    Default = false,
    Callback = function(v)
        CamLockSettings.Enabled = v
        if not v then CamLockSettings.StickyTarget = nil; _camBindState = false end
    end
})

_camBindObj = secCamL:AddMouseKeybind({
    Name = "CamLock Key / Button",
    Default = {type = "mouse", value = Enum.UserInputType.MouseButton2},
    Callback = function() _camBindState = false; CamLockSettings.StickyTarget = nil end
})

W.camLockMode = secCamL:AddDropdown({
    Name = "Mode",
    Values = {"Hold", "Toggle"},
    Default = "Hold",
    Callback = function(v) _camMode = v; _camBindState = false; CamLockSettings.StickyTarget = nil end
})

W.camLockTargetPart = secCamL:AddDropdown({
    Name = "Target Part",
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso", "Legs", "LeftLowerArm", "RightLowerArm", "LeftFoot", "RightFoot"},
    Default = "HumanoidRootPart",
    Callback = function(v) CamLockSettings.TargetPart = v; CamLockSettings.StickyTarget = nil end
})

W.camLockSmooth = secCamL:AddSlider({
    Name = "Smoothness",
    Min = 0.01,
    Max = 1,
    Default = 0.450,
    Rounding = 3,
    Callback = function(v) CamLockSettings.Smoothness = v end
})

secCamL:AddSeparator()

W.camLockSticky = secCamL:AddToggle({
    Name = "Sticky Target",
    Default = false,
    Callback = function(v)
        CamLockSettings.Sticky = v
        if not v then CamLockSettings.StickyTarget = nil end
    end
})

W.camLockKOCheck = secCamL:AddToggle({
    Name = "K.O Check",
    Default = true,
    Callback = function(v)
        CamLockSettings.KOCheck = v
        CamLockSettings.StickyTarget = nil
    end
})

W.camLockWallCheck = secCamL:AddToggle({
    Name = "Wall Check",
    Default = true,
    Callback = function(v)
        CamLockSettings.WallCheck = v
    end
})

secCamL:AddSeparator()

W.camLockAirCheck = secCamL:AddToggle({
    Name = "Air Check",
    Default = false,
    Callback = function(v)
        CamLockSettings.AirCheck = v
    end
})

W.camLockAirPart = secCamL:AddDropdown({
    Name = "Air Target Part",
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso", "Legs", "LeftLowerArm", "RightLowerArm", "LeftFoot", "RightFoot"},
    Default = "HumanoidRootPart",
    Callback = function(v)
        CamLockSettings.AirPart = v
    end
})

secCamL:AddSeparator()

W.camLockDeadzone = secCamL:AddToggle({
    Name = "Deadzone",
    Default = false,
    Callback = function(v)
        CamLockSettings.DeadzoneEnabled = v
    end
})

W.camLockDeadzoneVal = secCamL:AddSlider({
    Name = "Deadzone Radius",
    Min = 2,
    Max = 60,
    Default = 15,
    Rounding = 0,
    Callback = function(v)
        CamLockSettings.Deadzone = v
    end
})

secCamL:AddSeparator()

W.camLockShake = secCamL:AddToggle({
    Name = "Camera Shake",
    Default = false,
    Callback = function(v)
        CamLockSettings.ShakeEnabled = v
    end
})

W.camLockShakeAmt = secCamL:AddSlider({
    Name = "Shake Intensity",
    Min = 0.1,
    Max = 10,
    Default = 2,
    Rounding = 1,
    Callback = function(v)
        CamLockSettings.ShakeAmount = v
    end
})

local secCamR = SubCamLock:AddSection("FOV & Prediction", "Right")

W.camLockPrediction = secCamR:AddToggle({
    Name = "Prediction",
    Default = true,
    Callback = function(v)
        CamLockSettings.PredictionEnabled = v
    end
})

W.camLockPredictionAmt = secCamR:AddSlider({
    Name = "Prediction Amount",
    Min = 0,
    Max = 5,
    Default = 0.100,
    Rounding = 3,
    Callback = function(v)
        CamLockSettings.Prediction = v
    end
})

W.camLockAutoPred = secCamR:AddToggle({
    Name = "Auto Prediction (Ping)",
    Default = false,
    Callback = function(v)
        CamLockSettings.AutoPrediction = v
    end
})

W.camLockAntiGround = secCamR:AddToggle({
    Name = "Anti-Ground Shot",
    Default = true,
    Callback = function(v)
        CamLockSettings.AntiGroundShot = v
    end
})

secCamR:AddSeparator()

W.camLockShowFOV = secCamR:AddToggle({
    Name = "Show FOV Circle",
    Default = false,
    Callback = function(v)
        CamLockSettings.ShowFOV = v
    end
})

W.camLockFOVMode = secCamR:AddDropdown({
    Name = "FOV Origin",
    Values = {"Mouse", "Center"},
    Default = "Mouse",
    Callback = function(v)
        CamLockSettings.FOVMode = v
    end
})

W.camLockFOV = secCamR:AddSlider({
    Name = "FOV Radius",
    Min = 10,
    Max = 800,
    Default = 200,
    Rounding = 0,
    Callback = function(v)
        CamLockSettings.FOV = v
    end
})

W.camLockFOVColor = secCamR:AddColorPicker({
    Name = "FOV Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        CamLockSettings.FOVColor = v
    end
})

W.camLockFOVFill = secCamR:AddToggle({
    Name = "FOV Fill",
    Default = false,
    Callback = function(v)
        CamLockSettings.FOVFill = v
    end
})

W.camLockFOVFillColor = secCamR:AddColorPicker({
    Name = "FOV Fill Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        CamLockSettings.FOVFillColor = v
    end
})

W.camLockFOVFillTrans = secCamR:AddSlider({
    Name = "FOV Fill Transparency",
    Min = 0.01,
    Max = 1,
    Default = 0.1,
    Rounding = 2,
    Callback = function(v)
        CamLockSettings.FOVFillTransparency = v
    end
})
    end

    do
        local SubSilent = TabCombat:AddSubTab("Silent Aim")
        local secSilL = SubSilent:AddSection("Silent Aim", "Left")

W.silentEnabled = secSilL:AddToggle({
    Name = "Enable Silent Aim",
    Default = false,
    Callback = function(v)
        SilentAimSettings.Enabled = v
        if v then _applyGunHandlerHook() else _removeGunHandlerHook() end
    end
})

_silentBindObj = secSilL:AddMouseKeybind({
    Name = "Silent Aim Keybind",
    Default = {type = "key", value = Enum.KeyCode.Unknown},
    Callback = function() end
})

W.silentHitpartMode = secSilL:AddDropdown({
    Name = "Hitpart Mode",
    Values = {"Single Part", "Closest Part"},
    Default = "Single Part",
    Callback = function(v) SilentAimSettings.HitpartMode = v end
})

W.silentPart = secSilL:AddDropdown({
    Name = "Target Part",
    Values = SILENT_HITPARTS,
    Default = "Head",
    Callback = function(v) SilentAimSettings.TargetPart = v end
})

W.silentHitChance = secSilL:AddSlider({
    Name = "Hit Chance (%)",
    Min = 1,
    Max = 100,
    Default = 100,
    Rounding = 0,
    Callback = function(v) SilentAimSettings.HitChance = v end
})

W.silentMaxDistance = secSilL:AddSlider({
    Name = "Max Distance (Studs)",
    Min = 50,
    Max = 2000,
    Default = 500,
    Rounding = 0,
    Callback = function(v) SilentAimSettings.MaxDistance = v end
})

secSilL:AddSeparator()

W.silentIgnoreKO = secSilL:AddToggle({
    Name = "Knock Check (Ignore K.O)",
    Default = true,
    Callback = function(v) SilentAimSettings.IgnoreKO = v end
})

W.silentWallCheck = secSilL:AddToggle({
    Name = "Wall Check",
    Default = true,
    Callback = function(v) SilentAimSettings.WallCheck = v end
})

secSilL:AddSeparator()

W.rapidFire = secSilL:AddToggle({
    Name = "Enable Rapid Fire",
    Default = false,
    Callback = function(v)
        RapidFireSettings.Enabled = v
        applyRapidFire()
    end
})

W.rapidFireDelay = secSilL:AddSlider({
    Name = "Rapid Fire Delay",
    Min = 0.001,
    Max = 0.5,
    Default = 0.08,
    Rounding = 3,
    Callback = function(v) RapidFireSettings.Delay = v end
})

local secSilR = SubSilent:AddSection("Visuals & Prediction", "Right")

W.silentShowFOV = secSilR:AddToggle({
    Name = "Show FOV Circle",
    Default = false,
    Callback = function(v) SilentAimSettings.ShowFOV = v end
})

W.silentFOVMode = secSilR:AddDropdown({
    Name = "FOV Origin",
    Values = {"Mouse", "Center"},
    Default = "Mouse",
    Callback = function(v) SilentAimSettings.FOVMode = v end
})

W.silentFOV = secSilR:AddSlider({
    Name = "Silent FOV Radius",
    Min = 20,
    Max = 1000,
    Default = 150,
    Rounding = 0,
    Callback = function(v) SilentAimSettings.FOV = v end
})

W.silentFOVColor = secSilR:AddColorPicker({
    Name = "FOV Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v) SilentAimSettings.FOVColor = v end
})

W.silentFOVFill = secSilR:AddToggle({
    Name = "Silent FOV Fill",
    Default = false,
    Callback = function(v)
        SilentAimSettings.FOVFill = v
    end
})

W.silentFOVFillColor = secSilR:AddColorPicker({
    Name = "Silent FOV Fill Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        SilentAimSettings.FOVFillColor = v
    end
})

W.silentFOVFillTrans = secSilR:AddSlider({
    Name = "Silent FOV Fill Transparency",
    Min = 0.01,
    Max = 1,
    Default = 0.1,
    Rounding = 2,
    Callback = function(v)
        SilentAimSettings.FOVFillTransparency = v
    end
})

secSilR:AddSeparator()

W.silentPredict = secSilR:AddToggle({
    Name = "Prediction",
    Default = false,
    Callback = function(v) SilentAimSettings.PredictEnabled = v end
})

W.silentPredictAmt = secSilR:AddSlider({
    Name = "Predict Amount",
    Min = 0.01,
    Max = 0.5,
    Default = 0.15,
    Rounding = 2,
    Callback = function(v) SilentAimSettings.PredictAmount = v end
})
    end

    do
        local SubTrigger = TabCombat:AddSubTab("Triggerbot")
        local secTrigL = SubTrigger:AddSection("Triggerbot", "Left")

W.triggerEnabled = secTrigL:AddToggle({
    Name = "Enable Triggerbot",
    Default = false,
    Callback = function(v)
        TriggerSettings.Enabled = v
        if not v then TriggerSettings.Active = false end
    end
})

TriggerSettings.Keybind = secTrigL:AddMouseKeybind({
    Name = "Trigger Key / Button",
    Default = {type = "key", value = Enum.KeyCode.Z},
    Callback = function() TriggerSettings.Active = false end
})

W.triggerDelay = secTrigL:AddSlider({
    Name = "Fire Delay (s)",
    Min = 0,
    Max = 3,
    Default = 0.5,
    Rounding = 2,
    Callback = function(v) TriggerSettings.Delay = v end
})

W.triggerInterval = secTrigL:AddSlider({
    Name = "Fire Interval (s)",
    Min = 0,
    Max = 0.5,
    Default = 0.05,
    Rounding = 3,
    Callback = function(v) TriggerSettings.FireInterval = v end
})

W.triggerBlacklist = secTrigL:AddDropdown({
    Name = "Blacklisted Tools",
    Values = {"[Knife]", "Combat", "[Phone]", "[Wallet]", "TipJar", "[Bat]", "[Shovel]", "[LockPicker]"},
    Default = {"[Knife]", "Combat", "[Phone]", "[Wallet]", "TipJar", "[Bat]", "[Shovel]", "[LockPicker]"},
    Multi = true,
    Callback = function(v) TriggerSettings.Blacklist = v end
})

local secTrigR = SubTrigger:AddSection("Hitbox & Prediction", "Right")

W.triggerShowHitbox = secTrigR:AddToggle({
    Name = "Show Hitbox",
    Default = false,
    Callback = function(v) TriggerSettings.ShowHitbox = v end
})

W.triggerHitboxSize = secTrigR:AddSlider({
    Name = "Hitbox Size",
    Min = 2,
    Max = 40,
    Default = 5,
    Rounding = 0,
    Callback = function(v) TriggerSettings.HitboxSize = v end
})

W.triggerHitboxColor = secTrigR:AddColorPicker({
    Name = "Hitbox Color",
    Default = Color3.fromRGB(255, 80, 80),
    Callback = function(v) TriggerSettings.HitboxColor = v end
})

secTrigR:AddSeparator()

W.triggerPredict = secTrigR:AddToggle({
    Name = "Trigger Prediction",
    Default = false,
    Callback = function(v) TriggerSettings.PredictEnabled = v end
})

W.triggerPredictAmt = secTrigR:AddSlider({
    Name = "Trigger Predict Amount",
    Min = 0.01,
    Max = 0.5,
    Default = 0.1,
    Rounding = 2,
    Callback = function(v) TriggerSettings.PredictAmount = v end
})
    end

    do
        local SubHitbox = TabCombat:AddSubTab("Hitbox")
        local secHitboxL = SubHitbox:AddSection("Hitbox Expander", "Left")
        local secHitboxR = SubHitbox:AddSection("Targeting Mode", "Right")

        W.hitboxEnabled = secHitboxL:AddToggle({
            Name = "Enable Hitbox Expander",
            Default = false,
            Callback = function(v)
                HitboxSettings.Enabled = v
                if not v and revertAllHitboxes then
                    revertAllHitboxes()
                end
            end
        })

        W.hitboxSize = secHitboxL:AddSlider({
            Name = "Hitbox Size",
            Min = 2,
            Max = 35,
            Default = 15,
            Rounding = 1,
            Callback = function(v)
                HitboxSettings.Size = v
            end
        })

        W.hitboxTransparency = secHitboxL:AddSlider({
            Name = "Transparency",
            Min = 0,
            Max = 1,
            Default = 0.5,
            Rounding = 2,
            Callback = function(v)
                HitboxSettings.Transparency = v
            end
        })

        W.hitboxColor = secHitboxL:AddColorPicker({
            Name = "Hitbox Color",
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(v)
                HitboxSettings.Color = v
            end
        })

        secHitboxL:AddSeparator()
        secHitboxL:AddLabel({Text = "Applies to all non-whitelisted players if no specific targeting mode is enabled."})

        W.hitboxSingleTarget = secHitboxR:AddToggle({
            Name = "Single Target (Keybind)",
            Default = false,
            Callback = function(v)
                HitboxSettings.SingleTargetEnabled = v
                if not v then
                    HitboxSettings.SingleTargetPlayer = nil
                end
            end
        })

        _hitboxBindObj = secHitboxR:AddMouseKeybind({
            Name = "Select Target Key",
            Default = {type = "key", value = Enum.KeyCode.Q},
            Callback = function() end
        })
        secHitboxR:AddLabel({Text = "Aim near a player and press key/click to select/deselect."})

        secHitboxR:AddButton({
            Name = "Clear Selected Target",
            Callback = function()
                HitboxSettings.SingleTargetPlayer = nil
                notify("Hitbox Target", "Target cleared", 2, "info")
            end
        })

        secHitboxR:AddSeparator()

        W.hitboxMultiTarget = secHitboxR:AddToggle({
            Name = "Multi Target Mode",
            Default = false,
            Callback = function(v)
                HitboxSettings.MultiTargetEnabled = v
            end
        })

        local function getOnlinePlayerNames()
            local names = {}
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    table.insert(names, plr.Name)
                end
            end
            table.sort(names)
            if #names == 0 then table.insert(names, "None") end
            return names
        end

        W.hitboxMultiDropdown = secHitboxR:AddDropdown({
            Name = "Select Players",
            Multi = true,
            Options = getOnlinePlayerNames(),
            Default = {},
            Callback = function(selected)
                HitboxSettings.MultiTargetPlayers = {}
                if type(selected) == "table" then
                    for name, isSel in pairs(selected) do
                        if isSel == true and name ~= "None" then
                            HitboxSettings.MultiTargetPlayers[name] = true
                        end
                    end
                end
            end
        })

        secHitboxR:AddButton({
            Name = "Refresh Player List",
            Callback = function()
                if W.hitboxMultiDropdown and W.hitboxMultiDropdown.Refresh then
                    W.hitboxMultiDropdown:Refresh(getOnlinePlayerNames(), true)
                end
            end
        })

        Players.PlayerAdded:Connect(function()
            task.defer(function()
                if not _scriptUnloaded and W.hitboxMultiDropdown and W.hitboxMultiDropdown.Refresh then
                    W.hitboxMultiDropdown:Refresh(getOnlinePlayerNames(), true)
                end
            end)
        end)
        Players.PlayerRemoving:Connect(function()
            task.defer(function()
                if not _scriptUnloaded and W.hitboxMultiDropdown and W.hitboxMultiDropdown.Refresh then
                    W.hitboxMultiDropdown:Refresh(getOnlinePlayerNames(), true)
                end
            end)
        end)
    end
end

do
    local TabESP = Window:CreateTab("Visuals")

    do
        local SubESPMain = TabESP:AddSubTab("Player ESP")
        local secESPL = SubESPMain:AddSection("Boxes & Fill", "Left")

W.espEnabled = secESPL:AddToggle({
    Name = "Enable ESP",
    Default = false,
    Callback = function(v)
        ESPSettings.Enabled = v
        esp:setEnabled(v)
    end
})

W.espMaxDist = secESPL:AddSlider({
    Name = "Max Distance",
    Min = 50,
    Max = 30000,
    Default = 1000,
    Rounding = 0,
    Callback = function(v)
        ESPSettings.MaxDist = v
        esp:setMaxDist(v)
    end
})

secESPL:AddSeparator()

W.espBox = secESPL:AddToggle({
    Name = "2D Box",
    Default = false,
    Callback = function(v)
        ESPSettings.Box = v
        esp:setBoxEnabled(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({Box = v}) end end)
    end
})

W.espBoxColor = secESPL:AddColorPicker({
    Name = "Box Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        ESPSettings.BoxColor = v
        esp:setBoxColor(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({BoxColor = v}) end end)
    end
})

W.esp3DBox = secESPL:AddToggle({
    Name = "3D Box",
    Default = false,
    Callback = function(v)
        ESPSettings.Box3D = v
        esp:setBox3DEnabled(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({Box3D = v}) end end)
    end
})

W.esp3DBoxColor = secESPL:AddColorPicker({
    Name = "3D Box Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        ESPSettings.Box3DColor = v
        esp:setBox3DColor(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({Box3DColor = v}) end end)
    end
})

secESPL:AddSeparator()

W.espBoxFill = secESPL:AddToggle({
    Name = "Box Fill",
    Default = false,
    Callback = function(v)
        ESPSettings.BoxFill = v
        esp:setBoxFill(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({BoxFill = v}) end end)
    end
})

W.espBoxFillColor = secESPL:AddColorPicker({
    Name = "Fill Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        ESPSettings.BoxFillColor = v
        esp:setBoxFillColor(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({BoxFillColor = v}) end end)
    end
})

W.espBoxFillTrans = secESPL:AddSlider({
    Name = "Fill Transparency",
    Min = 0,
    Max = 1,
    Default = 0.45,
    Rounding = 2,
    Callback = function(v)
        ESPSettings.BoxFillTrans = v
        esp:setBoxFillTransparency(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({BoxFillTrans = v}) end end)
    end
})

W.espGradientFill = secESPL:AddToggle({
    Name = "Gradient Box Fill",
    Default = false,
    Callback = function(v)
        ESPSettings.GradientFill = v
        esp:setGradientFill(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({GradientFill = v}) end end)
    end
})

W.espGradientTopColor = secESPL:AddColorPicker({
    Name = "Gradient Top Color",
    Default = Color3.fromRGB(65, 105, 205),
    Callback = function(v)
        ESPSettings.GradientTopColor = v
        esp:setGradientTopColor(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({GradientTopColor = v}) end end)
    end
})

W.espGradientBottomColor = secESPL:AddColorPicker({
    Name = "Gradient Bottom Color",
    Default = Color3.fromRGB(15, 20, 35),
    Callback = function(v)
        ESPSettings.GradientBottomColor = v
        esp:setGradientBottomColor(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({GradientBottomColor = v}) end end)
    end
})

local secESPMid = SubESPMain:AddSection("Health & Armor", "Left")

W.espHealthBar = secESPMid:AddToggle({
    Name = "Health Bar",
    Default = false,
    Callback = function(v)
        ESPSettings.HealthBar = v
        esp:setHealthBarEnabled(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({HealthBar = v, Health = v}) end end)
    end
})

W.espHealthBarSide = secESPMid:AddDropdown({
    Name = "Bar Side",
    Values = {"Left", "Right"},
    Default = "Left",
    Callback = function(v)
        ESPSettings.HealthBarSide = v
        esp:setHealthBarSide(v)
    end
})

W.espHpFull = secESPMid:AddColorPicker({
    Name = "Health Full Color",
    Default = Color3.fromRGB(0, 255, 0),
    Callback = function(v)
        ESPSettings.HpColorFull = v
        esp:setHpColorFull(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({HpColorFull = v, HealthColor = v}) end end)
    end
})

W.espHpMid = secESPMid:AddColorPicker({
    Name = "Health Mid Color",
    Default = Color3.fromRGB(255, 170, 0),
    Callback = function(v)
        ESPSettings.HpColorMid = v
        esp:setHpColorMid(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({HpColorMid = v}) end end)
    end
})

W.espHpEmpty = secESPMid:AddColorPicker({
    Name = "Health Empty Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(v)
        ESPSettings.HpColorEmpty = v
        esp:setHpColorEmpty(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({HpColorEmpty = v}) end end)
    end
})

secESPMid:AddSeparator()

W.espArmorBar = secESPMid:AddToggle({
    Name = "Armor Bar",
    Default = false,
    Callback = function(v)
        ESPSettings.ArmorBar = v
        esp:setArmorBarEnabled(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({ArmorBar = v, Armor = v}) end end)
    end
})

W.espArmorFull = secESPMid:AddColorPicker({
    Name = "Armor Full Color",
    Default = Color3.fromRGB(80, 160, 255),
    Callback = function(v)
        ESPSettings.ArmorColorFull = v
        esp:setArmorColorFull(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({ArmorColorFull = v, ArmorColor = v}) end end)
    end
})

W.espArmorEmpty = secESPMid:AddColorPicker({
    Name = "Armor Empty Color",
    Default = Color3.fromRGB(30, 60, 120),
    Callback = function(v)
        ESPSettings.ArmorColorEmpty = v
        esp:setArmorColorEmpty(v)
    end
})

local secESPR = SubESPMain:AddSection("Info & Overlays", "Right")

W.espNames = secESPR:AddToggle({
    Name = "Names",
    Default = false,
    Callback = function(v)
        ESPSettings.Names = v
        esp:setNamesEnabled(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({Name = v}) end end)
    end
})

W.espNameColor = secESPR:AddColorPicker({
    Name = "Name Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        ESPSettings.NameColor = v
        esp:setNamesColor(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({NameColor = v}) end end)
    end
})

W.espDistance = secESPR:AddToggle({
    Name = "Distance",
    Default = false,
    Callback = function(v)
        ESPSettings.Distance = v
        esp:setDistanceEnabled(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({Distance = v}) end end)
    end
})

W.espDistanceColor = secESPR:AddColorPicker({
    Name = "Distance Color",
    Default = Color3.fromRGB(200, 200, 200),
    Callback = function(v)
        ESPSettings.DistanceColor = v
        esp:setDistanceColor(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({DistanceColor = v, DistColor = v}) end end)
    end
})

W.espTool = secESPR:AddToggle({
    Name = "Tool / Weapon",
    Default = false,
    Callback = function(v)
        ESPSettings.Tool = v
        esp:setToolEnabled(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({Weapon = v, WeaponESP = v}) end end)
    end
})

W.espToolColor = secESPR:AddColorPicker({
    Name = "Tool Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        ESPSettings.ToolColor = v
        esp:setToolColor(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({WeaponColor = v}) end end)
    end
})

secESPR:AddSeparator()

W.espTracers = secESPR:AddToggle({
    Name = "Tracers",
    Default = false,
    Callback = function(v)
        ESPSettings.Tracers = v
        esp:setTracersEnabled(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({Tracers = v}) end end)
    end
})

W.espTracerOrigin = secESPR:AddDropdown({
    Name = "Tracer Origin",
    Values = {"Bottom", "Center", "Top"},
    Default = "Bottom",
    Callback = function(v)
        ESPSettings.TracerOrigin = v
        esp:setTracerOrigin(v)
    end
})

W.espTracerColor = secESPR:AddColorPicker({
    Name = "Tracer Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        ESPSettings.TracerColor = v
        esp:setTracerColor(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({TracerColor = v}) end end)
    end
})

secESPR:AddSeparator()

W.espSkeleton = secESPR:AddToggle({
    Name = "Skeleton",
    Default = false,
    Callback = function(v)
        ESPSettings.Skeleton = v
        esp:setSkeletonEnabled(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({Skeleton = v}) end end)
    end
})

W.espSkeletonColor = secESPR:AddColorPicker({
    Name = "Skeleton Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        ESPSettings.SkeletonColor = v
        esp:setSkeletonColor(v)
        pcall(function() if Window.UpdateESPPreview then Window:UpdateESPPreview({SkeletonColor = v}) end end)
    end
})
    end

    do
        local SubVisualMisc = TabESP:AddSubTab("Misc")
        local secMiscL = SubVisualMisc:AddSection("Combat & FX", "Left")

W.hitChams = secMiscL:AddToggle({
    Name = "Hit Chams",
    Default = false,
    Callback = function(v) HitChamsSettings.Enabled = v end
})

W.hitChamsColor = secMiscL:AddColorPicker({
    Name = "Hit Chams Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(v) HitChamsSettings.Color = v end
})

W.hitChamsMat = secMiscL:AddDropdown({
    Name = "Hit Chams Material",
    Values = {"Neon", "ForceField", "Glass", "Plastic", "Metal"},
    Default = "Neon",
    Callback = function(v) HitChamsSettings.Material = v end
})

W.hitChamsTrans = secMiscL:AddSlider({
    Name = "Hit Chams Transparency",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Rounding = 2,
    Callback = function(v) HitChamsSettings.Transparency = v end
})

W.hitChamsDuration = secMiscL:AddSlider({
    Name = "Hit Chams Duration",
    Min = 0.5,
    Max = 8,
    Default = 2,
    Rounding = 1,
    Callback = function(v) HitChamsSettings.Duration = v end
})

secMiscL:AddSeparator()

W.damageNumbers = secMiscL:AddToggle({
    Name = "Damage Numbers",
    Default = false,
    Callback = function(v) DamageNumbersSettings.Enabled = v end
})

W.damageNumbersColor = secMiscL:AddColorPicker({
    Name = "Damage Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v) DamageNumbersSettings.Color = v end
})

local secMiscR = SubVisualMisc:AddSection("Self & Weapon Visuals", "Right")

W.selfAura = secMiscR:AddToggle({
    Name = "Self Aura",
    Default = false,
    Callback = function(v)
        SelfAuraSettings.Enabled = v
        if v then sa2Refresh() else sa2Clear() end
    end
})

W.selfAuraColor = secMiscR:AddColorPicker({
    Name = "Aura Color",
    Default = Color3.fromRGB(133, 220, 255),
    Callback = function(v)
        SelfAuraSettings.Color = v
        sa2UpdateColor(v)
    end
})

W.selfAuraType = secMiscR:AddDropdown({
    Name = "Aura Type",
    Values = {"Cloak Aura", "Sweet Hearth", "Ethereal", "Starlight", "Heavenly", "Ribbon", "Sakura", "Angel", "Wind", "Flow", "Star", "Angelic", "Ambient", "Nimb", "Tornado", "Swirl", "Bubble", "Air", "Ritual", "Rain"},
    Default = "Cloak Aura",
    Multi = true,
    Callback = function(v)
        SelfAuraSettings.Type = v
        if SelfAuraSettings.Enabled then sa2Refresh() end
    end
})

secMiscR:AddSeparator()

W.chinaHat = secMiscR:AddToggle({
    Name = "China Hat",
    Default = false,
    Callback = function(v) ChinaHatSettings.Enabled = v end
})

W.chinaHatRainbow = secMiscR:AddToggle({
    Name = "China Hat Rainbow",
    Default = false,
    Callback = function(v) ChinaHatSettings.Rainbow = v end
})

W.chinaHatColor = secMiscR:AddColorPicker({
    Name = "China Hat Color",
    Default = Color3.fromRGB(128, 18, 255),
    Callback = function(v) ChinaHatSettings.Color = v end
})

W.chinaHatRadius = secMiscR:AddSlider({
    Name = "China Hat Radius",
    Min = 0.5,
    Max = 5,
    Default = 1,
    Rounding = 1,
    Callback = function(v) ChinaHatSettings.Radius = v end
})

W.chinaHatHeight = secMiscR:AddSlider({
    Name = "China Hat Height",
    Min = 0.1,
    Max = 3,
    Default = 0.75,
    Rounding = 2,
    Callback = function(v) ChinaHatSettings.Height = v end
})

W.chinaHatTrans = secMiscR:AddSlider({
    Name = "China Hat Transparency",
    Min = 0,
    Max = 1,
    Default = 0.35,
    Rounding = 2,
    Callback = function(v) ChinaHatSettings.HatTransparency = v end
})

W.chinaHatCircleTrans = secMiscR:AddSlider({
    Name = "Circle Transparency",
    Min = 0,
    Max = 1,
    Default = 1,
    Rounding = 2,
    Callback = function(v) ChinaHatSettings.CircleTransparency = v end
})

secMiscR:AddSeparator()

W.scEnabled = secMiscR:AddToggle({
    Name = "Enable Self Chams",
    Default = false,
    Callback = function(v)
        scEnabled = v
        if v then scEnable() else scDisable() end
    end
})

W.scColor = secMiscR:AddColorPicker({
    Name = "SC Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        scColor = v
        if scEnabled then scApply(LocalPlayer.Character) end
    end
})

W.scMat = secMiscR:AddDropdown({
    Name = "SC Material",
    Values = {"Neon", "Glass", "ForceField", "SmoothPlastic", "Metal"},
    Default = "ForceField",
    Callback = function(v)
        scMat = v
        if scEnabled then scApply(LocalPlayer.Character) end
    end
})

W.scTrans = secMiscR:AddSlider({
    Name = "SC Transparency",
    Min = 0,
    Max = 1,
    Default = 0,
    Rounding = 2,
    Callback = function(v)
        scTrans = v
        if scEnabled and scEffect ~= "heat" then scApply(LocalPlayer.Character) end
    end
})

W.scReflect = secMiscR:AddSlider({
    Name = "SC Reflectance",
    Min = 0,
    Max = 1,
    Default = 0,
    Rounding = 2,
    Callback = function(v)
        scReflect = v
        if scEnabled then scApply(LocalPlayer.Character) end
    end
})

W.scParticles = secMiscR:AddDropdown({
    Name = "SC Particles",
    Values = {"none", "stars", "specks"},
    Default = "none",
    Callback = function(v)
        scParticles = v
        if scEnabled then
            scRemoveParticles(LocalPlayer.Character)
            if scParticles == "stars" then
                scApplyStars(LocalPlayer.Character)
            elseif scParticles == "specks" then
                scApplySpecks(LocalPlayer.Character)
            end
        end
    end
})

W.scParticleColor = secMiscR:AddColorPicker({
    Name = "SC Particle Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        scParticleColor = v
        if scEnabled then
            scRemoveParticles(LocalPlayer.Character)
            if scParticles == "stars" then
                scApplyStars(LocalPlayer.Character)
            elseif scParticles == "specks" then
                scApplySpecks(LocalPlayer.Character)
            end
        end
    end
})

secMiscR:AddSeparator()

W.toolChams = secMiscR:AddToggle({
    Name = "Tool Chams",
    Default = false,
    Callback = function(v)
        ToolChamsSettings.Enabled = v
        if v then tcEnable() else tcDisable() end
    end
})

W.toolChamsColor = secMiscR:AddColorPicker({
    Name = "Tool Color",
    Default = Color3.fromRGB(155, 125, 175),
    Callback = function(v)
        ToolChamsSettings.Color = v
        if ToolChamsSettings.Enabled then for t in pairs(tcTracked) do tcApply(t) end end
    end
})

W.toolChamsMat = secMiscR:AddDropdown({
    Name = "Tool Material",
    Values = {"Neon", "Glass", "ForceField", "SmoothPlastic", "Metal"},
    Default = "ForceField",
    Callback = function(v)
        ToolChamsSettings.Material = v
        if ToolChamsSettings.Enabled then for t in pairs(tcTracked) do tcApply(t) end end
    end
})

W.toolChamsTrans = secMiscR:AddSlider({
    Name = "Tool Transparency",
    Min = 0,
    Max = 1,
    Default = 0,
    Rounding = 2,
    Callback = function(v)
        ToolChamsSettings.Transparency = v
        if ToolChamsSettings.Enabled then for t in pairs(tcTracked) do tcApply(t) end end
    end
})

W.toolChamsReflect = secMiscR:AddSlider({
    Name = "Tool Reflectance",
    Min = 0,
    Max = 1,
    Default = 0,
    Rounding = 2,
    Callback = function(v)
        ToolChamsSettings.Reflectance = v
        if ToolChamsSettings.Enabled then for t in pairs(tcTracked) do tcApply(t) end end
    end
})

W.toolChamsParticles = secMiscR:AddDropdown({
    Name = "Tool Particles",
    Values = {"none", "stars", "specks"},
    Default = "none",
    Callback = function(v)
        ToolChamsSettings.Particles = v
        if ToolChamsSettings.Enabled then
            for t in pairs(tcTracked) do
                tcRemoveParticles(t)
                if v == "stars" then tcApplyStars(t) elseif v == "specks" then tcApplySpecks(t) end
            end
        end
    end
})

W.toolChamsParticleColor = secMiscR:AddColorPicker({
    Name = "Tool Particle Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        ToolChamsSettings.ParticleColor = v
        if ToolChamsSettings.Enabled then
            for t in pairs(tcTracked) do
                tcRemoveParticles(t)
                if ToolChamsSettings.Particles == "stars" then tcApplyStars(t) elseif ToolChamsSettings.Particles == "specks" then tcApplySpecks(t) end
            end
        end
    end
})
    end
end

do
    local TabWorld = Window:CreateTab("World")

    local SubWorldEnv = TabWorld:AddSubTab("Environment")
    local secWorldL = SubWorldEnv:AddSection("Skybox & Lighting", "Left")

local skyboxNames = {"Default","Rainy","Space v2","Cosmo","Neon","Minecraft","Nightless","Retro","Crimson Night","Orange Sunset","Blue Galaxy","Abyssal Blues","Sunrise","Stormy Night","Snowy","Spongebob"}

W.skyboxDropdown = secWorldL:AddDropdown({
    Name = "Skybox",
    Values = skyboxNames,
    Default = "Default",
    Callback = function(v)
        applySkybox(v)
    end
})

secWorldL:AddSeparator()

W.lightingEnabled = secWorldL:AddToggle({
    Name = "Enable Lighting",
    Default = false,
    Callback = function(v)
        LightingMods = v
        if not v then
            Lighting.Ambient              = OrigLighting.Ambient
            Lighting.OutdoorAmbient       = OrigLighting.OutdoorAmbient
            Lighting.FogStart             = OrigLighting.FogStart
            Lighting.FogEnd               = OrigLighting.FogEnd
            Lighting.FogColor             = OrigLighting.FogColor
            Lighting.Brightness           = OrigLighting.Brightness
            Lighting.ExposureCompensation = OrigLighting.ExposureCompensation
            Lighting.ClockTime            = OrigLighting.ClockTime
        end
    end
})

W.lightingExposure = secWorldL:AddSlider({
    Name = "Exposure Compensation",
    Min = -3,
    Max = 3,
    Default = -0.3,
    Rounding = 1,
    Callback = function(v) LightingMod.ExposureCompensation = v end
})

W.lightingBrightness = secWorldL:AddSlider({
    Name = "Brightness",
    Min = 0,
    Max = 10,
    Default = 2,
    Rounding = 2,
    Callback = function(v) LightingMod.Brightness = v end
})

W.lightingClockTime = secWorldL:AddSlider({
    Name = "Clock Time",
    Min = 0,
    Max = 24,
    Default = 14,
    Rounding = 1,
    Callback = function(v) LightingMod.ClockTime = v end
})

local secWorldR = SubWorldEnv:AddSection("Atmosphere & Fog", "Right")

W.lightingAmbient = secWorldR:AddColorPicker({
    Name = "Ambient",
    Default = Color3.fromRGB(0, 0, 0),
    Callback = function(v) LightingMod.Ambient = v end
})

W.lightingOutdoor = secWorldR:AddColorPicker({
    Name = "Outdoor Ambient",
    Default = Color3.fromRGB(80, 120, 200),
    Callback = function(v) LightingMod.OutdoorAmbient = v end
})

secWorldR:AddSeparator()

W.lightingFogStart = secWorldR:AddSlider({
    Name = "Fog Start",
    Min = 0,
    Max = 5000,
    Default = 50,
    Rounding = 0,
    Callback = function(v) LightingMod.FogStart = v end
})

W.lightingFogEnd = secWorldR:AddSlider({
    Name = "Fog End",
    Min = 0,
    Max = 10000,
    Default = 1000,
    Rounding = 0,
    Callback = function(v) LightingMod.FogEnd = v end
})

W.lightingFogColor = secWorldR:AddColorPicker({
    Name = "Fog Color",
    Default = Color3.fromRGB(80, 120, 200),
    Callback = function(v) LightingMod.FogColor = v end
})
end

do
    local TabMisc = Window:CreateTab("Movement")
    local SubMiscL = TabMisc:AddSubTab("Movement")

    local secSpeed = SubMiscL:AddSection("Speed & NoClip", "Left")

W.speedEnabled = secSpeed:AddToggle({
    Name = "WalkSpeed",
    Default = false,
    Callback = function(v)
        SpeedSettings.Enabled = v
        if not v then
            SpeedSettings.KeybindActive = false
            local char = LocalPlayer.Character
            local hum  = char and char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
    end
})

_speedBindObj = secSpeed:AddMouseKeybind({
    Name = "Speed Toggle Key",
    Default = {type = "key", value = Enum.KeyCode.V},
    Callback = function() end
})

W.speedValue = secSpeed:AddSlider({
    Name = "WalkSpeed Amount",
    Min = 16,
    Max = 500,
    Default = 16,
    Rounding = 0,
    Callback = function(v) SpeedSettings.Value = v end
})

secSpeed:AddSeparator()

W.cframeSpeedEnabled = secSpeed:AddToggle({
    Name = "CFrame Speed",
    Default = false,
    Callback = function(v)
        CFrameSpeedSettings.Enabled = v
        CFrameSpeedSettings.KeybindActive = v
    end
})

_cframeSpeedBindObj = secSpeed:AddMouseKeybind({
    Name = "CFrame Speed Key",
    Default = {type = "key", value = Enum.KeyCode.B},
    Callback = function() end
})

W.cframeSpeedValue = secSpeed:AddSlider({
    Name = "CFrame Speed Amount",
    Min = 16,
    Max = 1000,
    Default = 150,
    Rounding = 0,
    Callback = function(v) CFrameSpeedSettings.Value = v end
})

secSpeed:AddSeparator()

W.noClip = secSpeed:AddToggle({
    Name = "No Clip",
    Default = false,
    Callback = function(v)
        NoClipEnabled = v
        if not v and LocalPlayer.Character then
            for _, p in pairs(LocalPlayer.Character:GetChildren()) do
                if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.CanCollide = true end
            end
        end
    end
})

local secFly = SubMiscL:AddSection("Fly & Teleport", "Right")

W.flyEnabled = secFly:AddToggle({
    Name = "Enable Fly System",
    Default = false,
    Callback = function(v)
        FlySettings.Enabled = v
        _flyToggled = v
        if v then startFly() else stopFly() end
    end
})

_flyBindObj = secFly:AddMouseKeybind({
    Name = "Fly Toggle Key",
    Default = {type = "key", value = Enum.KeyCode.X},
    Callback = function() end
})

W.flySpeed = secFly:AddSlider({
    Name = "Fly Speed",
    Min = 10,
    Max = 500,
    Default = 50,
    Rounding = 0,
    Callback = function(v) FlySettings.Speed = v end
})

secFly:AddSeparator()

W.tpEnabled = secFly:AddToggle({
    Name = "Enable Teleport",
    Default = false,
    Callback = function(v) _tpEnabled = v end
})

W.tpMode = secFly:AddDropdown({
    Name = "Teleport Mode",
    Values = {"Hold", "Toggle"},
    Default = "Hold",
    Callback = function(v)
        _tpMode = v
        if v == "Hold" then _tpHolding = false end
    end
})

_tpBindObj = secFly:AddMouseKeybind({
    Name = "Teleport Key",
    Default = {type = "key", value = Enum.KeyCode.T},
    Callback = function() end
})

W.tpOrbit = secFly:AddToggle({
    Name = "Orbit On Teleport",
    Default = false,
    Callback = function(v) _tpOrbit = v end
})

W.tpOrbitSpeed = secFly:AddSlider({
    Name = "Orbit Speed",
    Min = 0.5,
    Max = 15,
    Default = 3,
    Rounding = 1,
    Callback = function(v) _tpOrbitSpeed = v end
})

W.tpOrbitRadius = secFly:AddSlider({
    Name = "Orbit Radius",
    Min = 2,
    Max = 30,
    Default = 8,
    Rounding = 0,
    Callback = function(v) _tpOrbitRadius = v end
})

secFly:AddLabel({Text = "Hold key or Toggle mode to teleport / orbit."})

local function doTeleport(dt)
    if not _tpEnabled then return end
    local target = GetPlayerAtCrosshair()
    if not (target and target.Character) then return end
    local tHRP = target.Character:FindFirstChild("HumanoidRootPart")
    local myChar = LocalPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if tHRP and myHRP then
        if _tpOrbit then
            local step = dt or 0.03
            _tpOrbitAngle = _tpOrbitAngle + step * _tpOrbitSpeed * 2 * math.pi
            local want = tHRP.Position + Vector3.new(math.sin(_tpOrbitAngle) * _tpOrbitRadius, 0, math.cos(_tpOrbitAngle) * _tpOrbitRadius)
            myHRP.CFrame = CFrame.new(want, tHRP.Position)
        else
            myHRP.CFrame = tHRP.CFrame * CFrame.new(0, 0, 3)
        end
    end
end

UserInputService.InputBegan:Connect(function(inp, proc)
    if UserInputService:GetFocusedTextBox() then return end
    if not matchesBind(inp, _tpBindObj.Value) then return end
    if not _tpEnabled then return end

    if _tpMode == "Toggle" then
        _tpHolding = not _tpHolding
        if _tpHolding then
            task.spawn(function()
                local lastT = os.clock()
                while _tpHolding and _tpEnabled do
                    local now = os.clock()
                    local dt = now - lastT
                    lastT = now
                    doTeleport(dt)
                    task.wait(0.016)
                end
                _tpHolding = false
            end)
        end
    else
        _tpHolding = true
        task.spawn(function()
            local lastT = os.clock()
            while _tpHolding and _tpEnabled do
                local now = os.clock()
                local dt = now - lastT
                lastT = now
                doTeleport(dt)
                task.wait(0.016)
            end
        end)
    end
end)

UserInputService.InputEnded:Connect(function(inp)
    if _tpMode == "Hold" and matchesBind(inp, _tpBindObj.Value) then
        _tpHolding = false
    end
end)

UserInputService.InputBegan:Connect(function(inp, proc)
    if UserInputService:GetFocusedTextBox() or not SpeedSettings.Enabled then return end
    if matchesBind(inp, _speedBindObj.Value) then
        SpeedSettings.KeybindActive = not SpeedSettings.KeybindActive
        if not SpeedSettings.KeybindActive then
            local char = LocalPlayer.Character
            local hum  = char and char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
    end
end)

UserInputService.InputBegan:Connect(function(inp, proc)
    if UserInputService:GetFocusedTextBox() then return end
    if _cframeSpeedBindObj and matchesBind(inp, _cframeSpeedBindObj.Value) then
        CFrameSpeedSettings.Enabled = not CFrameSpeedSettings.Enabled
        CFrameSpeedSettings.KeybindActive = CFrameSpeedSettings.Enabled
        if W.cframeSpeedEnabled and W.cframeSpeedEnabled.Set then
            pcall(function() W.cframeSpeedEnabled:Set(CFrameSpeedSettings.Enabled) end)
        end
    end
end)

UserInputService.InputBegan:Connect(function(inp, proc)
    if UserInputService:GetFocusedTextBox() or not FlySettings.Enabled then return end
    if _flyBindObj and matchesBind(inp, _flyBindObj.Value) then
        _flyToggled = not _flyToggled
        if _flyToggled then startFly() else stopFly() end
    end
end)
end

do
    local TabSettings = Window:CreateTab("Misc")

    local SubMiscR = TabSettings:AddSubTab("Utilities")
    local secUtilL = SubMiscR:AddSection("Hotkeys & System", "Left")

    secUtilL:AddLabel({Text = "Menu key - keyboard only, no default:"})
    _menuBindObj = secUtilL:AddMouseKeybind({
        Name = "Menu Toggle Key",
        Default = {type = "key", value = Enum.KeyCode.RightControl},
        Callback = function() end
    })
    secUtilL:AddLabel({Text = "Press a KEY to set. Mouse buttons are not accepted."})

    secUtilL:AddSeparator()

    _hideBindObj = secUtilL:AddMouseKeybind({
        Name = "Hide Visuals Key",
        Default = {type = "key", value = Enum.KeyCode.Insert},
        Callback = function() end
    })
    secUtilL:AddLabel({Text = "Hides ESP/FOV drawings. Everything keeps working."})

    secUtilL:AddSeparator()

    secUtilL:AddLabel({Text = "Unload key - disables everything and closes UI:"})
    _unloadBindObj = secUtilL:AddMouseKeybind({
        Name = "Unload Key",
        Default = {type = "key", value = Enum.KeyCode.End},
        Callback = function() end
    })
    secUtilL:AddLabel({Text = "Press to fully unload the script."})
    secUtilL:AddButton({
        Name = "Unload Script",
        Callback = function()
            fullUnload()
        end
    })

secUtilL:AddSeparator()

secUtilL:AddButton({
    Name = "Rejoin Server",
    Callback = function()
        local lp = Players.LocalPlayer
        if game.JobId ~= "" then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
        else
            TeleportService:Teleport(game.PlaceId, lp)
        end
    end
})

local secUtilR = SubMiscR:AddSection("Appearance & Execution", "Right")

local _currentEffectConn = nil
local function applyEffect(effectName)
    local backdrop = Window._Backdrop
    if not backdrop then return end
    for _, child in ipairs(backdrop:GetChildren()) do
        if child:IsA("Frame") and child.BackgroundTransparency == 1 then child:Destroy() end
    end
    if _currentEffectConn then _currentEffectConn:Disconnect(); _currentEffectConn = nil end
    if effectName == "None" then return end
    local cont = Instance.new("Frame", backdrop)
    cont.Size = UDim2.new(1,0,1,0); cont.BackgroundTransparency = 1
    cont.ClipsDescendants = true; cont.ZIndex = 0
    if effectName == "Snow" then
        local flakes = {}
        for i = 1, 120 do
            local sz = math.random(1,3)
            local f = Instance.new("Frame", cont)
            f.Size = UDim2.new(0,sz,0,sz); f.BackgroundColor3 = Color3.fromRGB(255,255,255)
            f.BackgroundTransparency = math.random(40,75)/100; f.BorderSizePixel = 0
            local c = Instance.new("UICorner", f); c.CornerRadius = UDim.new(0,sz)
            flakes[i] = {frame=f, x=math.random(0,1000)/1000, y=math.random(-10,100)/100,
                speed=math.random(6,14)/1000, drift=math.random(-4,4)/10000}
            f.Position = UDim2.new(flakes[i].x, 0, flakes[i].y, 0)
        end
        _currentEffectConn = RunService.Heartbeat:Connect(function(dt)
            if not cont or not cont.Parent then _currentEffectConn:Disconnect(); return end
            for _, fl in ipairs(flakes) do
                fl.y = fl.y + fl.speed*dt*60; fl.x = fl.x + fl.drift*dt*60
                if fl.y > 1.05 then fl.y = -0.05; fl.x = math.random(0,1000)/1000 end
                if fl.x < 0 then fl.x = 1 elseif fl.x > 1 then fl.x = 0 end
                fl.frame.Position = UDim2.new(fl.x, 0, fl.y, 0)
            end
        end)
    elseif effectName == "Rain" then
        local drops = {}
        for i = 1, 70 do
            local w = math.random(1,2); local h = math.random(8,18)
            local f = Instance.new("Frame", cont)
            f.Size = UDim2.new(0,w,0,h); f.BackgroundColor3 = Color3.fromRGB(255,255,255)
            f.BackgroundTransparency = math.random(55,80)/100; f.BorderSizePixel = 0
            local c = Instance.new("UICorner", f); c.CornerRadius = UDim.new(0,1)
            drops[i] = {frame=f, x=math.random(0,1000)/1000, y=math.random(-20,100)/100,
                speed=math.random(10,20)/1000, drift=math.random(1,3)/10000}
            f.Position = UDim2.new(drops[i].x, 0, drops[i].y, 0)
        end
        _currentEffectConn = RunService.Heartbeat:Connect(function(dt)
            if not cont or not cont.Parent then _currentEffectConn:Disconnect(); return end
            for _, dr in ipairs(drops) do
                dr.y = dr.y + dr.speed*dt*60; dr.x = dr.x + dr.drift*dt*60
                if dr.y > 1.05 then dr.y = -0.05; dr.x = math.random(0,1000)/1000 end
                if dr.x > 1 then dr.x = 0 end
                dr.frame.Position = UDim2.new(dr.x, 0, dr.y, 0)
            end
        end)
    end
end

secUtilR:AddDropdown({
    Name = "Background Effect",
    Values = {"Snow", "Rain", "None"},
    Default = "Snow",
    Callback = function(v) applyEffect(v) end
})
end

UserInputService.InputBegan:Connect(function(inp, proc)
    if UserInputService:GetFocusedTextBox() then return end
    if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
    if matchesMenuBind(inp, _menuBindObj.Value) then Window.ToggleWindow() end
end)

UserInputService.InputBegan:Connect(function(inp, proc)
    if UserInputService:GetFocusedTextBox() then return end
    if matchesBind(inp, _hideBindObj.Value) then
        _hidden = not _hidden
        if _hidden then
            if scEnabled then scDisable() end
            if LightingMods then
                Lighting.Ambient        = OrigLighting.Ambient
                Lighting.OutdoorAmbient = OrigLighting.OutdoorAmbient
                Lighting.FogStart       = OrigLighting.FogStart
                Lighting.FogEnd         = OrigLighting.FogEnd
                Lighting.FogColor       = OrigLighting.FogColor
                Lighting.Brightness     = OrigLighting.Brightness
            end
        else
            if scEnabled then scEnable() end
        end
    end
end)

UserInputService.InputBegan:Connect(function(inp, proc)
    if _scriptUnloaded then return end
    if UserInputService:GetFocusedTextBox() then return end
    if _unloadBindObj and matchesBind(inp, _unloadBindObj.Value) then fullUnload() end
end)

UserInputService.InputBegan:Connect(function(inp, proc)
    if _scriptUnloaded then return end
    if proc or UserInputService:GetFocusedTextBox() then return end
    if _hitboxBindObj and matchesBind(inp, _hitboxBindObj.Value) then
        if HitboxSettings.SingleTargetEnabled then
            local target = getPlayerUnderMouse and getPlayerUnderMouse()
            if target then
                if HitboxSettings.SingleTargetPlayer == target then
                    HitboxSettings.SingleTargetPlayer = nil
                    notify("Hitbox Target", "Unselected " .. target.DisplayName, 2, "info")
                else
                    HitboxSettings.SingleTargetPlayer = target
                    notify("Hitbox Target", "Selected: " .. target.DisplayName .. " (@" .. target.Name .. ")", 2.5, "success")
                end
            else
                notify("Hitbox Target", "No player under cursor", 2, "warn")
            end
        end
    end
end)

do
local function colorToT(c) return {r = c.R, g = c.G, b = c.B} end
local function tToColor(t)
    if type(t) ~= "table" then return nil end
    return Color3.new(t.r or 1, t.g or 1, t.b or 1)
end
local function bindToT(b)
    if not b then return nil end
    while type(b) == "table" and b.Value ~= nil do b = b.Value end
    local btype = (type(b) == "table" and (b.type or b.btype)) or "key"
    local bval = type(b) == "table" and b.value or b
    local valStr = "Unknown"
    if typeof(bval) == "EnumItem" then
        valStr = bval.Name
    elseif type(bval) == "string" then
        valStr = bval:match("%.([^%..]+)$") or bval
    end
    return {btype = btype, value = valStr}
end
local function tToBind(t)
    if not t then return nil end
    if typeof(t) == "EnumItem" then
        if t.EnumType == Enum.UserInputType then return {type = "mouse", value = t} end
        return {type = "key", value = t}
    end
    if type(t) == "string" then
        local raw = t:match("%.([^%..]+)$") or t
        if Enum.KeyCode[raw] then return {type = "key", value = Enum.KeyCode[raw]} end
        if Enum.UserInputType[raw] then return {type = "mouse", value = Enum.UserInputType[raw]} end
        return {type = "key", value = raw}
    end
    if type(t) ~= "table" then return nil end
    if t.Value ~= nil then return tToBind(t.Value) end
    local btype = t.type or t.btype or "key"
    local valStr = t.value or t.val
    if typeof(valStr) == "EnumItem" then
        return {type = btype, value = valStr}
    end
    local raw = tostring(valStr or ""):match("%.([^%..]+)$") or tostring(valStr or "")
    if btype == "mouse" then
        local ut = Enum.UserInputType[raw]
        return {type = "mouse", value = ut or raw}
    else
        local kc = Enum.KeyCode[raw]
        return {type = "key", value = kc or raw}
    end
end
local function getBind(obj)
    if obj and obj.Value then return bindToT(obj.Value) end
    return nil
end

local function collectConfig()
    return {
        CamLockEnabled        = CamLockSettings.Enabled,
        CamLockFOV            = CamLockSettings.FOV,
        CamLockFOVMode        = CamLockSettings.FOVMode,
        CamLockSmooth         = CamLockSettings.Smoothness,
        CamLockPart           = CamLockSettings.TargetPart,
        CamLockMode           = _camMode,
        CamLockSticky         = CamLockSettings.Sticky,
        CamLockKOCheck        = CamLockSettings.KOCheck,
        CamLockWallCheck      = CamLockSettings.WallCheck,
        CamLockPredict        = CamLockSettings.PredictionEnabled,
        CamLockPredictAmt     = CamLockSettings.Prediction,
        CamLockAutoPred       = CamLockSettings.AutoPrediction,
        CamLockAntiGround     = CamLockSettings.AntiGroundShot,
        CamLockAirCheck       = CamLockSettings.AirCheck,
        CamLockAirPart        = CamLockSettings.AirPart,
        CamLockDeadzone       = CamLockSettings.DeadzoneEnabled,
        CamLockDeadzoneVal    = CamLockSettings.Deadzone,
        CamLockShake          = CamLockSettings.ShakeEnabled,
        CamLockShakeAmt       = CamLockSettings.ShakeAmount,
        CamLockShowFOV        = CamLockSettings.ShowFOV,
        CamLockFOVColor       = colorToT(CamLockSettings.FOVColor),
        CamLockFOVFill        = CamLockSettings.FOVFill,
        CamLockFOVFillColor   = colorToT(CamLockSettings.FOVFillColor),
        CamLockFOVFillTrans   = CamLockSettings.FOVFillTransparency,

        BindCamLock           = getBind(_camBindObj),
        BindSilent            = getBind(_silentBindObj),
        BindTrigger           = getBind(TriggerSettings.Keybind),
        BindSpeed             = getBind(_speedBindObj),
        BindCFrameSpeed       = getBind(_cframeSpeedBindObj),
        BindFly               = getBind(_flyBindObj),
        BindTP                = getBind(_tpBindObj),
        BindMenu              = getBind(_menuBindObj),
        BindHide              = getBind(_hideBindObj),
        BindUnload            = getBind(_unloadBindObj),
        BindHitbox            = getBind(_hitboxBindObj),
        HitboxEnabled         = HitboxSettings.Enabled,
        HitboxSize            = HitboxSettings.Size,
        HitboxTransparency    = HitboxSettings.Transparency,
        HitboxColor           = colorToT(HitboxSettings.Color),
        HitboxSingleTarget    = HitboxSettings.SingleTargetEnabled,
        HitboxMultiTarget     = HitboxSettings.MultiTargetEnabled,
        HitboxMultiPlayers    = HitboxSettings.MultiTargetPlayers,
        GlobalWhitelist       = _G.Lexhancements_GlobalWhitelist,

        SilentEnabled         = SilentAimSettings.Enabled,
        SilentFOVMode         = SilentAimSettings.FOVMode,
        SilentHitpartMode     = SilentAimSettings.HitpartMode,
        SilentFOV             = SilentAimSettings.FOV,
        SilentHitChance       = SilentAimSettings.HitChance,
        SilentPart            = SilentAimSettings.TargetPart,
        SilentMaxDistance     = SilentAimSettings.MaxDistance,
        SilentIgnoreKO        = SilentAimSettings.IgnoreKO,
        SilentWallCheck       = SilentAimSettings.WallCheck,
        SilentPredict         = SilentAimSettings.PredictEnabled,
        SilentPredictAmt      = SilentAimSettings.PredictAmount,
        SilentShowFOV         = SilentAimSettings.ShowFOV,
        SilentFOVColor        = colorToT(SilentAimSettings.FOVColor),
        SilentFOVFill         = SilentAimSettings.FOVFill,
        SilentFOVFillColor    = colorToT(SilentAimSettings.FOVFillColor),
        SilentFOVFillTrans    = SilentAimSettings.FOVFillTransparency,

        RapidFire             = RapidFireSettings.Enabled,
        RapidFireDelay        = RapidFireSettings.Delay,

        TriggerEnabled     = TriggerSettings.Enabled,
        TriggerDelay       = TriggerSettings.Delay,
        TriggerInterval    = TriggerSettings.FireInterval,
        TriggerBlacklist   = TriggerSettings.Blacklist,
        TriggerShowHitbox  = TriggerSettings.ShowHitbox,
        TriggerHitboxSize  = TriggerSettings.HitboxSize,
        TriggerPredict     = TriggerSettings.PredictEnabled,
        TriggerPredictAmt  = TriggerSettings.PredictAmount,
        TriggerHitboxColor = colorToT(TriggerSettings.HitboxColor),

        ESPEnabled              = ESPSettings.Enabled,
        ESPMaxDist              = ESPSettings.MaxDist,
        ESPBox                  = ESPSettings.Box,
        ESPBoxColor             = colorToT(ESPSettings.BoxColor),
        ESP3DBox                = ESPSettings.Box3D,
        ESP3DBoxColor           = colorToT(ESPSettings.Box3DColor),
        ESPBoxFill              = ESPSettings.BoxFill,
        ESPBoxFillColor         = colorToT(ESPSettings.BoxFillColor),
        ESPBoxFillTrans         = ESPSettings.BoxFillTrans,
        ESPGradientFill         = ESPSettings.GradientFill,
        ESPGradientTopColor     = colorToT(ESPSettings.GradientTopColor),
        ESPGradientBottomColor  = colorToT(ESPSettings.GradientBottomColor),
        ESPHealthBar            = ESPSettings.HealthBar,
        ESPHealthBarSide        = ESPSettings.HealthBarSide,
        ESPHpFull               = colorToT(ESPSettings.HpColorFull),
        ESPHpMid                = colorToT(ESPSettings.HpColorMid),
        ESPHpEmpty              = colorToT(ESPSettings.HpColorEmpty),
        ESPArmorBar             = ESPSettings.ArmorBar,
        ESPArmorFull            = colorToT(ESPSettings.ArmorColorFull),
        ESPArmorEmpty           = colorToT(ESPSettings.ArmorColorEmpty),
        ESPNames                = ESPSettings.Names,
        ESPNameColor            = colorToT(ESPSettings.NameColor),
        ESPDistance             = ESPSettings.Distance,
        ESPDistanceColor        = colorToT(ESPSettings.DistanceColor),
        ESPTool                 = ESPSettings.Tool,
        ESPToolColor            = colorToT(ESPSettings.ToolColor),
        ESPTracers              = ESPSettings.Tracers,
        ESPTracerOrigin         = ESPSettings.TracerOrigin,
        ESPTracerColor          = colorToT(ESPSettings.TracerColor),
        ESPSkeleton             = ESPSettings.Skeleton,
        ESPSkeletonColor        = colorToT(ESPSettings.SkeletonColor),

        SpeedEnabled          = SpeedSettings.Enabled,
        SpeedValue            = SpeedSettings.Value,
        CFrameSpeedEnabled    = CFrameSpeedSettings.Enabled,
        CFrameSpeedValue      = CFrameSpeedSettings.Value,
        FlyEnabled            = FlySettings.Enabled,
        FlySpeed              = FlySettings.Speed,
        NoClip                = NoClipEnabled,
        TPEnabled             = _tpEnabled,
        TPMode                = _tpMode,
        TPOrbit               = _tpOrbit,
        TPOrbitSpeed          = _tpOrbitSpeed,
        TPOrbitRadius         = _tpOrbitRadius,

        Skybox                = selectedSkybox,
        LightingEnabled       = LightingMods,
        LightingBrightness    = LightingMod.Brightness,
        LightingExposure      = LightingMod.ExposureCompensation,
        LightingClockTime     = LightingMod.ClockTime,
        LightingFogStart      = LightingMod.FogStart,
        LightingFogEnd        = LightingMod.FogEnd,
        LightingAmbient       = colorToT(LightingMod.Ambient),
        LightingOutdoor       = colorToT(LightingMod.OutdoorAmbient),
        LightingFogColor      = colorToT(LightingMod.FogColor),

        HitChamsEnabled       = HitChamsSettings.Enabled,
        HitChamsColor         = colorToT(HitChamsSettings.Color),
        HitChamsMat           = HitChamsSettings.Material,
        HitChamsTrans         = HitChamsSettings.Transparency,
        HitChamsDuration      = HitChamsSettings.Duration,

        DamageNumbersEnabled  = DamageNumbersSettings.Enabled,
        DamageNumbersColor    = colorToT(DamageNumbersSettings.Color),

        SelfAuraEnabled       = SelfAuraSettings.Enabled,
        SelfAuraColor         = colorToT(SelfAuraSettings.Color),
        SelfAuraType          = SelfAuraSettings.Type,

        ChinaHatEnabled       = ChinaHatSettings.Enabled,
        ChinaHatRainbow       = ChinaHatSettings.Rainbow,
        ChinaHatColor         = colorToT(ChinaHatSettings.Color),
        ChinaHatRadius        = ChinaHatSettings.Radius,
        ChinaHatHeight        = ChinaHatSettings.Height,
        ChinaHatTrans         = ChinaHatSettings.HatTransparency,
        ChinaHatCircleTrans   = ChinaHatSettings.CircleTransparency,

        SCEnabled             = scEnabled,
        SCTrans               = scTrans,
        SCReflect             = scReflect,
        SCMat                 = scMat,
        SCEffect              = scEffect,
        SCParticles           = scParticles,
        SCColor               = colorToT(scColor),
        SCParticleColor       = colorToT(scParticleColor),

        ToolChamsEnabled       = ToolChamsSettings.Enabled,
        ToolChamsColor         = colorToT(ToolChamsSettings.Color),
        ToolChamsMat           = ToolChamsSettings.Material,
        ToolChamsTrans         = ToolChamsSettings.Transparency,
        ToolChamsReflect       = ToolChamsSettings.Reflectance,
        ToolChamsParticles     = ToolChamsSettings.Particles,
        ToolChamsParticleColor = colorToT(ToolChamsSettings.ParticleColor),
    }
end

local function applyConfig(cfg)
    if not cfg then return end
    local function gc(t, def) return tToColor(t) or def end
    local function sb(obj, t)
        if obj and t then
            local b = tToBind(t)
            if b and obj.Set then obj:Set(b) end
        end
    end
    local function setv(obj, val)
        if obj and obj.Set and val ~= nil then
            pcall(function() obj:Set(val) end)
        end
    end

    local cEnabled = cfg.CamLockEnabled
    if cEnabled == nil then cEnabled = cfg.AimbotEnabled end
    if cEnabled ~= nil then CamLockSettings.Enabled = cEnabled end

    local cFOV = cfg.CamLockFOV
    if cFOV == nil then cFOV = cfg.AimbotFOV end
    if cFOV ~= nil then CamLockSettings.FOV = cFOV end

    if cfg.CamLockFOVMode ~= nil then CamLockSettings.FOVMode = cfg.CamLockFOVMode end

    local cSmooth = cfg.CamLockSmooth
    if cSmooth == nil then cSmooth = cfg.AimbotSmooth end
    if cSmooth ~= nil then CamLockSettings.Smoothness = cSmooth end

    local cPart = cfg.CamLockPart
    if cPart == nil then cPart = cfg.AimbotPart end
    if cPart ~= nil then CamLockSettings.TargetPart = cPart end

    local cMode = cfg.CamLockMode
    if cMode == nil then cMode = cfg.AimbotMode end
    if cMode ~= nil then _camMode = cMode end

    local cSticky = cfg.CamLockSticky
    if cSticky == nil then cSticky = cfg.AimbotSticky end
    if cSticky ~= nil then CamLockSettings.Sticky = cSticky end

    local cKO = cfg.CamLockKOCheck
    if cKO == nil then cKO = cfg.AimbotIgnoreKO end
    if cKO ~= nil then CamLockSettings.KOCheck = cKO end

    if cfg.CamLockWallCheck ~= nil then CamLockSettings.WallCheck = cfg.CamLockWallCheck end

    local cPred = cfg.CamLockPredict
    if cPred == nil then cPred = cfg.AimbotPredict end
    if cPred ~= nil then CamLockSettings.PredictionEnabled = cPred end

    local cPredAmt = cfg.CamLockPredictAmt
    if cPredAmt == nil then cPredAmt = cfg.AimbotPredictAmt end
    if cPredAmt ~= nil then CamLockSettings.Prediction = cPredAmt end

    if cfg.CamLockAutoPred ~= nil then CamLockSettings.AutoPrediction = cfg.CamLockAutoPred end
    if cfg.CamLockAntiGround ~= nil then CamLockSettings.AntiGroundShot = cfg.CamLockAntiGround end
    if cfg.CamLockAirCheck ~= nil then CamLockSettings.AirCheck = cfg.CamLockAirCheck end
    if cfg.CamLockAirPart ~= nil then CamLockSettings.AirPart = cfg.CamLockAirPart end
    if cfg.CamLockDeadzone ~= nil then CamLockSettings.DeadzoneEnabled = cfg.CamLockDeadzone end
    if cfg.CamLockDeadzoneVal ~= nil then CamLockSettings.Deadzone = cfg.CamLockDeadzoneVal end
    if cfg.CamLockShake ~= nil then CamLockSettings.ShakeEnabled = cfg.CamLockShake end
    if cfg.CamLockShakeAmt ~= nil then CamLockSettings.ShakeAmount = cfg.CamLockShakeAmt end

    local cShowFOV = cfg.CamLockShowFOV
    if cShowFOV == nil then cShowFOV = cfg.AimbotShowFOV end
    if cShowFOV ~= nil then CamLockSettings.ShowFOV = cShowFOV end

    if cfg.CamLockFOVColor then
        CamLockSettings.FOVColor = gc(cfg.CamLockFOVColor, Color3.fromRGB(255, 255, 255))
    elseif cfg.AimbotFOVColor then
        CamLockSettings.FOVColor = gc(cfg.AimbotFOVColor, Color3.fromRGB(255, 255, 255))
    end
    if cfg.CamLockFOVFill ~= nil then CamLockSettings.FOVFill = cfg.CamLockFOVFill end
    if cfg.CamLockFOVFillColor then CamLockSettings.FOVFillColor = gc(cfg.CamLockFOVFillColor, Color3.fromRGB(255, 255, 255)) end
    if cfg.CamLockFOVFillTrans ~= nil then CamLockSettings.FOVFillTransparency = cfg.CamLockFOVFillTrans end

    if cfg.SilentEnabled ~= nil then
        SilentAimSettings.Enabled = cfg.SilentEnabled
        if cfg.SilentEnabled then _applyGunHandlerHook() else _removeGunHandlerHook() end
    end
    if cfg.SilentFOVMode ~= nil then SilentAimSettings.FOVMode = cfg.SilentFOVMode end
    if cfg.SilentHitpartMode ~= nil then SilentAimSettings.HitpartMode = cfg.SilentHitpartMode end
    if cfg.SilentFOV ~= nil then SilentAimSettings.FOV = cfg.SilentFOV end
    if cfg.SilentHitChance ~= nil then SilentAimSettings.HitChance = cfg.SilentHitChance end
    if cfg.SilentPart ~= nil then SilentAimSettings.TargetPart = cfg.SilentPart end
    if cfg.SilentMaxDistance ~= nil then SilentAimSettings.MaxDistance = cfg.SilentMaxDistance end
    if cfg.SilentIgnoreKO ~= nil then SilentAimSettings.IgnoreKO = cfg.SilentIgnoreKO end
    if cfg.SilentPredict ~= nil then SilentAimSettings.PredictEnabled = cfg.SilentPredict end
    if cfg.SilentPredictAmt ~= nil then SilentAimSettings.PredictAmount = cfg.SilentPredictAmt end
    if cfg.SilentShowFOV ~= nil then SilentAimSettings.ShowFOV = cfg.SilentShowFOV end
    if cfg.SilentFOVColor then SilentAimSettings.FOVColor = gc(cfg.SilentFOVColor, Color3.fromRGB(255, 255, 255)) end
    if cfg.SilentFOVFill ~= nil then SilentAimSettings.FOVFill = cfg.SilentFOVFill end
    if cfg.SilentFOVFillColor then SilentAimSettings.FOVFillColor = gc(cfg.SilentFOVFillColor, Color3.fromRGB(255, 255, 255)) end
    if cfg.SilentFOVFillTrans ~= nil then SilentAimSettings.FOVFillTransparency = cfg.SilentFOVFillTrans end

    if cfg.RapidFire ~= nil then
        RapidFireSettings.Enabled = cfg.RapidFire
        applyRapidFire()
    end
    if cfg.RapidFireDelay ~= nil then RapidFireSettings.Delay = cfg.RapidFireDelay end

    if cfg.TriggerEnabled ~= nil then TriggerSettings.Enabled = cfg.TriggerEnabled end
    if cfg.TriggerDelay ~= nil then TriggerSettings.Delay = cfg.TriggerDelay end
    if cfg.TriggerInterval ~= nil then TriggerSettings.FireInterval = cfg.TriggerInterval end
    if cfg.TriggerBlacklist ~= nil then TriggerSettings.Blacklist = cfg.TriggerBlacklist end
    if cfg.TriggerShowHitbox ~= nil then TriggerSettings.ShowHitbox = cfg.TriggerShowHitbox end
    if cfg.TriggerHitboxSize ~= nil then TriggerSettings.HitboxSize = cfg.TriggerHitboxSize end
    if cfg.TriggerPredict ~= nil then TriggerSettings.PredictEnabled = cfg.TriggerPredict end
    if cfg.TriggerPredictAmt ~= nil then TriggerSettings.PredictAmount = cfg.TriggerPredictAmt end

    if cfg.SpeedEnabled ~= nil then SpeedSettings.Enabled = cfg.SpeedEnabled end
    if cfg.SpeedValue ~= nil then SpeedSettings.Value = cfg.SpeedValue end
    if cfg.CFrameSpeedEnabled ~= nil then CFrameSpeedSettings.Enabled = cfg.CFrameSpeedEnabled end
    if cfg.CFrameSpeedValue ~= nil then CFrameSpeedSettings.Value = cfg.CFrameSpeedValue end
    if cfg.FlyEnabled ~= nil then FlySettings.Enabled = cfg.FlyEnabled end
    if cfg.FlySpeed ~= nil then FlySettings.Speed = cfg.FlySpeed end
    if cfg.NoClip ~= nil then NoClipEnabled = cfg.NoClip end
    if cfg.TPEnabled ~= nil then _tpEnabled = cfg.TPEnabled end
    if cfg.TPOrbit ~= nil then _tpOrbit = cfg.TPOrbit end
    if cfg.TPOrbitSpeed ~= nil then _tpOrbitSpeed = cfg.TPOrbitSpeed end
    if cfg.TPOrbitRadius ~= nil then _tpOrbitRadius = cfg.TPOrbitRadius end

    if cfg.Skybox ~= nil then applySkybox(cfg.Skybox) end
    if cfg.LightingEnabled ~= nil then LightingMods = cfg.LightingEnabled end
    if cfg.LightingExposure ~= nil then LightingMod.ExposureCompensation = cfg.LightingExposure end
    if cfg.LightingBrightness ~= nil then LightingMod.Brightness = cfg.LightingBrightness end
    if cfg.LightingClockTime ~= nil then LightingMod.ClockTime = cfg.LightingClockTime end
    if cfg.LightingFogStart ~= nil then LightingMod.FogStart = cfg.LightingFogStart end
    if cfg.LightingFogEnd ~= nil then LightingMod.FogEnd = cfg.LightingFogEnd end
    if cfg.LightingAmbient then LightingMod.Ambient = gc(cfg.LightingAmbient, Color3.new(0, 0, 0)) end
    if cfg.LightingOutdoor then LightingMod.OutdoorAmbient = gc(cfg.LightingOutdoor, Color3.fromRGB(80, 120, 200)) end
    if cfg.LightingFogColor then LightingMod.FogColor = gc(cfg.LightingFogColor, Color3.fromRGB(80, 120, 200)) end

    if cfg.HitChamsEnabled ~= nil then HitChamsSettings.Enabled = cfg.HitChamsEnabled end
    if cfg.HitChamsColor then HitChamsSettings.Color = gc(cfg.HitChamsColor, Color3.fromRGB(255, 0, 0)) end
    if cfg.HitChamsMat ~= nil then HitChamsSettings.Material = cfg.HitChamsMat end
    if cfg.HitChamsTrans ~= nil then HitChamsSettings.Transparency = cfg.HitChamsTrans end
    if cfg.HitChamsDuration ~= nil then HitChamsSettings.Duration = cfg.HitChamsDuration end

    if cfg.DamageNumbersEnabled ~= nil then DamageNumbersSettings.Enabled = cfg.DamageNumbersEnabled end
    if cfg.DamageNumbersColor then DamageNumbersSettings.Color = gc(cfg.DamageNumbersColor, Color3.fromRGB(255, 255, 255)) end

    if cfg.SelfAuraEnabled ~= nil then
        SelfAuraSettings.Enabled = cfg.SelfAuraEnabled
        if cfg.SelfAuraEnabled then sa2Refresh() else sa2Clear() end
    end
    if cfg.SelfAuraColor then
        SelfAuraSettings.Color = gc(cfg.SelfAuraColor, Color3.fromRGB(133, 220, 255))
        sa2UpdateColor(SelfAuraSettings.Color)
    end
    if cfg.SelfAuraType ~= nil then
        SelfAuraSettings.Type = cfg.SelfAuraType
        if SelfAuraSettings.Enabled then sa2Refresh() end
    end

    if cfg.ChinaHatEnabled ~= nil then ChinaHatSettings.Enabled = cfg.ChinaHatEnabled end
    if cfg.ChinaHatRainbow ~= nil then ChinaHatSettings.Rainbow = cfg.ChinaHatRainbow end
    if cfg.ChinaHatColor then ChinaHatSettings.Color = gc(cfg.ChinaHatColor, Color3.fromRGB(128, 18, 255)) end
    if cfg.ChinaHatRadius ~= nil then ChinaHatSettings.Radius = cfg.ChinaHatRadius end
    if cfg.ChinaHatHeight ~= nil then ChinaHatSettings.Height = cfg.ChinaHatHeight end
    if cfg.ChinaHatTrans ~= nil then ChinaHatSettings.HatTransparency = cfg.ChinaHatTrans end
    if cfg.ChinaHatCircleTrans ~= nil then ChinaHatSettings.CircleTransparency = cfg.ChinaHatCircleTrans end

    if cfg.SCEnabled ~= nil then scEnabled = cfg.SCEnabled end
    if cfg.SCTrans ~= nil then scTrans = cfg.SCTrans end
    if cfg.SCReflect ~= nil then scReflect = cfg.SCReflect end
    if cfg.SCMat ~= nil then scMat = cfg.SCMat end
    if cfg.SCEffect ~= nil then scEffect = cfg.SCEffect end
    if cfg.SCParticles ~= nil then scParticles = cfg.SCParticles end
    if cfg.SCColor then scColor = gc(cfg.SCColor, Color3.fromRGB(155, 125, 175)) end
    if cfg.SCParticleColor then scParticleColor = gc(cfg.SCParticleColor, Color3.fromRGB(255, 255, 255)) end

    local wantTC = cfg.ToolChamsEnabled or false
    if wantTC and not ToolChamsSettings.Enabled then ToolChamsSettings.Enabled = true; tcEnable()
    elseif not wantTC and ToolChamsSettings.Enabled then ToolChamsSettings.Enabled = false; tcDisable() end
    if cfg.ToolChamsColor then ToolChamsSettings.Color = gc(cfg.ToolChamsColor, Color3.fromRGB(155, 125, 175)) end
    if cfg.ToolChamsMat ~= nil then ToolChamsSettings.Material = cfg.ToolChamsMat end
    if cfg.ToolChamsTrans ~= nil then ToolChamsSettings.Transparency = cfg.ToolChamsTrans end
    if cfg.ToolChamsReflect ~= nil then ToolChamsSettings.Reflectance = cfg.ToolChamsReflect end
    if cfg.ToolChamsParticles ~= nil then ToolChamsSettings.Particles = cfg.ToolChamsParticles end
    if cfg.ToolChamsParticleColor then ToolChamsSettings.ParticleColor = gc(cfg.ToolChamsParticleColor, Color3.fromRGB(255, 255, 255)) end

    setv(W.camLockEnabled, cEnabled)
    setv(W.camLockFOV, cFOV)
    setv(W.camLockFOVMode, cfg.CamLockFOVMode)
    setv(W.camLockSmooth, cSmooth)
    setv(W.camLockTargetPart, cPart)
    setv(W.camLockMode, cMode)
    setv(W.camLockSticky, cSticky)
    setv(W.camLockKOCheck, cKO)
    setv(W.camLockWallCheck, cfg.CamLockWallCheck)
    setv(W.camLockPrediction, cPred)
    setv(W.camLockPredictionAmt, cPredAmt)
    setv(W.camLockAutoPred, cfg.CamLockAutoPred)
    setv(W.camLockAntiGround, cfg.CamLockAntiGround)
    setv(W.camLockAirCheck, cfg.CamLockAirCheck)
    setv(W.camLockAirPart, cfg.CamLockAirPart)
    setv(W.camLockDeadzone, cfg.CamLockDeadzone)
    setv(W.camLockDeadzoneVal, cfg.CamLockDeadzoneVal)
    setv(W.camLockShake, cfg.CamLockShake)
    setv(W.camLockShakeAmt, cfg.CamLockShakeAmt)
    setv(W.camLockShowFOV, cShowFOV)
    if W.camLockFOVColor then
        if cfg.CamLockFOVColor then
            setv(W.camLockFOVColor, gc(cfg.CamLockFOVColor, Color3.fromRGB(255, 255, 255)))
        elseif cfg.AimbotFOVColor then
            setv(W.camLockFOVColor, gc(cfg.AimbotFOVColor, Color3.fromRGB(255, 255, 255)))
        end
    end
    setv(W.camLockFOVFill, cfg.CamLockFOVFill)
    if W.camLockFOVFillColor and cfg.CamLockFOVFillColor then setv(W.camLockFOVFillColor, gc(cfg.CamLockFOVFillColor, Color3.fromRGB(255, 255, 255))) end
    setv(W.camLockFOVFillTrans, cfg.CamLockFOVFillTrans)

    sb(_camBindObj, cfg.BindCamLock or cfg.BindAimbot)
    sb(_silentBindObj, cfg.BindSilent)
    sb(TriggerSettings.Keybind, cfg.BindTrigger)
    sb(_speedBindObj, cfg.BindSpeed)
    sb(_cframeSpeedBindObj, cfg.BindCFrameSpeed)
    sb(_flyBindObj,   cfg.BindFly)
    sb(_tpBindObj,    cfg.BindTP)
    sb(_menuBindObj,  cfg.BindMenu)
    sb(_hideBindObj,  cfg.BindHide)
    sb(_unloadBindObj,cfg.BindUnload)
    sb(_hitboxBindObj,cfg.BindHitbox)

    if cfg.HitboxEnabled ~= nil then HitboxSettings.Enabled = cfg.HitboxEnabled end
    if cfg.HitboxSize ~= nil then HitboxSettings.Size = cfg.HitboxSize end
    if cfg.HitboxTransparency ~= nil then HitboxSettings.Transparency = cfg.HitboxTransparency end
    if cfg.HitboxColor then HitboxSettings.Color = gc(cfg.HitboxColor, Color3.fromRGB(255, 255, 255)) end
    if cfg.HitboxSingleTarget ~= nil then HitboxSettings.SingleTargetEnabled = cfg.HitboxSingleTarget end
    if cfg.HitboxMultiTarget ~= nil then HitboxSettings.MultiTargetEnabled = cfg.HitboxMultiTarget end

    setv(W.hitboxEnabled, cfg.HitboxEnabled)
    setv(W.hitboxSize, cfg.HitboxSize)
    setv(W.hitboxTransparency, cfg.HitboxTransparency)
    if W.hitboxColor and cfg.HitboxColor then setv(W.hitboxColor, gc(cfg.HitboxColor, Color3.fromRGB(255, 255, 255))) end
    setv(W.hitboxSingleTarget, cfg.HitboxSingleTarget)
    setv(W.hitboxMultiTarget, cfg.HitboxMultiTarget)
    if cfg.HitboxMultiPlayers ~= nil then
        HitboxSettings.MultiTargetPlayers = cfg.HitboxMultiPlayers
        if W.hitboxMultiDropdown then
            local selectedList = {}
            for name, isSel in pairs(cfg.HitboxMultiPlayers) do
                if isSel then table.insert(selectedList, name) end
            end
            setv(W.hitboxMultiDropdown, selectedList)
        end
    end

    if cfg.GlobalWhitelist then for k, v in pairs(cfg.GlobalWhitelist) do _G.Lexhancements_GlobalWhitelist[k] = v end end
    if cfg.CamLockWhitelist then for k, v in pairs(cfg.CamLockWhitelist) do _G.Lexhancements_GlobalWhitelist[k] = v end end
    if cfg.SilentWhitelist then for k, v in pairs(cfg.SilentWhitelist) do _G.Lexhancements_GlobalWhitelist[k] = v end end
    if cfg.HitboxWhitelist then for k, v in pairs(cfg.HitboxWhitelist) do _G.Lexhancements_GlobalWhitelist[k] = v end end
    if cfg.ESPWhitelist then for k, v in pairs(cfg.ESPWhitelist) do _G.Lexhancements_GlobalWhitelist[k] = v end end

    setv(W.silentEnabled, cfg.SilentEnabled)
    setv(W.silentFOVMode, cfg.SilentFOVMode)
    setv(W.silentHitpartMode, cfg.SilentHitpartMode)
    setv(W.silentFOV, cfg.SilentFOV)
    setv(W.silentHitChance, cfg.SilentHitChance)
    setv(W.silentPart, cfg.SilentPart)
    setv(W.silentMaxDistance, cfg.SilentMaxDistance)
    setv(W.silentIgnoreKO, cfg.SilentIgnoreKO)
    setv(W.silentWallCheck, cfg.SilentWallCheck)
    setv(W.silentPredict, cfg.SilentPredict)
    setv(W.silentPredictAmt, cfg.SilentPredictAmt)
    setv(W.silentShowFOV, cfg.SilentShowFOV)
    if W.silentFOVColor and cfg.SilentFOVColor then setv(W.silentFOVColor, gc(cfg.SilentFOVColor, Color3.fromRGB(255, 255, 255))) end
    setv(W.silentFOVFill, cfg.SilentFOVFill)
    if W.silentFOVFillColor and cfg.SilentFOVFillColor then setv(W.silentFOVFillColor, gc(cfg.SilentFOVFillColor, Color3.fromRGB(255, 255, 255))) end
    setv(W.silentFOVFillTrans, cfg.SilentFOVFillTrans)

    setv(W.rapidFire, cfg.RapidFire)
    setv(W.rapidFireDelay, cfg.RapidFireDelay)
    setv(W.triggerEnabled, cfg.TriggerEnabled)
    setv(W.triggerDelay, cfg.TriggerDelay)
    setv(W.triggerInterval, cfg.TriggerInterval)
    setv(W.triggerBlacklist, cfg.TriggerBlacklist)
    setv(W.triggerShowHitbox, cfg.TriggerShowHitbox)
    setv(W.triggerHitboxSize, cfg.TriggerHitboxSize)
    setv(W.triggerPredict, cfg.TriggerPredict)
    setv(W.triggerPredictAmt, cfg.TriggerPredictAmt)
    if W.triggerHitboxColor and cfg.TriggerHitboxColor then setv(W.triggerHitboxColor, gc(cfg.TriggerHitboxColor, Color3.fromRGB(255, 80, 80))) end

    if cfg.ESPEnabled ~= nil then ESPSettings.Enabled = cfg.ESPEnabled; esp:setEnabled(cfg.ESPEnabled) end
    if cfg.ESPMaxDist ~= nil then ESPSettings.MaxDist = cfg.ESPMaxDist; esp:setMaxDist(cfg.ESPMaxDist) end
    if cfg.ESPBox ~= nil then ESPSettings.Box = cfg.ESPBox; esp:setBoxEnabled(cfg.ESPBox) end
    if cfg.ESPBoxColor then ESPSettings.BoxColor = gc(cfg.ESPBoxColor, Color3.fromRGB(255, 255, 255)); esp:setBoxColor(ESPSettings.BoxColor) end
    if cfg.ESP3DBox ~= nil then ESPSettings.Box3D = cfg.ESP3DBox; esp:setBox3DEnabled(cfg.ESP3DBox) end
    if cfg.ESP3DBoxColor then ESPSettings.Box3DColor = gc(cfg.ESP3DBoxColor, Color3.fromRGB(255, 255, 255)); esp:setBox3DColor(ESPSettings.Box3DColor) end
    if cfg.ESPBoxFill ~= nil then ESPSettings.BoxFill = cfg.ESPBoxFill; esp:setBoxFill(cfg.ESPBoxFill) end
    if cfg.ESPBoxFillColor then ESPSettings.BoxFillColor = gc(cfg.ESPBoxFillColor, Color3.fromRGB(255, 255, 255)); esp:setBoxFillColor(ESPSettings.BoxFillColor) end
    if cfg.ESPBoxFillTrans ~= nil then ESPSettings.BoxFillTrans = cfg.ESPBoxFillTrans; esp:setBoxFillTransparency(cfg.ESPBoxFillTrans) end
    if cfg.ESPGradientFill ~= nil then ESPSettings.GradientFill = cfg.ESPGradientFill; esp:setGradientFill(cfg.ESPGradientFill) end
    if cfg.ESPGradientTopColor then ESPSettings.GradientTopColor = gc(cfg.ESPGradientTopColor, Color3.fromRGB(65, 105, 205)); esp:setGradientTopColor(ESPSettings.GradientTopColor) end
    if cfg.ESPGradientBottomColor then ESPSettings.GradientBottomColor = gc(cfg.ESPGradientBottomColor, Color3.fromRGB(15, 20, 35)); esp:setGradientBottomColor(ESPSettings.GradientBottomColor) end
    if cfg.ESPHealthBar ~= nil then ESPSettings.HealthBar = cfg.ESPHealthBar; esp:setHealthBarEnabled(cfg.ESPHealthBar) end
    if cfg.ESPHealthBarSide ~= nil then ESPSettings.HealthBarSide = cfg.ESPHealthBarSide; esp:setHealthBarSide(cfg.ESPHealthBarSide) end
    if cfg.ESPHpFull then ESPSettings.HpColorFull = gc(cfg.ESPHpFull, Color3.fromRGB(0, 255, 0)); esp:setHpColorFull(ESPSettings.HpColorFull) end
    if cfg.ESPHpMid then ESPSettings.HpColorMid = gc(cfg.ESPHpMid, Color3.fromRGB(255, 170, 0)); esp:setHpColorMid(ESPSettings.HpColorMid) end
    if cfg.ESPHpEmpty then ESPSettings.HpColorEmpty = gc(cfg.ESPHpEmpty, Color3.fromRGB(255, 0, 0)); esp:setHpColorEmpty(ESPSettings.HpColorEmpty) end
    if cfg.ESPArmorBar ~= nil then ESPSettings.ArmorBar = cfg.ESPArmorBar; esp:setArmorBarEnabled(cfg.ESPArmorBar) end
    if cfg.ESPArmorFull then ESPSettings.ArmorColorFull = gc(cfg.ESPArmorFull, Color3.fromRGB(80, 160, 255)); esp:setArmorColorFull(ESPSettings.ArmorColorFull) end
    if cfg.ESPArmorEmpty then ESPSettings.ArmorColorEmpty = gc(cfg.ESPArmorEmpty, Color3.fromRGB(30, 60, 120)); esp:setArmorColorEmpty(ESPSettings.ArmorColorEmpty) end
    if cfg.ESPNames ~= nil then ESPSettings.Names = cfg.ESPNames; esp:setNamesEnabled(cfg.ESPNames) end
    if cfg.ESPNameColor then ESPSettings.NameColor = gc(cfg.ESPNameColor, Color3.fromRGB(255, 255, 255)); esp:setNamesColor(ESPSettings.NameColor) end
    if cfg.ESPDistance ~= nil then ESPSettings.Distance = cfg.ESPDistance; esp:setDistanceEnabled(cfg.ESPDistance) end
    if cfg.ESPDistanceColor then ESPSettings.DistanceColor = gc(cfg.ESPDistanceColor, Color3.fromRGB(200, 200, 200)); esp:setDistanceColor(ESPSettings.DistanceColor) end
    if cfg.ESPTool ~= nil or cfg.ESPWeapon ~= nil then
        ESPSettings.Tool = (cfg.ESPTool ~= nil and cfg.ESPTool) or cfg.ESPWeapon
        esp:setToolEnabled(ESPSettings.Tool)
    end
    if cfg.ESPToolColor or cfg.ESPWeaponColor then
        ESPSettings.ToolColor = gc(cfg.ESPToolColor or cfg.ESPWeaponColor, Color3.fromRGB(255, 255, 255))
        esp:setToolColor(ESPSettings.ToolColor)
    end
    if cfg.ESPTracers ~= nil then ESPSettings.Tracers = cfg.ESPTracers; esp:setTracersEnabled(cfg.ESPTracers) end
    if cfg.ESPTracerOrigin ~= nil then ESPSettings.TracerOrigin = cfg.ESPTracerOrigin; esp:setTracerOrigin(cfg.ESPTracerOrigin) end
    if cfg.ESPTracerColor then ESPSettings.TracerColor = gc(cfg.ESPTracerColor, Color3.fromRGB(255, 255, 255)); esp:setTracerColor(ESPSettings.TracerColor) end
    if cfg.ESPSkeleton ~= nil then ESPSettings.Skeleton = cfg.ESPSkeleton; esp:setSkeletonEnabled(cfg.ESPSkeleton) end
    if cfg.ESPSkeletonColor then ESPSettings.SkeletonColor = gc(cfg.ESPSkeletonColor, Color3.fromRGB(255, 255, 255)); esp:setSkeletonColor(ESPSettings.SkeletonColor) end

    setv(W.espEnabled, cfg.ESPEnabled)
    setv(W.espMaxDist, cfg.ESPMaxDist)
    setv(W.espBox, cfg.ESPBox)
    if W.espBoxColor and cfg.ESPBoxColor then setv(W.espBoxColor, gc(cfg.ESPBoxColor, Color3.fromRGB(255, 255, 255))) end
    setv(W.esp3DBox, cfg.ESP3DBox)
    if W.esp3DBoxColor and cfg.ESP3DBoxColor then setv(W.esp3DBoxColor, gc(cfg.ESP3DBoxColor, Color3.fromRGB(255, 255, 255))) end
    setv(W.espBoxFill, cfg.ESPBoxFill)
    if W.espBoxFillColor and cfg.ESPBoxFillColor then setv(W.espBoxFillColor, gc(cfg.ESPBoxFillColor, Color3.fromRGB(255, 255, 255))) end
    setv(W.espBoxFillTrans, cfg.ESPBoxFillTrans)
    setv(W.espGradientFill, cfg.ESPGradientFill)
    if W.espGradientTopColor and cfg.ESPGradientTopColor then setv(W.espGradientTopColor, gc(cfg.ESPGradientTopColor, Color3.fromRGB(65, 105, 205))) end
    if W.espGradientBottomColor and cfg.ESPGradientBottomColor then setv(W.espGradientBottomColor, gc(cfg.ESPGradientBottomColor, Color3.fromRGB(15, 20, 35))) end
    setv(W.espHealthBar, cfg.ESPHealthBar)
    setv(W.espHealthBarSide, cfg.ESPHealthBarSide)
    if W.espHpFull and cfg.ESPHpFull then setv(W.espHpFull, gc(cfg.ESPHpFull, Color3.fromRGB(0, 255, 0))) end
    if W.espHpMid and cfg.ESPHpMid then setv(W.espHpMid, gc(cfg.ESPHpMid, Color3.fromRGB(255, 170, 0))) end
    if W.espHpEmpty and cfg.ESPHpEmpty then setv(W.espHpEmpty, gc(cfg.ESPHpEmpty, Color3.fromRGB(255, 0, 0))) end
    setv(W.espArmorBar, cfg.ESPArmorBar)
    if W.espArmorFull and cfg.ESPArmorFull then setv(W.espArmorFull, gc(cfg.ESPArmorFull, Color3.fromRGB(80, 160, 255))) end
    if W.espArmorEmpty and cfg.ESPArmorEmpty then setv(W.espArmorEmpty, gc(cfg.ESPArmorEmpty, Color3.fromRGB(30, 60, 120))) end
    setv(W.espNames, cfg.ESPNames)
    if W.espNameColor and cfg.ESPNameColor then setv(W.espNameColor, gc(cfg.ESPNameColor, Color3.fromRGB(255, 255, 255))) end
    setv(W.espDistance, cfg.ESPDistance)
    if W.espDistanceColor and cfg.ESPDistanceColor then setv(W.espDistanceColor, gc(cfg.ESPDistanceColor, Color3.fromRGB(200, 200, 200))) end
    setv(W.espTool, cfg.ESPTool or cfg.ESPWeapon)
    if W.espToolColor and (cfg.ESPToolColor or cfg.ESPWeaponColor) then setv(W.espToolColor, gc(cfg.ESPToolColor or cfg.ESPWeaponColor, Color3.fromRGB(255, 255, 255))) end
    setv(W.espTracers, cfg.ESPTracers)
    setv(W.espTracerOrigin, cfg.ESPTracerOrigin)
    if W.espTracerColor and cfg.ESPTracerColor then setv(W.espTracerColor, gc(cfg.ESPTracerColor, Color3.fromRGB(255, 255, 255))) end
    setv(W.espSkeleton, cfg.ESPSkeleton)
    if W.espSkeletonColor and cfg.ESPSkeletonColor then setv(W.espSkeletonColor, gc(cfg.ESPSkeletonColor, Color3.fromRGB(255, 255, 255))) end

    if cfg.SpeedEnabled ~= nil then SpeedSettings.Enabled = cfg.SpeedEnabled end
    if cfg.SpeedValue ~= nil then SpeedSettings.Value = cfg.SpeedValue end
    if cfg.CFrameSpeedEnabled ~= nil then CFrameSpeedSettings.Enabled = cfg.CFrameSpeedEnabled end
    if cfg.CFrameSpeedValue ~= nil then CFrameSpeedSettings.Value = cfg.CFrameSpeedValue end
    if cfg.FlyEnabled ~= nil then FlySettings.Enabled = cfg.FlyEnabled end
    if cfg.FlySpeed ~= nil then FlySettings.Speed = cfg.FlySpeed end
    if cfg.NoClip ~= nil then NoClipEnabled = cfg.NoClip end

    setv(W.speedEnabled, cfg.SpeedEnabled)
    setv(W.speedValue, cfg.SpeedValue)
    setv(W.cframeSpeedEnabled, cfg.CFrameSpeedEnabled)
    setv(W.cframeSpeedValue, cfg.CFrameSpeedValue)
    setv(W.flyEnabled, cfg.FlyEnabled)
    setv(W.flySpeed, cfg.FlySpeed)
    setv(W.noClip, cfg.NoClip)

    if cfg.TPMode ~= nil then _tpMode = cfg.TPMode end
    if cfg.TPEnabled ~= nil then _tpEnabled = cfg.TPEnabled end
    if cfg.TPOrbit ~= nil then _tpOrbit = cfg.TPOrbit end
    if cfg.TPOrbitSpeed ~= nil then _tpOrbitSpeed = cfg.TPOrbitSpeed end
    if cfg.TPOrbitRadius ~= nil then _tpOrbitRadius = cfg.TPOrbitRadius end
    setv(W.tpEnabled, cfg.TPEnabled)
    setv(W.tpMode, cfg.TPMode)
    setv(W.tpOrbit, cfg.TPOrbit)
    setv(W.tpOrbitSpeed, cfg.TPOrbitSpeed)
    setv(W.tpOrbitRadius, cfg.TPOrbitRadius)

    if cfg.Skybox then
        selectedSkybox = cfg.Skybox
        setv(W.skyboxDropdown, cfg.Skybox)
        pcall(function() applySkybox(cfg.Skybox) end)
    end

    if cfg.LightingEnabled ~= nil then LightingMods = cfg.LightingEnabled end
    if cfg.LightingBrightness ~= nil then LightingMod.Brightness = cfg.LightingBrightness end
    if cfg.LightingExposure ~= nil then LightingMod.ExposureCompensation = cfg.LightingExposure end
    if cfg.LightingClockTime ~= nil then LightingMod.ClockTime = cfg.LightingClockTime end
    if cfg.LightingFogStart ~= nil then LightingMod.FogStart = cfg.LightingFogStart end
    if cfg.LightingFogEnd ~= nil then LightingMod.FogEnd = cfg.LightingFogEnd end
    if cfg.LightingAmbient then LightingMod.Ambient = gc(cfg.LightingAmbient, OrigLighting.Ambient) end
    if cfg.LightingOutdoor then LightingMod.OutdoorAmbient = gc(cfg.LightingOutdoor, OrigLighting.OutdoorAmbient) end
    if cfg.LightingFogColor then LightingMod.FogColor = gc(cfg.LightingFogColor, OrigLighting.FogColor) end

    setv(W.lightingEnabled, cfg.LightingEnabled)
    setv(W.lightingBrightness, cfg.LightingBrightness)
    setv(W.lightingExposure, cfg.LightingExposure)
    setv(W.lightingClockTime, cfg.LightingClockTime)
    setv(W.lightingFogStart, cfg.LightingFogStart)
    setv(W.lightingFogEnd, cfg.LightingFogEnd)
    if W.lightingAmbient and cfg.LightingAmbient then setv(W.lightingAmbient, gc(cfg.LightingAmbient, OrigLighting.Ambient)) end
    if W.lightingOutdoor and cfg.LightingOutdoor then setv(W.lightingOutdoor, gc(cfg.LightingOutdoor, OrigLighting.OutdoorAmbient)) end
    if W.lightingFogColor and cfg.LightingFogColor then setv(W.lightingFogColor, gc(cfg.LightingFogColor, OrigLighting.FogColor)) end

    local wantSC = cfg.SCEnabled or false
    if wantSC and not scEnabled then scEnabled = true; scEnable()
    elseif not wantSC and scEnabled then scEnabled = false; scDisable() end
    if cfg.SCTrans ~= nil then scTrans = cfg.SCTrans end
    if cfg.SCReflect ~= nil then scReflect = cfg.SCReflect end
    if cfg.SCMat ~= nil then scMat = cfg.SCMat end
    if cfg.SCEffect ~= nil then scEffect = cfg.SCEffect end
    if cfg.SCParticles ~= nil then scParticles = cfg.SCParticles end
    if cfg.SCColor then scColor = gc(cfg.SCColor, Color3.fromRGB(155, 125, 175)) end
    if cfg.SCParticleColor then scParticleColor = gc(cfg.SCParticleColor, Color3.fromRGB(255, 255, 255)) end

    setv(W.scEnabled, wantSC)
    if W.scColor and cfg.SCColor then setv(W.scColor, gc(cfg.SCColor, Color3.fromRGB(155, 125, 175))) end
    setv(W.scTrans, cfg.SCTrans)
    setv(W.scReflect, cfg.SCReflect)
    setv(W.scMat, cfg.SCMat)
    setv(W.scEffect, cfg.SCEffect)
    setv(W.scParticles, cfg.SCParticles)
    if W.scParticleColor and cfg.SCParticleColor then setv(W.scParticleColor, gc(cfg.SCParticleColor, Color3.fromRGB(255, 255, 255))) end

    if cfg.ToolChamsEnabled ~= nil then ToolChamsSettings.Enabled = cfg.ToolChamsEnabled end
    if cfg.ToolChamsColor then ToolChamsSettings.Color = gc(cfg.ToolChamsColor, Color3.fromRGB(124, 58, 237)) end
    if cfg.ToolChamsMat ~= nil then ToolChamsSettings.Material = cfg.ToolChamsMat end
    if cfg.ToolChamsTrans ~= nil then ToolChamsSettings.Transparency = cfg.ToolChamsTrans end
    if cfg.ToolChamsReflect ~= nil then ToolChamsSettings.Reflectance = cfg.ToolChamsReflect end
    if cfg.ToolChamsParticles ~= nil then ToolChamsSettings.Particles = cfg.ToolChamsParticles end
    if cfg.ToolChamsParticleColor then ToolChamsSettings.ParticleColor = gc(cfg.ToolChamsParticleColor, Color3.fromRGB(255, 255, 255)) end

    setv(W.toolChams, cfg.ToolChamsEnabled)
    if W.toolChamsColor and cfg.ToolChamsColor then setv(W.toolChamsColor, gc(cfg.ToolChamsColor, Color3.fromRGB(124, 58, 237))) end
    setv(W.toolChamsMat, cfg.ToolChamsMat)
    setv(W.toolChamsTrans, cfg.ToolChamsTrans)
    setv(W.toolChamsReflect, cfg.ToolChamsReflect)
    setv(W.toolChamsParticles, cfg.ToolChamsParticles)
    if W.toolChamsParticleColor and cfg.ToolChamsParticleColor then setv(W.toolChamsParticleColor, gc(cfg.ToolChamsParticleColor, Color3.fromRGB(255, 255, 255))) end

    if cfg.HitChamsEnabled ~= nil then HitChamsSettings.Enabled = cfg.HitChamsEnabled end
    if cfg.HitChamsColor then HitChamsSettings.Color = gc(cfg.HitChamsColor, Color3.fromRGB(255, 0, 0)) end
    if cfg.HitChamsMat ~= nil then HitChamsSettings.Material = cfg.HitChamsMat end
    if cfg.HitChamsTrans ~= nil then HitChamsSettings.Transparency = cfg.HitChamsTrans end
    if cfg.HitChamsDuration ~= nil then HitChamsSettings.Duration = cfg.HitChamsDuration end

    setv(W.hitChams, cfg.HitChamsEnabled)
    if W.hitChamsColor and cfg.HitChamsColor then setv(W.hitChamsColor, gc(cfg.HitChamsColor, Color3.fromRGB(255, 0, 0))) end
    setv(W.hitChamsMat, cfg.HitChamsMat)
    setv(W.hitChamsTrans, cfg.HitChamsTrans)
    setv(W.hitChamsDuration, cfg.HitChamsDuration)

    if cfg.DamageNumbersEnabled ~= nil then DamageNumbersSettings.Enabled = cfg.DamageNumbersEnabled end
    if cfg.DamageNumbersColor then DamageNumbersSettings.Color = gc(cfg.DamageNumbersColor, Color3.fromRGB(255, 255, 255)) end

    setv(W.damageNumbers, cfg.DamageNumbersEnabled)
    if W.damageNumbersColor and cfg.DamageNumbersColor then setv(W.damageNumbersColor, gc(cfg.DamageNumbersColor, Color3.fromRGB(255, 255, 255))) end

    if cfg.SelfAuraEnabled ~= nil then SelfAuraSettings.Enabled = cfg.SelfAuraEnabled end
    if cfg.SelfAuraColor then SelfAuraSettings.Color = gc(cfg.SelfAuraColor, Color3.fromRGB(133, 220, 255)) end
    if cfg.SelfAuraType ~= nil then SelfAuraSettings.Type = cfg.SelfAuraType end

    setv(W.selfAura, cfg.SelfAuraEnabled)
    if W.selfAuraColor and cfg.SelfAuraColor then setv(W.selfAuraColor, gc(cfg.SelfAuraColor, Color3.fromRGB(133, 220, 255))) end
    setv(W.selfAuraType, cfg.SelfAuraType)

    if cfg.ChinaHatEnabled ~= nil then ChinaHatSettings.Enabled = cfg.ChinaHatEnabled end
    if cfg.ChinaHatRainbow ~= nil then ChinaHatSettings.Rainbow = cfg.ChinaHatRainbow end
    if cfg.ChinaHatColor then ChinaHatSettings.Color = gc(cfg.ChinaHatColor, Color3.fromRGB(128, 18, 255)) end
    if cfg.ChinaHatRadius ~= nil then ChinaHatSettings.Radius = cfg.ChinaHatRadius end
    if cfg.ChinaHatHeight ~= nil then ChinaHatSettings.Height = cfg.ChinaHatHeight end
    if cfg.ChinaHatTrans ~= nil then ChinaHatSettings.HatTransparency = cfg.ChinaHatTrans end
    if cfg.ChinaHatCircleTrans ~= nil then ChinaHatSettings.CircleTransparency = cfg.ChinaHatCircleTrans end

    setv(W.chinaHat, cfg.ChinaHatEnabled)
    setv(W.chinaHatRainbow, cfg.ChinaHatRainbow)
    if W.chinaHatColor and cfg.ChinaHatColor then setv(W.chinaHatColor, gc(cfg.ChinaHatColor, Color3.fromRGB(128, 18, 255))) end
    setv(W.chinaHatRadius, cfg.ChinaHatRadius)
    setv(W.chinaHatHeight, cfg.ChinaHatHeight)
    setv(W.chinaHatTrans, cfg.ChinaHatTrans)
    setv(W.chinaHatCircleTrans, cfg.ChinaHatCircleTrans)

    pcall(function()
        if Window and Window.UpdateESPPreview then
            Window:UpdateESPPreview(ESPSettings)
        end
    end)
end

Window._ConfigCollector = collectConfig
Window._ConfigApplier   = applyConfig
end

return Window

--[[
    ┌──────────────────────────────────────────────────────────┐
    │  LEXHANCEMENTS • EXCLUSIVE BUILD                         │
    │  This build is exclusive for Lexhancements.              │
    │  Copies are not accepted.                                │
    │                                                          │
    │  Created by KraviX Team: Scarlet • Sixs • Cyp            │
    └──────────────────────────────────────────────────────────┘
--]]
