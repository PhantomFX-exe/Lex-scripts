-- Lex Script V10: Nome do ESP ampliado e cor configurável
-- Controles Livres por Digitação, Fly Direcional Perfeito, ESP com Seletor, Rapid Fire e Hitbox

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

local LexScript = {
    Settings = {
        Fly = false,
        Speed = false,
        ESP = false,
        Aimbot = false,
        SilentAim = {
            Enabled = false,
            FOVMode = "Mouse",
            FOV = 150,
            ShowFOV = false,
            FOVColor = Color3.fromRGB(255, 255, 255),
            FOVFill = false,
            FOVFillColor = Color3.fromRGB(255, 255, 255),
            FOVFillTransparency = 0.1,
            HitpartMode = "Single Part",
            TargetPart = "Head",
            MaxDistance = 500,
            HitChance = 100,
            PredictEnabled = false,
            PredictAmount = 0.15,
            IgnoreKO = true,
            WallCheck = true,
        },
        RapidFire = {
            Enabled = false,
            Delay = 0.08
        },
        Hitbox = {
            Enabled = false,
            Size = 15,
            Transparency = 0.5,
            Color = Color3.fromRGB(255, 255, 255)
        },
        CFrameSpeed = false,
        Jump = false,
        WalkSpeedValue = 100,
        JumpPowerValue = 100,
        FlySpeedValue = 50,
        CFrameSpeedValue = 150,
        
        TpEnabled = false,
        TpMode = "Hold", 
        TpPosition = "Orbit", 
        TpOrbitSpeed = 3,
        TpOrbitRadius = 8,
        TpHolding = false,

        -- Configuração do Anti Stomp
        AntiStompEnabled = false
    }
}

-- Estados de atalhos e binds independentes para todas as funções
local targetUserId = nil   
local _tpOrbitAngle = 0
local aimbotKey = Enum.KeyCode.RightShift
local silentKey = Enum.KeyCode.RightAlt
local speedKey = Enum.KeyCode.V
local cframeKey = Enum.KeyCode.B
local jumpKey = Enum.KeyCode.J
local flyKey = Enum.KeyCode.X
local teleportKey = Enum.KeyCode.T
local uiToggleKey = Enum.KeyCode.RightControl

-- Tabelas para gerenciar quais jogadores estão selecionados no ESP e na Hitbox
local SelectedHitboxPlayers = {}
local SelectedESPPlayers = {}
local SelectedTeleportTarget = nil
local SelectedPlayerListTarget = nil
local SpectatingPlayer = nil

local Camera = game.Workspace.CurrentCamera
local LocalPlayer = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StatsService = game:GetService("Stats")

-- Variáveis de manipulação interna do Silent Aim
local _silentTargetPart = nil
local _silentTargetPos  = nil
local _silentHookActive = false
local GunHandler = nil
local OriginalGetAim = nil
local OriginalGetCanShoot = nil

local CLOSEST_PARTS_LIST = {
    "Head", "HumanoidRootPart", "UpperTorso", "LowerTorso",
    "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm",
    "LeftFoot", "RightFoot", "LeftLowerLeg", "RightLowerLeg", "LeftUpperLeg", "RightUpperLeg"
}

-- Elementos Visuais do FOV por Drawing
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
SilentCircleFill.Transparency = LexScript.Settings.SilentAim.FOVFillTransparency
SilentCircleFill.Color        = LexScript.Settings.SilentAim.FOVFillColor
SilentCircleFill.Visible      = false
SilentCircleFill.ZIndex       = 1

-- Variáveis do Rapid Fire portadas do Script 1
local State_RF = {
    rapidFireHooks = {},
    rapidFireChildConns = {},
    isHolding = false
}
local Refs_RF = {
    rapidFireLoopRunning = false,
    rapidFireLoopThread = nil
}

-- Tabelas de gerenciamento de Hitbox do Script 1
local HitboxOriginal = {}
local HitboxVisuals = {}

-- CONFIGURAÇÃO E INSTANCIAÇÃO DA JANELA RAYFIELD GEN2
local Window = Rayfield:CreateWindow({
    Name = "Pandora.cc",
    Subtitle = "made by Lex",
    Icon = 100604009889706,
    Theme = "default",
    ConfigurationSaving = { Enabled = false }
})

-- Criação das Abas Oficiais na Gen2
local CombatTab = Window:CreateTab({ Name = "Combate", Icon = "rbxassetid://100604009889706" })
local MovementTab = Window:CreateTab({ Name = "Movimento", Icon = "rbxassetid://100604009889706" })
local TeleportTab = Window:CreateTab({ Name = "Teleporte", Icon = "rbxassetid://100604009889706" })
local HitboxTab = Window:CreateTab({ Name = "Hitbox", Icon = "rbxassetid://100604009889706" })
local VisualsTab = Window:CreateTab({ Name = "Visuais", Icon = "rbxassetid://100604009889706" })
local PlayerListTab = Window:CreateTab({ Name = "Player List", Icon = "rbxassetid://100604009889706" })
local ConfigTab = Window:CreateTab({ Name = "Config", Icon = "rbxassetid://100604009889706" })
local MiscTab = Window:CreateTab({ Name = "Misc", Icon = "rbxassetid://100604009889706" })
local DesyncTab = Window:CreateTab({ Name = "Desync", Icon = "rbxassetid://100604009889706" })
local UITab = Window:CreateTab({ Name = "UI", Icon = "rbxassetid://100604009889706" })

-- ================= TAB UI / PERSONALIZACAO =================
UITab:CreateKeybind({
    Name = "Tecla para abrir/fechar o menu",
    CurrentValue = uiToggleKey,
    Callback = function(key)
        uiToggleKey = key
    end
})

UITab:CreateDropdown({
    Name = "Tema da interface",
    Options = {"default", "cobalt", "ember", "amethyst", "frost", "rose"},
    CurrentOption = {"default"},
    Callback = function(selected)
        local themeName = typeof(selected) == "table" and selected[1] or selected
        if themeName then
            pcall(function() Window:ChangeTheme(themeName) end)
        end
    end
})

UITab:CreateColorPicker({
    Name = "Cor personalizada da interface",
    Color = Color3.fromRGB(124, 58, 237),
    Callback = function(color)
        pcall(function()
            Window:ChangeTheme({
                AccentColor = color,
                AccentStroke = color,
                TabBackground = ColorSequence.new(color, color:Lerp(Color3.new(0, 0, 0), 0.25)),
                SliderProgress = ColorSequence.new(color, color:Lerp(Color3.new(1, 1, 1), 0.15)),
                DropdownHighlight = color,
                FieldGlow = color,
            })
        end)
    end
})

UITab:CreateButton({
    Name = "Restaurar tema padrão",
    Callback = function()
        pcall(function() Window:ChangeTheme("default") end)
    end
})

-- ================= TAB CHARACTER / DANCE SYSTEM =================
local DanceTab = Window:CreateTab({ Name = "Character", Icon = "rbxassetid://100604009889706" })

local DanceIds = {
    ["Billy Bounce"] = "rbxassetid://136095999219650",
    ["Zero Two Dance"] = "rbxassetid://116714406076290",
    ["Jabba Switchway"] = "rbxassetid://82682811348660",
    ["Beat Dance"] = "rbxassetid://133394554631338",
    ["Lay"] = "rbxassetid://2695918332",
    ["Floss"] = "rbxassetid://10714340543",
    ["Spin"] = "rbxassetid://2516930867",
    ["Sit"] = "rbxassetid://807343012",
    ["Baby Queen"] = "rbxassetid://15609995579",
    ["Godlike"] = "rbxassetid://14352343065",
    ["Victory Dance"] = "rbxassetid://16553163212",
    ["Elton John"] = "rbxassetid://15505456446",
    ["Sturdy Dance"] = "rbxassetid://11309255148",
    ["Ice Spice"] = "rbxassetid://17746180844",
    ["Old Town Road"] = "rbxassetid://10714391240",
    ["V Pose"] = "rbxassetid://10214319518",
    ["Ballerina"] = "rbxassetid://3333432454",
    ["Robot"] = "rbxassetid://4555808220",
    ["Back"] = "rbxassetid://4049037604",
    ["Zombie"] = "rbxassetid://4555782893",
    ["Hip-Hop"] = "rbxassetid://10214311282",
    ["Happy"] = "rbxassetid://10714010337",
    ["Body"] = "rbxassetid://10713981723",
    ["Spook"] = "rbxassetid://10714372526",
    ["Robot 2"] = "rbxassetid://10714392151",
    ["Hype"] = "rbxassetid://10714369624",
    ["Sleep"] = "rbxassetid://4686925579",
    ["Sweet"] = "rbxassetid://120370790028350",
    ["Robot 3"] = "rbxassetid://18443245017",
    ["Pick"] = "rbxassetid://128386160365167",
    ["Love"] = "rbxassetid://18443237526",
    ["Laugh"] = "rbxassetid://3337966527",
    ["Sad"] = "rbxassetid://4841407203",
    ["Sarra"] = "rbxassetid://119734573196374",
    ["Invisible"] = "rbxassetid://126995783634131",
    ["Evil"] = "rbxassetid://70692992882447",
    ["Lego"] = "rbxassetid://135373056067761",
    ["Broken"] = "rbxassetid://112119483472206",
    ["Monkey"] = "rbxassetid://3333499508",
    ["Fancy Feet"] = "rbxassetid://3333432454",
    ["Cry"] = "rbxassetid://4940563117",
    ["Bored"] = "rbxassetid://5230599789"
}

local CurrentDanceTrack = nil
local CurrentDanceName = nil
local DanceSpeed = 1
local SelectedDance = nil

local function stopDance()
    if CurrentDanceTrack then
        pcall(function()
            CurrentDanceTrack:Stop()
            CurrentDanceTrack:Destroy()
        end)
        CurrentDanceTrack = nil
    end
    CurrentDanceName = nil
end

local function playDance(name)
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local animationId = DanceIds[name]
    if not animationId then return end

    stopDance()
    local animation = Instance.new("Animation")
    animation.AnimationId = animationId
    local track = humanoid:LoadAnimation(animation)
    track.Looped = true
    track:AdjustSpeed(DanceSpeed)
    track:Play()

    CurrentDanceTrack = track
    CurrentDanceName = name
end

LocalPlayer.CharacterAdded:Connect(function()
    local danceToResume = CurrentDanceName
    if danceToResume then
        task.wait(0.2)
        playDance(danceToResume)
    end
end)

local danceNames = {}
for danceName in pairs(DanceIds) do
    table.insert(danceNames, danceName)
end
table.sort(danceNames)

DanceTab:CreateDropdown({
    Name = "Select Dance",
    Options = danceNames,
    CurrentOption = {danceNames[1]},
    Callback = function(value)
        SelectedDance = type(value) == "table" and value[1] or value
    end
})

DanceTab:CreateButton({
    Name = "Play Dance",
    Callback = function()
        if SelectedDance then
            playDance(SelectedDance)
        end
    end
})

DanceTab:CreateButton({
    Name = "Stop Dance",
    Callback = stopDance
})

DanceTab:CreateSlider({
    Name = "Dance Speed",
    Min = 0.1,
    Max = 5,
    Increment = 0.1,
    CurrentValue = DanceSpeed,
    Callback = function(value)
        DanceSpeed = value
        if CurrentDanceTrack then
            CurrentDanceTrack:AdjustSpeed(DanceSpeed)
        end
    end
})

-- ================= CHARACTER COSMETICS =================
local headlessEnabled = false
local korbloxEnabled = false
local headlessConnection = nil
local korbloxConnection = nil

local function setHeadless(enabled)
    local character = LocalPlayer.Character
    local head = character and character:FindFirstChild("Head")
    if not head then return end
    head.Transparency = enabled and 1 or 0
    local face = head:FindFirstChild("face")
    if face then face.Transparency = enabled and 1 or 0 end
end

local function setKorblox(enabled)
    local character = LocalPlayer.Character
    if not character then return end
    local rightUpperLeg = character:FindFirstChild("RightUpperLeg")
    local rightLowerLeg = character:FindFirstChild("RightLowerLeg")
    local rightFoot = character:FindFirstChild("RightFoot")
    if not rightUpperLeg or not rightLowerLeg or not rightFoot then return end

    if enabled then
        rightUpperLeg.TextureID = "rbxassetid://902843398"
        rightUpperLeg.MeshId = "rbxassetid://9598310133"
        rightLowerLeg.Transparency = 1
        rightFoot.Transparency = 1
    else
        rightUpperLeg.TextureID = ""
        rightUpperLeg.MeshId = "rbxassetid://532220018"
        rightLowerLeg.Transparency = 0
        rightFoot.Transparency = 0
    end
end

DanceTab:CreateToggle({
    Name = "Headless",
    CurrentValue = false,
    Callback = function(value)
        headlessEnabled = value
        setHeadless(value)
        if headlessConnection then headlessConnection:Disconnect(); headlessConnection = nil end
        if value then
            headlessConnection = LocalPlayer.CharacterAdded:Connect(function()
                task.wait(0.5)
                setHeadless(true)
            end)
        end
    end
})

DanceTab:CreateToggle({
    Name = "Korblox",
    CurrentValue = false,
    Callback = function(value)
        korbloxEnabled = value
        setKorblox(value)
        if korbloxConnection then korbloxConnection:Disconnect(); korbloxConnection = nil end
        if value then
            korbloxConnection = LocalPlayer.CharacterAdded:Connect(function()
                task.wait(0.5)
                setKorblox(true)
            end)
        end
    end
})

-- ================= MISC / CHAT LOGGER =================
local TextChatService = game:GetService("TextChatService")
local function setChatLoggerEnabled(enabled)
    local chatWindow = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
    if chatWindow then
        chatWindow.Enabled = enabled
    end
end

MiscTab:CreateToggle({
    Name = "Enable Chat Logger",
    CurrentValue = true,
    Callback = function(value)
        setChatLoggerEnabled(value)
    end
})
setChatLoggerEnabled(true)

-- ================= TAB DESYNC (SISTEMAS DO SCRIPT 1) =================
local DesyncSettings = {
    Enabled = false,
    StayInVoid = false,
    Visualize = false,
    Transparency = 0,
    Spam = false,
    InVoid = 0.4,
    OnGround = 0.133,
    Method = "Custom",
    VelocityEnabled = false,
    VelocityType = "low",
    VelocityRotate = false
}

local desyncKey = Enum.KeyCode.Unknown
local desyncInVoid = false
local desyncClone

local function createDesyncPart(name, size, parent)
    local part = Instance.new("Part")
    part.Name = name
    part.Size = size
    part.CanCollide = false
    part.Parent = parent
    return part
end

local function createDesyncWeld(p0, p1, c0)
    local weld = Instance.new("Weld")
    weld.Part0 = p0
    weld.Part1 = p1
    weld.C0 = c0
    weld.Parent = p0
end

local function createDesyncRig()
    local model = Instance.new("Model")
    model.Name = "DesyncVisual"
    local root = createDesyncPart("HumanoidRootPart", Vector3.new(2, 2, 1), model)
    root.Transparency = 1
    local humanoid = Instance.new("Humanoid")
    humanoid.RigType = Enum.HumanoidRigType.R6
    humanoid.Parent = model
    local torso = createDesyncPart("Torso", Vector3.new(2, 2, 1), model)
    local parts = {
        Head = {2, 1, 1, 0, 1.5, 0},
        ["Left Arm"] = {1, 2, 1, -1.5, 0, 0},
        ["Right Arm"] = {1, 2, 1, 1.5, 0, 0},
        ["Left Leg"] = {1, 2, 1, -0.5, -2, 0},
        ["Right Leg"] = {1, 2, 1, 0.5, -2, 0}
    }
    for name, data in pairs(parts) do
        local part = createDesyncPart(name, Vector3.new(data[1], data[2], data[3]), model)
        createDesyncWeld(torso, part, CFrame.new(data[4], data[5], data[6]))
    end
    createDesyncWeld(root, torso, CFrame.new())
    model.PrimaryPart = root
    model.Parent = workspace
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            part.Material = Enum.Material.Neon
            part.Color = Color3.fromRGB(80, 120, 200)
        end
    end
    return model
end

local function setDesyncRigTransparency(transparency)
    if not desyncClone then return end
    for _, part in ipairs(desyncClone:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = transparency
        end
    end
end

pcall(function() desyncClone = createDesyncRig() end)
_G.Desync = _G.Desync or {
    MinX = 10, MaxX = 10, MinY = 10, MaxY = 10, MinZ = 10, MaxZ = 10,
    MinPitch = 0, MaxPitch = 360, MinYaw = 0, MaxYaw = 360
}

RunService.Heartbeat:Connect(function()
    if not DesyncSettings.Enabled then
        setDesyncRigTransparency(1)
        return
    end
    pcall(function()
        local character = LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local spoofed
        if DesyncSettings.StayInVoid then
            spoofed = CFrame.new(
                math.random(-450000000, -100000000),
                math.random(100000000, 450000000),
                math.random(-450000000, -100000000)
            )
        elseif DesyncSettings.Method == "Custom" then
            local cfg = _G.Desync
            local pitch = math.rad(math.random(cfg.MinPitch, cfg.MaxPitch) - 180)
            local yaw = math.rad(math.random(cfg.MinYaw, cfg.MaxYaw) - 180)
            spoofed = (hrp.CFrame + Vector3.new(
                math.random(-cfg.MinX, cfg.MaxX),
                math.random(-cfg.MinY, cfg.MaxY),
                math.random(-cfg.MinZ, cfg.MaxZ)
            )) * CFrame.Angles(pitch, yaw, 0)
        elseif DesyncSettings.Method == "Randomize" then
            spoofed = hrp.CFrame + Vector3.new(math.random(-50, 50), math.random(0, 50), math.random(-50, 50))
        elseif DesyncSettings.Method == "Void" then
            spoofed = hrp.CFrame + Vector3.new(math.random(-80000, 80000), math.random(0, 80000), math.random(-80000, 80000))
        end

        local shouldRun = (not DesyncSettings.Spam) or (DesyncSettings.Spam and desyncInVoid)
        if shouldRun and spoofed then
            local saved = hrp.CFrame
            hrp.CFrame = spoofed
            if DesyncSettings.Visualize and desyncClone then
                setDesyncRigTransparency(DesyncSettings.Transparency)
                desyncClone.HumanoidRootPart.CFrame = spoofed
            else
                setDesyncRigTransparency(1)
            end
            RunService:BindToRenderStep("LexDesyncRestore", 199, function()
                if hrp and hrp.Parent then hrp.CFrame = saved end
                RunService:UnbindFromRenderStep("LexDesyncRestore")
            end)
        else
            setDesyncRigTransparency(1)
        end
    end)
end)

task.spawn(function()
    while task.wait() do
        desyncInVoid = true
        task.wait(DesyncSettings.InVoid)
        desyncInVoid = false
        task.wait(DesyncSettings.OnGround)
    end
end)

DesyncTab:CreateToggle({
    Name = "Desync",
    CurrentValue = false,
    Callback = function(value) DesyncSettings.Enabled = value end
})

DesyncTab:CreateKeybind({
    Name = "Desync Key",
    CurrentValue = desyncKey,
    Callback = function(key) desyncKey = key end
})

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and desyncKey ~= Enum.KeyCode.Unknown and input.KeyCode == desyncKey then
        DesyncSettings.Enabled = not DesyncSettings.Enabled
    end
end)

DesyncTab:CreateToggle({
    Name = "Stay In Void",
    CurrentValue = false,
    Callback = function(value) DesyncSettings.StayInVoid = value end
})

DesyncTab:CreateToggle({
    Name = "Spam",
    CurrentValue = false,
    Callback = function(value) DesyncSettings.Spam = value end
})

DesyncTab:CreateToggle({
    Name = "Visualize",
    CurrentValue = false,
    Callback = function(value) DesyncSettings.Visualize = value end
})

DesyncTab:CreateDropdown({
    Name = "Method",
    Options = {"Custom", "Randomize", "Void"},
    CurrentOption = {"Custom"},
    Callback = function(value)
        DesyncSettings.Method = type(value) == "table" and value[1] or value
    end
})

DesyncTab:CreateSlider({
    Name = "In Void Time",
    Min = 0.05, Max = 2, Increment = 0.01,
    CurrentValue = DesyncSettings.InVoid,
    Callback = function(value) DesyncSettings.InVoid = value end
})

DesyncTab:CreateSlider({
    Name = "On Ground Time",
    Min = 0.05, Max = 2, Increment = 0.001,
    CurrentValue = DesyncSettings.OnGround,
    Callback = function(value) DesyncSettings.OnGround = value end
})

DesyncTab:CreateSlider({
    Name = "Visualize Transparency",
    Min = 0, Max = 1, Increment = 0.01,
    CurrentValue = DesyncSettings.Transparency,
    Callback = function(value) DesyncSettings.Transparency = value end
})

-- Velocity Desync do primeiro script
DesyncTab:CreateToggle({
    Name = "Enable Velocity Desync",
    CurrentValue = false,
    Callback = function(value) DesyncSettings.VelocityEnabled = value end
})

DesyncTab:CreateDropdown({
    Name = "Velocity Desync Type",
    Options = {"low", "high", "y high", "limit", "zero"},
    CurrentOption = {"low"},
    Callback = function(value)
        DesyncSettings.VelocityType = type(value) == "table" and value[1] or value
    end
})

DesyncTab:CreateToggle({
    Name = "Rotate Angular Velocity",
    CurrentValue = false,
    Callback = function(value) DesyncSettings.VelocityRotate = value end
})

-- Underground Invisible (opção que aparece junto ao Desync no primeiro script)
local undergroundInvisibleEnabled = false
local undergroundInvisibleKey = Enum.KeyCode.Unknown
local undergroundSavedCFrame = nil
local undergroundHookInstalled = false
local undergroundOldIndex = nil

local function installUndergroundInvisibleHook(rootPart)
    if undergroundHookInstalled then return end
    if type(hookmetamethod) ~= "function" or type(checkcaller) ~= "function" then return end
    undergroundOldIndex = hookmetamethod(game, "__index", function(self, index)
        if not checkcaller() and undergroundInvisibleEnabled and undergroundSavedCFrame
            and index == "CFrame" and self == rootPart then
            return undergroundSavedCFrame
        end
        return undergroundOldIndex(self, index)
    end)
    undergroundHookInstalled = true
end

DesyncTab:CreateToggle({
    Name = "Underground Invisible",
    CurrentValue = false,
    Callback = function(value) undergroundInvisibleEnabled = value end
})

DesyncTab:CreateKeybind({
    Name = "Underground Invisible Key",
    CurrentValue = undergroundInvisibleKey,
    Callback = function(key) undergroundInvisibleKey = key end
})

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard
        and undergroundInvisibleKey ~= Enum.KeyCode.Unknown
        and input.KeyCode == undergroundInvisibleKey then
        undergroundInvisibleEnabled = not undergroundInvisibleEnabled
    end
end)

RunService.Heartbeat:Connect(function(delta)
    if not undergroundInvisibleEnabled then return end
    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    installUndergroundInvisibleHook(rootPart)
    undergroundSavedCFrame = rootPart.CFrame
    rootPart.CFrame = CFrame.new(rootPart.Position.X, rootPart.Position.Y - 18, rootPart.Position.Z)
        * CFrame.Angles(math.rad(math.random(-180, 180)), math.rad(math.random(-180, 180)), math.rad(math.random(-180, 180)))
    RunService.RenderStepped:Wait()
    if rootPart and rootPart.Parent then rootPart.CFrame = undergroundSavedCFrame end
end)

RunService.Heartbeat:Connect(function()
    if not DesyncSettings.VelocityEnabled then return end
    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local oldLinear = hrp.AssemblyLinearVelocity
    local oldAngular = hrp.AssemblyAngularVelocity
    local velocity = Vector3.zero
    local kind = DesyncSettings.VelocityType

    if kind == "y high" then
        velocity = Vector3.new(0, 16384, 0)
    elseif kind == "high" then
        local x = math.random(1, 2) == 1 and -16384 or 16384
        local y = math.random(1, 2) == 1 and -14384 or 16384
        local z = math.random(1, 2) == 1 and -16384 or 16384
        velocity = Vector3.new(x, y, z)
    elseif kind == "low" then
        local x = math.random(1, 2) == 1 and -300 or 300
        local y = math.random(1, 2) == 1 and -300 or 300
        local z = math.random(1, 2) == 1 and -300 or 300
        velocity = Vector3.new(x, y, z)
    elseif kind == "limit" then
        velocity = Vector3.new(
            math.random(-1000000, 1000000),
            math.random(-1000000, 1000000),
            math.random(-1000000, 1000000)
        )
    end

    hrp.AssemblyLinearVelocity = velocity
    if DesyncSettings.VelocityRotate then
        hrp.AssemblyAngularVelocity = velocity
    end

    RunService:BindToRenderStep("LexVelocityDesyncRestore", 199, function()
        if hrp and hrp.Parent then
            hrp.AssemblyLinearVelocity = oldLinear
            hrp.AssemblyAngularVelocity = oldAngular
        end
        RunService:UnbindFromRenderStep("LexVelocityDesyncRestore")
    end)
end)

-- Funções Auxiliares do Silent Aim e Hitbox portadas do Script 1
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

local function hbIsPlayerKO(Player)
    if not Player or not Player.Character then return true end
    local hum = Player.Character:FindFirstChildOfClass("Humanoid")
    if hum and hum.Health <= 0 then return true end
    local be = Player.Character:FindFirstChild("BodyEffects")
    local ko = be and (be:FindFirstChild("K.O") or be:FindFirstChild("KO"))
    return ko and ko.Value == true or false
end

local function getPart(char, name)
    if not char then return nil end
    local p = char:FindFirstChild(name)
    if p then return p end
    if name == "Torso" or name == "UpperTorso" then
        return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    end
    return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function getPredictedPos(char, partName, amt)
    local part = getPart(char, partName); if not part then return nil end
    local hrp  = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return part.Position end
    local vel = hrp.AssemblyLinearVelocity or hrp.Velocity
    if not vel then return part.Position end
    return part.Position + vel * amt
end

local function GetSilentFOVOrigin()
    if LexScript.Settings.SilentAim.FOVMode == "Center" then
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
    if workspace:FindFirstChild("Ignored") then table.insert(ignoreList, workspace.Ignored) end
    _silentRayParams.FilterDescendantsInstances = ignoreList
    local hit = workspace:Raycast(rayOrigin, rayDir, _silentRayParams)
    return hit == nil
end

local function _silentGetNearest()
    local best = LexScript.Settings.SilentAim.FOV
    local origin = GetSilentFOVOrigin()
    local foundPart, foundPos = nil, nil

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LocalPlayer or not plr.Character then continue end
        if LexScript.Settings.SilentAim.IgnoreKO and isDeadOrKO(plr.Character) then continue end
        local hum = plr.Character:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end

        local hrp = plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character:FindFirstChild("Head")
        if hrp then
            local dist = (hrp.Position - Camera.CFrame.Position).Magnitude
            if dist > LexScript.Settings.SilentAim.MaxDistance then continue end
        end

        if LexScript.Settings.SilentAim.HitpartMode == "Closest Part" then
            for _, pName in ipairs(CLOSEST_PARTS_LIST) do
                local p = plr.Character:FindFirstChild(pName)
                if p then
                    local pDist = (p.Position - Camera.CFrame.Position).Magnitude
                    if pDist <= LexScript.Settings.SilentAim.MaxDistance then
                        local sp, on = Camera:WorldToViewportPoint(p.Position)
                        if on then
                            local d = (Vector2.new(sp.X, sp.Y) - origin).Magnitude
                            if d <= best then
                                if not LexScript.Settings.SilentAim.WallCheck or silentWallCheck(p) then
                                    best = d
                                    foundPart = p
                                    foundPos = LexScript.Settings.SilentAim.PredictEnabled
                                        and getPredictedPos(plr.Character, pName, LexScript.Settings.SilentAim.PredictAmount)
                                        or p.Position
                                end
                            end
                        end
                    end
                end
            end
        else
            local part = getPart(plr.Character, LexScript.Settings.SilentAim.TargetPart)
            if part then
                local pDist = (part.Position - Camera.CFrame.Position).Magnitude
                if pDist <= LexScript.Settings.SilentAim.MaxDistance then
                    local sp, on = Camera:WorldToViewportPoint(part.Position)
                    if on then
                        local d = (Vector2.new(sp.X, sp.Y) - origin).Magnitude
                        if d <= best then
                            if not LexScript.Settings.SilentAim.WallCheck or silentWallCheck(part) then
                                best = d
                                foundPart = part
                                foundPos = LexScript.Settings.SilentAim.PredictEnabled
                                    and getPredictedPos(plr.Character, LexScript.Settings.SilentAim.TargetPart, LexScript.Settings.SilentAim.PredictAmount)
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

local function _applyGunHandlerHook()
    if _silentHookActive then return end
    _silentHookActive = true
    if GunHandler and OriginalGetAim then
        GunHandler.getAim = function(origin, range)
            if LexScript.Settings.SilentAim.Enabled and math.random(1, 100) <= LexScript.Settings.SilentAim.HitChance then
                _silentGetNearest()
                local aimPos = (_silentTargetPart and _silentTargetPos) or nil
                if aimPos then
                    local dir = aimPos - origin
                    if dir.Magnitude > 0.001 then return dir.Unit, range end
                end
            end
            local ok, a, b = pcall(OriginalGetAim, origin, range)
            if ok and a then return a, b end
            return Camera.CFrame.LookVector, range
        end
    end
end

local function _removeGunHandlerHook()
    _silentHookActive = false
    if GunHandler and OriginalGetAim then GunHandler.getAim = OriginalGetAim end
    _silentTargetPart = nil
    _silentTargetPos  = nil
end

-- Hook persistente e forçado do Silent Aim para garantir funcionamento contínuo
task.spawn(function()
    while true do
        task.wait(0.5)
        if LexScript.Settings.SilentAim.Enabled then
            if not GunHandler or not _silentHookActive then
                local modules = ReplicatedStorage:FindFirstChild("Modules") or ReplicatedStorage
                local gh = modules:FindFirstChild("GunHandler") or modules:FindFirstChild("Framework")
                if gh then
                    pcall(function()
                        GunHandler = require(gh)
                        OriginalGetAim = GunHandler.getAim
                        OriginalGetCanShoot = GunHandler.getCanShoot
                        _applyGunHandlerHook()
                    end)
                end
            end
        end
    end
end)

-- Lógica Interna Funcional do Rapid Fire hookado do Script 1
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
            if isPressed and LexScript.Settings.RapidFire.Enabled then
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
            local delayVal = LexScript.Settings.RapidFire.Delay or 0.08
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

local function applyRapidFire()
    if GunHandler then
        local origCanShoot = OriginalGetCanShoot or GunHandler.getCanShoot
        if type(origCanShoot) == "function" then
            GunHandler.getCanShoot = function(c, ...)
                if LexScript.Settings.RapidFire.Enabled then
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

    if not LexScript.Settings.RapidFire.Enabled then
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

-- Funções Core do Hitbox Expander portadas do Script 1
local function applyToHRP(HRP)
    if not HitboxOriginal[HRP] then
        HitboxOriginal[HRP] = {
            Size = HRP.Size,
            CanCollide = HRP.CanCollide
        }
    end

    local targetSize = Vector3.new(LexScript.Settings.Hitbox.Size, LexScript.Settings.Hitbox.Size, LexScript.Settings.Hitbox.Size)
    if HRP.Size ~= targetSize then
        HRP.Size = targetSize
    end
    if HRP.CanCollide then
        HRP.CanCollide = false
    end

    if not HitboxVisuals[HRP] or not HitboxVisuals[HRP].Parent then
        local sphere = Instance.new("Part")
        sphere.Name = "HitboxVisualizer"
        sphere.Material = Enum.Material.ForceField
        sphere.Color = LexScript.Settings.Hitbox.Color
        sphere.Transparency = LexScript.Settings.Hitbox.Transparency
        sphere.Size = targetSize
        sphere.CFrame = HRP.CFrame
        sphere.Anchored = false
        sphere.CanCollide = false
        sphere.Massless = true
        sphere.Parent = workspace

        local weld = Instance.new("WeldConstraint")
        weld.Part0 = sphere
        weld.Part1 = HRP
        weld.Parent = sphere

        HitboxVisuals[HRP] = sphere
    else
        local vis = HitboxVisuals[HRP]
        if vis.Color ~= LexScript.Settings.Hitbox.Color then vis.Color = LexScript.Settings.Hitbox.Color end
        if vis.Transparency ~= LexScript.Settings.Hitbox.Transparency then vis.Transparency = LexScript.Settings.Hitbox.Transparency end
        if vis.Size ~= targetSize then vis.Size = targetSize end
    end
end

local function revertHRP(HRP)
    local data = HitboxOriginal[HRP]
    if data then
        if HRP and HRP.Parent then
            HRP.Size = data.Size
            HRP.CanCollide = data.CanCollide
        end
        HitboxOriginal[HRP] = nil
    end

    if HitboxVisuals[HRP] then
        pcall(function() HitboxVisuals[HRP]:Destroy() end)
        HitboxVisuals[HRP] = nil
    end
end

-- Unificação das alterações de tamanho em tempo real no RenderStepped Loop
local function updateHitboxes()
    if not LexScript.Settings.Hitbox.Enabled then
        if next(HitboxOriginal) ~= nil or next(HitboxVisuals) ~= nil then
            for HRP, _ in pairs(HitboxOriginal) do revertHRP(HRP) end
            for HRP, _ in pairs(HitboxVisuals) do revertHRP(HRP) end
        end
        return
    end

    local hasFilter = false
    for _, _ in pairs(SelectedHitboxPlayers) do hasFilter = true break end

    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            local isSelected = SelectedHitboxPlayers[Player.Name]
            local char = Player.Character
            local HRP = char and char:FindFirstChild("HumanoidRootPart")
            if HRP then
                if (not hasFilter or isSelected) and not hbIsPlayerKO(Player) then
                    applyToHRP(HRP)
                else
                    revertHRP(HRP)
                end
            end
        end
    end
end

-- Inicialização assíncrona do GunHandler do Framework do Da Hood
task.spawn(function()
    local modules = ReplicatedStorage:WaitForChild("Modules", 5) or ReplicatedStorage
    local gh = modules and (modules:WaitForChild("GunHandler", 5) or modules:FindFirstChild("Framework"))
    if gh then
        GunHandler = require(gh)
        OriginalGetAim = GunHandler and GunHandler.getAim
        OriginalGetCanShoot = GunHandler and GunHandler.getCanShoot
        if LexScript.Settings.SilentAim.Enabled then _applyGunHandlerHook() end
    end
end)

-- ================= TAB COMBATE =================
CombatTab:CreateToggle({
    Name = "Sticky Aimbot (Trava por UserId)",
    CurrentValue = LexScript.Settings.Aimbot,
    Callback = function(v)
        LexScript.Settings.Aimbot = v
        if not v then targetUserId = nil end
    end
})

CombatTab:CreateKeybind({
    Name = "Tecla atalho: Aimbot",
    CurrentValue = aimbotKey,
    Callback = function(key) aimbotKey = key end
})

CombatTab:CreateToggle({
    Name = "Habilitar Silent Aim",
    CurrentValue = LexScript.Settings.SilentAim.Enabled,
    Callback = function(v)
        LexScript.Settings.SilentAim.Enabled = v
        if v then _applyGunHandlerHook() else _removeGunHandlerHook() end
    end
})

CombatTab:CreateKeybind({
    Name = "Tecla atalho: Silent Aim",
    CurrentValue = silentKey,
    Callback = function(key) silentKey = key end
})

CombatTab:CreateDropdown({
    Name = "Hitpart Mode",
    Options = {"Single Part", "Closest Part"},
    CurrentOption = {LexScript.Settings.SilentAim.HitpartMode},
    Callback = function(v) LexScript.Settings.SilentAim.HitpartMode = v or v end
})

CombatTab:CreateDropdown({
    Name = "Target Part",
    Options = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    CurrentOption = {LexScript.Settings.SilentAim.TargetPart},
    Callback = function(v) LexScript.Settings.SilentAim.TargetPart = v or v end
})

CombatTab:CreateSlider({
    Name = "Hit Chance (%)",
    Min = 1, Max = 100, Increment = 1,
    CurrentValue = LexScript.Settings.SilentAim.HitChance,
    Callback = function(v) LexScript.Settings.SilentAim.HitChance = v end
})

CombatTab:CreateSlider({
    Name = "Distância Máxima (Studs)",
    Min = 50, Max = 2000, Increment = 50,
    CurrentValue = LexScript.Settings.SilentAim.MaxDistance,
    Callback = function(v) LexScript.Settings.SilentAim.MaxDistance = v end
})

CombatTab:CreateToggle({
    Name = "Wall Check",
    CurrentValue = LexScript.Settings.SilentAim.WallCheck,
    Callback = function(v) LexScript.Settings.SilentAim.WallCheck = v end
})

CombatTab:CreateToggle({
    Name = "Knock Check (Ignore K.O)",
    CurrentValue = LexScript.Settings.SilentAim.IgnoreKO,
    Callback = function(v) LexScript.Settings.SilentAim.IgnoreKO = v end
})

CombatTab:CreateToggle({
    Name = "Show FOV Circle",
    CurrentValue = LexScript.Settings.SilentAim.ShowFOV,
    Callback = function(v) LexScript.Settings.SilentAim.ShowFOV = v end
})

CombatTab:CreateDropdown({
    Name = "FOV Origin",
    Options = {"Mouse", "Center"},
    CurrentOption = {LexScript.Settings.SilentAim.FOVMode},
    Callback = function(v) LexScript.Settings.SilentAim.FOVMode = v or v end
})

CombatTab:CreateSlider({
    Name = "Silent FOV Radius",
    range = {10, 3000},
    increment = 5,
    currentValue = LexScript.Settings.SilentAim.FOV,
    Callback = function(v) LexScript.Settings.SilentAim.FOV = v end
})

CombatTab:CreateInput({
    Name = "Ajustar FOV por Digitação (Sem Limites)",
    PlaceholderText = "Ex: 500, 1000, 1500",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local num = tonumber(text)
        if num then LexScript.Settings.SilentAim.FOV = num end
    end
})

CombatTab:CreateToggle({
    Name = "Silent Aim Prediction",
    CurrentValue = LexScript.Settings.SilentAim.PredictEnabled,
    Callback = function(v) LexScript.Settings.SilentAim.PredictEnabled = v end
})

CombatTab:CreateSlider({
    Name = "Predict Amount",
    Min = 0.01, Max = 0.5, Increment = 0.01,
    CurrentValue = LexScript.Settings.SilentAim.PredictAmount,
    Callback = function(v) LexScript.Settings.SilentAim.PredictAmount = v end
})

-- ================= TAB MOVIMENTO =================
local ConfigControlRefs = {}
ConfigControlRefs.Speed = MovementTab:CreateToggle({
    Name = "Habilitar Speed Boost",
    CurrentValue = LexScript.Settings.Speed,
    Callback = function(v) LexScript.Settings.Speed = v end
})

MovementTab:CreateKeybind({
    Name = "Tecla atalho: Speed",
    CurrentValue = speedKey,
    Callback = function(key) speedKey = key end
})

MovementTab:CreateInput({
    Name = "Velocidade Customizada (WalkSpeed)",
    PlaceholderText = "Ex: 100",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local num = tonumber(text)
        if num then LexScript.Settings.WalkSpeedValue = num end
    end
})

ConfigControlRefs.CFrameSpeed = MovementTab:CreateToggle({
    Name = "Habilitar CFrame Speed",
    CurrentValue = LexScript.Settings.CFrameSpeed,
    Callback = function(v) LexScript.Settings.CFrameSpeed = v end
})

MovementTab:CreateKeybind({
    Name = "Tecla atalho: CFrame Speed",
    CurrentValue = cframeKey,
    Callback = function(key) cframeKey = key end
})

MovementTab:CreateInput({
    Name = "Intensidade Customizada CFrame",
    PlaceholderText = "Ex: 150",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local num = tonumber(text)
        if num then LexScript.Settings.CFrameSpeedValue = num end
    end
})

ConfigControlRefs.Jump = MovementTab:CreateToggle({
    Name = "Modificar Força do Pulo",
    CurrentValue = LexScript.Settings.Jump,
    Callback = function(v) LexScript.Settings.Jump = v end
})

MovementTab:CreateKeybind({
    Name = "Tecla atalho: Jump Power",
    CurrentValue = jumpKey,
    Callback = function(key) jumpKey = key end
})

MovementTab:CreateInput({
    Name = "Força do Pulo Customizada (JumpPower)",
    PlaceholderText = "Ex: 120",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local num = tonumber(text)
        if num then LexScript.Settings.JumpPowerValue = num end
    end
})

ConfigControlRefs.Fly = MovementTab:CreateToggle({
    Name = "Habilitar Vôo (Fly Bypass)",
    CurrentValue = LexScript.Settings.Fly,
    Callback = function(v) LexScript.Settings.Fly = v end
})

MovementTab:CreateKeybind({
    Name = "Tecla atalho: Fly",
    CurrentValue = flyKey,
    Callback = function(key) flyKey = key end
})

MovementTab:CreateInput({
    Name = "Velocidade Customizada de Vôo",
    PlaceholderText = "Ex: 75",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local num = tonumber(text)
        if num then LexScript.Settings.FlySpeedValue = num end
    end
})

-- ================= TAB TELEPORTE =================
TeleportTab:CreateToggle({
    Name = "Ativar Sistema Teleport",
    CurrentValue = LexScript.Settings.TpEnabled,
    Callback = function(v) LexScript.Settings.TpEnabled = v end
})

TeleportTab:CreateKeybind({
    Name = "Tecla para Executar Teleporte",
    CurrentValue = teleportKey,
    Callback = function(key) teleportKey = key LexScript.Settings.TpHolding = false end
})

TeleportTab:CreateDropdown({
    Name = "Modo de Ativação",
    Options = {"Hold", "Toggle"},
    CurrentOption = {"Hold"},
    Callback = function(v) LexScript.Settings.TpMode = v or v LexScript.Settings.TpHolding = false end
})

TeleportTab:CreateDropdown({
    Name = "Posicionamento do Teleporte",
    Options = {"Orbit", "Above", "Below", "Side", "Frente", "Atrás", "Esquerda", "Direita", "Colado"},
    CurrentOption = {"Orbit"},
    Callback = function(v) LexScript.Settings.TpPosition = v or v end
})

TeleportTab:CreateSlider({
    Name = "Velocidade da Órbita",
    Min = 1, Max = 15, Increment = 0.5,
    CurrentValue = LexScript.Settings.TpOrbitSpeed,
    Callback = function(v) LexScript.Settings.TpOrbitSpeed = v end
})

TeleportTab:CreateSlider({
    Name = "Raio de Distância da Órbita",
    Min = 2, Max = 30, Increment = 1,
    CurrentValue = LexScript.Settings.TpOrbitRadius,
    Callback = function(v) LexScript.Settings.TpOrbitRadius = v end
})

-- ================= TAB HITBOX EXPANDER =================
HitboxTab:CreateToggle({
    Name = "Habilitar Hitbox Expander",
    CurrentValue = LexScript.Settings.Hitbox.Enabled,
    Callback = function(v)
        LexScript.Settings.Hitbox.Enabled = v
        if not v then
            for HRP, _ in pairs(HitboxOriginal) do revertHRP(HRP) end
        end
    end
})

HitboxTab:CreateSlider({
    Name = "Tamanho da Hitbox (Size)",
    Min = 2, Max = 30, Increment = 1,
    CurrentValue = LexScript.Settings.Hitbox.Size,
    Callback = function(v) LexScript.Settings.Hitbox.Size = v end
})

HitboxTab:CreateSlider({
    Name = "Transparência do Visualizer",
    Min = 0, Max = 1, Increment = 0.05,
    CurrentValue = LexScript.Settings.Hitbox.Transparency,
    Callback = function(v) LexScript.Settings.Hitbox.Transparency = v end
})

HitboxTab:CreateColorPicker({
    Name = "Cor da Hitbox Part",
    Color = LexScript.Settings.Hitbox.Color,
    Callback = function(v) LexScript.Settings.Hitbox.Color = v end
})

local HitboxTargetDropdown
local ESPTargetDropdown

local function GetPlayerNamesAndDisplaysList()
    local names = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            -- Formato dos seletores: Nome de Display (Nome de usuário)
            table.insert(names, plr.DisplayName .. " (" .. plr.Name .. ")")
        end
    end
    table.sort(names)
    return names
end

local function resolvePlayerOption(option)
    if type(option) == "table" then option = option[1] end
    if type(option) ~= "string" then return nil end
    -- O primeiro texto é o DisplayName; o username fica entre parênteses.
    local username = option:match("%(([^%(%)]+)%)$")
    if username then
        username = username:gsub("^%s+", ""):gsub("%s+$", "")
        local byUsername = Players:FindFirstChild(username)
        if byUsername then return byUsername end
    end
    -- Compatibilidade com opções antigas que continham apenas o username.
    local byName = Players:FindFirstChild(option)
    if byName then return byName end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.DisplayName == option then return plr end
    end
    return nil
end

local function GetTeleportOptions()
    local options = {"Padrão (foco da câmera)"}
    for _, name in ipairs(GetPlayerNamesAndDisplaysList()) do
        table.insert(options, name)
    end
    return options
end

local TeleportTargetDropdown = TeleportTab:CreateDropdown({
    Name = "Target do Teleporte (opcional)",
    Options = GetTeleportOptions(),
    CurrentOption = {"Padrão (foco da câmera)"},
    Callback = function(option)
        local chosen = type(option) == "table" and option[1] or option
        if chosen == "Padrão (foco da câmera)" or chosen == nil or chosen == "" then
            SelectedTeleportTarget = nil
        else
            SelectedTeleportTarget = resolvePlayerOption(chosen)
        end
    end
})

local PlayerListDropdown = PlayerListTab:CreateDropdown({
    Name = "Selecionar jogador",
    Options = GetPlayerNamesAndDisplaysList(),
    CurrentOption = {},
    Callback = function(option)
        SelectedPlayerListTarget = resolvePlayerOption(option)
    end
})

PlayerListTab:CreateButton({
    Name = "Ver personagem / Assistir câmera",
    Callback = function()
        local target = SelectedPlayerListTarget
        local character = target and target.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid and workspace.CurrentCamera then
            SpectatingPlayer = target
            workspace.CurrentCamera.CameraSubject = humanoid
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end
    end
})

PlayerListTab:CreateButton({
    Name = "Parar de assistir / Voltar para mim",
    Callback = function()
        SpectatingPlayer = nil
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid and workspace.CurrentCamera then
            workspace.CurrentCamera.CameraSubject = humanoid
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end
    end
})

local function RefreshDropdowns()
    local list = GetPlayerNamesAndDisplaysList()
    if TeleportTargetDropdown and TeleportTargetDropdown.Refresh then TeleportTargetDropdown:Refresh(GetTeleportOptions()) end
    if PlayerListDropdown and PlayerListDropdown.Refresh then PlayerListDropdown:Refresh(list) end
    if ESPTargetDropdown and ESPTargetDropdown.Refresh then ESPTargetDropdown:Refresh(list) end
    if HitboxTargetDropdown and HitboxTargetDropdown.Refresh then HitboxTargetDropdown:Refresh(list) end
    if SelectedTeleportTarget and not SelectedTeleportTarget.Parent then SelectedTeleportTarget = nil end
    if SelectedPlayerListTarget and not SelectedPlayerListTarget.Parent then SelectedPlayerListTarget = nil end
end
Players.PlayerAdded:Connect(function() task.wait(0.5); RefreshDropdowns() end)
Players.PlayerRemoving:Connect(function(player)
    if SelectedTeleportTarget == player then SelectedTeleportTarget = nil end
    SelectedESPPlayers[player.Name] = nil
    if SelectedPlayerListTarget == player then SelectedPlayerListTarget = nil end
    if SpectatingPlayer == player then
        SpectatingPlayer = nil
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid and workspace.CurrentCamera then workspace.CurrentCamera.CameraSubject = humanoid end
    end
    task.wait(0.2)
    RefreshDropdowns()
end)

HitboxTargetDropdown = HitboxTab:CreateDropdown({
    Name = "Selecionar Alvos para Hitbox",
    Options = GetPlayerNamesAndDisplaysList(),
    CurrentOption = {},
    MultipleOptions = true,
    Callback = function(selectedOptions)
        SelectedHitboxPlayers = {}
        for _, rawName in ipairs(selectedOptions) do
            local name = rawName:match("^([^(]+)%s*%(")
            if name then
                name = name:gsub("%s+$", "")
                SelectedHitboxPlayers[name] = true
            end
        end
    end
})

-- ================= TAB MISC =================
MiscTab:CreateToggle({
    Name = "Ativar Rapid Fire Realtime",
    CurrentValue = LexScript.Settings.RapidFire.Enabled,
    Callback = function(v)
        LexScript.Settings.RapidFire.Enabled = v
        applyRapidFire()
    end
})

MiscTab:CreateSlider({
    Name = "Intervalo do Disparo / Delay",
    Min = 0.001, Max = 0.5, Increment = 0.001,
    CurrentValue = LexScript.Settings.RapidFire.Delay,
    Callback = function(v)
        LexScript.Settings.RapidFire.Delay = v
    end
})

-- Nova adição unificada: Anti Stomp funcional do primeiro script
MiscTab:CreateToggle({
    Name = "Enable Anti Stomp (Insta-Respawn ao cair/derrubado)",
    CurrentValue = LexScript.Settings.AntiStompEnabled,
    Callback = function(v)
        LexScript.Settings.AntiStompEnabled = v
    end
})

-- ================= MISC: OPÇÕES EXTRAS DO PRIMEIRO SCRIPT =================
local defaultCameraMaxZoom = LocalPlayer.CameraMaxZoomDistance

MiscTab:CreateToggle({
    Name = "Unlock Max Zoom Distance",
    CurrentValue = false,
    Callback = function(enabled)
        if enabled then
            LocalPlayer.CameraMaxZoomDistance = 999999
        else
            LocalPlayer.CameraMaxZoomDistance = defaultCameraMaxZoom or 128
        end
    end
})

-- Cash Aura: recolhe MoneyDrops próximos ao personagem.
local cashAuraEnabled = false
MiscTab:CreateToggle({
    Name = "Cash Aura",
    CurrentValue = false,
    Callback = function(enabled)
        cashAuraEnabled = enabled
    end
})

task.spawn(function()
    while task.wait(0.1) do
        if cashAuraEnabled then
            pcall(function()
                local character = LocalPlayer.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                local ignored = workspace:FindFirstChild("Ignored")
                local drops = ignored and ignored:FindFirstChild("Drop")
                if not root or not drops or not fireclickdetector then return end
                for _, cash in ipairs(drops:GetChildren()) do
                    if cash.Name == "MoneyDrop" then
                        local part = cash:IsA("BasePart") and cash or cash:FindFirstChildWhichIsA("BasePart")
                        local detector = cash:FindFirstChildWhichIsA("ClickDetector", true)
                        if part and detector and (part.Position - root.Position).Magnitude < 11.5 then
                            fireclickdetector(detector)
                        end
                    end
                end
            end)
        end
    end
end)

-- Anti RPG: reage a projéteis/lançadores próximos no jogo.
local antiRPGEnabled = false
local antiRPGConnection
local function handleRPGObject(object)
    if not antiRPGEnabled then return end
    task.spawn(function()
        pcall(function()
            local projectile = object
            if object.Name == "Model" then
                projectile = object:FindFirstChild("Launcher") or object:FindFirstChildWhichIsA("BasePart")
                    or object:WaitForChild("Launcher", 0.5)
            end
            if not projectile or not projectile:IsA("BasePart") then return end
            local parentAtStart = projectile.Parent and projectile.Parent.Parent
            while antiRPGEnabled and projectile.Parent and projectile.Parent.Parent == parentAtStart do
                local character = LocalPlayer.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                if not root then break end
                if (projectile.Position - root.Position).Magnitude < 35 then
                    root.CFrame = root.CFrame + (projectile.CFrame.LookVector * 40 * Vector3.new(1, 0, 1))
                    break
                end
                task.wait(0.02)
            end
        end)
    end)
end

MiscTab:CreateToggle({
    Name = "Anti RPG",
    CurrentValue = false,
    Callback = function(enabled)
        antiRPGEnabled = enabled
        if antiRPGConnection then antiRPGConnection:Disconnect(); antiRPGConnection = nil end
        if enabled then
            local ignored = workspace:FindFirstChild("Ignored") or workspace:WaitForChild("Ignored", 5)
            if ignored then
                for _, object in ipairs(ignored:GetChildren()) do handleRPGObject(object) end
                antiRPGConnection = ignored.ChildAdded:Connect(handleRPGObject)
            end
        end
    end
})

-- No Clip com tecla configurável; a tecla alterna o mesmo estado do toggle.
local noClipEnabled = false
local noClipKey = Enum.KeyCode.N
local noClipOriginalCollision = {}
local function setNoClip(enabled)
    noClipEnabled = enabled
    local character = LocalPlayer.Character
    if not character then return end
    if enabled then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                if noClipOriginalCollision[part] == nil then
                    noClipOriginalCollision[part] = part.CanCollide
                end
                part.CanCollide = false
            end
        end
    else
        for part, wasCollidable in pairs(noClipOriginalCollision) do
            if part and part.Parent then part.CanCollide = wasCollidable end
        end
        table.clear(noClipOriginalCollision)
    end
end

MiscTab:CreateToggle({
    Name = "No Clip",
    CurrentValue = false,
    Callback = function(enabled) setNoClip(enabled) end
})

MiscTab:CreateKeybind({
    Name = "Tecla atalho: No Clip",
    CurrentValue = noClipKey,
    Callback = function(key) noClipKey = key end
})

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == noClipKey then
        setNoClip(not noClipEnabled)
    end
end)

RunService.Stepped:Connect(function()
    if noClipEnabled then
        local character = LocalPlayer.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    if noClipEnabled then
        task.wait(0.25)
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                noClipOriginalCollision[part] = part.CanCollide
                part.CanCollide = false
            end
        end
    end
end)

-- ================= TAB VISUAIS =================
-- Os controles antigos de ESP foram substituídos pelo ESP avançado V9 abaixo.
-- A lista de jogadores continua sendo atualizada para Teleporte, Hitbox e Player List.

local function GetPlayerAtCrosshair()
    local closest, best = nil, math.huge
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
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

local function doConsecutiveTeleport(dt)
    if not LexScript.Settings.TpEnabled then return end
    -- Sem alvo fixado, preserva o comportamento original: usa o jogador no foco da câmera.
    local target = SelectedTeleportTarget
    if not (target and target.Parent == Players and target.Character) then
        target = GetPlayerAtCrosshair()
    end
    if not (target and target.Parent == Players and target.Character) then return end
    
    local tHRP = target.Character:FindFirstChild("HumanoidRootPart")
    local myChar = LocalPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    if tHRP and myHRP then
        local mode = LexScript.Settings.TpPosition
        if mode == "Orbit" then
            local step = dt or 0.016
            _tpOrbitAngle = _tpOrbitAngle + (step * LexScript.Settings.TpOrbitSpeed * 2 * math.pi)
            local offset = Vector3.new(math.sin(_tpOrbitAngle) * LexScript.Settings.TpOrbitRadius, 0, math.cos(_tpOrbitAngle) * LexScript.Settings.TpOrbitRadius)
            myHRP.CFrame = CFrame.new(tHRP.Position + offset, tHRP.Position)
        elseif mode == "Above" then
            myHRP.CFrame = tHRP.CFrame * CFrame.new(0, 6, 0)
        elseif mode == "Below" then
            myHRP.CFrame = tHRP.CFrame * CFrame.new(0, -6, 0)
        elseif mode == "Side" then
            myHRP.CFrame = tHRP.CFrame * CFrame.new(3, 0, 3)
        elseif mode == "Frente" then
            myHRP.CFrame = tHRP.CFrame * CFrame.new(0, 0, -4)
        elseif mode == "Atrás" then
            myHRP.CFrame = tHRP.CFrame * CFrame.new(0, 0, 4)
        elseif mode == "Esquerda" then
            myHRP.CFrame = tHRP.CFrame * CFrame.new(-4, 0, 0)
        elseif mode == "Direita" then
            myHRP.CFrame = tHRP.CFrame * CFrame.new(4, 0, 0)
        elseif mode == "Colado" then
            -- Mantém uma pequena separação física para evitar sobreposição de personagens.
            myHRP.CFrame = tHRP.CFrame * CFrame.new(0, 0, -0.8)
        end
    end
end

-- Lógica de Lock Fixo do Aimbot Original
local function GetPlayerClosestToCameraDirection()
    local closest, smallestAngle = nil, math.huge
    local cameraPosition = Camera.CFrame.Position
    local cameraDirection = Camera.CFrame.LookVector 
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local targetPosition = player.Character.Head.Position
            local directionToTarget = (targetPosition - cameraPosition).Unit
            local dotProduct = cameraDirection:Dot(directionToTarget)
            if dotProduct > 0 then 
                local angleDifference = 1 - dotProduct 
                if angleDifference < smallestAngle then smallestAngle = angleDifference closest = player end
            end
        end
    end
    return closest
end

-- Gerenciador de Entrada e Teclas Globais
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == uiToggleKey then
            pcall(function() Window:ToggleHide() end)
        end
        if input.KeyCode == aimbotKey then
            LexScript.Settings.Aimbot = not LexScript.Settings.Aimbot
            if not LexScript.Settings.Aimbot then targetUserId = nil end
        end
        if input.KeyCode == silentKey then
            LexScript.Settings.SilentAim.Enabled = not LexScript.Settings.SilentAim.Enabled
            if LexScript.Settings.SilentAim.Enabled then _applyGunHandlerHook() else _removeGunHandlerHook() end
        end
        if input.KeyCode == speedKey then LexScript.Settings.Speed = not LexScript.Settings.Speed end
        if input.KeyCode == cframeKey then LexScript.Settings.CFrameSpeed = not LexScript.Settings.CFrameSpeed end
        if input.KeyCode == jumpKey then LexScript.Settings.Jump = not LexScript.Settings.Jump end
        if input.KeyCode == flyKey then LexScript.Settings.Fly = not LexScript.Settings.Fly end
        if input.KeyCode == teleportKey and LexScript.Settings.TpEnabled and LexScript.Settings.TpMode == "Toggle" then
            LexScript.Settings.TpHolding = not LexScript.Settings.TpHolding
        end
    end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        State_RF.isHolding = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gp)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        State_RF.isHolding = false
    end
end)

-- Loop RenderStepped unificado para atualização de Física, Fly, FOV, Aimbot, Hitbox, Teleporte e AntiStomp
RunService.RenderStepped:Connect(function(dt)
    -- Lógica do Anti Stomp portado do primeiro script
    if LexScript.Settings.AntiStompEnabled and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        local be  = LocalPlayer.Character:FindFirstChild("BodyEffects")
        local ko  = be and be:FindFirstChild("K.O")
        if hum and ko and ko.Value then
            hum.Health = 0
        end
        if hum and hum.Health <= 1 then
            hum.Health = 0
        end
    end

    -- Desenho do círculo FOV do Silent Aim
    local sOrigin = GetSilentFOVOrigin()
    local sVisible = LexScript.Settings.SilentAim.ShowFOV and LexScript.Settings.SilentAim.Enabled
    SilentCircle.Position = sOrigin
    SilentCircle.Radius   = LexScript.Settings.SilentAim.FOV
    SilentCircle.Color    = LexScript.Settings.SilentAim.FOVColor
    SilentCircle.Visible  = sVisible

    if sVisible and LexScript.Settings.SilentAim.FOVFill then
        SilentCircleFill.Position     = sOrigin
        SilentCircleFill.Radius       = LexScript.Settings.SilentAim.FOV
        SilentCircleFill.Color        = LexScript.Settings.SilentAim.FOVFillColor
        SilentCircleFill.Transparency = LexScript.Settings.SilentAim.FOVFillTransparency
        SilentCircleFill.Visible      = true
    else
        SilentCircleFill.Visible      = false
    end

    -- Chamada em tempo real das hitboxes do primeiro script
    updateHitboxes()

    -- Sistema de Trava do Sticky Aimbot Original
    if LexScript.Settings.Aimbot then
        if not targetUserId then
            local initialTarget = GetPlayerClosestToCameraDirection()
            if initialTarget then targetUserId = initialTarget.UserId end
        end
        if targetUserId then
            local tPlayer = Players:GetPlayerByUserId(targetUserId)
            if tPlayer and tPlayer.Character and tPlayer.Character:FindFirstChild("Head") then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, tPlayer.Character.Head.Position)
            end
        end
    else
        targetUserId = nil 
    end

    -- Sistema de Teleporte Consecutivo
    if LexScript.Settings.TpEnabled then
        if LexScript.Settings.TpMode == "Hold" then
            if UserInputService:IsKeyDown(teleportKey) then doConsecutiveTeleport(dt) end
        elseif LexScript.Settings.TpMode == "Toggle" and LexScript.Settings.TpHolding then
            doConsecutiveTeleport(dt)
        end
    end

    -- WalkSpeed, JumpPower e CFrame Speed
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
        local humanoid = char.Humanoid
        local hrp = char.HumanoidRootPart
        
        humanoid.WalkSpeed = LexScript.Settings.Speed and LexScript.Settings.WalkSpeedValue or 16
        humanoid.JumpPower = LexScript.Settings.Jump and LexScript.Settings.JumpPowerValue or 50
        humanoid.UseJumpPower = LexScript.Settings.Jump

        if LexScript.Settings.CFrameSpeed and humanoid.MoveDirection.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (humanoid.MoveDirection.Unit * LexScript.Settings.CFrameSpeedValue * dt)
            humanoid:Move(humanoid.MoveDirection)
        end

        -- Controle Direcional do Sistema de Vôo
        if LexScript.Settings.Fly then
            humanoid.PlatformStand = true
            local direction = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
            
            hrp.AssemblyLinearVelocity = Vector3.zero
            if direction.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + (direction.Unit * LexScript.Settings.FlySpeedValue * dt)
            end
        else
            if humanoid.PlatformStand then humanoid.PlatformStand = false end
        end
    end
end)

-- ================= ESP AVANCADO V9 =================
local ESPConfig = {
    Enabled = false, Box = false, Box3D = false, BoxFill = false, Gradient = false,
    Health = false, Armor = false, Names = false, Distance = false, Tool = false,
    Tracers = false, Skeleton = false, Highlight = false,
    BoxColor = Color3.fromRGB(255, 70, 70), Box3DColor = Color3.fromRGB(80, 170, 255),
    FillColor = Color3.fromRGB(120, 80, 255), GradientTop = Color3.fromRGB(0, 200, 255),
    GradientBottom = Color3.fromRGB(150, 0, 255), HealthFull = Color3.fromRGB(0, 255, 100),
    HealthEmpty = Color3.fromRGB(255, 50, 50), ArmorFull = Color3.fromRGB(60, 160, 255),
    ArmorEmpty = Color3.fromRGB(30, 50, 90), NameColor = Color3.fromRGB(255,255,255),
    DistanceColor = Color3.fromRGB(255,255,255), ToolColor = Color3.fromRGB(255,220,70),
    NameTextSize = 20,
    NameBold = true,
    TracerColor = Color3.fromRGB(255,255,255), SkeletonColor = Color3.fromRGB(255,255,255),
    HighlightFill = Color3.fromRGB(120,80,255), HighlightOutline = Color3.fromRGB(255,255,255),
    FillTransparency = 0.55, HighlightFillTransparency = 0.55, HighlightOutlineTransparency = 0,
    TracerOrigin = 'Bottom', BarSide = 'Left',
}

ESPTargetDropdown = VisualsTab:CreateDropdown({
    Name = "Target do ESP (vazio = todos)",
    Options = GetPlayerNamesAndDisplaysList(),
    CurrentOption = {},
    MultipleOptions = true,
    Callback = function(selectedOptions)
        SelectedESPPlayers = {}
        if type(selectedOptions) == "table" then
            for _, rawName in ipairs(selectedOptions) do
                local player = resolvePlayerOption(rawName)
                if player and player ~= LocalPlayer then
                    SelectedESPPlayers[player.Name] = true
                end
            end
        end
    end
})

local function espToggle(label, key)
    VisualsTab:CreateToggle({Name=label, CurrentValue=ESPConfig[key], Callback=function(v) ESPConfig[key]=v end})
end
local function espColor(label, key)
    VisualsTab:CreateColorPicker({Name=label, Color=ESPConfig[key], Callback=function(v) ESPConfig[key]=v end})
end
espToggle('Enabled', 'Enabled')
VisualsTab:CreateDropdown({Name='Paleta rápida de cores', Options={'Personalizada','Vermelho','Azul','Verde','Roxo','Amarelo','Branco','Ciano','Rosa'}, CurrentOption={'Personalizada'}, Callback=function(v)
    local choice=type(v)=='table' and v[1] or v
    local palettes={
        Vermelho=Color3.fromRGB(255,55,55), Azul=Color3.fromRGB(55,130,255), Verde=Color3.fromRGB(55,230,110),
        Roxo=Color3.fromRGB(160,75,255), Amarelo=Color3.fromRGB(255,220,45), Branco=Color3.fromRGB(255,255,255),
        Ciano=Color3.fromRGB(0,220,230), Rosa=Color3.fromRGB(255,90,180)
    }
    local c=palettes[choice]
    if c then
        ESPConfig.BoxColor=c; ESPConfig.Box3DColor=c; ESPConfig.FillColor=c; ESPConfig.NameColor=c
        ESPConfig.DistanceColor=c; ESPConfig.TracerColor=c; ESPConfig.SkeletonColor=c; ESPConfig.HighlightFill=c
    end
end})
espToggle('Box', 'Box')
espToggle('3D Box', 'Box3D')
espToggle('Box Fill', 'BoxFill')
espToggle('Gradient Box Fill', 'Gradient')
espToggle('Health Bar', 'Health')
espToggle('Armor Bar', 'Armor')
espToggle('Names', 'Names')
espToggle('Nomes em negrito', 'NameBold')
espToggle('Distance', 'Distance')
espToggle('Tool', 'Tool')
espToggle('Tracers', 'Tracers')
espToggle('Skeleton', 'Skeleton')
espToggle('Highlight', 'Highlight')
espColor('Box Color', 'BoxColor')
espColor('3D Box Color', 'Box3DColor')
espColor('Box Fill Color', 'FillColor')
espColor('Gradient Top Color', 'GradientTop')
espColor('Gradient Bottom Color', 'GradientBottom')
espColor('Health Full Color', 'HealthFull')
espColor('Health Empty Color', 'HealthEmpty')
espColor('Armor Full Color', 'ArmorFull')
espColor('Armor Empty Color', 'ArmorEmpty')
espColor('Name Color', 'NameColor')
VisualsTab:CreateSlider({Name='Name Text Size', Min=14, Max=28, Increment=1, CurrentValue=ESPConfig.NameTextSize, Callback=function(v) ESPConfig.NameTextSize=v end})
espColor('Distance Color', 'DistanceColor')
espColor('Tool Color', 'ToolColor')
espColor('Tracer Color', 'TracerColor')
espColor('Skeleton Color', 'SkeletonColor')
espColor('Highlight Fill Color', 'HighlightFill')
espColor('Highlight Outline Color', 'HighlightOutline')
VisualsTab:CreateDropdown({Name='Tracer Origin', Options={'Bottom','Center','Top'}, CurrentOption={'Bottom'}, Callback=function(v) ESPConfig.TracerOrigin=type(v)=='table' and v[1] or v end})
VisualsTab:CreateDropdown({Name='Health/Armor Bar Side', Options={'Left','Right'}, CurrentOption={'Left'}, Callback=function(v) ESPConfig.BarSide=type(v)=='table' and v[1] or v end})
VisualsTab:CreateSlider({Name='Box Fill Transparency', Min=0, Max=1, Increment=0.05, CurrentValue=0.55, Callback=function(v) ESPConfig.FillTransparency=v end})
VisualsTab:CreateSlider({Name='Highlight Fill Transparency', Min=0, Max=1, Increment=0.05, CurrentValue=0.55, Callback=function(v) ESPConfig.HighlightFillTransparency=v end})
VisualsTab:CreateSlider({Name='Highlight Outline Transparency', Min=0, Max=1, Increment=0.05, CurrentValue=0, Callback=function(v) ESPConfig.HighlightOutlineTransparency=v end})

local ESPObjects = {}
local ESPBones = {
    {'Head','UpperTorso'}, {'UpperTorso','LowerTorso'},
    {'UpperTorso','RightUpperArm'}, {'RightUpperArm','RightLowerArm'}, {'RightLowerArm','RightHand'},
    {'UpperTorso','LeftUpperArm'}, {'LeftUpperArm','LeftLowerArm'}, {'LeftLowerArm','LeftHand'},
    {'LowerTorso','RightUpperLeg'}, {'RightUpperLeg','RightLowerLeg'}, {'RightLowerLeg','RightFoot'},
    {'LowerTorso','LeftUpperLeg'}, {'LeftUpperLeg','LeftLowerLeg'}, {'LeftLowerLeg','LeftFoot'},
    -- R6 fallback links
    {'Head','Torso'}, {'Torso','Left Arm'}, {'Torso','Right Arm'}, {'Torso','Left Leg'}, {'Torso','Right Leg'}
}
local function newDrawing(kind, props)
    local obj = Drawing.new(kind)
    for k,v in pairs(props or {}) do pcall(function() obj[k]=v end) end
    obj.Visible=false
    return obj
end
local ESPBoldFont = 2
pcall(function()
    if Drawing.Fonts and Drawing.Fonts.SystemBold then
        ESPBoldFont = Drawing.Fonts.SystemBold
    end
end)

local function makeESPObject()
    local d={}
    d.box=newDrawing('Square',{Filled=false,Thickness=1,Color=ESPConfig.BoxColor,ZIndex=3})
    d.outline=newDrawing('Square',{Filled=false,Thickness=3,Color=Color3.new(0,0,0),ZIndex=2})
    d.fill=newDrawing('Square',{Filled=true,Thickness=1,Color=ESPConfig.FillColor,ZIndex=1,Transparency=ESPConfig.FillTransparency})
    d.gradient={}
    for i=1,18 do d.gradient[i]=newDrawing('Square',{Filled=true,Thickness=0,ZIndex=1}) end
    d.box3d={}
    for i=1,12 do d.box3d[i]=newDrawing('Line',{Thickness=1,ZIndex=3}) end
    d.hpbg=newDrawing('Square',{Filled=true,Color=Color3.new(0,0,0),ZIndex=2})
    d.hp=newDrawing('Square',{Filled=true,ZIndex=3})
    d.armorbg=newDrawing('Square',{Filled=true,Color=Color3.new(0,0,0),ZIndex=2})
    d.armor=newDrawing('Square',{Filled=true,ZIndex=3})
    d.name=newDrawing('Text',{Size=13,FontSize=13,Center=true,Outline=true,Font=ESPBoldFont,ZIndex=5})
    -- Reforço visual em camadas: mantém o nome encorpado mesmo em Drawing APIs sem fonte bold nativa.
    d.nameBoldCopies={}
    for i=1,4 do
        d.nameBoldCopies[i]=newDrawing('Text',{Size=13,FontSize=13,Center=true,Outline=true,Font=ESPBoldFont,ZIndex=5})
    end
    d.lastNamePosition=nil
    d.distance=newDrawing('Text',{Size=13,FontSize=13,Center=true,Outline=true,Font=2,ZIndex=4})
    d.tool=newDrawing('Text',{Size=13,FontSize=13,Center=true,Outline=true,Font=2,ZIndex=4})
    d.tracer=newDrawing('Line',{Thickness=1,ZIndex=1})
    d.skeleton={}
    for i=1,#ESPBones do d.skeleton[i]=newDrawing('Line',{Thickness=1,ZIndex=2}) end
    d.highlight=nil
    return d
end
local function hideESP(d)
    if not d then return end
    for _,v in pairs(d) do
        if typeof(v)=='Instance' then pcall(function() v:Destroy() end)
        elseif type(v)=='table' then for _,x in pairs(v) do pcall(function() x.Visible=false end) end
        else pcall(function() v.Visible=false end) end
    end
end
local function hideESPKeepName(d)
    if not d then return end
    for key,v in pairs(d) do
        if key ~= 'name' and key ~= 'nameBoldCopies' and key ~= 'lastNamePosition' then
            if type(v)=='table' then
                for _,x in pairs(v) do pcall(function() x.Visible=false end) end
            else
                pcall(function() v.Visible=false end)
            end
        end
    end
    local showName=ESPConfig.Names and d.lastNamePosition~=nil
    d.name.Visible=showName
    for _, copy in ipairs(d.nameBoldCopies or {}) do copy.Visible=showName and ESPConfig.NameBold end
end
local function removeESP(player)
    local d=ESPObjects[player]
    if not d then return end
    for _,v in pairs(d) do
        if type(v)=='table' then for _,x in pairs(v) do pcall(function() x:Remove() end) end
        elseif typeof(v)=='Instance' then pcall(function() v:Destroy() end)
        else pcall(function() v:Remove() end) end
    end
    ESPObjects[player]=nil
end
local function screenPoint(pos)
    local p,on=Camera:WorldToViewportPoint(pos)
    return Vector2.new(p.X,p.Y),on,p.Z
end
local function updateESP(player,d)
    local char=player.Character
    local hrp=char and char:FindFirstChild('HumanoidRootPart')
    local hum=char and char:FindFirstChildOfClass('Humanoid')
    if not char or not hrp or not hum or hum.Health<=0 then hideESPKeepName(d); return end
    local distance=(hrp.Position-Camera.CFrame.Position).Magnitude
    local head=char:FindFirstChild('Head')
    local topPart=head or hrp
    local top,topOn=screenPoint(topPart.Position+Vector3.new(0,0.6,0))
    local bottom,bottomOn=screenPoint(hrp.Position-Vector3.new(0,3.2,0))
    local center,centerOn=screenPoint(hrp.Position)
    if not centerOn or not topOn or not bottomOn then hideESP(d); return end
    local h=math.max(math.abs(bottom.Y-top.Y),4)
    local w=math.max(h*0.58,4)
    local x= center.X-w/2
    local y= math.min(top.Y,bottom.Y)
    local boxPos=Vector2.new(x,y)
    local boxSize=Vector2.new(w,h)
    local corners={
        Vector3.new(-w/2,h/2,-1),Vector3.new(-w/2,-h/2,-1),Vector3.new(w/2,h/2,-1),Vector3.new(w/2,-h/2,-1),
        Vector3.new(-w/2,h/2,1),Vector3.new(-w/2,-h/2,1),Vector3.new(w/2,h/2,1),Vector3.new(w/2,-h/2,1)
    }
    if ESPConfig.Box then
        d.box.Position=boxPos; d.box.Size=boxSize; d.box.Color=ESPConfig.BoxColor; d.box.Visible=true
        d.outline.Position=boxPos-Vector2.new(1,1); d.outline.Size=boxSize+Vector2.new(2,2); d.outline.Visible=true
    else d.box.Visible=false; d.outline.Visible=false end
    if ESPConfig.BoxFill or ESPConfig.Gradient then
        d.fill.Position=boxPos; d.fill.Size=boxSize; d.fill.Color=ESPConfig.FillColor; d.fill.Transparency=ESPConfig.FillTransparency
        d.fill.Visible=ESPConfig.BoxFill and not ESPConfig.Gradient
        for i,seg in ipairs(d.gradient) do
            if ESPConfig.Gradient then
                local sh=h/#d.gradient
                seg.Position=Vector2.new(x,y+(i-1)*sh); seg.Size=Vector2.new(w,sh+1)
                seg.Color=ESPConfig.GradientTop:Lerp(ESPConfig.GradientBottom,(i-1)/(#d.gradient-1))
                seg.Transparency=ESPConfig.FillTransparency; seg.Visible=true
            else seg.Visible=false end
        end
    else d.fill.Visible=false; for _,seg in ipairs(d.gradient) do seg.Visible=false end end
    if ESPConfig.Box3D then
        local cf=hrp.CFrame
        local sz=Vector3.new(2.4,math.max(4.5,h/25),1.4)
        local verts={Vector3.new(-1,1,-1),Vector3.new(-1,-1,-1),Vector3.new(1,1,-1),Vector3.new(1,-1,-1),Vector3.new(-1,1,1),Vector3.new(-1,-1,1),Vector3.new(1,1,1),Vector3.new(1,-1,1)}
        local edges={{1,2},{1,3},{1,5},{2,4},{2,6},{3,4},{3,7},{4,8},{5,6},{5,7},{6,8},{7,8}}
        local pts={}
        for i,v in ipairs(verts) do local pos,visible=screenPoint(cf:PointToWorldSpace(Vector3.new(v.X*sz.X/2,v.Y*sz.Y/2,v.Z*sz.Z/2))); pts[i]={pos=pos,visible=visible} end
        for i,e in ipairs(edges) do local a=pts[e[1]]; local b=pts[e[2]]; local line=d.box3d[i]; line.From=a.pos; line.To=b.pos; line.Color=ESPConfig.Box3DColor; line.Visible=a.visible or b.visible end
    else for _,l in ipairs(d.box3d) do l.Visible=false end end
    local side=ESPConfig.BarSide=='Left' and x-7 or x+w+3
    if ESPConfig.Health then
        local ratio=math.clamp(hum.Health/math.max(hum.MaxHealth,1),0,1)
        d.hpbg.Position=Vector2.new(side-1,y-1); d.hpbg.Size=Vector2.new(5,h+2); d.hpbg.Visible=true
        d.hp.Position=Vector2.new(side,y+h*(1-ratio)); d.hp.Size=Vector2.new(3,h*ratio); d.hp.Color=ESPConfig.HealthEmpty:Lerp(ESPConfig.HealthFull,ratio); d.hp.Visible=true
    else d.hpbg.Visible=false; d.hp.Visible=false end
    if ESPConfig.Armor then
        local armor=0; local be=char:FindFirstChild('BodyEffects'); local av=be and be:FindFirstChild('Armor'); if av then armor=av.Value end
        local ratio=math.clamp(armor/100,0,1); local ax=ESPConfig.BarSide=='Left' and x-13 or x+w+9
        d.armorbg.Position=Vector2.new(ax-1,y-1); d.armorbg.Size=Vector2.new(5,h+2); d.armorbg.Visible=true
        d.armor.Position=Vector2.new(ax,y+h*(1-ratio)); d.armor.Size=Vector2.new(3,h*ratio); d.armor.Color=ESPConfig.ArmorEmpty:Lerp(ESPConfig.ArmorFull,ratio); d.armor.Visible=true
    else d.armorbg.Visible=false; d.armor.Visible=false end
    local namePos=Vector2.new(center.X,y-24)
    d.lastNamePosition=namePos
    d.name.Visible=ESPConfig.Names; d.name.Text=player.DisplayName; d.name.Size=ESPConfig.NameTextSize; d.name.Color=ESPConfig.NameColor; d.name.Position=namePos
    pcall(function() d.name.Font=ESPConfig.NameBold and ESPBoldFont or 2 end)
    pcall(function() d.name.FontSize=ESPConfig.NameTextSize end)
    for i, copy in ipairs(d.nameBoldCopies or {}) do
        copy.Text = player.DisplayName
        copy.Size = ESPConfig.NameTextSize
        copy.Color = ESPConfig.NameColor
        copy.Position = namePos + (ESPConfig.NameBold and ({
            Vector2.new(-0.45, 0), Vector2.new(0.45, 0),
            Vector2.new(0, -0.45), Vector2.new(0, 0.45)
        })[i] or Vector2.new(0, 0))
        copy.Visible = ESPConfig.Names and ESPConfig.NameBold
        pcall(function() copy.Font=ESPBoldFont end)
        pcall(function() copy.FontSize=ESPConfig.NameTextSize end)
    end
    d.distance.Visible=ESPConfig.Distance; d.distance.Text=math.floor(distance)..' studs'; d.distance.Color=ESPConfig.DistanceColor; d.distance.Position=Vector2.new(center.X,y+h+2)
    local tool=char:FindFirstChildOfClass('Tool'); d.tool.Visible=ESPConfig.Tool and tool~=nil; d.tool.Text=tool and tool.Name or ''; d.tool.Color=ESPConfig.ToolColor; d.tool.Position=Vector2.new(center.X,y+h+(ESPConfig.Distance and 18 or 2))
    if ESPConfig.Tracers then
        local vp=Camera.ViewportSize; local oy=ESPConfig.TracerOrigin=='Bottom' and vp.Y or ESPConfig.TracerOrigin=='Center' and vp.Y/2 or 0
        d.tracer.From=Vector2.new(vp.X/2,oy); d.tracer.To=bottom; d.tracer.Color=ESPConfig.TracerColor; d.tracer.Visible=true
    else d.tracer.Visible=false end
    if ESPConfig.Skeleton then
        for i,bone in ipairs(ESPBones) do
            local a=char:FindFirstChild(bone[1]); local b=char:FindFirstChild(bone[2]); local line=d.skeleton[i]
            if a and b then local p1,o1=screenPoint(a.Position); local p2,o2=screenPoint(b.Position); line.From=p1; line.To=p2; line.Color=ESPConfig.SkeletonColor; line.Visible=o1 and o2 else line.Visible=false end
        end
    else for _,line in ipairs(d.skeleton) do line.Visible=false end end
    if ESPConfig.Highlight then
        if not d.highlight or not d.highlight.Parent then d.highlight=Instance.new('Highlight'); d.highlight.Adornee=char; d.highlight.Parent=char end
        d.highlight.FillColor=ESPConfig.HighlightFill; d.highlight.OutlineColor=ESPConfig.HighlightOutline
        d.highlight.FillTransparency=ESPConfig.HighlightFillTransparency; d.highlight.OutlineTransparency=ESPConfig.HighlightOutlineTransparency
    elseif d.highlight then d.highlight:Destroy(); d.highlight=nil end
end

RunService.RenderStepped:Connect(function()
    local on=ESPConfig.Enabled
    for _,player in ipairs(Players:GetPlayers()) do
        if player~=LocalPlayer then
            local hasTargetFilter = next(SelectedESPPlayers) ~= nil
            local isSelected = SelectedESPPlayers[player.Name] == true
            if on and (not hasTargetFilter or isSelected) then
                if not ESPObjects[player] then ESPObjects[player]=makeESPObject() end
                updateESP(player,ESPObjects[player])
            elseif ESPObjects[player] then
                hideESP(ESPObjects[player])
            end
        end
    end
end)
Players.PlayerRemoving:Connect(removeESP)
local function trackESPPlayer(player)
    player.CharacterAdded:Connect(function()
        -- Mantém o objeto associado ao jogador e atualiza o ESP no próximo ciclo,
        -- inclusive depois de morrer, reiniciar o personagem ou carregar um novo avatar.
        if ESPObjects[player] then
            local d=ESPObjects[player]
            if d.highlight then pcall(function() d.highlight:Destroy() end); d.highlight=nil end
        end
    end)
end
for _,player in ipairs(Players:GetPlayers()) do
    if player~=LocalPlayer then trackESPPlayer(player) end
end
Players.PlayerAdded:Connect(function(player)
    if player~=LocalPlayer then trackESPPlayer(player) end
end)

-- ================= VISUAL DO RADAR =================
-- Radar circular + indicadores fora da câmera com miniaturas de perfil.
-- As miniaturas são carregadas uma vez por jogador e reutilizadas nos desenhos.
local RadarTab = Window:CreateTab({ Name = "Visual do radar", Icon = "rbxassetid://100604009889706" })

local RadarConfig = {
    Enabled = false,
    OffscreenEnabled = false,
    UnlimitedRange = true,
    ShowProfilePictures = true,
    ShowNames = true,
    ShowDistance = true,
    RotateWithCamera = true,
    Range = 1200,
    Size = 190,
    PositionLocked = false,
    Position = nil,
    AvatarSize = 34,
    ArrowMargin = 54,
    Corner = "Top Right",
    BackgroundColor = Color3.fromRGB(15, 18, 25),
    BackgroundTransparency = 0.28,
    BorderColor = Color3.fromRGB(210, 215, 230),
    CenterColor = Color3.fromRGB(255, 255, 255),
    PlayerColor = Color3.fromRGB(255, 75, 75),
    AvatarBorderColor = Color3.fromRGB(255, 255, 255),
    ArrowColor = Color3.fromRGB(255, 85, 85),
    NameColor = Color3.fromRGB(255, 255, 255),
    DistanceColor = Color3.fromRGB(220, 225, 235),
}

local function radarToggle(label, key)
    RadarTab:CreateToggle({
        Name = label,
        CurrentValue = RadarConfig[key],
        Callback = function(value) RadarConfig[key] = value end
    })
end

local function radarColor(label, key)
    RadarTab:CreateColorPicker({
        Name = label,
        Color = RadarConfig[key],
        Callback = function(value) RadarConfig[key] = value end
    })
end

radarToggle("Ativar mini radar", "Enabled")
radarToggle("Ativar setas fora da câmera", "OffscreenEnabled")
radarToggle("Mostrar todos no radar (alcance automático)", "UnlimitedRange")
radarToggle("Mostrar fotos de perfil", "ShowProfilePictures")
radarToggle("Mostrar nomes", "ShowNames")
radarToggle("Mostrar distância", "ShowDistance")
radarToggle("Girar radar com a câmera", "RotateWithCamera")
radarToggle("Travar posição do radar", "PositionLocked")

RadarTab:CreateSlider({Name="Tamanho do radar", Min=120, Max=3000, Increment=10, CurrentValue=RadarConfig.Size, Callback=function(v) RadarConfig.Size=v end})
RadarTab:CreateSlider({Name="Alcance do mini radar (studs)", Min=100, Max=5000, Increment=50, CurrentValue=RadarConfig.Range, Callback=function(v) RadarConfig.Range=v end})
RadarTab:CreateSlider({Name="Tamanho das fotos", Min=18, Max=48, Increment=2, CurrentValue=RadarConfig.AvatarSize, Callback=function(v) RadarConfig.AvatarSize=v end})
RadarTab:CreateSlider({Name="Margem das setas", Min=24, Max=120, Increment=2, CurrentValue=RadarConfig.ArrowMargin, Callback=function(v) RadarConfig.ArrowMargin=v end})
RadarTab:CreateSlider({Name="Transparência do fundo", Min=0, Max=1, Increment=0.05, CurrentValue=RadarConfig.BackgroundTransparency, Callback=function(v) RadarConfig.BackgroundTransparency=v end})
RadarTab:CreateDropdown({Name="Posição do radar", Options={"Top Left", "Top Center", "Top Right", "Center Left", "Center Right", "Bottom Left", "Bottom Center", "Bottom Right"}, CurrentOption={RadarConfig.Corner}, Callback=function(v)
    RadarConfig.Corner=type(v)=="table" and v[1] or v
    RadarConfig.Position=nil
end})

radarColor("Cor do fundo", "BackgroundColor")
radarColor("Cor da borda do radar", "BorderColor")
radarColor("Cor do jogador no radar", "PlayerColor")
radarColor("Cor da borda das fotos", "AvatarBorderColor")
radarColor("Cor das setas", "ArrowColor")
radarColor("Cor dos nomes", "NameColor")
radarColor("Cor das distâncias", "DistanceColor")
radarColor("Cor do ponto central", "CenterColor")

local RadarHttpService = game:GetService("HttpService")
local RadarObjects = {}
local RadarAvatarCache = {}

local function radarNewDrawing(kind, props)
    local ok, object = pcall(function() return Drawing.new(kind) end)
    if not ok or not object then return nil end
    for key, value in pairs(props or {}) do
        pcall(function() object[key] = value end)
    end
    pcall(function() object.Visible = false end)
    return object
end

local function radarSet(object, properties)
    if not object then return end
    for key, value in pairs(properties) do
        pcall(function() object[key] = value end)
    end
end

local function radarHide(object)
    if object then pcall(function() object.Visible = false end) end
end

local function radarRemove(object)
    if object then pcall(function() object:Remove() end) end
end

local RadarFrame = {
    Background = radarNewDrawing("Circle", {Filled=true, NumSides=64, ZIndex=1}),
    Border = radarNewDrawing("Circle", {Filled=false, Thickness=2, NumSides=64, ZIndex=4}),
    RingOuter = radarNewDrawing("Circle", {Filled=false, Thickness=1, NumSides=64, ZIndex=2}),
    RingInner = radarNewDrawing("Circle", {Filled=false, Thickness=1, NumSides=64, ZIndex=2}),
    Horizontal = radarNewDrawing("Line", {Thickness=1, ZIndex=2}),
    Vertical = radarNewDrawing("Line", {Thickness=1, ZIndex=2}),
    Center = radarNewDrawing("Circle", {Filled=true, NumSides=24, ZIndex=6}),
    Title = radarNewDrawing("Text", {Text="RADAR", Size=13, FontSize=13, Center=true, Outline=true, Font=ESPBoldFont, ZIndex=6}),
}

local function radarHideFrame()
    for _, drawing in pairs(RadarFrame) do radarHide(drawing) end
end

local RadarCurrentCenter = nil
local function radarUpdateFrame(viewport)
    local size = RadarConfig.Size
    local half = size / 2
    local corner = RadarConfig.Corner
    local cx, cy

    if corner == "Custom" and RadarConfig.Position then
        cx, cy = RadarConfig.Position.X, RadarConfig.Position.Y
    else
        local left = string.find(corner, "Left") ~= nil
        local right = string.find(corner, "Right") ~= nil
        local top = string.find(corner, "Top") ~= nil
        local bottom = string.find(corner, "Bottom") ~= nil
        local fitsX = (half + 18) < (viewport.X - half - 18)
        local fitsY = (half + 42) < (viewport.Y - half - 18)
        if left and fitsX then cx = half + 18
        elseif right and fitsX then cx = viewport.X - half - 18
        else cx = viewport.X / 2 end
        if top and fitsY then cy = half + 42
        elseif bottom and fitsY then cy = viewport.Y - half - 18
        else cy = viewport.Y / 2 end
    end

    local center = Vector2.new(cx, cy)
    RadarCurrentCenter = center
    local radius = half

    radarSet(RadarFrame.Background, {Position=center, Radius=radius, Color=RadarConfig.BackgroundColor, Transparency=RadarConfig.BackgroundTransparency, Visible=true})
    radarSet(RadarFrame.Border, {Position=center, Radius=radius, Color=RadarConfig.BorderColor, Visible=true})
    radarSet(RadarFrame.RingOuter, {Position=center, Radius=radius*0.66, Color=RadarConfig.BorderColor, Transparency=0.55, Visible=true})
    radarSet(RadarFrame.RingInner, {Position=center, Radius=radius*0.33, Color=RadarConfig.BorderColor, Transparency=0.65, Visible=true})
    radarSet(RadarFrame.Horizontal, {From=Vector2.new(cx-radius,cy), To=Vector2.new(cx+radius,cy), Color=RadarConfig.BorderColor, Transparency=0.65, Visible=true})
    radarSet(RadarFrame.Vertical, {From=Vector2.new(cx,cy-radius), To=Vector2.new(cx,cy+radius), Color=RadarConfig.BorderColor, Transparency=0.65, Visible=true})
    radarSet(RadarFrame.Center, {Position=center, Radius=4, Color=RadarConfig.CenterColor, Visible=true})
    radarSet(RadarFrame.Title, {Position=Vector2.new(cx,cy-radius-14), Color=RadarConfig.NameColor, Visible=true})
    return center, radius
end

-- Permite arrastar o radar com o mouse; o toggle de trava desativa o arraste.
local RadarDragging = false
local RadarDragOffset = Vector2.new(0, 0)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    if not RadarConfig.Enabled or RadarConfig.PositionLocked or not RadarCurrentCenter then return end
    local mouse = UserInputService:GetMouseLocation()
    if (mouse - RadarCurrentCenter).Magnitude <= RadarConfig.Size/2 then
        RadarDragging = true
        RadarDragOffset = RadarCurrentCenter - mouse
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if RadarDragging and input.UserInputType == Enum.UserInputType.MouseMovement and not RadarConfig.PositionLocked then
        local mouse = UserInputService:GetMouseLocation()
        RadarConfig.Position = mouse + RadarDragOffset
        RadarConfig.Corner = "Custom"
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then RadarDragging = false end
end)

local function makeRadarPlayer(player)
    if player == LocalPlayer or RadarObjects[player] then return end
    local profileSize = RadarConfig.AvatarSize
    local marker = {
        MapImage = radarNewDrawing("Image", {Size=Vector2.new(profileSize,profileSize), Rounding=profileSize/2, ZIndex=5}),
        MapRing = radarNewDrawing("Circle", {Filled=false, Thickness=2, NumSides=32, ZIndex=6}),
        MapDot = radarNewDrawing("Circle", {Filled=true, NumSides=20, ZIndex=5}),
        MapName = radarNewDrawing("Text", {Size=11, FontSize=11, Center=true, Outline=true, Font=ESPBoldFont, ZIndex=7}),
        MapDistance = radarNewDrawing("Text", {Size=10, FontSize=10, Center=true, Outline=true, Font=ESPBoldFont, ZIndex=7}),
        EdgeImage = radarNewDrawing("Image", {Size=Vector2.new(profileSize,profileSize), Rounding=profileSize/2, ZIndex=12}),
        EdgeRing = radarNewDrawing("Circle", {Filled=false, Thickness=2, NumSides=32, ZIndex=13}),
        EdgeDot = radarNewDrawing("Circle", {Filled=true, NumSides=24, ZIndex=12}),
        EdgeArrow = radarNewDrawing("Triangle", {ZIndex=10}),
        EdgeName = radarNewDrawing("Text", {Size=13, FontSize=13, Center=true, Outline=true, Font=ESPBoldFont, ZIndex=14}),
        EdgeDistance = radarNewDrawing("Text", {Size=11, FontSize=11, Center=true, Outline=true, Font=ESPBoldFont, ZIndex=14}),
        AvatarData = nil,
        AvatarLoading = false,
        AvatarAttempted = false,
    }
    RadarObjects[player] = marker

    local cached = RadarAvatarCache[player.UserId]
    if cached then
        marker.AvatarData = cached
        radarSet(marker.MapImage, {Data=cached})
        radarSet(marker.EdgeImage, {Data=cached})
    end
end

local function loadRadarAvatar(player, marker)
    if marker.AvatarAttempted or marker.AvatarLoading then return end
    marker.AvatarAttempted = true
    local cached = RadarAvatarCache[player.UserId]
    if cached then
        marker.AvatarData = cached
        radarSet(marker.MapImage, {Data=cached})
        radarSet(marker.EdgeImage, {Data=cached})
        return
    end

    marker.AvatarLoading = true
    task.spawn(function()
        local imageBytes = nil
        local ok = pcall(function()
            local endpoint = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. tostring(player.UserId) .. "&size=150x150&format=Png&isCircular=true"
            local response = game:HttpGet(endpoint)
            local decoded = RadarHttpService:JSONDecode(response)
            local first = decoded and decoded.data and decoded.data[1]
            if first and first.imageUrl then
                imageBytes = game:HttpGet(first.imageUrl)
            end
        end)
        marker.AvatarLoading = false
        if ok and type(imageBytes) == "string" and #imageBytes > 0 and RadarObjects[player] == marker then
            RadarAvatarCache[player.UserId] = imageBytes
            marker.AvatarData = imageBytes
            radarSet(marker.MapImage, {Data=imageBytes})
            radarSet(marker.EdgeImage, {Data=imageBytes})
        end
    end)
end

local function radarHideMap(marker)
    radarHide(marker.MapImage); radarHide(marker.MapRing); radarHide(marker.MapDot)
    radarHide(marker.MapName); radarHide(marker.MapDistance)
end

local function radarHideEdge(marker)
    radarHide(marker.EdgeImage); radarHide(marker.EdgeRing); radarHide(marker.EdgeDot)
    radarHide(marker.EdgeArrow); radarHide(marker.EdgeName); radarHide(marker.EdgeDistance)
end

local function updateRadarMap(player, marker, originPosition, center, radius, effectiveRange)
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then radarHideMap(marker); return end

    local delta = root.Position - originPosition
    local flatDistance = Vector2.new(delta.X, delta.Z).Magnitude
    if flatDistance > effectiveRange then radarHideMap(marker); return end

    local mapX, mapForward
    if RadarConfig.RotateWithCamera and Camera then
        mapX = delta:Dot(Camera.CFrame.RightVector)
        mapForward = delta:Dot(Camera.CFrame.LookVector)
    else
        mapX = delta.X
        mapForward = -delta.Z
    end

    local usableRadius = math.max(radius - RadarConfig.AvatarSize/2 - 7, 4)
    local scale = usableRadius / math.max(effectiveRange, 1)
    local point = Vector2.new(center.X + mapX*scale, center.Y - mapForward*scale)
    local imageSize = RadarConfig.AvatarSize
    local hasAvatar = RadarConfig.ShowProfilePictures and marker.AvatarData ~= nil and marker.MapImage ~= nil

    if hasAvatar then
        radarSet(marker.MapImage, {Position=point-Vector2.new(imageSize/2,imageSize/2), Size=Vector2.new(imageSize,imageSize), Rounding=imageSize/2, Visible=true})
        radarHide(marker.MapDot)
        radarSet(marker.MapRing, {Position=point, Radius=imageSize/2+1, Color=RadarConfig.AvatarBorderColor, Visible=true})
    else
        radarHide(marker.MapImage); radarHide(marker.MapRing)
        radarSet(marker.MapDot, {Position=point, Radius=5, Color=RadarConfig.PlayerColor, Visible=true})
    end

    if RadarConfig.ShowNames then
        radarSet(marker.MapName, {Text=player.Name, Position=point+Vector2.new(0,imageSize/2+7), Color=RadarConfig.NameColor, Font=ESPConfig.NameBold and ESPBoldFont or 2, Visible=true})
    else
        radarHide(marker.MapName)
    end
    if RadarConfig.ShowDistance then
        radarSet(marker.MapDistance, {Text=tostring(math.floor(flatDistance)).." studs", Position=point+Vector2.new(0,imageSize/2+18), Color=RadarConfig.DistanceColor, Visible=true})
    else
        radarHide(marker.MapDistance)
    end
end

local function updateRadarEdge(player, marker, viewport)
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root or not Camera then radarHideEdge(marker); return end

    local projected, onScreen = nil, false
    -- Matcha documents WorldToScreen as its screen-projection helper; use it
    -- when available, with Camera:WorldToViewportPoint as a compatibility fallback.
    if type(WorldToScreen) == "function" then
        pcall(function()
            local screenPosition, visible = WorldToScreen(root.Position)
            if screenPosition then
                projected = {X=screenPosition.X, Y=screenPosition.Y, Z=1}
                onScreen = visible
            end
        end)
    else
        pcall(function() projected, onScreen = Camera:WorldToViewportPoint(root.Position) end)
    end
    local inViewport = onScreen and projected and projected.Z > 0
        and projected.X >= 0 and projected.X <= viewport.X
        and projected.Y >= 0 and projected.Y <= viewport.Y
    if inViewport then radarHideEdge(marker); return end

    local cameraCF = Camera.CFrame
    local delta = root.Position - cameraCF.Position
    local horizontal = delta:Dot(cameraCF.RightVector)
    local vertical = delta:Dot(cameraCF.UpVector)
    local forward = delta:Dot(cameraCF.LookVector)
    if forward < 0 then
        horizontal = -horizontal
        vertical = -vertical
    end

    local direction = Vector2.new(horizontal, -vertical)
    if direction.Magnitude < 0.001 then
        direction = forward < 0 and Vector2.new(0,1) or Vector2.new(0,-1)
    else
        direction = direction.Unit
    end

    local iconSize = RadarConfig.AvatarSize
    local halfX = math.max(viewport.X/2 - RadarConfig.ArrowMargin - iconSize/2, 8)
    local halfY = math.max(viewport.Y/2 - RadarConfig.ArrowMargin - iconSize/2, 8)
    local scaleX = math.abs(direction.X) > 0.001 and halfX/math.abs(direction.X) or math.huge
    local scaleY = math.abs(direction.Y) > 0.001 and halfY/math.abs(direction.Y) or math.huge
    local edgeCenter = Vector2.new(viewport.X/2, viewport.Y/2) + direction*math.min(scaleX,scaleY)
    local perpendicular = Vector2.new(-direction.Y,direction.X)
    local tip = edgeCenter + direction*(iconSize/2+8)
    local base = edgeCenter - direction*(iconSize/2-1)

    radarSet(marker.EdgeArrow, {
        PointA=tip,
        PointB=base+perpendicular*7,
        PointC=base-perpendicular*7,
        Color=RadarConfig.ArrowColor,
        Visible=true
    })

    local hasAvatar = RadarConfig.ShowProfilePictures and marker.AvatarData ~= nil and marker.EdgeImage ~= nil
    if hasAvatar then
        radarSet(marker.EdgeImage, {Position=edgeCenter-Vector2.new(iconSize/2,iconSize/2), Size=Vector2.new(iconSize,iconSize), Rounding=iconSize/2, Visible=true})
        radarHide(marker.EdgeDot)
        radarSet(marker.EdgeRing, {Position=edgeCenter, Radius=iconSize/2+1, Color=RadarConfig.AvatarBorderColor, Visible=true})
    else
        radarHide(marker.EdgeImage); radarHide(marker.EdgeRing)
        radarSet(marker.EdgeDot, {Position=edgeCenter, Radius=math.max(iconSize/2,6), Color=RadarConfig.PlayerColor, Visible=true})
    end

    local inward = edgeCenter - direction*(iconSize/2 + 13)
    local distance = (root.Position - cameraCF.Position).Magnitude
    if RadarConfig.ShowNames then
        radarSet(marker.EdgeName, {Text=player.Name, Position=inward-Vector2.new(0,7), Color=RadarConfig.NameColor, Font=ESPConfig.NameBold and ESPBoldFont or 2, Visible=true})
    else
        radarHide(marker.EdgeName)
    end
    if RadarConfig.ShowDistance then
        radarSet(marker.EdgeDistance, {Text=tostring(math.floor(distance)).." studs", Position=inward+Vector2.new(0,8), Color=RadarConfig.DistanceColor, Visible=true})
    else
        radarHide(marker.EdgeDistance)
    end
end

local function removeRadarPlayer(player)
    local marker = RadarObjects[player]
    if not marker then return end
    for key, drawing in pairs(marker) do
        if key ~= "AvatarData" and key ~= "AvatarLoading" and key ~= "AvatarAttempted" then
            radarRemove(drawing)
        end
    end
    RadarObjects[player] = nil
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        makeRadarPlayer(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player == LocalPlayer then return end
    makeRadarPlayer(player)
end)

Players.PlayerRemoving:Connect(removeRadarPlayer)

RunService.RenderStepped:Connect(function()
    local viewport = Camera and Camera.ViewportSize
    if not viewport then
        radarHideFrame()
        for _, marker in pairs(RadarObjects) do radarHideMap(marker); radarHideEdge(marker) end
        return
    end

    local showRadar = RadarConfig.Enabled
    local showEdges = RadarConfig.OffscreenEnabled
    if RadarConfig.ShowProfilePictures and (showRadar or showEdges) then
        for player, marker in pairs(RadarObjects) do
            if not marker.AvatarAttempted and not marker.AvatarLoading then
                loadRadarAvatar(player, marker)
            end
        end
    end
    if showRadar then
        local center, radius = radarUpdateFrame(viewport)
        local localCharacter = LocalPlayer.Character
        local localRoot = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
        if localRoot then
            local effectiveRange = RadarConfig.Range
            if RadarConfig.UnlimitedRange then
                for player, marker in pairs(RadarObjects) do
                    local character = player.Character
                    local root = character and character:FindFirstChild("HumanoidRootPart")
                    if root then
                        local delta = root.Position - localRoot.Position
                        local distance = Vector2.new(delta.X, delta.Z).Magnitude
                        effectiveRange = math.max(effectiveRange, distance)
                    end
                end
            end
            for player, marker in pairs(RadarObjects) do
                updateRadarMap(player, marker, localRoot.Position, center, radius, effectiveRange)
            end
        else
            for _, marker in pairs(RadarObjects) do radarHideMap(marker) end
        end
    else
        radarHideFrame()
        for _, marker in pairs(RadarObjects) do radarHideMap(marker) end
    end

    if showEdges then
        for player, marker in pairs(RadarObjects) do
            updateRadarEdge(player, marker, viewport)
        end
    else
        for _, marker in pairs(RadarObjects) do radarHideEdge(marker) end
    end
end)

-- ================= CONFIG: SALVAR / CARREGAR =================
local ConfigHttpService = game:GetService("HttpService")
local ConfigFolder = "LexScriptV10/Configs"
local SelectedConfigName = "default"
local ConfigNameInput = "default"
local ConfigDropdown = nil

local function ensureConfigFolder()
    if not isfolder or not makefolder then return false end
    local ok = pcall(function()
        if not isfolder("LexScriptV10") then makefolder("LexScriptV10") end
        if not isfolder(ConfigFolder) then makefolder(ConfigFolder) end
    end)
    return ok and isfolder(ConfigFolder)
end

local function encodeConfigValue(value)
    local kind = typeof(value)
    if kind == "Color3" then
        return {__type="Color3", r=value.R, g=value.G, b=value.B}
    elseif kind == "EnumItem" then
        return {__type="EnumItem", enum=tostring(value.EnumType):gsub("^Enum%.", ""), name=value.Name}
    elseif kind == "Vector2" then
        return {__type="Vector2", x=value.X, y=value.Y}
    elseif kind == "Vector3" then
        return {__type="Vector3", x=value.X, y=value.Y, z=value.Z}
    elseif type(value) == "table" then
        local result = {}
        for k, v in pairs(value) do result[k] = encodeConfigValue(v) end
        return result
    end
    return value
end

local function decodeConfigValue(value)
    if type(value) ~= "table" then return value end
    if value.__type == "Color3" then
        return Color3.new(value.r or 1, value.g or 1, value.b or 1)
    elseif value.__type == "EnumItem" then
        local enumType = Enum[value.enum]
        return enumType and enumType[value.name] or nil
    elseif value.__type == "Vector2" then
        return Vector2.new(value.x or 0, value.y or 0)
    elseif value.__type == "Vector3" then
        return Vector3.new(value.x or 0, value.y or 0, value.z or 0)
    end
    local result = {}
    for k, v in pairs(value) do result[k] = decodeConfigValue(v) end
    return result
end

local function mergeConfigTable(destination, source)
    if type(destination) ~= "table" or type(source) ~= "table" then return end
    for key, savedValue in pairs(source) do
        if type(savedValue) == "table" and not savedValue.__type and type(destination[key]) == "table" then
            mergeConfigTable(destination[key], savedValue)
        else
            local decoded = decodeConfigValue(savedValue)
            if decoded ~= nil then destination[key] = decoded end
        end
    end
end

local function cleanConfigName(name)
    name = tostring(name or "default"):gsub("[^%w_%-]", "")
    if name == "" then name = "default" end
    return name
end

local function buildConfigSnapshot()
    return encodeConfigValue({
        ConfigVersion = 2,
        Settings = LexScript.Settings,
        ESPConfig = ESPConfig,
        RadarConfig = RadarConfig,
        DesyncSettings = DesyncSettings,
        Extra = {
            DanceSpeed = DanceSpeed,
            headlessEnabled = headlessEnabled,
            korbloxEnabled = korbloxEnabled,
            cashAuraEnabled = cashAuraEnabled,
            undergroundInvisibleEnabled = undergroundInvisibleEnabled,
            noClipEnabled = noClipEnabled
        },
        Keys = {
            aimbotKey=aimbotKey, silentKey=silentKey, speedKey=speedKey,
            cframeKey=cframeKey, jumpKey=jumpKey, flyKey=flyKey,
            teleportKey=teleportKey, uiToggleKey=uiToggleKey,
            desyncKey=desyncKey, undergroundInvisibleKey=undergroundInvisibleKey,
            noClipKey=noClipKey
        },
        TeleportTarget = SelectedTeleportTarget and SelectedTeleportTarget.Name or "",
        ESPTargets = SelectedESPPlayers,
        HitboxTargets = SelectedHitboxPlayers,
        PlayerListTarget = SelectedPlayerListTarget and SelectedPlayerListTarget.Name or ""
    })
end

local function saveConfig(name)
    name = cleanConfigName(name)
    if not writefile or not ensureConfigFolder() then return false end
    local ok, json = pcall(function() return ConfigHttpService:JSONEncode(buildConfigSnapshot()) end)
    if not ok then return false end
    local path = ConfigFolder .. "/" .. name .. ".json"
    local wrote = pcall(function() writefile(path, json) end)
    if wrote then SelectedConfigName = name; return true end
    return false
end

local function loadConfig(name)
    name = cleanConfigName(name)
    local path = ConfigFolder .. "/" .. name .. ".json"
    if not readfile or not isfile or not isfile(path) then return false end
    local ok, data = pcall(function() return ConfigHttpService:JSONDecode(readfile(path)) end)
    if not ok or type(data) ~= "table" then return false end
    if data.Settings then mergeConfigTable(LexScript.Settings, data.Settings) end

    local function syncConfigControl(control, value)
        if not control then return end
        pcall(function()
            if type(control.Set) == "function" then
                control:Set(value)
            elseif type(control.SetValue) == "function" then
                control:SetValue(value)
            end
        end)
    end

    -- Atualiza os toggles visuais junto com os estados internos carregados.
    syncConfigControl(ConfigControlRefs.Speed, LexScript.Settings.Speed)
    syncConfigControl(ConfigControlRefs.CFrameSpeed, LexScript.Settings.CFrameSpeed)
    syncConfigControl(ConfigControlRefs.Jump, LexScript.Settings.Jump)
    syncConfigControl(ConfigControlRefs.Fly, LexScript.Settings.Fly)

    if data.ESPConfig then mergeConfigTable(ESPConfig, data.ESPConfig) end
    if data.RadarConfig then mergeConfigTable(RadarConfig, data.RadarConfig) end
    if data.DesyncSettings then mergeConfigTable(DesyncSettings, data.DesyncSettings) end
    if data.Extra then
        DanceSpeed = data.Extra.DanceSpeed or DanceSpeed
        if CurrentDanceTrack then pcall(function() CurrentDanceTrack:AdjustSpeed(DanceSpeed) end) end
        if data.Extra.headlessEnabled ~= nil then headlessEnabled = data.Extra.headlessEnabled; setHeadless(headlessEnabled) end
        if data.Extra.korbloxEnabled ~= nil then korbloxEnabled = data.Extra.korbloxEnabled; setKorblox(korbloxEnabled) end
        if data.Extra.cashAuraEnabled ~= nil then cashAuraEnabled = data.Extra.cashAuraEnabled end
        if data.Extra.undergroundInvisibleEnabled ~= nil then undergroundInvisibleEnabled = data.Extra.undergroundInvisibleEnabled end
        if data.Extra.noClipEnabled ~= nil then setNoClip(data.Extra.noClipEnabled) end
    end
    if data.Keys then
        aimbotKey=data.Keys.aimbotKey or aimbotKey
        silentKey=data.Keys.silentKey or silentKey
        speedKey=data.Keys.speedKey or speedKey
        cframeKey=data.Keys.cframeKey or cframeKey
        jumpKey=data.Keys.jumpKey or jumpKey
        flyKey=data.Keys.flyKey or flyKey
        teleportKey=data.Keys.teleportKey or teleportKey
        uiToggleKey=data.Keys.uiToggleKey or uiToggleKey
        desyncKey=data.Keys.desyncKey or desyncKey
        undergroundInvisibleKey=data.Keys.undergroundInvisibleKey or undergroundInvisibleKey
        noClipKey=data.Keys.noClipKey or noClipKey
    end
    if data.TeleportTarget and data.TeleportTarget ~= "" then
        SelectedTeleportTarget = Players:FindFirstChild(data.TeleportTarget)
    else
        SelectedTeleportTarget = nil
    end
    SelectedESPPlayers = {}
    if type(data.ESPTargets) == "table" then
        for playerName, enabled in pairs(data.ESPTargets) do
            if enabled == true and Players:FindFirstChild(playerName) then
                SelectedESPPlayers[playerName] = true
            end
        end
    end

    SelectedHitboxPlayers = {}
    if type(data.HitboxTargets) == "table" then
        for playerName, enabled in pairs(data.HitboxTargets) do
            if enabled == true and Players:FindFirstChild(playerName) then
                SelectedHitboxPlayers[playerName] = true
            end
        end
    end

    SelectedPlayerListTarget = data.PlayerListTarget ~= ""
        and Players:FindFirstChild(data.PlayerListTarget) or nil

    SelectedConfigName = name
    return true
end

local function getConfigNames()
    local names = {}
    if listfiles and ensureConfigFolder() then
        pcall(function()
            for _, filePath in ipairs(listfiles(ConfigFolder)) do
                local fileName = tostring(filePath):gsub("\\", "/"):match("([^/]+)%.json$")
                if fileName then table.insert(names, fileName) end
            end
        end)
    end
    table.sort(names)
    return names
end

ConfigTab:CreateInput({
    Name = "Nome da configuração",
    PlaceholderText = "Digite um nome",
    RemoveTextAfterFocusLost = false,
    Callback = function(value)
        ConfigNameInput = cleanConfigName(value)
    end
})

ConfigDropdown = ConfigTab:CreateDropdown({
    Name = "Configurações salvas",
    Options = getConfigNames(),
    CurrentOption = {},
    Callback = function(value)
        if type(value) == "table" then value = value[1] end
        if value then SelectedConfigName = tostring(value); ConfigNameInput = SelectedConfigName end
    end
})

ConfigTab:CreateButton({
    Name = "Salvar configuração",
    Callback = function()
        if saveConfig(ConfigNameInput ~= "" and ConfigNameInput or SelectedConfigName) then
            if ConfigDropdown and ConfigDropdown.Refresh then ConfigDropdown:Refresh(getConfigNames()) end
            pcall(function() Rayfield:Notify({Title="Config", Content="Configuração salva.", Duration=3}) end)
        else
            pcall(function() Rayfield:Notify({Title="Config", Content="Não foi possível salvar. Verifique o suporte a arquivos do executor.", Duration=4}) end)
        end
    end
})

ConfigTab:CreateButton({
    Name = "Carregar configuração",
    Callback = function()
        if loadConfig(ConfigNameInput ~= "" and ConfigNameInput or SelectedConfigName) then
            pcall(function() Rayfield:Notify({Title="Config", Content="Configuração carregada.", Duration=3}) end)
        else
            pcall(function() Rayfield:Notify({Title="Config", Content="Configuração não encontrada ou inválida.", Duration=3}) end)
        end
    end
})

ConfigTab:CreateButton({
    Name = "Atualizar lista de configs",
    Callback = function()
        if ConfigDropdown and ConfigDropdown.Refresh then ConfigDropdown:Refresh(getConfigNames()) end
    end
})

