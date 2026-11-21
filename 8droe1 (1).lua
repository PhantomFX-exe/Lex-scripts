-- Deobfuscated with expertise by neuro.net.

local p = game
local cloneref = cloneref or function(o) return o end
local _genv = {}
local getgenv = getgenv or function() return _genv end
local tick = tick or os.clock

local Services = {
    Players = p and p.GetService and cloneref(p:GetService("Players")),
    RunService = p and p.GetService and cloneref(p:GetService("RunService")),
    UserInputService = p and p.GetService and cloneref(p:GetService("UserInputService")),
    ReplicatedStorage = p and p.GetService and cloneref(p:GetService("ReplicatedStorage")),
    SoundService = p and p.GetService and cloneref(p:GetService("SoundService")),
    TweenService = p and p.GetService and cloneref(p:GetService("TweenService")),
    Lighting = p and p.GetService and cloneref(p:GetService("Lighting"))
}

if Services.Players and typeof(getgenv().Players) ~= "Instance" then getgenv().Players = Services.Players end
if Services.Players and Services.Players.LocalPlayer and typeof(getgenv().LocalPlayer) ~= "Instance" then getgenv().LocalPlayer = Services.Players.LocalPlayer end
if Services.RunService and typeof(getgenv().RunService) ~= "Instance" then getgenv().RunService = Services.RunService end
if Services.UserInputService and typeof(getgenv().UserInputService) ~= "Instance" then getgenv().UserInputService = Services.UserInputService end
if Services.ReplicatedStorage and typeof(getgenv().ReplicatedStorage) ~= "Instance" then getgenv().ReplicatedStorage = Services.ReplicatedStorage end
if Services.SoundService and typeof(getgenv().SoundService) ~= "Instance" then getgenv().SoundService = Services.SoundService end
if Services.TweenService and typeof(getgenv().TweenService) ~= "Instance" then getgenv().TweenService = Services.TweenService end
if Services.Lighting and typeof(getgenv().Lighting) ~= "Instance" then getgenv().Lighting = Services.Lighting end
if Services.Lighting and typeof(getgenv().WV_Lighting) ~= "Instance" then getgenv().WV_Lighting = Services.Lighting end

local dummy_conn = { Disconnect = function() end }
local dummy_signal = { Connect = function() return dummy_conn end, Wait = function() return nil end }
local dummy_player = {
    Character = nil,
    CharacterAdded = dummy_signal,
    CharacterRemoving = dummy_signal,
    Name = "LocalPlayer",
    UserId = 0
}

if typeof(getgenv().LocalPlayer) ~= "Instance" then
    getgenv().LocalPlayer = (Services.Players and Services.Players.LocalPlayer) or dummy_player
end

if Services.Players and not Services.Players.LocalPlayer then
    task.spawn(function()
        pcall(function()
            local pl = Services.Players
            local lp = pl.LocalPlayer or (pl:GetPropertyChangedSignal("LocalPlayer"):Wait() and pl.LocalPlayer)
            if lp then getgenv().LocalPlayer = lp end
        end)
    end)
end

if typeof(getgenv().WV_Settings) ~= "table" then
    getgenv().WV_Settings = {
        LightingMode = false,
        LightingType = "shadowmap",
        WorldTime = false,
        WorldTimeHour = 4.5,
        Atmosphere = false,
        AtmosphereColor = Color3.fromRGB(255, 255, 255),
        AtmosphereDecay = Color3.fromRGB(120, 120, 120),
        AtmosphereHaze = 1,
        AtmosphereGlare = 10,
        AtmosphereOffset = 0,
        AtmosphereDensity = 0.35,
        Textures = false,
        TexturePack = "minecraft",
        Ambient = false,
        AmbientColor = Color3.fromRGB(128, 128, 128),
        OutdoorColor = Color3.fromRGB(128, 128, 128),
        Weather = false,
        WeatherColor = Color3.fromRGB(255, 255, 255),
        WeatherType = "rain",
        WeatherRate = 100,
        Skybox = false,
        SkyboxType = "realistic"
    }
end

local X = setmetatable({}, {
    __index = function(t, k)
        if k == 19 or k == 36 or k == 48 or k == 68 or k == 100 or k == 127 or k == 136 then
            return getgenv().RunService or Services.RunService
        end
        if k == 34 then return getgenv().Players or Services.Players end
        if k == 8 or k == 35 or k == 82 or k == 227 then return getgenv().LocalPlayer or (Services.Players and Services.Players.LocalPlayer) end
        if k == 37 then return getgenv().UserInputService or Services.UserInputService end
        return rawget(t, k)
    end
})

local Config = {
    LastRespawnTime = tick(),
    Unloaded = false,
    Legit = {},
    ForceHit = {},
    Desync = {},
    Misc = {},
    UI = {},
    Services = {},
    IsHooking = false
}

local N = {
    Aq = function(self, n)
        n = n % 4294967296
        if n ~= n then return 0 end
        return n - n % 1
    end,
    Yq = function(self, t)
        return table.unpack(t, 1, t.n or #t)
    end,
    jq = function(self, tbl, offset, ...)
        local args = table.pack(...)
        for i = 1, args.n do
            tbl[offset + i] = args[i]
        end
    end,
    pq = function(self, tbl, offset, pack_t)
        for i = 1, pack_t.n do
            tbl[offset + i] = pack_t[i]
        end
        tbl.n = offset + pack_t.n
    end,
    fq = function(...)
        return function(...) end
    end
}

task.spawn(function()task.wait(2)
    local S=type(PolSec_SendWebhook)=="function"and type(PolSec_Sanitize)=="function"
    if S then local S=84817806
        local a=S
        local v
        v,S=pcall,N:Aq(bit32.band(171192355,a)+bit32.band(171192355,366838965)+(bit32.band(3952582586,(bit32.bor(a,366838965)))+bit32.band(171192356,(bit32.bxor(a,366838965)))))
        v(function()local S={}
            local a=p
            local v,H=a:GetService("Players").LocalPlayer
            local a=nil
            local w={}
            w.username="NeverLarp // PolSec"
            local H,E,R=a,w
            S[1]=(string.format("**Script Executed Successfully!**\n\226\128\162 **User:** `%s`\n\226\128\162 **Discord ID:** `%s`\n\226\128\162 **Key Note:** `%s`\n\226\128\162 **Country:** `%s`",v.Name,"%PolSec_Discord_Id%","%PolSec_Key_Note%","%PolSec_Country_Code%"))
            E.content=S[1]
            H(E)
        end)
    else print("[PolSec] Script running in un-obfuscated environment (PolSec API unavailable).")
    end
end)
Config.Services = {
    Players = p:GetService("Players"),
    RunService = p:GetService("RunService"),
    UserInputService = p:GetService("UserInputService"),
    ReplicatedStorage = p:GetService("ReplicatedStorage"),
    SoundService = p:GetService("SoundService"),
    TweenService = p:GetService("TweenService"),
    Lighting = p:GetService("Lighting")
}

Config.LocalPlayer = Config.Services.Players.LocalPlayer
getgenv().Players = Config.Services.Players
getgenv().LocalPlayer = Config.LocalPlayer
getgenv().RunService = Config.Services.RunService
getgenv().UserInputService = Config.Services.UserInputService
getgenv().ReplicatedStorage = Config.Services.ReplicatedStorage
getgenv().SoundService = Config.Services.SoundService
getgenv().LocalPlayer = Config.LocalPlayer
X[7]=p
X[6]="Players"
X[267]={}
X[268]=X[6]
N:jq(X[267],0,X[7]:GetService(X[268]).LocalPlayer,function(S)getgenv().LastRespawnTime=tick()
    local w=getgenv().FakePosToggleEnabled
    if w then task.wait(0.2)
        local w=S and S:FindFirstChild("HumanoidRootPart")
        if w then getgenv().FakePosServerPos=w.Position
        end
    end
end)
X[267].n=2
X[9],X[10]=X[267][1],X[267][2]
X[9].CharacterAdded:Connect(X[10])
X[7]=nil
X[269]=getgenv()
X[7]=p
X[269].NeverLose = (loadstring(p:HttpGet("https://files.catbox.moe/rit3mp.luau"))())
getgenv().Notification=getgenv().NeverLose:CreateNotification()
getgenv().Logging=getgenv().NeverLose:CreateLogger()
getgenv().Indicator=getgenv().NeverLose:CreateIndicator()
X[7]=p
X[271]="UserInputService"
X[10]=(X[7]:GetService(X[271]))
X[9]=getgenv
X[6]=function(S)local w={}
    local P=typeof(S)=="EnumItem"
    if P then return S
    else local P=typeof(S)=="string"
        if P then local P=353340517
            local a=P
            local v=S:lower()
            local H={}
            H.m1="MouseButton1"
            H.m2="MouseButton2"
            local E,R=v,H
            P=N:Aq(a+13841323)
            w[1]="MouseButton3"
            R.m3=w[1]
            w[2]="MouseButton1"
            R.mb1=w[2]
            w[3]="MouseButton2"
            R.mb2=w[3]
            w[4]="MouseButton3"
            R.mb3=w[4]
            w[5]="MouseButton1"
            R.m1b=w[5]
            w[6]="MouseButton2"
            R.m2b=w[6]
            w[7]="MouseButton2"
            R.rclick=w[7]
            w[8]="MouseButton1"
            R.lclick=w[8]
            a=R[E]
            P=N:Aq(P+206797439)
            if a then return Enum.UserInputType[R[E]]
            end
            local w=S:gsub("Enum.KeyCode.",""):gsub("Enum.UserInputType.","")
            a,R=pcall(function()return Enum.KeyCode[w]
            end)
            if a and R then return R
            end
            a,R=pcall(function()return Enum.UserInputType[w]
            end)
            if a and R then return R
            end
        end
    end
    return nil
end
X[272]=X[9]()
X[272].parseKey=X[6]
X[6]=X[10].TouchEnabled and not X[10].KeyboardEnabled and not X[10].MouseEnabled and getgenv().NeverLose.Scales.Mobile or getgenv().NeverLose.Scales.Large
X[11]=function(S)local w={}
    local P="NLAssets"
    if not isfolder(P)then makefolder(P)
    end
    getgenv().getCatboxAsset = X[11]
    local w=S:gsub("[^%w]","")..".png"
    local a=P.."/"..w
    P=not isfile(a)
    if P then local P=161246003
        w=P
        local v
        v,P=pcall,N:Aq(w+338046949)
        local w,P=v(function()local H,E=p,S.."?nocache="..tostring(math.random(1,100000))
            return H:HttpGet(E)
        end)
        v=w and P and not P:find("404")and not P:find("Not Found")
        if v then writefile(a,P)
        end
    end
    if isfile(a)then return getcustomasset(a)
    end
    return nil
end
X[7]=(X[11]("https://raw.githubusercontent.com/4lpaca-pin/NeverLose/main/assets/logo.png"))
X[10]=(getgenv())
X[9]=getgenv().NeverLose
X[273]={}
X[274]={}
X[274].Logo=X[7]or getgenv().NeverLose.GlobalLogo
X[274].Name="NeverLarp"
N:jq(X[273],0,X[274],p,"MarketplaceService",p)
X[273].n=4
X[12],X[13],X[14],X[15]=X[273][1],X[273][2],X[273][3],X[273][4]
X[275]=X[14]
X[12].Content = X[13]:GetService(X[275]):GetProductInfo(X[15].PlaceId).Name
X[12].Size=X[6]
X[12].Enable3DRenderer=false
X[12].Keybind = "RightControl"
X[278]=X[12]
X[10].window = (X[9]:CreateWindow(X[278]))
X[280]={}
N:jq(X[280],0,getgenv().window.TopLogoDecorator)
X[280].n=1
X[16]=X[280][1]
getgenv().DecoratorSize=getgenv().DecoratorSize or 120
getgenv().DecoratorX=getgenv().DecoratorX or 340
getgenv().DecoratorY=getgenv().DecoratorY or 0
getgenv().DecoratorVisible=getgenv().DecoratorVisible~=false
getgenv().DecoratorAnimation=nil
getgenv().CurrentDecoratorName=nil
(function()local S={}
    if X[16]then X[16].Size = (UDim2.fromOffset(getgenv().DecoratorSize,getgenv().DecoratorSize))
        X[16].Position = (UDim2.new(0.5,getgenv().DecoratorX,0,getgenv().DecoratorY))
        X[16].Visible = getgenv().DecoratorVisible
        S[7]=X[16]
        S[7].ZIndex=50
    end
end)()
do local S={d=getgenv().window.TopLogoDecorator}
    X[281]={}
    X[282]={}
    X[282].type="static"
    X[282].url="https://files.catbox.moe/h80mc4.png"
    X[282].size=120
    X[282].x=340
    X[282].y=0
    X[281].animegirl=X[282]
    X[284]="sitting dude"
    X[283]={}
    X[283].type="static"
    X[283].url="https://files.catbox.moe/4c50gu.png"
    X[283].size=210
    X[283].x=257
    X[283].y=80
    X[281][X[284]]=X[283]
    X[286]="Linux"
    X[285]={}
    X[285].type="gif"
    X[285].fps=5
    X[285].size=150
    X[285].x=340
    X[285].y=5
    local w,P,a,v,H,E,R,x,q=X[281],X[286],X[285],{},"https://files.catbox.moe/lnnmut.png","https://files.catbox.moe/etwx15.png","https://files.catbox.moe/zxd3w4.png","https://files.catbox.moe/etwx15.png","https://files.catbox.moe/lnnmut.png"
    N:jq(v,0,H,E,R,x,q)
    a.frames=v
    w[P]=a
    X[287]="Charizard"
    X[288]={}
    X[288].type="spritesheet"
    X[288].url="https://files.catbox.moe/ujwejs.png"
    X[288].size=120
    X[288].x=340
    X[288].y=0
    X[288].fps=22
    X[288].sheetWidth=1040
    X[288].sheetHeight=910
    X[288].frameWidth=130
    X[288].columns=8
    X[288].totalFrames=51
    w[X[287]] = X[288]
    S.list=w
    getgenv().DecoratorSize=getgenv().DecoratorSize or 120
    getgenv().DecoratorX=getgenv().DecoratorX or 340
    getgenv().DecoratorY=getgenv().DecoratorY or 0
    getgenv().DecoratorVisible=getgenv().DecoratorVisible~=false
    getgenv().DecoratorAnimation=nil
    getgenv().CurrentDecoratorName=nil
    local function w()if S.d then S.d.Size=UDim2.fromOffset(getgenv().DecoratorSize,getgenv().DecoratorSize)
            S.d.Position=UDim2.new(0.5,getgenv().DecoratorX,0,getgenv().DecoratorY)
            S.d.Visible=getgenv().DecoratorVisible
            S.d.ZIndex=50
        end
    end
    w()
    local function P()if getgenv().DecoratorAnimation then task.cancel(getgenv().DecoratorAnimation)
            getgenv().DecoratorAnimation=nil
        end
        local a=S.d
        if a then local a=S.d:FindFirstChild("DecoratorSheet")
            if a then a.Visible=false
            end
        end
    end
    local function a(v)local H={}
        local E=S.list[v]
        if not E then return
        end
        if getgenv().CurrentDecoratorName==v and getgenv().DecoratorAnimation then return
        end
        P()
        getgenv().CurrentDecoratorName=v
        getgenv().DecoratorSize=E.size
        getgenv().DecoratorX=E.x
        getgenv().DecoratorY=E.y
        w()
        local P,R=S.d and S.d:FindFirstChild("DecoratorSheet"),E.type=="static"
        if R then local R=508706544
            if P then P.Visible=false
            end
            R=N:Aq(R+231691481)
            if S.d then S.d.ImageTransparency=0
                S.d.ImageRectSize=Vector2.zero
                S.d.ImageRectOffset=Vector2.zero
                S.d.ClipsDescendants=false
            end
            local x
            x,R=task,N:Aq(R+257116422)
            x.spawn(function()local R=X[11](E.url)
                if R and S.d and getgenv().CurrentDecoratorName==v then S.d.Image=R
                    S.d.Visible=getgenv().DecoratorVisible
                end
            end)
        else local R=E.type=="gif"
            if R then if P then P.Visible=false
                end
                if S.d then S.d.ImageTransparency=0
                    S.d.ImageRectSize=Vector2.zero
                    S.d.ImageRectOffset=Vector2.zero
                    S.d.ClipsDescendants=false
                end
                getgenv().DecoratorAnimation=task.spawn(function()local P={}
                    for R,x in ipairs(E.frames)do local q=X[11](x)
                    if q then table.insert(P,q)
                    if R==1 and S.d then S.d.Image=q
                    S.d.Visible=getgenv().DecoratorVisible
                end
            end
        end
        if#P==0 then return
        end
        local R=1/E.fps
        while true do for x,x in ipairs(P)do if S.d then S.d.Image=x
                end
                task.wait(R)
            end
        end
    end)
else local P=E.type=="spritesheet"
    if P then local P=136732480
        P=bit32.bxor(P,504358396)
        local R=S.d
        P=bit32.bxor(P,175335514)
        if R then S.d.Image = ""
            S.d.ImageTransparency=1
            S.d.ClipsDescendants=true
            S.d.ImageRectSize=Vector2.zero
            S.d.ImageRectOffset=Vector2.zero
        end
        getgenv().DecoratorAnimation=task.spawn(function()local P={}
            local H=X[11](E.url)
            if not H or not S.d or getgenv().CurrentDecoratorName~=v then return
            end
            local v=S.d:FindFirstChild("DecoratorSheet")
            local R=not v
            if R then v=(Instance.new("ImageLabel"))
                P[1]="DecoratorSheet"
                v.Name=P[1]
                v.BackgroundTransparency=1
                v.BorderSizePixel=0
                v.ResampleMode=Enum.ResamplerMode.Pixelated
                v.ScaleType=Enum.ScaleType.Stretch
                v.Parent=S.d
            end
            v.Image=H
            v.Visible=getgenv().DecoratorVisible
            R=E.size/E.frameWidth
            v.Size=UDim2.fromOffset(E.sheetWidth*R,E.sheetHeight*R)
            R,H=1/E.fps,0
            while true do local P,x=H%E.columns,math.floor(H/E.columns)
                v.Position=UDim2.fromOffset(-P*E.size,-x*E.size)
                H=(H+1)%E.totalFrames
                task.wait(R)
            end
        end)
    end
end
end
end
X[15]=(getgenv().window.UserSettings:AddLabel("decorator"))
X[15]:AddToggle({
    Default = true,
    Flag = "Menu_Decorator_Enabled",
    Callback = function(P)getgenv().DecoratorVisible=P
        w()
        local v=S.d and S.d:FindFirstChild("DecoratorSheet")
        local S=v and getgenv().CurrentDecoratorName=="Charizard"
        if S then v.Visible=P
        end
    end,
})
X[9]=(X[15]:AddOption(1))
X[291]="image"
X[293]=X[9]:AddLabel(X[291])
X[292]={}
X[292].Default="Linux"
local S,P,v,H,E,R,x=X[293],X[292],{},"animegirl","sitting dude","Linux","Charizard"
N:jq(v,0,H,E,R,x)
P.Values=v
P.Flag = "Menu_Decorator_Selection"
P.Callback=function(v)a(v)
end
S:AddDropdown(P)
task.spawn(function()task.wait(0.1)
    a("Linux")
    w()
end)
end
getgenv().Watermark=getgenv().window:Watermark()
getgenv().KeybindHUDVisible=getgenv().KeybindHUDVisible~=false
getgenv().SetKeybindHUDVisible=function(S)getgenv().KeybindHUDVisible=S
    if getgenv().KeybindsDisplayGui then getgenv().KeybindsDisplayGui.Enabled=S
    end
    if getgenv().KeybindGui then getgenv().KeybindGui.Enabled=S
    end
end
if getgenv().KeybindsDisplayGui then pcall(function()getgenv().KeybindsDisplayGui:Destroy()
    end)
    getgenv().KeybindsDisplayGui=nil
end
X[295]=getgenv()
X[295].KeybindsDisplayGui = (Instance.new("ScreenGui"))
X[297]=getgenv().KeybindsDisplayGui
X[297].Name = "NL_DesktopKeybindsHUD"
X[299]=getgenv().KeybindsDisplayGui
X[299].ResetOnSpawn=false
getgenv().KeybindsDisplayGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
getgenv().KeybindsDisplayGui.Enabled=getgenv().KeybindHUDVisible
getgenv().KB_ParentSuccess,_=pcall(function()local S={}
    local w
    S[1]=getgenv().KeybindsDisplayGui
    w=p
    S[2]=(p:GetService("CoreGui"))
    S[1].Parent=S[2]
end)
X[12]=not getgenv().KB_ParentSuccess
if X[12]then X[300]=getgenv().KeybindsDisplayGui
    X[300].Parent = (getgenv().LocalPlayer:WaitForChild("PlayerGui"))
end
X[302]=getgenv()
X[302].KB_MainCard = (Instance.new("Frame"))
X[304]=getgenv().KB_MainCard
X[304].Name = "KeybindsCard"
getgenv().KB_MainCard.Size=UDim2.new(0,180,0,28)
X[13]=(getgenv())
X[306]=X[13].KB_MainCard
X[306].Position = (UDim2.new(0.04,0,0.45,0))
getgenv().KB_MainCard.BackgroundColor3=Color3.fromRGB(11,12,16)
getgenv().KB_MainCard.BackgroundTransparency=0.08
getgenv().KB_MainCard.BorderSizePixel=0
getgenv().KB_MainCard.ClipsDescendants=true
getgenv().KB_MainCard.Parent=getgenv().KeybindsDisplayGui
X[12]=(Instance.new("UICorner",getgenv().KB_MainCard))
X[12].CornerRadius = (UDim.new(0,7))
X[6]=(Instance.new("UIStroke",getgenv().KB_MainCard))
X[6].Color = (Color3.fromRGB(32,34,44))
X[6].Thickness=1.1
X[6].Transparency=0.3
X[13]=(Instance.new("Frame",getgenv().KB_MainCard))
X[13].Name = "HeaderBar"
X[13].Size = (UDim2.new(1,0,0,27))
X[13].Position = (UDim2.new(0,0,0,0))
X[13].BackgroundTransparency=1
X[13].BorderSizePixel=0
X[14]=(Instance.new("TextLabel",X[13]))
X[14].Name = "Title"
X[12]=nil
X[12]=UDim2
X[14].Size = (X[12].new(1,-20,1,0))
X[14].Position = (UDim2.new(0,10,0,0))
X[14].BackgroundTransparency=1
X[14].Text = "keybinds"
X[14].TextColor3 = (Color3.fromRGB(220,222,230))
X[14].TextSize=11
X[14].Font = Enum.Font.GothamBold
X[14].TextXAlignment = Enum.TextXAlignment.Left
X[14]=(Instance.new("Frame",getgenv().KB_MainCard))
X[14].Name = "WhiteSeparator"
X[14].Size = (UDim2.new(1,-16,0,1))
X[14].Position = (UDim2.new(0,8,0,27))
X[14].BackgroundColor3 = (Color3.fromRGB(255,255,255))
X[14].BackgroundTransparency=0.9
X[14].BorderSizePixel=0
X[324]=getgenv()
X[324].KB_RowsHolder = (Instance.new("Frame",getgenv().KB_MainCard))
X[326]=getgenv().KB_RowsHolder
X[326].Name = "RowsHolder"
getgenv().KB_RowsHolder.Size=UDim2.new(1,0,1,-29)
X[7]=nil
X[15]=nil
X[7]=getgenv().KB_RowsHolder
X[15]=UDim2
X[7].Position = (X[15].new(0,0,0,29))
getgenv().KB_RowsHolder.BackgroundTransparency=1
X[7]=(Instance.new("UIPadding",getgenv().KB_RowsHolder))
X[7].PaddingLeft = (UDim.new(0,10))
X[7].PaddingRight = (UDim.new(0,10))
X[7].PaddingTop = (UDim.new(0,5))
X[7].PaddingBottom = (UDim.new(0,5))
X[333]=getgenv()
X[333].KB_RowsLayout = (Instance.new("UIListLayout",getgenv().KB_RowsHolder))
getgenv().KB_RowsLayout.Padding=UDim.new(0,3)
getgenv().KB_RowsLayout.SortOrder=Enum.SortOrder.LayoutOrder
getgenv().KB_IsDragging=false
getgenv().KB_DragStart=nil
getgenv().KB_StartPos=nil
getgenv().KB_DragInput=nil
X[17]=function(S)if S.UserInputType==Enum.UserInputType.MouseButton1 or S.UserInputType==Enum.UserInputType.Touch then local w=61026661
        local P=w
        getgenv().KB_IsDragging=true
        getgenv().KB_DragStart=S.Position
        local a=getgenv()
        w=N:Aq(bit32.band(316011589,P)+bit32.band(316011589,185185618)+(bit32.band(3978955708,(bit32.bor(P,185185618)))+bit32.band(3978955706,(bit32.band(P,185185618)))))
        P=getgenv().KB_MainCard
        w=bit32.bxor(w,46362623)
        a.KB_StartPos=P.Position
        local function w()if S.UserInputState==Enum.UserInputState.End then getgenv().KB_IsDragging=false
            end
        end
        S.Changed:Connect(w)
    end
end
X[13].InputBegan:Connect(X[17])
X[18]=function(S)if S.UserInputType==Enum.UserInputType.MouseMovement or S.UserInputType==Enum.UserInputType.Touch then getgenv().KB_DragInput=S
    end
end
X[13].InputChanged:Connect(X[18])
X[15]=getgenv
X[13]=X[15]().UserInputService
X[6]=function(S)if S==getgenv().KB_DragInput and getgenv().KB_IsDragging then local w=S.Position-getgenv().KB_DragStart
        getgenv().KB_MainCard.Position=UDim2.new(getgenv().KB_StartPos.X.Scale,getgenv().KB_StartPos.X.Offset+w.X,getgenv().KB_StartPos.Y.Scale,getgenv().KB_StartPos.Y.Offset+w.Y)
    end
end
X[13].InputChanged:Connect(X[6])
Config.TrackedKeybinds={}
X[336]=(getgenv())
N:jq(Config.TrackedKeybinds,0,X[336],{})
X[337]={}
X[337].Name="Force hit"
X[337].GetKey=function()local S=Config.ForceHit and Config.ForceHit.Key
    local w=S and(typeof(S)=="EnumItem"and S.Name or tostring(S))
    S=w or "C"
    return S
end
X[337].IsActive=function()return Config.ForceHit and Config.ForceHit.Enabled and Config.ForceHit.Active
end
N:jq(Config.TrackedKeybinds,2,X[337])
X[338]={}
X[338].Name="Flashback"
X[338].GetKey=function()return "Auto"
end
X[338].IsActive=function()return getgenv().FlashbackConfig and getgenv().FlashbackConfig.Enabled
end
N:jq(Config.TrackedKeybinds,3,X[338])
X[339]={}
X[339].Name="Target strafe"
X[339].GetKey=function()local S=Config.ForceHit and Config.ForceHit.StrafeKey
    local w=S and(typeof(S)=="EnumItem"and S.Name or tostring(S))
    S=w or "N"
    return S
end
X[339].IsActive=function()return Config.ForceHit and Config.ForceHit.StrafeEnabled
end
N:jq(Config.TrackedKeybinds,4,X[339])
X[340]={}
X[340].Name="Aimbot"
X[340].GetKey=function()local S=Config.Legit and Config.Legit.AimbotKey
    local w=S and(typeof(S)=="EnumItem"and S.Name or tostring(S))
    S=w or "F"
    return S
end
X[340].IsActive=function()return Config.Legit and Config.Legit.AimbotEnabled and Config.Legit.AimbotActive
end
N:jq(Config.TrackedKeybinds,5,X[340])
X[341]={}
X[341].Name="Desync"
X[341].GetKey=function()local S=getgenv().Des_Keybind
    local w=S and(typeof(S)=="EnumItem"and S.Name or tostring(S))
    S=w or "V"
    return S
end
X[341].IsActive=function()return Config.Desync and Config.Desync.enabled
end
N:jq(Config.TrackedKeybinds,6,X[341])
X[342]={}
X[342].Name="Glue"
X[342].GetKey=function()local S=getgenv().GlueKey
    local w=S and(typeof(S)=="EnumItem"and S.Name or tostring(S))
    S=w or "G"
    return S
end
X[342].IsActive=function()return getgenv().glue_active==true
end
N:jq(Config.TrackedKeybinds,7,X[342])
X[343]={}
X[343].Name="CFrame speed"
X[343].GetKey=function()local S=Config.Misc and Config.Misc.CFrameSpeedKey
    local w=S and(typeof(S)=="EnumItem"and S.Name or tostring(S))
    S=w or "None"
    return S
end
X[343].IsActive=function()return Config.Misc and Config.Misc.CFrameSpeedEnabled and Config.Misc.CFrameSpeedActive
end
N:jq(Config.TrackedKeybinds,8,X[343])
X[344]={}
X[344].Name="CFrame fly"
X[344].GetKey=function()local S=Config.Misc and Config.Misc.CFrameFlyKey
    local w=S and(typeof(S)=="EnumItem"and S.Name or tostring(S))
    S=w or "None"
    return S
end
X[344].IsActive=function()return Config.Misc and Config.Misc.CFrameFlyEnabled and Config.Misc.CFrameFlyActive
end
N:jq(Config.TrackedKeybinds,9,X[344])
X[345]={}
X[345].Name="WalkSpeed"
X[345].GetKey=function()local S=Config.Misc and Config.Misc.WalkSpeedKey
    local w=S and(typeof(S)=="EnumItem"and S.Name or tostring(S))
    S=w or "None"
    return S
end
X[345].IsActive=function()return Config.Misc and Config.Misc.WalkSpeedEnabled and Config.Misc.WalkSpeedActive
end
N:jq(Config.TrackedKeybinds,10,X[345])
X[346]={}
X[346].Name="Kill aura"
X[346].GetKey=function()return "Auto"
end
X[346].IsActive=function()return getgenv().KillAura and getgenv().KillAura.Enabled
end
N:jq(Config.TrackedKeybinds,11,X[346])
X[347]={}
X[347].Name="Fake pos"
X[347].GetKey=function()local S=getgenv().FakePosKey
    local w=S and(typeof(S)=="EnumItem"and S.Name or tostring(S))
    S=w or "None"
    return S
end
X[347].IsActive=function()return getgenv().PhysicsRepDesyncEnabled==true
end
N:jq(Config.TrackedKeybinds,12,X[347])
Config.TrackedKeybinds.n=13
X[19],X[20],X[21],X[22],X[23],X[24],X[25],X[26],X[27],X[28],X[29],X[30],X[31]=Config.TrackedKeybinds[1],Config.TrackedKeybinds[2],Config.TrackedKeybinds[3],Config.TrackedKeybinds[4],Config.TrackedKeybinds[5],Config.TrackedKeybinds[6],Config.TrackedKeybinds[7],Config.TrackedKeybinds[8],Config.TrackedKeybinds[9],Config.TrackedKeybinds[10],Config.TrackedKeybinds[11],Config.TrackedKeybinds[12],Config.TrackedKeybinds[13]
N:jq(X[20],0,X[21],X[22],X[23],X[24],X[25],X[26],X[27],X[28],X[29],X[30],X[31])
X[19].KB_TrackedFeatures=X[20]
getgenv().KB_RowInstances={}
X[14]=getgenv
X[28]=function(S)local w={}
    local P=Instance.new("Frame")
    w[1]="Row_"..S.Name
    P.Name=w[1]
    P.Size=UDim2.new(1,0,0,16)
    P.BackgroundTransparency=1
    P.Visible=false
    P.Parent=getgenv().KB_RowsHolder
    local a=Instance.new("TextLabel",P)
    w[2]="NameLabel"
    a.Name=w[2]
    a.Size=UDim2.new(0.65,0,1,0)
    a.Position=UDim2.new(0,0,0,0)
    a.BackgroundTransparency=1
    a.Text=S.Name
    a.Font=Enum.Font.GothamMedium
    a.TextSize=11
    a.TextColor3=Color3.fromRGB(200,202,212)
    a.TextXAlignment=Enum.TextXAlignment.Left
    local v=Instance.new("TextLabel",P)
    w[3]="StatusLabel"
    v.Name=w[3]
    v.Size=UDim2.new(0.35,0,1,0)
    v.Position=UDim2.new(0.65,0,0,0)
    v.BackgroundTransparency=1
    v.Font=Enum.Font.GothamMedium
    v.TextSize=11
    w[4]="["..S.GetKey().."]"
    v.Text=w[4]
    v.TextColor3=Color3.fromRGB(130,134,146)
    v.TextXAlignment=Enum.TextXAlignment.Right
    getgenv().KB_RowInstances[S.Name]={Frame=P,NameLabel=a,StatusLabel=v}
end
X[348]=X[14]()
X[348].createKeybindRow=X[28]
for S,S in ipairs(getgenv().KB_TrackedFeatures)do getgenv().createKeybindRow(S)
end
task.spawn(function()local S={}
    while task.wait(0.04)do if getgenv().Unloaded then if getgenv().KeybindsDisplayGui then getgenv().KeybindsDisplayGui:Destroy()
            end
            break
        end
        local w,P,a=ipairs,getgenv().KB_TrackedFeatures,0
        for v,H in w(P)do v=getgenv().KB_RowInstances[H.Name]
            if v then local E=45181779
                local R=E
                local x=false
                local q=N:Aq(a)
                E=N:Aq(bit32.band(321341559,4294967295)+R+(bit32.band(3582116556,q)+bit32.band(3582116556,(bit32.bnot(q)))))
                R=nil
                R,E=pcall,N:Aq(E-164653314)
                R(function()x=H.IsActive()
                end)
                if x then a+=1
                    v.StatusLabel.Text = "["..H.GetKey().."]"
                    v.Frame.Visible=true
                else v.Frame.Visible=false
                end
            end
        end
        w,P=a==0 and 28 or 34+a*19,p
        local S,a=P:GetService("TweenService"),getgenv
        local v,H,E=a().KB_MainCard,TweenInfo.new,Enum
        a,P=E.EasingStyle.Quad,Enum.EasingDirection
        local E,R=H(0.12,a,P.Out),{}
        R.Size=UDim2.new(0,180,0,w)
        S:Create(v,E,R):Play()
    end
end)
X[349]=getgenv()
X[349].UITogg = (getgenv().Watermark:AddBlock("cube-vertexes","neverlose"))
X[21]=(getgenv())
X[25]=function()getgenv().window:ToggleInterface()
end
X[21].UITogg:Input(X[25])
X[351]={}
X[351].AimbotEnabled=false
X[351].AimbotActive=false
X[351].AimbotKey=Enum.KeyCode.F
X[351].KeyMode="Hold"
X[351].SilentAimEnabled=false
X[351].HitPart="Head"
X[351].Smoothness=5
X[351].Prediction=0.135
X[351].WallCheck=true
X[351].ForceFieldCheck=true
X[351].DeathCheck=true
X[351].MaxDistance=250
X[351].FovRadius=100
X[351].FovVisible=false
X[351].FovColor=Color3.fromRGB(255,255,255)
X[351].FovFilled=false
X[351].FovTransparency=0.5
Config.Legit = X[351]
Config.Camera = workspace.CurrentCamera
Config.Players = getgenv().Players
Config.LocalPlayer = getgenv().LocalPlayer
Config.RunService = getgenv().RunService
Config.UserInputService = getgenv().UserInputService
getgenv().Players = getgenv().Players
getgenv().LocalPlayer = getgenv().LocalPlayer
X[36] = getgenv().RunService
getgenv().UserInputService = getgenv().UserInputService
Config.FovCircle = Drawing.new("Circle")
Config.FovCircle.Thickness = 1
Config.FovCircle.NumSides = 64
Config.FovCircle.Filled = false
Config.WallCheck=function(S,w)local P=getgenv().LocalPlayer.Character
    if not P then return false
    end
    local a=P:FindFirstChild("Head")
    if not a then return false
    end
    local v,H=RaycastParams.new(),{P}
    if w then table.insert(H,w)
    end
    local E,R=ipairs,table.pack(workspace:GetChildren())
    for x,x in E(table.unpack(R))do P=x.Name=="hit_cham"or x.Name:find("HitEffect")
        if P then table.insert(H,x)
        end
    end
    v.FilterDescendantsInstances=H
    v.FilterType=Enum.RaycastFilterType.Exclude
    v.IgnoreWater=true
    R=a.Position+workspace.CurrentCamera.CFrame.LookVector*1.5
    H=workspace:Raycast(R,S-R,v)
    if not H then return true
    end
    E=H.Instance
    if E then R=(H.Instance:FindFirstAncestorOfClass("Model"))
        if R==w or R and getgenv().Players:GetPlayerFromCharacter(R)then return true
        end
        v=H.Instance:FindFirstAncestor("hit_cham")or H.Instance.Parent and H.Instance.Parent.Name:find("HitEffect")
        if v then return true
        end
    end
    return false
end
X[24]=getgenv
X[20]=function()local S=273490454
    local w=S
    local P,a,v={},ipairs,getgenv().Players
    S=N:Aq(bit32.band(492137355,w)+bit32.band(4294967295,138283397)+(bit32.band(2,(bit32.bor(w,138283397)))+(bit32.band(3802829940,4294967295)+bit32.band(492137356,(bit32.bnot(w))))))
    w=table.pack(v:GetPlayers())
    S=bit32.bxor(S,216236183)
    for S,H in a(table.unpack(w))do v=H~=getgenv().LocalPlayer
        if v then S=H.DisplayName.." (@"..H.Name..")"
            table.insert(P,S)
        end
    end
    table.sort(P,function(S,w)return S:lower()<w:lower()
    end)
    return P
end
X[359]=X[24]()
X[359].getPlayerNames=X[20]
X[7]=getgenv
X[6]=function(S)if not S then return nil
    end
    local w=S:match("@([^%)]+)")
    if w then return getgenv().Players:FindFirstChild(w)
    end
    return getgenv().Players:FindFirstChild(S)
end
X[360]=X[7]()
X[360].getPlayerFromLabel=X[6]
Config.GetClosestLegitTarget=function()local S,w,P,a=getgenv().UserInputService:GetMouseLocation(),Config.Legit.FovRadius,ipairs,table.pack(getgenv().Players:GetPlayers())
    local v
    for H,E in P(table.unpack(a))do H=E~=getgenv().LocalPlayer and E.Character
        if H then local P,a=E.Character,Config.Legit.DeathCheck
            if a then local H=P:FindFirstChildOfClass("Humanoid")
                if not H or H.Health<=0 then continue
                end
                H=(P:FindFirstChild("BodyEffects"))
                local R=H and H:FindFirstChild("K.O")and H["K.O"].Value
                if R then continue
                end
            end
            a=Config.Legit.ForceFieldCheck and P:FindFirstChildOfClass("ForceField")
            if a then continue
            end
            a=(P:FindFirstChild(Config.Legit.HitPart))
            if a then local H=getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if H and(H.Position-a.Position).Magnitude>Config.Legit.MaxDistance then continue
                end
                local R,x=Config.Camera:WorldToViewportPoint(a.Position)
                if x then if Config.Legit.WallCheck and not Config.WallCheck(a.Position,P)then continue
                end
                H=(Vector2.new(R.X,R.Y)-S).Magnitude
                if H<w then w,v=H,E
                end
            end
        end
    end
end
return v
end
Config.UpdateLegitAimbot=function()local S={}
    Config.FovCircle.Visible = Config.Legit.FovVisible
    Config.FovCircle.Radius = Config.Legit.FovRadius
    Config.FovCircle.Color = Config.Legit.FovColor
    Config.FovCircle.Position = (getgenv().UserInputService:GetMouseLocation())
    Config.FovCircle.Transparency = Config.Legit.FovTransparency
    Config.FovCircle.Filled = Config.Legit.FovFilled
    if Config.Legit.AimbotEnabled or Config.Legit.SilentAimEnabled then S[13]=(Config.GetClosestLegitTarget())
        CurrentLegitTarget=S[13]
    else CurrentLegitTarget=nil
    end
    local w=Config.Legit.AimbotEnabled and Config.Legit.AimbotActive
    if w then local w=Config.GetClosestLegitTarget()
        local P=w and w.Character
        if P then local P,a=w.Character:FindFirstChild(Config.Legit.HitPart),w.Character:FindFirstChildOfClass("Humanoid")
            if P and a then local w=P.AssemblyLinearVelocity
                local a=P.Position+w*Config.Legit.Prediction
                w=(CFrame.lookAt(Config.Camera.CFrame.Position,a))
                Config.Camera.CFrame = (Config.Camera.CFrame:Lerp(w,1/Config.Legit.Smoothness))
            end
        end
    end
end
getgenv().RunService.RenderStepped:Connect(Config.UpdateLegitAimbot)
Config.AimbotInputBegan=function(S,w)local P={}
    if not S.KeyCode or S.KeyCode==Enum.KeyCode.Unknown or S.KeyCode==Enum.KeyCode.None then return
    end
    if w and not(Config.Legit.AimbotKey==Enum.UserInputType.MouseButton1 or Config.Legit.AimbotKey==Enum.UserInputType.MouseButton2)then return
    end
    w=S.KeyCode==Config.Legit.AimbotKey or S.UserInputType==Config.Legit.AimbotKey
    if w then S=Config.Legit.AimbotEnabled
        if S then local S,w=Config.Legit.KeyMode,"Toggle"
            if S==w then Config.Legit.AimbotActive = not Config.Legit.AimbotActive
            else                 Config.Legit.AimbotActive = true
            end
        end
    end
end
getgenv().UserInputService.InputBegan:Connect(X[42])
Config.AimbotInputEnded=function(S)local w={}
    local P=S.KeyCode==Config.Legit.AimbotKey or S.UserInputType==Config.Legit.AimbotKey
    if P then local S,P=Config.Legit.KeyMode,"Hold"
        if S==P then             Config.Legit.AimbotActive = false
        end
    end
end
getgenv().UserInputService.InputEnded:Connect(X[43])
Config.IsHooking = false
X[362]=table.pack(pcall(function()local S={}
    local w=274405206
    local P=w
    local a=hookmetamethod
    w=N:Aq(P+63381960)
    local P,v,H=p,"__index",newcclosure
    w=N:Aq(w+231219159)
    local function w(E,R)local x=Config.IsHooking
        if x then local q=Config.OldIndex
            return q(E,R)
        end
        x=checkcaller()
        if x then local q=Config.OldIndex
            return q(E,R)
        end
        x=R=="Hit"or R=="Target"
        if x then local q=typeof(E)=="Instance"
            if q then Config.IsHooking=true
                local q,q,L=p,pcall(p.IsA,E,"Mouse")
                local Y=q and L and Config.Legit and Config.Legit.SilentAimEnabled
                if Y then L=CurrentLegitTarget
                    q=L and L.Character
                    if q then local q=L.Character:FindFirstChild(Config.Legit.HitPart)
                    if q then local L=R=="Hit"
                    if L then local L=q.AssemblyLinearVelocity or q.Velocity or Vector3.new(0,0,0)
                    local Y=q.CFrame+L*Config.Legit.Prediction
                    Config.IsHooking=false
                    return Y
                else local L=R=="Target"
                    if L then Config.IsHooking=false
                    return q
                end
            end
        end
    end
end
Config.IsHooking=false
end
end
x=Config.OldIndex
return x(E,R)
end
S[1]=(a(P,v,H(w)))
Config.OldIndex=S[1]
end))
X[36]=X[362][1]
X[43]=X[362][2]
X[27]=not X[36]
if X[27]then warn("Failed to hook __index:",X[43])
end
X[364]=getgenv().window
X[363]={}
X[363].Icon="L"
X[363].Name="Legit"
Config.LegitTab = (X[364]:AddTab(X[363]))
X[367]=Config.LegitTab
X[366]={}
X[366].Name="aimbot & silent"
X[366].Position="left"
Config.LegitAimbotSection = (X[367]:AddSection(X[366]))
X[370]=Config.LegitTab
X[369]={}
X[369].Name="checks & tuning"
X[369].Position="left"
Config.LegitChecksSection = (X[370]:AddSection(X[369]))
X[373]=Config.LegitTab
X[372]={}
X[372].Name="fov visualizer"
X[372].Position="right"
Config.LegitFovSection = (X[373]:AddSection(X[372]))
Config.Legit_aim_lbl = (Config.LegitAimbotSection:AddLabel("aimbot"))
Config.Legit_aim_lbl:AddToggle({
    Default = false,
    Flag = "Legit_AimbotEnabled",
    Callback = function(S)local w={}
            Config.Legit.AimbotEnabled = S
        if not S then         Config.Legit.AimbotActive = false
        end
    end,
})
Config.Legit_aim_lbl:AddKeybind({
    Default = "F",
    Flag = "Legit_AimbotKey",
    Callback = function(S)local w={}
        local P=getgenv().parseKey(S)
        if P then         Config.Legit.AimbotKey = P
        end
    end,
})
Config.Legit_keymode_lbl = (Config.LegitAimbotSection:AddLabel("aimbot mode"))
Config.Legit_keymode_lbl:AddDropdown({
    Default = "Hold",
    Values = { "Hold","Toggle" },
    Flag = "Legit_KeyMode",
    Callback = function(S)local w={}
        Config.Legit.KeyMode = S
        Config.Legit.AimbotActive = false
end
})
Config.Legit_silent_lbl = (Config.LegitAimbotSection:AddLabel("silent aim"))
Config.Legit_silent_lbl:AddToggle({
    Default = false,
    Flag = "Legit_SilentAimEnabled",
    Callback = function(S)local w={}
            Config.Legit.SilentAimEnabled = S
    end,
})
Config.Legit_hitpart_lbl = (Config.LegitAimbotSection:AddLabel("hitpart"))
Config.Legit_hitpart_lbl:AddDropdown({
    Default = "Head",
    Values = { "Head","HumanoidRootPart","UpperTorso","LowerTorso" },
    Flag = "Legit_HitPart",
    Callback = function(S)local w={}
        Config.Legit.HitPart = S
end
})
Config.Legit_smooth_lbl = (Config.LegitChecksSection:AddLabel("smoothness"))
Config.Legit_smooth_lbl:AddSlider({
    Min = 1,
    Max = 30,
    Rounding = 0,
    Default = 5,
    Flag = "Legit_Smoothness",
    Callback = function(S)local w={}
            Config.Legit.Smoothness = S
    end,
})
Config.Legit_pred_lbl = (Config.LegitChecksSection:AddLabel("prediction"))
Config.Legit_pred_lbl:AddSlider({
    Min = 0.01,
    Max = 0.3,
    Rounding = 3,
    Default = 0.135,
    Flag = "Legit_Prediction",
    Callback = function(S)local w={}
            Config.Legit.Prediction = S
    end,
})
Config.Legit_maxdist_lbl = (Config.LegitChecksSection:AddLabel("max range"))
Config.Legit_maxdist_lbl:AddSlider({
    Min = 50,
    Max = 1000,
    Rounding = 0,
    Default = 250,
    Flag = "Legit_MaxDistance",
    Callback = function(S)local w={}
            Config.Legit.MaxDistance = S
    end,
})
Config.Legit_wall_lbl = (Config.LegitChecksSection:AddLabel("wall check"))
Config.Legit_wall_lbl:AddToggle({
    Default = true,
    Flag = "Legit_WallCheck",
    Callback = function(S)local w={}
            Config.Legit.WallCheck = S
    end,
})
Config.Legit_ff_lbl = (Config.LegitChecksSection:AddLabel("forcefield check"))
Config.Legit_ff_lbl:AddToggle({
    Default = true,
    Flag = "Legit_FFCheck",
    Callback = function(S)local w={}
            Config.Legit.ForceFieldCheck = S
    end,
})
Config.Legit_death_lbl = (Config.LegitChecksSection:AddLabel("death check"))
Config.Legit_death_lbl:AddToggle({
    Default = true,
    Flag = "Legit_DeathCheck",
    Callback = function(S)local w={}
            Config.Legit.DeathCheck = S
    end,
})
Config.Legit_fov_lbl = (Config.LegitFovSection:AddLabel("show fov circle"))
Config.Legit_fov_lbl:AddToggle({
    Default = false,
    Flag = "Legit_FovVisible",
    Callback = function(S)local w={}
            Config.Legit.FovVisible = S
    end,
})
Config.Legit_fov_lbl:AddColorPicker({
    Default = Color3.fromRGB(255,255,255),
    Flag = "Legit_FovColor",
    Callback = function(S)local w={}
            Config.Legit.FovColor = S
    end,
})
Config.Legit_fovrad_lbl = (Config.LegitFovSection:AddLabel("fov radius"))
Config.Legit_fovrad_lbl:AddSlider({
    Min = 10,
    Max = 800,
    Rounding = 0,
    Default = 100,
    Flag = "Legit_FovRadius",
    Callback = function(S)local w={}
            Config.Legit.FovRadius = S
    end,
})
Config.Legit_fovfilled_lbl = (Config.LegitFovSection:AddLabel("filled circle"))
Config.Legit_fovfilled_lbl:AddToggle({
    Default = false,
    Flag = "Legit_FovFilled",
    Callback = function(S)local w={}
            Config.Legit.FovFilled = S
    end,
})
Config.Legit_fovtrans_lbl = (Config.LegitFovSection:AddLabel("fov opacity"))
Config.Legit_fovtrans_lbl:AddSlider({
    Min = 0.05,
    Max = 1,
    Rounding = 2,
    Default = 0.5,
    Flag = "Legit_FovTransparency",
    Callback = function(S)local w={}
            Config.Legit.FovTransparency = S
    end,
})
X[425]=getgenv()
X[427]=getgenv().window
X[426]={}
X[426].Icon="R"
X[426].Name="RageBot"
X[425].CombatTab = (X[427]:AddTab(X[426]))
X[429]=getgenv()
X[431]=getgenv().CombatTab
X[430]={}
X[430].Name="Combat"
X[430].Icon="crosshairs"
X[429].Combat_MainSubTab = (X[431]:AddSubTab(X[430]))
X[433]=getgenv()
X[435]=getgenv().CombatTab
X[434]={}
X[434].Name="Visuals & Audio"
X[434].Icon="eye"
X[433].Combat_VisualsSubTab = (X[435]:AddSubTab(X[434]))
X[438]=getgenv().Combat_MainSubTab
X[437]={}
X[437].Name="forcehit"
X[437].Position="left"
X[437].LayoutOrder=1
Config.ForceHitSection = (X[438]:AddSection(X[437]))
X[440]=getgenv()
X[442]=getgenv().Combat_MainSubTab
X[441]={}
X[441].Name="strafe"
X[441].Position="left"
X[441].LayoutOrder=2
X[440].StrafeSection = (X[442]:AddSection(X[441]))
X[444]=getgenv()
X[446]=getgenv().Combat_MainSubTab
X[445]={}
X[445].Name="checks"
X[445].Position="right"
X[445].LayoutOrder=1
X[444].ChecksSection = (X[446]:AddSection(X[445]))
X[448]=getgenv()
X[450]=getgenv().Combat_MainSubTab
X[449]={}
X[449].Name="kill aura"
X[449].Position="right"
X[449].LayoutOrder=2
X[448].KillAuraSection = (X[450]:AddSection(X[449]))
X[58]=function(S,w)if not S then return
    end
    local P=S.Holder or S.Frame or S.Container or S.Instance or S.Main
    S=P and P:IsA("GuiObject")
    if S then P.LayoutOrder=w
    end
end
X[58](Config.ForceHitSection,1)
X[58](getgenv().StrafeSection,2)
X[58](getgenv().ChecksSection,1)
X[58](getgenv().KillAuraSection,2)
X[452]=getgenv()
X[454]=getgenv().Combat_VisualsSubTab
X[453]={}
X[453].Name="target visuals"
X[453].Position="left"
X[452].TargetVisualsSection = (X[454]:AddSection(X[453]))
X[456]=getgenv()
X[456].ammo_ind_lbl = (getgenv().TargetVisualsSection:AddLabel("ammo counter"))
X[459]=getgenv().ammo_ind_lbl
X[459]:AddToggle({
    Default = true,
    Flag = "Visuals_ShowAmmo",
    Callback = function(S)getgenv().AmmoIndicatorConfig.Enabled=S
    end,
})
X[460]=getgenv()
X[460].ammo_pos_lbl = (getgenv().TargetVisualsSection:AddLabel("ammo position"))
X[462]={}
N:jq(X[462],0,getgenv().ammo_pos_lbl)
X[463]={}
X[463].Default="Screen Bottom"
N:jq(X[462],1,X[463],{},"Screen Bottom","Next to Gun")
X[462].n=5
X[59],X[60],X[61],X[62],X[63]=X[462][1],X[462][2],X[462][3],X[462][4],X[462][5]
N:jq(X[61],0,X[62],X[63])
X[60].Values=X[61]
X[60].Flag = "Visuals_AmmoPosition"
X[60].Callback=function(S)getgenv().AmmoIndicatorConfig.Position=S
end
X[465]=X[60]
X[59]:AddDropdown(X[465])
X[466]=getgenv()
X[468]=getgenv().Combat_VisualsSubTab
X[467]={}
X[467].Name="hit effects & chams"
X[467].Position="left"
X[466].HitEffectsSection = (X[468]:AddSection(X[467]))
X[470]=getgenv()
X[472]=getgenv().Combat_VisualsSubTab
X[471]={}
X[471].Name="bullet tracers"
X[471].Position="right"
X[470].BulletTracersSection = (X[472]:AddSection(X[471]))
X[474]=getgenv()
X[476]=getgenv().Combat_VisualsSubTab
X[475]={}
X[475].Name="audio & feedback"
X[475].Position="right"
X[474].AudioFeedbackSection = (X[476]:AddSection(X[475]))
X[478]=getgenv()
X[478].ka_enable_lbl = (getgenv().KillAuraSection:AddLabel("kill aura[BETA]"))
X[481]=getgenv().ka_enable_lbl
X[481]:AddToggle({
    Default = false,
    Flag = "KA_Enabled",
    Callback = function(S)getgenv().KillAura.Enabled=S
    end,
})
X[482]=getgenv()
X[482].ka_visuals_lbl = (getgenv().KillAuraSection:AddLabel("apply forcehit visuals"))
X[485]=getgenv().ka_visuals_lbl
X[485]:AddToggle({
    Default = false,
    Flag = "KA_ApplyForceHitVisuals",
    Callback = function(S)getgenv().KillAura.ApplyForceHitVisuals=S
    end,
})
X[486]=getgenv()
X[486].ka_whitelist_lbl = (getgenv().KillAuraSection:AddLabel("whitelist players"))
getgenv().ka_whitelist_dropdown=getgenv().ka_whitelist_lbl:AddDropdown({Default={},Multi=true,Values=getgenv().getPlayerNames(),Save=false,Callback=function(S)getgenv().KillAura.Whitelist=S
end})
X[489]=getgenv().KillAuraSection:AddLabel("aura range")
X[488]={}
X[488].Min=5
X[488].Max=250
X[488].Rounding=0
X[488].Default=50
X[488].Flag="KA_Range"
X[488].Callback=function(S)if getgenv().KillAura then getgenv().KillAura.Range=S
    end
end
X[489]:AddSlider(X[488])
X[490]=getgenv()
X[490].ka_part_lbl = (getgenv().KillAuraSection:AddLabel("hitpart"))
X[492]={}
N:jq(X[492],0,getgenv().ka_part_lbl)
X[493]={}
X[493].Default="Head"
N:jq(X[492],1,X[493],{},"Head","HumanoidRootPart","UpperTorso","LowerTorso")
X[492].n=7
X[64],X[65],X[66],X[67],X[68],X[69],X[70]=X[492][1],X[492][2],X[492][3],X[492][4],X[492][5],X[492][6],X[492][7]
N:jq(X[66],0,X[67],X[68],X[69],X[70])
X[65].Values=X[66]
X[65].Flag = "KA_HitPart"
X[65].Callback=function(S)getgenv().KillAura.HitPart=S
end
X[495]=X[65]
X[64]:AddDropdown(X[495])
X[496]=getgenv()
X[496].ka_delay_lbl = (getgenv().KillAuraSection:AddLabel("attack delay"))
X[499]=getgenv().ka_delay_lbl
X[499]:AddSlider({
    Min = 0.01,
    Max = 1,
    Rounding = 2,
    Default = 0.1,
    Flag = "KA_Delay",
    Callback = function(S)getgenv().KillAura.Delay=S
    end,
})
X[500]=getgenv()
X[500].ka_wall_lbl = (getgenv().KillAuraSection:AddLabel("wall check"))
X[503]=getgenv().ka_wall_lbl
X[503]:AddToggle({
    Default = false,
    Flag = "KA_WallCheck",
    Callback = function(S)getgenv().KillAura.WallCheck=S
    end,
})
X[504]=getgenv()
X[504].ka_ff_lbl = (getgenv().KillAuraSection:AddLabel("forcefield check"))
X[507]=getgenv().ka_ff_lbl
X[507]:AddToggle({
    Default = true,
    Flag = "KA_FFCheck",
    Callback = function(S)getgenv().KillAura.ForceFieldCheck=S
    end,
})
X[508]=getgenv()
X[508].ka_death_lbl = (getgenv().KillAuraSection:AddLabel("death check"))
X[511]=getgenv().ka_death_lbl
X[511]:AddToggle({
    Default = true,
    Flag = "KA_DeathCheck",
    Callback = function(S)getgenv().KillAura.DeathCheck=S
    end,
})
X[512]=getgenv()
X[514]=getgenv().window
X[513]={}
X[513].Name="KnifeBot"
X[513].Icon="K"
X[512].RageTab = (X[514]:AddTab(X[513]))
X[516]=getgenv()
X[518]=getgenv().RageTab
X[517]={}
X[517].Name="knifebot"
X[517].Position="left"
X[516].KnifebotSection = (X[518]:AddSection(X[517]))
X[520]=getgenv()
X[522]=getgenv().RageTab
X[521]={}
X[521].Name="glue connection"
X[521].Position="right"
X[520].GlueSection = (X[522]:AddSection(X[521]))
X[525]=getgenv().window
X[524]={}
X[524].Icon="M"
X[524].Name="Misc"
Config.MiscTab = (X[525]:AddTab(X[524]))
X[528]=Config.MiscTab
X[527]={}
X[527].Name="Movement"
X[527].Icon="person-running"
Config.Misc_MovementTab = (X[528]:AddSubTab(X[527]))
X[531]=Config.MiscTab
X[530]={}
X[530].Name="Desync"
X[530].Icon="shield-check"
Config.Misc_DesyncTab = (X[531]:AddSubTab(X[530]))
X[534]=Config.MiscTab
X[533]={}
X[533].Name="Morphs & Anims"
X[533].Icon="person"
Config.Misc_MorphsTab = (X[534]:AddSubTab(X[533]))
X[537]=Config.MiscTab
X[536]={}
X[536].Name="Automation"
X[536].Icon="gear"
Config.Misc_AutomationTab = (X[537]:AddSubTab(X[536]))
X[539]=getgenv()
X[541]=Config.Misc_MovementTab
X[540]={}
X[540].Name="movement"
X[540].Position="left"
X[539].MovementSection = (X[541]:AddSection(X[540]))
X[543]=getgenv()
X[545]=getgenv().window
X[544]={}
X[544].Icon="V"
X[544].Name="Visuals"
X[543].VisualsTab = (X[545]:AddTab(X[544]))
X[547]=getgenv()
X[549]=getgenv().VisualsTab
X[548]={}
X[548].Name="Players Esp"
X[548].Icon="eye"
X[547].Visuals_ESP_SubTab = (X[549]:AddSubTab(X[548]))
X[551]=getgenv()
X[553]=getgenv().VisualsTab
X[552]={}
X[552].Name="self visuals"
X[552].Icon="Human"
X[551].Visuals_Self_SubTab = (X[553]:AddSubTab(X[552]))
X[555]=getgenv()
X[557]=getgenv().VisualsTab
X[556]={}
X[556].Name="World Visuals"
X[556].Icon="sun"
X[555].Visuals_World_SubTab = (X[557]:AddSubTab(X[556]))
X[559]=getgenv()
X[562]=getgenv().MorphSettings
if not X[562]then X[560]={}
    X[560].CopyAppearance=true
    X[560].HasHeadless=false
    X[560].HasKorblox=false
    X[560].HasChams=false
    X[560].ChamsColor=Color3.new(1,1,1)
    X[560].SelectedUserName="None"
    X[560].SelectedUserId=nil
    X[560].DanceEnabled=false
    X[560].CurrentDanceName="None"
    X[560].CurrentDanceId=""
    X[560].LagAnimations=false
    X[560].LagIntensity=1
    X[560].SelectedAnimPack="None"
    X[561]={}
    X[561].idle="Default"
    X[561].walk="Default"
    X[561].run="Default"
    X[561].jump="Default"
    X[561].fall="Default"
    X[561].climb="Default"
    X[561].swim="Default"
    X[560].Anims=X[561]
    X[562]=X[560]
end
X[559].MorphSettings = X[562]
getgenv().DickESP=getgenv().DickESP or{SelfEnabled=false,OthersEnabled=false}
X[564]={}
N:jq(X[564],0,getgenv().MorphSettings)
X[564].n=1
Config.MorphSettings=X[564][1]
X[565]={}
N:jq(X[565],0,getgenv().DickESP)
X[565].n=1
X[72],X[73]=X[565][1],X[565][2]
X[73]=(getgenv())
X[566]={}
N:jq(X[566],0,X[73].Players)
X[566].n=1
X[74]=X[566][1]
X[567]={}
N:jq(X[567],0,getgenv().LocalPlayer,{},{},{})
X[568]={149648779,488097871,445921167,533532198,10897118438,7535880104}
N:jq(X[567],4,X[568],{})
X[567].n=6
X[75],X[76],X[77],X[78],X[79],X[80]=X[567][1],X[567][2],X[567][3],X[567][4],X[567][5],X[567][6]
X[569]={}
X[569].UserId=4912090997
X[569].UserName="amir"
X[28]=X[569]
X[570]={}
X[570].UserId=nil
X[570].UserName="random tryhard"
X[63]=X[570]
N:jq(X[80],0,X[28],X[63])
X[571]={}
X[572]={}
X[572].None=""
X[572].Floss="rbxassetid://10714340543"
X[572]["Yungblud Happier Jump"]="rbxassetid://15609995579"
X[572]["take the L"]="rbxassetid://118343267142519"
X[572].darktriad="rbxassetid://131564504226925"
N:jq(X[571],0,X[572],{})
X[571].n=2
X[81],X[82]=X[571][1],X[571][2]
for S in pairs(X[81])do table.insert(X[82],S)
end
X[573]={}
X[574]={}
X[575]={}
X[575].swim="http://www.roblox.com/asset/?id=61609998"
X[575].idle="http://www.roblox.com/asset/?id=616088211"
X[575].climb="http://www.roblox.com/asset/?id=616086039"
X[575].jump="http://www.roblox.com/asset/?id=616090535"
X[575].fall="http://www.roblox.com/asset/?id=616087089"
X[575].run="http://www.roblox.com/asset/?id=616091570"
X[575].walk="http://www.roblox.com/asset/?id=616095330"
X[574].Robot=X[575]
X[576]={}
X[576].walk="http://www.roblox.com/asset/?id=845403856"
X[576].idle="http://www.roblox.com/asset/?id=845397899"
X[576].climb="http://www.roblox.com/asset/?id=845392038"
X[576].jump="http://www.roblox.com/asset/?id=845398858"
X[576].fall="http://www.roblox.com/asset/?id=845396048"
X[576].run="http://www.roblox.com/asset/?id=845386501"
X[576].swim="http://www.roblox.com/asset/?id=845401742"
X[574].Elder=X[576]
X[577]={}
X[577].swim="http://www.roblox.com/asset/?id=891639666"
X[577].idle="http://www.roblox.com/asset/?id=891621366"
X[577].climb="http://www.roblox.com/asset/?id=891609353"
X[577].jump="http://www.roblox.com/asset/?id=891627522"
X[577].fall="http://www.roblox.com/asset/?id=891617961"
X[577].run="http://www.roblox.com/asset/?id=891636393"
X[577].walk="http://www.roblox.com/asset/?id=891636393"
X[574].Astronaut=X[577]
X[578]={}
X[578].walk="http://www.roblox.com/asset/?id=742640026"
X[578].idle="http://www.roblox.com/asset/?id=742637544"
X[578].climb="http://www.roblox.com/asset/?id=742636889"
X[578].jump="http://www.roblox.com/asset/?id=742637942"
X[578].fall="http://www.roblox.com/asset/?id=742637151"
X[578].run="http://www.roblox.com/asset/?id=742638842"
X[578].swim="http://www.roblox.com/asset/?id=742639220"
X[574].Cartoony=X[578]
X[579]={}
X[579].walk="http://www.roblox.com/asset/?id=656121766"
X[579].idle="http://www.roblox.com/asset/?id=656117400"
X[579].climb="http://www.roblox.com/asset/?id=656114359"
X[579].jump="http://www.roblox.com/asset/?id=656117878"
X[579].fall="http://www.roblox.com/asset/?id=656115606"
X[579].run="http://www.roblox.com/asset/?id=656118852"
X[579].swim="http://www.roblox.com/asset/?id=656119721"
X[574].Ninja=X[579]
X[580]={}
X[580].swim="http://www.roblox.com/asset/?id=616119360"
X[580].idle="http://www.roblox.com/asset/?id=616111295"
X[580].climb="http://www.roblox.com/asset/?id=616104706"
X[580].jump="http://www.roblox.com/asset/?id=616115533"
X[580].fall="http://www.roblox.com/asset/?id=616108001"
X[580].run="http://www.roblox.com/asset/?id=616117076"
X[580].walk="http://www.roblox.com/asset/?id=616122287"
X[574].Superhero=X[580]
X[581]={}
X[581].swim="http://www.roblox.com/asset/?id=616143378"
X[581].idle="http://www.roblox.com/asset/?id=616136790"
X[581].climb="http://www.roblox.com/asset/?id=616133594"
X[581].jump="http://www.roblox.com/asset/?id=616139451"
X[581].fall="http://www.roblox.com/asset/?id=616134815"
X[581].run="http://www.roblox.com/asset/?id=616140816"
X[581].walk="http://www.roblox.com/asset/?id=616146177"
X[574].Stylish=X[581]
N:jq(X[573],0,X[574])
X[573].n=1
X[83]=X[573][1]
X[582]={}
X[582].swim="http://www.roblox.com/asset/?id=616011509"
X[582].idle="http://www.roblox.com/asset/?id=616006778"
X[582].climb="http://www.roblox.com/asset/?id=616003713"
X[582].jump="http://www.roblox.com/asset/?id=616008936"
X[582].fall="http://www.roblox.com/asset/?id=616005863"
X[58] = X[582]
X[25]=nil
X[58].run = "http://www.roblox.com/asset/?id=616010382"
X[58].walk = "http://www.roblox.com/asset/?id=616013216"
X[83].Levitation=X[58]
X[585]={}
X[585].walk="http://www.roblox.com/asset/?id=707897309"
X[585].idle="http://www.roblox.com/asset/?id=707742142"
X[585].climb="http://www.roblox.com/asset/?id=707826056"
X[585].jump="http://www.roblox.com/asset/?id=707853694"
X[585].fall="http://www.roblox.com/asset/?id=707829716"
X[585].run="http://www.roblox.com/asset/?id=707861613"
X[585].swim="http://www.roblox.com/asset/?id=707876443"
X[83].Mage = X[585]
X[587]={}
X[587].walk="http://www.roblox.com/asset/?id=1083178339"
X[587].idle="http://www.roblox.com/asset/?id=1083195517"
X[587].climb="http://www.roblox.com/asset/?id=1083182000"
X[587].jump="http://www.roblox.com/asset/?id=1083218792"
X[587].fall="http://www.roblox.com/asset/?id=1083189019"
X[587].run="http://www.roblox.com/asset/?id=1083216690"
X[587].swim="http://www.roblox.com/asset/?id=1083222527"
X[83].Werewolf = X[587]
X[589]={}
X[589].walk="http://www.roblox.com/asset/?id=657552124"
X[589].idle="http://www.roblox.com/asset/?id=657595757"
X[589].climb="http://www.roblox.com/asset/?id=658360781"
X[589].jump="http://www.roblox.com/asset/?id=658409194"
X[589].fall="http://www.roblox.com/asset/?id=657600338"
X[589].run="http://www.roblox.com/asset/?id=657564596"
X[589].swim="http://www.roblox.com/asset/?id=657560551"
X[83].Knight = X[589]
X[591]={}
X[591].walk="http://www.roblox.com/asset/?id=750785693"
X[591].idle="http://www.roblox.com/asset/?id=750781874"
X[591].climb="http://www.roblox.com/asset/?id=750779899"
X[591].jump="http://www.roblox.com/asset/?id=750782230"
X[591].fall="http://www.roblox.com/asset/?id=750780242"
X[591].run="http://www.roblox.com/asset/?id=750783738"
X[591].swim="http://www.roblox.com/asset/?id=750784579"
X[83].Pirate = X[591]
X[593]={}
X[593].swim="http://www.roblox.com/asset/?id=782844582"
X[593].idle="http://www.roblox.com/asset/?id=782841498"
X[593].climb="http://www.roblox.com/asset/?id=782843869"
X[593].jump="http://www.roblox.com/asset/?id=782847020"
X[593].fall="http://www.roblox.com/asset/?id=782846423"
X[593].run="http://www.roblox.com/asset/?id=782842708"
X[593].walk="http://www.roblox.com/asset/?id=782843345"
X[83].Toy = X[593]
X[595]={}
X[595].walk="http://www.roblox.com/asset/?id=910034870"
X[595].idle="http://www.roblox.com/asset/?id=910004836"
X[595].climb="http://www.roblox.com/asset/?id=909997997"
X[595].jump="http://www.roblox.com/asset/?id=910016857"
X[595].fall="http://www.roblox.com/asset/?id=910001910"
X[595].run="http://www.roblox.com/asset/?id=910025107"
X[595].swim="http://www.roblox.com/asset/?id=910028158"
X[83].Bubbly = X[595]
X[597]={}
X[597].walk="http://www.roblox.com/asset/?id=1083473930"
X[597].idle="http://www.roblox.com/asset/?id=1083445855"
X[597].climb="http://www.roblox.com/asset/?id=1083439238"
X[597].jump="http://www.roblox.com/asset/?id=1083455352"
X[597].fall="http://www.roblox.com/asset/?id=1083443587"
X[597].run="http://www.roblox.com/asset/?id=1083462077"
X[597].swim="http://www.roblox.com/asset/?id=1083464683"
X[83].Vampire = X[597]
X[599]={}
X[599].swim="http://www.roblox.com/asset/?id=616165109"
X[599].idle="http://www.roblox.com/asset/?id=616158929"
X[599].climb="http://www.roblox.com/asset/?id=616156119"
X[599].jump="http://www.roblox.com/asset/?id=616161997"
X[599].fall="http://www.roblox.com/asset/?id=616157476"
X[599].run="http://www.roblox.com/asset/?id=616163682"
X[599].walk="http://www.roblox.com/asset/?id=616168032"
X[83].Zombie = X[599]
X[601]={}
X[601].jump="http://www.roblox.com/asset/?id=10921242013"
X[601].fall="http://www.roblox.com/asset/?id=180436148"
X[83].Oldschool = X[601]
X[603]={}
X[603].run="http://www.roblox.com/asset/?id=10921261968"
X[603].walk="http://www.roblox.com/asset/?id=10921269718"
X[603].jump="http://www.roblox.com/asset/?id=10921263860"
X[603].fall="http://www.roblox.com/asset/?id=10921262864"
X[83].Rthro = X[603]
X[22]={}
X[19]="Default"
N:jq(X[22],0,X[19])
for S in pairs(X[83])do table.insert(X[22],S)
end
table.sort(X[22])
X[605]={}
X[606]={}
X[607]={}
X[607].Animation1="rbxassetid://507766388"
X[607].Animation2="rbxassetid://507766666"
X[606].idle=X[607]
X[608]={}
X[608].WalkAnim="rbxassetid://507777826"
X[606].walk=X[608]
X[609]={}
X[609].RunAnim="rbxassetid://507767714"
X[606].run=X[609]
X[610]={}
X[610].JumpAnim="rbxassetid://507768783"
X[606].jump=X[610]
X[611]={}
X[611].FallAnim="rbxassetid://507767968"
X[606].fall=X[611]
X[612]={}
X[612].ClimbAnim="rbxassetid://507765000"
X[606].climb=X[612]
X[613]={}
X[613].SwimAnim="rbxassetid://913384386"
X[606].swim=X[613]
N:jq(X[605],0,X[606])
X[605].n=1
X[84]=X[605][1]
X[85]=function(S)local w={}
    w[1]={}
    X[78]=w[1]
    local P,a=ipairs,table.pack(S:GetChildren())
    for v,H in P(table.unpack(a))do v=H:IsA("ValueObject")or H:IsA("StringValue")or H:IsA("Configuration")or H:IsA("Folder")
        if v then S=X[78]
            S[H.Name]={}
            local S,P,a=ipairs,table.pack(H:GetChildren()),false
            for v,E in S(table.unpack(P))do v=E:IsA("Animation")and E.AnimationId~=""
                if v then local v=X[78]
                    v[H.Name][E.Name]=E.AnimationId
                    a=true
                end
            end
            S=not a and X[84][H.Name]
            if S then P=X[78]
                w[2]=H.Name
                w[3]=X[84][H.Name]
                P[w[2]]=w[3]
            end
        end
    end
end
X[86]=function()local S=X[75].Character
    if not S then return
    end
    local w=S:FindFirstChildOfClass("Humanoid")
    if not w or w.RigType==Enum.HumanoidRigType.R6 then return
    end
    local P=S:WaitForChild("Animate",5)
    if not P then return
    end
    S=(next(X[78]))
    if not S then X[85](P)
    end
    P.Enabled=false
    for a,a in pairs(w:GetPlayingAnimationTracks())do a:Stop()
    end
    S,w=ipairs,table.pack(P:GetChildren())
    for a,v in S(table.unpack(w))do a=v.Name
        local S=Config.MorphSettings.Anims[a]
        if S then local w=S=="Default"
            if w then local w=X[78][a]or X[84][a]
                if w then local H=pairs
                    for E,R in H(w)do local w=v:FindFirstChild(E)
                    E=w and w:IsA("Animation")
                    if E then w.AnimationId=R
                end
            end
        end
    else local w=X[83][S]
        local S=w and w[a]
        if S then local S,H=ipairs,table.pack(v:GetChildren())
            for v,E in S(table.unpack(H))do v="Animation"
                if E:IsA(v)then E.AnimationId=w[a]
                end
            end
        end
    end
end
end
task.wait(0.05)
P.Enabled=true
end
X[87]=function(S)local w=S and S:FindFirstChildOfClass("Humanoid")
    local P=w and w.Health>0 and S:FindFirstChild("HumanoidRootPart")
    return P
end
Config.ApplyHeadless=function(S)local w=S:FindFirstChild("Head")
    if w then w.Transparency=1
        S=(w:FindFirstChild("face"))
        if S then S.Transparency=1
        end
    end
end
X[89]=function(S)local w=S:FindFirstChild("Head")
    if w then w.Transparency=0
        S=(w:FindFirstChild("face"))
        if S then S.Transparency=0
        end
    end
end
X[90]=function(S)if not S then return false
    end
    local w=tostring(S)
    S=w:find("902942093")or w:find("902942096")or w:find("902942089")
    return S
end
X[91]=function(S)local w,P,a=S:FindFirstChild("RightLowerLeg"),S:FindFirstChild("RightUpperLeg"),S:FindFirstChild("RightFoot")
    S=w and not X[77].rLowerLeg
    if S then local v=not X[90](w.MeshId)and w.MeshId~=""
        if v then local v=X[77]
            v.rLowerLeg={MeshId=w.MeshId,TextureID=w.TextureID,Transparency=w.Transparency,Color=w.Color}
        end
    end
    S=P and not X[77].rUpperLeg
    if S then w=not X[90](P.TextureID)and not X[90](P.MeshId)and P.MeshId~=""
        if w then local v=X[77]
            v.rUpperLeg={MeshId=P.MeshId,TextureID=P.TextureID,Color=P.Color}
        end
    end
    w=a and not X[77].rFoot
    if w then P=not X[90](a.MeshId)and a.MeshId~=""
        if P then S=X[77]
            S.rFoot={MeshId=a.MeshId,TextureID=a.TextureID,Transparency=a.Transparency,Color=a.Color}
        end
    end
end
Config.ApplyKorblox=function(S)local w={}
    if not S then return
    end
    local P,a,v=S:FindFirstChild("RightLowerLeg"),S:FindFirstChild("RightUpperLeg"),S:FindFirstChild("RightFoot")
    if a and X[90](a.MeshId)then if P then P.Transparency=1
        end
        if v then v.Transparency=1
        end
        return
    end
    X[91](S)
    if P then w[1]="rbxassetid://902942093"
        P.MeshId=w[1]
        P.Transparency=1
    end
    if a then w[2]="rbxassetid://902942096"
        a.MeshId=w[2]
        w[3]="rbxassetid://902843398"
        a.TextureID=w[3]
        a.Transparency=0
    end
    if v then w[4]="rbxassetid://902942089"
        v.MeshId=w[4]
        v.Transparency=1
    end
end
X[93]=function(S)local w={}
    local P,a,v=S:FindFirstChild("RightLowerLeg"),S:FindFirstChild("RightUpperLeg"),S:FindFirstChild("RightFoot")
    if P then local H=X[77].rLowerLeg and X[77].rLowerLeg.MeshId~=""
        if H then w[1]=X[77].rLowerLeg.MeshId
            P.MeshId=w[1]
            w[2]=X[77].rLowerLeg.TextureID or ""
            P.TextureID=w[2]
            w[3]=X[77].rLowerLeg.Transparency or 0
            P.Transparency=w[3]
            w[4]=X[77].rLowerLeg.Color or getBodyColorForPart(S,"RightLowerLeg")
            P.Color=w[4]
        else P.Transparency=0
            w[5]=(getBodyColorForPart(S,"RightLowerLeg"))
            P.Color=w[5]
        end
    end
    if a then P=X[77].rUpperLeg and X[77].rUpperLeg.MeshId~=""
        if P then w[6]=X[77].rUpperLeg.MeshId
            a.MeshId=w[6]
            w[7]=X[77].rUpperLeg.TextureID or ""
            a.TextureID=w[7]
            w[8]=X[77].rUpperLeg.Color or getBodyColorForPart(S,"RightUpperLeg")
            a.Color=w[8]
        else w[9]=(getBodyColorForPart(S,"RightUpperLeg"))
            a.Color=w[9]
        end
    end
    if v then a=X[77].rFoot and X[77].rFoot.MeshId~=""
        if a then w[10]=X[77].rFoot.MeshId
            v.MeshId=w[10]
            w[11]=X[77].rFoot.TextureID or ""
            v.TextureID=w[11]
            w[12]=X[77].rFoot.Transparency or 0
            v.Transparency=w[12]
            w[13]=X[77].rFoot.Color or getBodyColorForPart(S,"RightFoot")
            v.Color=w[13]
        else v.Transparency=0
            w[14]=(getBodyColorForPart(S,"RightFoot"))
            v.Color=w[14]
        end
    end
end
Config.ApplyChams=function(S)local w,P,a,v,H,E,R,x,q,L,Y,r,A,K,f,C=Config.MorphSettings.ChamsColor or Color3.new(1,1,1),{},"Head","LeftFoot","LeftHand","LeftLowerArm","LeftLowerLeg","LeftUpperArm","LeftUpperLeg","LowerTorso","RightFoot","RightHand","RightLowerArm","RightLowerLeg","RightUpperArm","RightUpperLeg"
    N:jq(P,0,a,v,H,E,R,x,q,L,Y,r,A,K,f,C,"UpperTorso")
    C=ipairs
    for a,a in C(P)do q=S:FindFirstChild(a)
        v=q and q:IsA("BasePart")
        if v then q.Material=Enum.Material.ForceField
            q.Color=w
        end
    end
end
X[95]=function(S,w)local P={}
    local a=19461829
    local v=X[74]:FindFirstChild(w)
    a=N:Aq(a+7106479)
    if not v or not v.Character then return
    end
    local H=v.Character
    local E=H:FindFirstChildOfClass("Humanoid")
    v=not E
    a=N:Aq(a+354032976)
    if v then return
    end
    v=(H:FindFirstChild("Head"))
    if v then local a,R=ipairs,table.pack(H.Head:GetChildren())
        for x,x in a(table.unpack(R))do w="Decal"
            if x:IsA(w)then x:Destroy()
            end
        end
    end
    local a=false
    local R,x=pcall(function()local q=p
        local L=q:GetService("Players")
        return L:GetHumanoidDescriptionFromUserId(S)
    end)
    v=R and x
    if v then w=E and typeof(E)=="Instance"
        if w then R=pcall(function()return E.ApplyDescriptionClientServer
            end)and E.ApplyDescriptionClientServer
            if R then pcall(function()local q={}
                    E:RemoveAccessories()
                    local L=E:FindFirstChildOfClass("HumanoidDescription")or Instance.new("HumanoidDescription")
                    q[1]=x
                    q[2]="BodyTypeScale"
                    q[3]=E:FindFirstChild("BodyTypeScale")and E.BodyTypeScale.Value or x["BodyTypeScale"]
                    q[1][q[2]]=q[3]
                    q[4]=x
                    q[5]="HeadScale"
                    q[6]=E:FindFirstChild("HeadScale")and E.HeadScale.Value or x["HeadScale"]
                    q[4][q[5]]=q[6]
                    q[7]=x
                    q[8]="DepthScale"
                    q[9]=E:FindFirstChild("BodyDepthScale")and E.BodyDepthScale.Value or x["DepthScale"]
                    q[7][q[8]]=q[9]
                    q[10]=x
                    q[11]="HeightScale"
                    q[12]=E:FindFirstChild("BodyHeightScale")and E.BodyHeightScale.Value or x["HeightScale"]
                    q[10][q[11]]=q[12]
                    q[13]=x
                    q[14]="ProportionScale"
                    q[15]=E:FindFirstChild("BodyProportionScale")and E.BodyProportionScale.Value or x["ProportionScale"]
                    q[13][q[14]]=q[15]
                    q[16]=x
                    q[17]="WidthScale"
                    q[18]=E:FindFirstChild("BodyWidthScale")and E.BodyWidthScale.Value or x["WidthScale"]
                    q[16][q[17]]=q[18]
                    x:SetEmotes(L:GetEmotes())
                    L=(H:FindFirstChild("Shirt"))
                    if L then L:Destroy()
                end
                L=(H:FindFirstChild("Pants"))
                if L then L:Destroy()
                end
                L=(H:FindFirstChild("Shirt Graphic"))
                if L then L:Destroy()
                end
                E:ApplyDescriptionClientServer(x)
                a=true
            end)
        end
    end
    local q=not a
    if q then local function q()local L={}
            local Y=p
            local r=Y:GetService("Players"):CreateHumanoidModelFromDescription(x)
            if r then local x,A=pairs,table.pack(H:GetChildren())
                for K,K in x(table.unpack(A))do Y=K:IsA("Accessory")or K:IsA("Shirt")or K:IsA("Pants")or K:IsA("BodyColors")
                    if Y then K:Destroy()
                end
            end
            x=(r:FindFirstChildOfClass("BodyColors"))
            if x then x:Clone().Parent=H
            end
            x=(r:FindFirstChildOfClass("Shirt"))
            if x then x:Clone().Parent=H
            end
            A=(r:FindFirstChildOfClass("Pants"))
            if A then A:Clone().Parent=H
            end
            x,A=ipairs,table.pack(r:GetChildren())
            for Y,K in x(table.unpack(A))do Y="Accessory"
                if K:IsA(Y)then E:AddAccessory(K:Clone())
                end
            end
            A=(r:FindFirstChild("Head"))
            x=A and A:FindFirstChildOfClass("Decal")
            if x then x:Clone().Parent = (H:FindFirstChild("Head"))
            else A=(Instance.new("Decal"))
                A.Face=Enum.NormalId.Front
                L[3]="face"
                A.Name=L[3]
                L[4]="rbxasset://textures/face.png"
                A.Texture=L[4]
                L[5]=(H:FindFirstChild("Head"))
                A.Parent=L[5]
            end
            local L,Y,A,K,f,C,l,Z,h,m,M,d,c,e,j={},"LeftUpperArm","LeftLowerArm","LeftHand","RightUpperArm","RightLowerArm","RightHand","LeftUpperLeg","LeftLowerLeg","LeftFoot","RightUpperLeg","RightLowerLeg","RightFoot","UpperTorso","LowerTorso"
            N:jq(L,0,Y,A,K,f,C,l,Z,h,m,M,d,c,e,j,"Head")
            A=ipairs
            for f,f in A(L)do d,Y=r:FindFirstChild(f),H:FindFirstChild(f)
                h=d and Y
                if h then K=d:IsA("MeshPart")and Y:IsA("MeshPart")
                    if K then Y.MeshId=d.MeshId
                    Y.TextureID=d.TextureID
                end
            end
        end
        L={}
        d="Height"
        j="Width"
        e="Depth"
        A="HeadScale"
        l="Proportion"
        N:jq(L,0,d,j,e,A,l,"BodyTypeScale")
        j=(r:FindFirstChildOfClass("Humanoid"))
        if j then for K,K in ipairs(L)do x,Y=j:FindFirstChild(K),E:FindFirstChild(K)
                if x and Y then Y.Value=x.Value
                end
            end
        end
        l=(r:FindFirstChild("Animate"))
        Z=(H:FindFirstChild("Animate"))
        if l and Z then for x,x in ipairs(l:GetChildren())do M=Z:FindFirstChild(x.Name)
                if M then for L,L in ipairs(x:GetChildren())do A=M:FindFirstChild(L.Name)
                    if A then A.AnimationId=L.AnimationId
                end
            end
        end
    end
    Z.Enabled=false
    Z.Enabled=true
end
r:Destroy()
a=true
end
end
pcall(q)
end
end
w=not a
if w then local w=434219281
    R=nil
    R,w=pcall,bit32.bxor(w,14719163)
    local w,a=R(function()return X[74]:GetCharacterAppearanceAsync(S)
    end)
    v=w and a
    if v then local S,R=pairs,table.pack(H:GetChildren())
        for x,q in S(table.unpack(R))do x=q:IsA("Accessory")or q:IsA("Shirt")or q:IsA("Pants")or q:IsA("CharacterMesh")or q:IsA("BodyColors")
            if x then q:Destroy()
            end
        end
        w,R=pairs,table.pack(a:GetChildren())
        for x,q in w(table.unpack(R))do x=q:IsA("Shirt")or q:IsA("Pants")or q:IsA("BodyColors")
            if x then q.Parent=H
            else S=(q:IsA("Accessory"))
                if S then E:AddAccessory(q)
                else local w=q.Name=="R15"and E.RigType==Enum.HumanoidRigType.R15
                    if w then local w=q:FindFirstChildOfClass("CharacterMesh")
                    if w then w.Parent=H
                end
            end
        end
    end
end
R=(a:FindFirstChild("face"))
if R then a.face.Parent=H.Head
else S=(Instance.new("Decal"))
    S.Face=Enum.NormalId.Front
    P[1]="face"
    S.Name=P[1]
    P[2]="rbxasset://textures/face.png"
    S.Texture=P[2]
    S.Parent=H.Head
end
end
end
v=H.Parent
H.Parent=nil
H.Parent=v
if Config.MorphSettings.HasHeadless then Config.ApplyHeadless(H)
end
if Config.MorphSettings.HasKorblox then Config.ApplyKorblox(H)
end
if Config.MorphSettings.HasChams then Config.ApplyChams(H)
end
end
X[97]=function()local S={}
    local w=X[75].Character
    local P=not X[87](w)or Config.MorphSettings.CurrentDanceId==""
    if P then return
    end
    P=(w:FindFirstChildOfClass("Humanoid"))
    local w,a=P:FindFirstChildOfClass("Animator")or Instance.new("Animator",P),X[96]
    if a then X[96]:Stop()
        X[96]:Destroy()
    end
    a=(Instance.new("Animation"))
    S[1]=Config.MorphSettings.CurrentDanceId
    a.AnimationId=S[1]
    S[2]=(w:LoadAnimation(a))
    X[96]=S[2]
    w=X[96]
    w.Priority=Enum.AnimationPriority.Action
end
X[98]=function()local S=Config.MorphSettings.DanceEnabled and X[96]and not X[96].IsPlaying
    if S then local S=212898632
        local w=S
        local P
        P,S=pcall,N:Aq(w+38810124)
        P(function()X[96]:Play()
        end)
    end
end
X[99]=function(S,w)local P={}
    if not S then return
    end
    local a=S:FindFirstChild("LowerTorso")or S:FindFirstChild("Torso")
    if not a then return
    end
    S=(Instance.new("Model"))
    P[1]="AttachedParts_"..w.Name
    S.Name=P[1]
    S.Parent=workspace
    S.PrimaryPart=a
    P[2]=X[76]
    P[2][w]=S
    local P,v={},Instance.new("Part")
    v.Shape=Enum.PartType.Ball
    v.Size=Vector3.new(0.5,0.5,0.5)
    v.Color=Color3.fromRGB(255,255,255)
    v.Material=Enum.Material.Neon
    v.CanCollide=false
    v.Anchored=false
    v.CFrame=a.CFrame*CFrame.new(0.2,-0.6,-0.7)
    v.Parent=S
    table.insert(P,v)
    w=(Instance.new("Part"))
    w.Size=Vector3.new(0.3,0.3,6.8)
    w.Color=Color3.fromRGB(255,255,255)
    w.Material=Enum.Material.Neon
    w.CanCollide=false
    w.Anchored=false
    w.CFrame=a.CFrame*CFrame.new(0.07,-0.6,-3.9)
    w.Parent=S
    table.insert(P,w)
    v=(Instance.new("Part"))
    v.Shape=Enum.PartType.Ball
    v.Size=Vector3.new(0.5,4.5,0.5)
    v.Color=Color3.fromRGB(255,255,255)
    v.Material=Enum.Material.Neon
    v.CanCollide=false
    v.Anchored=false
    v.CFrame=a.CFrame*CFrame.new(-0.1,-0.6,-0.7)
    v.Parent=S
    table.insert(P,v)
    w=pairs
    for v,H in w(P)do v=(Instance.new("WeldConstraint"))
        v.Part0=a
        v.Part1=H
        v.Parent=H
    end
    w=(Instance.new("Highlight"))
    w.Parent=S
    w.Adornee=S
    w.FillColor=Color3.fromRGB(0,0,0)
    w.OutlineColor=Color3.fromRGB(255,255,255)
    w.FillTransparency=1
    w.OutlineTransparency=0
end
X[75].CharacterAdded:Connect(function(S)local w={}
    task.wait(1)
    w[1]={}
    w[2]={}
    X[78]=w[1]
    X[77]=w[2]
    local w=Config.MorphSettings.SelectedUserId
    if w then X[95](Config.MorphSettings.SelectedUserId,X[75].Name)
    else local P=Config.MorphSettings.SelectedUserName and Config.MorphSettings.SelectedUserName~="None"
        if P then local P
            for a,a in pairs(X[80])do if a.UserName==Config.MorphSettings.SelectedUserName then P=a.UserId
                    break
                end
            end
            if P then X[95](P,X[75].Name)
            end
        else if Config.MorphSettings.HasHeadless then Config.ApplyHeadless(S)
            end
            if Config.MorphSettings.HasKorblox then Config.ApplyKorblox(S)
            end
            if Config.MorphSettings.HasChams then Config.ApplyChams(S)
            end
        end
    end
    if Config.MorphSettings.DanceEnabled then local P=77196775
        w=P
        local a=task
        P=N:Aq(w+187251322)
        local w=a.spawn
        P=N:Aq(P+59309038)
        w(function()task.wait(0.1)
            X[97]()
            X[98]()
        end)
    end
    X[86]()
    if X[72].SelfEnabled then X[99](S,X[75])
    end
end)
if X[75].Character and X[87](X[75].Character)then task.spawn(function()task.wait(1)
        X[97]()
        X[98]()
        X[86]()
    end)
end
X[57]=Config.MiscTab
X[7]=not X[57]
if X[7]then repeat task.wait(0.5)
        X[57]=Config.MiscTab
    until X[57]
end
X[614]=getgenv()
X[616]=Config.Misc_MorphsTab
X[615]={}
X[615].Name="morphs & accessories"
X[615].Position="left"
X[614].MorphSection = (X[616]:AddSection(X[615]))
X[618]=getgenv()
X[620]=Config.Misc_MorphsTab
X[619]={}
X[619].Name="emotes & lag"
X[619].Position="left"
X[618].EmoteSection = (X[620]:AddSection(X[619]))
X[622]=getgenv()
X[624]=Config.Misc_MorphsTab
X[623]={}
X[623].Name="animation customization"
X[623].Position="right"
X[622].AnimationSection = (X[624]:AddSection(X[623]))
X[626]=getgenv()
X[628]=Config.Misc_MorphsTab
X[627]={}
X[627].Name="body parts"
X[627].Position="right"
X[626].VisualBodySection = (X[628]:AddSection(X[627]))
X[17]={}
X[30]="None"
N:jq(X[17],0,X[30])
for S,S in ipairs(X[80])do table.insert(X[17],S.UserName)
end
X[630]=getgenv()
X[630].morph_char_lbl = (getgenv().MorphSection:AddLabel("avatar changer"))
X[632]={}
N:jq(X[632],0,getgenv().morph_char_lbl)
X[633]={}
X[633].Default="None"
X[633].Values=X[17]
X[633].Flag="Morph_Presets"
N:jq(X[632],1,X[633])
X[632].n=2
X[100],X[101]=X[632][1],X[632][2]
X[101].Callback=function(S)local w={}
        Config.MorphSettings.SelectedUserName = S
    local P=S~="None"
    if P then local P
        local a="random tryhard"
        if S==a then if#X[79]>0 then P=X[79][math.random(1,#X[79])]
                                Config.MorphSettings.SelectedUserId = P
            end
        else             Config.MorphSettings.SelectedUserId = nil
            for a,a in pairs(X[80])do if a.UserName==S then P=a.UserId
                                        Config.MorphSettings.SelectedUserId = P
                    break
                end
            end
        end
        if P then X[95](P,X[75].Name)
        end
    else         Config.MorphSettings.SelectedUserId = nil
        X[95](X[75].UserId,X[75].Name)
    end
end
X[634]=X[101]
X[100]:AddDropdown(X[634])
X[635]=getgenv()
X[635].morph_headless_lbl = (getgenv().MorphSection:AddLabel("toggle headless"))
X[638]=getgenv().morph_headless_lbl
X[638]:AddToggle({
    Default = Config.MorphSettings.HasHeadless,
    Flag = "Morph_Headless",
    Callback = function(S)local w={}
            Config.MorphSettings.HasHeadless = S
        if X[75].Character then if S then Config.ApplyHeadless(X[75].Character)
            else X[89](X[75].Character)
            end
        end
    end,
})
X[639]=getgenv()
X[639].morph_korblox_lbl = (getgenv().MorphSection:AddLabel("toggle korblox"))
X[642]=getgenv().morph_korblox_lbl
X[642]:AddToggle({
    Default = Config.MorphSettings.HasKorblox,
    Flag = "Morph_Korblox",
    Callback = function(S)local w={}
            Config.MorphSettings.HasKorblox = S
        if X[75].Character then if S then Config.ApplyKorblox(X[75].Character)
            else X[93](X[75].Character)
            end
        end
    end,
})
X[643]={}
N:jq(X[643],0,getgenv().MorphSection)
X[644]={}
X[644].Name="Remove Accessories"
N:jq(X[643],1,X[644])
X[643].n=2
X[102],X[103]=X[643][1],X[643][2]
X[103].Callback=function()local S=X[75].Character
    if not S then return
    end
    local w,P=pairs,table.pack(S:GetChildren())
    for a,a in w(table.unpack(P))do S="Accessory"
        if a:IsA(S)then a:Destroy()
        end
    end
end
X[645]=X[103]
X[102]:AddButton(X[645])
X[646]=getgenv()
X[646].emote_enable_lbl = (getgenv().EmoteSection:AddLabel("enable emote"))
X[648]={}
N:jq(X[648],0,getgenv().emote_enable_lbl)
X[649]={}
X[649].Default=Config.MorphSettings.DanceEnabled
X[649].Flag="Emote_Enabled"
N:jq(X[648],1,X[649])
X[648].n=2
X[104],X[105]=X[648][1],X[648][2]
X[105].Callback=function(S)local w={}
        Config.MorphSettings.DanceEnabled = S
    if S then X[97]()
        X[98]()
    else local S=X[96]
        if S then X[96]:Stop()
        end
    end
end
X[650]=X[105]
X[104]:AddToggle(X[650])
X[651]=getgenv()
X[651].emote_select_lbl = (getgenv().EmoteSection:AddLabel("select emote"))
X[654]=getgenv().emote_select_lbl
X[654]:AddDropdown({
    Default = "None",
    Values = X[82],
    Flag = "Emote_Selection",
    Callback = function(S)local w={}
            Config.MorphSettings.CurrentDanceName = S
        Config.MorphSettings.CurrentDanceId = X[81][S]
        if Config.MorphSettings.DanceEnabled then X[97]()
            X[98]()
        end
    end,
})
X[31]={}
X[70]="idle"
X[13]="walk"
X[27]="run"
X[73]="jump"
X[36]="fall"
X[63]="climb"
X[15]="swim"
N:jq(X[31],0,X[70],X[13],X[27],X[73],X[36],X[63],X[15])
X[10]=ipairs
for S,S in X[10](X[31])do X[61]=(getgenv().AnimationSection:AddLabel(S.." style"))
    X[61]:AddDropdown({
        Default = "Default",
        Values = X[22],
        Flag = "Anim_State_"..S,
        Callback = function(w)local P={}
                P[1]=Config.MorphSettings.Anims
                P[2]=S
                P[1][P[2]]=w
                X[86]()
            end,
    })
end
X[656]=getgenv()
X[656].visual_self_lbl = (getgenv().VisualBodySection:AddLabel("dick visuals (local player)"))
X[658]={}
N:jq(X[658],0,getgenv().visual_self_lbl)
X[659]={}
X[659].Default=false
X[659].Flag="Visual_DickSelf"
N:jq(X[658],1,X[659])
X[658].n=2
X[106],X[107]=X[658][1],X[658][2]
X[107].Callback=function(S)local w={}
    w[1]=X[72]
    w[1].SelfEnabled=S
    local P=not S
    if P then S=X[76][X[75]]
        if S then X[76][X[75]]:Destroy()
            w[2]=X[76]
            w[3]=X[75]
            w[2][w[3]]=nil
        end
        return
    end
    if X[75].Character then X[99](X[75].Character,X[75])
    end
end
X[660]=X[107]
X[106]:AddToggle(X[660])
X[661]=getgenv()
X[661].visual_others_lbl = (getgenv().VisualBodySection:AddLabel("dick visuals (other players)"))
X[663]={}
N:jq(X[663],0,getgenv().visual_others_lbl)
X[664]={}
X[664].Default=false
X[664].Flag="Visual_DickOthers"
N:jq(X[663],1,X[664])
X[663].n=2
X[108],X[109]=X[663][1],X[663][2]
X[109].Callback=function(S)local w={}
    w[1]=X[72]
    w[1].OthersEnabled=S
    local P=not S
    if P then S=X[76]
        for a,v in pairs(S)do local H=a~=X[75]and v
            if H then v:Destroy()
                w[2]=X[76]
                w[2][a]=nil
            end
        end
        return
    end
    P,S=pairs,p
    local w=S:GetService("Players")
    for S,S in P(w:GetPlayers())do if S~=X[75]and S.Character then X[99](S.Character,S)
        end
    end
end
X[665]=X[109]
X[108]:AddToggle(X[665])
Config.Desync_setback = (Instance.new("Part"))
Config.Desync_setback.Name = "desyncc"
Config.Desync_setback.Size = (Vector3.new(2,2,1))
Config.Desync_setback.Anchored = true
Config.Desync_setback.CanCollide = false
Config.Desync_setback.Transparency = 1
Config.Desync_setback.Parent = workspace
pcall(function()local S=setfflag
    if S then setfflag("S2PhysicsSenderRate",1000)
    end
end)
X[676]={}
X[676].enabled=false
X[676].mode="void"
X[676].old_position=nil
X[26]=X[676]
X[26].target_position=nil
X[26].entry_position=nil
X[26].void_time=0.4
X[26].normal_time=0.133
X[26].timer=0
X[26].custom_offset = (Vector3.new(0,0,0))
X[26].tracerEnabled=false
X[26].tracerOrigin = "guns tip"
Config.Desync=X[26]
X[110] = Drawing.new("Line")
X[110].Thickness=1.5
X[110].Color = (Color3.fromRGB(255,0,0))
X[110].Visible=false
X[19]=getgenv().RunService
X[59]=function()local S={}
    local w=Config.Desync
    if not w or not w.enabled or not w.tracerEnabled or not w.target_position then S[1]=X[110]
        S[1].Visible=false
        return
    end
    local P,a=workspace.CurrentCamera,w.target_position.Position
    local v,H=P:WorldToViewportPoint(a)
    if not H then S[2]=X[110]
        S[2].Visible=false
        return
    end
    a,H=Vector2.new(0,0),w.tracerOrigin
    w=H=="mouse"
    if w then a=getgenv().UserInputService:GetMouseLocation()
    else local w=H=="center"
        if w then a=P.ViewportSize/2
        else local w=H=="guns tip"
            if w then local w=getgenv().FH_GetMuzzlePos()or getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChild("Head")and getgenv().LocalPlayer.Character.Head.Position
                if w then local H=P:WorldToViewportPoint(w)
                    a=Vector2.new(H.X,H.Y)
                else a=getgenv().UserInputService:GetMouseLocation()
                end
            end
        end
    end
    S[3]=X[110]
    S[3].From=a
    X[110].To = (Vector2.new(v.X,v.Y))
    S[6]=X[110]
    S[6].Visible=true
end
getgenv().RunService.RenderStepped:Connect(X[59])
getgenv().dToolCheckEnabled=false
getgenv().dIndicatorEnabled=false
getgenv().dIndicatorSpin=false
getgenv().dIndicatorSize=55
getgenv().dIndicatorRotation=0
getgenv().dIndicatorLastPos=nil
getgenv().Des_MasterEnabled=false
getgenv().Des_Keybind=Enum.KeyCode.V
getgenv().FakePosKey=nil
getgenv().StrafeVis={Enabled=false,Transparency=0.5,Color=Color3.fromRGB(0,140,255),Folder=nil,Connection=nil,Parts={},LastTool=nil}
getgenv().dDestroyVisualizer=function()if getgenv().StrafeVis.Connection then getgenv().StrafeVis.Connection:Disconnect()
        getgenv().StrafeVis.Connection=nil
    end
    if getgenv().StrafeVis.Folder then getgenv().StrafeVis.Folder:Destroy()
        getgenv().StrafeVis.Folder=nil
    end
    getgenv().StrafeVis.Parts={}
end
X[17]=getgenv
X[49]=function()local S={}
    local w=489493861
    local P=w
    getgenv().dDestroyVisualizer()
    local a=getgenv().LocalPlayer.Character
    if not a then return
    end
    local v=a:FindFirstChild("HumanoidRootPart")
    if not v then return
    end
    local H=Instance.new("Folder")
    S[1]="dsncvsl"
    H.Name=S[1]
    H.Parent=workspace
    getgenv().StrafeVis.Folder=H
    local S,E=ipairs,table.pack(a:GetChildren())
    w=N:Aq(P+364855777)
    for R,R in S(table.unpack(E))do a=R:IsA("BasePart")and R.Name~="HumanoidRootPart"
        if a then P=(Instance.new("Part"))
            P.Size=R.Size
            P.Anchored=true
            P.CanCollide=false
            P.CastShadow=false
            P.Material=Enum.Material.Neon
            P.Color=getgenv().StrafeVis.Color
            P.Transparency=getgenv().StrafeVis.Transparency
            P.TopSurface=Enum.SurfaceType.Smooth
            P.BottomSurface=Enum.SurfaceType.Smooth
            P.Parent=H
            local S,a=getgenv().StrafeVis.Parts,{part=P}
            a.offset,S[R]=v.CFrame:Inverse()*R.CFrame,a
        end
    end
    P=getgenv()
    w=N:Aq(w-44542013)
    local function S()local w=Config.Desync.target_position
        for a,v in pairs(getgenv().StrafeVis.Parts)do if not a.Parent or not v.part or not v.part.Parent then getgenv().StrafeVis.Parts[a]=nil
            else if w then v.part.CFrame=w*v.offset
                end
                v.part.Color=getgenv().StrafeVis.Color
                v.part.Transparency=getgenv().StrafeVis.Enabled and getgenv().StrafeVis.Transparency or 1
            end
        end
    end
    P.StrafeVis.Connection=getgenv().RunService.RenderStepped:Connect(S)
end
X[681]=X[17]()
X[681].dCreateVisualizer=X[49]
getgenv().REFRESH_COOLDOWN=0.04
getgenv().FORCE_REFRESH_EVERY=0.04
getgenv().dLastAttempt=0
getgenv().dLastFullCreate=0
X[36]=getgenv
X[102]=function()if not getgenv().StrafeVis.Enabled then return
    end
    local S=tick()
    if S-getgenv().dLastAttempt<getgenv().REFRESH_COOLDOWN then return
    end
    getgenv().dLastAttempt=S
    local w=S-getgenv().dLastFullCreate>=getgenv().FORCE_REFRESH_EVERY
    local P=not w
    if P then local P=getgenv().LocalPlayer.Character
        if P then local a=P:FindFirstChildWhichIsA("Tool")
            if a~=getgenv().StrafeVis.LastTool then getgenv().StrafeVis.LastTool=a
                w=true
            end
        end
    end
    if w then getgenv().dCreateVisualizer()
        getgenv().dLastFullCreate=S
    else for S,S in pairs(getgenv().StrafeVis.Parts)do if S.part and S.part.Parent then S.part.Color=getgenv().StrafeVis.Color
                S.part.Transparency=getgenv().StrafeVis.Transparency
            end
        end
    end
end
X[682]=X[36]()
X[682].dTryUpdateVisualizer=X[102]
X[59]=getgenv
X[18]=function(S)local w=10543096
    local P=w
    local a=not S
    w=bit32.bxor(P,263691834)
    if a then return
    end
    P=nil
    P,w=S.ChildAdded,N:Aq(bit32.band(1064032511,w)+bit32.band(1064032511,11436240)+(bit32.band(2166902274,(bit32.bor(w,11436240)))+bit32.band(1064032512,(bit32.bxor(w,11436240)))))
    P:Connect(function(w)local P=w:IsA("Tool")or w:IsA("Accessory")
        if P then task.delay(0.03,getgenv().dTryUpdateVisualizer)
        end
    end)
    local function w(P)local a=P:IsA("Tool")or P:IsA("Accessory")
        if a then task.delay(0.03,getgenv().dTryUpdateVisualizer)
        end
    end
    S.ChildRemoved:Connect(w)
end
X[683]=X[59]()
X[683].dSetupVisualizerListeners=X[18]
task.spawn(function()while true do task.wait(0.033)
        getgenv().dTryUpdateVisualizer()
    end
end)
X[15]=getgenv
X[26]=X[15]().LocalPlayer
X[42]=function(S)task.wait(0.15)
    if getgenv().StrafeVis.Enabled then getgenv().dCreateVisualizer()
        getgenv().StrafeVis.LastTool=nil
        getgenv().dLastFullCreate=tick()
        getgenv().dSetupVisualizerListeners(S)
    end
end
X[26].CharacterAdded:Connect(X[42])
getgenv().dResetCamera=function()local S=getgenv().LocalPlayer.Character
    local w=S and S:FindFirstChild("Humanoid")
    if w then workspace.CurrentCamera.CameraSubject=S.Humanoid
    end
end
Config.SetDesync=function(S)local w={}
        Config.Desync.enabled = S
    local P=getgenv().LocalPlayer.Character
    local a,v=P and P:FindFirstChild("HumanoidRootPart"),not S
    if v then getgenv().dResetCamera()
                Config.Desync.timer = 0
                Config.Desync.target_position = nil
        Config.Desync_setback.CFrame = (CFrame.new(0,-2000,0))
        if Config.DesyncIndicatorImage then             Config.DesyncIndicatorImage.Visible = false
        end
        getgenv().dIndicatorRotation=0
        getgenv().dIndicatorLastPos=nil
        Config.Desync.last_disabled_time = (tick())
        P=Config.Desync.mode=="Anti Connection"and Config.Desync.entry_position
        if P then if a then w[9]=Config.Desync.entry_position+Vector3.new(0,1.5,0)
                a.CFrame=w[9]
                a.AssemblyLinearVelocity=Vector3.new(0,0,0)
                a.AssemblyAngularVelocity=Vector3.new(0,0,0)
            end
        end
                Config.Desync.entry_position = nil
    else local S,P=Config.Desync.mode,"Anti Connection"
        if S==P then if a then Config.Desync.entry_position = Config.Desync.entry_position_tracker or a.CFrame
            end
        end
    end
end
X[684]=getgenv()
X[684].setDesync = Config.SetDesync
X[14]=getgenv
X[9]=X[14]().RunService
X[106]=function(S)local w={}
    local P=Config.Desync
    local a=not P.enabled
    if a then local v=P.mode=="Anti Connection"and P.entry_position
        if v then local H=getgenv().LocalPlayer.Character
            local E=H and H:FindFirstChild("HumanoidRootPart")
            if E then E.CFrame=P.entry_position+Vector3.new(0,1.5,0)
                E.AssemblyLinearVelocity=Vector3.new(0,0,0)
                E.AssemblyAngularVelocity=Vector3.new(0,0,0)
            end
            P.entry_position=nil
        end
        v=P.mode=="Anti Connection"and tick()-(P.last_disabled_time or 0)>0.5
        if v then local v=getgenv().LocalPlayer.Character
            local H,E=v and v:FindFirstChild("HumanoidRootPart"),v and v:FindFirstChildOfClass("Humanoid")
            if H and E and E.FloorMaterial~=Enum.Material.Air then P.entry_position_tracker=H.CFrame
            end
        end
        P.target_position=nil
        return
    end
    a=getgenv().LocalPlayer.Character
    if not a then return
    end
    local v=a:FindFirstChild("HumanoidRootPart")
    if not v then return
    end
    local H=getgenv().dToolCheckEnabled and a:FindFirstChildWhichIsA("Tool")
    if H then local E=P.mode=="Anti Connection"and P.entry_position
        if E then v.CFrame=P.entry_position
            v.AssemblyLinearVelocity=Vector3.new(0,0,0)
            v.AssemblyAngularVelocity=Vector3.new(0,0,0)
            P.entry_position=nil
        end
        P.target_position=nil
        getgenv().dResetCamera()
        Config.Desync_setback.CFrame = (CFrame.new(0,-2000,0))
        return
    end
    if v.AssemblyLinearVelocity.Magnitude<0.1 then v.AssemblyLinearVelocity=Vector3.new(0,0.05,0)
    end
    P.old_position=v.CFrame
    local E,R=P.old_position,P.mode=="void"
    if R then E=CFrame.new(v.Position+Vector3.new(math.random(-900000000,900000000),math.random(100000000,900000000),math.random(-900000000,900000000)))
    else H=P.mode=="spam void"
        if H then P.timer=P.timer+S
            E=if P.timer<P.void_time then CFrame.new(v.Position+Vector3.new(math.random(-900000000,900000000),math.random(100000000,900000000),math.random(-900000000,900000000)))else E
                if P.timer>=P.void_time+P.normal_time then P.timer=0
                end
            else local S=P.mode=="Epilepsy"
                if S then E=math.floor(tick()*60)%2==0 and CFrame.new(v.Position+Vector3.new(2147483647,2147483647,2147483647))or CFrame.new(v.Position+Vector3.new(-2147483647,-2147483647,-2147483647))
                else local S=P.mode=="Custom"
                    if S then E=P.old_position+P.custom_offset
                else local S=P.mode=="Underground"
                    if S then E=CFrame.new(v.Position-Vector3.new(0,6,0))*CFrame.Angles(1.5707963267948966,0,0)
                else local S=P.mode=="Anti Connection"
                    if S then local S,H=ipairs,table.pack(a:GetChildren())
                    for a,R in S(table.unpack(H))do a="BasePart"
                    if R:IsA(a)then R.CanCollide=false
                end
            end
            S=sethiddenproperty
            if S then pcall(sethiddenproperty,v,"PhysicsRepRootPart",v)
            end
            if v.AssemblyLinearVelocity.Y<-20 then v.AssemblyLinearVelocity=Vector3.new(v.AssemblyLinearVelocity.X,0,v.AssemblyLinearVelocity.Z)
            end
            v.AssemblyAngularVelocity=Vector3.new(0.0,0.0,0.0)
            E=CFrame.new(v.Position+Vector3.new(0,5000,0))
        end
    end
end
end
end
end
P.target_position=E
getgenv().dIndicatorLastPos=E.Position
v.CFrame=E
Config.Desync_setback.CFrame = P.old_position
workspace.CurrentCamera.CameraSubject = Config.Desync_setback
getgenv().RunService.RenderStepped:Wait()
v.CFrame=P.old_position
Config.Desync_setback.CFrame = (CFrame.new(0,-2000,0))
getgenv().dResetCamera()
end
X[9].Heartbeat:Connect(X[106])
getgenv().des_keybind_conn=getgenv().des_keybind_conn or{}
if getgenv().des_keybind_conn.InputBegan then getgenv().des_keybind_conn.InputBegan:Disconnect()
end
getgenv().des_keybind_conn.InputBegan=getgenv().UserInputService.InputBegan:Connect(function(S,w)if w then return
    end
    if not S.KeyCode or S.KeyCode==Enum.KeyCode.Unknown or S.KeyCode==Enum.KeyCode.None then return
    end
    if getgenv().Des_Keybind and S.KeyCode==getgenv().Des_Keybind then if getgenv().Des_MasterEnabled then getgenv().setDesync(not Config.Desync.enabled)
        end
    end
    w=getgenv().FakePosKey and S.KeyCode==getgenv().FakePosKey
    if w then S=getgenv().FakePosToggleEnabled
        if S then getgenv().PhysicsRepDesyncEnabled=not getgenv().PhysicsRepDesyncEnabled
            local S=not getgenv().PhysicsRepDesyncEnabled
            if S then local S=p
                local w=S:GetService("Players").LocalPlayer.Character
                S=w and w:FindFirstChild("HumanoidRootPart")
                w=S and sethiddenproperty
                if w then pcall(sethiddenproperty,S,"PhysicsRepRootPart",S)
                end
            end
        end
    end
end)
if getgenv().LocalPlayer.Character then task.delay(0.1,function()getgenv().dSetupVisualizerListeners(getgenv().LocalPlayer.Character)
    end)
end
X[108]=Config.MiscTab
if not X[108]then repeat task.wait(0.5)
        X[108]=Config.MiscTab
    until X[108]
end
X[686]=getgenv()
X[686].des_section_lbl = Config.MiscTab
if not getgenv().des_section_lbl then repeat task.wait(0.5)
        X[688]=getgenv()
        X[688].des_section_lbl = Config.MiscTab
    until getgenv().des_section_lbl
end
X[691]=Config.Misc_DesyncTab
X[690]={}
X[690].Name="desync main"
X[690].Position="left"
Config.DesyncMainSection = (X[691]:AddSection(X[690]))
X[693]=getgenv()
X[693].des_enable_lbl = (Config.DesyncMainSection:AddLabel("enable desync"))
X[696]=getgenv().des_enable_lbl
X[696]:AddToggle({
    Default = false,
    Flag = "Des_Enabled",
    Callback = function(S)getgenv().Des_MasterEnabled=S
        if not S then getgenv().setDesync(false)
        end
    end,
})
X[698]=getgenv().des_enable_lbl
X[698]:AddKeybind({
    Default = "V",
    Flag = "Des_Keybind",
    Callback = function(S)local w=getgenv().parseKey(S)
        if w then getgenv().Des_Keybind=w
        end
    end,
})
X[699]=getgenv()
X[699].des_method_lbl = (Config.DesyncMainSection:AddLabel("desync mode"))
X[701]={}
N:jq(X[701],0,getgenv().des_method_lbl)
X[702]={}
X[702].Default="void"
N:jq(X[701],1,X[702],{},"void","spam void","Epilepsy","Custom","Underground","Anti Connection")
X[701].n=9
X[111],X[112],X[113],X[114],X[115],X[116],X[117],X[118],X[119]=X[701][1],X[701][2],X[701][3],X[701][4],X[701][5],X[701][6],X[701][7],X[701][8],X[701][9]
N:jq(X[113],0,X[114],X[115],X[116],X[117],X[118],X[119])
X[112].Values=X[113]
X[112].Flag = "Des_Method"
X[112].Callback=function(S)local w={}
        Config.Desync.mode = S
end
X[704]=X[112]
X[111]:AddDropdown(X[704])
getgenv().PhysicsRepDesyncEnabled=false
X[64]=getgenv
X[51]=function(S,w)if not sethiddenproperty or not S then return
    end
    local P=getgenv().PhysicsRepDesyncEnabled and S or w
    pcall(sethiddenproperty,S,"PhysicsRepRootPart",P)
end
X[705]=X[64]()
X[705].SetPhysicsRepRootPart=X[51]
pcall(function()setfflag("S2PhysicsSenderRate",1000)
end)
X[706]={}
N:jq(X[706],0,0,false)
X[706].n=2
X[120],X[121]=X[706][1],X[706][2]
task.spawn(function()while task.wait(0.004166666666666667)do if not getgenv().PhysicsRepDesyncEnabled then continue
        end
        local S=p
        local w=S:GetService("Players").LocalPlayer.Character
        if not w then continue
        end
        S=(w:FindFirstChild("HumanoidRootPart"))
        if not S or not sethiddenproperty then continue
        end
        w=X[121]
        if w then continue
        end
        w=X[120]<=0
        if w then X[121]=true
            local w=S.Position
            pcall(sethiddenproperty,S,"PhysicsRepRootPart",nil)
            task.wait(0.1)
            local P=S.Position
            pcall(sethiddenproperty,S,"PhysicsRepRootPart",S)
            if(P-w).Magnitude>10 then getgenv().FakePosServerPos=P
            end
            X[121]=false
            X[120]=20
        else local w=X[120]
            local P=1
            X[120]=w-P
            pcall(sethiddenproperty,S,"PhysicsRepRootPart",S)
        end
    end
end)
X[707]=getgenv()
X[709]=getgenv().FakePosVis
if not X[709]then X[708]={}
    X[708].TracerEnabled=false
    X[708].TracerColor=Color3.fromRGB(255,100,0)
    X[708].TracerThickness=1.5
    X[708].TracerOrigin="center"
    X[708].BillboardEnabled=false
    X[708].BillboardColor=Color3.fromRGB(255,100,0)
    X[709]=X[708]
end
X[707].FakePosVis = X[709]
X[108]=p
X[711]="Players"
X[106]=X[108]:GetService(X[711]).LocalPlayer.Character
X[713]=X[106]
if X[713]then X[712]="HumanoidRootPart"
    X[713]=X[106]:FindFirstChild(X[712])
end
X[104]=X[713]
if X[104]then X[714]=getgenv()
    X[714].FakePosServerPos = X[104].Position
end
X[122] = Drawing.new("Line")
X[122].Thickness=1.5
X[122].Color = (Color3.fromRGB(255,100,0))
X[122].Visible=false
X[68]=getgenv().RunService
X[26]=function()local S={}
    local w=getgenv().FakePosVis
    if not w then S[1]=X[122]
        S[1].Visible=false
        return
    end
    local P,a=workspace.CurrentCamera,p
    local v=a:GetService("Players").LocalPlayer
    a=v and v.Character
    v=a and a:FindFirstChild("HumanoidRootPart")
    if not getgenv().PhysicsRepDesyncEnabled or not v or not getgenv().FakePosServerPos then S[2]=X[122]
        S[2].Visible=false
        return
    end
    v=getgenv().FakePosServerPos
    local H,E=P:WorldToViewportPoint(v)
    v=w.TracerEnabled
    if v then local v=not E
        if v then S[3]=X[122]
            S[3].Visible=false
        else local v,E=Vector2.new(0,0),w.TracerOrigin
            local R=E=="mouse"
            if R then v=getgenv().UserInputService:GetMouseLocation()
            else local R=E=="center"
                if R then v=P.ViewportSize/2
                else local R=E=="guns tip"
                    if R then local E=getgenv().FH_GetMuzzlePos and getgenv().FH_GetMuzzlePos()or a and a:FindFirstChild("Head")and a.Head.Position
                    if E then local a=P:WorldToViewportPoint(E)
                    v=Vector2.new(a.X,a.Y)
                else v=getgenv().UserInputService:GetMouseLocation()
                end
            end
        end
    end
    S[4]=X[122]
    S[4].From=v
    X[122].To = (Vector2.new(H.X,H.Y))
    X[122].Color = w.TracerColor
    X[122].Thickness = w.TracerThickness
    S[11]=X[122]
    S[11].Visible=true
end
else S[12]=X[122]
S[12].Visible=false
end
end
X[68].RenderStepped:Connect(X[26])
X[718]=getgenv()
X[718].phys_desync_lbl = (Config.DesyncMainSection:AddLabel("Fake Position"))
X[720]={}
N:jq(X[720],0,getgenv().phys_desync_lbl)
X[721]={}
X[721].Default=false
X[721].Flag="fakepos"
N:jq(X[720],1,X[721])
X[720].n=2
X[123],X[124]=X[720][1],X[720][2]
X[124].Callback=function(S)getgenv().FakePosToggleEnabled=S
    getgenv().PhysicsRepDesyncEnabled=S
    local w=p
    local P=w:GetService("Players").LocalPlayer.Character
    w=P and P:FindFirstChild("HumanoidRootPart")
    if S then if w then getgenv().FakePosServerPos=w.Position
        end
    else getgenv().FakePosServerPos=nil
        P=w and sethiddenproperty
        if P then pcall(sethiddenproperty,w,"PhysicsRepRootPart",w)
        end
    end
end
X[722]=X[124]
X[123]:AddToggle(X[722])
X[724]=getgenv().phys_desync_lbl
X[724]:AddKeybind({
    Default = "None",
    Flag = "FakePos_Keybind",
    Callback = function(S)local w=getgenv().parseKey(S)
        if w then getgenv().FakePosKey=w
        end
    end,
})
X[725]=getgenv()
X[727]=Config.Misc_DesyncTab
X[726]={}
X[726].Name="fake position visuals"
X[726].Position="right"
X[725].FakePosVisualSection = (X[727]:AddSection(X[726]))
X[729]=getgenv()
X[729].fp_tracer_lbl = (getgenv().FakePosVisualSection:AddLabel("server pos tracer"))
X[732]=getgenv().fp_tracer_lbl
X[732]:AddToggle({
    Default = false,
    Flag = "FakePos_TracerEnabled",
    Callback = function(S)getgenv().FakePosVis.TracerEnabled=S
    end,
})
X[54]=nil
X[54]=(getgenv())
X[54].fp_tracer_lbl:AddColorPicker({
    Default = Color3.fromRGB(255,100,0),
    Flag = "FakePos_TracerColor",
    Callback = function(S)getgenv().FakePosVis.TracerColor=S
    end,
})
X[735]=getgenv()
X[735].fp_tracer_thick_lbl = (getgenv().FakePosVisualSection:AddLabel("tracer thickness"))
X[738]=getgenv().fp_tracer_thick_lbl
X[738]:AddSlider({
    Min = 0.5,
    Max = 5,
    Rounding = 1,
    Default = 1.5,
    Flag = "FakePos_TracerThickness",
    Callback = function(S)getgenv().FakePosVis.TracerThickness=S
    end,
})
X[739]=getgenv()
X[739].fp_tracer_origin_lbl = (getgenv().FakePosVisualSection:AddLabel("tracer origin"))
X[741]={}
N:jq(X[741],0,getgenv().fp_tracer_origin_lbl)
X[742]={}
X[742].Default="center"
N:jq(X[741],1,X[742],{},"center","mouse","guns tip")
X[741].n=6
X[125],X[126],X[127],X[128],X[129],X[130]=X[741][1],X[741][2],X[741][3],X[741][4],X[741][5],X[741][6]
N:jq(X[127],0,X[128],X[129],X[130])
X[126].Values=X[127]
X[126].Flag = "FakePos_TracerOrigin"
X[126].Callback=function(S)getgenv().FakePosVis.TracerOrigin=S
end
X[744]=X[126]
X[125]:AddDropdown(X[744])
X[745]=getgenv()
X[745].fp_billboard_lbl = (getgenv().FakePosVisualSection:AddLabel("server pos indicator"))
X[748]=getgenv().fp_billboard_lbl
X[748]:AddToggle({
    Default = false,
    Flag = "FakePos_BillboardEnabled",
    Callback = function(S)getgenv().ServerPositionIndicatorConfig=getgenv().ServerPositionIndicatorConfig or{}
        getgenv().ServerPositionIndicatorConfig.FakePosEnabled=S
        local w,P=getgenv().ServerPositionIndicatorConfig,S or(getgenv().ServerPositionIndicatorConfig.DesyncEnabled or false)
        w.Enabled=P or(getgenv().ServerPositionIndicatorConfig.GlueEnabled or false)
        if not getgenv().ServerPositionIndicatorConfig.Enabled and getgenv().SV_SetVisibility then getgenv().SV_SetVisibility(false)
        end
    end,
})
X[750]=getgenv().fp_billboard_lbl
X[750]:AddColorPicker({
    Default = Color3.fromRGB(255,100,0),
    Flag = "FakePos_BillboardColor",
    Callback = function(S)getgenv().ServerPositionIndicatorConfig=getgenv().ServerPositionIndicatorConfig or{}
        getgenv().ServerPositionIndicatorConfig.Color=S
        if getgenv().SV_Circle then getgenv().SV_Circle.Color=S
        end
    end,
})
X[751]=getgenv()
X[751].des_toolcheck_lbl = (Config.DesyncMainSection:AddLabel("disable on tool"))
X[754]=getgenv().des_toolcheck_lbl
X[754]:AddToggle({
    Default = false,
    Flag = "Des_ToolCheck",
    Callback = function(S)getgenv().dToolCheckEnabled=S
    end,
})
X[755]=getgenv()
X[755].des_voidtime_lbl = (Config.DesyncMainSection:AddLabel("void time"))
X[758]=getgenv().des_voidtime_lbl
X[758]:AddSlider({
    Min = 0.05,
    Max = 2,
    Rounding = 2,
    Default = 0.4,
    Flag = "Des_VoidTime",
    Callback = function(S)local w={}
            Config.Desync.void_time = S
    end,
})
X[759]=getgenv()
X[759].des_normaltime_lbl = (Config.DesyncMainSection:AddLabel("ground time"))
X[762]=getgenv().des_normaltime_lbl
X[762]:AddSlider({
    Min = 0.05,
    Max = 2,
    Rounding = 2,
    Default = 0.133,
    Flag = "Des_NormalTime",
    Callback = function(S)local w={}
            Config.Desync.normal_time = S
    end,
})
X[764]=Config.Misc_DesyncTab
X[763]={}
X[763].Name="desync visuals"
X[763].Position="right"
Config.DesyncVisualSection = (X[764]:AddSection(X[763]))
X[766]=getgenv()
X[766].des_rig_lbl = (Config.DesyncVisualSection:AddLabel("rig visualizer"))
X[769]=getgenv().des_rig_lbl
X[769]:AddToggle({
    Default = false,
    Flag = "Des_Rig",
    Callback = function(S)getgenv().StrafeVis.Enabled=S
        if S then getgenv().dCreateVisualizer()
            getgenv().StrafeVis.LastTool=nil
            getgenv().dLastFullCreate=tick()
            if getgenv().LocalPlayer.Character then getgenv().dSetupVisualizerListeners(getgenv().LocalPlayer.Character)
            end
        else getgenv().dDestroyVisualizer()
        end
    end,
})
X[771]=getgenv().des_rig_lbl
X[771]:AddColorPicker({
    Default = Color3.fromRGB(0,140,255),
    Flag = "Des_RigColor",
    Callback = function(S)getgenv().StrafeVis.Color=S
        getgenv().dTryUpdateVisualizer()
    end,
})
X[772]=getgenv()
X[772].des_rigtrans_lbl = (Config.DesyncVisualSection:AddLabel("rig transparency"))
X[775]=getgenv().des_rigtrans_lbl
X[775]:AddSlider({
    Min = 0,
    Max = 1,
    Rounding = 2,
    Default = 0.5,
    Flag = "Des_RigTrans",
    Callback = function(S)getgenv().StrafeVis.Transparency=S
        getgenv().dTryUpdateVisualizer()
    end,
})
X[17]=nil
X[130]=nil
X[17]=(getgenv())
X[130]=Config.DesyncVisualSection
X[776]="desync tracer"
X[17].des_tracer_lbl = (X[130]:AddLabel(X[776]))
X[779]=getgenv().des_tracer_lbl
X[779]:AddToggle({
    Default = false,
    Flag = "Des_TracerEnabled",
    Callback = function(S)local w={}
            Config.Desync.tracerEnabled = S
    end,
})
X[781]=getgenv().des_tracer_lbl
X[781]:AddColorPicker({
    Default = Color3.fromRGB(255,0,0),
    Flag = "Des_TracerColor",
    Callback = function(S)local w={}
        w[1]=X[110]
        w[1].Color=S
    end,
})
X[782]=getgenv()
X[782].des_tracer_origin_lbl = (Config.DesyncVisualSection:AddLabel("tracer origin"))
X[784]={}
N:jq(X[784],0,getgenv().des_tracer_origin_lbl)
X[785]={}
X[785].Default="guns tip"
N:jq(X[784],1,X[785],{},"guns tip","mouse","center")
X[784].n=6
X[131],X[132],X[133],X[134],X[135],X[136]=X[784][1],X[784][2],X[784][3],X[784][4],X[784][5],X[784][6]
N:jq(X[133],0,X[134],X[135],X[136])
X[132].Values=X[133]
X[132].Flag = "Des_TracerOrigin"
X[132].Callback=function(S)local w={}
        Config.Desync.tracerOrigin = S
end
X[787]=X[132]
X[131]:AddDropdown(X[787])
getgenv().ServerPositionIndicatorConfig=getgenv().ServerPositionIndicatorConfig or{Enabled=false,DesyncEnabled=false,GlueEnabled=false,FakePosEnabled=false,Smooth=true,Color=Color3.fromRGB(78,127,252),IconColor=Color3.fromRGB(255,255,255),GlowColor=Color3.fromRGB(0,0,0),Transparency=0.8,Offset=Vector3.new(0,0.5,0)}
X[788]=getgenv()
X[788].des_ind_lbl = (Config.DesyncVisualSection:AddLabel("server pos indicator"))
X[791]=getgenv().des_ind_lbl
X[791]:AddToggle({
    Default = false,
    Flag = "Des_Indicator",
    Callback = function(S)getgenv().ServerPositionIndicatorConfig.DesyncEnabled=S
        getgenv().ServerPositionIndicatorConfig.Enabled=S or getgenv().ServerPositionIndicatorConfig.GlueEnabled
        if not getgenv().ServerPositionIndicatorConfig.Enabled and getgenv().SV_SetVisibility then getgenv().SV_SetVisibility(false)
        end
    end,
})
X[792]=getgenv()
X[792].des_ind_smooth_lbl = (Config.DesyncVisualSection:AddLabel("smooth tracking"))
X[795]=getgenv().des_ind_smooth_lbl
X[795]:AddToggle({
    Default = getgenv().ServerPositionIndicatorConfig.Smooth,
    Flag = "Des_IndicatorSmooth",
    Callback = function(S)getgenv().ServerPositionIndicatorConfig.Smooth=S
        getgenv().SV_LastPos=nil
    end,
})
X[797]=Config.Misc_DesyncTab
X[796]={}
X[796].Name="custom offsets"
X[796].Position="left"
Config.DesyncOffsetSection = (X[797]:AddSection(X[796]))
X[799]=getgenv()
X[799].des_offsetx_lbl = (Config.DesyncOffsetSection:AddLabel("offset x"))
X[802]=getgenv().des_offsetx_lbl
X[802]:AddSlider({
    Min = -25,
    Max = 25,
    Rounding = 1,
    Default = 0,
    Flag = "Des_OffsetX",
    Callback = function(S)local w=Config.Desync
        w.custom_offset=Vector3.new(S,w.custom_offset.Y,w.custom_offset.Z)
    end,
})
X[803]=getgenv()
X[803].des_offsety_lbl = (Config.DesyncOffsetSection:AddLabel("offset y"))
X[806]=getgenv().des_offsety_lbl
X[806]:AddSlider({
    Min = -25,
    Max = 25,
    Rounding = 1,
    Default = 0,
    Flag = "Des_OffsetY",
    Callback = function(S)local w=Config.Desync
        w.custom_offset=Vector3.new(w.custom_offset.X,S,w.custom_offset.Z)
    end,
})
X[807]=getgenv()
X[807].des_offsetz_lbl = (Config.DesyncOffsetSection:AddLabel("offset z"))
X[810]=getgenv().des_offsetz_lbl
X[810]:AddSlider({
    Min = -25,
    Max = 25,
    Rounding = 1,
    Default = 0,
    Flag = "Des_OffsetZ",
    Callback = function(S)local w=Config.Desync
        w.custom_offset=Vector3.new(w.custom_offset.X,w.custom_offset.Y,S)
    end,
})
X[811]=getgenv()
X[813]=Config.MiscTab
X[812]={}
X[812].Name="extra options"
X[812].Position="right"
X[811].UtilitySection = (X[813]:AddSection(X[812]))
X[815]={}
X[815].CFrameSpeedEnabled=false
X[815].CFrameSpeedActive=false
X[815].CFrameSpeed=2
X[815].CFrameSpeedKey=nil
X[815].CFrameFlyEnabled=false
X[815].CFrameFlyActive=false
X[815].CFrameFlySpeed=50
X[815].CFrameFlyKey=nil
X[815].AutoEat=false
X[815].DontForceTool=false
X[815].AntiStomp=false
X[815].FastStomp=false
X[815].PingSpoofEnabled=false
X[815].PingValue=300
X[815].PlatformSpoof="None"
X[815].AutoBuyFood=false
X[815].AutoBuyInterval=3
Config.Misc = X[815]
getgenv().BypassExhaustionConfig={Enabled=false,JumpHeightValue=7.2}
X[137]=function(S)if not S then return
    end
    local w=S:WaitForChild("Humanoid",5)
    if not w then return
    end
    if getgenv().BypassExhaustionConfig.Enabled then w.UseJumpPower=false
        w.JumpHeight=getgenv().BypassExhaustionConfig.JumpHeightValue
    else w.UseJumpPower=true
    end
end
X[138]=function(S)local w=515639540
    local P=w
    if not S then return
    end
    local a=S:WaitForChild("Humanoid",5)
    w=bit32.bxor(P,309333035)
    S=not a
    w=N:Aq(bit32.band(171287012,w)+bit32.band(171287012,438008791)+(bit32.band(3952393272,(bit32.bor(w,438008791)))+bit32.band(171287013,(bit32.bxor(w,438008791)))))
    if S then return
    end
    P="PlatformStand"
    S=function()if a.PlatformStand then a.PlatformStand=false
        end
    end
    a:GetPropertyChangedSignal(P):Connect(S)
    a.PlatformStand=false
end
X[54]=nil
X[54]=(getgenv())
X[136]=X[54].LocalPlayer
X[100]=function(S)X[137](S)
    X[138](S)
end
X[136].CharacterAdded:Connect(X[100])
if getgenv().LocalPlayer.Character then X[137](getgenv().LocalPlayer.Character)
    X[138](getgenv().LocalPlayer.Character)
end
X[817]={}
X[818]={W=false,A=false,S=false,D=false,Space=false,LeftShift=false}
N:jq(X[817],0,X[818])
X[817].n=1
X[139]=X[817][1]
X[819]={}
X[820]={}
X[820][Enum.KeyCode.W]="W"
X[820][Enum.KeyCode.A]="A"
X[820][Enum.KeyCode.S]="S"
X[820][Enum.KeyCode.D]="D"
X[820][Enum.KeyCode.Space]="Space"
X[820][Enum.KeyCode.LeftShift]="LeftShift"
N:jq(X[819],0,X[820],getgenv)
X[819].n=2
X[140],X[141]=X[819][1],X[819][2]
X[115]=X[141]().UserInputService
X[53]=function(S,w)local P={}
    if w then return
    end
    w=X[140][S.KeyCode]
    if w then P[1]=X[139]
        P[1][w]=true
    end
end
X[115].InputBegan:Connect(X[53])
X[118]=getgenv
X[31]=X[118]().UserInputService
X[69]=function(S)local w={}
    local P=X[140][S.KeyCode]
    if P then w[1]=X[139]
        w[1][P]=false
    end
end
X[31].InputEnded:Connect(X[69])
X[136]=getgenv().RunService
X[118]=function()local S={}
    local w=getgenv().LocalPlayer.Character
    local P,a=w and w:FindFirstChild("HumanoidRootPart"),w and w:FindFirstChildOfClass("Humanoid")
    if not P or not a then return
    end
    if Config.Misc.CFrameSpeedEnabled and Config.Misc.CFrameSpeedActive and not Config.Misc.CFrameFlyActive then if a.MoveDirection.Magnitude>0 then S[1]=P.CFrame+a.MoveDirection*(Config.Misc.CFrameSpeed/10)
            P.CFrame=S[1]
        end
    end
    if Config.Misc.CFrameFlyEnabled and Config.Misc.CFrameFlyActive then P.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0)
        a.PlatformStand=false
        local w,v=workspace.CurrentCamera,Vector3.new(0,0,0)
        v=if X[139].W then v+w.CFrame.LookVector else v
            v=if X[139].S then v-w.CFrame.LookVector else v
                v=if X[139].A then v-w.CFrame.RightVector else v
                    v=if X[139].D then v+w.CFrame.RightVector else v
                    v=if X[139].Space then v+Vector3.new(0,1,0)else v
                    v=if X[139].LeftShift then v-Vector3.new(0,1,0)else v
                    if v.Magnitude>0 then S[2]=P.CFrame+v.Unit*(Config.Misc.CFrameFlySpeed/100)
                    P.CFrame=S[2]
                end
            elseif a.PlatformStand then a.PlatformStand=false
                end
            end
            X[136].Heartbeat:Connect(X[118])
                        Config.Misc.WalkSpeedEnabled = false
                        Config.Misc.WalkSpeedActive = false
                        Config.Misc.WalkSpeedKey = nil
                        Config.Misc.WalkSpeed = 16
                        Config.Misc.AntiStompDelay = 3
            X[826]={}
            N:jq(X[826],0,false)
            X[826].n=1
            X[142],X[143]=X[826][1],X[826][2]
            X[144]=function(S)local w={}
                local P=488047796
                local a=P
                if not S then return
                end
                local v=S:FindFirstChildOfClass("Humanoid")or S:WaitForChild("Humanoid",5)
                if not v then return
                end
                S=X[143]
                P=N:Aq(bit32.band(36912894,a)+bit32.band(36912894,21152450)+(bit32.band(4221141508,(bit32.bor(a,21152450)))+bit32.band(36912895,(bit32.bxor(a,21152450)))))
                if S then X[143]:Disconnect()
                end
                S=nil
                S=(v:GetPropertyChangedSignal("WalkSpeed"))
                P=bit32.bxor(P,270002342)
                w[1]=(S:Connect(function()local S={}
                    if Config.Misc.WalkSpeedEnabled and Config.Misc.WalkSpeedActive then if v.WalkSpeed~=Config.Misc.WalkSpeed then v.WalkSpeed = Config.Misc.WalkSpeed
                end
            end
        end))
        X[143]=w[1]
        if Config.Misc.WalkSpeedEnabled and Config.Misc.WalkSpeedActive then w[2]=Config.Misc.WalkSpeed
            v.WalkSpeed=w[2]
        end
    end
    X[21]=getgenv
    X[125]=X[21]().UserInputService
    X[67]=function(S,w)local P={}
        if w then return
        end
        if not S.KeyCode or S.KeyCode==Enum.KeyCode.Unknown or S.KeyCode==Enum.KeyCode.None then return
        end
        if Config.Misc.WalkSpeedKey and S.KeyCode==Config.Misc.WalkSpeedKey then if Config.Misc.WalkSpeedEnabled then Config.Misc.WalkSpeedActive = not Config.Misc.WalkSpeedActive
                X[144](getgenv().LocalPlayer.Character)
            end
        end
    end
    X[125].InputBegan:Connect(X[67])
    getgenv().RunService.RenderStepped:Connect(function()local S={}
        local w=getgenv().LocalPlayer.Character
        local P=w and w:FindFirstChildOfClass("Humanoid")
        if P then w=Config.Misc.WalkSpeedEnabled and Config.Misc.WalkSpeedActive
            if w then if P.WalkSpeed~=Config.Misc.WalkSpeed then S[1]=Config.Misc.WalkSpeed
                    P.WalkSpeed=S[1]
                end
                X[142]=true
            else local S=X[142]
                if S then local S=X[143]
                    if S then X[143]:Disconnect()
                    X[143]=nil
                end
                P.WalkSpeed=16
                X[142]=false
            end
        end
    end
end)
getgenv().LocalPlayer.CharacterAdded:Connect(X[144])
if getgenv().LocalPlayer.Character then task.spawn(X[144],getgenv().LocalPlayer.Character)
end
Config.Misc_walkspeed_lbl = (getgenv().MovementSection:AddLabel("walkspeed"))
Config.Misc_walkspeed_lbl:AddToggle({
    Default = false,
    Flag = "Misc_WalkSpeedEnabled",
    Callback = function(S)local w={}
            Config.Misc.WalkSpeedEnabled = S
        if not S then         Config.Misc.WalkSpeedActive = false
        else X[144](getgenv().LocalPlayer.Character)
        end
    end,
})
Config.Misc_walkspeed_lbl:AddKeybind({
    Default = "None",
    Flag = "Misc_WalkSpeedKeybind",
    Callback = function(S)local w={}
        local P=getgenv().parseKey(S)
        if P then         Config.Misc.WalkSpeedKey = P
        end
    end,
})
Config.Misc_walkspeed_val_lbl = (getgenv().MovementSection:AddLabel("walkspeed value"))
Config.Misc_walkspeed_val_lbl:AddSlider({
    Min = 16,
    Max = 600,
    Rounding = 0,
    Default = 16,
    Flag = "Misc_WalkSpeedValue",
    Callback = function(S)local w={}
            Config.Misc.WalkSpeed = S
        X[144](getgenv().LocalPlayer.Character)
    end,
})
Config.Misc_cf_speed_lbl = (getgenv().MovementSection:AddLabel("cframe speed"))
Config.Misc_cf_speed_lbl:AddToggle({
    Default = false,
    Flag = "Misc_CFrameSpeedEnabled",
    Callback = function(S)local w={}
            Config.Misc.CFrameSpeedEnabled = S
        if not S then         Config.Misc.CFrameSpeedActive = false
        end
    end,
})
Config.Misc_cf_speed_lbl:AddKeybind({
    Default = "None",
    Flag = "Misc_CFrameSpeedKeybind",
    Callback = function(S)local w={}
        local P=getgenv().parseKey(S)
        if P then         Config.Misc.CFrameSpeedKey = P
        end
    end,
})
Config.Misc_cf_speed_val_lbl = (getgenv().MovementSection:AddLabel("speed multiplier"))
Config.Misc_cf_speed_val_lbl:AddSlider({
    Min = 1,
    Max = 60,
    Rounding = 1,
    Default = 2,
    Flag = "Misc_CFrameSpeedValue",
    Callback = function(S)local w={}
            Config.Misc.CFrameSpeed = S
    end,
})
Config.Misc_cf_fly_lbl = (getgenv().MovementSection:AddLabel("cframe fly"))
X[844]={}
N:jq(X[844],0,Config.Misc_cf_fly_lbl)
X[845]={}
X[845].Default=false
X[845].Flag="Misc_CFrameFlyEnabled"
N:jq(X[844],1,X[845])
X[844].n=2
X[145],X[146]=X[844][1],X[844][2]
X[146].Callback=function(S)local w={}
        Config.Misc.CFrameFlyEnabled = S
    local P=not S
    if P then         Config.Misc.CFrameFlyActive = false
        S=getgenv().LocalPlayer.Character
        local w,P=S and S:FindFirstChild("HumanoidRootPart"),S and S:FindFirstChildOfClass("Humanoid")
        if w then w.AssemblyLinearVelocity=Vector3.new(0,0,0)
        end
        if P then P.PlatformStand=false
        end
    end
end
X[846]=X[146]
X[145]:AddToggle(X[846])
Config.Misc_cf_fly_lbl:AddKeybind({
    Default = "None",
    Flag = "Misc_CFrameFlyKeybind",
    Callback = function(S)local w={}
        local P=getgenv().parseKey(S)
        if P then         Config.Misc.CFrameFlyKey = P
        end
    end,
})
Config.Misc_cf_fly_speed_lbl = (getgenv().MovementSection:AddLabel("fly speed"))
Config.Misc_cf_fly_speed_lbl:AddSlider({
    Min = 10,
    Max = 300,
    Rounding = 0,
    Default = 50,
    Flag = "Misc_CFrameFlySpeedValue",
    Callback = function(S)local w={}
            Config.Misc.CFrameFlySpeed = S
    end,
})
X[852]=getgenv()
X[852].MainEvent = (getgenv().ReplicatedStorage:WaitForChild("MainEvent",10))
X[63]=getgenv
X[25]=function()local S=getgenv().LocalPlayer.Character
    local w=S and S:FindFirstChild("HumanoidRootPart")
    if not w then return nil
    end
    local P,a,v=Config.ForceHit.ClosestMaxDistance or 50,ipairs,table.pack(getgenv().Players:GetPlayers())
    S=nil
    for H,E in a(table.unpack(v))do H=E~=getgenv().LocalPlayer and E.Character
        if H then if Config.ForceHit.Whitelist[E.Name]then continue
            end
            local a=E.Character:FindFirstChildOfClass("Humanoid")
            if not a or a.Health<=0 then continue
            end
            a=(E.Character:FindFirstChild("BodyEffects"))
            local v,H=a and a:FindFirstChild("K.O")and a["K.O"].Value,a and a:FindFirstChild("Dead")and a.Dead.Value
            if v or H then continue
            end
            a=(E.Character:FindFirstChild("HumanoidRootPart"))
            if a then v=(w.Position-a.Position).Magnitude
                if v<P then P,S=v,E
                end
            end
        end
    end
    return S
end
X[854]=X[63]()
X[854].FH_GetClosestToCharacter=X[25]
Config.ForceHitSettings={}
Config.ForceHitSettings.Enabled=false
Config.ForceHitSettings.Active=false
Config.ForceHitSettings.UseMaxDistance=true
Config.ForceHitSettings.Key=Enum.KeyCode.C
Config.ForceHitSettings.StrafeKey=Enum.KeyCode.N
Config.ForceHitSettings.OnlyOnDeath=false
Config.ForceHitSettings.Target=nil
Config.ForceHitSettings.HitPart="Head"
Config.ForceHitSettings.Whitelist={}
Config.ForceHitSettings.WallCheck=false
Config.ForceHitSettings.ForceFieldCheck=true
Config.ForceHitSettings.DeathCheck=true
Config.ForceHitSettings.AutoClosestTarget=false
Config.ForceHitSettings.ShowTargetLine=false
Config.ForceHitSettings.LineColor=Color3.fromRGB(255,255,255)
Config.ForceHitSettings.LineThickness=2
Config.ForceHitSettings.LineTransparency=0
Config.ForceHitSettings.LastShotTime=0
Config.ForceHitSettings.ShotCooldown=0
Config.ForceHitSettings.PrefireForceField=false
Config.ForceHitSettings.PrefireTime=0.1
Config.ForceHitSettings.AutoCalculatePrefire=false
Config.ForceHitSettings.MaxDistance=250
Config.ForceHitSettings.BulletTracers=true
Config.ForceHitSettings.TracerInlineColor=Color3.fromRGB(0,255,0)
Config.ForceHitSettings.TracerOutlineColor=Color3.fromRGB(255,255,255)
Config.ForceHitSettings.TracerLifetime=5.5
Config.ForceHitSettings.TracerWidth=0.1
Config.ForceHitSettings.HitSoundEnabled=true
Config.ForceHitSettings.HitSoundId="138750331387064"
Config.ForceHitSettings.HitNotification=true
Config.ForceHitSettings.NotificationFormat="hit (player) for (dmg%)"
Config.ForceHitSettings.TargetQueue={}
Config.ForceHitSettings.TargetHUDEnabled=true
Config.ForceHitSettings.HitChamsEnabled=true
Config.ForceHitSettings.HitChamsColor=Color3.fromRGB(255,0,0)
Config.ForceHitSettings.HitChamsTransparency=0.3
Config.ForceHitSettings.HitChamsDuration=1.5
X[53] = Config.ForceHitSettings
X[118]=nil
X[53].HitChamsMaterial = "forcefield"
X[53].HitChamsEffect = "fade"
X[53].HitEffectsEnabled=true
X[53].HitEffectType = "Blood Splatter"
X[53].HitEffectsColor = (Color3.fromRGB(255,255,255))
X[53].HitEffectsDuration=1.5
X[53].StrafeMode = "Orbit"
X[53].LookAtTarget=false
X[53].SpectateTarget=false
X[53].StrafeEnabled=false
X[53].strafespoof=false
X[53].VisualizeStrafe=false
X[53].StrafeSpeed=5
X[53].StrafeDistance=8
X[53].StrafeHeight=0
X[53].VoidTime=0.4
X[53].GroundTime=0.133
X[53].SpectateStrafe=false
X[53].AutoToxicEnabled=false
X[118]={}
X[15]="sometiems all you need is a larptic whitelist"
X[63]="this is why your blacklisted"
X[28]="bad config or low IQ"
X[22]="unlucky"
X[119]="ggwp"
X[67]="stop trying bro"
X[114]="why cheat when you cant make proper configs"
X[131]="clipped"
X[31]="easy"
X[61]="did ai code your glue connection"
X[100]="larp larp larp sahur"
N:jq(X[118],0,X[15],X[63],X[28],X[22],X[119],X[67],X[114],X[131],X[31],X[61],X[100])
X[53].ToxicPhrases=X[118]
X[53].LastToxicTarget=nil
Config.ForceHit=X[53]
X[861]=getgenv()
X[862]={}
X[862].Enabled=false
X[862].Range=50
X[862].HitPart="Head"
X[862].Delay=0.1
X[862].WallCheck=false
X[862].ForceFieldCheck=true
X[862].DeathCheck=true
X[862].Whitelist={}
X[862].StrafeWithAura=false
X[862].ApplyForceHitVisuals=false
X[862].CurrentTarget=nil
X[861].KillAura = X[862]
X[147]=function(S,w)if not w then return false
    end
    if w[S.Name]then return true
    end
    local P=pairs
    for a,v in P(w)do local w=v and a:find("@"..S.Name)
        if w then return true
        end
    end
    return false
end
task.spawn(function()while task.wait()do local S=getgenv().KillAura
        if not S or not S.Enabled then S.CurrentTarget=nil
            task.wait(0.1)
            continue
        end
        local w=getgenv().LocalPlayer.Character
        local P=w and w:FindFirstChild("HumanoidRootPart")
        local a,v=w and w:FindFirstChildOfClass("Humanoid"),w and w:FindFirstChildOfClass("Tool")
        if not P or not a or a.Health<=0 or not v then S.CurrentTarget=nil
            continue
        end
        local H,E,R=ipairs,table.pack(getgenv().Players:GetPlayers()),false
        for x,q in H(table.unpack(E))do if q==getgenv().LocalPlayer then continue
            end
            if X[147](q,S.Whitelist)then continue
            end
            local H=q.Character
            if not H then continue
            end
            x=(H:FindFirstChildOfClass("Humanoid"))
            if not x or x.Health<=0 then continue
            end
            a=(H:FindFirstChild("BodyEffects"))
            w=S.DeathCheck
            if w then local w,E=a and(a:FindFirstChild("K.O")and a["K.O"].Value or a:FindFirstChild("KO")and a.KO.Value),a and a:FindFirstChild("Dead")and a.Dead.Value
                if w or E then continue
                end
            end
            x=S.ForceFieldCheck and H:FindFirstChildOfClass("ForceField")
            if x then continue
            end
            local w=H:FindFirstChild(S.HitPart)or H:FindFirstChild("Head")
            if not w then continue
            end
            if(P.Position-w.Position).Magnitude>S.Range then continue
            end
            x=S.WallCheck and getgenv().FH_IsWallBetween
            if x then local a,E=265993005,false
                a=bit32.bxor(a,217863435)
                local L
                L,a=pcall,bit32.bxor(a,517392172)
                L(function()E=getgenv().FH_IsWallBetween(P.Position,w.Position,H)
                end)
                if E then continue
                end
            end
            S.CurrentTarget=q
            x=getgenv().FH_Fire
            if x then local a=78043033
                local H=a
                local E
                E,a=pcall,N:Aq(bit32.band(1434502464,H)+bit32.band(1434502464,82634748)+(bit32.band(2860464833,(bit32.bor(H,82634748)))+bit32.band(2860464831,(bit32.band(H,82634748)))))
                E(function()getgenv().FH_Fire(q)
                end)
            else local a=getgenv().MainEvent or getgenv().ReplicatedStorage:FindFirstChild("MainEvent")
                if a then local H=v:FindFirstChild("Handle")and v.Handle.Position or P.Position
                    local P=(w.Position-H).Unit
                    local v=w.Position+P*25
                    local P={}
                    P[1]="Shoot"
                    P[2]={[1]={[1]={Normal=w.Position,Instance=w,Position=w.Position}},[2]={[1]={thePart=w,theOffset=Vector3.new(0,0,0)}},[3]=H,[4]=v,[5]=workspace:GetServerTimeNow()}
                    local w=P
                    pcall(function()a:FireServer(unpack(w))
                end)
            end
        end
        task.wait(S.Delay)
        R=true
        break
    end
    if not R then S.CurrentTarget=nil
    end
end
end)
X[148]=function(S)local w=p
    local P=w:GetService("TextChatService")
    w=P.ChatVersion==Enum.ChatVersion.TextChatService
    if w then local w=P:FindFirstChild("TextChannels")and P.TextChannels:FindFirstChild("RBXGeneral")
        if w then w:SendAsync(S)
        end
    else local w=p
        local P=w:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
        w=nil
        if P then local a=p
            w=(a.ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest"))
        else w=P
        end
        if w then w:FireServer(S,"All")
        end
    end
end
getgenv().stompTargetEnabled=false
getgenv().autoGrabEnabled=false
getgenv().autoGrabCooldown=1
getgenv().SIZE_X,getgenv().SIZE_Y,getgenv().SIZE_Z=21,21,21
getgenv().TRANSPARENCY=0.8
getgenv().KnifeHitboxEnabled=false
getgenv().AutoKnifeEnabled=false
getgenv().auto_knife_loop=nil
getgenv().feature_enabled=false
getgenv().glue_active=false
getgenv().target_players={}
getgenv().use_unc_method=sethiddenproperty~=nil
getgenv().connection_loop=nil
getgenv().no_unc_loop=nil
getgenv().is_connecting=false
getgenv().glue_offset_z=3
X[864]=getgenv()
X[864].glue_position = "Back"
getgenv().max_connection_distance=100
getgenv().min_target_health=1
getgenv().show_target_status=false
getgenv().target_status_update_loop=nil
X[866]=getgenv()
X[866].last_status_message = ""
X[868]=getgenv()
X[868].last_target_list = ""
getgenv().player_knocked_state=false
getgenv().last_knockdown_notified=false
getgenv().GlueKey=Enum.KeyCode.G
getgenv().glue_spoof=false
getgenv().stompGlueTargetEnabled=false
X[149]=function(S)local w="NLAssets"
    if not isfolder(w)then makefolder(w)
    end
    local P=S:match("%.%w+$")or ".ogg"
    local a=S:gsub("[^%w]","")..P
    P=w.."/"..a
    a=not isfile(P)
    if a then local a=504793926
        w=a
        local v
        v,a=pcall,N:Aq(bit32.band(361193430,w)+bit32.band(361193430,194621890)+(bit32.band(3933773867,(bit32.bor(w,194621890)))+bit32.band(3933773865,(bit32.band(w,194621890)))))
        local w,a=v(function()local H=p
            return H:HttpGet(S)
        end)
        v=w and a and not a:find("404")
        if v then writefile(P,a)
        end
    end
    if isfile(P)then return getcustomasset(P)
    end
    return nil
end
X[10]=(getgenv())
Config.HitsoundMap={}
Config.HitsoundMap["Sparkles"]="https://files.catbox.moe/bgy8au.ogg"
Config.HitsoundMap["Neverlose"]="110168723447153"
Config.HitsoundMap["Skeet"]="5633695679"
Config.HitsoundMap["Fatality"]="6534947869"
Config.HitsoundMap["Old Fatality"]="6607142036"
Config.HitsoundMap["Hood Customs"]="330595293"
Config.HitsoundMap["Fortnite Shield"]="130919835188323"
Config.HitsoundMap["Register"]="134810204798705"
Config.HitsoundMap["Call of Duty"]="5952120301"
Config.HitsoundMap["Cod Alt"]="77082587278347"
Config.HitsoundMap["Cod Hit"]="160432334"
Config.HitsoundMap["Bonebreak"]="135076986499326"
Config.HitsoundMap["Pickaxe Hit"]="9120146349"
Config.HitsoundMap["Rust Headshot"]="138750331387064"
Config.HitsoundMap["Rust"]="6565371338"
Config.HitsoundMap["Bubble"]="6534947588"
Config.HitsoundMap["Laser"]="7837461331"
Config.HitsoundMap["LazerBeam"]="130791043"
Config.HitsoundMap["Steve"]="4965083997"
Config.HitsoundMap["TF2 Critical"]="296102734"
Config.HitsoundMap["TF2 Hitsound"]="3455144981"
Config.HitsoundMap["TF2 Bat"]="3333907347"
Config.HitsoundMap["TF2 Pan"]="3431749479"
Config.HitsoundMap["TF2"]="2868331684"
Config.HitsoundMap["Saber"]="8415678813"
Config.HitsoundMap["Bameware"]="3124331820"
Config.HitsoundMap["Money"]="13956013041"
Config.HitsoundMap["Notif"]="6696469190"
Config.HitsoundMap["Shutter"]="10066921516"
Config.HitsoundMap["RIFK7"]="9102080552"
Config.HitsoundMap["Windows XP Error"]="160715357"
Config.HitsoundMap["Bow Hit"]="1053296915"
Config.HitsoundMap["Bow"]="3442683707"
Config.HitsoundMap["OSU"]="7147454322"
Config.HitsoundMap["Osu Alt"]="7149255551"
Config.HitsoundMap["OneNN"]="7349055654"
Config.HitsoundMap["One"]="7380502345"
Config.HitsoundMap["Mario"]="5709456554"
X[130]=Config.HitsoundMap
X[871]="Bell"
X[130][X[871]] = "6534947240"
X[873]="Pick"
X[130][X[873]] = "1347140027"
X[875]="Pop"
X[130][X[875]] = "198598793"
X[877]="Sans"
X[130][X[877]] = "3188795283"
X[879]="Fart"
X[130][X[879]] = "130833677"
X[881]="Big"
X[130][X[881]] = "5332005053"
X[883]="Vine"
X[130][X[883]] = "5332680810"
X[885]="Bruh"
X[130][X[885]] = "4578740568"
X[887]="Bonk"
X[130][X[887]] = "5766898159"
X[889]="Minecraft"
X[130][X[889]] = "5869422451"
X[891]="Gamesense"
X[130][X[891]] = "4817809188"
X[893]="Bamboo"
X[130][X[893]] = "3769434519"
X[895]="Crowbar"
X[130][X[895]] = "546410481"
X[897]="Weeb"
X[130][X[897]] = "6442965016"
X[899]="Beep"
X[130][X[899]] = "8177256015"
X[901]="Bambi"
X[130][X[901]] = "8437203821"
X[903]="Stone"
X[130][X[903]] = "3581383408"
X[905]="Click"
X[130][X[905]] = "8053704437"
X[907]="Ding"
X[130][X[907]] = "7149516994"
X[909]="Snow"
X[130][X[909]] = "6455527632"
X[911]="Slime"
X[130][X[911]] = "6916371803"
X[913]="Among Us"
X[130][X[913]] = "5700183626"
X[915]="Bullet Deflect"
X[130][X[915]] = "1657157666"
X[917]="UwU"
X[130][X[917]] = "8679659744"
X[919]="Blood SFX"
X[130][X[919]] = "8164951181"
X[921]="Blood Burst"
X[130][X[921]] = "3781479909"
X[923]="Blood Hit"
X[130][X[923]] = "429400881"
X[10].HitSounds=X[130]
getgenv().hitsoundNames={}
for S in pairs(getgenv().HitSounds)do table.insert(getgenv().hitsoundNames,S)
end
table.sort(getgenv().hitsoundNames)
X[42]=nil
X[69]=nil
X[42]=(getgenv())
X[69]=Instance.new
X[42].HitSound = (X[69]("Sound"))
getgenv().HitSound.Volume=0.5
getgenv().HitSound.Parent=getgenv().SoundService
getgenv().TracerContainer=getgenv().TracerContainer or(function()local S={}
    local w=Instance.new("Folder")
    S[1]="FH_Tracers"
    w.Name=S[1]
    w.Parent=workspace.CurrentCamera
    return w
end)()
getgenv().FH_ActiveTracers=getgenv().FH_ActiveTracers or{}
X[926]=getgenv()
X[926].FH_NotifGui = (Instance.new("ScreenGui"))
X[7]=getgenv
X[928]=X[7]().FH_NotifGui
X[928].Name = "fh_notifgui"
getgenv().FH_NotifGui.ResetOnSpawn=false
X[930]=getgenv().FH_NotifGui
X[930].Parent = (getgenv().LocalPlayer:WaitForChild("PlayerGui"))
getgenv().FH_NotifGui.IgnoreGuiInset=true
X[932]={}
X[933]={}
X[933][0]="https://files.catbox.moe/50j8pw.png"
X[933][1]="https://files.catbox.moe/7kk7mr.png"
X[933][2]="https://files.catbox.moe/6o8qk0.png"
X[933][3]="https://files.catbox.moe/b88dro.png"
X[933][4]="https://files.catbox.moe/poztxv.png"
X[933][5]="https://files.catbox.moe/pdze27.png"
X[933][6]="https://files.catbox.moe/gub3gj.png"
X[933][7]="https://files.catbox.moe/kyrq3n.png"
N:jq(X[932],0,X[933])
X[932].n=1
X[150]=X[932][1]
X[150][8] = "https://files.catbox.moe/c151do.png"
X[150][9] = "https://files.catbox.moe/v90skk.png"
getgenv().DamageIndicatorColor=Color3.fromRGB(255,225,0)
getgenv().DamageIndicatorEnabled=true
X[936]=getgenv()
X[936].DamageIndicatorStyle = "Phantom Forces"
X[55]=getgenv
X[131]=function(S,w)local P={}
    if not getgenv().DamageIndicatorEnabled or not w then return
    end
    local a=getgenv().DamageIndicatorStyle or "Phantom Forces"
    local v=a=="Phantom Forces"
    if v then local v=517815014
        local H,E=tostring(math.floor(S)),Instance.new("Attachment")
        E.WorldPosition=w
        E.Parent=workspace.Terrain
        local R=Instance.new("BillboardGui")
        P[1]="BillboardDamage"
        R.Name=P[1]
        R.Size=UDim2.new(0,150,0,60)
        R.ClipsDescendants=false
        R.AlwaysOnTop=true
        R.MaxDistance=1/0
        R.Adornee=E
        local x,q=getgenv().FH_NotifGui
        if x then q=x
        else local L=p
            q=(L:GetService("CoreGui"))
        end
        R.Parent=q
        local q=Instance.new("TextLabel")
        P[2]="TextDamage"
        q.Name=P[2]
        q.Text=H
        q.TextColor3=getgenv().DamageIndicatorColor or Color3.fromRGB(255,150,0)
        q.TextSize=26
        q.TextScaled=false
        v=bit32.bxor(v,476464859)
        q.Font=Enum.Font.Unknown
        P[3]=(Font.new("rbxasset://fonts/families/Zekton.json",Enum.FontWeight.Bold,Enum.FontStyle.Normal))
        q.FontFace=P[3]
        q.Size=UDim2.new(1,0,1,0)
        q.Position=UDim2.new(0.5,-1,0.5,-10)
        q.AnchorPoint=Vector2.new(0.5,0.5)
        q.BackgroundTransparency=1
        q.BorderSizePixel=0
        q.ZIndex=2
        q.Visible=true
        q.Parent=R
        local L=Instance.new("TextLabel")
        P[4]="TextDamageShadow"
        L.Name=P[4]
        L.Text=H
        L.TextColor3=Color3.fromRGB(67,67,67)
        L.TextSize=26
        L.TextScaled=false
        L.Font=Enum.Font.Unknown
        v=bit32.bxor(v,188959010)
        P[5]=(Font.new("rbxasset://fonts/families/Zekton.json",Enum.FontWeight.Bold,Enum.FontStyle.Normal))
        L.FontFace=P[5]
        L.Size=UDim2.new(1,0,1,0)
        L.Position=UDim2.new(0.5,0,0.5,-9)
        L.AnchorPoint=Vector2.new(0.5,0.5)
        L.BackgroundTransparency=1
        L.BorderSizePixel=0
        L.ZIndex=1
        L.Visible=true
        L.Parent=R
        local v=Instance.new("UIStroke")
        P[6]="UIStroke"
        v.Name=P[6]
        v.Thickness=1.5
        v.Color=Color3.fromRGB(0,0,0)
        v.Parent=L
        x,H=math.rad(math.random(0,360)),math.random(60,100)/10
        local P,Y,r,A=math.cos(x)*H,math.sin(x)*H,math.random(30,60)/10,Vector3.new(0,0,0)
        local H=Vector3.new(P,r,Y)
        task.spawn(function()local P=1.35
            R.Size=UDim2.new(0,60,0,24)
            local x=p
            local Y,r,K=x:GetService("TweenService"),TweenInfo.new,Enum
            local f,C=K.EasingStyle.Quad,Enum.EasingDirection
            K,x=r(0.04,f,C.Out),{}
            x.Size=UDim2.new(0,150,0,60)
            Y:Create(R,K,x):Play()
            x=0
            while x<P do x+=task.wait()
                f=x/P
                Y=math.sin(f*1.5707963267948966)
                R.StudsOffset=A:Lerp(H,Y)
                if f>0.5 then r=(f-0.5)/0.5
                    q.TextTransparency=r
                    L.TextTransparency=r
                    v.Transparency=r
                end
            end
            R:Destroy()
            if E and E.Parent then E:Destroy()
            end
        end)
    else local P=a=="Fortnite"
        if P then local P=workspace.CurrentCamera
            local a,v=P:WorldToViewportPoint(w)
            if not v then return
            end
            local w=math.clamp(a.X,0,P.ViewportSize.X)
            local H=math.clamp(a.Y,0,P.ViewportSize.Y)
            local E,R,x=tostring(math.floor(S)),25,0
            local S=#E*R+(#E-1)*x
            local q=Instance.new("Frame")
            q.BackgroundTransparency=1
            q.Size=UDim2.new(0,S,0,R)
            q.Position=UDim2.new(0,w-S/2,0,H-30)
            q.Parent=getgenv().FH_NotifGui
            v=#E
            for L=1,v,1 do local Y=71359963
                P=Y
                local r=tonumber(E:sub(L,L))
                local E=Instance.new("ImageLabel")
                Y=bit32.bxor(P,351832297)
                E.BackgroundTransparency=1
                E.Size=UDim2.new(R/S,0,1,0)
                local P,A=UDim2.new,(L-1)*(R+x)/S
                E.Position=P(A,0,0,0)
                P,a=getgenv().DamageIndicatorColor,N:Aq(A)
                Y=N:Aq(bit32.bxor(Y,351477229)+bit32.band(178624542,4294967295)+(bit32.band(4116342754,a)+bit32.band(4116342754,(bit32.bnot(a)))))
                E.ImageColor3=P
                E.Parent=q
                A=task.spawn
                local function P()local x="nl_digit_"..r..".png"
                    local L=not isfile(x)
                    if L then local L,Y=p,X[150][r]
                    writefile(x,(L:HttpGet(Y)))
                end
                E.Image=getcustomasset(x)
            end
            A(P)
        end
        a,v=task,function()local P,E,x,L,Y=tick(),0.12,0.3,H-30,55
            while tick()-P<E do local H=(tick()-P)/E*1.3
                local r,A=S*H,R*H
                q.Size=UDim2.new(0,r,0,A)
                q.Position=UDim2.new(0,w-r/2,0,L-(A-R)/2)
                task.wait()
            end
            E,P=tick(),0.08
            while tick()-E<P do local H=1.3-0.3*((tick()-E)/P)
                local r,A=S*H,R*H
                q.Size=UDim2.new(0,r,0,A)
                q.Position=UDim2.new(0,w-r/2,0,L-(A-R)/2)
                task.wait()
            end
            E=tick()
            while tick()-E<x do P=L-Y*((tick()-E)/x)
                q.Position=UDim2.new(0,w-S/2,0,P)
                task.wait()
            end
            task.wait(0.35)
            x,L,Y={},ipairs,table.pack(q:GetChildren())
            for S,w in L(table.unpack(Y))do S="ImageLabel"
                if w:IsA(S)then table.insert(x,w)
                end
            end
            Y,L,E=#x/2,tick(),0.45
            while tick()-L<E do P=(tick()-L)/E
                local S=P*P
                for w,H in ipairs(x)do local E,R=(w<=Y and-1 or 1)*(P*95),S*320
                    H.Position=UDim2.new(H.Position.X.Scale,H.Position.X.Offset+E*0.05,0,H.Position.Y.Offset+R*0.05)
                    H.ImageTransparency=P
                end
                task.wait()
            end
            q:Destroy()
        end
        a.spawn(v)
    end
end
end
X[938]=X[55]()
X[938].FH_ShowDamageIndicator=X[131]
X[939]=getgenv()
X[939].FH_NotifFrame = (Instance.new("Frame"))
getgenv().FH_NotifFrame.Size=UDim2.new(0,400,0,160)
X[130]=nil
X[136]=nil
X[130]=getgenv().FH_NotifFrame
X[136]=UDim2.new
X[130].Position = (X[136](0.5,-200,0.62,0))
getgenv().FH_NotifFrame.BackgroundTransparency=1
getgenv().FH_NotifFrame.Parent=getgenv().FH_NotifGui
X[942]=getgenv()
X[942].FH_NotifLayout = (Instance.new("UIListLayout"))
X[944]=getgenv().FH_NotifLayout
X[944].VerticalAlignment = Enum.VerticalAlignment.Bottom
getgenv().FH_NotifLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
getgenv().FH_NotifLayout.SortOrder=Enum.SortOrder.LayoutOrder
getgenv().FH_NotifLayout.Padding=UDim.new(0,5)
getgenv().FH_NotifLayout.Parent=getgenv().FH_NotifFrame
X[56]=getgenv
X[23]=function(S,w)local P={}
    local a=534650186
    local v=a
    local H=Instance.new("TextLabel")
    H.Size=UDim2.new(1,0,0,25)
    a=N:Aq(v+367389434)
    H.BackgroundTransparency=1
    H.RichText=true
    H.Font=Enum.Font.GothamBold
    H.TextSize=14
    H.TextColor3=Color3.fromRGB(255,255,255)
    v=nil
    v,a=Instance,N:Aq(a-150441028)
    local a=v.new("UIStroke")
    a.Thickness=1.5
    a.Color=Color3.fromRGB(0,0,0)
    a.Parent=H
    P[1]=(string.format("hit <font color=\"rgb(160, 32, 240)\">%s</font> for <font color=\"rgb(0, 255, 0)\">%.1f</font> damage",S,w))
    H.Text=P[1]
    H.Parent=getgenv().FH_NotifFrame
    task.spawn(function()task.wait(2.5)
        local S=10
        for w=1,S,1 do task.wait(0.05)
            local P=w/S
            H.TextTransparency=P
            a.Transparency=P
        end
        H:Destroy()
    end)
end
X[946]=X[56]()
X[946].FH_CustomNotify=X[23]
X[119]=Config.ForceHit and Config.ForceHit.TracerType==nil
if X[119]then     Config.ForceHit.TracerType = "Default"
end
X[58]=getgenv
X[10]=function(S,w)local P={}
    if not Config.ForceHit.BulletTracers then return
    end
    local a=getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChildOfClass("Tool")
    local v=a and a.Name=="[DoubleBarrel]"
    local H,E=v and 3 or 1,0.65
    for R=1,H,1 do a=nil
        if v then local v=(R-2)*E
            a=w+(w-S).Unit:Cross(Vector3.new(0,1,0)).Unit*v
        else a=w
        end
        R=Config.ForceHit.TracerType=="Hood Customs"
        if R then local w=Instance.new("Part")
            P[1]="BULLET_RAYS"
            w.Name=P[1]
            w.Size=Vector3.new(0.009999999776482582,0.009999999776482582,0.009999999776482582)
            w.Transparency=1
            w.CanCollide=false
            w.CanQuery=false
            w.CanTouch=true
            w.Anchored=true
            w.Massless=false
            w.Color=Color3.fromRGB(163,162,165)
            w.Material=Enum.Material.Plastic
            w.CFrame=CFrame.new(S)
            w.Parent=getgenv().TracerContainer
            local v=Instance.new("Attachment")
            P[2]="START_ATTACHMENT"
            v.Name=P[2]
            v.Position=Vector3.new(0,0,0)
            v.Parent=w
            local H=Instance.new("Attachment")
            P[3]="END_ATTACHMENT"
            H.Name=P[3]
            H.Position=w.CFrame:PointToObjectSpace(a)
            H.Parent=w
            local E=Instance.new("Beam")
            P[4]="GunBeam"
            E.Name=P[4]
            E.Enabled=true
            E.Attachment0=v
            E.Attachment1=H
            E.Brightness=1
            E.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(1,0.94902,0.352941)),ColorSequenceKeypoint.new(1,Color3.new(1,0.819608,0.160784))})
            E.CurveSize0=0
            E.CurveSize1=0
            E.FaceCamera=true
            E.LightEmission=1
            E.LightInfluence=0.10000000149011612
            E.Segments=5
            P[5]=""
            E.Texture=P[5]
            E.TextureLength=0.5
            E.TextureMode=Enum.TextureMode.Stretch
            E.TextureSpeed=1
            E.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.81875),NumberSequenceKeypoint.new(1,0.225)})
            E.Width0=0
            E.Width1=0.10000000149011612
            E.ZOffset=0
            E.Parent=w
            v=(Instance.new("PointLight"))
            v.Enabled=true
            v.Brightness=0.5
            v.Range=11.5
            v.Color=Color3.fromRGB(255,255,255)
            v.Shadows=true
            v.Parent=w
            P[7]=table.insert
            P[8]=getgenv().FH_ActiveTracers
            P[6]={}
            P[6].startPart=w
            P[6].endPart=w
            P[6].gunBeam=E
            P[6].isHoodCustoms=true
            P[6].createdAt=tick()
            P[6].lifetime=Config.ForceHit.TracerLifetime
            P[7](P[8],P[6])
        else local w=Instance.new("Part")
            w.Size=Vector3.new(0,0,0)
            w.Transparency=1
            w.CanCollide=false
            w.Anchored=true
            w.Massless=true
            w.CFrame=CFrame.new(S)
            w.Parent=getgenv().TracerContainer
            local S=Instance.new("Part")
            S.Size=Vector3.new(0,0,0)
            S.Transparency=1
            S.CanCollide=false
            S.CanQuery=false
            S.Anchored=true
            S.Massless=true
            S.CFrame=CFrame.new(a)
            S.Parent=getgenv().TracerContainer
            local a,v,H=Instance.new("Attachment",w),Instance.new("Attachment",S),Instance.new("Beam",w)
            H.Attachment0=a
            H.Attachment1=v
            H.FaceCamera=true
            H.LightEmission=1
            H.LightInfluence=0
            P[9]=(ColorSequence.new(Config.ForceHit.TracerInlineColor))
            H.Color=P[9]
            P[10]=Config.ForceHit.TracerWidth
            H.Width0=P[10]
            P[11]=Config.ForceHit.TracerWidth
            H.Width1=P[11]
            P[12]="rbxassetid://446111271"
            H.Texture=P[12]
            H.TextureMode=Enum.TextureMode.Wrap
            H.TextureLength=3
            H.TextureSpeed=3
            H.Transparency=NumberSequence.new(0)
            H.ZOffset=0
            P[14]=table.insert
            P[15]=getgenv().FH_ActiveTracers
            P[13]={}
            P[13].startPart=w
            P[13].endPart=S
            P[13].beam=H
            P[13].createdAt=tick()
            P[13].lifetime=Config.ForceHit.TracerLifetime
            P[14](P[15],P[13])
        end
    end
end
X[949]=X[58]()
X[949].FH_CreateTracer=X[10]
X[56]=getgenv
X[115]=function(S,w,P)local a={}
    local v=441837741
    local H=v
    if not S then return
    end
    local E=Instance.new("Model")
    a[1]="hit_cham"
    E.Name=a[1]
    local a
    a=Config.ForceHit
    v=bit32.bxor(H,167738430)
    local H,R=a.HitChamsMaterial=="neon"and Enum.Material.Neon or Enum.Material.ForceField
    R,v=Enum.Material,N:Aq(bit32.band(375453103,v)+bit32.band(4294967295,237207523)+(bit32.band(2,(bit32.bor(v,237207523)))+(bit32.band(3919514192,4294967295)+bit32.band(375453104,(bit32.bnot(v))))))
    local a=H==R.Neon and 0 or(Config.ForceHit.HitChamsTransparency or 0.3)
    local function v(R,x)local q=219973165
        local L=q
        R.CanCollide=false
        R.CanTouch=false
        R.CanQuery=false
        R.Massless=true
        q=bit32.bxor(L,448884967)
        R.Material=H
        R.Color=w
        R.Transparency=a
        local w,H=ipairs,table.pack(R:GetDescendants())
        for Y,Y in w(table.unpack(H))do L=Y:IsA("JointInstance")or Y:IsA("Constraint")or Y:IsA("TouchTransmitter")or Y:IsA("Script")or Y:IsA("LocalScript")
            if L then Y:Destroy()
            end
        end
        R.Parent=E
        q=N:Aq(bit32.band(496763565,q)+bit32.band(496763565,514461972)+(bit32.band(3798203732,(bit32.bor(q,514461972)))+bit32.band(3798203730,(bit32.band(q,514461972)))))
        R.CFrame=x.CFrame
        R.Anchored=true
        local w=Config.ForceHit.HitChamsEffect or "fade"
        local H=x.Size
        x,L=task,function()local q=20
            local Y,r=P/q,w=="fade"
            if r then for r=1,q,1 do task.wait(Y)
                    if not(R and R.Parent)then return
                end
                R.Transparency=a+(1-a)*(r/q)
            end
        else local r=w=="explode"
            if r then task.wait(P*0.6)
                for r=1,q,1 do task.wait(Y*0.02)
                    if not(R and R.Parent)then return
                end
                local A=r/q
                R.Size=H*(1+A*2.5)
                R.Transparency=A
            end
        else local r=w=="minimize"
            if r then for r=1,q,1 do task.wait(Y)
                    if not(R and R.Parent)then return
                end
                local A=r/q
                R.Size=H*math.max(1-A,0.01)
                R.Transparency=a+(1-a)*A
            end
        else local H=w=="flicker"
            if H then local H=0
                while H<P do task.wait(0.05)
                    H+=0.05
                    if not(R and R.Parent)then return
                end
                R.Transparency=R.Transparency==1 and a or 1
            end
        else local a="shatter"
            if w==a then task.wait(P*0.5)
                for w=1,q,1 do task.wait(Y*0.025)
                    if not(R and R.Parent)then return
                end
                local a=w/q
                R.CFrame=R.CFrame*CFrame.new(math.random(-10,10)*0.05*a,math.random(-10,10)*0.05*a,math.random(-10,10)*0.05*a)
                R.Transparency=a
            end
        end
    end
end
end
end
if R and R.Parent then R:Destroy()
end
end
x.spawn(L)
end
local w,a,H,R,x,q,L,Y,r,A,K,f,C,l,Z,h,m,M,d,c={},"Head","Torso","UpperTorso","LowerTorso","LeftArm","RightArm","LeftLeg","RightLeg","LeftUpperArm","LeftLowerArm","LeftHand","RightUpperArm","RightLowerArm","RightHand","LeftUpperLeg","LeftLowerLeg","LeftFoot","RightUpperLeg","RightLowerLeg"
N:jq(w,0,a,H,R,x,q,L,Y,r,A,K,f,C,l,Z,h,m,M,d,c,"RightFoot")
Z={}
for H,H in ipairs(w)do Z[H]=true
end
Y,d=ipairs,table.pack(S:GetChildren())
for S,S in Y(table.unpack(d))do a=S:IsA("BasePart")and Z[S.Name]
    if a then r=(Instance.new("Part"))
        r.Size=S.Size
        r.Shape=Enum.PartType.Block
        v(r,S)
    end
end
E.Parent=workspace
task.delay(P+0.1,function()if E then E:Destroy()
    end
end)
end
X[950]=X[56]()
X[950].FH_CreateHitChams=X[115]
X[48]=getgenv().RunService
X[25]=function()local S={}
    local w,P=tick(),1
    while P<=#getgenv().FH_ActiveTracers do local a=getgenv().FH_ActiveTracers[P]
        local v=(w-a.createdAt)/a.lifetime
        if v>=1 then if a.startPart and a.startPart.Parent then a.startPart:Destroy()
            end
            if a.endPart and a.endPart.Parent then a.endPart:Destroy()
            end
            table.remove(getgenv().FH_ActiveTracers,P)
        else local w=NumberSequence.new(v)
            if a.isHoodCustoms then if a.gunBeam and a.gunBeam.Parent then local H,E=0.81875+0.18125*v,0.225+0.775*v
                    a.gunBeam.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,math.clamp(H,0,1)),NumberSequenceKeypoint.new(1,math.clamp(E,0,1))})
                end
            elseif a.beam and a.beam.Parent then a.beam.Transparency=w
                    a.beam.Color = (ColorSequence.new(Config.ForceHit.TracerInlineColor))
                    a.beam.Width0 = Config.ForceHit.TracerWidth
                    a.beam.Width1 = Config.ForceHit.TracerWidth
                end
                P+=1
            end
        end
    end
    X[48].Heartbeat:Connect(X[25])
    X[20]=getgenv
    X[133]=function(S,w,P)local a=getgenv().LocalPlayer.Character
        if not a then return false
        end
        local v=a:FindFirstChild("Head")
        local H,E=v and v.Position or S,RaycastParams.new()
        E.FilterDescendantsInstances={a,P,workspace.CurrentCamera}
        E.FilterType=Enum.RaycastFilterType.Exclude
        E.IgnoreWater=true
        S=workspace:Raycast(H,w-H,E)
        if not S then return false
        end
        H=S.Instance
        if H then if S.Instance.CanCollide==false or S.Instance.Transparency>=0.95 then return false
            end
            v=(S.Instance:FindFirstAncestorOfClass("Model"))
            if v and(getgenv().Players:GetPlayerFromCharacter(v)or v==P)then return false
            end
        end
        return true
    end
    X[951]=X[20]()
    X[951].FH_IsWallBetween=X[133]
    Config.FH_GetClosest=function()local S,w,P,a=getgenv().UserInputService:GetMouseLocation(),workspace.CurrentCamera,1/0
        for v,H in ipairs(getgenv().Players:GetPlayers())do if H~=getgenv().LocalPlayer and H.Character then if Config.ForceHit.Whitelist[H.Name]then continue
                end
                v=(H.Character:FindFirstChild(Config.ForceHit.HitPart))
                if v then local E,R=w:WorldToViewportPoint(v.Position)
                    if R then local w=(Vector2.new(E.X,E.Y)-S).Magnitude
                    if w<P then P,a=w,H
                end
            end
        end
    end
end
return a
end
X[952]=getgenv()
X[952].FH_GetClosest = Config.FH_GetClosest
getgenv().FH_GetMuzzlePos=function()local S=getgenv().LocalPlayer.Character
    if not S then return nil
    end
    local w=S:FindFirstChildOfClass("Tool")
    if w then local P=w:FindFirstChild("Handle")or w:FindFirstChildWhichIsA("BasePart")
        if P then local a=P:FindFirstChild("Muzzle")or P
            return a.Position
        end
    end
    w=(S:FindFirstChild("Head"))
    if w then return w.Position+w.CFrame.LookVector*3
    end
    w=(S:FindFirstChild("HumanoidRootPart"))
    if w then return w.Position+w.CFrame.LookVector*4
    end
    return nil
end
getgenv().FH_LastHealth=getgenv().FH_LastHealth or{}
getgenv().FH_TrashedPlayers=getgenv().FH_TrashedPlayers or{}
X[28]=getgenv
X[106]=X[28]().RunService
X[23]=function()local S={}
    local w={}
    if Config.ForceHit and Config.ForceHit.Target then table.insert(w,Config.ForceHit.Target)
    end
    if getgenv().KillAura and getgenv().KillAura.CurrentTarget and not table.find(w,getgenv().KillAura.CurrentTarget)then table.insert(w,getgenv().KillAura.CurrentTarget)
    end
    if CurrentLegitTarget and not table.find(w,CurrentLegitTarget)then table.insert(w,CurrentLegitTarget)
    end
    local P=ipairs
    for a,v in P(w)do a=v and v.Character
        if a then local w,P=getgenv().KillAura and getgenv().KillAura.CurrentTarget==v,v.Character
            local a=P:FindFirstChild("BodyEffects")
            local H,E=a and(a:FindFirstChild("Health")or a:FindFirstChild("Health_CLIENT")),P:FindFirstChildOfClass("Humanoid")
            local R=H and H.Value or(E and E.Health or 100)
            if P then E=v.UserId
                local P=(getgenv().FH_LastHealth[E]or R)-R
                if a then local x=a:FindFirstChild("K.O")and a["K.O"].Value
                    if not(x)then local x="KO"
                    if a:FindFirstChild(x)then H=a.KO.Value
                end
            end
        end
        local a,a=R<=0,v.Character:FindFirstChild("BodyEffects")
        local H=a and(a:FindFirstChild("K.O")and a["K.O"].Value or a:FindFirstChild("KO")and a.KO.Value)
        H=R<=0 or H
        if H then a=Config.ForceHit.AutoToxicEnabled and not getgenv().FH_TrashedPlayers[E]
            if a then getgenv().FH_TrashedPlayers[E]=true
                local x=Config.ForceHit.ToxicPhrases
                local q=#x>0
                if q then local q=x[math.random(1,#x)]
                    X[148]((q:gsub("%(player%)",v.DisplayName)))
                end
            end
        else getgenv().FH_TrashedPlayers[E]=nil
        end
        a=P>0 and(not w or getgenv().KillAura.ApplyForceHitVisuals)
        if a then if not Config.ForceHit.OnlyOnDeath or H then getgenv().FH_CreateCustomHitEffect(v.Character)
            end
            local w,a=v.Character:FindFirstChild(Config.ForceHit.HitPart)or v.Character:FindFirstChild("HumanoidRootPart")or v.Character:FindFirstChild("Head"),Config.ForceHit.HitSoundEnabled
            if a then local H=tostring(Config.ForceHit.HitSoundId)
                local x=H:find("^http")
                if x then local x=199027723
                    local q=x
                    local L=task
                    x=bit32.bxor(q,211477605)
                    q=L.spawn
                    x=N:Aq(bit32.band(1625673845,x)+bit32.band(1625673845,66892478)+(bit32.band(2669293452,(bit32.bor(x,66892478)))+bit32.band(2669293450,(bit32.band(x,66892478)))))
                    local function x()local L=X[149](H)
                    if L then getgenv().HitSound.SoundId=L
                    getgenv().HitSound:Play()
                end
            end
            q(x)
        else local x=H:gsub("rbxassetid://","")
            getgenv().HitSound.SoundId = "rbxassetid://"..x
            getgenv().HitSound:Play()
        end
    end
    if Config.ForceHit.HitNotification then getgenv().FH_CustomNotify(v.DisplayName,P)
    end
    if Config.ForceHit.BulletTracers and w then a=getgenv().FH_GetMuzzlePos()
        if a then getgenv().FH_CreateTracer(a,w.Position)
        end
    end
    if Config.ForceHit.HitChamsEnabled then getgenv().FH_CreateHitChams(v.Character,Config.ForceHit.HitChamsColor,Config.ForceHit.HitChamsDuration)
    end
    if w then getgenv().FH_ShowDamageIndicator(P,w.Position)
    end
end
getgenv().FH_LastHealth[E]=R
end
end
end
end
X[106].Heartbeat:Connect(X[23])
getgenv().FH_Index=getgenv().FH_Index or 19
Config.FH_Fire=function(S)local w=15321989
    local P=w
    if not S or not S.Character then return
    end
    local a=S.Character
    local v,H=a:FindFirstChildOfClass("Humanoid"),Config.ForceHit
    if not H then return
    end
    S=H.FireRate or 0.1
    if H.LastShotTime and S>tick()-H.LastShotTime then return
    end
    S=(a:FindFirstChild("BodyEffects"))
    if S then local E,R,x=S:FindFirstChild("K.O"),S:FindFirstChild("KO"),S:FindFirstChild("Dead")
        if E and E.Value or R and R.Value or x and x.Value then return
        end
        R=(S:FindFirstChild("Health"))
        x=(S:FindFirstChild("Health_CLIENT"))
        if R and R.Value<=0 then return
        end
        if x and x.Value<=0 then return
        end
    end
    if H.DeathCheck then if not v or v.Health<=0 then return
        end
    end
    v=a:FindFirstChild(H.HitPart)or a:FindFirstChild("Head")
    S=not v or not v:IsA("BasePart")
    if S then return
    end
    local E,R,x=H.ForceFieldCheck,bit32.band(2088375622,P)+bit32.band(2088375622,479618357)
    w,x=N:Aq(R+(bit32.band(2206591675,(bit32.bor(P,479618357)))+bit32.band(2206591673,(bit32.band(P,479618357))))),E and not H.PrefireForceField
    if x then S="ForceField"
        if a:FindFirstChildOfClass(S)then return
        end
    end
    S=getgenv().LocalPlayer.Character
    P=not S or not S:FindFirstChild("HumanoidRootPart")
    if P then return
    end
    E=S.HumanoidRootPart
    x=(S:FindFirstChildOfClass("Tool"))
    P=not x or not x:FindFirstChild("Handle")
    if P then return
    end
    local q,L=x.Handle.Position,v.Position
    local Y=getgenv().glue_spoof and getgenv().glue_active and L or E.Position
    if H.UseMaxDistance and(Y-L).Magnitude>H.MaxDistance then return
    end
    if H.WallCheck and getgenv().FH_IsWallBetween then P,E=pcall(function()return getgenv().FH_IsWallBetween(Y,L,a)
        end)
        if P and E then return
        end
    end
    E=string.lower(x.Name)
    P=H.Pellets or(string.find(E,"shotgun")or string.find(E,"tactical")or string.find(E,"db"))and 5
    S,R=P or 1,{}
    for x=1,S,1 do local Y=40745726
        P=nil
        P,Y=S>1,N:Aq(Y+180473499)
        local S=L+(P and Vector3.new(math.random(-1.5,1.5)/10,math.random(-1.5,1.5)/10,math.random(-1.5,1.5)/10)or Vector3.new(0.0,0.0,0.0))
        table.insert(R,{PELLET=x,POSITION=S,MODEL=a,PART=v})
        pcall(function()if ShowHitEffect then ShowHitEffect(S)
            end
        end)
    end
    E,v,P=L+(L-q).Unit*25
    v,P,w=getgenv(),getgenv,bit32.bxor(w,96153379)
    v.FH_Index=(P().FH_Index+1)%100
    local S={INDEX=getgenv().FH_Index,AIM=E,ORIGIN=q,HITS=R}
    pcall(function()getgenv().MainEvent:FireServer("Shoot",S)
    end)
    H.LastShotTime=tick()
end
X[954]=getgenv()
X[954].FH_Fire = Config.FH_Fire
X[956]=getgenv()
X[956].FH_Fire = Config.FH_Fire
getgenv().FH_GlobalShieldDuration=4
task.spawn(function()local S=204330350
    local w=S
    local P=getgenv
    S=N:Aq(bit32.band(410168759,w)+bit32.band(410168759,477823991)+(bit32.band(3474629778,(bit32.bor(w,477823991)))+bit32.band(410168760,(bit32.bxor(w,477823991)))))
    w=P()
    S=bit32.bxor(S,420535307)
    local function S(P)local a=318422107
        local v=a
        local H
        H,a=getgenv(),N:Aq(v+376188246)
        if P==H.LocalPlayer then return
        end
        a,getgenv().setupChar=N:Aq(a-46561403),function(a)local v=176554415
            local H=v
            if not a then return
            end
            v=N:Aq(H+480380835)
            H=nil
            H,v=a.ChildAdded,N:Aq(v-167417154)
            H:Connect(function(a)local v=a:IsA("ForceField")
                if v then local v=220227681
                    local H=v
                    local E
                    E,v=tick,bit32.bxor(H,71593362)
                    local H,R,x=E(),false
                    v=N:Aq(bit32.band(1213957216,v)+bit32.band(1213957216,235139198)+(bit32.band(1867052864,(bit32.bor(v,235139198)))+bit32.band(1213957217,(bit32.bxor(v,235139198)))))
                    local function v(E,q)if not q then E=tick()-H
                    if E>1 and E<15 then getgenv().FH_GlobalShieldDuration=E
                end
                if x then x:Disconnect()
                end
            end
        end
        x=a.AncestryChanged:Connect(v)
        local v
        v=getgenv().RunService.Heartbeat:Connect(function()local E={}
            if not a or not a.Parent then if v then v:Disconnect()
                end
                return
            end
            local a,v=tick()-H,Config.ForceHit.PrefireForceField and Config.ForceHit.Enabled and Config.ForceHit.Active and P==Config.ForceHit.Target and not R
            if v then local v=Config.ForceHit.PrefireTime
                local H=a>=getgenv().FH_GlobalShieldDuration-v
                if H then local a=165155284
                    v=a
                    R=true
                    a=N:Aq(bit32.band(1571686160,v)+bit32.band(1571686160,383991031)+(bit32.band(2723281137,(bit32.bor(v,383991031)))+bit32.band(2723281135,(bit32.band(v,383991031)))))
                    local v=Config.ForceHit.ForceFieldCheck
                                        Config.ForceHit.ForceFieldCheck = false
                    a=bit32.bxor(a,388840987)
                    task.spawn(function()getgenv().FH_Fire(P)
                end)
                                Config.ForceHit.ForceFieldCheck = v
            end
        end
    end)
end
end)
end
if P.Character then getgenv().setupChar(P.Character)
end
P.CharacterAdded:Connect(getgenv().setupChar)
end
w.monitor=S
for S,S in ipairs(getgenv().Players:GetPlayers())do getgenv().monitor(S)
end
getgenv().Players.PlayerAdded:Connect(getgenv().monitor)
end)
getgenv().send_notification=function()end
getgenv().am_i_knocked=function()if not getgenv().LocalPlayer.Character then return false
    end
    local S=getgenv().LocalPlayer.Character:FindFirstChild("BodyEffects")
    if not S then return false
    end
    S=getgenv().LocalPlayer.Character.BodyEffects:FindFirstChild("K.O")or getgenv().LocalPlayer.Character.BodyEffects:FindFirstChild("KO")
    return S and S.Value
end
getgenv().get_position_offset=function()local S,w=getgenv().glue_offset_z,getgenv().glue_position
    local P=w=="Back"
    if P then return CFrame.new(0,0,S)
    else local P=w=="Front"
        if P then return CFrame.new(0,0,-S)
        else local P=w=="Left Side"
            if P then return CFrame.new(-S,0,0)
            else local P=w=="Random"
                if P then local P,a=math.rad(math.random(0,360)),math.rad(math.random(-50,60))
                    return CFrame.new(math.cos(P)*math.cos(a)*S,math.sin(a)*(S*0.6),math.sin(P)*math.cos(a)*S)
                else local P="Backstab"
                    if w==P then return CFrame.new(0,0,S)
                end
            end
        end
    end
end
return CFrame.new(0,0,S)
end
getgenv().reset_velocity=function()local S=getgenv().get_root_part()
    if S then S.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0)
        S.AssemblyAngularVelocity=Vector3.new(0.0,0.0,0.0)
    end
end
X[10]=getgenv
X[51]=function(S)local w=S and S.Character and S.Character:FindFirstChild("BodyEffects")
    if w then local w=S.Character.BodyEffects:FindFirstChild("K.O")or S.Character.BodyEffects:FindFirstChild("KO")
        return w and w.Value
    end
    return false
end
X[958]=X[10]()
X[958].is_knocked=X[51]
getgenv().get_root_part=function()local S=getgenv().LocalPlayer.Character
    if not S then return nil
    end
    local w=S:FindFirstChildOfClass("Humanoid")
    if not w or w.Health<=0 then return nil
    end
    if getgenv().am_i_knocked and getgenv().am_i_knocked()then return nil
    end
    return w.RootPart
end
X[23]=getgenv
X[17]=function()local S=496378752
    local w=S
    S=N:Aq(bit32.band(269854152,w)+bit32.band(269854152,51681330)+(bit32.band(3755258992,(bit32.bor(w,51681330)))+bit32.band(269854153,(bit32.bxor(w,51681330)))))
    local function S(P)if not P or not P.Character then return nil
        end
        local a=P.Character
        P=(a:FindFirstChildOfClass("Humanoid"))
        if not P or P.Health<=0 then return nil
        end
        P=(a:FindFirstChild("BodyEffects"))
        local v,H=P and(P:FindFirstChild("K.O")or P:FindFirstChild("KO")),P and(P:FindFirstChild("Dead")or P:FindFirstChild("SDeath"))
        if v and v.Value or H and H.Value then return nil
        end
        P="HumanoidRootPart"
        return a:FindFirstChild(P)
    end
    for P,P in pairs(getgenv().target_players)do w=S((getgenv().Players:FindFirstChild(P)))
        if w then return w
        end
    end
    return S(Config.ForceHit and Config.ForceHit.Target)
end
X[959]=X[23]()
X[959].get_target_root=X[17]
getgenv().get_target_list_string=function()local S=#getgenv().target_players==0
    if S then return "No targets selected" end
    local S,w,P=table.concat,getgenv().target_players,", "
    return S(w,P)
end
X[134]=getgenv
X[56]=function()local S,w="No target selected",getgenv().am_i_knocked()
    if w then return "You are knocked out" end
    if#getgenv().target_players==0 then return S
    end
    local P,a=pairs,getgenv().target_players
    for v,H in P(a)do w=getgenv().Players:FindFirstChild(H)
        v=not w
        if v then local P=" not found in game"
            return H..P
        end
        v=not w.Character
        if v then local P=" has no character"
            return H..P
        end
        v=(w.Character:FindFirstChildOfClass("Humanoid"))
        local P=not v
        if P then local a=" has no humanoid"
            return H..a
        end
        P=v.Health<getgenv().min_target_health
        if P then local a=" health too low ("..math.floor(v.Health).."/"..math.floor(v.MaxHealth)..")"
            return H..a
        end
        P=getgenv().is_knocked(w)
        if P then local w=" is knocked out"
            return H..w
        end
        P=getgenv().get_root_part()
        local w=not P
        if w then return "You have no character" end
        w=v.RootPart
        v=not w
        if v then local a=" has no root part"
            return H..a
        end
        v=(w.Position-P.Position).Magnitude
        P=v>getgenv().max_connection_distance
        if P then w=" too far ("..math.floor(v).." studs / max "..getgenv().max_connection_distance..")"
            return H..w
        end
        S=H.." is valid and ready"
        break
    end
    return S
end
X[960]=X[134]()
X[960].check_target_validity=X[56]
getgenv().start_target_status_loop=function()local S=208240202
    local w=S
    local P=getgenv().target_status_update_loop
    S=bit32.bxor(w,519109949)
    if P then getgenv().target_status_update_loop:Disconnect()
        getgenv().target_status_update_loop=nil
    end
    local w,P,a
    w,P,S,a=getgenv(),getgenv(),N:Aq(bit32.band(617265139,S)+bit32.band(617265139,83411089)+(bit32.band(3677702158,(bit32.bor(S,83411089)))+bit32.band(3677702156,(bit32.band(S,83411089))))),function()if not getgenv().show_target_status then if getgenv().target_status_update_loop then getgenv().target_status_update_loop:Disconnect()
                getgenv().target_status_update_loop=nil
            end
            return
        end
        local S=getgenv().am_i_knocked()
        if S and not getgenv().last_knockdown_notified then getgenv().last_knockdown_notified=true
        elseif not S and getgenv().last_knockdown_notified then getgenv().last_knockdown_notified=false
            end
            if S then return
            end
            local S,v=getgenv().check_target_validity(),getgenv().get_target_list_string()
            if S~=getgenv().last_status_message then getgenv().last_status_message=S
            end
            if v~=getgenv().last_target_list then getgenv().last_target_list=v
            end
        end
        w.target_status_update_loop=P.RunService.Heartbeat:Connect(a)
    end
    X[68]=nil
    X[141]=nil
    X[68]=(getgenv())
    X[68].KnifeRage = {Enabled=false,HitDuration=0.09,VoidDuration=0.4,CycleStart=tick()}
    getgenv().isKnifeSwinging=function()local S=getgenv().LocalPlayer
        local w=S and S.Character
        local P,a=w and w:FindFirstChildOfClass("Humanoid"),w and w:FindFirstChild("[Knife]")
        if not a or not P or P.Health<=0 or not getgenv().KnifeRage.Enabled then return false
        end
        P,S=tick(),getgenv().KnifeRage.HitDuration+getgenv().KnifeRage.VoidDuration
        if(P-getgenv().KnifeRage.CycleStart)%S<=getgenv().KnifeRage.HitDuration then return true
        else return false
        end
    end
    getgenv().GlueVis={Enabled=false,Color=Color3.fromRGB(255,140,0),Transparency=0.5,TracerEnabled=true,TracerColor=Color3.fromRGB(255,140,0),IndicatorEnabled=true,Folder=nil,Connection=nil,Parts={}}
    getgenv().GlueVis_LastDestination=nil
    X[961]=getgenv()
    X[961].GlueTracer = (Drawing.new("Line"))
    getgenv().GlueTracer.Thickness=1.5
    getgenv().GlueTracer.Color=Color3.fromRGB(255,140,0)
    getgenv().GlueTracer.Visible=false
    getgenv().GlueVis_Destroy=function()if getgenv().GlueVis.Connection then getgenv().GlueVis.Connection:Disconnect()
            getgenv().GlueVis.Connection=nil
        end
        if getgenv().GlueVis.Folder then getgenv().GlueVis.Folder:Destroy()
            getgenv().GlueVis.Folder=nil
        end
        getgenv().GlueVis.Parts={}
        getgenv().GlueVis_LastDestination=nil
        if getgenv().GlueTracer then getgenv().GlueTracer.Visible=false
        end
    end
    X[64]=getgenv
    X[128]=function()local S={}
        local w=143287062
        local P=w
        getgenv().GlueVis_Destroy()
        local a=getgenv().LocalPlayer.Character
        local v=a and a:FindFirstChild("HumanoidRootPart")
        if not a or not v then return
        end
        local H=Instance.new("Folder")
        S[1]="GlueVisualizer"
        H.Name=S[1]
        H.Parent=workspace
        local S=getgenv()
        w=N:Aq(bit32.band(273908713,P)+bit32.band(273908713,107041795)+(bit32.band(3747149870,(bit32.bor(P,107041795)))+bit32.band(273908714,(bit32.bxor(P,107041795)))))
        S.GlueVis.Folder=H
        S,P=ipairs,table.pack(a:GetChildren())
        w=bit32.bxor(w,139580917)
        for w,E in S(table.unpack(P))do a=E:IsA("BasePart")and E.Name~="HumanoidRootPart"
            if a then w=(Instance.new("Part"))
                w.Size=E.Size
                w.Anchored=true
                w.CanCollide=false
                w.CastShadow=false
                w.Material=Enum.Material.Neon
                w.Color=getgenv().GlueVis.Color
                w.Transparency=getgenv().GlueVis.Transparency
                w.TopSurface=Enum.SurfaceType.Smooth
                w.BottomSurface=Enum.SurfaceType.Smooth
                w.Parent=H
                local S,P=getgenv().GlueVis.Parts,{part=w}
                P.offset,S[E]=v.CFrame:Inverse()*E.CFrame,P
            end
        end
        getgenv().GlueVis.Connection=getgenv().RunService.RenderStepped:Connect(function(S)S=getgenv().glue_active==true
            local w=getgenv().GlueVis.Enabled and S
            local P,a=w and getgenv().GlueVis_LastDestination or nil,workspace.CurrentCamera
            S=w and P~=nil
            for v,H in pairs(getgenv().GlueVis.Parts)do if not v.Parent or not H.part or not H.part.Parent then getgenv().GlueVis.Parts[v]=nil
                elseif S then H.part.CFrame=P*H.offset
                    H.part.Color=getgenv().GlueVis.Color
                    H.part.Transparency=getgenv().GlueVis.Transparency
                else H.part.Transparency=1
                end
            end
            if w and getgenv().GlueVis.TracerEnabled and P~=nil then S=P.Position
                local w,P=a:WorldToViewportPoint(S)
                if P and w.Z>0 then local S=getgenv().UserInputService:GetMouseLocation()
                    getgenv().GlueTracer.From=S
                    getgenv().GlueTracer.To=Vector2.new(w.X,w.Y)
                    getgenv().GlueTracer.Color=getgenv().GlueVis.TracerColor
                    getgenv().GlueTracer.Visible=true
                else getgenv().GlueTracer.Visible=false
                end
            else getgenv().GlueTracer.Visible=false
            end
        end)
    end
    X[963]=X[64]()
    X[963].GlueVis_Create=X[128]
    X[14]=getgenv().LocalPlayer
    X[51]=function()task.wait(0.15)
        getgenv().GlueVis_LastDestination=nil
        if getgenv().GlueVis.Enabled then getgenv().GlueVis_Create()
        end
    end
    X[14].CharacterAdded:Connect(X[51])
    getgenv().connection_loop=nil
    X[151]=function(S,w)local P=515681641
        local a=P
        local v
        v,P=sethiddenproperty,bit32.bxor(a,415237672)
        if not v or not S or not w then return
        end
        a=nil
        a,P=pcall,N:Aq(bit32.band(62186465,P)+bit32.band(62186465,402089619)+(bit32.band(4232780832,(bit32.bor(P,402089619)))+bit32.band(4232780830,(bit32.band(P,402089619)))))
        a(function()sethiddenproperty(S,"PhysicsRepRootPart",w)
            local P=InstanceHandle
            if P then local P=475486145
                local a=P
                local v
                v,P=pcall,N:Aq(a+277491401)
                v(function()sethiddenproperty(S,"PhysicsRepRootRef",InstanceHandle.new(w))
                end)
            end
        end)
    end
    getgenv().unc_connection=function()local S=213807466
        local w=S
        local P
        P,S=getgenv,N:Aq(w+20076180)
        if P().connection_loop then getgenv().connection_loop:Disconnect()
            getgenv().connection_loop=nil
        end
        w=getgenv().LocalPlayer.Character
        P=w and w:FindFirstChild("HumanoidRootPart")
        if P then P.CanCollide=false
        end
        local w,P,a=getgenv(),getgenv
        a,S=P().RunService,N:Aq(S+331174549)
        w.connection_loop=a.Heartbeat:Connect(function()local S={}
            local w=not getgenv().glue_active
            if w then if getgenv().connection_loop then getgenv().connection_loop:Disconnect()
                    getgenv().connection_loop=nil
                end
                getgenv().reset_velocity()
                getgenv().resetStrafeCamera()
                getgenv().GlueVis_LastDestination=nil
                local P=getgenv().LocalPlayer.Character
                local a=P and P:FindFirstChild("HumanoidRootPart")
                if a then a.CanCollide=true
                    X[151](a,a)
                end
                return
            end
            local P,a=getgenv().get_root_part(),getgenv().get_target_root()
            if not P or not a then getgenv().GlueVis_LastDestination=nil
                return
            end
            w=getgenv().glue_offset_z or 3
            local v,H=Vector3.new(0,0,w),getgenv().glue_position
            local E=H=="Front"
            if E then v=Vector3.new(0,0,-w)
            else local R=H=="Left Side"
                if R then v=Vector3.new(-w,0,0)
                else local R=H=="Backstab"or H=="Back"
                    if R then v=Vector3.new(0,0,w)
                else local R="Random"
                    if H==R then local R=math.rad(math.random(0,360))
                    v=Vector3.new(math.cos(R)*w,0,math.sin(R)*w)
                end
            end
        end
    end
    w=a.CFrame*CFrame.new(v)
    getgenv().GlueVis_LastDestination=w
    E=nil
    if getgenv().KnifeRage and getgenv().KnifeRage.Enabled then if getgenv().KnifeRage.AutoCalculate and getgenv().isKnifeSwinging then E=if not getgenv().isKnifeSwinging()then CFrame.new(a.Position+Vector3.new(math.random()<0.5 and 900000 or-900000,900000,math.random()<0.5 and 900000 or-900000))else w
            else H=getgenv().KnifeRage.Interval or 0.12
                E=if math.floor(tick()/H)%2==0 then CFrame.new(a.Position+Vector3.new(math.random()<0.5 and 900000 or-900000,900000,math.random()<0.5 and 900000 or-900000))else w
                end
            else E=w
            end
            H=getgenv().glue_spoof
            if H then local v,H=P.CFrame,getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if Config.DesyncPart then Config.DesyncPart.CFrame = v+Vector3.new(0,5,0)
                    getgenv().strafeCamera.CameraSubject = Config.DesyncPart
                end
                X[151](P,a)
                P.CFrame=E
                getgenv().RunService.RenderStepped:Wait()
                w=H and H.MoveDirection*H.WalkSpeed*0.011111111111111112*0.1 or Vector3.new(0.0,0.0,0.0)
                P.CFrame=CFrame.new(v.Position+w)*(v-v.Position)
                getgenv().resetStrafeCamera()
            else X[151](P,a)
                P.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0)
                P.AssemblyAngularVelocity=Vector3.new(0.0,0.0,0.0)
                P.CFrame=E
            end
        end)
    end
    getgenv().no_unc_connection=function()getgenv().unc_connection()
    end
    X[51]=getgenv
    X[67]=function()if not getgenv().LocalPlayer.Character then return nil
        end
        local S,w=ipairs,table.pack(getgenv().LocalPlayer.Character:GetChildren())
        for P,a in S(table.unpack(w))do P=a:IsA("Tool")and a.Name=="[Knife]"
            if P then return a
            end
        end
        return nil
    end
    X[964]=X[51]()
    X[964].get_knife=X[67]
    getgenv().equip_knife=function()local S=getgenv().LocalPlayer.Character
        if not S then return nil
        end
        local w=getgenv().get_knife()
        if w then return w
        end
        w=(getgenv().LocalPlayer:FindFirstChild("Backpack"))
        if w then local P=w:FindFirstChild("[Knife]")
            if P then P.Parent=S
                return P
            end
        end
        return nil
    end
    getgenv().start_auto_knife=function()local S=331300800
        local w=S
        local P=getgenv()
        S=N:Aq(bit32.band(224517682,w)+bit32.band(224517682,70192489)+(bit32.band(4070449615,(bit32.bor(w,70192489)))+bit32.band(4070449613,(bit32.band(w,70192489)))))
        S=bit32.bxor(S,48912131)
        if P.auto_knife_loop then getgenv().auto_knife_loop:Disconnect()
            getgenv().auto_knife_loop=nil
        end
        getgenv().auto_knife_loop=getgenv().RunService.Heartbeat:Connect(function()if not getgenv().AutoKnifeEnabled then getgenv().auto_knife_loop:Disconnect()
                getgenv().auto_knife_loop=nil
                return
            end
            if tick()-(getgenv().LastRespawnTime or 0)<1 then return
            end
            if not getgenv().glue_active then return
            end
            if not getgenv().get_target_root()then local S=getgenv().get_knife()
                if S then local w=248609407
                    local P=w
                    local a
                    a,w=pcall,N:Aq(bit32.band(391088246,P)+bit32.band(391088246,192468108)+(bit32.band(3903879051,(bit32.bor(P,192468108)))+bit32.band(3903879049,(bit32.band(P,192468108)))))
                    a(function()S:Deactivate()
                end)
            end
            return
        end
        local S=getgenv().LocalPlayer.Character
        local w=S and S:FindFirstChildOfClass("Humanoid")
        if not w or w.Health<=0 then return
        end
        if getgenv().am_i_knocked and getgenv().am_i_knocked()then return
        end
        local w=getgenv().equip_knife()
        if w then local P=426237258
            S=nil
            S,P=pcall,N:Aq(P+274262213)
            S(function()w:Activate()
            end)
        end
    end)
end
X[48]=getgenv().RunService
X[55]=function()if not getgenv().glue_spoof then return
    end
    if not getgenv().glue_active then return
    end
    if not getgenv().KnifeHitboxEnabled then return
    end
    local S=getgenv().LocalPlayer.Character
    local w=S and S:FindFirstChild("[Knife]")
    S=w and w:FindFirstChild("Handle")
    w=S and S:FindFirstChild("HITBOX_PART")
    if not w then return
    end
    S=getgenv().get_target_root()
    if not S then return
    end
    local P=w.CFrame
    w.CFrame=S.CFrame
    getgenv().RunService.RenderStepped:Wait()
    w.CFrame=P
end
X[48].Heartbeat:Connect(X[55])
getgenv().KnifeVisualizerEnabled=false
X[965]=getgenv()
X[965].KnifeVisualizerMode = "Highlight"
getgenv().KnifeVisualizerColor=Color3.fromRGB(255,120,120)
getgenv().KnifeVisualizerOutlineColor=Color3.fromRGB(255,255,255)
getgenv().KnifeVisualizerFillTransparency=0.6
getgenv().KnifeVisualizerOutlineTransparency=0.1
X[967]=getgenv()
X[968]={}
X[968].Enabled=false
X[968].Style="Adornment"
X[968].Color=Color3.fromRGB(120,150,255)
X[968].OutlineColor=Color3.fromRGB(255,255,255)
X[968].Transparency=0.65
X[968].AlwaysOnTop=true
X[968].Pulse=true
X[968].PulseSpeed=3
X[967].KnifeVisualizerConfig = X[968]
X[152]=function(S)if S then local w,P,a,v=ipairs,{},"Visualizer_Adornment","Visualizer_Box"
        N:jq(P,0,a,v,"Visualizer_Highlight")
        for a,v in w(P)do a=S:FindFirstChild(v)
            if a then a:Destroy()
            end
        end
    end
    S=workspace.CurrentCamera
    if S then local S=workspace.CurrentCamera:FindFirstChild("Visualizer_Ghost")
        if S then S:Destroy()
        end
    end
end
X[102]=getgenv
X[108]=function(S)local w={}
    local P=not S or not S:IsA("BasePart")
    if P then return
    end
    local a=getgenv().KnifeVisualizerConfig
    X[152](S)
    if not a.Enabled then return
    end
    P=a.Style=="Adornment"
    if P then local P=Instance.new("BoxHandleAdornment")
        w[1]="Visualizer_Adornment"
        P.Name=w[1]
        P.Adornee=S
        P.Size=S.Size
        P.Color3=a.Color
        P.Transparency=a.Transparency
        P.AlwaysOnTop=a.AlwaysOnTop
        P.ZIndex=5
        P.Parent=S
    else local P=a.Style=="Hologram"
        if P then local P=118796000
            local v=P
            local H=Instance.new("Part")
            w[2]="Visualizer_Ghost"
            H.Name=w[2]
            H.Size=S.Size
            H.CFrame=S.CFrame
            P=bit32.bxor(v,110572213)
            H.Material=Enum.Material.ForceField
            H.Color=a.Color
            H.Transparency=a.Transparency
            H.CastShadow=false
            H.CanCollide=false
            H.CanQuery=false
            H.CanTouch=false
            H.Anchored=true
            P=N:Aq(bit32.band(2969706133,P)+bit32.band(2969706133,369127965)+(bit32.band(2650522326,(bit32.bor(P,369127965)))+bit32.band(2969706134,(bit32.bxor(P,369127965)))))
            local P
            v=p
            local E,R=v:GetService("RunService"),function()local v=not S or not S.Parent or not H or not H.Parent or not a.Enabled or a.Style~="Hologram"
                if v then if H and H.Parent then H:Destroy()
                end
                if P then P:Disconnect()
                end
                return
            end
            H.CFrame=S.CFrame
            H.Size=S.Size
        end
        P=E.RenderStepped:Connect(R)
        H.Parent=workspace.CurrentCamera
    else local P=a.Style=="Wireframe"
        if P then local P=Instance.new("SelectionBox")
            w[3]="Visualizer_Box"
            P.Name=w[3]
            P.Adornee=S
            P.LineThickness=0.02
            P.Color3=a.OutlineColor
            P.SurfaceColor3=a.Color
            P.Transparency=0.1
            P.SurfaceTransparency=a.Transparency
            P.Parent=S
        else local P=a.Style=="Highlight"
            if P then local P=Instance.new("Highlight")
                w[4]="Visualizer_Highlight"
                P.Name=w[4]
                P.Adornee=S
                P.FillColor=a.Color
                P.OutlineColor=a.OutlineColor
                P.FillTransparency=a.Transparency
                P.OutlineTransparency=0.2
                P.DepthMode=a.AlwaysOnTop and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
                P.Parent=S
            end
        end
    end
end
end
X[970]=X[102]()
X[970].updateHitboxVisualizer=X[108]
X[59]=getgenv
X[53]=function(S)local w={}
    local P=not S or not S:IsA("BasePart")
    if P then return
    end
    P=getgenv().KnifeVisualizerConfig
    X[152](S)
    if not P.Enabled then return
    end
    local a=P.Style=="Adornment"
    if a then local a=Instance.new("BoxHandleAdornment")
        w[1]="Visualizer_Adornment"
        a.Name=w[1]
        a.Adornee=S
        a.Size=S.Size
        a.Color3=P.Color
        a.Transparency=P.Transparency
        a.AlwaysOnTop=P.AlwaysOnTop
        a.ZIndex=5
        a.Parent=S
    else local a=P.Style=="Hologram"
        if a then local a=71973360
            local v=a
            local H=Instance.new("Part")
            w[2]="Visualizer_Ghost"
            H.Name=w[2]
            local E
            E,a=S.Size,bit32.bxor(v,264216544)
            H.Size=E
            H.CFrame=S.CFrame
            v=nil
            v,a=Enum.Material.ForceField,N:Aq(bit32.band(3316208235,a)+bit32.band(3316208235,29794495)+(bit32.band(1957518122,(bit32.bor(a,29794495)))+bit32.band(3316208236,(bit32.bxor(a,29794495)))))
            H.Material=v
            H.Color=P.Color
            H.Transparency=P.Transparency
            H.CastShadow=false
            H.CanCollide=false
            H.CanQuery=false
            H.CanTouch=false
            H.Anchored=true
            local a
            v=p
            local E,R=v:GetService("RunService"),function()if not S or not S.Parent or not H or not H.Parent then if H and H.Parent then H:Destroy()
                end
                if a then a:Disconnect()
                end
                return
            end
            H.CFrame=S.CFrame
            H.Size=S.Size
        end
        a=E.RenderStepped:Connect(R)
        H.Parent=workspace.CurrentCamera
    else local a=P.Style=="Wireframe"
        if a then local a=Instance.new("SelectionBox")
            w[3]="Visualizer_Box"
            a.Name=w[3]
            a.Adornee=S
            a.LineThickness=0.02
            a.Color3=P.OutlineColor
            a.SurfaceColor3=P.Color
            a.Transparency=0.1
            a.SurfaceTransparency=P.Transparency
            a.Parent=S
        else local a=P.Style=="Highlight"
            if a then local a=Instance.new("Highlight")
                w[4]="Visualizer_Highlight"
                a.Name=w[4]
                a.Adornee=S
                a.FillColor=P.Color
                a.OutlineColor=P.OutlineColor
                a.FillTransparency=P.Transparency
                a.OutlineTransparency=0.2
                a.DepthMode=P.AlwaysOnTop and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
                a.Parent=S
            end
        end
    end
end
end
X[971]=X[59]()
X[971].updateHitboxVisualizer=X[53]
X[153]=function()local S={}
    local w=getgenv().LocalPlayer.Character
    local P={}
    N:jq(P,0,w)
    S[1]=(getgenv().LocalPlayer:FindFirstChild("Backpack"))
    N:jq(P,1,S[1])
    local S,a=P,ipairs
    for P,v in a(S)do if v then w=(v:FindFirstChild("[Knife]"))
            P=w and w:FindFirstChild("Handle")
            local S=P and(P:FindFirstChild("HITBOX_PART")or P)
            if S then if getgenv().KnifeHitboxEnabled then S.Size=Vector3.new(getgenv().SIZE_X or 21,getgenv().SIZE_Y or 21,getgenv().SIZE_Z or 21)
                    S.Transparency=0.99
                    S.Massless=true
                    S.CanCollide=false
                else S.Size=Vector3.new(2,2,2)
                    S.Transparency=0
                end
                getgenv().updateHitboxVisualizer(S)
            end
        end
    end
end
X[82]=getgenv
X[6]=function(S)local w=5406641
    local P=w
    w=N:Aq(bit32.band(1021867313,P)+bit32.band(1021867313,477337414)+(bit32.band(2251232670,(bit32.bor(P,477337414)))+bit32.band(1021867314,(bit32.bxor(P,477337414)))))
    P=nil
    P,w=S.ChildAdded,bit32.bxor(w,276758076)
    P:Connect(function(S)local w,P=S.Name,"[Knife]"
        if w~=P then return
        end
        task.wait()
        w=(S:FindFirstChild("Handle"))
        if not w then return
        end
        S=w:FindFirstChild("HITBOX_PART")or w
        if not S then return
        end
        if getgenv().KnifeHitboxEnabled then S.Size=Vector3.new(getgenv().SIZE_X or 21,getgenv().SIZE_Y or 21,getgenv().SIZE_Z or 21)
            S.Transparency=0.99
            S.Massless=true
            S.CanCollide=false
            S.CastShadow=false
        end
        getgenv().updateHitboxVisualizer(S)
    end)
end
X[972]=X[82]()
X[972].hook=X[6]
if getgenv().LocalPlayer.Character then getgenv().hook(getgenv().LocalPlayer.Character)
end
getgenv().LocalPlayer.CharacterAdded:Connect(getgenv().hook)
X[127]=getgenv().RunService
X[113]=function()local S={}
    if not(Config.ForceHit.Enabled and Config.ForceHit.Active)then return
    end
    if Config.ForceHit.AutoClosestTarget then Config.ForceHit.Target = (getgenv().FH_GetClosest())
    elseif Config.ForceHit.AutoClosestToCharacter then Config.ForceHit.Target = (getgenv().FH_GetClosestToCharacter())
        end
        local w=Config.ForceHit.Target
        if w and Config.ForceHit.Whitelist[w.Name]then             Config.ForceHit.Target = nil
            return
        end
        if not w or not w.Character then return
        end
        if tick()-Config.ForceHit.LastShotTime<Config.ForceHit.ShotCooldown then return
        end
        local S=w.Character:FindFirstChildOfClass("ForceField")
        if Config.ForceHit.ForceFieldCheck and S then return
        end
        getgenv().FH_Fire(w)
    end
    X[127].Heartbeat:Connect(X[113])
    X[973]=getgenv()
    X[973].TargetLine = (Drawing.new("Line"))
    X[975]=getgenv()
    X[975].TargetLineOutline = (Drawing.new("Line"))
    X[100]=getgenv().RunService
    X[43]=function()local S=Config.ForceHit
        if not(S.ShowTargetLine and S.Enabled and S.Active and S.Target)then getgenv().TargetLine.Visible=false
            getgenv().TargetLineOutline.Visible=false
            return
        end
        local w=S.Target.Character
        if not w then getgenv().TargetLine.Visible=false
            getgenv().TargetLineOutline.Visible=false
            return
        end
        local P=w:FindFirstChild(S.HitPart)
        if not P then getgenv().TargetLine.Visible=false
            getgenv().TargetLineOutline.Visible=false
            return
        end
        local a,v,H=getgenv().UserInputService:GetMouseLocation(),workspace.CurrentCamera:WorldToViewportPoint(P.Position)
        if H then w,P=Vector2.new(v.X,v.Y),1-S.LineTransparency
            getgenv().TargetLineOutline.From=a
            getgenv().TargetLineOutline.To=w
            getgenv().TargetLineOutline.Color=Color3.new(0,0,0)
            getgenv().TargetLineOutline.Thickness=S.LineThickness+1.5
            getgenv().TargetLineOutline.Transparency=P
            getgenv().TargetLineOutline.ZIndex=1
            getgenv().TargetLineOutline.Visible=true
            getgenv().TargetLine.From=a
            getgenv().TargetLine.To=w
            getgenv().TargetLine.Color=S.LineColor
            getgenv().TargetLine.Thickness=S.LineThickness
            getgenv().TargetLine.Transparency=P
            getgenv().TargetLine.ZIndex=2
            getgenv().TargetLine.Visible=true
        else getgenv().TargetLine.Visible=false
            getgenv().TargetLineOutline.Visible=false
        end
    end
    X[100].RenderStepped:Connect(X[43])
    X[69]=getgenv
    X[111]=X[69]().RunService
    X[141]=function()local S={}
        local w=237581906
        local P=w
        w=bit32.bxor(P,482256719)
        P=not(Config.ForceHit.Enabled and Config.ForceHit.Active)
        w=N:Aq(bit32.band(1745579765,w)+bit32.band(1745579765,187757159)+(bit32.band(803807766,(bit32.bor(w,187757159)))+bit32.band(1745579766,(bit32.bxor(w,187757159)))))
        if P then return
        end
        if Config.ForceHit.AutoClosestTarget then return
        end
        P=Config.ForceHit.TargetQueue
        if#P==0 then return
        end
        local w=Config.ForceHit.Target
        local function a(v)if not v or not v.Character then return false
            end
            local H=v.Character:FindFirstChildOfClass("Humanoid")
            if not H or H.Health<=0 then return false
            end
            H=(v.Character:FindFirstChild("BodyEffects"))
            v=H and H:FindFirstChild("K.O")and H["K.O"].Value
            if v then return false
            end
            return true
        end
        local v=not a(w)
        if v then local v
            for H,H in ipairs(P)do if H~=w and a(H)and not Config.ForceHit.Whitelist[H.Name]then v=H
                    break
                end
            end
            if v then                 Config.ForceHit.Target = v
                getgenv().Logging.new("crosshairs","Switched target to "..v.DisplayName,3)
            elseif not a(w)then                     Config.ForceHit.Target = nil
                end
            end
        end
        X[111].Heartbeat:Connect(X[141])
        do getgenv().TargetHUDConfig=getgenv().TargetHUDConfig or{FollowTarget=false,AccentColor=Color3.fromRGB(97,121,191)}
            if getgenv().TargetHudGui then pcall(function()getgenv().TargetHudGui:Destroy()
                end)
                getgenv().TargetHudGui=nil
            end
            local function S(w)local P=not w
                if P then return "None", "0" end
                P=(w:FindFirstChildOfClass("Tool"))
                w=not P
                if w then return "None", "-" end
                local a,v=P.Name:gsub("^%[",""):gsub("%]$",""),P:FindFirstChild("Ammo")or P:FindFirstChild("Script")and P.Script:FindFirstChild("Ammo")
                w=v or P:FindFirstChild("GunScript")and P.GunScript:FindFirstChild("Ammo")
                v=w and tostring(w.Value)or "-"
                return a,v
            end
            local w,P={}
            X[977]="1"
            P=p
            w[X[977]] = (Instance.new("ScreenGui",p:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")))
            X[979]=w["1"]
            X[980]="Name"
            X[979][X[980]] = "target hud"
            X[982]=w["1"]
            X[983]="ZIndexBehavior"
            X[982][X[983]] = Enum.ZIndexBehavior.Sibling
            X[985]=w["1"]
            X[986]="ResetOnSpawn"
            X[985][X[986]]=false
            X[987]=w["1"]
            X[988]="IgnoreGuiInset"
            X[987][X[988]]=true
            X[25]=not pcall(function()local P,a,v=w["1"],gethui and gethui()
                if a then v=a
                else local a=p
                    v=(a:GetService("CoreGui"))
                end
                P.Parent=v
            end)
            if X[25]then X[989]=w["1"]
                X[989].Parent = (getgenv().LocalPlayer:WaitForChild("PlayerGui"))
            end
            X[991]=getgenv()
            X[991].TargetHudGui = w["1"]
            X[993]="2"
            w[X[993]] = (Instance.new("Frame",w["1"]))
            X[995]=w["2"]
            X[996]="BorderSizePixel"
            X[995][X[996]]=0
            X[997]=w["2"]
            X[998]="BackgroundColor3"
            X[997][X[998]] = (Color3.fromRGB(11,11,11))
            X[1000]=w["2"]
            X[1001]="AnchorPoint"
            X[1000][X[1001]] = (Vector2.new(0.5,0.75))
            X[1003]=w["2"]
            X[1004]="Size"
            X[1003][X[1004]] = (UDim2.new(0,322,0,147))
            X[1006]=w["2"]
            X[1007]="Position"
            X[1006][X[1007]] = (UDim2.new(0.5,0,0.75,0))
            X[1009]=w["2"]
            X[1010]="Visible"
            X[1009][X[1010]]=false
            X[1011]=Instance.new("UICorner",w["2"])
            X[1011].CornerRadius = (UDim.new(0,8))
            local P=Instance.new("UIScale",w["2"])
            P.Scale=1
            X[1013]="3"
            w[X[1013]] = (Instance.new("Frame",w["2"]))
            X[1015]=w["3"]
            X[1016]="BorderSizePixel"
            X[1015][X[1016]]=0
            X[1017]=w["3"]
            X[1018]="BackgroundColor3"
            X[1017][X[1018]] = (Color3.fromRGB(97,121,191))
            X[1020]=w["3"]
            X[1021]="Size"
            X[1020][X[1021]] = (UDim2.new(1,-2,1,-2))
            X[1023]=w["3"]
            X[1024]="Position"
            X[1023][X[1024]] = (UDim2.new(0,1,0,1))
            X[1026]=Instance.new("UICorner",w["3"])
            X[1026].CornerRadius = (UDim.new(0,7))
            X[1028]="4"
            w[X[1028]] = (Instance.new("Frame",w["3"]))
            X[1030]=w["4"]
            X[1031]="BorderSizePixel"
            X[1030][X[1031]]=0
            X[1032]=w["4"]
            X[1033]="BackgroundColor3"
            X[1032][X[1033]] = (Color3.fromRGB(31,31,31))
            X[1035]=w["4"]
            X[1036]="Size"
            X[1035][X[1036]] = (UDim2.new(1,-2,1,-2))
            X[1038]=w["4"]
            X[1039]="Position"
            X[1038][X[1039]] = (UDim2.new(0,1,0,1))
            X[1041]=Instance.new("UICorner",w["4"])
            X[1041].CornerRadius = (UDim.new(0,6))
            X[1043]="5"
            w[X[1043]] = (Instance.new("Frame",w["4"]))
            X[1045]=w["5"]
            X[1046]="BorderSizePixel"
            X[1045][X[1046]]=0
            X[1047]=w["5"]
            X[1048]="BackgroundTransparency"
            X[1047][X[1048]]=1
            X[1049]=w["5"]
            X[1050]="Size"
            X[1049][X[1050]] = (UDim2.new(1,-2,1,-4))
            X[1052]=w["5"]
            X[1053]="Position"
            X[1052][X[1053]] = (UDim2.new(0,1,0,2))
            X[1055]="6"
            w[X[1055]] = (Instance.new("UIPadding",w["5"]))
            X[1057]=w["6"]
            X[1058]="PaddingLeft"
            X[1057][X[1058]] = (UDim.new(0,6))
            X[1060]="7"
            w[X[1060]] = (Instance.new("Frame",w["5"]))
            X[1062]=w["7"]
            X[1063]="BorderSizePixel"
            X[1062][X[1063]]=0
            X[1064]=w["7"]
            X[1065]="BackgroundColor3"
            X[1064][X[1065]] = (Color3.fromRGB(46,46,46))
            X[1067]=w["7"]
            X[1068]="Size"
            X[1067][X[1068]] = (UDim2.new(1,0,1,-18))
            X[1070]=w["7"]
            X[1071]="Position"
            X[1070][X[1071]] = (UDim2.new(0,-3,0,16))
            X[1073]=Instance.new("UICorner",w["7"])
            X[1073].CornerRadius = (UDim.new(0,6))
            X[1075]="8"
            w[X[1075]] = (Instance.new("Frame",w["7"]))
            X[1077]=w["8"]
            X[1078]="BorderSizePixel"
            X[1077][X[1078]]=0
            X[1079]=w["8"]
            X[1080]="BackgroundColor3"
            X[1079][X[1080]] = (Color3.fromRGB(11,11,11))
            X[1082]=w["8"]
            X[1083]="Size"
            X[1082][X[1083]] = (UDim2.new(1,-2,1,-2))
            X[1085]=w["8"]
            X[1086]="Position"
            X[1085][X[1086]] = (UDim2.new(0,1,0,1))
            X[1088]=Instance.new("UICorner",w["8"])
            X[1088].CornerRadius = (UDim.new(0,5))
            X[1090]="9"
            w[X[1090]] = (Instance.new("Frame",w["8"]))
            X[1092]=w["9"]
            X[1093]="BorderSizePixel"
            X[1092][X[1093]]=0
            X[1094]=w["9"]
            X[1095]="BackgroundColor3"
            X[1094][X[1095]] = (Color3.fromRGB(21,21,21))
            X[1097]=w["9"]
            X[1098]="Size"
            X[1097][X[1098]] = (UDim2.new(1,-2,1,-2))
            X[1100]=w["9"]
            X[1101]="Position"
            X[1100][X[1101]] = (UDim2.new(0,1,0,1))
            X[1103]=Instance.new("UICorner",w["9"])
            X[1103].CornerRadius = (UDim.new(0,4))
            X[1105]="a"
            w[X[1105]] = (Instance.new("UIPadding",w["9"]))
            X[1107]=w["a"]
            X[1108]="PaddingTop"
            X[1107][X[1108]] = (UDim.new(0,4))
            X[1110]=w["a"]
            X[1111]="PaddingLeft"
            X[1110][X[1111]] = (UDim.new(0,4))
            X[1113]="b"
            w[X[1113]] = (Instance.new("Frame",w["9"]))
            X[1115]=w["b"]
            X[1116]="BorderSizePixel"
            X[1115][X[1116]]=0
            X[1117]=w["b"]
            X[1118]="BackgroundColor3"
            X[1117][X[1118]] = (Color3.fromRGB(11,11,11))
            X[1120]=w["b"]
            X[1121]="Size"
            X[1120][X[1121]] = (UDim2.new(1,-4,1,-4))
            X[1123]=Instance.new("UICorner",w["b"])
            X[1123].CornerRadius = (UDim.new(0,4))
            X[1125]="c"
            w[X[1125]] = (Instance.new("Frame",w["b"]))
            X[1127]=w["c"]
            X[1128]="BorderSizePixel"
            X[1127][X[1128]]=0
            X[1129]=w["c"]
            X[1130]="BackgroundColor3"
            X[1129][X[1130]] = (Color3.fromRGB(46,46,46))
            X[1132]=w["c"]
            X[1133]="Size"
            X[1132][X[1133]] = (UDim2.new(1,-2,1,-2))
            X[1135]=w["c"]
            X[1136]="Position"
            X[1135][X[1136]] = (UDim2.new(0,1,0,1))
            X[1138]=Instance.new("UICorner",w["c"])
            X[1138].CornerRadius = (UDim.new(0,3))
            X[1140]="d"
            w[X[1140]] = (Instance.new("Frame",w["c"]))
            X[1142]=w["d"]
            X[1143]="BorderSizePixel"
            X[1142][X[1143]]=0
            X[1144]=w["d"]
            X[1145]="BackgroundColor3"
            X[1144][X[1145]] = (Color3.fromRGB(255,255,255))
            X[1147]=w["d"]
            X[1148]="Size"
            X[1147][X[1148]] = (UDim2.new(1,-2,1,-2))
            X[1150]=w["d"]
            X[1151]="Position"
            X[1150][X[1151]] = (UDim2.new(0,1,0,1))
            X[1153]=Instance.new("UICorner",w["d"])
            X[1153].CornerRadius = (UDim.new(0,2))
            X[1155]="e"
            w[X[1155]] = (Instance.new("UIGradient",w["d"]))
            X[1157]=w["e"]
            X[1158]="Color"
            X[1157][X[1158]] = (ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(30,30,30)),ColorSequenceKeypoint.new(1,Color3.fromRGB(21,21,21))}))
            X[1160]="f"
            w[X[1160]] = (Instance.new("UIPadding",w["d"]))
            X[1162]=w["f"]
            X[1163]="PaddingTop"
            X[1162][X[1163]] = (UDim.new(0,4))
            X[1165]=w["f"]
            X[1166]="PaddingRight"
            X[1165][X[1166]] = (UDim.new(0,3))
            X[1168]=w["f"]
            X[1169]="PaddingLeft"
            X[1168][X[1169]] = (UDim.new(0,4))
            X[1171]=w["f"]
            X[1172]="PaddingBottom"
            X[1171][X[1172]] = (UDim.new(0,3))
            X[1174]="10"
            w[X[1174]] = (Instance.new("Frame",w["d"]))
            X[1176]=w["10"]
            X[1177]="BorderSizePixel"
            X[1176][X[1177]]=0
            X[1178]=w["10"]
            X[1179]="BackgroundTransparency"
            X[1178][X[1179]]=1
            X[1180]=w["10"]
            X[1181]="Size"
            X[1180][X[1181]] = (UDim2.new(1,0,1,3))
            X[1183]="11"
            w[X[1183]] = (Instance.new("UIListLayout",w["10"]))
            X[1185]=w["11"]
            X[1186]="Padding"
            X[1185][X[1186]] = (UDim.new(0,4))
            X[1188]=w["11"]
            X[1189]="SortOrder"
            X[1188][X[1189]] = Enum.SortOrder.LayoutOrder
            X[1191]="12"
            w[X[1191]] = (Instance.new("UIPadding",w["10"]))
            X[1193]=w["12"]
            X[1194]="PaddingBottom"
            X[1193][X[1194]] = (UDim.new(0,4))
            X[1196]="13"
            w[X[1196]] = (Instance.new("Frame",w["10"]))
            X[1198]=w["13"]
            X[1199]="BorderSizePixel"
            X[1198][X[1199]]=0
            X[1200]=w["13"]
            X[1201]="BackgroundColor3"
            X[1200][X[1201]] = (Color3.fromRGB(46,46,46))
            X[1203]=w["13"]
            X[1204]="Size"
            X[1203][X[1204]] = (UDim2.new(1,-1,1,0))
            X[1206]="14"
            w[X[1206]] = (Instance.new("Frame",w["13"]))
            X[1208]=w["14"]
            X[1209]="BorderSizePixel"
            X[1208][X[1209]]=0
            X[1210]=w["14"]
            X[1211]="BackgroundColor3"
            X[1210][X[1211]] = (Color3.fromRGB(11,11,11))
            X[1213]=w["14"]
            X[1214]="Size"
            X[1213][X[1214]] = (UDim2.new(1,-2,1,-2))
            X[1216]=w["14"]
            X[1217]="Position"
            X[1216][X[1217]] = (UDim2.new(0,1,0,1))
            X[1219]="15"
            w[X[1219]] = (Instance.new("Frame",w["14"]))
            X[1221]=w["15"]
            X[1222]="BorderSizePixel"
            X[1221][X[1222]]=0
            X[1223]=w["15"]
            X[1224]="BackgroundColor3"
            X[1223][X[1224]] = (Color3.fromRGB(255,255,255))
            X[1226]=w["15"]
            X[1227]="Size"
            X[1226][X[1227]] = (UDim2.new(1,-2,1,-2))
            X[1229]=w["15"]
            X[1230]="Position"
            X[1229][X[1230]] = (UDim2.new(0,1,0,1))
            X[1232]="16"
            w[X[1232]] = (Instance.new("UIGradient",w["15"]))
            X[1234]=w["16"]
            X[1235]="Color"
            X[1234][X[1235]] = (ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(30,30,30)),ColorSequenceKeypoint.new(1,Color3.fromRGB(21,21,21))}))
            X[1237]="17"
            w[X[1237]] = (Instance.new("Frame",w["15"]))
            X[1239]=w["17"]
            X[1240]="BorderSizePixel"
            X[1239][X[1240]]=0
            X[1241]=w["17"]
            X[1242]="BackgroundColor3"
            X[1241][X[1242]] = (Color3.fromRGB(255,255,255))
            X[1244]=w["17"]
            X[1245]="Size"
            X[1244][X[1245]] = (UDim2.new(1,0,0,2))
            X[1247]=w["17"]
            X[1248]="Name"
            X[1247][X[1248]] = "bar"
            X[1250]=Instance.new("UICorner",w["17"])
            X[1250].CornerRadius = (UDim.new(0,1))
            X[1252]="18"
            w[X[1252]] = (Instance.new("UIGradient",w["17"]))
            X[1254]=w["18"]
            X[1255]="Color"
            X[1254][X[1255]] = (ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(97,120,190)),ColorSequenceKeypoint.new(1,Color3.fromRGB(101,113,169))}))
            X[1257]="19"
            w[X[1257]] = (Instance.new("Frame",w["15"]))
            X[1259]=w["19"]
            X[1260]="BorderSizePixel"
            X[1259][X[1260]]=0
            X[1261]=w["19"]
            X[1262]="BackgroundTransparency"
            X[1261][X[1262]]=1
            X[1263]=w["19"]
            X[1264]="Size"
            X[1263][X[1264]] = (UDim2.new(1,-2,1,-24))
            X[1266]=w["19"]
            X[1267]="Position"
            X[1266][X[1267]] = (UDim2.new(0,1,0,22))
            X[1269]=w["19"]
            X[1270]="Name"
            X[1269][X[1270]] = "holder"
            X[1272]="1a"
            w[X[1272]] = (Instance.new("UIPadding",w["19"]))
            X[1274]=w["1a"]
            X[1275]="PaddingTop"
            X[1274][X[1275]] = (UDim.new(0,-1))
            X[1277]=w["1a"]
            X[1278]="PaddingRight"
            X[1277][X[1278]] = (UDim.new(0,3))
            X[1280]=w["1a"]
            X[1281]="PaddingLeft"
            X[1280][X[1281]] = (UDim.new(0,3))
            X[1283]=w["1a"]
            X[1284]="PaddingBottom"
            X[1283][X[1284]] = (UDim.new(0,2))
            X[1286]="1b"
            w[X[1286]] = (Instance.new("Frame",w["19"]))
            X[1288]=w["1b"]
            X[1289]="BorderSizePixel"
            X[1288][X[1289]]=0
            X[1290]=w["1b"]
            X[1291]="BackgroundTransparency"
            X[1290][X[1291]]=1
            X[1292]=w["1b"]
            X[1293]="Size"
            X[1292][X[1293]] = (UDim2.new(1,0,1,0))
            X[1295]=w["1b"]
            X[1296]="Name"
            X[1295][X[1296]] = "playerinfo"
            X[1298]="1c"
            w[X[1298]] = (Instance.new("Frame",w["1b"]))
            X[1300]=w["1c"]
            X[1301]="BorderSizePixel"
            X[1300][X[1301]]=0
            X[1302]=w["1c"]
            X[1303]="BackgroundColor3"
            X[1302][X[1303]] = (Color3.fromRGB(11,11,11))
            X[1305]=w["1c"]
            X[1306]="Size"
            X[1305][X[1306]] = (UDim2.new(0,68,1,0))
            X[1308]=w["1c"]
            X[1309]="Name"
            X[1308][X[1309]] = "icon"
            X[1311]=Instance.new("UICorner",w["1c"])
            X[1311].CornerRadius = (UDim.new(0,6))
            X[1313]="1d"
            w[X[1313]] = (Instance.new("Frame",w["1c"]))
            X[1315]=w["1d"]
            X[1316]="BorderSizePixel"
            X[1315][X[1316]]=0
            X[1317]=w["1d"]
            X[1318]="BackgroundColor3"
            X[1317][X[1318]] = (Color3.fromRGB(46,46,46))
            X[1320]=w["1d"]
            X[1321]="Size"
            X[1320][X[1321]] = (UDim2.new(1,-2,1,-2))
            X[1323]=w["1d"]
            X[1324]="Position"
            X[1323][X[1324]] = (UDim2.new(0,1,0,1))
            X[1326]=Instance.new("UICorner",w["1d"])
            X[1326].CornerRadius = (UDim.new(0,5))
            X[1328]="1e"
            w[X[1328]] = (Instance.new("Frame",w["1d"]))
            X[1330]=w["1e"]
            X[1331]="BorderSizePixel"
            X[1330][X[1331]]=0
            X[1332]=w["1e"]
            X[1333]="BackgroundColor3"
            X[1332][X[1333]] = (Color3.fromRGB(255,255,255))
            X[1335]=w["1e"]
            X[1336]="Size"
            X[1335][X[1336]] = (UDim2.new(1,-2,1,-2))
            X[1338]=w["1e"]
            X[1339]="Position"
            X[1338][X[1339]] = (UDim2.new(0,1,0,1))
            X[1341]=Instance.new("UICorner",w["1e"])
            X[1341].CornerRadius = (UDim.new(0,4))
            X[1343]="1f"
            w[X[1343]] = (Instance.new("ImageLabel",w["1e"]))
            X[1345]=w["1f"]
            X[1346]="BorderSizePixel"
            X[1345][X[1346]]=0
            X[1347]=w["1f"]
            X[1348]="BackgroundTransparency"
            X[1347][X[1348]]=1
            X[1349]=w["1f"]
            X[1350]="Image"
            X[1349][X[1350]] = "http://www.roblox.com/asset/?id=119472238324544"
            X[1352]=w["1f"]
            X[1353]="Size"
            X[1352][X[1353]] = (UDim2.new(1,0,1,0))
            X[1355]=Instance.new("UICorner",w["1f"])
            X[1355].CornerRadius = (UDim.new(0,4))
            X[1357]="20"
            w[X[1357]] = (Instance.new("UIGradient",w["1e"]))
            X[1359]=w["20"]
            X[1360]="Color"
            X[1359][X[1360]] = (ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(30,30,30)),ColorSequenceKeypoint.new(1,Color3.fromRGB(21,21,21))}))
            X[1362]="21"
            w[X[1362]] = (Instance.new("Frame",w["1b"]))
            X[1364]=w["21"]
            X[1365]="BorderSizePixel"
            X[1364][X[1365]]=0
            X[1366]=w["21"]
            X[1367]="BackgroundColor3"
            X[1366][X[1367]] = (Color3.fromRGB(11,11,11))
            X[1369]=w["21"]
            X[1370]="Size"
            X[1369][X[1370]] = (UDim2.new(1,-72,0,14))
            X[1372]=w["21"]
            X[1373]="Position"
            X[1372][X[1373]] = (UDim2.new(0,72,0,45))
            X[1375]=w["21"]
            X[1376]="Name"
            X[1375][X[1376]] = "health"
            X[1378]=Instance.new("UICorner",w["21"])
            X[1378].CornerRadius = (UDim.new(0,4))
            X[1380]="22"
            w[X[1380]] = (Instance.new("Frame",w["21"]))
            X[1382]=w["22"]
            X[1383]="BorderSizePixel"
            X[1382][X[1383]]=0
            X[1384]=w["22"]
            X[1385]="BackgroundColor3"
            X[1384][X[1385]] = (Color3.fromRGB(46,46,46))
            X[1387]=w["22"]
            X[1388]="Size"
            X[1387][X[1388]] = (UDim2.new(1,-2,1,-2))
            X[1390]=w["22"]
            X[1391]="Position"
            X[1390][X[1391]] = (UDim2.new(0,1,0,1))
            X[1393]=Instance.new("UICorner",w["22"])
            X[1393].CornerRadius = (UDim.new(0,3))
            X[1395]="23"
            w[X[1395]] = (Instance.new("Frame",w["22"]))
            X[1397]=w["23"]
            X[1398]="BorderSizePixel"
            X[1397][X[1398]]=0
            X[1399]=w["23"]
            X[1400]="BackgroundColor3"
            X[1399][X[1400]] = (Color3.fromRGB(255,255,255))
            X[1402]=w["23"]
            X[1403]="Size"
            X[1402][X[1403]] = (UDim2.new(1,-2,1,-2))
            X[1405]=w["23"]
            X[1406]="Position"
            X[1405][X[1406]] = (UDim2.new(0,1,0,1))
            X[1408]=Instance.new("UICorner",w["23"])
            X[1408].CornerRadius = (UDim.new(0,2))
            X[1410]="24"
            w[X[1410]] = (Instance.new("UIGradient",w["23"]))
            X[1412]=w["24"]
            X[1413]="Color"
            X[1412][X[1413]] = (ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(30,30,30)),ColorSequenceKeypoint.new(1,Color3.fromRGB(21,21,21))}))
            X[1415]="25"
            w[X[1415]] = (Instance.new("Frame",w["23"]))
            X[1417]=w["25"]
            X[1418]="BorderSizePixel"
            X[1417][X[1418]]=0
            X[1419]=w["25"]
            X[1420]="BackgroundColor3"
            X[1419][X[1420]] = (Color3.fromRGB(46,196,46))
            X[1422]=w["25"]
            X[1423]="Size"
            X[1422][X[1423]] = (UDim2.new(1,0,1,0))
            X[1425]=w["25"]
            X[1426]="Name"
            X[1425][X[1426]] = "healthbarvalue"
            X[1428]=Instance.new("UICorner",w["25"])
            X[1428].CornerRadius = (UDim.new(0,2))
            X[1430]="26"
            w[X[1430]] = (Instance.new("UIGradient",w["25"]))
            X[1432]=w["26"]
            X[1433]="Color"
            X[1432][X[1433]] = (ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(125,125,125))}))
            X[1435]="27"
            w[X[1435]] = (Instance.new("TextLabel",w["23"]))
            X[1437]=w["27"]
            X[1438]="BorderSizePixel"
            X[1437][X[1438]]=0
            X[1439]=w["27"]
            X[1440]="TextSize"
            X[1439][X[1440]]=12
            X[1441]=w["27"]
            X[1442]="Font"
            X[1441][X[1442]] = Enum.Font.GothamMedium
            X[1444]=w["27"]
            X[1445]="BackgroundColor3"
            X[1444][X[1445]] = (Color3.fromRGB(255,255,255))
            X[1447]=w["27"]
            X[1448]="TextColor3"
            X[1447][X[1448]] = (Color3.fromRGB(181,181,181))
            X[1450]=w["27"]
            X[1451]="BackgroundTransparency"
            X[1450][X[1451]]=1
            X[1452]=w["27"]
            X[1453]="AnchorPoint"
            X[1452][X[1453]] = (Vector2.new(0.5,0.5))
            X[1455]=w["27"]
            X[1456]="Size"
            X[1455][X[1456]] = (UDim2.new(1,0,1,0))
            X[1458]=w["27"]
            X[1459]="Text"
            X[1458][X[1459]] = "100/100"
            X[1461]=w["27"]
            X[1462]="Name"
            X[1461][X[1462]] = "healthvalue"
            X[1464]=w["27"]
            X[1465]="Position"
            X[1464][X[1465]] = (UDim2.new(0.5,0,0.5,0))
            Instance.new("UIStroke",w["27"])
            X[1467]="29"
            w[X[1467]] = (Instance.new("Frame",w["1b"]))
            X[1469]=w["29"]
            X[1470]="BorderSizePixel"
            X[1469][X[1470]]=0
            X[1471]=w["29"]
            X[1472]="BackgroundTransparency"
            X[1471][X[1472]]=1
            X[1473]=w["29"]
            X[1474]="Size"
            X[1473][X[1474]] = (UDim2.new(0,198,0,31))
            X[1476]=w["29"]
            X[1477]="Position"
            X[1476][X[1477]] = (UDim2.new(0.27,0,0.03,0))
            X[1479]="2a"
            w[X[1479]] = (Instance.new("UIListLayout",w["29"]))
            X[1481]=w["2a"]
            X[1482]="Padding"
            X[1481][X[1482]] = (UDim.new(0,2))
            X[1484]=w["2a"]
            X[1485]="SortOrder"
            X[1484][X[1485]] = Enum.SortOrder.LayoutOrder
            X[1487]="2b"
            w[X[1487]] = (Instance.new("TextLabel",w["29"]))
            X[1489]=w["2b"]
            X[1490]="BorderSizePixel"
            X[1489][X[1490]]=0
            X[1491]=w["2b"]
            X[1492]="TextSize"
            X[1491][X[1492]]=12
            X[1493]=w["2b"]
            X[1494]="Font"
            X[1493][X[1494]] = Enum.Font.GothamBold
            X[1496]=w["2b"]
            X[1497]="TextXAlignment"
            X[1496][X[1497]] = Enum.TextXAlignment.Left
            X[1499]=w["2b"]
            X[1500]="BackgroundTransparency"
            X[1499][X[1500]]=1
            X[1501]=w["2b"]
            X[1502]="TextColor3"
            X[1501][X[1502]] = (Color3.fromRGB(220,222,230))
            X[1504]=w["2b"]
            X[1505]="Size"
            X[1504][X[1505]] = (UDim2.new(1,0,0,14))
            X[1507]=w["2b"]
            X[1508]="Text"
            X[1507][X[1508]] = "exp (@example)"
            X[1510]=w["2b"]
            X[1511]="Name"
            X[1510][X[1511]] = "name"
            Instance.new("UIStroke",w["2b"])
            X[1513]="2d"
            w[X[1513]] = (Instance.new("TextLabel",w["29"]))
            X[1515]=w["2d"]
            X[1516]="BorderSizePixel"
            X[1515][X[1516]]=0
            X[1517]=w["2d"]
            X[1518]="TextSize"
            X[1517][X[1518]]=11
            X[1519]=w["2d"]
            X[1520]="Font"
            X[1519][X[1520]] = Enum.Font.GothamMedium
            X[1522]=w["2d"]
            X[1523]="TextXAlignment"
            X[1522][X[1523]] = Enum.TextXAlignment.Left
            X[1525]=w["2d"]
            X[1526]="BackgroundTransparency"
            X[1525][X[1526]]=1
            X[1527]=w["2d"]
            X[1528]="TextColor3"
            X[1527][X[1528]] = (Color3.fromRGB(140,144,158))
            X[1530]=w["2d"]
            X[1531]="Size"
            X[1530][X[1531]] = (UDim2.new(1,0,0,14))
            X[1533]=w["2d"]
            X[1534]="Text"
            X[1533][X[1534]] = "123 studs"
            X[1536]=w["2d"]
            X[1537]="Name"
            X[1536][X[1537]] = "studs"
            Instance.new("UIStroke",w["2d"])
            X[1539]="37"
            w[X[1539]] = (Instance.new("Frame",w["15"]))
            X[1541]=w["37"]
            X[1542]="BorderSizePixel"
            X[1541][X[1542]]=0
            X[1543]=w["37"]
            X[1544]="BackgroundTransparency"
            X[1543][X[1544]]=1
            X[1545]=w["37"]
            X[1546]="Size"
            X[1545][X[1546]] = (UDim2.new(1,0,0,20))
            X[1548]=w["37"]
            X[1549]="Position"
            X[1548][X[1549]] = (UDim2.new(0,0,0,2))
            X[1551]=w["37"]
            X[1552]="Name"
            X[1551][X[1552]] = "top"
            X[1554]="38"
            w[X[1554]] = (Instance.new("TextLabel",w["37"]))
            X[1556]=w["38"]
            X[1557]="BorderSizePixel"
            X[1556][X[1557]]=0
            X[1558]=w["38"]
            X[1559]="TextSize"
            X[1558][X[1559]]=11
            X[1560]=w["38"]
            X[1561]="Font"
            X[1560][X[1561]] = Enum.Font.GothamBold
            X[1563]=w["38"]
            X[1564]="TextXAlignment"
            X[1563][X[1564]] = Enum.TextXAlignment.Left
            X[1566]=w["38"]
            X[1567]="BackgroundTransparency"
            X[1566][X[1567]]=1
            X[1568]=w["38"]
            X[1569]="TextColor3"
            X[1568][X[1569]] = (Color3.fromRGB(137,137,137))
            X[1571]=w["38"]
            X[1572]="Size"
            X[1571][X[1572]] = (UDim2.new(1,0,1,0))
            X[1574]=w["38"]
            X[1575]="Text"
            X[1574][X[1575]] = "Info"
            X[1577]=Instance.new("UIPadding",w["38"])
            X[1577].PaddingLeft = (UDim.new(0,5))
            Instance.new("UIStroke",w["38"])
            X[1579]="3b"
            w[X[1579]] = (Instance.new("Frame",w["5"]))
            X[1581]=w["3b"]
            X[1582]="BorderSizePixel"
            X[1581][X[1582]]=0
            X[1583]=w["3b"]
            X[1584]="BackgroundTransparency"
            X[1583][X[1584]]=1
            X[1585]=w["3b"]
            X[1586]="Size"
            X[1585][X[1586]] = (UDim2.new(1,-4,0,20))
            X[1588]=w["3b"]
            X[1589]="Name"
            X[1588][X[1589]] = "top"
            X[1591]="3c"
            w[X[1591]] = (Instance.new("TextLabel",w["3b"]))
            X[1593]=w["3c"]
            X[1594]="BorderSizePixel"
            X[1593][X[1594]]=0
            X[1595]=w["3c"]
            X[1596]="TextSize"
            X[1595][X[1596]]=11
            X[1597]=w["3c"]
            X[1598]="Font"
            X[1597][X[1598]] = Enum.Font.GothamBold
            X[1600]=w["3c"]
            X[1601]="TextXAlignment"
            X[1600][X[1601]] = Enum.TextXAlignment.Left
            X[1603]=w["3c"]
            X[1604]="BackgroundTransparency"
            X[1603][X[1604]]=1
            X[1605]=w["3c"]
            X[1606]="TextColor3"
            X[1605][X[1606]] = (Color3.fromRGB(181,181,181))
            X[1608]=w["3c"]
            X[1609]="Size"
            X[1608][X[1609]] = (UDim2.new(0.5,0,1,0))
            X[1611]=w["3c"]
            X[1612]="Text"
            X[1611][X[1612]] = "Indicator"
            X[9]=(Instance.new("UIPadding",w["3c"]))
            X[9].PaddingTop = (UDim.new(0,-4))
            X[9].PaddingLeft = (UDim.new(0,-2))
            X[9].PaddingBottom = (UDim.new(0,4))
            Instance.new("UIStroke",w["3c"])
            local function a(v)local H=521291476
                local E=H
                local R,x,q=false
                H=N:Aq(E+422431098)
                local E,L
                L,H=v.InputBegan,N:Aq(H-281054528)
                L:Connect(function(H)if getgenv().TargetHUDConfig.FollowTarget then return
                end
                local Y=H.UserInputType==Enum.UserInputType.MouseButton1 or H.UserInputType==Enum.UserInputType.Touch
                if Y then local Y=129612744
                    local r=Y
                    R=true
                    Y=bit32.bxor(r,486120098)
                    x=H.Position
                    q=v.Position
                    Y=N:Aq(bit32.band(809661112,Y)+bit32.band(809661112,138170493)+(bit32.band(2675645072,(bit32.bor(Y,138170493)))+bit32.band(809661113,(bit32.bxor(Y,138170493)))))
                    H.Changed:Connect(function()local Y=H.UserInputState==Enum.UserInputState.End
                    if Y then R=false
                end
            end)
        end
    end)
    v.InputChanged:Connect(function(H)if getgenv().TargetHUDConfig.FollowTarget then return
        end
        local Y=H.UserInputType==Enum.UserInputType.MouseMovement or H.UserInputType==Enum.UserInputType.Touch
        if Y then E=H
        end
    end)
    L=p
    L:GetService("UserInputService").InputChanged:Connect(function(H)if getgenv().TargetHUDConfig.FollowTarget then return
        end
        local L=H==E and R
        if L then local E=H.Position-x
            v.Position=UDim2.new(q.X.Scale,q.X.Offset+E.X,q.Y.Scale,q.Y.Offset+E.Y)
        end
    end)
end
a(w["2"])
X[1617]=getgenv()
X[1617].HudMainFrame = w["2"]
local a,v=1
X[26]=p
X[1619]="RunService"
X[26]:GetService(X[1619]).RenderStepped:Connect(function(H)local E={}
    if getgenv().Unloaded then return
    end
    local R,x,q,L=Config and Config.ForceHit and Config.ForceHit.Target or getgenv().KillAura and getgenv().KillAura.CurrentTarget or CurrentLegitTarget,Config and Config.ForceHit and Config.ForceHit.TargetHUDEnabled,Config and Config.ForceHit and Config.ForceHit.Active or getgenv().KillAura and getgenv().KillAura.Enabled,getgenv().TargetHUDConfig.FollowTarget
    local Y=q and x and R and R.Character
    if Y then local x,Y,r,A=R.Character:FindFirstChildOfClass("Humanoid"),R.Character:FindFirstChild("HumanoidRootPart"),getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChild("HumanoidRootPart"),workspace.CurrentCamera
        q=x and Y and r and A
        if q then local q=R.Character:FindFirstChild("BodyEffects")
            local K,f=q and(q:FindFirstChild("Health")or q:FindFirstChild("Health_CLIENT")),q and q:FindFirstChild("MaxHealth")
            local C,l=math.max(K and K.Value or x.Health,0),math.max(f and f.Value or x.MaxHealth,1)
            q,f=math.clamp(C/l,0,1),a
            a=f+(q-f)*math.clamp(H*9.5,0,1)
            local x,K,Z=math.floor((r.Position-Y.Position).Magnitude),S(R.Character)
            if L then f=Y.CFrame.RightVector*3.8
                q=Y.Position+f+Vector3.new(0,0.4,0)
                local S,L=A:WorldToViewportPoint(q)
                if S.X>A.ViewportSize.X-220 then q=Y.Position-f+Vector3.new(0,0.4,0)
                    S,L=A:WorldToViewportPoint(q)
                end
                local q=not L or S.Z<=0
                if q then E[1]=w["2"]
                    E[1].Visible=false
                    return
                end
                q=math.clamp(1.4-x*0.012,0.65,1.35)
                P.Scale=P.Scale+(q-P.Scale)*math.clamp(H*12,0,1)
                local L,Y=Vector2.new(S.X,S.Y),not v
                if Y then v=L
                else q=v
                    v=q+(L-q)*math.clamp(H*26,0,1)
                end
                w["2"].AnchorPoint = (Vector2.new(0.5,0.5))
                w["2"].Position = (UDim2.fromOffset(v.X,v.Y))
            else P.Scale=1
                v=nil
            end
            E[6]=w["2"]
            E[6].Visible=true
            w["2b"].Text = R.DisplayName.." (@"..R.Name..")"
            w["2d"].Text = x.." studs \226\128\162 "..K.." ["..Z.."]"
            w["27"].Text = math.floor(C).."/"..math.floor(l)
            w["25"].Size = (UDim2.new(math.clamp(a,0,1),0,1,0))
            w["1f"].Image = "rbxthumb://type=AvatarHeadShot&id="..tostring(R.UserId).."&w=150&h=150"
        else E[17]=w["2"]
            E[17].Visible=false
            a,v=1,nil
        end
    else E[18]=w["2"]
        E[18].Visible=false
        a,v=1,nil
    end
end)
X[123]=getgenv().TargetVisualsSection
if X[123]then X[1620]=getgenv()
    X[1620].fh_targethud_lbl = (getgenv().TargetVisualsSection:AddLabel("target hud"))
    X[1623]=getgenv().fh_targethud_lbl
    X[1623]:AddToggle({
        Default = true,
        Flag = "FH_TargetHUD",
        Callback = function(S)local a={}
                        Config.ForceHit.TargetHUDEnabled = S
            end,
    })
    X[1625]=getgenv().fh_targethud_lbl
    X[1624]={}
    X[1624].Default=getgenv().TargetHUDConfig.AccentColor
    X[1624].Flag="FH_TargetHUDColor"
    local S,a=X[1625],X[1624]
    a.Callback=function(H)local E={}
        getgenv().TargetHUDConfig.AccentColor=H
        local R=w["3"]
        if R then E[1]=w["3"]
            E[1].BackgroundColor3=H
        end
        R=w["17"]
        if R then E[2]=w["17"]
            E[2].BackgroundColor3=H
        end
        R=w["18"]
        if R then local E,R,x,q,L,Y=w["18"],ColorSequence.new,{},ColorSequenceKeypoint.new(0,H),ColorSequenceKeypoint.new,Color3.fromRGB
            N:jq(x,0,q,L(1,H:Lerp(Y(255,255,255),0.15)))
            E.Color=R(x)
        end
    end
    S:AddColorPicker(a)
    X[130]=getgenv().TargetVisualsSection
    X[1626] = "follow target"
    X[1628]=X[130]:AddLabel(X[1626])
    X[1627]={}
    X[1627].Default=getgenv().TargetHUDConfig.FollowTarget
    X[1627].Flag="TargetHUD_FollowTarget"
    local S,a=X[1628],X[1627]
    a.Callback=function(H)local E={}
        getgenv().TargetHUDConfig.FollowTarget=H
        v=nil
        local v=not H
        if v then w["2"].AnchorPoint = (Vector2.new(0.5,0.75))
            w["2"].Position = (UDim2.new(0.5,0,0.75,0))
            P.Scale=1
        end
    end
    S:AddToggle(a)
end
end
Config.DesyncPart = (Instance.new("Part"))
Config.DesyncPart.Name = "desyncvisual"
Config.DesyncPart.Size = (Vector3.new(2,2,1))
Config.DesyncPart.Transparency = 1
Config.DesyncPart.CanCollide = false
Config.DesyncPart.Anchored = true
Config.DesyncPart.Parent = workspace
X[1639]=getgenv()
X[1639].DesyncPart = Config.DesyncPart
getgenv().strafeCamera=workspace.CurrentCamera
getgenv().resetStrafeCamera=function()local S=getgenv().LocalPlayer.Character
    local w=S and S:FindFirstChildWhichIsA("Humanoid")
    if w then getgenv().strafeCamera.CameraSubject=w
    end
end
getgenv().destroyStrafeVisualizer=function()local S={}
    if Config.ForceHit.StrafeVisConnection then Config.ForceHit.StrafeVisConnection:Disconnect()
                Config.ForceHit.StrafeVisConnection = nil
    end
    if Config.ForceHit.StrafeVisParts then for w,w in pairs(Config.ForceHit.StrafeVisParts)do if w.part then w.part:Destroy()
            end
        end
                Config.ForceHit.StrafeVisParts = nil
    end
end
X[7]=getgenv
X[145]=function()local S={}
    local w=181018502
    local P=w
    local a
    a,w=getgenv(),N:Aq(P+335518781)
    a.destroyStrafeVisualizer()
    a=getgenv().LocalPlayer.Character
    P=a and a:FindFirstChild("HumanoidRootPart")
    if not P then return
    end
    local v={}
        Config.ForceHit.StrafeVisParts = v
    local H=ipairs
    w=N:Aq(w+11997754)
    local w=table.pack(a:GetChildren())
    for E,R in H(table.unpack(w))do E=R:IsA("BasePart")and R.Name~="HumanoidRootPart"
        if E then a=(Instance.new("Part"))
            S[2]=R.Name.."_strafeghost"
            a.Name=S[2]
            a.Size=R.Size
            a.Anchored=true
            a.CanCollide=false
            a.CastShadow=false
            a.Material=Enum.Material.Neon
            a.Color=Color3.fromRGB(255,255,255)
            a.Transparency=0.4
            a.Parent=getgenv().strafeCamera
            local w=P.CFrame:Inverse()*R.CFrame
            v[R.Name]={part=a,offset=w,currentCF=a.CFrame}
        end
    end
    local w=0.18
    Config.ForceHit.CurrentStrafeCF = P.CFrame
    S[5]=Config.ForceHit
    S[6]=(getgenv().RunService.RenderStepped:Connect(function()local P=Config.ForceHit.CurrentStrafeCF
        if not P then return
        end
        for a,H in pairs(v)do a=P*H.offset
            H.currentCF=H.currentCF:Lerp(a,w)
            H.part.CFrame=H.currentCF
        end
    end))
    S[5].StrafeVisConnection=S[6]
end
X[1641]=X[7]()
X[1641].createStrafeVisualizer=X[145]
X[25]=getgenv
X[69]=function(S)local w={}
        Config.ForceHit.SpectateTarget = S
    if getgenv().SpectateConnection then getgenv().SpectateConnection:Disconnect()
        getgenv().SpectateConnection=nil
    end
    if S then local S=499870468
        local w=S
        local P,a=getgenv(),getgenv()
        S=N:Aq(bit32.band(622373940,w)+bit32.band(622373940,305607427)+(bit32.band(3050219416,(bit32.bor(w,305607427)))+bit32.band(622373941,(bit32.bxor(w,305607427)))))
        w=a.RunService
        S=bit32.bxor(S,257397825)
        local function S()local a,v=Config.ForceHit.Target,workspace.CurrentCamera
            local H=a and a.Character
            if H then local H=a.Character:FindFirstChildOfClass("Humanoid")
                if H and v.CameraSubject~=H then v.CameraSubject=H
                end
            else local a=getgenv().LocalPlayer.Character
                local H=a and a:FindFirstChildOfClass("Humanoid")
                if H and v.CameraSubject~=H then v.CameraSubject=H
                end
            end
        end
        P.SpectateConnection=w.RenderStepped:Connect(S)
    else local S=getgenv().LocalPlayer.Character
        local w=S and S:FindFirstChildOfClass("Humanoid")
        if w then workspace.CurrentCamera.CameraSubject=w
        end
    end
end
X[1642]=X[25]()
X[1642].updateSpectate=X[69]
getgenv().stopStrafe=function()local S={}
    if Config.ForceHit.StrafeConnection then Config.ForceHit.StrafeConnection:Disconnect()
                Config.ForceHit.StrafeConnection = nil
    end
    getgenv().destroyStrafeVisualizer()
    getgenv().resetStrafeCamera()
        Config.ForceHit.LookAtTarget = false
end
getgenv().startStrafe=function()local S={}
    local w=6501784
    local P=w
    if Config.ForceHit.StrafeConnection then Config.ForceHit.StrafeConnection:Disconnect()
                Config.ForceHit.StrafeConnection = nil
    end
    local a=Config.ForceHit
    w=bit32.bxor(P,474171609)
    if a.VisualizeStrafe then getgenv().createStrafeVisualizer()
    end
        Config.ForceHit.LookAtTarget = false
    local S,P,a,v,H=0,false,0
    v=Config.ForceHit
    H=(getgenv())
    w=N:Aq(bit32.band(189362455,w)+bit32.band(189362455,299213214)+(bit32.band(3916242386,(bit32.bor(w,299213214)))+bit32.band(189362456,(bit32.bxor(w,299213214)))))
    v.StrafeConnection=H.RunService.Heartbeat:Connect(function(w)local v={}
        S+=w
        if not Config.ForceHit.StrafeEnabled or not Config.ForceHit.Target then getgenv().stopStrafe()
            return
        end
        local H=getgenv().LocalPlayer.Character
        local E,R=H and H:FindFirstChild("HumanoidRootPart"),Config.ForceHit.Target.Character
        local x,q,L,Y=R and R:FindFirstChild("HumanoidRootPart"),R and R:FindFirstChildWhichIsA("Humanoid"),R and R:FindFirstChild("BodyEffects")
        if L then local r=L:FindFirstChild("K.O")and L["K.O"].Value or L:FindFirstChild("KO")and L.KO.Value
            Y=r or L:FindFirstChild("Dead")and L.Dead.Value
        else Y=L
        end
        if not(E and x and q and q.Health>0)or Y then getgenv().stopStrafe()
            return
        end
        local Y,r=x.Position
        x=Config.ForceHit.StrafeMode=="Orbit"
        if x then L=S
            local A=L*(Config.ForceHit.StrafeSpeed or 5)
            r=(CFrame.lookAt(Y+Vector3.new(math.cos(A)*(Config.ForceHit.StrafeDistance or 8),Config.ForceHit.StrafeHeight or 0,math.sin(A)*(Config.ForceHit.StrafeDistance or 8)),Y))
        else local A=Config.ForceHit.StrafeMode=="Random"
            if A then local A,K=(Config.ForceHit.StrafeSpeed or 5)*1.2,Config.ForceHit.StrafeDistance or 8
                local f=S*A
                A=(Vector3.new(math.noise(f,0,0)*K,math.noise(0,f,0)*(K*0.5)+(Config.ForceHit.StrafeHeight or 0),math.noise(0,0,f)*K))
                r=CFrame.lookAt(Y+A,Y)
            else local A=Config.ForceHit.StrafeMode=="Far Random"
                if A then local A,K=(Config.ForceHit.StrafeSpeed or 5)*0.9,(Config.ForceHit.StrafeDistance or 8)*5.5
                    local f=S*A
                    A=(Vector3.new(math.noise(f,0,0)*K,math.noise(0,f,0)*(K*0.4)+(Config.ForceHit.StrafeHeight or 0),math.noise(0,0,f)*K))
                    r=CFrame.lookAt(Y+A,Y)
                else local S=Config.ForceHit.StrafeMode=="Void Shoot"
                    if S then a+=w
                    local S=tick()-(Config.ForceHit.LastShotTime or 0)<0.12
                    if S then P,a=false,0
                    r=CFrame.lookAt(Y+Vector3.new(0,200,2),Y)
                else local S,A,K=Config.ForceHit.VoidTime or 0.4,Config.ForceHit.GroundTime or 0.133,not P
                    if K then local K=a>=A
                    if K then P,a=true,0
                end
                r=CFrame.lookAt(Y+Vector3.new(0,3,2),Y)
            else local A=a>=S
                if A then P,a=false,0
                end
                r=CFrame.new(Y+Vector3.new(0,10000,0))
            end
        end
    end
end
end
end
if not r then return
end
if Config.ForceHit.VisualizeStrafe then     Config.ForceHit.CurrentStrafeCF = r
end
Y=Config.ForceHit.strafespoof
if Y then L=E.CFrame
    Config.DesyncPart.CFrame = L+Vector3.new(0,5,0)
    getgenv().strafeCamera.CameraSubject = Config.DesyncPart
    if E.AssemblyLinearVelocity.Magnitude<0.1 then E.AssemblyLinearVelocity=Vector3.new(0,0.05,0)
    end
    E.CFrame=r
    getgenv().RunService.RenderStepped:Wait()
    E.CFrame=L
    getgenv().resetStrafeCamera()
else E.CFrame=r
    x=not Config.ForceHit.SpectateTarget
    if x then local S,P=R:FindFirstChild("Head")or q,H:FindFirstChildWhichIsA("Humanoid")
        w=nil
        w=getgenv().strafeCamera
        S=Config.ForceHit.SpectateStrafe and S
        w.CameraSubject=S or P
    end
end
end)
end
task.spawn(function()local S={}
    while task.wait(0.05)do local w,P,a=Config.ForceHit.StrafeEnabled,getgenv().KillAura.Enabled and getgenv().KillAura.StrafeWithAura and getgenv().KillAura.CurrentTarget,Config.ForceHit.Enabled and Config.ForceHit.Active and Config.ForceHit.Target
        if w and(a or P)then if not Config.ForceHit.Target and P then Config.ForceHit.Target = getgenv().KillAura.CurrentTarget
            end
            if Config.ForceHit.Target and Config.ForceHit.Target.Character then if not Config.ForceHit.StrafeConnection then getgenv().startStrafe()
                end
            end
        elseif Config.ForceHit.StrafeConnection and not a and not P then getgenv().stopStrafe()
            end
        end
    end)
    task.spawn(function()local S={}
        while task.wait()do if not getgenv().stompTargetEnabled then continue
            end
            local w=Config.ForceHit and Config.ForceHit.Target
            if not w or w==getgenv().LocalPlayer then continue
            end
            local P=w.Character
            if not P or not P.Parent then continue
            end
            w=(P:FindFirstChild("BodyEffects"))
            local a,v=w and(w:FindFirstChild("K.O")and w["K.O"].Value or w:FindFirstChild("KO")and w.KO.Value),w and(w:FindFirstChild("Dead")and w.Dead.Value or w:FindFirstChild("SDeath")and w.SDeath.Value)
            w=a and not v
            if w then local w,a=P:FindFirstChild("UpperTorso")or P:FindFirstChild("Torso"),getgenv().LocalPlayer.Character
                local P=a and a:FindFirstChild("HumanoidRootPart")
                a=w and P and not getgenv().am_i_knocked()
                if a then local a,v,H=P.CFrame,Config.ForceHit.strafespoof,Config.ForceHit.StrafeEnabled
                                        Config.ForceHit.strafespoof = false
                                        Config.ForceHit.StrafeEnabled = false
                    if getgenv().stopStrafe then getgenv().stopStrafe()
                end
                if v and Config.DesyncPart then Config.DesyncPart.CFrame = a+Vector3.new(0,5,0)
                    getgenv().strafeCamera.CameraSubject = Config.DesyncPart
                end
                P.CFrame=CFrame.new(w.Position+Vector3.new(0,3,0))
                local w=getgenv().MainEvent or getgenv().ReplicatedStorage:FindFirstChild("MainEvent")
                if w then w:FireServer("Stomp")
                end
                getgenv().RunService.RenderStepped:Wait()
                P.CFrame=a
                                Config.ForceHit.strafespoof = v
                                Config.ForceHit.StrafeEnabled = H
                getgenv().resetStrafeCamera()
            end
        end
    end
end)
task.spawn(function()local S={}
    while true do local w,P=task.wait,getgenv
        if not w(P().autoGrabCooldown or 1)then break
        end
        if not(getgenv().autoGrabEnabled and Config.ForceHit.Target and Config.ForceHit.Target~=getgenv().LocalPlayer)then continue
        end
        w=Config.ForceHit.Target.Character
        P=w and w:FindFirstChild("BodyEffects")
        local a=P and P:FindFirstChild("K.O")and P["K.O"].Value
        if not a then continue
        end
        local a,v=w:FindFirstChild("HumanoidRootPart"),getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not a or not v then continue
        end
        local w,H,E=v.CFrame,Config.ForceHit.strafespoof,Config.ForceHit.StrafeEnabled
                Config.ForceHit.strafespoof = false
                Config.ForceHit.StrafeEnabled = false
        getgenv().stopStrafe()
        if H then Config.DesyncPart.CFrame = w+Vector3.new(0,5,0)
            getgenv().strafeCamera.CameraSubject = Config.DesyncPart
        end
        v.CFrame=CFrame.new(a.Position+Vector3.new(0,3,0))
        getgenv().ReplicatedStorage.MainEvent:FireServer("Grabbing")
        getgenv().RunService.RenderStepped:Wait()
        v.CFrame=w
                Config.ForceHit.strafespoof = H
                Config.ForceHit.StrafeEnabled = E
        getgenv().resetStrafeCamera()
        v=(P:FindFirstChild("Grabbed"))
        if v then P=tick()
            while tick()-P<2 do if v.Value==getgenv().LocalPlayer.Name then a.CFrame=w
                    break
                end
                task.wait()
            end
        end
    end
end)
X[111]=task
X[22]=function()local S={}
    while task.wait()do if not getgenv().stompGlueTargetEnabled then continue
        end
        local w
        for P,a in pairs(getgenv().target_players)do P=getgenv().Players:FindFirstChild(a)
            if P and P.Character then w=P
                break
            end
        end
        if not w then local P=Config.ForceHit and Config.ForceHit.Target
            w=if P and P.Character then P else w
            end
            if not w then continue
            end
            local P=w.Character
            if not P or not P.Parent then continue
            end
            local w=P:FindFirstChildOfClass("Humanoid")
            if not w or w.Health<=0 then continue
            end
            w=(P:FindFirstChild("BodyEffects"))
            local a,v,H=w and w:FindFirstChild("K.O")and w["K.O"].Value,w and w:FindFirstChild("SDeath")and w.SDeath.Value,w and w:FindFirstChild("Dead")and w.Dead.Value
            w=a and not v and not H
            if w then a=P:FindFirstChild("UpperTorso")or P:FindFirstChild("Torso")
                v=getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                H=a and v
                if H then local w,P,H=v.CFrame,getgenv().glue_spoof,getgenv().glue_active
                    getgenv().glue_spoof=false
                    getgenv().glue_active=false
                    if getgenv().connection_loop then getgenv().connection_loop:Disconnect()
                    getgenv().connection_loop=nil
                end
                if getgenv().no_unc_loop then getgenv().no_unc_loop:Disconnect()
                    getgenv().no_unc_loop=nil
                end
                if P then Config.DesyncPart.CFrame = w+Vector3.new(0,5,0)
                    getgenv().strafeCamera.CameraSubject = Config.DesyncPart
                end
                v.CFrame=CFrame.new(a.Position+Vector3.new(0,3,0))
                getgenv().ReplicatedStorage.MainEvent:FireServer("Stomp")
                getgenv().RunService.RenderStepped:Wait()
                v.CFrame=w
                getgenv().glue_spoof=P
                getgenv().glue_active=H
                if H then if getgenv().use_unc_method then getgenv().unc_connection()
                else getgenv().no_unc_connection()
                end
            end
            getgenv().resetStrafeCamera()
        end
    end
end
end
X[111].spawn(X[22])
X[46]=getgenv().RunService
X[135]=function()if not Config.ForceHit.LookAtTarget then return
    end
    local S=Config.ForceHit.Target
    if not S or not S.Character then return
    end
    local w=S.Character:FindFirstChild(Config.ForceHit.HitPart)or S.Character:FindFirstChild("HumanoidRootPart")
    if not w then return
    end
    S=getgenv().LocalPlayer.Character
    if not S then return
    end
    local P=S:FindFirstChild("HumanoidRootPart")
    if P then local a=w.Position-P.Position
        local v=Vector3.new(a.X,0,a.Z).Unit
        if v.Magnitude>0 then P.CFrame=CFrame.new(P.Position,P.Position+v)
        end
    end
    local a,v=S:FindFirstChild("Head"),S:FindFirstChild("UpperTorso")and S.UpperTorso:FindFirstChild("Neck")or S:FindFirstChild("Torso")and S.Torso:FindFirstChild("Neck")
    if a and v then P=(w.Position-a.Position).Unit
        v.C0=CFrame.new(v.C0.Position)*CFrame.Angles(math.asin(math.clamp(P.Y,-1,1))*-1,math.atan2(-P.X,-P.Z),0)
    end
end
X[46].Heartbeat:Connect(X[135])
X[1643]=getgenv()
X[1643].fh_enable_lbl = (Config.ForceHitSection:AddLabel("forcehit"))
X[1645]=getgenv()
X[1647]=getgenv().fh_enable_lbl
X[1646]={}
X[1646].Default=false
X[1646].Flag="FH_Enabled"
X[1646].Callback=function(S)local w={}
        Config.ForceHit.Enabled = S
    if not S then         Config.ForceHit.Active = false
                Config.ForceHit.Target = nil
        getgenv().TargetLine.Visible=false
    end
end
X[1645].FHToggleObject = (X[1647]:AddToggle(X[1646]))
X[1650]=getgenv().fh_enable_lbl
X[1650]:AddKeybind({
    Default = "C",
    Flag = "FH_Keybind",
    Callback = function(S)local w={}
        local P=getgenv().parseKey(S)
        if P then         Config.ForceHit.Key = P
        end
    end,
})
X[1651]=getgenv()
X[1651].fh_whitelist_lbl = (Config.ForceHitSection:AddLabel("whitelist players"))
getgenv().fh_whitelist_dropdown=getgenv().fh_whitelist_lbl:AddDropdown({Default={},Multi=true,Values=getgenv().getPlayerNames(),Save=false,Callback=function(S)local w={}
        Config.ForceHit.Whitelist = S
    local P=Config.ForceHit.Target
    if P and S[P.Name]then         Config.ForceHit.Target = nil
    end
end})
X[131]=getgenv
X[55]=X[131]().UserInputService
X[21]=function(S,w)local P={}
    if w then return
    end
    if not S.KeyCode or S.KeyCode==Enum.KeyCode.Unknown or S.KeyCode==Enum.KeyCode.None then return
    end
    w=Config.ForceHit.Key and S.KeyCode==Config.ForceHit.Key
    if w then local w=Config.ForceHit.Enabled
        if w then local w=not Config.ForceHit.Active
                        Config.ForceHit.Active = w
            if w then getgenv().Logging.new("crosshairs","force hit: active",3)
                if not(Config.ForceHit.Target and Config.ForceHit.Target.Parent)then Config.ForceHit.Target = (getgenv().FH_GetClosest())
                end
            else getgenv().Logging.new("crosshairs-slash","force hit: idle",3)
                                Config.ForceHit.Target = nil
                getgenv().TargetLine.Visible=false
            end
        end
    else local w=Config.ForceHit.StrafeKey and S.KeyCode==Config.ForceHit.StrafeKey
        if w then if Config.ForceHit.Enabled and Config.ForceHit.StrafeArmed then Config.ForceHit.StrafeEnabled = not Config.ForceHit.StrafeEnabled
            end
        else local w=getgenv().GlueKey and S.KeyCode==getgenv().GlueKey
            if w then if not getgenv().feature_enabled then return
                end
                getgenv().glue_active=not getgenv().glue_active
                if getgenv().glue_active and(#getgenv().target_players>0 or Config.ForceHit.Target)then if getgenv().use_unc_method then getgenv().unc_connection()
                else getgenv().no_unc_connection()
                end
            else if getgenv().connection_loop then getgenv().connection_loop:Disconnect()
                    getgenv().connection_loop=nil
                end
                if getgenv().no_unc_loop then getgenv().no_unc_loop:Disconnect()
                    getgenv().no_unc_loop=nil
                end
                getgenv().reset_velocity()
            end
        else local w=Config.Misc.CFrameSpeedKey and S.KeyCode==Config.Misc.CFrameSpeedKey
            if w then if Config.Misc.CFrameSpeedEnabled then Config.Misc.CFrameSpeedActive = not Config.Misc.CFrameSpeedActive
                end
            else local w=Config.Misc.CFrameFlyKey and S.KeyCode==Config.Misc.CFrameFlyKey
                if w then local S=Config.Misc.CFrameFlyEnabled
                    if S then Config.Misc.CFrameFlyActive = not Config.Misc.CFrameFlyActive
                    local S=not Config.Misc.CFrameFlyActive
                    if S then local S=getgenv().LocalPlayer.Character
                    local w,P=S and S:FindFirstChild("HumanoidRootPart"),S and S:FindFirstChildOfClass("Humanoid")
                    if w then w.AssemblyLinearVelocity=Vector3.new(0,0,0)
                end
                if P then P.PlatformStand=false
                end
            end
        end
    end
end
end
end
end
end
X[55].InputBegan:Connect(X[21])
Config.Misc_nobypass_lbl = (getgenv().MovementSection:AddLabel("no jump cooldown"))
Config.Misc_nobypass_lbl:AddToggle({
    Default = false,
    Flag = "Misc_BypassExhaustion",
    Callback = function(S)getgenv().BypassExhaustionConfig.Enabled=S
        if getgenv().LocalPlayer.Character then X[137](getgenv().LocalPlayer.Character)
        end
    end,
})
Config.Misc_jump_val_lbl = (getgenv().MovementSection:AddLabel("jump height value"))
X[1657]={}
N:jq(X[1657],0,Config.Misc_jump_val_lbl)
X[1658]={}
X[1658].Min=7
X[1658].Max=100
X[1658].Rounding=1
X[1658].Default=7.2
X[1658].Flag="Misc_BypassJumpHeightValue"
N:jq(X[1657],1,X[1658])
X[1657].n=2
X[154],X[155]=X[1657][1],X[1657][2]
X[155].Callback=function(S)getgenv().BypassExhaustionConfig.JumpHeightValue=S
    local w=getgenv().LocalPlayer.Character
    local P=w and w:FindFirstChildOfClass("Humanoid")
    if P and not P.UseJumpPower then P.JumpHeight=S
    end
end
X[1659]=X[155]
X[154]:AddSlider(X[1659])
getgenv().spinbot=getgenv().spinbot or{enabled=false,speed=50}
if getgenv().spinbot_conn then pcall(function()getgenv().spinbot_conn:Disconnect()
    end)
    getgenv().spinbot_conn=nil
end
getgenv().spinbot_conn=getgenv().RunService.Heartbeat:Connect(function()if not getgenv().spinbot or not getgenv().spinbot.enabled then return
    end
    local S=getgenv().LocalPlayer.Character
    local w=S and S:FindFirstChild("HumanoidRootPart")
    if not w then return
    end
    w.CFrame=w.CFrame*CFrame.Angles(0,math.rad(getgenv().spinbot.speed),0)
end)
getgenv().NoclipConfig={Enabled=false,Key=nil}
if getgenv().NoclipConnection then pcall(function()getgenv().NoclipConnection:Disconnect()
    end)
    getgenv().NoclipConnection=nil
end
getgenv().NoclipConnection=getgenv().RunService.Stepped:Connect(function()local S=getgenv().NoclipConfig and getgenv().NoclipConfig.Enabled
    if S then local S=getgenv().LocalPlayer.Character
        if S then local w,P=ipairs,table.pack(S:GetDescendants())
            for S,a in w(table.unpack(P))do S=a:IsA("BasePart")and a.CanCollide
                if S then a.CanCollide=false
                end
            end
        end
    end
end)
if getgenv().NoclipKeyConnection then pcall(function()getgenv().NoclipKeyConnection:Disconnect()
    end)
    getgenv().NoclipKeyConnection=nil
end
getgenv().NoclipKeyConnection=getgenv().UserInputService.InputBegan:Connect(function(S,w)if w then return
    end
    if getgenv().NoclipConfig and getgenv().NoclipConfig.Key and S.KeyCode==getgenv().NoclipConfig.Key then getgenv().NoclipConfig.Enabled=not getgenv().NoclipConfig.Enabled
    end
end)
Config.Misc_spinbot_lbl = (getgenv().MovementSection:AddLabel("spinbot"))
X[1662]=Config.Misc_spinbot_lbl
X[1661]={}
X[1661].Default=false
X[1661].Flag="Misc_SpinbotEnabled"
X[1661].Callback=function(S)if getgenv().spinbot then getgenv().spinbot.enabled=S
    end
end
X[1662]:AddToggle(X[1661])
Config.Misc_spinbot_speed_lbl = (getgenv().MovementSection:AddLabel("spinbot speed"))
X[1665]=Config.Misc_spinbot_speed_lbl
X[1664]={}
X[1664].Min=5
X[1664].Max=150
X[1664].Rounding=0
X[1664].Default=50
X[1664].Flag="Misc_SpinbotSpeed"
X[1664].Callback=function(S)if getgenv().spinbot then getgenv().spinbot.speed=S
    end
end
X[1665]:AddSlider(X[1664])
Config.Misc_noclip_lbl = (getgenv().MovementSection:AddLabel("noclip"))
X[1668]=Config.Misc_noclip_lbl
X[1667]={}
X[1667].Default=false
X[1667].Flag="Misc_NoclipEnabled"
X[1667].Callback=function(S)if getgenv().NoclipConfig then getgenv().NoclipConfig.Enabled=S
    end
end
X[1668]:AddToggle(X[1667])
X[1669]=getgenv()
X[1669].fh_closest_lbl = (Config.ForceHitSection:AddLabel("auto closest"))
X[1672]=getgenv().fh_closest_lbl
X[1672]:AddToggle({
    Default = false,
    Flag = "FH_AutoClosest",
    Callback = function(S)local w={}
            Config.ForceHit.AutoClosestTarget = S
    end,
})
X[1673]=getgenv()
X[1673].fh_closest_dist_lbl = (Config.ForceHitSection:AddLabel("closest check range"))
X[1676]=getgenv().fh_closest_dist_lbl
X[1676]:AddSlider({
    Min = 5,
    Max = 500,
    Rounding = 0,
    Default = 50,
    Flag = "FH_ClosestDistance",
    Callback = function(S)local w={}
            Config.ForceHit.ClosestMaxDistance = S
    end,
})
X[1677]=getgenv()
X[1677].fh_part_lbl = (Config.ForceHitSection:AddLabel("hitpart"))
X[1679]={}
N:jq(X[1679],0,getgenv().fh_part_lbl)
X[1680]={}
X[1680].Default="Head"
N:jq(X[1679],1,X[1680],{},"Head","HumanoidRootPart","UpperTorso","LowerTorso","RightUpperArm","LeftUpperArm","RightUpperLeg","LeftUpperLeg")
X[1679].n=11
X[156],X[157],X[158],X[159],X[160],X[161],X[162],X[163],X[164],X[165],X[166]=X[1679][1],X[1679][2],X[1679][3],X[1679][4],X[1679][5],X[1679][6],X[1679][7],X[1679][8],X[1679][9],X[1679][10],X[1679][11]
N:jq(X[158],0,X[159],X[160],X[161],X[162],X[163],X[164],X[165],X[166])
X[157].Values=X[158]
X[157].Flag = "FH_HitPart"
X[157].Callback=function(S)local w={}
        Config.ForceHit.HitPart = S
end
X[1682]=X[157]
X[156]:AddDropdown(X[1682])
X[167]=function(S)local w=S:match("@([^%)]+)")
    if w then return getgenv().Players:FindFirstChild(w)
    end
    return getgenv().Players:FindFirstChild(S)
end
X[1683]=getgenv()
X[1683].fh_players_lbl = (Config.ForceHitSection:AddLabel("select players"))
X[51]=(getgenv())
X[41]=getgenv().fh_players_lbl
X[49]={Default={},Multi=true,Values=getgenv().getPlayerNames(),Save=false}
X[168]=function(S)local w={}
    Config.ForceHit.TargetQueue = {}
    for P,a in pairs(S)do if a then local a=X[167](P)
            if a then table.insert(Config.ForceHit.TargetQueue,a)
            end
        end
    end
    S=#Config.ForceHit.TargetQueue>0
    if S then         Config.ForceHit.Target = nil
        local S,P=ipairs,Config.ForceHit.TargetQueue
        for a,v in S(P)do a=v.Character
            local S=a and a:FindFirstChildOfClass("Humanoid")
            if S and S.Health>0 then                 Config.ForceHit.Target = v
                break
            end
        end
    end
end
X[49].Callback=X[168]
X[1685]=X[49]
X[51].fh_players_dropdown = (X[41]:AddDropdown(X[1685]))
X[1688]=Config.ForceHitSection
X[1687]={}
X[1687].Name="Refresh Player Lists"
X[1687].Callback=function()if getgenv().update_player_list_fh then getgenv().update_player_list_fh()
    end
    if getgenv().update_player_list_glue then getgenv().update_player_list_glue()
    end
    getgenv().Logging.new("arrow-rotate-right","player lists updated",3)
end
X[1688]:AddButton(X[1687])
X[1689]=getgenv()
X[1689].fh_stomp_lbl = (getgenv().StrafeSection:AddLabel("stomp target"))
X[1692]=getgenv().fh_stomp_lbl
X[1692]:AddToggle({
    Default = false,
    Flag = "FH_StompTarget",
    Callback = function(S)getgenv().stompTargetEnabled=S
    end,
})
X[1693]=getgenv()
X[1693].fh_strafe_lbl = (getgenv().StrafeSection:AddLabel("target strafe"))
X[1696]=getgenv().fh_strafe_lbl
X[1696]:AddToggle({
    Default = false,
    Flag = "FH_TargetStrafe",
    Callback = function(S)local w={}
            Config.ForceHit.StrafeArmed = S
            Config.ForceHit.StrafeEnabled = S
        if not S then getgenv().stopStrafe()
        end
    end,
})
X[1698]=getgenv().fh_strafe_lbl
X[1698]:AddKeybind({
    Default = "N",
    Flag = "FH_StrafeKeybind",
    Callback = function(S)local w={}
        local P=getgenv().parseKey(S)
        if P then         Config.ForceHit.StrafeKey = P
        end
    end,
})
X[1699]=getgenv()
X[1699].fh_spoof_lbl = (getgenv().StrafeSection:AddLabel("spoof"))
X[1702]=getgenv().fh_spoof_lbl
X[1702]:AddToggle({
    Default = false,
    Flag = "FH_StrafeSpoof",
    Callback = function(S)local w={}
            Config.ForceHit.strafespoof = S
        if not S then getgenv().resetStrafeCamera()
        end
    end,
})
X[1703]=getgenv()
X[1703].fh_visstrafe_lbl = (getgenv().StrafeSection:AddLabel("visualize strafe"))
X[1706]=getgenv().fh_visstrafe_lbl
X[1706]:AddToggle({
    Default = false,
    Flag = "FH_VisualizeStrafe",
    Callback = function(S)local w={}
            Config.ForceHit.VisualizeStrafe = S
        if not S then getgenv().destroyStrafeVisualizer()
        end
    end,
})
X[1707]=getgenv()
X[1707].fh_strafespeed_lbl = (getgenv().StrafeSection:AddLabel("strafe speed"))
X[1710]=getgenv().fh_strafespeed_lbl
X[1710]:AddSlider({
    Min = 1,
    Max = 30,
    Rounding = 1,
    Default = 5,
    Flag = "FH_StrafeSpeed",
    Callback = function(S)local w={}
            Config.ForceHit.StrafeSpeed = S
    end,
})
X[1711]=getgenv()
X[1711].fh_strafedist_lbl = (getgenv().StrafeSection:AddLabel("strafe distance"))
X[1714]=getgenv().fh_strafedist_lbl
X[1714]:AddSlider({
    Min = 1,
    Max = 20,
    Rounding = 1,
    Default = 8,
    Flag = "FH_StrafeDistance",
    Callback = function(S)local w={}
            Config.ForceHit.StrafeDistance = S
    end,
})
X[1715]=getgenv()
X[1715].fh_strafeheight_lbl = (getgenv().StrafeSection:AddLabel("strafe height"))
X[1718]=getgenv().fh_strafeheight_lbl
X[1718]:AddSlider({
    Min = -15,
    Max = 15,
    Rounding = 1,
    Default = 0,
    Flag = "FH_StrafeHeight",
    Callback = function(S)local w={}
            Config.ForceHit.StrafeHeight = S
    end,
})
X[1719]=getgenv()
X[1719].fh_strafemode_lbl = (getgenv().StrafeSection:AddLabel("strafe mode"))
X[1721]={}
N:jq(X[1721],0,getgenv().fh_strafemode_lbl)
X[1722]={}
X[1722].Default="Orbit"
N:jq(X[1721],1,X[1722],{},"Orbit","Random","Far Random")
X[1721].n=6
X[169],X[170],X[171],X[172],X[173],X[174]=X[1721][1],X[1721][2],X[1721][3],X[1721][4],X[1721][5],X[1721][6]
N:jq(X[171],0,X[172],X[173],X[174])
X[170].Values=X[171]
X[170].Flag = "FH_StrafeMode"
X[170].Callback=function(S)local w={}
        Config.ForceHit.StrafeMode = S
end
X[1724]=X[170]
X[169]:AddDropdown(X[1724])
X[1725]=getgenv()
X[1725].fh_wall_lbl = (getgenv().ChecksSection:AddLabel("wall check"))
X[1728]=getgenv().fh_wall_lbl
X[1728]:AddToggle({
    Default = false,
    Flag = "FH_WallCheck",
    Callback = function(S)local w={}
            Config.ForceHit.WallCheck = S
    end,
})
X[1729]=getgenv()
X[1729].fh_ff_lbl = (getgenv().ChecksSection:AddLabel("forcefield check"))
X[1732]=getgenv().fh_ff_lbl
X[1732]:AddToggle({
    Default = true,
    Flag = "FH_FFCheck",
    Callback = function(S)local w={}
            Config.ForceHit.ForceFieldCheck = S
    end,
})
X[1733]=getgenv()
X[1733].fh_death_lbl = (getgenv().ChecksSection:AddLabel("death check"))
X[1736]=getgenv().fh_death_lbl
X[1736]:AddToggle({
    Default = true,
    Flag = "FH_DeathCheck",
    Callback = function(S)local w={}
            Config.ForceHit.DeathCheck = S
    end,
})
X[1737]=getgenv()
X[1737].fh_prefire_lbl = (getgenv().ChecksSection:AddLabel("prefire"))
X[1740]=getgenv().fh_prefire_lbl
X[1740]:AddToggle({
    Default = false,
    Flag = "FH_Prefire",
    Callback = function(S)local w={}
            Config.ForceHit.PrefireForceField = S
    end,
})
X[1741]=getgenv()
X[1741].fh_pretime_lbl = (getgenv().ChecksSection:AddLabel("prefire delay"))
X[1744]=getgenv().fh_pretime_lbl
X[1744]:AddSlider({
    Min = 0.01,
    Max = 1,
    Rounding = 2,
    Default = 0.1,
    Flag = "FH_PrefireTime",
    Callback = function(S)local w={}
            Config.ForceHit.PrefireTime = S
    end,
})
X[1745]=getgenv()
X[1745].fh_usemaxdist_lbl = (getgenv().ChecksSection:AddLabel("use max distance"))
X[1748]=getgenv().fh_usemaxdist_lbl
X[1748]:AddToggle({
    Default = true,
    Flag = "FH_UseMaxDistance",
    Callback = function(S)local w={}
            Config.ForceHit.UseMaxDistance = S
    end,
})
X[1749]=getgenv()
X[1749].fh_maxdist_lbl = (getgenv().ChecksSection:AddLabel("max range"))
X[1752]=getgenv().fh_maxdist_lbl
X[1752]:AddSlider({
    Min = 10,
    Max = 200,
    Rounding = 0,
    Default = 150,
    Flag = "FH_MaxDistance",
    Callback = function(S)local w={}
            Config.ForceHit.MaxDistance = S
    end,
})
X[1753]=getgenv()
X[1753].fh_tgtline_lbl = (getgenv().TargetVisualsSection:AddLabel("target tracer"))
X[1756]=getgenv().fh_tgtline_lbl
X[1756]:AddToggle({
    Default = true,
    Flag = "FH_TargetLine",
    Callback = function(S)local w={}
            Config.ForceHit.ShowTargetLine = S
    end,
})
X[1758]=getgenv().fh_tgtline_lbl
X[1758]:AddColorPicker({
    Default = Color3.fromRGB(255,255,255),
    Flag = "FH_TargetLineColor",
    Callback = function(S)local w={}
            Config.ForceHit.LineColor = S
    end,
})
X[1759]=getgenv()
X[1759].fh_spectate_lbl = (getgenv().TargetVisualsSection:AddLabel("spectate target"))
X[1762]=getgenv().fh_spectate_lbl
X[1762]:AddToggle({
    Default = false,
    Flag = "FH_SpectateTarget",
    Callback = function(S)getgenv().updateSpectate(S)
    end,
})
X[1763]=getgenv()
X[1763].fh_blttrace_lbl = (getgenv().BulletTracersSection:AddLabel("bullet tracers"))
X[1766]=getgenv().fh_blttrace_lbl
X[1766]:AddToggle({
    Default = true,
    Flag = "FH_BulletTracers",
    Callback = function(S)local w={}
            Config.ForceHit.BulletTracers = S
    end,
})
X[1768]=getgenv().fh_blttrace_lbl
X[1768]:AddColorPicker({
    Default = Color3.fromRGB(255,255,255),
    Flag = "FH_TracerColor",
    Callback = function(S)local w={}
            Config.ForceHit.TracerInlineColor = S
    end,
})
X[1769]=getgenv()
X[1769].fh_blttracetype_lbl = (getgenv().BulletTracersSection:AddLabel("tracer type"))
X[1771]={}
N:jq(X[1771],0,getgenv().fh_blttracetype_lbl)
X[1772]={}
X[1772].Default="Default"
N:jq(X[1771],1,X[1772],{},"Default","Hood Customs")
X[1771].n=5
X[175],X[176],X[177],X[178],X[179]=X[1771][1],X[1771][2],X[1771][3],X[1771][4],X[1771][5]
N:jq(X[177],0,X[178],X[179])
X[176].Values=X[177]
X[176].Flag = "FH_TracerType"
X[176].Callback=function(S)local w={}
        Config.ForceHit.TracerType = S
end
X[1774]=X[176]
X[175]:AddDropdown(X[1774])
X[1775]=getgenv()
X[1775].fh_tracelife_lbl = (getgenv().BulletTracersSection:AddLabel("tracer lifetime"))
X[1778]=getgenv().fh_tracelife_lbl
X[1778]:AddSlider({
    Min = 1.3,
    Max = 5.5,
    Rounding = 1,
    Default = 5.5,
    Flag = "FH_TracerLifetime",
    Callback = function(S)local w={}
            Config.ForceHit.TracerLifetime = S
    end,
})
X[1779]=getgenv()
X[1779].fh_tracewidth_lbl = (getgenv().BulletTracersSection:AddLabel("tracer width"))
X[1781]={}
N:jq(X[1781],0,getgenv().fh_tracewidth_lbl)
X[1782]={}
X[1782].Min=0.05
X[1782].Max=2
X[1782].Rounding=2
X[1782].Default=0.1
X[1782].Flag="FH_TracerWidth"
N:jq(X[1781],1,X[1782])
X[1781].n=2
X[180],X[181]=X[1781][1],X[1781][2]
X[181].Callback=function(S)local w={}
    local P,a=Config.ForceHit.TracerType,"Default"
    if P==a then         Config.ForceHit.TracerWidth = S
    end
end
X[1783]=X[181]
X[180]:AddSlider(X[1783])
X[1784]=getgenv()
X[1784].fh_hitchams_lbl = (getgenv().HitEffectsSection:AddLabel("hit chams"))
X[1787]=getgenv().fh_hitchams_lbl
X[1787]:AddToggle({
    Default = true,
    Flag = "FH_HitChams",
    Callback = function(S)local w={}
            Config.ForceHit.HitChamsEnabled = S
    end,
})
X[1789]=getgenv().fh_hitchams_lbl
X[1789]:AddColorPicker({
    Default = Color3.fromRGB(255,255,0),
    Flag = "FH_HitChamsColor",
    Callback = function(S)local w={}
            Config.ForceHit.HitChamsColor = S
    end,
})
X[1790]=getgenv()
X[1790].fh_chamsmat_lbl = (getgenv().HitEffectsSection:AddLabel("chams material"))
X[1792]={}
N:jq(X[1792],0,getgenv().fh_chamsmat_lbl)
X[1793]={}
X[1793].Default="neon"
N:jq(X[1792],1,X[1793],{},"forcefield","neon")
X[1792].n=5
X[182],X[183],X[184],X[185],X[186]=X[1792][1],X[1792][2],X[1792][3],X[1792][4],X[1792][5]
N:jq(X[184],0,X[185],X[186])
X[183].Values=X[184]
X[183].Flag = "FH_HitChamsMaterial"
X[183].Callback=function(S)local w={}
        Config.ForceHit.HitChamsMaterial = S
end
X[1795]=X[183]
X[182]:AddDropdown(X[1795])
X[1796]=getgenv()
X[1796].fh_chamstrans_lbl = (getgenv().HitEffectsSection:AddLabel("chams transparency"))
X[1799]=getgenv().fh_chamstrans_lbl
X[1799]:AddSlider({
    Min = 0,
    Max = 0.95,
    Rounding = 2,
    Default = 0,
    Flag = "FH_HitChamsTransparency",
    Callback = function(S)local w={}
            Config.ForceHit.HitChamsTransparency = S
    end,
})
X[1800]=getgenv()
X[1800].fh_chamslife_lbl = (getgenv().HitEffectsSection:AddLabel("chams duration"))
X[1803]=getgenv().fh_chamslife_lbl
X[1803]:AddSlider({
    Min = 0.5,
    Max = 5,
    Rounding = 1,
    Default = 2.5,
    Flag = "FH_HitChamsDuration",
    Callback = function(S)local w={}
            Config.ForceHit.HitChamsDuration = S
    end,
})
X[1804]=getgenv()
X[1804].fh_chamseffect_lbl = (getgenv().HitEffectsSection:AddLabel("chams effect"))
X[1806]={}
N:jq(X[1806],0,getgenv().fh_chamseffect_lbl)
X[1807]={}
X[1807].Default="fade"
N:jq(X[1806],1,X[1807],{},"fade","explode","minimize","flicker","shatter")
X[1806].n=8
X[187],X[188],X[189],X[190],X[191],X[192],X[193],X[194]=X[1806][1],X[1806][2],X[1806][3],X[1806][4],X[1806][5],X[1806][6],X[1806][7],X[1806][8]
N:jq(X[189],0,X[190],X[191],X[192],X[193],X[194])
X[188].Values=X[189]
X[188].Flag = "FH_HitChamsEffect"
X[188].Callback=function(S)local w={}
        Config.ForceHit.HitChamsEffect = S
end
X[1809]=X[188]
X[187]:AddDropdown(X[1809])
X[1810]=getgenv()
X[1810].fh_dmgindicator_lbl = (getgenv().HitEffectsSection:AddLabel("damage indicator"))
X[1813]=getgenv().fh_dmgindicator_lbl
X[1813]:AddToggle({
    Default = true,
    Flag = "FH_DamageIndicator",
    Callback = function(S)getgenv().DamageIndicatorEnabled=S
    end,
})
X[1814]={}
N:jq(X[1814],0,getgenv().fh_dmgindicator_lbl)
X[1815]={}
X[1815].Default="Phantom Forces"
N:jq(X[1814],1,X[1815],{},"Phantom Forces","Fortnite")
X[1814].n=5
X[195],X[196],X[197],X[198],X[199]=X[1814][1],X[1814][2],X[1814][3],X[1814][4],X[1814][5]
N:jq(X[197],0,X[198],X[199])
X[196].Values=X[197]
X[196].Flag = "FH_DamageIndicatorStyle"
X[196].Callback=function(S)getgenv().DamageIndicatorStyle=S
end
X[1817]=X[196]
X[195]:AddDropdown(X[1817])
X[1819]=getgenv().fh_dmgindicator_lbl
X[1819]:AddColorPicker({
    Default = Color3.fromRGB(255,225,0),
    Flag = "FH_DamageIndicatorColor",
    Callback = function(S)getgenv().DamageIndicatorColor=S
    end,
})
X[1820]=getgenv()
X[1821]={}
X[1821].starlight="rbxassetid://134645216613107"
X[1821].heavenly="rbxassetid://139300897520961"
X[1821].ribbon="rbxassetid://132069507632161"
X[1821].sakura="rbxassetid://81755778619404"
X[1821].angel="rbxassetid://97658130917593"
X[1821].wind="rbxassetid://80694081850877"
X[1821].flow="rbxassetid://119913533725648"
X[1821].star="rbxassetid://73754563740680"
X[1820].HitEffect_AuraIds = X[1821]
getgenv().HitEffect_LoadedModels=getgenv().HitEffect_LoadedModels or{}
X[199]=getgenv
X[23]=function(S)local w=271942485
    local P=w
    if getgenv().HitEffect_LoadedModels[S]then return getgenv().HitEffect_LoadedModels[S]
    end
    local a
    a,w=getgenv().HitEffect_AuraIds,bit32.bxor(P,524535565)
    local v=a[S]
    if not v then return nil
    end
    P=nil
    P,w=pcall,N:Aq(bit32.band(1872250469,w)+bit32.band(1872250469,231997866)+(bit32.band(2422716828,(bit32.bor(w,231997866)))+bit32.band(2422716826,(bit32.band(w,231997866)))))
    local w,a=P(function()local P=p
        return P:GetObjects(v)[1]
    end)
    if w and a then getgenv().HitEffect_LoadedModels[S]=a
        return a
    end
    return nil
end
X[1823]=X[199]()
X[1823].GetHitEffectAuraModel=X[23]
task.spawn(function()for S,w in pairs(getgenv().HitEffect_AuraIds)do getgenv().GetHitEffectAuraModel(S)
    end
end)
X[200]=function(S,w)local P={}
    if not S then return nil
    end
    local a=S:FindFirstChild(w)
    local v=a and a:IsA("BasePart")
    if v then return a
    end
    P[1]={}
    P[1]["Torso"]=S:FindFirstChild("UpperTorso")or S:FindFirstChild("LowerTorso")or S:FindFirstChild("Torso")
    P[1]["UpperTorso"]=S:FindFirstChild("Torso")or S:FindFirstChild("LowerTorso")
    P[1]["LowerTorso"]=S:FindFirstChild("Torso")or S:FindFirstChild("UpperTorso")
    P[1]["Left Arm"]=S:FindFirstChild("LeftUpperArm")or S:FindFirstChild("LeftLowerArm")or S:FindFirstChild("LeftHand")
    P[1]["Right Arm"]=S:FindFirstChild("RightUpperArm")or S:FindFirstChild("RightLowerArm")or S:FindFirstChild("RightHand")
    P[1]["Left Leg"]=S:FindFirstChild("LeftUpperLeg")or S:FindFirstChild("LeftLowerLeg")or S:FindFirstChild("LeftFoot")
    P[1]["Right Leg"]=S:FindFirstChild("RightUpperLeg")or S:FindFirstChild("RightLowerLeg")or S:FindFirstChild("RightFoot")
    P[1]["LeftUpperArm"]=S:FindFirstChild("Left Arm")or S:FindFirstChild("LeftLowerArm")
    P[1]["RightUpperArm"]=S:FindFirstChild("Right Arm")or S:FindFirstChild("RightLowerArm")
    P[1]["LeftUpperLeg"]=S:FindFirstChild("Left Leg")or S:FindFirstChild("LeftLowerLeg")
    P[1]["RightUpperLeg"]=S:FindFirstChild("Right Leg")or S:FindFirstChild("RightLowerLeg")
    a=P[1]
    v=a[w]or S:FindFirstChild("HumanoidRootPart")or S:FindFirstChild("Head")
    return v
end
X[58]=getgenv
X[127]=function(S)local w={}
    if not Config.ForceHit.HitEffectsEnabled then return
    end
    if not S then return
    end
    local P=S:FindFirstChild("HumanoidRootPart")or S:FindFirstChild("Head")
    if not P then return
    end
    local a,v,H=Config.ForceHit.HitEffectType or "Blood Splatter",Config.ForceHit.HitEffectsColor or Color3.fromRGB(255,255,255),Config.ForceHit.HitEffectsDuration or 1.5
    local E=a=="Blood Splatter"
    if E then local E=v
        if E==Color3.fromRGB(255,255,255)then E=Color3.fromRGB(120,10,10)
        end
        local R=P.Position
        local x=RaycastParams.new()
        x.FilterDescendantsInstances={S,getgenv().LocalPlayer.Character,workspace.CurrentCamera}
        x.FilterType=Enum.RaycastFilterType.Blacklist
        x.IgnoreWater=true
        for q=1,12,1 do task.spawn(function()local q={}
                local L=Instance.new("Part")
                L.Size=Vector3.new(0.12,0.12,0.12)
                L.Color=E
                L.Material=Enum.Material.Neon
                L.Transparency=0
                L.CanCollide=false
                L.CanQuery=false
                L.CanTouch=false
                L.Anchored=true
                L.Parent=workspace
                local Y=Instance.new("Attachment",L)
                Y.Position=Vector3.new(0,0.12,0)
                local r=Instance.new("Attachment",L)
                r.Position=Vector3.new(0,-0.12,0)
                local A=Instance.new("Trail")
                A.Attachment0=Y
                A.Attachment1=r
                A.Color=ColorSequence.new(E)
                A.Lifetime=0.25
                A.WidthScale=NumberSequence.new({NumberSequenceKeypoint.new(0,0.05),NumberSequenceKeypoint.new(0.25,0.35),NumberSequenceKeypoint.new(0.8,0.2),NumberSequenceKeypoint.new(1,0)})
                A.FaceCamera=true
                A.Parent=L
                local K,f,C=math.rad(math.random(0,360)),math.rad(math.random(15,75)),math.random(14,28)
                r=Vector3.new(math.cos(K)*math.cos(f)*C,math.sin(f)*C,math.sin(K)*math.cos(f)*C)
                L.CFrame=CFrame.new(R)
                K,C,Y=0.016666666666666666,1.8,0
                f=R
                while Y<C do Y+=K
                    r+=Vector3.new(0,-0.8,0)
                    local R=f+r*K
                    local Y=workspace:Raycast(f,R-f,x)
                    if Y then local x=357771994
                    local K=x
                    local C,l,Z=Y.Position,Y.Normal,Instance.new("Part")
                    Z.Shape=Enum.PartType.Cylinder
                    local Y,h,m,M=math.random(7,12)/10,math.random(7,9),bit32.band(1606480078,K)+bit32.band(1606480078,142811553)
                    x,M=N:Aq(m+(bit32.band(1082007140,(bit32.bor(142811553,K)))+bit32.band(1606480079,(bit32.bxor(K,142811553))))),Y*(h/10)
                    Z.Size=Vector3.new(0.02,Y,M)
                    Z.Color=E
                    Z.Material=Enum.Material.SmoothPlastic
                    Z.Transparency=0.05
                    Z.Anchored=true
                    Z.CanCollide=false
                    Z.CanQuery=false
                    Z.CanTouch=false
                    Z.CFrame=CFrame.lookAt(C,C+l)*CFrame.Angles(0,1.5707963267948966,0)*CFrame.Angles(math.rad(math.random(0,360)),0,0)
                    Z.Parent=workspace
                    m=nil
                    m,x=Instance.new,bit32.bxor(x,283942857)
                    local x=m("Decal")
                    q[1]="rbxassetid://16939835586"
                    x.Texture=q[1]
                    x.Color3=E
                    x.Face=Enum.NormalId.Top
                    x.Parent=Z
                    l=task.spawn
                    local function E()task.wait(H)
                    local q=p
                    local Y,K=q:GetService("TweenService"):Create(Z,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=1}),p
                    q=(K:GetService("TweenService"):Create(x,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=1}))
                    Y:Play()
                    q:Play()
                    Y.Completed:Wait()
                    Z:Destroy()
                end
                l(E)
                break
            else L.CFrame=CFrame.lookAt(R,R+r)
            end
            task.wait()
            f=R
        end
        A.Enabled=false
        task.wait(0.3)
        L:Destroy()
    end)
end
else local E=getgenv().HitEffect_AuraIds and getgenv().HitEffect_AuraIds[a]
if E then local E=237418900
    local R=E
    local x=getgenv().GetHitEffectAuraModel(a)
    local q=not x
    E=N:Aq(R+100402589)
    if q then return
    end
    local E=Instance.new("Model")
    w[1]="HitEffect_"..a
    E.Name=w[1]
    E.Parent=workspace
    local a,L,Y,r,A=x:Clone(),ColorSequence.new(v),{},{},ipairs
    R=table.pack(a:GetDescendants())
    for K,f in A(table.unpack(R))do q=(f:IsA("PointLight"))
        if q then f.Color=v
        else K=f:IsA("ParticleEmitter")or f:IsA("Beam")or f:IsA("Trail")
            if K then f.Color=L
            end
        end
    end
    x,A=ipairs,table.pack(a:GetChildren())
    for v,K in x(table.unpack(A))do R=X[200](S,K.Name)or P
        if R then L=R.CFrame
            q=(K:IsA("BasePart"))
            if q then K.CanCollide=false
                K.CanTouch=false
                K.CanQuery=false
                K.Massless=true
                K.Anchored=true
                K.Transparency=1
                K.CFrame=L
                K.Parent=E
                local S,P=ipairs,table.pack(K:GetDescendants())
                for R,q in S(table.unpack(P))do R=(q:IsA("ParticleEmitter"))
                    if R then q.LockedToPart=false
                    table.insert(Y,q)
                else local S="PointLight"
                    if q:IsA(S)then table.insert(r,q)
                end
            end
        end
    else local S=Instance.new("Part")
        w[2]=K.Name.."_StaticAnchor"
        S.Name=w[2]
        S.Size=Vector3.new(0.1,0.1,0.1)
        S.CFrame=L
        S.Transparency=1
        S.Anchored=true
        S.CanCollide=false
        S.CanTouch=false
        S.CanQuery=false
        S.Parent=E
        local w,P=K:Clone(),ipairs
        v=table.pack(w:GetChildren())
        for R,q in P(table.unpack(v))do q.Parent=S
            R=(q:IsA("ParticleEmitter"))
            if R then q.LockedToPart=false
                table.insert(Y,q)
            else local S="PointLight"
                if q:IsA(S)then table.insert(r,q)
                end
            end
            local S,P=ipairs,table.pack(q:GetDescendants())
            for v,R in S(table.unpack(P))do v=(R:IsA("ParticleEmitter"))
                if v then R.LockedToPart=false
                    table.insert(Y,R)
                else q="PointLight"
                    if R:IsA(q)then table.insert(r,R)
                end
            end
        end
    end
    w:Destroy()
end
end
end
a:Destroy()
for S,S in ipairs(Y)do local w=448354494
    x=nil
    x,w=pcall,bit32.bxor(w,16986572)
    x(function()S:Emit(25)
    end)
end
L=task.spawn
local function S()task.wait(H)
    for w,w in ipairs(Y)do if w and w.Parent then w.Enabled=false
        end
    end
    local w=ipairs
    for P,a in w(r)do P=a and a.Parent
        if P then local w=p
            w:GetService("TweenService"):Create(a,TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Brightness=0,Range=0}):Play()
        end
    end
    task.wait(2)
    if E and E.Parent then E:Destroy()
    end
end
L(S)
end
end
end
X[1824]=X[58]()
X[1824].FH_CreateCustomHitEffect=X[127]
X[1825]=getgenv()
X[1825].fh_custom_hiteffects_lbl = (getgenv().HitEffectsSection:AddLabel("hit effects"))
X[1828]=getgenv().fh_custom_hiteffects_lbl
X[1828]:AddToggle({
    Default = true,
    Flag = "FH_HitEffectsEnabled",
    Callback = function(S)local w={}
            Config.ForceHit.HitEffectsEnabled = S
    end,
})
X[1830]=getgenv().fh_custom_hiteffects_lbl
X[1830]:AddColorPicker({
    Default = Color3.fromRGB(255,255,255),
    Flag = "FH_HitEffectsColor",
    Callback = function(S)local w={}
            Config.ForceHit.HitEffectsColor = S
    end,
})
X[1831]=getgenv()
X[1831].fh_effects_death_lbl = (getgenv().HitEffectsSection:AddLabel("effects only on death"))
X[1834]=getgenv().fh_effects_death_lbl
X[1834]:AddToggle({
    Default = false,
    Flag = "FH_EffectsOnlyOnDeath",
    Callback = function(S)local w={}
            Config.ForceHit.OnlyOnDeath = S
    end,
})
X[1835]=getgenv()
X[1835].fh_custom_hiteffects_type_lbl = (getgenv().HitEffectsSection:AddLabel("effect type"))
X[1837]={}
N:jq(X[1837],0,getgenv().fh_custom_hiteffects_type_lbl)
X[1838]={}
X[1838].Default="Blood Splatter"
N:jq(X[1837],1,X[1838],{},"Blood Splatter","starlight","heavenly","ribbon","sakura","angel","wind","flow","star")
X[1837].n=12
X[201],X[202],X[203],X[204],X[205],X[206],X[207],X[208],X[209],X[210],X[211],X[212]=X[1837][1],X[1837][2],X[1837][3],X[1837][4],X[1837][5],X[1837][6],X[1837][7],X[1837][8],X[1837][9],X[1837][10],X[1837][11],X[1837][12]
N:jq(X[203],0,X[204],X[205],X[206],X[207],X[208],X[209],X[210],X[211],X[212])
X[202].Values=X[203]
X[202].Flag = "FH_HitEffectType"
X[202].Callback=function(S)local w={}
        Config.ForceHit.HitEffectType = S
end
X[1840]=X[202]
X[201]:AddDropdown(X[1840])
X[1841]=getgenv()
X[1841].fh_effects_duration_lbl = (getgenv().HitEffectsSection:AddLabel("hit effects duration"))
X[1844]=getgenv().fh_effects_duration_lbl
X[1844]:AddSlider({
    Min = 0.5,
    Max = 5,
    Rounding = 1,
    Default = 1.5,
    Flag = "FH_HitEffectsDuration",
    Callback = function(S)local w={}
            Config.ForceHit.HitEffectsDuration = S
    end,
})
X[1845]=getgenv()
X[1845].fh_hitsound_lbl = (getgenv().AudioFeedbackSection:AddLabel("hit sound"))
X[1848]=getgenv().fh_hitsound_lbl
X[1848]:AddToggle({
    Default = true,
    Flag = "FH_HitSound",
    Callback = function(S)local w={}
            Config.ForceHit.HitSoundEnabled = S
    end,
})
X[1849]=getgenv()
X[1849].fh_soundsel_lbl = (getgenv().AudioFeedbackSection:AddLabel("sound pack"))
X[1852]=getgenv().fh_soundsel_lbl
X[1852]:AddDropdown({
    Default = "Sparkles",
    Values = getgenv().hitsoundNames,
    Flag = "FH_SoundSelect",
    Callback = function(S)local w={}
        Config.ForceHit.HitSoundId = getgenv().HitSounds[S]
    end,
})
X[1853]=getgenv()
X[1853].fh_volume_lbl = (getgenv().AudioFeedbackSection:AddLabel("volume"))
X[1856]=getgenv().fh_volume_lbl
X[1856]:AddSlider({
    Min = 0,
    Max = 100,
    Default = 50,
    Flag = "FH_Volume",
    Callback = function(S)getgenv().HitSound.Volume=S/100
    end,
})
X[1857]=getgenv()
X[1857].fh_hitnotif_lbl = (getgenv().AudioFeedbackSection:AddLabel("notifications"))
X[1860]=getgenv().fh_hitnotif_lbl
X[1860]:AddToggle({
    Default = true,
    Flag = "FH_HitNotif",
    Callback = function(S)local w={}
            Config.ForceHit.HitNotification = S
    end,
})
X[1861]=getgenv()
X[1861].fh_autotoxic_lbl = (getgenv().AudioFeedbackSection:AddLabel("auto toxic"))
X[1864]=getgenv().fh_autotoxic_lbl
X[1864]:AddToggle({
    Default = false,
    Flag = "FH_AutoToxic",
    Callback = function(S)local w={}
            Config.ForceHit.AutoToxicEnabled = S
    end,
})
X[1865]=getgenv()
X[1865].knife_hitbox_lbl = (getgenv().KnifebotSection:AddLabel("knife hitbox expander"))
X[1868]=getgenv().knife_hitbox_lbl
X[1868]:AddToggle({
    Default = false,
    Flag = "KnifeHitbox",
    Callback = function(S)getgenv().KnifeHitboxEnabled=S
        X[153]()
    end,
})
task.spawn(function()while true do task.wait(0.03)
        local S=getgenv().KnifeVisualizerConfig
        local w=S and S.Enabled and S.Pulse
        if w then local w=(math.sin(os.clock()*(S.PulseSpeed or 3))+1)*0.5
            local P,a=S.Transparency+w*0.2,getgenv().LocalPlayer.Character
            w=a and a:FindFirstChild("[Knife]")
            a=w and w:FindFirstChild("Handle")
            w=a and(a:FindFirstChild("HITBOX_PART")or a)
            if w then a=(w:FindFirstChild("Visualizer_Adornment"))
                if a then a.Transparency=P
                end
                local S=w:FindFirstChild("Visualizer_Box")
                if S then S.SurfaceTransparency=P
                end
            end
        end
    end
end)
X[1869]=getgenv()
X[1869].knife_vis_toggle = (getgenv().KnifebotSection:AddLabel("hitbox visualizer"))
X[1872]=getgenv().knife_vis_toggle
X[1872]:AddToggle({
    Default = false,
    Flag = "KnifeVisualizerEnabled",
    Callback = function(S)getgenv().KnifeVisualizerConfig.Enabled=S
        X[153]()
    end,
})
X[1874]=getgenv().knife_vis_toggle
X[1874]:AddColorPicker({
    Default = Color3.fromRGB(120,150,255),
    Flag = "KnifeVisualizerColor",
    Callback = function(S)getgenv().KnifeVisualizerConfig.Color=S
        X[153]()
    end,
})
X[30]=getgenv().KnifebotSection
X[172]="visualizer style"
X[1875]={}
X[1876]=X[172]
X[1877]=(X[30]:AddLabel(X[1876]))
N:jq(X[1875],0,X[1877])
X[1878]={}
X[1878].Default="Adornment"
N:jq(X[1875],1,X[1878],{},"Adornment","Hologram","Wireframe","Highlight")
X[1875].n=7
X[213],X[214],X[215],X[216],X[217],X[218],X[219]=X[1875][1],X[1875][2],X[1875][3],X[1875][4],X[1875][5],X[1875][6],X[1875][7]
N:jq(X[215],0,X[216],X[217],X[218],X[219])
X[214].Values=X[215]
X[214].Flag = "KnifeVisualizerStyle"
X[214].Callback=function(S)getgenv().KnifeVisualizerConfig.Style=S
    X[153]()
end
X[1880]=X[214]
X[213]:AddDropdown(X[1880])
X[1882]=getgenv().KnifebotSection:AddLabel("transparency")
X[1882]:AddSlider({
    Min = 0.1,
    Max = 0.95,
    Rounding = 2,
    Default = 0.65,
    Flag = "KnifeVisualizerTransparency",
    Callback = function(S)getgenv().KnifeVisualizerConfig.Transparency=S
        X[153]()
    end,
})
X[1884]=getgenv().KnifebotSection:AddLabel("pulse effect")
X[1884]:AddToggle({
    Default = true,
    Flag = "KnifeVisualizerPulse",
    Callback = function(S)getgenv().KnifeVisualizerConfig.Pulse=S
    end,
})
X[1885]=getgenv()
X[1885].auto_knife_lbl = (getgenv().KnifebotSection:AddLabel("auto swing knife"))
X[1888]=getgenv().auto_knife_lbl
X[1887]={}
X[1887].Default=false
X[1887].Flag="AutoKnife"
X[1887].Callback=function(S)getgenv().AutoKnifeEnabled=S
    if S then getgenv().start_auto_knife()
    elseif getgenv().auto_knife_loop then getgenv().auto_knife_loop:Disconnect()
            getgenv().auto_knife_loop=nil
        end
    end
    X[1888]:AddToggle(X[1887])
    X[1889]=getgenv()
    X[1889].glue_lbl = (getgenv().GlueSection:AddLabel("glue connection"))
    X[1892]=getgenv().glue_lbl
    X[1892]:AddToggle({
        Default = false,
        Flag = "GlueConnection",
        Callback = function(S)getgenv().feature_enabled=S
                if not getgenv().feature_enabled then getgenv().glue_active=false
                    if getgenv().connection_loop then getgenv().connection_loop:Disconnect()
                        getgenv().connection_loop=nil
                    end
                    if getgenv().no_unc_loop then getgenv().no_unc_loop:Disconnect()
                        getgenv().no_unc_loop=nil
                    end
                    getgenv().reset_velocity()
                end
            end,
    })
    X[1894]=getgenv().glue_lbl
    X[1894]:AddKeybind({
        Default = "G",
        Flag = "GlueKeybind",
        Callback = function(S)local w=getgenv().parseKey(S)
                if w then getgenv().GlueKey=w
                end
            end,
    })
    X[1895]=getgenv()
    X[1895].glue_spoof_lbl = (getgenv().GlueSection:AddLabel("spoof glue"))
    X[1898]=getgenv().glue_spoof_lbl
    X[1898]:AddToggle({
        Default = false,
        Flag = "GlueSpoof",
        Callback = function(S)getgenv().glue_spoof=S
                if not S then getgenv().resetStrafeCamera()
                end
            end,
    })
    X[1899]=getgenv()
    X[1899].glue_stomp_lbl = (getgenv().GlueSection:AddLabel("stomp glue target"))
    X[1902]=getgenv().glue_stomp_lbl
    X[1902]:AddToggle({
        Default = false,
        Flag = "GlueStompTarget",
        Callback = function(S)getgenv().stompGlueTargetEnabled=S
            end,
    })
    X[1903]=getgenv()
    X[1903].glue_pos_lbl = (getgenv().GlueSection:AddLabel("attach position"))
    X[1905]={}
    N:jq(X[1905],0,getgenv().glue_pos_lbl)
    X[1906]={}
    X[1906].Default="Back"
    N:jq(X[1905],1,X[1906],{},"Back","Front","Left Side","Random","Backstab")
    X[1905].n=8
    X[220],X[221],X[222],X[223],X[224],X[225],X[226],X[227]=X[1905][1],X[1905][2],X[1905][3],X[1905][4],X[1905][5],X[1905][6],X[1905][7],X[1905][8]
    N:jq(X[222],0,X[223],X[224],X[225],X[226],X[227])
    X[221].Values=X[222]
    X[221].Flag = "GluePosition"
    X[221].Callback=function(S)getgenv().glue_position=S
    end
    X[1908]=X[221]
    X[220]:AddDropdown(X[1908])
    X[1909]=getgenv()
    X[1909].glue_rage_lbl = (getgenv().GlueSection:AddLabel("void spam"))
    X[1912]=getgenv().glue_rage_lbl
    X[1912]:AddToggle({
        Default = false,
        Flag = "KA_RageBlink",
        Callback = function(S)getgenv().KnifeRage.Enabled=S
            end,
    })
    X[1913]=getgenv()
    X[1913].glue_rage_auto_lbl = (getgenv().GlueSection:AddLabel("auto calculate knife swing"))
    X[1916]=getgenv().glue_rage_auto_lbl
    X[1916]:AddToggle({
        Default = false,
        Flag = "KA_RageAutoSwing",
        Callback = function(S)getgenv().KnifeRage.AutoCalculate=S
            end,
    })
    X[1917]=getgenv()
    X[1917].glue_ragespeed_lbl = (getgenv().GlueSection:AddLabel("void spam speed"))
    X[1920]=getgenv().glue_ragespeed_lbl
    X[1920]:AddSlider({
        Min = 0.05,
        Max = 0.5,
        Rounding = 2,
        Default = 0.12,
        Flag = "KA_RageInterval",
        Callback = function(S)getgenv().KnifeRage.Interval=S
            end,
    })
    X[1921]=getgenv()
    X[1922]={}
    X[1922].Enabled=false
    X[1922].SelectedGun="[Revolver]"
    X[1921].HoldGunAndKnifeConfig = X[1922]
    task.spawn(function()while true do task.wait(0.1)
            local S=getgenv().HoldGunAndKnifeConfig.Enabled
            if S then local S=384818972
                local w=S
                local P
                P,S=pcall,N:Aq(bit32.band(3291583740,w)+bit32.band(3291583740,390002203)+(bit32.band(2006767112,(bit32.bor(w,390002203)))+bit32.band(3291583741,(bit32.bxor(w,390002203)))))
                P(function()local S=getgenv().LocalPlayer
                    local w,P=S and S.Character,S and S:FindFirstChild("Backpack")
                    S=w and w:FindFirstChildOfClass("Humanoid")
                    if not w or not P or not S or S.Health<=0 then return
                end
                local a=getgenv().HoldGunAndKnifeConfig.SelectedGun
                local v,H=w:FindFirstChild(a)or P:FindFirstChild(a),w:FindFirstChild("[Knife]")or P:FindFirstChild("[Knife]")
                if v and v.Parent==P then S:EquipTool(v)
                end
                if H and H.Parent==P then H.Parent=w
                end
            end)
        end
    end
end)
X[64]=getgenv().KnifebotSection
if X[64]then X[133]=(getgenv().KnifebotSection:AddLabel("hold gun + knife"))
    X[133]:AddToggle({
        Default = false,
        Flag = "KnifeBot_HoldGunAndKnife",
        Callback = function(S)getgenv().HoldGunAndKnifeConfig.Enabled=S
                if S then getgenv().Logging.new("crosshairs","hold gun + knife enabled",3)
                end
            end,
    })
    X[1925]={}
    X[1925].Default="[Revolver]"
    local S,w,P,a,v,H,E,R=X[1925],{},"[Revolver]","[DoubleBarrel]","[TacticalShotgun]","[SMG]","[Shotgun]","[Silencer]"
    N:jq(w,0,P,a,v,H,E,R)
    S.Values=w
    S.Flag = "KnifeBot_HoldGunChoice"
    S.Callback=function(w)getgenv().HoldGunAndKnifeConfig.SelectedGun=w
    end
    X[1927]=S
    X[133]:AddDropdown(X[1927])
end
X[1928]=getgenv()
X[1928].glue_dist_lbl = (getgenv().GlueSection:AddLabel("attach distance"))
X[1931]=getgenv().glue_dist_lbl
X[1931]:AddSlider({
    Min = 0.3,
    Max = 20,
    Rounding = 1,
    Default = 3,
    Flag = "GlueDistance",
    Callback = function(S)getgenv().glue_offset_z=S
    end,
})
X[1932]=getgenv()
X[1932].glue_vis_lbl = (getgenv().GlueSection:AddLabel("glue rig"))
X[1935]=getgenv().glue_vis_lbl
X[1935]:AddToggle({
    Default = false,
    Flag = "Glue_Visualizer",
    Callback = function(S)getgenv().GlueVis.Enabled=S
        if S then getgenv().GlueVis_Create()
        else getgenv().GlueVis_Destroy()
        end
    end,
})
X[1937]=getgenv().glue_vis_lbl
X[1937]:AddColorPicker({
    Default = Color3.fromRGB(255,140,0),
    Flag = "Glue_VisualizerColor",
    Callback = function(S)getgenv().GlueVis.Color=S
    end,
})
X[1938]=getgenv()
X[1938].glue_vis_trans_lbl = (getgenv().GlueSection:AddLabel("rig transparency"))
X[1941]=getgenv().glue_vis_trans_lbl
X[1941]:AddSlider({
    Min = 0,
    Max = 0.9,
    Rounding = 2,
    Default = 0.5,
    Flag = "Glue_VisualizerTrans",
    Callback = function(S)getgenv().GlueVis.Transparency=S
    end,
})
X[1942]=getgenv()
X[1942].glue_vis_ind_lbl = (getgenv().GlueSection:AddLabel("position indicator"))
X[1945]=getgenv().glue_vis_ind_lbl
X[1945]:AddToggle({
    Default = true,
    Flag = "Glue_VisIndicator",
    Callback = function(S)getgenv().GlueVis.IndicatorEnabled=S
        getgenv().ServerPositionIndicatorConfig.GlueEnabled=S
        getgenv().ServerPositionIndicatorConfig.Enabled=S or getgenv().ServerPositionIndicatorConfig.DesyncEnabled
        if not getgenv().ServerPositionIndicatorConfig.Enabled and getgenv().SV_SetVisibility then getgenv().SV_SetVisibility(false)
        end
    end,
})
X[1946]=getgenv()
X[1946].glue_vis_tracer_lbl = (getgenv().GlueSection:AddLabel("tracer"))
X[1949]=getgenv().glue_vis_tracer_lbl
X[1949]:AddToggle({
    Default = true,
    Flag = "Glue_VisTracer",
    Callback = function(S)getgenv().GlueVis.TracerEnabled=S
        if not S and getgenv().GlueTracer then getgenv().GlueTracer.Visible=false
        end
    end,
})
X[1951]=getgenv().glue_vis_tracer_lbl
X[1951]:AddColorPicker({
    Default = Color3.fromRGB(255,140,0),
    Flag = "Glue_VisTracerColor",
    Callback = function(S)getgenv().GlueVis.TracerColor=S
    end,
})
X[1952]=getgenv()
X[1952].glue_target_lbl = (getgenv().GlueSection:AddLabel("select glue target"))
getgenv().glue_target_dropdown=getgenv().glue_target_lbl:AddDropdown({Default={},Multi=true,Values=getgenv().getPlayerNames(),Save=false,Callback=function(S)getgenv().target_players={}
    for w,P in pairs(S)do if P then local S=getgenv().getPlayerFromLabel(w)
            if S then table.insert(getgenv().target_players,S.Name)
            end
        end
    end
    if getgenv().show_target_status then getgenv().get_target_list_string()
        getgenv().check_target_validity()
    end
end})
X[228]=function(S,w)if not S then return false
    end
    local P,a,v,H={},"Refresh","Update","SetValues"
    N:jq(P,0,a,v,H,"Set")
    a=ipairs
    for E,R in a(P)do E=(type(S[R]))
        v="function"
        if E==v then if pcall(S[R],S,w)then return true
            end
        end
    end
    a=S.Dropdown
    if a then v=ipairs
        for a,E in v(P)do H=(type(S.Dropdown[E]))
            a="function"
            if H==a then if pcall(S.Dropdown[E],S.Dropdown,w)then return true
                end
            end
        end
    end
    return false
end
getgenv().update_player_list_fh=function()local S=getgenv().getPlayerNames()
    X[228](getgenv().fh_players_dropdown,S)
    X[228](getgenv().fh_whitelist_dropdown,S)
    X[228](getgenv().ka_whitelist_dropdown,S)
end
getgenv().update_player_list_glue=function()if getgenv().glue_target_dropdown then local S,w=getgenv().getPlayerNames(),{}
        for P,P in ipairs(getgenv().target_players)do if table.find(S,P)then table.insert(w,P)
            end
        end
        getgenv().target_players=w
        X[228](getgenv().glue_target_dropdown,S)
    end
end
X[141]=getgenv().window.UserSettings
X[20]="menu keybind"
X[1954]={}
X[1955]=X[20]
X[1956]=(X[141]:AddLabel(X[1955]))
N:jq(X[1954],0,X[1956])
X[1957]={}
X[1957].Default="RightControl"
X[1957].Flag="Menu_Keybind_Flag"
N:jq(X[1954],1,X[1957])
X[1954].n=2
X[229],X[230]=X[1954][1],X[1954][2]
X[230].Callback=function(S)getgenv().window.Keybind=S
    getgenv().Logging.new("ps4-touchpad","changed ui keybind to "..tostring(S),5)
end
X[1958]=X[230]
X[229]:AddKeybind(X[1958])
X[1960]=getgenv().window.UserSettings:AddLabel("show keybind menu")
X[1960]:AddToggle({
    Default = true,
    Flag = "Menu_KeybindsVisible",
    Callback = function(S)getgenv().SetKeybindHUDVisible(S)
    end,
})
X[173]=getgenv().window.UserSettings
X[1961] = "menu scale"
X[197]=(X[173]:AddLabel(X[1961]))
X[1962]={}
X[1962].Default="Large"
X[211]=X[1962]
X[227]={}
X[6]="Default"
X[141]="Large"
X[205]="Mobile"
X[210]="Small"
N:jq(X[227],0,X[6],X[141],X[205],X[210])
X[211].Values=X[227]
X[211].Flag = "Menu_Scale_Flag"
X[231]=function(S)getgenv().window:SetSize(getgenv().NeverLose.Scales[S])
    getgenv().Logging.new("crop","changed ui size to "..tostring(S),5)
end
X[211].Callback=X[231]
X[1964]=X[211]
X[197]:AddDropdown(X[1964])
getgenv().window.UserSettings:AddLabel("-ui themes-")
X[1965]={}
X[1966]={}
X[1966]["Dark Blue (Default)"]={Main=Color3.fromRGB(8,8,13),Secondary=Color3.fromRGB(20,22,27),Input=Color3.fromRGB(26,28,36),Accent=Color3.fromRGB(78,127,252),Stroke=Color3.fromRGB(45,48,58),Text=Color3.fromRGB(255,255,255),CornerRadius=8,Font=Enum.Font.GothamMedium,BoldFont=Enum.Font.GothamBold,StrokeThickness=1,StrokeTransparency=0.65,BgTransparency=0.055,SecondaryTransparency=0.5}
X[1966]["Retro Skeet (Boxy)"]={Main=Color3.fromRGB(10,10,12),Secondary=Color3.fromRGB(17,17,22),Input=Color3.fromRGB(22,22,28),Accent=Color3.fromRGB(160,96,255),Stroke=Color3.fromRGB(60,60,80),Text=Color3.fromRGB(240,240,245),CornerRadius=0,Font=Enum.Font.Code,BoldFont=Enum.Font.Code,StrokeThickness=1.5,StrokeTransparency=0.2,BgTransparency=0,SecondaryTransparency=0}
X[1966]["Bubbly Pink (Cute)"]={Main=Color3.fromRGB(26,12,24),Secondary=Color3.fromRGB(42,18,38),Input=Color3.fromRGB(58,24,52),Accent=Color3.fromRGB(255,105,180),Stroke=Color3.fromRGB(90,35,80),Text=Color3.fromRGB(255,245,250),CornerRadius=14,Font=Enum.Font.FredokaOne,BoldFont=Enum.Font.FredokaOne,StrokeThickness=1.2,StrokeTransparency=0.5,BgTransparency=0.08,SecondaryTransparency=0.45}
X[1966]["Glassmorphism (Clear)"]={Main=Color3.fromRGB(15,20,30),Secondary=Color3.fromRGB(25,30,45),Input=Color3.fromRGB(40,45,65),Accent=Color3.fromRGB(0,191,255),Stroke=Color3.fromRGB(255,255,255),Text=Color3.fromRGB(255,255,255),CornerRadius=10,Font=Enum.Font.SourceSans,BoldFont=Enum.Font.SourceSansBold,StrokeThickness=1,StrokeTransparency=0.82,BgTransparency=0.42,SecondaryTransparency=0.65}
X[1966]["Minimalist Light"]={Main=Color3.fromRGB(245,245,248),Secondary=Color3.fromRGB(230,230,235),Input=Color3.fromRGB(215,215,220),Accent=Color3.fromRGB(40,40,40),Stroke=Color3.fromRGB(190,190,200),Text=Color3.fromRGB(40,40,45),CornerRadius=6,Font=Enum.Font.Arial,BoldFont=Enum.Font.ArialBold,StrokeThickness=1,StrokeTransparency=0.7,BgTransparency=0.05,SecondaryTransparency=0.3}
X[1966]["Pastel Dark"]={Main=Color3.fromRGB(15,15,17),Secondary=Color3.fromRGB(22,22,26),Input=Color3.fromRGB(30,30,36),Accent=Color3.fromRGB(238,208,216),Stroke=Color3.fromRGB(60,62,70),Text=Color3.fromRGB(240,240,245),CornerRadius=2,Font=Enum.Font.Gotham,BoldFont=Enum.Font.GothamBold,StrokeThickness=1,StrokeTransparency=0.25,BgTransparency=0.02,SecondaryTransparency=0.15}
N:jq(X[1965],0,X[1966])
X[1965].n=1
X[232]=X[1965][1]
X[1967]=getgenv()
X[1969]=getgenv().ActiveUITheme
if not X[1969]then X[1968]="Dark Blue (Default)"
    X[1969]=X[232][X[1968]]
end
X[1967].ActiveUITheme = X[1969]
X[233]=function(S,w)local P={}
    if not w then return
    end
    local a=not S:GetAttribute("ThemeRole")
    if a then local v=S:IsA("Frame")or S:IsA("ScrollingFrame")
        if v then local v=S.BackgroundColor3
            local H=v==Color3.fromRGB(8,8,13)
            if H then S:SetAttribute("ThemeRole","Main")
            else local H=v==Color3.fromRGB(20,22,27)or v==Color3.fromRGB(25,27,33)or v==Color3.fromRGB(21,20,27)or v==Color3.fromRGB(29,31,38)
                if H then S:SetAttribute("ThemeRole","Secondary")
                else local H=v==Color3.fromRGB(26,28,36)or v==Color3.fromRGB(30,29,36)or v==Color3.fromRGB(13,17,22)or v==Color3.fromRGB(39,40,49)
                    if H then S:SetAttribute("ThemeRole","Input")
                else local H=v==Color3.fromRGB(78,127,252)
                    if H then S:SetAttribute("ThemeRole","Accent")
                end
            end
        end
    end
else local v=S:IsA("UIStroke")
    if v then local v=S.Color==Color3.fromRGB(78,127,252)
        if v then S:SetAttribute("ThemeRole","AccentStroke")
        else local v=S.Color==Color3.fromRGB(45,48,58)
            if v then S:SetAttribute("ThemeRole","Stroke")
            end
        end
    else local v=S:IsA("TextLabel")or S:IsA("TextBox")
        if v then local v=S.TextColor3==Color3.fromRGB(78,127,252)
            if v then S:SetAttribute("ThemeRole","AccentText")
            else local v=S.TextColor3==Color3.fromRGB(255,255,255)or S.TextColor3==Color3.fromRGB(223,223,223)or S.TextColor3==Color3.fromRGB(240,240,245)or S.TextColor3==Color3.fromRGB(200,200,210)
                if v then S:SetAttribute("ThemeRole","Text")
                end
            end
        else local v=S:IsA("ImageLabel")
            if v then local v=S.ImageColor3==Color3.fromRGB(78,127,252)
                if v then S:SetAttribute("ThemeRole","AccentImage")
                end
            end
        end
    end
end
end
a=(S:IsA("UICorner"))
if a then local v=S.CornerRadius.Scale==1 or S.Parent and(S.Parent.Name:lower():find("circle")or S.Parent.Name:lower():find("profile")or S.Parent.Name:lower():find("logo")or S.Parent.Name:lower():find("icon"))
    if v then S.CornerRadius=UDim.new(1,0)
    else S.CornerRadius=UDim.new(0,w.CornerRadius)
    end
end
a=(S:GetAttribute("ThemeRole"))
if a then local v=a=="Main"
    if v then S.BackgroundColor3=w.Main
        S.BackgroundTransparency=w.BgTransparency
    else local v=a=="Secondary"
        if v then S.BackgroundColor3=w.Secondary
            S.BackgroundTransparency=w.SecondaryTransparency
        else local v=a=="Input"
            if v then S.BackgroundColor3=w.Input
                S.BackgroundTransparency=0
            else local v=a=="Accent"
                if v then S.BackgroundColor3=w.Accent
                else local v=a=="AccentStroke"
                    if v then S.Color=w.Accent
                    S.Thickness=w.StrokeThickness
                else local v=a=="Stroke"
                    if v then S.Color=w.Stroke
                    S.Thickness=w.StrokeThickness
                    S.Transparency=w.StrokeTransparency
                else local v=a=="AccentText"
                    if v then S.TextColor3=w.Accent
                else local v=a=="Text"
                    if v then S.TextColor3=w.Text
                    local v=if S.FontFace and typeof(S.FontFace)=="Font"then if S.FontFace.Family:find("BuilderIcons")then true else false else false
                    v=if S.Name:lower():find("icon")or S.Name:lower():find("logo")then true else v
                    local H=not v
                    if H then local v=S.Font~=w.Font and S.Font~=w.BoldFont
                    if v then P[1]=S.Font.Name:lower():find("bold")and w.BoldFont or w.Font
                    S.Font=P[1]
                end
            end
        else local P="AccentImage"
            if a==P then S.ImageColor3=w.Accent
            end
        end
    end
end
end
end
end
end
end
end
end
local function S(w)getgenv().ActiveUITheme=w
    getgenv().NeverLose.MainColor=w.Main
    getgenv().NeverLose.AccentColor=w.Accent
    local P=getgenv().NeverLose.ScreenGui
    if not P then return
    end
    for a,a in ipairs(P:GetDescendants())do X[233](a,w)
    end
end
X[6]=getgenv().NeverLose.ScreenGui
if X[6]then if getgenv().ThemeConnection then getgenv().ThemeConnection:Disconnect()
    end
    X[1971]=getgenv()
    X[1972]=(X[6].DescendantAdded:Connect(function(w)local P=454114460
        local a=P
        local v=task
        P=N:Aq(bit32.band(425831189,a)+bit32.band(425831189,321548783)+(bit32.band(3869136108,(bit32.bor(a,321548783)))+bit32.band(3869136106,(bit32.band(a,321548783)))))
        a=v.defer
        P=bit32.bxor(P,172024532)
        a(function()if w.Parent then X[233](w,getgenv().ActiveUITheme)
            end
        end)
    end))
    X[1971].ThemeConnection=X[1972]
end
do X[1974]=getgenv().window.UserSettings:AddLabel("theme")
    X[1973]={}
    X[1973].Default="Dark Blue (Default)"
    local w,P,a,v,H,E,R,x,q=X[1974],X[1973],{},"Dark Blue (Default)","Pastel Dark (Onyx & Pink)","Retro Skeet (Boxy)","Bubbly Pink (Cute)","Glassmorphism (Clear)","Minimalist Light"
    N:jq(a,0,v,H,E,R,x,q)
    P.Values=a
    P.Flag = "Menu_ThemeSelection_Flag"
    P.Callback=function(a)local v=X[232][a]
        if v then S(v)
            getgenv().Logging.new("paint-brush","Applied Theme: "..a,3)
        end
    end
    w:AddDropdown(P)
    X[62]=(w:AddOption(1))
    local function w(P,a)local v=getgenv().ActiveUITheme or X[232]["Dark Blue (Default)"]
        S({Main=v.Main,Secondary=v.Secondary,Input=v.Input,Accent=v.Accent,Stroke=v.Stroke,Text=v.Text,CornerRadius=v.CornerRadius,Font=v.Font,BoldFont=v.BoldFont,StrokeThickness=v.StrokeThickness,StrokeTransparency=v.StrokeTransparency,BgTransparency=v.BgTransparency,SecondaryTransparency=v.SecondaryTransparency,[P]=a})
    end
    X[61]={}
    X[42]={}
    X[171]="accent color"
    X[118]="Accent"
    X[7]=getgenv().NeverLose.AccentColor or Color3.fromRGB(78,127,252)
    X[58]="Menu_Custom_Accent"
    N:jq(X[42],0,X[171],X[118],X[7],X[58])
    X[18]={}
    X[55]="main background"
    X[185]="Main"
    X[10]=(Color3.fromRGB(8,8,13))
    X[211]="Menu_Custom_Main"
    N:jq(X[18],0,X[55],X[185],X[10],X[211])
    X[207]={}
    X[225]="secondary background"
    X[226]="Secondary"
    X[125]=(Color3.fromRGB(20,22,27))
    X[54]="Menu_Custom_Secondary"
    N:jq(X[207],0,X[225],X[226],X[125],X[54])
    X[26]={}
    X[100]="controls / inputs"
    X[111]="Input"
    X[168]=(Color3.fromRGB(26,28,36))
    X[212]="Menu_Custom_Input"
    N:jq(X[26],0,X[100],X[111],X[168],X[212])
    H={}
    X[68]="border stroke"
    X[156]="Stroke"
    X[135]=(Color3.fromRGB(45,48,58))
    X[127]="Menu_Custom_Stroke"
    N:jq(H,0,X[68],X[156],X[135],X[127])
    X[199]={}
    X[23]="text color"
    E="Text"
    X[194]=(Color3.fromRGB(255,255,255))
    X[229]="Menu_Custom_Text"
    N:jq(X[199],0,X[23],E,X[194],X[229])
    N:jq(X[61],0,X[42],X[18],X[207],X[26],H,X[199])
    for S,S in ipairs(X[61])do X[1976]=S[1]
        X[62]:AddLabel(X[1976]):AddColorPicker({Default=S[3],Flag=S[4],Callback=function(P)w(S[2],P)
        end})
    end
    X[1977] = "logo color"
    X[1979]=X[62]:AddLabel(X[1977])
    X[1978]={}
    X[1978].Default=getgenv().NeverLose.IconColor or Color3.fromRGB(255,255,255)
    X[1978].Flag="Menu_Custom_LogoColor"
    local S,w=X[1979],X[1978]
    w.Callback=function(P)getgenv().NeverLose.IconColor=P
        local a=getgenv().NeverLose.ScreenGui
        if a then local a,v=pairs,table.pack(getgenv().NeverLose.ScreenGui:GetDescendants())
            for H,E in a(table.unpack(v))do H=E:IsA("ImageLabel")and E.Image==getgenv().window.Logo
                if H then E.ImageColor3=P
                end
            end
        end
    end
    S:AddColorPicker(w)
end
X[1981]=getgenv().window.UserSettings
X[1981]:AddButton({
    Icon = "discord",
    Name = "discord",
    Callback = function()setclipboard("discord.gg/larptik")
        getgenv().Logging.new("discord","copied discord invite link",5)
    end,
})
X[1983]=getgenv().window.UserSettings
X[1983]:AddButton({
    Icon = "arrow-rotate-right",
    Name = "rejoin",
    Callback = function()local S=p
        local w,P=S:GetService("TeleportService"),p
        local S,a=P:GetService("Players").LocalPlayer,p
        w:TeleportToPlaceInstance(a.PlaceId,p.JobId,S)
    end,
})
getgenv().Unload=function()local S={}
    getgenv().Unloaded=true
    if Config.Legit then         Config.Legit.AimbotEnabled = false
                Config.Legit.AimbotActive = false
                Config.Legit.SilentAimEnabled = false
                Config.Legit.FovVisible = false
    end
    if Config.ForceHit then         Config.ForceHit.Enabled = false
                Config.ForceHit.Active = false
                Config.ForceHit.StrafeEnabled = false
                Config.ForceHit.strafespoof = false
                Config.ForceHit.BulletTracers = false
                Config.ForceHit.HitChamsEnabled = false
                Config.ForceHit.ShowTargetLine = false
                Config.ForceHit.AutoToxicEnabled = false
                Config.ForceHit.Target = nil
    end
    if getgenv().KillAura then getgenv().KillAura.Enabled=false
    end
    if Config.Misc then         Config.Misc.CFrameSpeedEnabled = false
                Config.Misc.CFrameSpeedActive = false
                Config.Misc.CFrameFlyEnabled = false
                Config.Misc.CFrameFlyActive = false
                Config.Misc.WalkSpeedEnabled = false
                Config.Misc.WalkSpeedActive = false
                Config.Misc.AutoEat = false
                Config.Misc.AntiStomp = false
                Config.Misc.FastStomp = false
                Config.Misc.PingSpoofEnabled = false
                Config.Misc.AutoBuyFood = false
                Config.Misc.ForceReset = false
                Config.Misc.AutoHealEnabled = false
                Config.Misc.AutoReloadEnabled = false
    end
    if getgenv().Config then getgenv().Config.Box.Enable=false
        getgenv().Config.Text.Enable=false
        getgenv().Config.Bars.Health.Enable=false
        getgenv().Config.Bars.Armor.Enable=false
    end
    if getgenv().spinbot then getgenv().spinbot.enabled=false
    end
    if getgenv().NoclipConfig then getgenv().NoclipConfig.Enabled=false
    end
    if getgenv().setDesync then pcall(function()getgenv().setDesync(false)
        end)
    end
    if Config.Desync then         Config.Desync.enabled = false
                Config.Desync.tracerEnabled = false
    end
    if getgenv().ChinaHatConfig then getgenv().ChinaHatConfig.Enabled=false
    end
    if getgenv().ToolAuraConfig then getgenv().ToolAuraConfig.Enabled=false
    end
    if getgenv().RTXConfig then getgenv().RTXConfig.Enabled=false
    end
    if getgenv().ServerPositionIndicatorConfig then getgenv().ServerPositionIndicatorConfig.Enabled=false
    end
    getgenv().KnifeHitboxEnabled=false
    getgenv().AutoKnifeEnabled=false
    getgenv().feature_enabled=false
    getgenv().glue_active=false
    getgenv().stompTargetEnabled=false
    getgenv().autoGrabEnabled=false
    getgenv().stompGlueTargetEnabled=false
    getgenv().DamageIndicatorEnabled=false
    getgenv().Des_MasterEnabled=false
    getgenv().ChatSpyActive=false
    if getgenv().ClearRTX then pcall(getgenv().ClearRTX)
    end
    if getgenv().restoreForcefieldMap then pcall(getgenv().restoreForcefieldMap)
    end
    if getgenv().WV_stopWeather then pcall(getgenv().WV_stopWeather)
    end
    if getgenv().WV_removeTextures then pcall(getgenv().WV_removeTextures)
    end
    if getgenv().WV_restoreSkybox then pcall(getgenv().WV_restoreSkybox)
    end
    if getgenv().PA_Toggle then pcall(getgenv().PA_Toggle,false)
    end
    if clearToolAura then pcall(clearToolAura)
    end
    local w=p
    local P=w:GetService("Lighting")
    if getgenv().WV_origTechnology then P.Technology=getgenv().WV_origTechnology
    end
    if getgenv().WV_origClockTime then P.ClockTime=getgenv().WV_origClockTime
    end
    if getgenv().WV_origAmbient then P.Ambient=getgenv().WV_origAmbient
    end
    if getgenv().WV_origOutdoor then P.OutdoorAmbient=getgenv().WV_origOutdoor
    end
    w=p
    P=w:GetService("Players").LocalPlayer
    w=P and P.Character
    if w then local a,v=w:FindFirstChildOfClass("Humanoid"),w:FindFirstChild("HumanoidRootPart")
        if a then a.PlatformStand=false
            a.WalkSpeed=16
            workspace.CurrentCamera.CameraSubject=a
        end
        if v then v.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0)
            v.AssemblyAngularVelocity=Vector3.new(0.0,0.0,0.0)
        end
        if X[95]then pcall(X[95],P.UserId,P.Name)
        end
    end
    if getgenv().connections and getgenv().connections.main and getgenv().connections.main.RenderStepped then pcall(function()getgenv().connections.main.RenderStepped:Disconnect()
        end)
    end
    if getgenv().ESPCache then for a,v in pairs(getgenv().ESPCache)do if getgenv().utility and getgenv().utility.funcs and getgenv().utility.funcs.clear_esp then pcall(getgenv().utility.funcs.clear_esp,a)
            end
        end
        getgenv().ESPCache=nil
    end
    local a,v,H,E,R,x,q,L,Y,r,A,K,f,C,l,Z,h,m,M,d,c={},"ThemeConnection","des_keybind_conn","_AutoReloadConnection","ChatSpyConn1","ChatSpyConn2","WV_textureConn","PA_CharConn","SpectateConnection","SV_Connection","spinbot_conn","ManualStompConnection","NoclipConnection","NoclipKeyConnection","globalAnimBreakerConn","auto_knife_loop","connection_loop","no_unc_loop","target_status_update_loop","RTXTimeForceConn","RTXDescAddedConn"
    N:jq(a,0,v,H,E,R,x,q,L,Y,r,A,K,f,C,l,Z,h,m,M,d,c,"CharizardConnection")
    f=ipairs
    for H,H in f(a)do local A=getgenv()[H]
        if A then pcall(function()local K=typeof(A)=="RBXScriptConnection"
                if K then A:Disconnect()
                else local K=type(A)=="table"and A.Disconnect
                    if K then A:Disconnect()
                end
            end
        end)
        getgenv()[H]=nil
    end
end
S[30]={}
S[31]=Config.FovCircle
N:jq(S[30],0,S[31])
S[32]=X[110]
N:jq(S[30],1,S[32],getgenv().TargetLine,getgenv().TargetLineOutline,getgenv().SV_Circle,getgenv().SV_Image,getgenv().SV_Glow,getgenv().SV_Outline)
Z=S[30]
for H,H in ipairs(Z)do if H then pcall(function()H:Remove()
        end)
        pcall(function()H:Destroy()
        end)
    end
end
if getgenv().destroyStrafeVisualizer then pcall(getgenv().destroyStrafeVisualizer)
end
if getgenv().dDestroyVisualizer then pcall(getgenv().dDestroyVisualizer)
end
L=X[76]
if L then q=X[76]
    for H,H in pairs(q)do if H then local q=248312998
            R=q
            C=pcall
            q=N:Aq(R+99880230)
            local function q()H:Destroy()
            end
            C(q)
        end
    end
    S[33]={}
    X[76]=S[33]
end
if getgenv().GlueVis_Destroy then pcall(getgenv().GlueVis_Destroy)
end
Z,r=ipairs,{getgenv().GlueTracer}
for S,S in Z(r)do if S then pcall(function()S.Visible=false
        end)
        pcall(function()S:Remove()
        end)
    end
end
Y={}
c="desync_setback"
E="DesyncPart"
w="desyncc"
x="dsncvsl"
m="FH_Tracers"
N:jq(Y,0,c,E,w,x,m,"GlueVisualizer")
for S,S in ipairs(Y)do local H=workspace:FindFirstChild(S)or workspace.CurrentCamera and workspace.CurrentCamera:FindFirstChild(S)or getgenv()[S]
    if H then pcall(function()H:Destroy()
        end)
        getgenv()[S]=nil
    end
end
l={}
d=p
a=(d:GetService("CoreGui"))
w="PlayerGui"
N:jq(l,0,a,P:FindFirstChild(w))
R=ipairs
for S,S in R(l)do if S then d,v=ipairs,table.pack(S:GetChildren())
        for S,S in d(table.unpack(v))do E=S:IsA("ScreenGui")and(S.Name=="target hud"or S.Name=="fh_notifgui"or S.Name=="NL_KeybindHUD"or S.Name=="NL_Charizard2D"or S.Name:find("_HealthBar")or S.Name:find("_ArmorBar")or S.Name:lower():find("neverlose")or S.Name:lower():find("neverlarp"))
            if E then pcall(function()S:Destroy()
                end)
            end
        end
    end
end
if getgenv().NeverLose and getgenv().NeverLose.ScreenGui then pcall(function()getgenv().NeverLose.ScreenGui:Destroy()
    end)
end
if getgenv().window and getgenv().window.Destroy then local S=385167917
    a=S
    E=pcall
    S=N:Aq(a+223887268)
    local function S()getgenv().window:Destroy()
    end
    E(S)
end
if getgenv().Watermark then pcall(function()getgenv().Watermark:Destroy()
    end)
end
if getgenv().HC then pcall(function()getgenv().HC:Destroy()
    end)
end
print("[NeverLose] Successfully unloaded completely.")
end
X[1985]=getgenv().window.UserSettings
X[1984]={}
X[1984].Icon="arrow-right-from-bracket"
X[1984].Name="Unload UI"
X[1984].Callback=function()if getgenv().Unload then getgenv().Unload()
    end
end
X[1985]:AddButton(X[1984])
X[1986]=getgenv()
X[1988]=Config.Misc_AutomationTab
X[1987]={}
X[1987].Name="misc"
X[1987].Position="left"
X[1986].SurvivalSection = (X[1988]:AddSection(X[1987]))
X[1990]=getgenv()
X[1992]=Config.Misc_AutomationTab
X[1991]={}
X[1991].Name="spoofing & network"
X[1991].Position="right"
X[1990].SpoofingSection = (X[1992]:AddSection(X[1991]))
X[1994]=getgenv()
X[1996]=Config.Misc_AutomationTab
X[1995]={}
X[1995].Name="chat & utility"
X[1995].Position="right"
X[1994].ChatUtilSection = (X[1996]:AddSection(X[1995]))
task.spawn(function()local S=233153107
    local w,P=workspace:WaitForChild("FFA_MAP",15)and workspace.FFA_MAP:WaitForChild("Shop",15),{}
    local a,v="Grab - [Burger]","Grab - [Taco]"
    local S,E="Grab - [Pizza]","Grab - [Chicken]"
    N:jq(P,0,a,v,S,E,"Grab - [Candy Basket]")
    local function v(R)local x=p
        local q,L=x:GetService("Players").LocalPlayer.Character,p
        x=(L:GetService("Players").LocalPlayer:FindFirstChild("Backpack"))
        if x then for Y,r in ipairs(x:GetChildren())do Y,L=r.Name:lower(),table.pack(R:lower())
                if Y:find(table.unpack(L))then return true
                end
            end
        end
        if q then for Y,Y in ipairs(q:GetChildren())do L,x=Y.Name:lower(),table.pack(R:lower())
                if L:find(table.unpack(x))then return true
                end
            end
        end
        return false
    end
    while true do H=Config.Misc and Config.Misc.AutoBuyInterval or 3
        task.wait(H)
        a=Config.Misc and Config.Misc.AutoBuyFood
        if a then local a=69010644
            S=a
            E=nil
            E,a=pcall,N:Aq(bit32.band(646999552,S)+bit32.band(646999552,236078035)+(bit32.band(3000968192,(bit32.bor(S,236078035)))+bit32.band(646999553,(bit32.bxor(S,236078035)))))
            E(function()local S={}
                local a=not w
                if a then S[1]=workspace:FindFirstChild("FFA_MAP")and workspace.FFA_MAP:FindFirstChild("Shop")
                    w=S[1]
                end
                a=w
                if a then local S=p
                    local a=S:GetService("Players").LocalPlayer.Character
                    local H,E=a and a:FindFirstChildOfClass("Humanoid"),ipairs
                    for R,x in E(P)do S=x:match("%[(.-)%]")or x
                    R=not v(S)
                    if R then local S=H and a:FindFirstChildOfClass("Tool")
                    if S then H:UnequipTools()
                    task.wait(0.1)
                end
                S=w:FindFirstChild(x)
                local w=S and S:FindFirstChildOfClass("ClickDetector")
                if w and fireclickdetector then fireclickdetector(w)
                    task.wait(0.15)
                end
            end
        end
    end
end)
end
end
end)
task.spawn(function()local S,w=227334080,{}
    S=N:Aq(S+31978)
    local S,P,a="[Chicken]","[Taco]","[Burger]"
    N:jq(w,0,S,P,a,"[Pizza]")
    local function v(H)return H and table.find(w,H.Name)~=nil
    end
    local H=false
    while true do task.wait(0.1)
        S=Config.Misc.AutoEat and not H
        if S then local S=314161968
            a=S
            P=nil
            P,S=pcall,N:Aq(a+22116148)
            P(function()local S=getgenv().LocalPlayer.Character
                local P,a=S and S:FindFirstChildOfClass("Humanoid"),getgenv().LocalPlayer:FindFirstChild("Backpack")
                local E=P and P.Health<P.MaxHealth
                if E then local E=S:FindFirstChildOfClass("Tool")
                    if Config.Misc.DontForceTool and E and not v(E)then return
                end
                local R
                for x,x in ipairs(w)do R=S:FindFirstChild(x)or a and a:FindFirstChild(x)
                    if R then break
                end
            end
            if R then H=true
                if E then v(E)
                end
                if E and E~=R then P:UnequipTools()
                    task.wait(0.08)
                end
                if R.Parent==a then P:EquipTool(R)
                    task.wait(0.08)
                end
                if R.Parent==S then R:Activate()
                    task.wait(0.15)
                    if R.Parent==S then R:Deactivate()
                end
            end
            P:UnequipTools()
            task.wait(0.08)
            H=false
        end
    end
end)
end
end
end)
Config.Misc.AutoHealEnabled = false
Config.Misc.AutoHealThreshold = 35
local function S()local w=getgenv().get_root_part()
    if not w then return nil
    end
    local P,a,v,H=ipairs,table.pack(getgenv().Players:GetPlayers()),1/0
    for E,R in P(table.unpack(a))do E=R~=getgenv().LocalPlayer and R.Character
        if E then local P=R.Character
            local a,E=P:FindFirstChildOfClass("Humanoid"),P:FindFirstChild("BodyEffects")
            local x=a and a.Health>0 and E
            if x then local x,q,L=E:FindFirstChild("K.O")and E["K.O"].Value or E:FindFirstChild("KO")and E.KO.Value,E:FindFirstChild("Dead")and E.Dead.Value,E:FindFirstChild("SDeath")and E.SDeath.Value
                a=x and not q and not L
                if a then x=(P:FindFirstChild("HumanoidRootPart"))
                    if x then L=(w.Position-x.Position).Magnitude
                    if L<v then v,H=L,R
                end
            end
        end
    end
end
end
return H
end
task.spawn(function()local w={}
    local P=false
    while true do local a={}
        task.wait(0.1)
        local v,H,E,R,x,q=Config.Misc.AutoHealEnabled
        a[4]=H
        a[5]=E
        a[6]=R
        a[1]=x
        a[2]=q
        if v then local H=getgenv().LocalPlayer.Character
            local E,R=H and H:FindFirstChild("HumanoidRootPart"),H and H:FindFirstChildOfClass("Humanoid")
            H=R and E and R.Health>0 and R.Health<Config.Misc.AutoHealThreshold
            if H then if getgenv().am_i_knocked()then continue
                end
                a[4]=S()
                R=a[4]and a[4].Character
                if R then w[1]=a[4].Character:FindFirstChild("HumanoidRootPart")or a[4].Character:FindFirstChild("UpperTorso")
                    a[5]=w[1]
                    if a[5]then getgenv().Logging.new("shield","stomping "..tostring(a[4].DisplayName):lower(),3)
                    a[6]=E.CFrame
                    local H,E=getgenv().glue_active,Config.ForceHit and Config.ForceHit.StrafeEnabled
                    getgenv().glue_active=false
                    if Config.ForceHit then                     Config.ForceHit.StrafeEnabled = false
                end
                local R=Config.DesyncPart
                if R then Config.DesyncPart.CFrame = a[6]+Vector3.new(0,5,0)
                    getgenv().strafeCamera.CameraSubject = Config.DesyncPart
                end
                a[1],a[2]=tick(),4
                w[9]=pcall
                w[8]=N.fq
                w[7]={}
                w[7][1]=a
                w[7][2]=a
                w[7][3]=nil
                w[7][4]=a
                w[7][5]=a
                w[7][6]=a
                w[9](w[8](1,2,w[7],g,I,getfenv()))
                R=getgenv().LocalPlayer.Character
                local x=R and R:FindFirstChild("HumanoidRootPart")
                if x then x.CFrame=a[6]
                    x.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0)
                end
                getgenv().resetStrafeCamera()
                getgenv().glue_active=H
                if Config.ForceHit then                     Config.ForceHit.StrafeEnabled = E
                end
                task.wait(1)
                P=false
            end
        end
    end
else if v then local v=getgenv().LocalPlayer.Character
        local H,E=v and v:FindFirstChild("HumanoidRootPart"),v and v:FindFirstChildOfClass("Humanoid")
        v=E and H and E.Health>0 and E.Health<Config.Misc.AutoHealThreshold
        if v then if getgenv().am_i_knocked()then continue
            end
            a[4]=S()
            E=a[4]and a[4].Character
            if E then w[11]=a[4].Character:FindFirstChild("HumanoidRootPart")or a[4].Character:FindFirstChild("UpperTorso")
                a[5]=w[11]
                if a[5]then getgenv().Logging.new("shield","stomping "..tostring(a[4].DisplayName):lower(),3)
                    a[6]=H.CFrame
                    local v,H=getgenv().glue_active,Config.ForceHit and Config.ForceHit.StrafeEnabled
                    getgenv().glue_active=false
                    if Config.ForceHit then                     Config.ForceHit.StrafeEnabled = false
                end
                local E=Config.DesyncPart
                if E then Config.DesyncPart.CFrame = a[6]+Vector3.new(0,5,0)
                    getgenv().strafeCamera.CameraSubject = Config.DesyncPart
                end
                a[1],a[2]=tick(),4
                w[19]=pcall
                w[18]=N.fq
                w[17]={}
                w[17][1]=a
                w[17][2]=a
                w[17][3]=nil
                w[17][4]=a
                w[17][5]=a
                w[17][6]=a
                w[19](w[18](1,2,w[17],g,I,getfenv()))
                E=getgenv().LocalPlayer.Character
                local g=E and E:FindFirstChild("HumanoidRootPart")
                if g then g.CFrame=a[6]
                    g.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0)
                end
                getgenv().resetStrafeCamera()
                getgenv().glue_active=v
                if Config.ForceHit then                     Config.ForceHit.StrafeEnabled = H
                end
                task.wait(1)
                P=false
            end
        end
    end
end
end
end
end)
Config.Misc.AntiStompDelay = 1.5
Config.Misc.ManualStompKey = nil
getgenv().performManualStomp=function()local g={}
    if getgenv().am_i_knocked()then return
    end
    local I=getgenv().LocalPlayer.Character
    local w,P=I and I:FindFirstChild("HumanoidRootPart"),I and I:FindFirstChildOfClass("Humanoid")
    if not w or not P or P.Health<=0 then return
    end
    local a=S()
    I=a and a.Character
    if I then local I=a.Character:FindFirstChild("HumanoidRootPart")or a.Character:FindFirstChild("UpperTorso")
        if I then local S=209591903
            P=S
            local v
            v,S=getgenv().Logging.new,N:Aq(P+196618156)
            v("shield","stomping "..tostring(a.DisplayName):lower(),3)
            local P=w.CFrame
            local w,H=getgenv().glue_active,Config.ForceHit and Config.ForceHit.StrafeEnabled
            getgenv().glue_active=false
            if Config.ForceHit then                 Config.ForceHit.StrafeEnabled = false
            end
            v=Config.DesyncPart
            S=N:Aq(S+52339080)
            if v then Config.DesyncPart.CFrame = P+Vector3.new(0,5,0)
                getgenv().strafeCamera.CameraSubject = Config.DesyncPart
            end
            local S,E=tick(),1.5
            pcall(function()while tick()-S<E do local S=getgenv().LocalPlayer.Character
                    local E,R=S and S:FindFirstChild("HumanoidRootPart"),S and S:FindFirstChildOfClass("Humanoid")
                    if not E or not R or R.Health<=0 or getgenv().am_i_knocked()then break
                end
                if not a.Character or not a.Character.Parent then break
                end
                S=(a.Character:FindFirstChildOfClass("Humanoid"))
                if not S or S.Health<=0 then break
                end
                R=(a.Character:FindFirstChild("BodyEffects"))
                local S,a=R and R:FindFirstChild("Dead")and R.Dead.Value,R and R:FindFirstChild("SDeath")and R.SDeath.Value
                if S or a then break
                end
                E.AssemblyLinearVelocity=Vector3.new(0,1,0)
                E.CFrame=CFrame.new(I.Position+Vector3.new(0,3,0))
                getgenv().ReplicatedStorage.MainEvent:FireServer("Stomp")
                getgenv().RunService.RenderStepped:Wait()
                getgenv().RunService.RenderStepped:Wait()
                E.CFrame=P
                getgenv().RunService.Heartbeat:Wait()
            end
        end)
        v=getgenv().LocalPlayer.Character
        local I=v and v:FindFirstChild("HumanoidRootPart")
        if I then I.CFrame=P
        end
        getgenv().resetStrafeCamera()
        getgenv().glue_active=w
        if Config.ForceHit then             Config.ForceHit.StrafeEnabled = H
        end
    end
end
end
if getgenv().ManualStompConnection then getgenv().ManualStompConnection:Disconnect()
end
getgenv().ManualStompConnection=getgenv().UserInputService.InputBegan:Connect(function(g,I)if I then return
    end
    if Config.Misc.AutoHealEnabled and Config.Misc.ManualStompKey and g.KeyCode==Config.Misc.ManualStompKey then getgenv().performManualStomp()
    end
end)
local function g()local I=getgenv().LocalPlayer.Character
    local S=I and I:FindFirstChildWhichIsA("Humanoid")
    if S and S.RigType~=Enum.HumanoidRigType.R6 then local w=162817260
        I=w
        local P
        P,w=pcall,N:Aq(bit32.band(2095434677,I)+bit32.band(2095434677,381443250)+(bit32.band(2199532620,(bit32.bor(I,381443250)))+bit32.band(2199532618,(bit32.band(I,381443250)))))
        P(function()S.RigType=Enum.HumanoidRigType.R6
        end)
    end
end
local I=false
getgenv().RunService.Heartbeat:Connect(function()local S=p
    if S.PlaceId==9825515356 then return
    end
    if not Config.Misc.AntiStomp then return
    end
    S=getgenv().LocalPlayer.Character
    local w,P=S and S:FindFirstChildWhichIsA("Humanoid"),S and S:FindFirstChild("BodyEffects")
    S=P and(P:FindFirstChild("K.O")or P:FindFirstChild("KO"))
    P=w and S and S.Value and not I
    if P then local P=112336023
        w=P
        P,I=N:Aq(bit32.band(30197702,w)+bit32.band(30197702,138526372)+(bit32.band(4264769595,(bit32.bor(w,138526372)))+bit32.band(4264769593,(bit32.band(w,138526372))))),true
        local w
        w,P=task.spawn,bit32.bxor(P,262639161)
        w(function()task.wait(Config.Misc.AntiStompDelay or 3)
            local w=getgenv().LocalPlayer.Character
            local P,a=w and w:FindFirstChildWhichIsA("Humanoid"),w and w:FindFirstChild("BodyEffects")
            local v=a and(a:FindFirstChild("K.O")or a:FindFirstChild("KO"))
            a=Config.Misc.AntiStomp and P and v and v.Value and P.Health>0
            if a then g()
                P="Head"
                if w:FindFirstChild(P)then w:BreakJoints()
                end
            end
            task.wait(1)
            I=false
        end)
    else local g=S and not S.Value
        if g then I=false
        end
    end
end)
task.spawn(function()while true do task.wait(0.1)
        local g=Config.Misc.FastStomp
        if g then local g=getgenv().ReplicatedStorage:FindFirstChild("MainEvent")
            if g then g:FireServer("Stomp")
            end
        end
    end
end)
X[2002]=getgenv()
X[2002].fast_stomp_lbl = (getgenv().SurvivalSection:AddLabel("auto stomp when on dead body"))
X[2005]=getgenv().fast_stomp_lbl
X[2005]:AddToggle({
    Default = false,
    Flag = "Misc_FastStomp",
    Callback = function(g)local I={}
            Config.Misc.FastStomp = g
    end,
})
Config.Misc.ForceReset = false
Config.Misc.ResetKey = Enum.KeyCode.E
Config.Misc.ForceResetDelay = 2
getgenv().performReset=function()local g=getgenv().LocalPlayer.Character
    if g then local I=g:FindFirstChildOfClass("Humanoid")
        if replicatesignal then local g=69064256
            local S=g
            local w
            w,g=pcall,N:Aq(S+248781222)
            w(function()replicatesignal(getgenv().LocalPlayer.Kill)
            end)
        elseif I then I:ChangeState(Enum.HumanoidStateType.Dead)
            end
        end
    end
    local g=false
    task.spawn(function()while true do task.wait(0.1)
            local I=Config.Misc.ForceReset and not g
            if I then local I=getgenv().LocalPlayer.Character
                if I then local S=I:FindFirstChildOfClass("Humanoid")
                    if S then local w=I:FindFirstChild("KO")or I:FindFirstChild("Ragdoll")or S.Health>0 and S.Health<=15
                    if w then g=true
                    task.wait(Config.Misc.ForceResetDelay or 2)
                    if I and I.Parent and S.Health>0 then getgenv().performReset()
                end
                task.wait(3)
                g=false
            end
        end
    end
end
end
end)
X[216]=getgenv
X[29]=X[216]().UserInputService
X[194]=function(g,I)if I then return
    end
    if not g.KeyCode or g.KeyCode==Enum.KeyCode.Unknown or g.KeyCode==Enum.KeyCode.None then return
    end
    if Config.Misc.ForceReset and Config.Misc.ResetKey and g.KeyCode==Config.Misc.ResetKey then getgenv().performReset()
    end
end
X[29].InputBegan:Connect(X[194])
getgenv().AntiRopeConfig={Enabled=false,Connection=nil}
local function g()local I,S=ipairs,table.pack(workspace:GetDescendants())
    for w,P in I(table.unpack(S))do w="RopeConstraint"
        if P:IsA(w)then P:Destroy()
        end
    end
end
local function I(S)getgenv().AntiRopeConfig.Enabled=S
    if getgenv().AntiRopeConfig.Connection then getgenv().AntiRopeConfig.Connection:Disconnect()
        getgenv().AntiRopeConfig.Connection=nil
    end
    if S then local S=419584110
        local w=S
        S=bit32.bxor(w,153183620)
        g()
        local g,w
        g,S,w=getgenv().AntiRopeConfig,N:Aq(bit32.band(1121992789,S)+bit32.band(1121992789,174472423)+(bit32.band(3172974508,(bit32.bor(S,174472423)))+bit32.band(3172974506,(bit32.band(S,174472423))))),function(S)local P=getgenv().AntiRopeConfig.Enabled and S:IsA("RopeConstraint")
            if P then S:Destroy()
            end
        end
        g.Connection=workspace.DescendantAdded:Connect(w)
    end
end
X[2010]=getgenv()
X[2012]=Config.Misc_AutomationTab
X[2011]={}
X[2011].Name="rope"
X[2011].Position="left"
X[2010].RopeAutomationSection = (X[2012]:AddSection(X[2011]))
X[2014]=getgenv()
X[2014].anti_rope_lbl = (getgenv().RopeAutomationSection:AddLabel("anti rope"))
X[2017]=getgenv().anti_rope_lbl
X[2017]:AddToggle({
    Default = false,
    Flag = "Misc_AntiRopeEnabled",
    Callback = function(g)I(g)
    end,
})
Config.Misc.CustomAntiStomp = false
local g
local function I(S)local w={}
    local P=300716168
    local a=P
    local v=g
    if v then g:Disconnect()
        g=nil
    end
    if not S then return
    end
    v=(S:WaitForChild("BodyEffects",5))
    local H=not v
    P=N:Aq(a+506590444)
    if H then return
    end
    a=nil
    a=(v:WaitForChild("K.O",5))
    P=N:Aq(P-290270156)
    local P=a or v:WaitForChild("KO",5)
    if not P then return
    end
    w[1]=(P:GetPropertyChangedSignal("Value"):Connect(function()local a=Config.Misc.CustomAntiStomp and P.Value==true
        if a then local P=5370480
            local a=P
            local v
            v,P=pcall,N:Aq(a+487704444)
            v(function()local P=S:FindFirstChildOfClass("Humanoid")
                if replicatesignal then replicatesignal(getgenv().LocalPlayer.Kill)
                elseif P then P.Health=0
                else S:BreakJoints()
                end
            end)
        end
    end))
    g=w[1]
end
if getgenv().LocalPlayer and getgenv().LocalPlayer.Character then I(getgenv().LocalPlayer.Character)
end
if getgenv().LocalPlayer and getgenv().LocalPlayer.CharacterAdded then getgenv().LocalPlayer.CharacterAdded:Connect(I) end
X[2019]=getgenv()
X[2019].custom_antistomp_lbl = (getgenv().SurvivalSection:AddLabel("anti stomp"))
X[2022]=getgenv().custom_antistomp_lbl
X[2022]:AddToggle({
    Default = false,
    Flag = "Misc_CustomAntiStomp",
    Callback = function(g)local S={}
            Config.Misc.CustomAntiStomp = g
    end,
})
X[2023]=getgenv()
X[2023].force_reset_lbl = (getgenv().SurvivalSection:AddLabel("force reset"))
X[2026]=getgenv().force_reset_lbl
X[2026]:AddToggle({
    Default = false,
    Flag = "Misc_ForceReset",
    Callback = function(g)local S={}
            Config.Misc.ForceReset = g
    end,
})
X[2028]=getgenv().force_reset_lbl
X[2028]:AddKeybind({
    Default = "P",
    Flag = "Misc_ResetKeybind",
    Callback = function(g)local S={}
        local w=getgenv().parseKey(g)
        if w then         Config.Misc.ResetKey = w
        end
    end,
})
X[54]=task
X[154]=function()local g=getgenv().ReplicatedStorage:WaitForChild("MainEvent",15)
    if g then local S=p
        local w=getrawmetatable(S)
        S=w and setreadonly
        if S then local S=147504346
            local P=S
            local a
            a,S=setreadonly,N:Aq(P+181308010)
            a(w,false)
            local v,H=w.__namecall,true
            S=N:Aq(S-61003172)
            w.__namecall=function(S,...)local w,E={...},getnamecallmethod()
                local R=E=="FireServer"and S==g and w[1]=="GetPing"
                if R then if Config.Misc.PingSpoofEnabled and H and not checkcaller()then return
                end
            end
            return v(S,...)
        end
        while true do a=Config.Misc.PingSpoofEnabled
            if a then H=false
                P=(Config.Misc.PingValue or 300)/1000
                g:FireServer("GetPing",P)
                H=true
                task.wait(P)
            else task.wait(1)
            end
        end
    end
end
end
X[54].spawn(X[154])
X[2029]=getgenv()
X[2029].ping_spoof_lbl = (getgenv().SpoofingSection:AddLabel("ping spoofer"))
X[2032]=getgenv().ping_spoof_lbl
X[2032]:AddToggle({
    Default = false,
    Flag = "Misc_PingSpoof",
    Callback = function(g)local S={}
            Config.Misc.PingSpoofEnabled = g
    end,
})
X[2033]=getgenv()
X[2033].ping_val_lbl = (getgenv().SpoofingSection:AddLabel("ping value (ms)"))
X[2036]=getgenv().ping_val_lbl
X[2036]:AddSlider({
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Default = 300,
    Flag = "Misc_PingValue",
    Callback = function(g)local S={}
            Config.Misc.PingValue = g
    end,
})
X[2037]=getgenv()
X[2037].platform_spoof_lbl = (getgenv().SpoofingSection:AddLabel("platform spoof"))
X[192]=getgenv().platform_spoof_lbl
X[2039]={}
X[2039].Default="None"
X[165]=X[2039]
X[14]={}
X[104]="None"
X[42]="Mobile"
X[211]="Console"
N:jq(X[14],0,X[104],X[42],X[211])
X[165].Values=X[14]
X[165].Flag = "Misc_PlatformSpoof"
local function g(S)local w={}
        Config.Misc.PlatformSpoof = S
    local w=getgenv().ReplicatedStorage:FindFirstChild("MainEvent")
    if w then local P=S=="Mobile"
        if P then w:FireServer("IS_MOBILE")
        else local P=S=="Console"
            if P then w:FireServer("IS_CONSOLE")
            end
        end
    end
end
X[165].Callback=g
X[2041]=X[165]
X[192]:AddDropdown(X[2041])
getgenv().AutoRejoinConfig={Enabled=false,Connection=nil}
X[2042]=getgenv()
X[2042].rejoin_kick_lbl = (getgenv().SpoofingSection:AddLabel("rejoin when kicked"))
X[2045]=getgenv().rejoin_kick_lbl
X[2044]={}
X[2044].Default=false
X[2044].Flag="Misc_RejoinWhenKicked"
local S,w=X[2045],X[2044]
w.Callback=function(P)getgenv().AutoRejoinConfig.Enabled=P
    if getgenv().AutoRejoinConfig.Connection then getgenv().AutoRejoinConfig.Connection:Disconnect()
        getgenv().AutoRejoinConfig.Connection=nil
    end
    if P then local P=471331736
        local a=P
        local v=p
        local H,E=v:GetService("GuiService"),p
        local v,R=E:GetService("TeleportService"),p
        local x=R:GetService("Players").LocalPlayer
        R=getgenv()
        P=N:Aq(bit32.band(348787058,a)+bit32.band(348787058,1504467)+(bit32.band(3597393180,(bit32.bor(a,1504467)))+bit32.band(348787059,(bit32.bxor(a,1504467)))))
        E=R.AutoRejoinConfig
        P=bit32.bxor(P,322695477)
        local function P()local a=getgenv().AutoRejoinConfig.Enabled
            if a then local a=p
                v:TeleportToPlaceInstance(a.PlaceId,p.JobId,x)
            end
        end
        E.Connection=H.ErrorMessageChanged:Connect(P)
    end
end
S:AddToggle(w)
if getgenv().ChatSpyConn1 then getgenv().ChatSpyConn1:Disconnect()
    getgenv().ChatSpyConn1=nil
end
if getgenv().ChatSpyConn2 then getgenv().ChatSpyConn2:Disconnect()
    getgenv().ChatSpyConn2=nil
end
getgenv().ChatSpyActive=false
X[179]=p
X[2046]="TextChatService"
X[19]=X[179]:GetService(X[2046]).ChatVersion==Enum.ChatVersion.TextChatService
if X[19]then X[219]=nil
    X[2047]=getgenv()
    X[219]=p
    X[2048]=(p:GetService("TextChatService").MessageReceived:Connect(function(S)local w=getgenv().ChatSpyActive and S.TextSource
        if w then local w=p
            local P=w:GetService("Players"):GetPlayerByUserId(S.TextSource.UserId)
            w=nil
            if P then local a=p
                w=P~=a:GetService("Players").LocalPlayer
            else w=P
            end
            if w then local w=366342513
                local a=w
                local v
                v,w=pcall,N:Aq(a+414609925)
                v(function()local w=p
                    w:GetService("TextChatService").TextChannels.RBXGeneral:DisplaySystemMessage(string.format("<font color='#FF5555'>[SPY] [%s] %s:</font> %s",S.TextChannel and S.TextChannel.Name or "Chat",P.Name,S.Text))
                end)
            end
        end
    end))
    X[2047].ChatSpyConn1=X[2048]
end
local function S()local w=45736707
    local P=w
    local a,v=getgenv(),p
    local E=v:GetService("ReplicatedStorage")
    w=N:Aq(P+378503063)
    v=E.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent
    w=N:Aq(w+46693486)
    local function w(P)local H,E=getgenv().ChatSpyActive and P
        if H then local R
            R=p
            E=P.FromPlayer~=p:GetService("Players").LocalPlayer.Name
        else E=H
        end
        if E then H=p
            local E=H:GetService("StarterGui")
            local H="ChatMakeSystemMessage"
            local R={}
            R.Text=string.format("[SPY] [%s] %s: %s",P.OriginalChannel or "Chat",P.FromPlayer,P.Message)
            R.Color=Color3.fromRGB(255,85,85)
            R.Font=Enum.Font.SourceSansBold
            R.TextSize=13
            E:SetCore(H,R)
        end
    end
    a.ChatSpyConn2=v:Connect(w)
end
pcall(S)
X[2049]=getgenv()
X[2049].chat_spy_lbl = (getgenv().ChatUtilSection:AddLabel("chat spy"))
X[2052]=getgenv().chat_spy_lbl
X[2051]={}
X[2051].Default=false
X[2051].Flag="Misc_ChatSpy"
local w,P=X[2052],X[2051]
P.Callback=function(a)getgenv().ChatSpyActive=a
    local v=p
    local H=v:GetService("TextChatService")
    if H and H.ChatVersion==Enum.ChatVersion.TextChatService then local E=63086183
        v=E
        local R
        R,E=pcall,N:Aq(bit32.band(545657853,v)+bit32.band(545657853,121621853)+(bit32.band(3749309444,(bit32.bor(v,121621853)))+bit32.band(3749309442,(bit32.band(v,121621853)))))
        R(function()local v=H.ChatWindowConfiguration
            if v then v.Enabled=a
                if a then v.BackgroundColor3=Color3.fromRGB(0,0,0)
                    v.BackgroundTransparency=0.8
                    v.TextColor3=Color3.fromRGB(255,255,255)
                    v.TextSize=13
                    v.VerticalAlignment=Enum.VerticalAlignment.Top
                end
            end
        end)
    end
    if a then getgenv().Logging.new("message-square","chat spy enabled",3)
    end
end
w:AddToggle(P)
Config.Misc.CustomBubbleEnabled = false
X[2054]=getgenv()
X[2054].bubble_lbl = (getgenv().ChatUtilSection:AddLabel("custom bubbles"))
X[2057]=getgenv().bubble_lbl
X[2056]={}
X[2056].Default=false
X[2056].Flag="Misc_CustomBubble"
local w,P=X[2057],X[2056]
P.Callback=function(a)local v={}
        Config.Misc.CustomBubbleEnabled = a
    local v=p
    local H=v:GetService("TextChatService")
    if a then local a=457943473
        v=a
        a=N:Aq(bit32.band(910029409,v)+bit32.band(910029409,437123273)+(bit32.band(2474908478,(bit32.bor(v,437123273)))+bit32.band(910029410,(bit32.bxor(v,437123273)))))
        H.OnBubbleAdded=function(a)local v=a.TextSource
            if v then a=(Instance.new("BubbleChatMessageProperties"))
                a.BackgroundColor3=Color3.fromRGB(0,0,0)
                a.TextColor3=Color3.fromRGB(255,255,255)
                a.TextSize=16
                a.TailVisible=true
                return a
            end
        end
    else H.OnBubbleAdded=nil
    end
end
w:AddToggle(P)
Config.Misc.AutoReloadEnabled = false
local P,a={last={},cd=1},{}
X[58]="[Revolver]"
X[113]="[DoubleBarrel]"
X[172]="[TacticalShotgun]"
X[69]="[SMG]"
X[182]="[Shotgun]"
X[168]="[Silencer]"
N:jq(a,0,X[58],X[113],X[172],X[69],X[182],X[168])
P.TOOLS=a
X[160]=p
X[2059]="RunService"
local v,H=X[160]:GetService(X[2059]),p
local E=H:GetService("VirtualInputManager")
X[2060]=getgenv()
X[2060].autoreload_lbl = (getgenv().ChatUtilSection:AddLabel("auto reload"))
X[2063]=getgenv().autoreload_lbl
X[2062]={}
X[2062].Default=false
X[2062].Flag="Misc_AutoReload"
local R,x=X[2063],X[2062]
x.Callback=function(q)local L={}
        Config.Misc.AutoReloadEnabled = q
    if getgenv()._AutoReloadConnection then getgenv()._AutoReloadConnection:Disconnect()
        getgenv()._AutoReloadConnection=nil
    end
    if q then local q=169149033
        local L=q
        local Y=getgenv()
        q=N:Aq(L+346456699)
        q=N:Aq(q+164783937)
        local function q()local L=getgenv().LocalPlayer.Character
            if not L then return
            end
            local r,A=ipairs,P.TOOLS
            for K,f in r(A)do K=L:FindFirstChild(f)
                local L=K and(not P.last[f]or tick()-P.last[f]>=P.cd)
                if L then local L=K:FindFirstChild("Script")
                    local r=L and L:FindFirstChild("Ammo")
                    L=r and r:IsA("IntValue")and r.Value==0
                    if L then E:SendKeyEvent(true,Enum.KeyCode.R,false,nil)
                    E:SendKeyEvent(false,Enum.KeyCode.R,false,nil)
                    P.last[f]=tick()
                end
            end
        end
    end
    Y._AutoReloadConnection=v.RenderStepped:Connect(q)
end
end
R:AddToggle(x)
local P,P=getgenv().Players,getgenv().ReplicatedStorage
X[2066]=getgenv().LocalPlayer
X[2064]={}
X[2064].enabled=false
X[2064].DoubleBarrel=""
X[2064].Revolver=""
X[2064].TacticalShotgun=""
X[2064].SMG=""
X[2064].Shotgun=""
X[2065]={}
X[2065].Knife=""
X[2064].special=X[2065]
local v,E=X[2066],X[2064]
X[2067]={}
X[2067].DB_HANDLE="DoubleBarrel"
X[2067].REV_HANDLE="Revolver"
local x=X[2067]
local function q(L)local Y=typeof(L)=="Instance"and L:IsA("BasePart")
    return Y
end
local function L(Y)local r=Y and Y:IsA("Model")
    if r then local r=not q(Y.PrimaryPart)
        if r then local r=Y:FindFirstChildWhichIsA("BasePart")
            if r then Y.PrimaryPart=r
            end
        end
        return Y.PrimaryPart
    end
end
local function Y(r,A)local K,f=ipairs,table.pack(r:GetDescendants())
    for C,l in K(table.unpack(f))do r="BasePart"
        if l:IsA(r)then l.CanCollide=false
            l.Anchored=false
            l.Massless=true
            l.Transparency=math.clamp(l.Transparency,0,1)
        end
        C=A and l:IsA("MeshPart")
        if C then local r=l:FindFirstChildOfClass("SurfaceAppearance")
            if r then r:Destroy()
            end
            r=l.TextureID==""
            if r then local r=l.Name:lower()
                local A=r:find("box")or r:find("cube")or r:find("part")or r:find("hit")
                if A then l.Transparency=1
                end
            end
        end
    end
end
local function r(A,K)local f=q(A)and q(K)
    if f then local f=Instance.new("WeldConstraint")
        f.Part0=A
        f.Part1=K
        f.Parent=K
        return f
    end
end
local function A(K,f,C)C=C or 5
    local l=P:WaitForChild("Wraps",C)
    if not l then return nil
    end
    local Z=l:WaitForChild("["..K.."]",C)
    if not Z then return nil
    end
    l=not f or f==""
    if l then return nil
    end
    return Z:WaitForChild(f,C)
end
local function K(f,C)local l={}
    if not f or not C then return
    end
    local Z=f:FindFirstChild("Handle")
    if not q(Z)then return
    end
    local h=f:FindFirstChild("SkinModel")
    if h then h:Destroy()
    end
    h=C:Clone()
    l[1]="SkinModel"
    h.Name=l[1]
    if not q((L(h)))then return
    end
    C=f.Name:find("Knife")and true or false
    Y(h,C)
    h.Parent=f
    h:PivotTo(Z.CFrame)
    f,C=ipairs,table.pack(h:GetDescendants())
    for q,L in f(table.unpack(C))do q="BasePart"
        if L:IsA(q)then r(Z,L)
        end
    end
    Z.Transparency=1
end
local function q(L)if not E.enabled then return
    end
    local Y=not L or not L:IsA("Tool")
    if Y then return
    end
    Y=(L.Name:match("^%[(.+)%]$"))
    if not Y then return
    end
    local r=E[Y]
    local f=not r or r==""
    if f then local C=L:FindFirstChild("SkinModel")
        if C then C:Destroy()
        end
        C=(L:FindFirstChild("Handle"))
        local l=C and C:IsA("BasePart")
        if l then C.Transparency=0
        end
        return
    end
    f=A(Y,r,5)
    if f then K(L,f)
    end
end
local function L(Y)if not E.enabled then return
    end
    local r=not Y or not Y:IsA("Tool")
    if r then return
    end
    local f,C=Y.Name,"[Knife]"
    if f~=C then return
    end
    r=E.special and E.special.Knife
    f=not r or r==""
    if f then C=(Y:FindFirstChild("SkinModel"))
        if C then C:Destroy()
        end
        local l=Y:FindFirstChild("Handle")
        local Z=l and l:IsA("BasePart")
        if Z then l.Transparency=0
        end
        return
    end
    f=(P:FindFirstChild("Knives"))
    if not f then return
    end
    C=f:FindFirstChild(r)
    if C then K(Y,C)
    end
end
local function P(Y,r)local f=x[r]
    if not f then return
    end
    local C=E[f]
    local l=not C or C==""
    if l then return
    end
    l=Y:FindFirstChild(r)
    if not l then return
    end
    r=A(f,C,5)
    if r then K(l,r)
    end
end
local function Y(r)if not E.enabled then return
    end
    local A,K=ipairs,table.pack(r:GetChildren())
    for f,C in A(table.unpack(K))do f="Tool"
        if C:IsA(f)then q(C)
            L(C)
        end
    end
    for A,K in pairs(x)do P(r,A)
    end
end
local function r(A)local K=496339845
    local f=K
    K=N:Aq(f+458989029)
    f=nil
    f,K=A.ChildAdded,N:Aq(K-54511296)
    f:Connect(function(K)local f="Tool"
        if K:IsA(f)then q(K)
            L(K)
        elseif x[K.Name]then local x=93675836
                local f=x
                local C=task
                x=N:Aq(f+166660051)
                x=N:Aq(x+369492172)
                C.defer(function()P(A,K.Name)
                end)
            end
        end)
        Y(A)
    end
    if v.Character then r(v.Character)
    end
    X[2068]=getgenv()
    X[2070]=getgenv().window
    X[2069]={}
    X[2069].Icon="S"
    X[2069].Name="Skinchanger"
    X[2068].SkinTab = (X[2070]:AddTab(X[2069]))
    X[197]=nil
    X[2072]=getgenv()
    X[197]=p
    X[2072].VirtualUser = (p:GetService("VirtualUser"))
    X[2074]=getgenv()
    X[2076]=getgenv().SkinTab
    X[2075]={}
    X[2075].Name="weapons"
    X[2075].Position="left"
    X[2074].SkinWeaponSection = (X[2076]:AddSection(X[2075]))
    X[2078]=getgenv()
    X[2080]=getgenv().SkinTab
    X[2079]={}
    X[2079].Name="knife"
    X[2079].Position="right"
    X[2078].SkinKnifeSection = (X[2080]:AddSection(X[2079]))
    X[2082]=getgenv()
    X[2082].skin_enable_lbl = (getgenv().SkinWeaponSection:AddLabel("enable skinchanger"))
    X[2085]=getgenv().skin_enable_lbl
    X[2085]:AddToggle({
        Default = false,
        Flag = "SkinChanger_Enable",
        Callback = function(P)E.enabled=P
                if P then local P=getgenv().LocalPlayer.Character
                    if P then Y(P)
                    end
                end
            end,
    })
    local function P(v)local x={}
        local Y=p
        local A=Y:GetService("ReplicatedStorage"):FindFirstChild("Wraps")
        Y=A and A:FindFirstChild("["..v.."]")
        v=not Y
        if v then x[1]={}
            N:jq(x[1],0,"None")
            A=x[1]
            return A
        end
        x[2]={}
        N:jq(x[2],0,"None")
        v=x[2]
        for x,x in ipairs(Y:GetChildren())do table.insert(v,x.Name)
        end
        return v
    end
    local function v()local x={}
        local Y=p
        local A=Y:GetService("ReplicatedStorage"):FindFirstChild("Knives")
        Y=not A
        if Y then local K={}
            N:jq(K,0,"None")
            local f=K
            return f
        end
        x[1]={}
        N:jq(x[1],0,"None")
        Y=x[1]
        for x,x in ipairs(A:GetChildren())do table.insert(Y,x.Name)
        end
        return Y
    end
    X[197]={}
    X[133]="DoubleBarrel"
    X[156]="Revolver"
    X[206]="TacticalShotgun"
    X[173]="SMG"
    X[19]="Shotgun"
    N:jq(X[197],0,X[133],X[156],X[206],X[173],X[19])
    X[100]=ipairs
    for x,x in X[100](X[197])do X[117]=(getgenv().SkinWeaponSection:AddLabel(x:lower()))
        X[117]:AddDropdown({
            Default = "None",
            Values = P(x),
            Flag = "Skin_"..x,
            Callback = function(P)local Y={}
                        Y[1]=E
                        Y[2]=x
                        Y[3]=P=="None"and ""or P
                        Y[1][Y[2]]=Y[3]
                        if not E.enabled then return
                        end
                        P=getgenv().LocalPlayer.Character
                        if not P then return
                        end
                        local Y=P:FindFirstChild("["..x.."]")
                        if Y then q(Y)
                        end
                    end,
        })
    end
    X[212]=p
    local P,x=X[212].Players.LocalPlayer,p
    local q=x:GetService("HttpService")
    X[2087]=getgenv()
    X[2088]={}
    X[2088].DoubleBarrel="Beta"
    X[2088].Revolver="Beta"
    X[2088].Shotgun="Beta"
    X[2088].SMG="Beta"
    X[2087].BulletChanger = X[2088]
    X[197]={}
    X[165]="Beta"
    X[10]="Hallows"
    g="Kitty"
    X[36]="Kirumi"
    X[108]="Rainbow"
    X[205]="Red"
    X[56]="Blue"
    r="Green"
    X[31]="Orange"
    N:jq(X[197],0,X[165],X[10],g,X[36],X[108],X[205],X[56],r,X[31])
    local function g()if not getgenv().BulletBeamsEnabled then return
        end
        local x=P:FindFirstChild("DataFolder")
        if not x then return
        end
        local P=x:FindFirstChild("InventoryData")
        if P then local Y=P:FindFirstChild("BulletBeams")
            local P,A=x:FindFirstChild("EquippedBulletBeams"),Y and Y:IsA("StringValue")
            if A then local x={}
                local K=Y.Value~=""
                if K then local f=459590785
                    local C=f
                    local l
                    l,f=pcall,N:Aq(C+295367238)
                    l(function()x=q:JSONDecode(Y.Value)
                end)
            end
            K=type(x)~="table"
            if K then x={}
            end
            local f,C=pairs,getgenv().BulletChanger
            for l,Z in f(C)do K=if l=="DoubleBarrel"then "109d1326878cc594bc1bb42d126250810999782f"else if l=="Revolver"then "539db315b53f77390c0aa74773158e25bedcdd6e"else if l=="Shotgun"then "b415a7273aa86cbc2adc445fde5435eb5afababa"else if l=="SMG"then "005af87725b42ac4ca8103d11af6bf0c7d55f7b3"else if l=="TacticalShotgun"then "109d1326878cc594bc1bb42d126250810999782f"else nil
                    if K then x[K]={Name=Z}
                end
            end
            Y.Value=q:JSONEncode(x)
        end
        A=P and P:IsA("StringValue")
        if A then local x={}
            x["[DoubleBarrel]"]="109d1326878cc594bc1bb42d126250810999782f"
            x["[Revolver]"]="539db315b53f77390c0aa74773158e25bedcdd6e"
            x["[TacticalShotgun]"]="109d1326878cc594bc1bb42d126250810999782f"
            x["[SMG]"]="005af87725b42ac4ca8103d11af6bf0c7d55f7b3"
            x["[Shotgun]"]="b415a7273aa86cbc2adc445fde5435eb5afababa"
            local Y=x
            P.Value=q:JSONEncode(Y)
        end
    end
end
X[2090]=getgenv()
X[2092]=getgenv().SkinTab
X[2091]={}
X[2091].Name="bullet beams"
X[2091].Position="right"
X[2090].BulletSection = (X[2092]:AddSection(X[2091]))
X[2094]=getgenv()
X[2094].bullet_beam_enable_lbl = (getgenv().BulletSection:AddLabel("enable bullet beams"))
X[2097]=getgenv().bullet_beam_enable_lbl
X[2097]:AddToggle({
    Default = false,
    Flag = "Bullet_Beam_Enable",
    Callback = function(P)getgenv().BulletBeamsEnabled=P
        if P then g()
        end
    end,
})
X[2098]=getgenv()
X[2098].bullet_beam_lbl = (getgenv().BulletSection:AddLabel("bullet beam"))
X[2101]=getgenv().bullet_beam_lbl
X[2101]:AddDropdown({
    Default = "Beta",
    Values = X[197],
    Flag = "Bullet_Beam_Skin",
    Callback = function(P)getgenv().BulletChanger.DoubleBarrel=P
        getgenv().BulletChanger.Revolver=P
        getgenv().BulletChanger.Shotgun=P
        getgenv().BulletChanger.SMG=P
        g()
    end,
})
X[2102]=getgenv()
X[2102].skin_knife_lbl = (getgenv().SkinKnifeSection:AddLabel("knife skin"))
X[2105]=getgenv().skin_knife_lbl
X[2104]={}
X[2104].Default="None"
X[2104].Values=v()
X[2104].Flag="Skin_Knife"
local g,P=X[2105],X[2104]
P.Callback=function(v)local x={}
    local q=E.special
    if q then E.special.Knife = v=="None"and ""or v
    end
    if not E.enabled then return
    end
    q=getgenv().LocalPlayer.Character
    if not q then return
    end
    v=(q:FindFirstChild("[Knife]"))
    if v then L(v)
    end
end
g:AddDropdown(P)
setfpscap(32555555555555556)
X[2106]=getgenv()
X[2107]={}
X[2107].ShowOnSelf=false
X[2108]={}
X[2108].Enable=true
X[2108].Type="Full"
X[2108].Font="ProggyClean"
X[2108].Color=Color3.fromRGB(255,255,255)
X[2108].Filled={Enable=false,Gradient={Enable=true,Color={Start=Color3.fromRGB(255,255,255),End=Color3.fromRGB(0,0,0)},Rotation={Enable=true,Auto=true},Transparency=0.3}}
X[2107].Box=X[2108]
X[2109]={}
X[2109].Enable=true
X[2110]={}
X[2110].Enable=true
X[2110].Type="Display"
X[2110].Teamcheck=true
X[2110].Color=Color3.fromRGB(255,255,255)
X[2109].Name=X[2110]
X[2109].Studs={Enable=true,Color=Color3.fromRGB(255,255,255)}
X[2109].Tool={Enable=true,Color=Color3.fromRGB(255,255,255)}
X[2107].Text=X[2109]
X[2107].Bars={Enable=true,Health={ShowOutline=false,Enable=true,Lerp=true,Color1=Color3.fromRGB(0,255,0),Color2=Color3.fromRGB(255,255,0),Color3=Color3.fromRGB(255,0,0)},Armor={ShowOutline=false,Enable=false,Lerp=false,Color1=Color3.fromRGB(0,0,255),Color2=Color3.fromRGB(135,206,235),Color3=Color3.fromRGB(1,0,0)}}
X[2106].Config = X[2107]
getgenv().Fonts={Visitor=Font.fromEnum(Enum.Font.Arcade),SmallestPixel=Font.fromEnum(Enum.Font.Code),TahomaBold=Font.fromEnum(Enum.Font.SourceSansBold),ProggyTiny=Font.fromEnum(Enum.Font.Code),ProggyClean=Font.fromEnum(Enum.Font.Code),Verdana=Font.fromEnum(Enum.Font.SourceSans),Tahoma=Font.fromEnum(Enum.Font.SourceSans),Stratum2=Font.fromEnum(Enum.Font.Gotham),WindowsXP=Font.fromEnum(Enum.Font.Legacy)}
X[21]=nil
X[2112]=getgenv()
X[21]=p
X[2112].gui_inset = (p:GetService("GuiService"):GetGuiInset())
getgenv().utility=getgenv().utility or{}
getgenv().connections=getgenv().connections or{}
getgenv().ESPCache=getgenv().ESPCache or{}
getgenv().utility.funcs=getgenv().utility.funcs or{}
X[108]=getgenv
X[135]=X[108]().utility
X[125]=function(g)local P=Instance.new("TextLabel")
    P.Parent=g
    P.Size=UDim2.new(0,4,0,4)
    P.BackgroundTransparency=1
    P.TextColor3=Color3.fromRGB(255,255,255)
    P.TextStrokeTransparency=0
    P.TextScaled=false
    P.TextSize=10
    P.TextStrokeColor3=Color3.fromRGB(0,0,0)
    P.FontFace=getgenv().Fonts[getgenv().Config.Box.Font]or Font.fromEnum(Enum.Font.Code)
    return P
end
X[2114]=X[135].funcs
X[2114].make_text=X[125]
X[64]=getgenv
X[229]=X[64]().utility
X[129]=function(g)local P={}
    if not g then return
    end
    getgenv().ESPCache[g]=getgenv().ESPCache[g]or{}
    getgenv().ESPCache[g].Box={}
    getgenv().ESPCache[g].Bars={}
    getgenv().ESPCache[g].Text={}
    local v=getgenv().ESPCache[g].Box
    local E={}
    E.Square=Drawing.new("Square")
    E.Inline=Drawing.new("Square")
    E.Outline=Drawing.new("Square")
    local x,q,L=v,E,p
    P[1]=(Instance.new("Frame",Instance.new("ScreenGui",p.CoreGui)))
    q.Filled=P[1]
    x.Full=q
    x=(Instance.new("ScreenGui"))
    q=p
    x.Parent=q.CoreGui
    local v,E=Instance.new("ScreenGui"),p
    v.Parent=E.CoreGui
    E=(Instance.new("ScreenGui"))
    q=p
    E.Parent=q.CoreGui
    getgenv().ESPCache[g].Text.Studs=getgenv().utility.funcs.make_text(x)
    getgenv().ESPCache[g].Text.Tool=getgenv().utility.funcs.make_text(E)
    getgenv().ESPCache[g].Text.Name=getgenv().utility.funcs.make_text(v)
    q=(Instance.new("ScreenGui"))
    P[2]=g.Name.."_ArmorBar"
    q.Name=P[2]
    q.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    v=p
    q.Parent=v.CoreGui
    E=(Instance.new("Frame"))
    E.BackgroundColor3=Color3.new(0,0,0)
    E.BorderSizePixel=0
    P[3]="Outline"
    E.Name=P[3]
    E.Parent=q
    x=(Instance.new("Frame"))
    x.BackgroundTransparency=0
    x.BorderSizePixel=0
    P[4]="Fill"
    x.Name=P[4]
    x.Parent=E
    v=(Instance.new("UIGradient",x))
    v.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,getgenv().Config.Bars.Armor.Color1),ColorSequenceKeypoint.new(0.5,getgenv().Config.Bars.Armor.Color2),ColorSequenceKeypoint.new(1,getgenv().Config.Bars.Armor.Color3)})
    v.Rotation=90
    getgenv().ESPCache[g].Bars.Armor={Gui=q,Outline=E,Frame=x,Gradient=v}
    v=(Instance.new("ScreenGui"))
    P[5]=g.Name.."_HealthBar"
    v.Name=P[5]
    v.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    q=p
    v.Parent=q.CoreGui
    q=(Instance.new("Frame"))
    q.BackgroundColor3=Color3.new(0,0,0)
    q.BorderSizePixel=0
    P[6]="Outline"
    q.Name=P[6]
    q.Parent=v
    x=(Instance.new("Frame"))
    x.BackgroundTransparency=0
    x.BorderSizePixel=0
    P[7]="Fill"
    x.Name=P[7]
    x.Parent=q
    E=(Instance.new("UIGradient",x))
    E.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,getgenv().Config.Bars.Health.Color1),ColorSequenceKeypoint.new(0.5,getgenv().Config.Bars.Health.Color2),ColorSequenceKeypoint.new(1,getgenv().Config.Bars.Health.Color3)})
    E.Rotation=90
    getgenv().ESPCache[g].Bars.Health={Gui=v,Outline=q,Frame=x,Gradient=E}
end
X[2115]=X[229].funcs
X[2115].render=X[129]
getgenv().utility.funcs.clear_esp=function(g)if not getgenv().ESPCache[g]then return
    end
    if getgenv().ESPCache[g].Box and getgenv().ESPCache[g].Box.Full then getgenv().ESPCache[g].Box.Full.Square.Visible=false
        getgenv().ESPCache[g].Box.Full.Outline.Visible=false
        getgenv().ESPCache[g].Box.Full.Inline.Visible=false
        if getgenv().ESPCache[g].Box.Full.Filled then getgenv().ESPCache[g].Box.Full.Filled.Visible=false
        end
    end
    if getgenv().ESPCache[g].Text then if getgenv().ESPCache[g].Text.Studs then getgenv().ESPCache[g].Text.Studs.Visible=false
        end
        if getgenv().ESPCache[g].Text.Tool then getgenv().ESPCache[g].Text.Tool.Visible=false
        end
        if getgenv().ESPCache[g].Text.Name then getgenv().ESPCache[g].Text.Name.Visible=false
        end
    end
    if getgenv().ESPCache[g].Bars then if getgenv().ESPCache[g].Bars.Health and getgenv().ESPCache[g].Bars.Health.Frame then getgenv().ESPCache[g].Bars.Health.Frame.Visible=false
            getgenv().ESPCache[g].Bars.Health.Outline.Visible=false
        end
        if getgenv().ESPCache[g].Bars.Armor and getgenv().ESPCache[g].Bars.Armor.Frame then getgenv().ESPCache[g].Bars.Armor.Frame.Visible=false
            getgenv().ESPCache[g].Bars.Armor.Outline.Visible=false
        end
    end
end
X[203]=getgenv
X[212]=X[203]().utility
I=function(g)local P={}
    if not g or not getgenv().ESPCache[g]then return
    end
    if g==getgenv().LocalPlayer and not getgenv().Config.ShowOnSelf then getgenv().utility.funcs.clear_esp(g)
        return
    end
    local v,E,x,q=getgenv().Config.Box.Enable,getgenv().Config.Text.Enable,getgenv().Config.Bars.Health.Enable,getgenv().Config.Bars.Armor.Enable
    if not(v or E or x or q)then getgenv().utility.funcs.clear_esp(g)
        return
    end
    x,q,v=g.Character,getgenv().LocalPlayer.Character,workspace.CurrentCamera
    if not x or not q then return
    end
    q=(x:FindFirstChild("HumanoidRootPart"))
    E=(x:FindFirstChildWhichIsA("Humanoid"))
    if not q or not E then getgenv().utility.funcs.clear_esp(g)
        return
    end
    local L,Y,A,K,f,C,l=ipairs,table.pack(x:GetChildren()),false,1/0,-1/0,1/0,-1/0
    for Z,h in L(table.unpack(Y))do Z=h:IsA("BasePart")and h.Name~="HumanoidRootPart"
        if Z then local Z,m,M=h.CFrame,h.Size*0.5,ipairs
            local h={Z*Vector3.new(m.X,m.Y,m.Z),Z*Vector3.new(m.X,m.Y,-m.Z),Z*Vector3.new(m.X,-m.Y,m.Z),Z*Vector3.new(m.X,-m.Y,-m.Z),Z*Vector3.new(-m.X,m.Y,m.Z),Z*Vector3.new(-m.X,m.Y,-m.Z),Z*Vector3.new(-m.X,-m.Y,m.Z),Z*Vector3.new(-m.X,-m.Y,-m.Z)}
            for d,d in M(h)do m,Z=v:WorldToViewportPoint(d)
                if Z then A,K,f,C,l=true,if m.X<K then m.X else K,if m.X>f then m.X else f,if m.Y<C then m.Y else C,if m.Y>l then m.Y else l
                end
            end
        end
    end
    if not A or K==1/0 then getgenv().utility.funcs.clear_esp(g)
        return
    end
    bi=Vector2.new(math.floor(K-2),math.floor(C-2))
    bh=Vector2.new(math.floor(f-K+4),math.floor(l-C+4))
    local A,K,K=getgenv().ESPCache[g],v:WorldToViewportPoint(q.Position)
    if not K then getgenv().utility.funcs.clear_esp(g)
        return
    end
    L=getgenv().Config.Box.Enable
    if L then Y=A.Box.Full
        local f,C,l,Z,h=Y.Square,Y.Outline,Y.Inline,Y.Filled,getgenv().Config.Box.Type=="Full"
        if h then f.Visible=true
            f.Position=bi
            f.Size=bh
            f.Color=getgenv().Config.Box.Color
            f.Thickness=2
            f.Filled=false
            f.ZIndex=9000000000
            C.Visible=true
            C.Position=bi-Vector2.new(1,1)
            C.Size=bh+Vector2.new(2,2)
            C.Color=Color3.new(0,0,0)
            C.Thickness=1
            C.Filled=false
            l.Visible=true
            l.Position=bi+Vector2.new(1,1)
            l.Size=bh-Vector2.new(2,2)
            l.Color=Color3.new(0,0,0)
            l.Thickness=1
            l.Filled=false
            K=getgenv().Config.Box.Filled.Enable and Z
            if K then Z.Position=UDim2.new(0,bi.X,0,bi.Y-getgenv().gui_inset.Y)
                Z.Size=UDim2.new(0,bh.X,0,bh.Y)
                Z.BackgroundTransparency=getgenv().Config.Box.Filled.Gradient.Transparency or 0.5
                Z.BackgroundColor3=Color3.fromRGB(255,255,255)
                Z.Visible=true
                Z.ZIndex=-9000000000
                local f=getgenv().Config.Box.Filled.Gradient.Enable
                if f then local f=Z:FindFirstChild("Gradient")or Instance.new("UIGradient")
                    P[1]="Gradient"
                    f.Name=P[1]
                    f.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,getgenv().Config.Box.Filled.Gradient.Color.Start),ColorSequenceKeypoint.new(1,getgenv().Config.Box.Filled.Gradient.Color.End)})
                    f.Rotation=math.sin(tick()*2)*180
                    if not f.Parent then f.Parent=Z
                end
            end
        elseif Z then Z.Visible=false
            end
        else Y.Square.Visible=false
            Y.Outline.Visible=false
            Y.Inline.Visible=false
            if Y.Filled then Y.Filled.Visible=false
            end
        end
    else local f=A.Box.Full
        if f then if f.Square then f.Square.Visible=false
            end
            if f.Outline then f.Outline.Visible=false
            end
            if f.Inline then f.Inline.Visible=false
            end
            if f.Filled then f.Filled.Visible=false
            end
        end
    end
    local f,C,l,Z=bh.Y,3,bi.X,bi.Y-getgenv().gui_inset.Y
    if getgenv().Config.Bars.Health.Enable and E then L=math.clamp(E.Health/E.MaxHealth,0,1)
        Y=A.Bars.Health.LastHealth or L
        local h=Y+(L-Y)*0.05
        A.Bars.Health.LastHealth=h
        local m,M,d=l-7,A.Bars.Health.Outline,A.Bars.Health.Frame
        if M and d then M.Visible=true
            M.Position=UDim2.new(0,m-1,0,Z-1)
            M.Size=UDim2.new(0,5,0,f+1.1)
            M.BackgroundTransparency=0.2
            d.Visible=true
            d.Position=UDim2.new(0,1,0,(1-h)*f+1)
            d.Size=UDim2.new(0,C,0,h*f)
        end
    elseif A.Bars.Health then if A.Bars.Health.Frame then A.Bars.Health.Frame.Visible=false
            end
            if A.Bars.Health.Outline then A.Bars.Health.Outline.Visible=false
            end
        end
        E=getgenv().Config.Text.Enable
        if E then local h,m,M,d,c,e,j=A.Text.Name,A.Text.Tool,A.Text.Studs,15,bi.X+bh.X/2,bi.Y-getgenv().gui_inset.Y,getgenv().Config.Text.Name.Enable
            if j then h.Visible=true
                h.Position=UDim2.new(0,c-h.AbsoluteSize.X/2,0,e-d+6)
                L=getgenv().Config.Text.Name.Type or "Both"
                Y=L=="Display"
                if Y then h.Text=g.DisplayName
                else local B=L=="Username"
                    if B then h.Text=g.Name
                else local B=L=="Both"
                    if B then P[2]=g.DisplayName.." (@"..g.Name..")"
                    h.Text=P[2]
                else h.Text=g.Name
                end
            end
        end
    else h.Visible=false
    end
    j=getgenv().Config.Text.Tool.Enable
    if j then m.Visible=true
        m.Position=UDim2.new(0,c-m.AbsoluteSize.X/2,0,e+bh.Y+15)
        d=(x:FindFirstChildOfClass("Tool"))
        P[3]=d and d.Name or "none"
        m.Text=P[3]
    else m.Visible=false
    end
    m=getgenv().Config.Text.Studs.Enable
    if m then M.Visible=true
        M.Position=UDim2.new(0,c-M.AbsoluteSize.X/2,0,e+bh.Y+5)
        d=(v.CFrame.Position-q.Position).Magnitude
        P[4]=(string.format("[%.0fm]",d*0.28))
        M.Text=P[4]
    else M.Visible=false
    end
else if A.Text.Name then A.Text.Name.Visible=false
    end
    if A.Text.Tool then A.Text.Tool.Visible=false
    end
    if A.Text.Studs then A.Text.Studs.Visible=false
    end
end
q=getgenv().Config.Bars.Armor.Enable and x
if q then E=(x:FindFirstChild("BodyEffects"))
    L=E and E:FindFirstChild("Armor")
    Y=L and math.clamp(L.Value/130,0,1)or 0
    K=A.Bars.Armor.LastArmor or Y
    v=K+(Y-K)*0.05
    A.Bars.Armor.LastArmor=v
    local g,P,E=l-14,A.Bars.Armor.Outline,A.Bars.Armor.Frame
    if P then P.Visible=true
        P.Position=UDim2.new(0,g-1,0,Z-1)
        P.Size=UDim2.new(0,5,0,f+1.1)
        P.BackgroundTransparency=0.2
    end
    if E then E.Visible=true
        E.Position=UDim2.new(0,1,0,(1-v)*f+1)
        E.Size=UDim2.new(0,C,0,v*f)
    end
elseif A.Bars.Armor then if A.Bars.Armor.Frame then A.Bars.Armor.Frame.Visible=false
        end
        if A.Bars.Armor.Outline then A.Bars.Armor.Outline.Visible=false
        end
    end
end
X[2116]=X[212].funcs
X[2116].update=I
for g,g in ipairs(getgenv().Players:GetPlayers())do getgenv().utility.funcs.render(g)
end
X[193]=getgenv
r=X[193]().Players
X[56]=function(g)getgenv().utility.funcs.render(g)
end
r.PlayerAdded:Connect(X[56])
X[119]=getgenv
X[104]=X[119]().Players
X[117]=function(g)getgenv().utility.funcs.clear_esp(g)
end
X[104].PlayerRemoving:Connect(X[117])
getgenv().connections.main=getgenv().connections.main or{}
if getgenv().connections.main.RenderStepped then getgenv().connections.main.RenderStepped:Disconnect()
end
getgenv().connections.main.RenderStepped=getgenv().RunService.Heartbeat:Connect(function()for g,I in pairs(getgenv().ESPCache)do if g then getgenv().utility.funcs.update(g)
        end
    end
end)
X[2117]=getgenv()
X[2119]=getgenv().Visuals_ESP_SubTab
X[2118]={}
X[2118].Name="player esp"
X[2118].Position="left"
X[2117].ESPSection = (X[2119]:AddSection(X[2118]))
X[2121]=getgenv()
X[2121].esp_box_lbl = (getgenv().ESPSection:AddLabel("box esp"))
X[2124]=getgenv().esp_box_lbl
X[2124]:AddToggle({
    Default = getgenv().Config.Box.Enable,
    Flag = "ESP_BoxEnable",
    Callback = function(g)getgenv().Config.Box.Enable=g
        if not g then for g in pairs(getgenv().ESPCache)do getgenv().utility.funcs.clear_esp(g)
            end
        end
    end,
})
X[2126]=getgenv().esp_box_lbl
X[2126]:AddColorPicker({
    Default = getgenv().Config.Box.Color,
    Flag = "ESP_BoxColor",
    Callback = function(g)getgenv().Config.Box.Color=g
    end,
})
X[2127]=getgenv()
X[2127].esp_self_lbl = (getgenv().ESPSection:AddLabel("show on self"))
X[2130]=getgenv().esp_self_lbl
X[2130]:AddToggle({
    Default = getgenv().Config.ShowOnSelf,
    Flag = "ESP_ShowOnSelf",
    Callback = function(g)getgenv().Config.ShowOnSelf=g
        if not g then getgenv().utility.funcs.clear_esp(getgenv().LocalPlayer)
        end
    end,
})
X[2131]=getgenv()
X[2131].esp_fill_lbl = (getgenv().ESPSection:AddLabel("filled box"))
X[2134]=getgenv().esp_fill_lbl
X[2134]:AddToggle({
    Default = getgenv().Config.Box.Filled.Enable,
    Flag = "ESP_FilledBox",
    Callback = function(g)getgenv().Config.Box.Filled.Enable=g
    end,
})
X[2136]=getgenv().esp_fill_lbl
X[2136]:AddColorPicker({
    Default = getgenv().Config.Box.Filled.Gradient.Color.Start,
    Flag = "ESP_FillGradStart",
    Callback = function(g)getgenv().Config.Box.Filled.Gradient.Color.Start=g
    end,
})
X[2138]=getgenv().esp_fill_lbl
X[2138]:AddColorPicker({
    Default = getgenv().Config.Box.Filled.Gradient.Color.End,
    Flag = "ESP_FillGradEnd",
    Callback = function(g)getgenv().Config.Box.Filled.Gradient.Color.End=g
    end,
})
X[2139]=getgenv()
X[2139].esp_trans_lbl = (getgenv().ESPSection:AddLabel("fill transparency"))
X[2142]=getgenv().esp_trans_lbl
X[2142]:AddSlider({
    Min = 0,
    Max = 1,
    Rounding = 2,
    Default = getgenv().Config.Box.Filled.Gradient.Transparency,
    Flag = "ESP_FillTransparency",
    Callback = function(g)getgenv().Config.Box.Filled.Gradient.Transparency=g
    end,
})
X[2143]=getgenv()
X[2143].esp_text_lbl = (getgenv().ESPSection:AddLabel("text esp master"))
X[2146]=getgenv().esp_text_lbl
X[2146]:AddToggle({
    Default = getgenv().Config.Text.Enable,
    Flag = "ESP_TextEnable",
    Callback = function(g)getgenv().Config.Text.Enable=g
        if not g then for g in pairs(getgenv().ESPCache)do getgenv().utility.funcs.clear_esp(g)
            end
        end
    end,
})
X[2147]=getgenv()
X[2147].esp_name_lbl = (getgenv().ESPSection:AddLabel("names"))
X[2150]=getgenv().esp_name_lbl
X[2150]:AddToggle({
    Default = getgenv().Config.Text.Name.Enable,
    Flag = "ESP_Names",
    Callback = function(g)getgenv().Config.Text.Name.Enable=g
        if not g then for g,g in pairs(getgenv().ESPCache)do if g.Text and g.Text.Name then g.Text.Name.Visible=false
                end
            end
        end
    end,
})
X[2152]=getgenv().esp_name_lbl
X[2152]:AddColorPicker({
    Default = getgenv().Config.Text.Name.Color,
    Flag = "ESP_NamesColor",
    Callback = function(g)getgenv().Config.Text.Name.Color=g
        for I,I in pairs(getgenv().ESPCache)do if I.Text and I.Text.Name then I.Text.Name.TextColor3=g
            end
        end
    end,
})
X[2154]=getgenv().esp_name_lbl
X[2153]={}
X[2153].Default="Display"
local g,I,P,v,E,x=X[2154],X[2153],{},"Display","Username","Both"
N:jq(P,0,v,E,x)
I.Values=P
I.Flag = "ESP_NameType"
I.Callback=function(P)getgenv().Config.Text.Name.Type=P
end
g:AddDropdown(I)
X[2156]=getgenv()
X[2156].esp_studs_lbl = (getgenv().ESPSection:AddLabel("distance"))
X[2159]=getgenv().esp_studs_lbl
X[2159]:AddToggle({
    Default = getgenv().Config.Text.Studs.Enable,
    Flag = "ESP_Distance",
    Callback = function(g)getgenv().Config.Text.Studs.Enable=g
        if not g then for g,g in pairs(getgenv().ESPCache)do if g.Text and g.Text.Studs then g.Text.Studs.Visible=false
                end
            end
        end
    end,
})
X[2161]=getgenv().esp_studs_lbl
X[2161]:AddColorPicker({
    Default = getgenv().Config.Text.Studs.Color,
    Flag = "ESP_DistanceColor",
    Callback = function(g)getgenv().Config.Text.Studs.Color=g
        for I,I in pairs(getgenv().ESPCache)do if I.Text and I.Text.Studs then I.Text.Studs.TextColor3=g
            end
        end
    end,
})
X[2162]=getgenv()
X[2162].esp_tool_lbl = (getgenv().ESPSection:AddLabel("equipped tools"))
X[2165]=getgenv().esp_tool_lbl
X[2165]:AddToggle({
    Default = getgenv().Config.Text.Tool.Enable,
    Flag = "ESP_Tools",
    Callback = function(g)getgenv().Config.Text.Tool.Enable=g
        if not g then for g,g in pairs(getgenv().ESPCache)do if g.Text and g.Text.Tool then g.Text.Tool.Visible=false
                end
            end
        end
    end,
})
X[2167]=getgenv().esp_tool_lbl
X[2167]:AddColorPicker({
    Default = getgenv().Config.Text.Tool.Color,
    Flag = "ESP_ToolsColor",
    Callback = function(g)getgenv().Config.Text.Tool.Color=g
        for I,I in pairs(getgenv().ESPCache)do if I.Text and I.Text.Tool then I.Text.Tool.TextColor3=g
            end
        end
    end,
})
local function g()local I=ColorSequence.new({ColorSequenceKeypoint.new(0,getgenv().Config.Bars.Health.Color1),ColorSequenceKeypoint.new(0.5,getgenv().Config.Bars.Health.Color2),ColorSequenceKeypoint.new(1,getgenv().Config.Bars.Health.Color3)})
    if getgenv().ESPCache then for P,P in pairs(getgenv().ESPCache)do if P.Bars and P.Bars.Health and P.Bars.Health.Gradient then P.Bars.Health.Gradient.Color=I
            end
        end
    end
end
X[2168]=getgenv()
X[2168].esp_healthbar_lbl = (getgenv().ESPSection:AddLabel("health bar"))
X[2171]=getgenv().esp_healthbar_lbl
X[2171]:AddToggle({
    Default = getgenv().Config.Bars.Health.Enable,
    Flag = "ESP_HealthBar",
    Callback = function(I)getgenv().Config.Bars.Health.Enable=I
        if not I and getgenv().ESPCache then for I,I in pairs(getgenv().ESPCache)do if I.Bars and I.Bars.Health then if I.Bars.Health.Frame then I.Bars.Health.Frame.Visible=false
                    end
                    if I.Bars.Health.Outline then I.Bars.Health.Outline.Visible=false
                    end
                end
            end
        end
    end,
})
X[2173]=getgenv().esp_healthbar_lbl
X[2173]:AddColorPicker({
    Default = getgenv().Config.Bars.Health.Color1,
    Flag = "ESP_HealthBarColor_High",
    Callback = function(I)getgenv().Config.Bars.Health.Color1=I
        g()
    end,
})
X[2175]=getgenv().esp_healthbar_lbl
X[2175]:AddColorPicker({
    Default = getgenv().Config.Bars.Health.Color2,
    Flag = "ESP_HealthBarColor_Mid",
    Callback = function(I)getgenv().Config.Bars.Health.Color2=I
        g()
    end,
})
X[2177]=getgenv().esp_healthbar_lbl
X[2177]:AddColorPicker({
    Default = getgenv().Config.Bars.Health.Color3,
    Flag = "ESP_HealthBarColor_Low",
    Callback = function(I)getgenv().Config.Bars.Health.Color3=I
        g()
    end,
})
X[2178]=getgenv()
X[2179]={}
X[2179].Enabled=false
X[2179].Material="Neon"
X[2179].Color=Color3.fromRGB(0,140,255)
X[2179].Transparency=0
X[2179].OriginalData={}
X[2179].SavedClothes={}
X[2179].SavedFaces={}
X[2179].SavedBodyColors=nil
X[2179].WireframeBoxes={}
X[2178].SelfMaterialConfig = X[2179]
X[2181]=getgenv()
Config.HitPartsMap={}
Config.HitPartsMap["Head"]=true
Config.HitPartsMap["Torso"]=true
Config.HitPartsMap["UpperTorso"]=true
Config.HitPartsMap["LowerTorso"]=true
Config.HitPartsMap["Left Arm"]=true
Config.HitPartsMap["Right Arm"]=true
Config.HitPartsMap["Left Leg"]=true
Config.HitPartsMap["Right Leg"]=true
Config.HitPartsMap["LeftUpperArm"]=true
Config.HitPartsMap["LeftLowerArm"]=true
Config.HitPartsMap["LeftHand"]=true
Config.HitPartsMap["RightUpperArm"]=true
Config.HitPartsMap["RightLowerArm"]=true
Config.HitPartsMap["RightHand"]=true
Config.HitPartsMap["LeftUpperLeg"]=true
Config.HitPartsMap["LeftLowerLeg"]=true
Config.HitPartsMap["LeftFoot"]=true
Config.HitPartsMap["RightUpperLeg"]=true
Config.HitPartsMap["RightLowerLeg"]=true
Config.HitPartsMap["RightFoot"]=true
X[2181].SelfMat_TargetBodyParts = Config.HitPartsMap
local function g(I)if not I then return false
    end
    if getgenv().MorphSettings and getgenv().MorphSettings.HasKorblox then return true
    end
    local P,v,q=I:FindFirstChild("RightLowerLeg"),I:FindFirstChild("RightFoot"),I:FindFirstChild("RightUpperLeg")
    if P and P.Transparency>=0.9 then return true
    end
    if v and v.Transparency>=0.9 then return true
    end
    I=q and q:IsA("MeshPart")
    if I then v=tostring(q.MeshId)
        P=v:find("902942096")or v:find("902942093")or v:find("902843398")
        if P then return true
        end
    end
    return false
end
getgenv().SelfMat_ClearWireframe=function()for I,P in ipairs(getgenv().SelfMaterialConfig.WireframeBoxes)do if P and P.Parent then local v=346738055
            I=v
            local q
            q,v=pcall,N:Aq(I+364498007)
            q(function()P:Destroy()
            end)
        end
    end
    getgenv().SelfMaterialConfig.WireframeBoxes={}
end
X[43]=getgenv
X[70]=function(I)if not I then return
    end
    local P,v=ipairs,table.pack(I:GetChildren())
    for I,q in P(table.unpack(v))do I=q:IsA("Shirt")or q:IsA("Pants")or q:IsA("ShirtGraphic")
        if I then table.insert(getgenv().SelfMaterialConfig.SavedClothes,q)
            q.Parent=nil
        end
    end
end
X[2184]=X[43]()
X[2184].SelfMat_HideClothes=X[70]
X[58]=getgenv
X[7]=function(I)if not I then return
    end
    local P,v=ipairs,getgenv().SelfMaterialConfig.SavedClothes
    for q,L in P(v)do q=L and L:IsA("Instance")
        if q then L.Parent=I
        end
    end
    getgenv().SelfMaterialConfig.SavedClothes={}
end
X[2185]=X[58]()
X[2185].SelfMat_RestoreClothes=X[7]
X[15]=getgenv
x=function(I)if not I then return
    end
    local P=I:FindFirstChild("Head")
    if not P then return
    end
    local I,v=ipairs,table.pack(P:GetDescendants())
    for P,q in I(table.unpack(v))do P="Decal"
        if q:IsA(P)then if getgenv().SelfMaterialConfig.SavedFaces[q]==nil then getgenv().SelfMaterialConfig.SavedFaces[q]=q.Transparency
            end
            q.Transparency=1
        end
    end
end
X[2186]=X[15]()
X[2186].SelfMat_HideFace=x
getgenv().SelfMat_RestoreFace=function()for I,P in pairs(getgenv().SelfMaterialConfig.SavedFaces)do if I and I.Parent then local v=354561683
            local x=v
            local q
            q,v=pcall,N:Aq(x+252085431)
            q(function()I.Transparency=P
            end)
        end
    end
    getgenv().SelfMaterialConfig.SavedFaces={}
end
X[180]=getgenv
X[17]=function(I,P)local v=I and I:FindFirstChildOfClass("BodyColors")
    if not v then return
    end
    if not getgenv().SelfMaterialConfig.SavedBodyColors then getgenv().SelfMaterialConfig.SavedBodyColors={HeadColor3=v.HeadColor3,TorsoColor3=v.TorsoColor3,LeftArmColor3=v.LeftArmColor3,RightArmColor3=v.RightArmColor3,LeftLegColor3=v.LeftLegColor3,RightLegColor3=v.RightLegColor3}
    end
    v.HeadColor3=P
    v.TorsoColor3=P
    v.LeftArmColor3=P
    v.RightArmColor3=P
    v.LeftLegColor3=P
    v.RightLegColor3=P
end
X[2187]=X[180]()
X[2187].SelfMat_ApplyBodyColors=X[17]
w=getgenv
X[12]=function(I)local P,v=I and I:FindFirstChildOfClass("BodyColors"),getgenv().SelfMaterialConfig.SavedBodyColors
    if P and v then P.HeadColor3=v.HeadColor3
        P.TorsoColor3=v.TorsoColor3
        P.LeftArmColor3=v.LeftArmColor3
        P.RightArmColor3=v.RightArmColor3
        P.LeftLegColor3=v.LeftLegColor3
        P.RightLegColor3=v.RightLegColor3
    end
    getgenv().SelfMaterialConfig.SavedBodyColors=nil
end
X[2188]=w()
X[2188].SelfMat_RestoreBodyColors=X[12]
X[178]=getgenv
X[169]=function(I)local w=not getgenv().SelfMaterialConfig.OriginalData[I]
    if w then local w,P,v=I:FindFirstChildOfClass("SpecialMesh"),getgenv().SelfMaterialConfig.OriginalData,{Material=I.Material,Color=I.Color,Transparency=I.Transparency}
        v.TextureID=I:IsA("MeshPart")and I.TextureID or nil
        v.MeshTexture=w and w.TextureId or nil
        P[I]=v
    end
end
X[2189]=X[178]()
X[2189].SelfMat_BackupPartData=X[169]
X[209]=getgenv
X[145]=function()local I=getgenv().LocalPlayer.Character
    getgenv().SelfMat_ClearWireframe()
    if I then getgenv().SelfMat_RestoreClothes(I)
        getgenv().SelfMat_RestoreFace()
        local w,P=pairs,getgenv().SelfMaterialConfig.OriginalData
        for v,x in w(P)do local w=v and v.Parent
            if w then local w=228109822
                local q=w
                local L
                L,w=pcall,N:Aq(bit32.band(527141068,q)+bit32.band(527141068,488050528)+(bit32.band(3767826229,(bit32.bor(q,488050528)))+bit32.band(3767826227,(bit32.band(q,488050528)))))
                L(function()v.Material=x.Material
                    v.Color=x.Color
                    v.Transparency=x.Transparency
                    local w=v:IsA("MeshPart")and x.TextureID
                    if w then v.TextureID=x.TextureID
                end
                w=(v:FindFirstChildOfClass("SpecialMesh"))
                if w and x.MeshTexture then w.TextureId=x.MeshTexture
                end
            end)
        end
    end
    getgenv().SelfMat_RestoreBodyColors(I)
    P=g(I)
    if P then local w,P=I:FindFirstChild("RightLowerLeg"),I:FindFirstChild("RightFoot")
        if w then w.Transparency=1
        end
        if P then P.Transparency=1
        end
    end
end
getgenv().SelfMaterialConfig.OriginalData={}
end
X[2190]=X[209]()
X[2190].RestoreSelfMaterial=X[145]
local function I(w,P)local v={}
    if not w or not w.Parent then return
    end
    local x=P.Material=="Wireframe"
    if x then w.Transparency=1
        local x=w:IsA("MeshPart")
        if x then v[1]=""
            w.TextureID=v[1]
        end
        x=(w:FindFirstChildOfClass("SpecialMesh"))
        if x then v[2]=""
            x.TextureId=v[2]
        end
        x=(Instance.new("SelectionBox"))
        v[3]="Self_Wireframe"
        x.Name=v[3]
        x.Adornee=w
        x.Color3=P.Color
        x.SurfaceTransparency=1
        x.LineThickness=0.01
        x.Parent=w
        table.insert(P.WireframeBoxes,x)
    else w.Material=Enum.Material[P.Material]or Enum.Material.Neon
        w.Color=P.Color
        local x=w:IsA("MeshPart")
        if x then v[4]=""
            w.TextureID=v[4]
        end
        x=(w:FindFirstChildOfClass("SpecialMesh"))
        if x then v[5]=""
            x.TextureId=v[5]
        end
        x=P.Material=="Glass"
        if x then w.Transparency=P.Transparency>0 and P.Transparency or 0.25
        else local v,x=P.Material,"ForceField"
            if v==x then w.Transparency=P.Transparency>0 and P.Transparency or 0.3
            else w.Transparency=P.Transparency
            end
        end
    end
end
X[163]=getgenv
X[203]=function()local w={}
    if not getgenv().SelfMaterialConfig.Enabled then return
    end
    local P=getgenv().LocalPlayer.Character
    if not P then return
    end
    local v,x=getgenv().SelfMaterialConfig,g(P)
    getgenv().SelfMat_ClearWireframe()
    local g,q=ipairs,table.pack(P:GetChildren())
    for L,Y in g(table.unpack(q))do L=Y:IsA("BasePart")and getgenv().SelfMat_TargetBodyParts[Y.Name]
        if L then getgenv().SelfMat_BackupPartData(Y)
        else local L=Y:IsA("Accessory")
            if L then local L,A=ipairs,table.pack(Y:GetDescendants())
                for Y,K in L(table.unpack(A))do Y="BasePart"
                    if K:IsA(Y)then getgenv().SelfMat_BackupPartData(K)
                end
            end
        end
    end
end
getgenv().SelfMat_HideClothes(P)
getgenv().SelfMat_HideFace(P)
getgenv().SelfMat_ApplyBodyColors(P,v.Color)
q,g=ipairs,table.pack(P:GetChildren())
for L,Y in q(table.unpack(g))do L=Y:IsA("BasePart")and getgenv().SelfMat_TargetBodyParts[Y.Name]
    if L then local L=getgenv().SelfMaterialConfig.OriginalData[Y]
        local A,K=L and L.Transparency>=0.9,x and(Y.Name=="RightLowerLeg"or Y.Name=="RightFoot")
        K=A or K
        if K then Y.Transparency=1
            L=(Y:IsA("MeshPart"))
            if L then w[1]=""
                Y.TextureID=w[1]
            end
        else I(Y,v)
        end
    end
end
q,g=ipairs,table.pack(P:GetChildren())
for w,L in q(table.unpack(g))do x=(L:IsA("Accessory"))
    if x then w,P=ipairs,table.pack(L:GetDescendants())
        for g,x in w(table.unpack(P))do g="BasePart"
            if x:IsA(g)then local g=getgenv().SelfMaterialConfig.OriginalData[x]
                if g and g.Transparency>=0.9 then x.Transparency=1
                else I(x,v)
                end
            end
        end
    end
end
end
X[2191]=X[163]()
X[2191].ApplySelfMaterial=X[203]
X[116]=getgenv
X[54]=X[116]().LocalPlayer
X[225]=function(g)task.wait(0.5)
    if getgenv().SelfMaterialConfig.Enabled then getgenv().ApplySelfMaterial()
    end
end
X[54].CharacterAdded:Connect(X[225])
X[2192]=getgenv()
X[2194]=getgenv().Visuals_Self_SubTab
X[2193]={}
X[2193].Name="self material"
X[2193].Position="left"
X[2192].SelfMatSection = (X[2194]:AddSection(X[2193]))
X[2196]=getgenv()
X[2196].self_mat_lbl = (getgenv().SelfMatSection:AddLabel("self material"))
X[2199]=getgenv().self_mat_lbl
X[2199]:AddToggle({
    Default = false,
    Flag = "SelfMat_Enabled",
    Callback = function(g)getgenv().SelfMaterialConfig.Enabled=g
        if g then getgenv().ApplySelfMaterial()
        else getgenv().RestoreSelfMaterial()
        end
    end,
})
X[2201]=getgenv().self_mat_lbl
X[2201]:AddColorPicker({
    Default = Color3.fromRGB(0,140,255),
    Flag = "SelfMat_Color",
    Callback = function(g)getgenv().SelfMaterialConfig.Color=g
        if getgenv().SelfMaterialConfig.Enabled then getgenv().ApplySelfMaterial()
        end
    end,
})
X[201]=getgenv().SelfMatSection
X[2202] = "material"
X[2204]=X[201]:AddLabel(X[2202])
X[2203]={}
X[2203].Default="Neon"
local g,I,w,P,v,x,q,L=X[2204],X[2203],{},"ForceField","Neon","Glass","Wireframe","SmoothPlastic"
N:jq(w,0,P,v,x,q,L)
I.Values=w
I.Flag = "SelfMat_MaterialType"
I.Callback=function(w)getgenv().SelfMaterialConfig.Material=w
    if getgenv().SelfMaterialConfig.Enabled then getgenv().ApplySelfMaterial()
    end
end
g:AddDropdown(I)
X[2207]=getgenv().SelfMatSection:AddLabel("transparency")
X[2207]:AddSlider({
    Min = 0,
    Max = 0.95,
    Rounding = 2,
    Default = 0,
    Flag = "SelfMat_Transparency",
    Callback = function(I)getgenv().SelfMaterialConfig.Transparency=I
        if getgenv().SelfMaterialConfig.Enabled then getgenv().ApplySelfMaterial()
        end
    end,
})
local I,I=getgenv().Players,getgenv().LocalPlayer
local w=getgenv().RunService
X[2208]={}
X[2208].starlight="rbxassetid://134645216613107"
X[2208].heavenly="rbxassetid://139300897520961"
X[2208].ribbon="rbxassetid://132069507632161"
X[2208].sakura="rbxassetid://81755778619404"
X[2208].angel="rbxassetid://97658130917593"
X[2208].wind="rbxassetid://80694081850877"
X[2208].flow="rbxassetid://119913533725648"
X[2208].star="rbxassetid://73754563740680"
local P=X[2208]
getgenv().PA_Enabled=false
getgenv().PA_Color=Color3.fromRGB(133,220,255)
getgenv().PA_Transparency=0.2
X[2209]=getgenv()
X[2209].PA_CurrentAura = "angel"
getgenv().PA_Particles={}
getgenv().PA_CharConn=nil
getgenv().PA_AuraObjects={}
local function v()for q,Y in ipairs(getgenv().PA_Particles)do local A=459160883
        q=A
        local K
        K,A=pcall,N:Aq(q+49574428)
        K(function()Y:Destroy()
        end)
    end
    getgenv().PA_Particles={}
end
local function q(Y,A)local K,f,C=ColorSequence.new(A),ipairs,table.pack(Y:GetDescendants())
    for l,Z in f(table.unpack(C))do Y=Z.ClassName=="PointLight"
        if Y then Z.Color=A
        else l=Z.ClassName=="ParticleEmitter"or Z.ClassName=="Beam"or Z.ClassName=="Trail"
            if l then Z.Color=K
            end
        end
    end
end
local function Y(A)local K=507859536
    local f=K
    local C
    C,K=getgenv().PA_AuraObjects,N:Aq(f+296920454)
    f=C[A]
    K=N:Aq(K+103217346)
    if f then return getgenv().PA_AuraObjects[A]
    end
    local K=P[A]
    if not K then return nil
    end
    C,f=pcall(function()local P=p
        return P:GetObjects(K)[1]
    end)
    if C and f then getgenv().PA_AuraObjects[A]=f
        return f
    end
    return nil
end
local function P()v()
    local A=I.Character
    if not A or not getgenv().PA_Enabled then return
    end
    local K=Y(getgenv().PA_CurrentAura)
    if not K then return
    end
    local Y=K:Clone()
    q(Y,getgenv().PA_Color)
    for q,q in ipairs(Y:GetChildren())do K=A:FindFirstChild(q.Name)
        if K then for A,A in ipairs(q:GetChildren())do A.Parent=K
                table.insert(getgenv().PA_Particles,A)
            end
        end
    end
    Y:Destroy()
end
getgenv().PA_Apply=P
getgenv().PA_Toggle=function(q)getgenv().PA_Enabled=q
    if getgenv().PA_CharConn then getgenv().PA_CharConn:Disconnect()
        getgenv().PA_CharConn=nil
    end
    v()
    if q then local v=413102141
        local q=v
        P()
        v=N:Aq(q+339696572)
        v,getgenv().PA_CharConn=N:Aq(v-127940349),I.CharacterAdded:Connect(function()task.wait(0.5)
            P()
        end)
    end
end
X[2211]={}
X[2211].Enabled=false
X[2211].Material="Neon"
X[2211].Color=Color3.fromRGB(217,204,83)
X[2211].OriginalData={}
local P=X[2211]
local function v(q)local Y={}
    local A=not P.OriginalData[q]
    if A then local A=338091454
        local K=A
        local f,C=P.OriginalData,{Material=q.Material,Color=q.Color}
        C.TextureID=""
        Y[1]=""
        C.Texture=Y[1]
        f[q]=C
        A=N:Aq(A+134170339)
        l,K=pcall(function()return q.TextureID
        end)
        if l and K then P.OriginalData[q].TextureID=K
        end
        C=(q:FindFirstChildOfClass("Texture"))
        if C and C.Texture then P.OriginalData[q].Texture=C.Texture
        end
    end
end
local function q(Y)local A={}
    local K=514382372
    local f=K
    local C
    K=bit32.bxor(f,497072719)
    C=not Y or not Y:IsA("BasePart")
    if C then return
    end
    K=N:Aq(bit32.band(3948036028,K)+bit32.band(3948036028,437015276)+(bit32.band(346931269,(bit32.bor(K,437015276)))+bit32.band(346931267,(bit32.band(K,437015276)))))
    v(Y)
    f=pcall(function()return Y.TextureID
    end)
    if f then A[1]=""
        Y.TextureID=A[1]
    end
    f=(Y:FindFirstChildOfClass("Texture"))
    if f then A[2]=""
        f.Texture=A[2]
    end
    Y.Material=Enum.Material[P.Material]
    Y.Color=P.Color
end
local function v(Y)local A={}
    local K=not Y or not Y:IsA("BasePart")
    if K then return
    end
    local f=P.OriginalData[Y]
    if f then local C=155045164
        K=C
        Y.Material=f.Material
        C=N:Aq(bit32.band(2168758104,K)+bit32.band(2168758104,74604696)+(bit32.band(4252418384,(bit32.bor(K,74604696)))+bit32.band(2168758105,(bit32.bxor(K,74604696)))))
        Y.Color=f.Color
        C=bit32.bxor(C,127770107)
        pcall(function()local K={}
            local C=f.TextureID and f.TextureID~=""
            if C then Y.TextureID=f.TextureID
            else Y.TextureID = ""
            end
        end)
        local K=Y:FindFirstChildOfClass("Texture")
        if K then local Y=f.Texture and f.Texture~=""
            if Y then K.Texture=f.Texture
            else A[1]=""
                K.Texture=A[1]
            end
        end
    end
end
local function Y(A)local K=not A or not A:IsA("Tool")
    if K then return
    end
    local f,C=pairs,table.pack(A:GetDescendants())
    for A,A in f(table.unpack(C))do K="BasePart"
        if A:IsA(K)then if P.Enabled then q(A)
            else v(A)
            end
        end
    end
end
local function v()if not I.Character then return
    end
    local q,A=pairs,table.pack(I.Character:GetChildren())
    for K,f in q(table.unpack(A))do K="Tool"
        if f:IsA(K)then Y(f)
        end
    end
    A=I.Backpack
    if A then local A,K=pairs,table.pack(I.Backpack:GetChildren())
        for f,f in A(table.unpack(K))do q="Tool"
            if f:IsA(q)then Y(f)
            end
        end
    end
end
local function q(A)local K="Tool"
    if A:IsA(K)then task.wait(0.1)
        Y(A)
    end
end
local function A(K)local f=K:IsA("Tool")
    if f then local f,C=pairs,table.pack(K:GetDescendants())
        for K,l in f(table.unpack(C))do K=l:IsA("BasePart")and P.OriginalData[l]
            if K then P.OriginalData[l]=nil
            end
        end
    end
end
local function K(f)f.ChildAdded:Connect(q)
    f.ChildRemoved:Connect(A)
    task.wait(1)
    v()
end
if I.Character then K(I.Character)
end
I.CharacterAdded:Connect(K)
local function K()P.OriginalData={}
end
I.CharacterRemoving:Connect(K)
if I.Backpack then I.Backpack.ChildAdded:Connect(q)
    I.Backpack.ChildRemoved:Connect(A)
end
local function K(f)local C,l=f.Name,"Backpack"
    if C==l then f.ChildAdded:Connect(q)
        f.ChildRemoved:Connect(A)
    end
end
I.ChildAdded:Connect(K)
local function q()local A=P.Enabled
    if A then local A=I.Character and I.Character:FindFirstChildOfClass("Tool")
        if A then local A,K=pairs,table.pack(I.Character:GetChildren())
            for I,f in A(table.unpack(K))do I=(f:IsA("Tool"))
                if I then local I,A=pairs,table.pack(f:GetDescendants())
                    for K,C in I(table.unpack(A))do K=C:IsA("BasePart")and C.Material~=Enum.Material[P.Material]
                    if K then Y(f)
                    break
                end
            end
        end
    end
end
end
end
w.Heartbeat:Connect(q)
X[55]=nil
X[2212]=getgenv()
X[55]=p
X[2212].WV_Lighting = (p:GetService("Lighting"))
getgenv().WV_origBrightness=getgenv().WV_Lighting.Brightness
getgenv().WV_origAmbient=getgenv().WV_Lighting.Ambient
getgenv().WV_origOutdoor=getgenv().WV_Lighting.OutdoorAmbient
getgenv().WV_origFogEnd=getgenv().WV_Lighting.FogEnd
getgenv().WV_origFogStart=getgenv().WV_Lighting.FogStart
getgenv().WV_origFogColor=getgenv().WV_Lighting.FogColor
getgenv().WV_origTechnology=getgenv().WV_Lighting.Technology
getgenv().WV_origClockTime=getgenv().WV_Lighting.ClockTime
X[2214]=getgenv()
X[2214].WV_origSky = (getgenv().WV_Lighting:FindFirstChildOfClass("Sky"))
X[2216]=getgenv()
X[2216].WV_origColorCorrection = (getgenv().WV_Lighting:FindFirstChildOfClass("ColorCorrectionEffect"))
getgenv().WV_atmosphere=nil
getgenv().WV_weatherPart=nil
getgenv().WV_weatherParticle=nil
getgenv().WV_weatherConn=nil
getgenv().WV_textureVariants={}
getgenv().WV_textureRestores={}
getgenv().WV_textureConn=nil
X[2218]=getgenv()
X[2218].WV_currentTexturePack = "minecraft"
X[2220]=getgenv()
X[2221]={}
X[2222]={}
X[2222].Speed=NumberRange.new(60,60)
X[2222].LockedToPart=true
X[2222].Rate=600
X[2222].Texture="rbxassetid://1822883048"
X[2222].EmissionDirection=Enum.NormalId.Bottom
X[2222].Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.25,0.78),NumberSequenceKeypoint.new(0.75,0.78),NumberSequenceKeypoint.new(1,1)})
X[2222].Lifetime=NumberRange.new(0.8,0.8)
X[2222].LightEmission=0.05
X[2222].LightInfluence=0.9
X[2222].Orientation=Enum.ParticleOrientation.FacingCameraWorldUp
X[2222].Size=NumberSequence.new({NumberSequenceKeypoint.new(0,10),NumberSequenceKeypoint.new(1,10)})
X[2221].rain=X[2222]
X[2223]={}
X[2223].Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.74),NumberSequenceKeypoint.new(0.973,0.77),NumberSequenceKeypoint.new(1,1)})
X[2223].Texture="http://www.roblox.com/asset/?id=99851851"
X[2223].SpreadAngle=Vector2.new(50,50)
X[2223].Speed=NumberRange.new(30,30)
X[2223].LightEmission=0.5
X[2223].Rate=1000
X[2223].EmissionDirection=Enum.NormalId.Bottom
X[2223].Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.33),NumberSequenceKeypoint.new(0.551,0.4),NumberSequenceKeypoint.new(1,0.33)})
X[2221].snow=X[2223]
X[2225]="light rain"
X[2224]={}
X[2224].LockedToPart=true
X[2224].Rate=500
X[2224].Squash=NumberSequence.new({NumberSequenceKeypoint.new(0,3),NumberSequenceKeypoint.new(1,3)})
X[2224].LightInfluence=0.3
X[2224].Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.435,0),NumberSequenceKeypoint.new(1,0)})
X[2224].Texture="rbxasset://textures/particles/sparkles_main.dds"
X[2224].Speed=NumberRange.new(30,50)
X[2224].Lifetime=NumberRange.new(9,9)
X[2224].LightEmission=0.5
X[2224].Brightness=2
X[2224].EmissionDirection=Enum.NormalId.Bottom
X[2224].Orientation=Enum.ParticleOrientation.FacingCameraWorldUp
X[2224].Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.2),NumberSequenceKeypoint.new(1,0.2)})
X[2221][X[2225]]=X[2224]
X[2220].WV_weatherTypes = X[2221]
X[2227]=getgenv()
X[2228]={}
X[2229]={}
X[2229].SkyboxUp="http://www.roblox.com/asset/?id=1876544642"
X[2229].SkyboxBk="http://www.roblox.com/asset/?id=1876545003"
X[2229].SkyboxLf="http://www.roblox.com/asset/?id=1876543392"
X[2229].SkyboxDn="http://www.roblox.com/asset/?id=1876544331"
X[2229].SkyboxFt="http://www.roblox.com/asset/?id=1876542941"
X[2229].SkyboxRt="http://www.roblox.com/asset/?id=1876543764"
X[2228].Minecraft=X[2229]
X[2231]="blue space"
X[2230]={}
X[2230].SkyboxLf="rbxassetid://15536110634"
X[2230].SkyboxUp="rbxassetid://15536117282"
X[2230].SkyboxRt="rbxassetid://15536110634"
X[2230].SkyboxFt="rbxassetid://15536110634"
X[2230].SkyboxDn="rbxassetid://15536112543"
X[2230].SkyboxBk="rbxassetid://15536110634"
X[2228][X[2231]]=X[2230]
X[2232]={}
X[2232].SkyboxUp="rbxassetid://12216108877"
X[2232].SkyboxLf="rbxassetid://12216110170"
X[2232].SkyboxRt="rbxassetid://12216110471"
X[2232].SkyboxFt="rbxassetid://12216109489"
X[2232].SkyboxBk="rbxassetid://12216109205"
X[2232].SkyboxDn="rbxassetid://12216109875"
X[2228].pink=X[2232]
X[2234]="black storm"
X[2233]={}
X[2233].SkyboxLf="rbxassetid://15502507918"
X[2233].SkyboxUp="rbxassetid://15502511911"
X[2233].SkyboxRt="rbxassetid://15502509398"
X[2233].SkyboxFt="rbxassetid://15502510289"
X[2233].SkyboxDn="rbxassetid://15502508460"
X[2233].SkyboxBk="rbxassetid://15502511288"
X[2228][X[2234]]=X[2233]
X[2235]={}
X[2235].SkyboxUp="rbxassetid://653719321"
X[2235].SkyboxDn="rbxassetid://653718790"
X[2235].SkyboxLf="rbxassetid://653719190"
X[2235].SkyboxFt="rbxassetid://653719067"
X[2235].SkyboxRt="rbxassetid://653718931"
X[2235].SkyboxBk="rbxassetid://653719502"
X[2228].realistic=X[2235]
X[2227].WV_skyboxes = X[2228]
X[28]=(getgenv())
X[172]={}
X[2237]={}
X[2237].Slate="http://www.roblox.com/asset/?id=8676746437"
X[2237].Grass="http://www.roblox.com/asset/?id=9267183930"
X[2237].Sand="http://www.roblox.com/asset/?id=12624140843"
X[2237].Wood="http://www.roblox.com/asset/?id=3258599312"
X[2237].Brick="http://www.roblox.com/asset/?id=10777285622"
X[2237].Concrete="http://www.roblox.com/asset/?id=15622710576"
X[2237].CorrodedMetal="rbxassetid://78612695839404"
X[2237].Metal="http://www.roblox.com/asset/?id=121650613091353"
X[2237].WoodPlanks="http://www.roblox.com/asset/?id=8676581022"
X[172].minecraft = X[2237]
X[28].WV_texture_packs=X[172]
R=getgenv
X[210]=function(I)local Y={}
    local A=getgenv().WV_Lighting:FindFirstChildOfClass("Sky")
    local K=not A
    if K then A=(Instance.new("Sky"))
        A.Parent=getgenv().WV_Lighting
    end
    K=getgenv().WV_skyboxes[I]
    if not K then return
    end
    Y[1]=K.SkyboxBk or ""
    A.SkyboxBk=Y[1]
    Y[2]=K.SkyboxDn or ""
    A.SkyboxDn=Y[2]
    Y[3]=K.SkyboxFt or ""
    A.SkyboxFt=Y[3]
    Y[4]=K.SkyboxLf or ""
    A.SkyboxLf=Y[4]
    Y[5]=K.SkyboxRt or ""
    A.SkyboxRt=Y[5]
    Y[6]=K.SkyboxUp or ""
    A.SkyboxUp=Y[6]
end
X[2239]=R()
X[2239].WV_applySkybox=X[210]
getgenv().WV_restoreSkybox=function()local I=getgenv().WV_Lighting:FindFirstChildOfClass("Sky")
    if getgenv().WV_origSky then if I and I~=getgenv().WV_origSky then I:Destroy()
        end
        getgenv().WV_origSky.Parent=getgenv().WV_Lighting
    elseif I then I:Destroy()
        end
    end
    X[26]=getgenv
    X[220]=function(I)local Y=getgenv().WV_texture_packs[getgenv().WV_currentTexturePack]
        if not Y then return
        end
        local A=I:IsA("MeshPart")or I:IsA("Part")
        if not A then return
        end
        local A,K=Y[I.Material.Name],Color3.fromRGB(254,253,255)
        if A or I.Color==K then if I.Transparency>=0.8 then return
            end
            if not getgenv().WV_textureRestores[I]then getgenv().WV_textureRestores[I]=I.Color
                I.Color=K
            end
        end
    end
    X[2240]=X[26]()
    X[2240].WV_applyTexture=X[220]
    X[42]=getgenv
    X[13]=function()for I=1,#getgenv().WV_textureVariants,1 do if getgenv().WV_textureVariants[I]then getgenv().WV_textureVariants[I]:Destroy()
                getgenv().WV_textureVariants[I]=nil
            end
        end
        getgenv().WV_textureVariants={}
        local I,I,I=p,p,pcall(p.GetService,p,"MaterialService")
        local Y
        if I then local A=p
            Y=(A:FindService("MaterialService"))
        else Y=I
        end
        if not Y then return
        end
        I=getgenv().WV_texture_packs[getgenv().WV_currentTexturePack]
        if not I then return
        end
        local A=pairs
        for K,f in A(I)do local I=K~="Glass"
            if I then local I=Instance.new("MaterialVariant")
                I.ColorMap=f
                I.MetalnessMap=f
                I.NormalMap=f
                I.RoughnessMap=f
                I.BaseMaterial=Enum.Material[K]
                I.Name=K
                I.StudsPerTile=5
                I.Parent=Y
                table.insert(getgenv().WV_textureVariants,I)
            end
        end
        for I,I in ipairs(workspace:GetDescendants())do getgenv().WV_applyTexture(I)
        end
    end
    X[2241]=X[42]()
    X[2241].WV_applyTextures=X[13]
    getgenv().WV_removeTextures=function()for I=1,#getgenv().WV_textureVariants,1 do local Y=345084598
            local A=Y
            local K,f=pcall,N:Aq(I)
            Y=N:Aq(bit32.band(2677374180,4294967295)+A+(bit32.band(1373539281,f)+bit32.band(1373539281,(bit32.bnot(f)))))
            K(function()getgenv().WV_textureVariants[I]:Destroy()
            end)
        end
        getgenv().WV_textureVariants={}
        for I,Y in pairs(getgenv().WV_textureRestores)do local A=170244663
            local K
            K,A=pcall,bit32.bxor(A,118978019)
            K(function()I.Color=Y
            end)
            getgenv().WV_textureRestores[I]=nil
        end
    end
    q=getgenv
    X[61]=function(I,Y,A)local K={}
        local f=267772264
        if getgenv().WV_weatherConn then getgenv().WV_weatherConn:Disconnect()
            getgenv().WV_weatherConn=nil
        end
        if getgenv().WV_weatherPart then getgenv().WV_weatherPart:Destroy()
            getgenv().WV_weatherPart=nil
            getgenv().WV_weatherParticle=nil
        end
        local C=getgenv().WV_weatherTypes[I]
        if not C then return
        end
        K[1]=getgenv()
        f=bit32.bxor(f,2569816)
        K[2]=(Instance.new("Part"))
        K[1].WV_weatherPart=K[2]
        getgenv().WV_weatherPart.Size=Vector3.new(40,40,85)
        getgenv().WV_weatherPart.CanCollide=false
        getgenv().WV_weatherPart.Massless=true
        getgenv().WV_weatherPart.CastShadow=false
        getgenv().WV_weatherPart.Transparency=1
        getgenv().WV_weatherPart.Anchored=true
        getgenv().WV_weatherPart.Parent=workspace
        getgenv().WV_weatherParticle = (Instance.new("ParticleEmitter"))
        for K,f in pairs(C)do local l=32912599
            I=l
            local Z
            Z,l=pcall,N:Aq(I+241664828)
            Z(function()getgenv().WV_weatherParticle[K]=f
            end)
        end
        getgenv().WV_weatherParticle.Color=ColorSequence.new(Y or Color3.fromRGB(255,255,255))
        if A then getgenv().WV_weatherParticle.Rate=C.Rate*(A/100)
        end
        getgenv().WV_weatherParticle.Parent=getgenv().WV_weatherPart
        getgenv().WV_weatherConn=w.Heartbeat:Connect(function()if getgenv().WV_weatherPart and workspace.CurrentCamera then getgenv().WV_weatherPart.CFrame=CFrame.new(workspace.CurrentCamera.CFrame.Position)+Vector3.new(0,20,0)
            end
        end)
    end
    X[2242]=q()
    X[2242].WV_startWeather=X[61]
    getgenv().WV_stopWeather=function()if getgenv().WV_weatherConn then getgenv().WV_weatherConn:Disconnect()
            getgenv().WV_weatherConn=nil
        end
        if getgenv().WV_weatherPart then getgenv().WV_weatherPart:Destroy()
            getgenv().WV_weatherPart=nil
            getgenv().WV_weatherParticle=nil
        end
    end
    getgenv().WV_weatherColor=Color3.fromRGB(255,255,255)
    getgenv().WV_weatherRate=100
    X[2243]=getgenv()
    X[2243].WV_weatherType = "rain"
    getgenv().WV_weatherEnabled=false
    local a9 = getgenv().WV_Settings
    local function I()local Y={}
        a9 = getgenv().WV_Settings
        if not a9 then return
        end
        if a9.LightingMode then local A=({compatibility=Enum.Technology.Compatibility,shadowmap=Enum.Technology.ShadowMap,future=Enum.Technology.Future,voxel=Enum.Technology.Voxel})[a9.LightingType]or Enum.Technology.ShadowMap
            if getgenv().WV_Lighting.Technology~=A then getgenv().WV_Lighting.Technology=A
            end
        end
        if a9.WorldTime then if getgenv().WV_Lighting.ClockTime~=a9.WorldTimeHour then getgenv().WV_Lighting.ClockTime=a9.WorldTimeHour
            end
        end
        if a9.Ambient then if getgenv().WV_Lighting.Ambient~=a9.AmbientColor then getgenv().WV_Lighting.Ambient=a9.AmbientColor
            end
            if getgenv().WV_Lighting.OutdoorAmbient~=a9.OutdoorColor then getgenv().WV_Lighting.OutdoorAmbient=a9.OutdoorColor
            end
        end
        local A=a9.Atmosphere
        if A then local K=not getgenv().WV_atmosphere or not getgenv().WV_atmosphere.Parent
            if K then getgenv().WV_atmosphere = (Instance.new("Atmosphere"))
                getgenv().WV_atmosphere.Color=a9.AtmosphereColor
                getgenv().WV_atmosphere.Decay=a9.AtmosphereDecay
                getgenv().WV_atmosphere.Haze=a9.AtmosphereHaze
                getgenv().WV_atmosphere.Glare=a9.AtmosphereGlare
                getgenv().WV_atmosphere.Offset=a9.AtmosphereOffset
                getgenv().WV_atmosphere.Density=a9.AtmosphereDensity
                getgenv().WV_atmosphere.Parent=getgenv().WV_Lighting
            end
        end
        A=a9.Skybox
        if A then local Y,A=getgenv().WV_Lighting:FindFirstChildOfClass("Sky"),getgenv().WV_skyboxes[a9.SkyboxType]
            if not Y or A and Y.SkyboxBk~=A.SkyboxBk then getgenv().WV_applySkybox(a9.SkyboxType)
            end
        end
    end
    if getgenv().WV_PersistLoop then getgenv().WV_PersistLoop:Disconnect()
    end
    getgenv().WV_PersistLoop=w.Heartbeat:Connect(I)
    X[227]=getgenv().LocalPlayer
    L=function()task.wait(0.2)
        I()
        local a9 = getgenv().WV_Settings
        if a9 and a9.Textures then getgenv().WV_applyTextures()
        end
        if a9 and a9.Weather then getgenv().WV_startWeather(a9.WeatherType,a9.WeatherColor,a9.WeatherRate)
        end
    end
    if X[227] and X[227].CharacterAdded then X[227].CharacterAdded:Connect(L) end
    X[2246]=getgenv().Visuals_Self_SubTab
    X[2245]={}
    X[2245].Name="particle aura"
    X[2245].Position="left"
    X[117]=(X[2246]:AddSection(X[2245]))
    X[2248]=getgenv().Visuals_Self_SubTab
    X[2247]={}
    X[2247].Name="gun material"
    X[2247].Position="right"
    X[27]=(X[2248]:AddSection(X[2247]))
    X[2249]=getgenv()
    X[2251]=getgenv().Visuals_World_SubTab
    X[2250]={}
    X[2250].Name="lighting & time"
    X[2250].Position="left"
    X[2249].LightingTimeSection = (X[2251]:AddSection(X[2250]))
    X[2253]=getgenv()
    X[2255]=getgenv().Visuals_World_SubTab
    X[2254]={}
    X[2254].Name="atmosphere"
    X[2254].Position="left"
    X[2253].AtmosphereSection = (X[2255]:AddSection(X[2254]))
    X[2257]=getgenv()
    X[2259]=getgenv().Visuals_World_SubTab
    X[2258]={}
    X[2258].Name="weather & skybox"
    X[2258].Position="right"
    X[2257].WeatherSkySection = (X[2259]:AddSection(X[2258]))
    X[2261]=getgenv()
    X[2263]=getgenv().Visuals_World_SubTab
    X[2262]={}
    X[2262].Name="world textures"
    X[2262].Position="right"
    X[2261].TexturesSection = (X[2263]:AddSection(X[2262]))
    X[2265]="particle aura"
    X[127]=(X[117]:AddLabel(X[2265]))
    X[127]:AddToggle({
        Default = false,
        Flag = "PA_Enabled_Flag",
        Callback = function(I)getgenv().PA_Toggle(I)
            end,
    })
    X[127]:AddColorPicker({
        Default = Color3.fromRGB(133,220,255),
        Flag = "PA_Color_Flag",
        Callback = function(I)getgenv().PA_Color=I
                if getgenv().PA_Enabled then getgenv().PA_Apply()
                end
            end,
    })
    X[2268] = "aura type"
    X[2270]=X[117]:AddLabel(X[2268])
    X[2269]={}
    X[2269].Default="angel"
    local I,Y,A,K,f,C,l,Z,h,m,M=X[2270],X[2269],{},"starlight","heavenly","ribbon","sakura","angel","wind","flow","star"
    N:jq(A,0,K,f,C,l,Z,h,m,M)
    Y.Values=A
    Y.Flag = "PA_CurrentAura_Flag"
    Y.Callback=function(A)getgenv().PA_CurrentAura=A
        if getgenv().PA_Enabled then getgenv().PA_Apply()
        end
    end
    I:AddDropdown(Y)
    X[2272]="gun material"
    X[73]=(X[27]:AddLabel(X[2272]))
    X[73]:AddToggle({
        Default = false,
        Flag = "GunMat_Enabled_Flag",
        Callback = function(I)P.Enabled=I
                v()
            end,
    })
    X[73]:AddColorPicker({
        Default = Color3.fromRGB(217,204,83),
        Flag = "GunMat_Color_Flag",
        Callback = function(I)P.Color=I
                if P.Enabled then v()
                end
            end,
    })
    X[2275] = "material type"
    X[2277]=X[27]:AddLabel(X[2275])
    X[2276]={}
    X[2276].Default="Neon"
    local I,Y,A,K,f,C,l,Z,d,c,e,j,B,u=X[2277],X[2276],{},"Neon","ForceField","Glass","SmoothPlastic","Metal","Concrete","Brick","Marble","Slate","Plastic","Wood"
    N:jq(A,0,K,f,C,l,Z,d,c,e,j,B,u)
    Y.Values=A
    Y.Flag = "GunMat_Material_Flag"
    Y.Callback=function(A)P.Material=A
        if P.Enabled then v()
        end
    end
    I:AddDropdown(Y)
    X[13]=(getgenv())
    X[51]={Enabled=false,Filled=false}
    X[51].Color = (Color3.fromRGB(255,255,255))
    X[51].SpinEnabled=false
    X[51].SpinSpeed=10
    X[13].ChinaHatConfig=X[51]
    local P,v={},0
    local function Y()local A=P
        for C,Z in pairs(A)do local A=222157443
            C=A
            local e
            e,A=pcall,N:Aq(C+136226114)
            e(function()Z:Destroy()
            end)
        end
        P={}
    end
    if getgenv().LocalPlayer then getgenv().LocalPlayer.CharacterRemoving:Connect(Y)
    end
    local function A(C)local Z=getgenv().LocalPlayer
        local e=Z and Z.Character
        Z=e and e:FindFirstChild("Head")
        if not Z then Y()
            return
        end
        local B,G,s,W,n,V=1.8,0.9,32,getgenv().ChinaHatConfig.Color,getgenv().ChinaHatConfig.Filled,getgenv().ChinaHatConfig.SpinEnabled
        if V then e=v
            v=e+getgenv().ChinaHatConfig.SpinSpeed*C*5
        end
        e=Z.CFrame.Position+Vector3.new(0,0.6,0)
        V,Z,C=e+Vector3.new(0,G,0),n and s or 128,#P
        if C~=Z then Y()
        end
        while true do C=#P
            if not(C<Z)then break
            end
            local F=Instance.new(n and "WedgePart"or "Part")
            F.Anchored=true
            F.CanCollide=false
            F.CastShadow=false
            F.Material=Enum.Material.Neon
            F.TopSurface=Enum.SurfaceType.Smooth
            F.BottomSurface=Enum.SurfaceType.Smooth
            F.Parent=workspace
            table.insert(P,F)
        end
        if n then for n=1,s,1 do C,Z=(n-1)/s*3.141592653589793*2+v,n/s*3.141592653589793*2+v
                local F,o,T=e+Vector3.new(math.cos(C)*B,0,math.sin(C)*B),e+Vector3.new(math.cos(Z)*B,0,math.sin(Z)*B),P[n]
                local C,Z=(F-o).Magnitude,(F+o)/2
                o=(Z-e).Magnitude
                F=T and T:IsA("WedgePart")
                if F then T.Size=Vector3.new(C,G,o)
                    n=(Z-e).Unit
                    local C=e+Vector3.new(0,0.45,0)+n*(o/2)
                    T.CFrame=CFrame.lookAt(C,C+n)
                    T.Color=W
                end
            end
        else for C=1,s,1 do local Z=(C-1)/s*3.141592653589793*2+v
                local n,F=e+Vector3.new(math.cos(Z)*B,0,math.sin(Z)*B),P[C]
                local C,Z,o=(V+n)/2,(V-n).Magnitude,F and F:IsA("Part")
                if o then F.Size=Vector3.new(0.06,0.06,Z)
                    F.CFrame=CFrame.lookAt(C,n)
                    F.Color=W
                end
            end
            local C=33
            for Z=1,3,1 do local n=Z/3
                local V,F=B*(1-n),G*n
                n=e+Vector3.new(0,F,0)
                for e=1,s,1 do Z,F=(e-1)/s*3.141592653589793*2+v,e/s*3.141592653589793*2+v
                    local v,e,B=n+Vector3.new(math.cos(Z)*V,0,math.sin(Z)*V),n+Vector3.new(math.cos(F)*V,0,math.sin(F)*V),P[C]
                    local Z,G,s=(v+e)/2,(v-e).Magnitude,B and B:IsA("Part")
                    if s then B.Size=Vector3.new(0.06,0.06,G)
                    B.CFrame=CFrame.lookAt(Z,e)
                    B.Color=W
                end
                C+=1
            end
        end
    end
end
X[168]=p
X[2280]="RunService"
X[168]:GetService(X[2280]).RenderStepped:Connect(function(v)local C=getgenv().ChinaHatConfig and getgenv().ChinaHatConfig.Enabled
    if C then A(v)
    else local v=#P
        if v>0 then Y()
        end
    end
end)
X[2281]=getgenv()
X[2283]=getgenv().Visuals_Self_SubTab
X[2282]={}
X[2282].Name="china hat"
X[2282].Position="left"
X[2281].ChinaHatSection = (X[2283]:AddSection(X[2282]))
X[2285]=getgenv()
X[2285].china_hat_lbl = (getgenv().ChinaHatSection:AddLabel("china hat"))
X[2288]=getgenv().china_hat_lbl
X[2288]:AddToggle({
    Default = false,
    Flag = "ChinaHat_Enabled",
    Callback = function(P)getgenv().ChinaHatConfig.Enabled=P
    end,
})
X[2290]=getgenv().china_hat_lbl
X[2290]:AddColorPicker({
    Default = Color3.fromRGB(255,255,255),
    Flag = "ChinaHat_Color",
    Callback = function(P)getgenv().ChinaHatConfig.Color=P
    end,
})
X[2291]=getgenv()
X[2291].china_filled_lbl = (getgenv().ChinaHatSection:AddLabel("filled"))
X[2294]=getgenv().china_filled_lbl
X[2294]:AddToggle({
    Default = false,
    Flag = "ChinaHat_Filled",
    Callback = function(P)getgenv().ChinaHatConfig.Filled=P
    end,
})
X[2295]=getgenv()
X[2295].china_spin_lbl = (getgenv().ChinaHatSection:AddLabel("spin"))
X[2298]=getgenv().china_spin_lbl
X[2298]:AddToggle({
    Default = false,
    Flag = "ChinaHat_Spin",
    Callback = function(P)getgenv().ChinaHatConfig.SpinEnabled=P
    end,
})
X[2299]=getgenv()
X[2299].china_spinspeed_lbl = (getgenv().ChinaHatSection:AddLabel("spin speed"))
X[2302]=getgenv().china_spinspeed_lbl
X[2302]:AddSlider({
    Min = 0.1,
    Max = 10,
    Rounding = 1,
    Default = 10,
    Flag = "ChinaHat_SpinSpeed",
    Callback = function(P)getgenv().ChinaHatConfig.SpinSpeed=P
    end,
})
X[2303]=getgenv()
X[2305]=getgenv().WV_Settings
if not X[2305]then X[2304]={}
    X[2304].LightingMode=false
    X[2304].LightingType="shadowmap"
    X[2304].WorldTime=false
    X[2304].WorldTimeHour=4.5
    X[2304].Atmosphere=false
    X[2304].AtmosphereColor=Color3.fromRGB(255,255,255)
    X[2304].AtmosphereDecay=Color3.fromRGB(120,120,120)
    X[2304].AtmosphereHaze=1
    X[2304].AtmosphereGlare=10
    X[2304].AtmosphereOffset=0
    X[2304].AtmosphereDensity=0.35
    X[2304].Textures=false
    X[2304].TexturePack="minecraft"
    X[2304].Ambient=false
    X[2304].AmbientColor=getgenv().WV_origAmbient or Color3.fromRGB(128,128,128)
    X[2304].OutdoorColor=getgenv().WV_origOutdoor or Color3.fromRGB(128,128,128)
    X[2304].Weather=false
    X[2304].WeatherColor=Color3.fromRGB(255,255,255)
    X[2304].WeatherType="rain"
    X[2304].WeatherRate=100
    X[2304].Skybox=false
    X[2304].SkyboxType="realistic"
    X[2305]=X[2304]
end
X[2303].WV_Settings = X[2305]
local P=getgenv().WV_Settings
getgenv().WV_UpdateVisuals=function()local v={}
    if not P then return
    end
    if P.LightingMode then local Y=({compatibility=Enum.Technology.Compatibility,shadowmap=Enum.Technology.ShadowMap,future=Enum.Technology.Future,voxel=Enum.Technology.Voxel})[P.LightingType]or Enum.Technology.ShadowMap
        if getgenv().WV_Lighting.Technology~=Y then getgenv().WV_Lighting.Technology=Y
        end
    elseif getgenv().WV_Lighting.Technology~=getgenv().WV_origTechnology then getgenv().WV_Lighting.Technology=getgenv().WV_origTechnology
        end
        if P.WorldTime then if getgenv().WV_Lighting.ClockTime~=P.WorldTimeHour then getgenv().WV_Lighting.ClockTime=P.WorldTimeHour
            end
        end
        if P.Ambient then if getgenv().WV_Lighting.Ambient~=P.AmbientColor then getgenv().WV_Lighting.Ambient=P.AmbientColor
            end
            if getgenv().WV_Lighting.OutdoorAmbient~=P.OutdoorColor then getgenv().WV_Lighting.OutdoorAmbient=P.OutdoorColor
            end
        end
        local Y=P.Atmosphere
        if Y then local A=not getgenv().WV_atmosphere or not getgenv().WV_atmosphere.Parent
            if A then getgenv().WV_atmosphere = (Instance.new("Atmosphere"))
                getgenv().WV_atmosphere.Parent=getgenv().WV_Lighting
            end
            getgenv().WV_atmosphere.Color=P.AtmosphereColor
            getgenv().WV_atmosphere.Decay=P.AtmosphereDecay
            getgenv().WV_atmosphere.Haze=P.AtmosphereHaze
            getgenv().WV_atmosphere.Glare=P.AtmosphereGlare
            getgenv().WV_atmosphere.Offset=P.AtmosphereOffset
            getgenv().WV_atmosphere.Density=P.AtmosphereDensity
        elseif getgenv().WV_atmosphere then getgenv().WV_atmosphere:Destroy()
                getgenv().WV_atmosphere=nil
            end
            Y=P.Skybox
            if Y then local v,Y=getgenv().WV_Lighting:FindFirstChildOfClass("Sky"),getgenv().WV_skyboxes[P.SkyboxType]
                if not v or Y and v.SkyboxBk~=Y.SkyboxBk then getgenv().WV_applySkybox(P.SkyboxType)
                end
            else getgenv().WV_restoreSkybox()
            end
        end
        if getgenv().WV_HeartbeatConn then getgenv().WV_HeartbeatConn:Disconnect()
        end
        getgenv().WV_HeartbeatConn=w.Heartbeat:Connect(getgenv().WV_UpdateVisuals)
        X[82]=getgenv().LocalPlayer
        X[19]=function()task.wait(0.2)
            getgenv().WV_UpdateVisuals()
            local P = getgenv().WV_Settings
            if P and P.Textures then getgenv().WV_applyTextures()
            end
            if P and P.Weather then getgenv().WV_startWeather(P.WeatherType,P.WeatherColor,P.WeatherRate)
            end
        end
        if X[82] and X[82].CharacterAdded then X[82].CharacterAdded:Connect(X[19]) end
        X[158]=(getgenv().LightingTimeSection:AddLabel("lighting mode"))
        X[158]:AddToggle({
            Default = P.LightingMode,
            Flag = "WV_LightingMode_Flag",
            Callback = function(w)P.LightingMode=w
                        getgenv().WV_UpdateVisuals()
                    end,
        })
        X[229]=getgenv().LightingTimeSection
        X[2308] = "mode"
        local w,v,Y,A,C,Z,e=X[229]:AddLabel(X[2308]),{Default=P.LightingType},{},"compatibility","shadowmap","future","voxel"
        N:jq(Y,0,A,C,Z,e)
        v.Values=Y
        v.Flag = "WV_LightingType_Flag"
        v.Callback=function(Y)P.LightingType=Y
            getgenv().WV_UpdateVisuals()
        end
        w:AddDropdown(v)
        S=(getgenv().LightingTimeSection:AddLabel("world time"))
        S:AddToggle({
            Default = P.WorldTime,
            Flag = "WV_WorldTime_Flag",
            Callback = function(v)P.WorldTime=v
                        if not v then getgenv().WV_Lighting.ClockTime=getgenv().WV_origClockTime
                        else getgenv().WV_UpdateVisuals()
                        end
                    end,
        })
        X[2312]=getgenv().LightingTimeSection:AddLabel("hour")
        X[2312]:AddSlider({
            Min = 0,
            Max = 24,
            Rounding = 1,
            Default = P.WorldTimeHour,
            Flag = "WV_WorldTimeHour_Flag",
            Callback = function(v)P.WorldTimeHour=v
                        getgenv().WV_UpdateVisuals()
                    end,
        })
        X[191]=(getgenv().LightingTimeSection:AddLabel("ambient"))
        X[191]:AddToggle({
            Default = P.Ambient,
            Flag = "WV_Ambient_Flag",
            Callback = function(v)P.Ambient=v
                        if not v then getgenv().WV_Lighting.Ambient=getgenv().WV_origAmbient
                            getgenv().WV_Lighting.OutdoorAmbient=getgenv().WV_origOutdoor
                        else getgenv().WV_UpdateVisuals()
                        end
                    end,
        })
        X[191]:AddColorPicker({
            Default = P.AmbientColor,
            Flag = "WV_AmbientColor_Flag",
            Callback = function(v)P.AmbientColor=v
                        getgenv().WV_UpdateVisuals()
                    end,
        })
        X[191]:AddColorPicker({
            Default = P.OutdoorColor,
            Flag = "WV_OutdoorColor_Flag",
            Callback = function(v)P.OutdoorColor=v
                        getgenv().WV_UpdateVisuals()
                    end,
        })
        h=(getgenv().AtmosphereSection:AddLabel("atmosphere"))
        h:AddToggle({
            Default = P.Atmosphere,
            Flag = "WV_Atmosphere_Flag",
            Callback = function(v)P.Atmosphere=v
                        getgenv().WV_UpdateVisuals()
                    end,
        })
        h:AddColorPicker({
            Default = P.AtmosphereColor,
            Flag = "WV_AtmColor_Flag",
            Callback = function(v)P.AtmosphereColor=v
                        getgenv().WV_UpdateVisuals()
                    end,
        })
        h:AddColorPicker({
            Default = P.AtmosphereDecay,
            Flag = "WV_AtmDecay_Flag",
            Callback = function(v)P.AtmosphereDecay=v
                        getgenv().WV_UpdateVisuals()
                    end,
        })
        X[2320]=getgenv().AtmosphereSection:AddLabel("haze")
        X[2320]:AddSlider({
            Min = 0,
            Max = 10,
            Rounding = 3,
            Default = P.AtmosphereHaze,
            Flag = "WV_AtmHaze_Flag",
            Callback = function(v)P.AtmosphereHaze=v
                        getgenv().WV_UpdateVisuals()
                    end,
        })
        X[2322]=getgenv().AtmosphereSection:AddLabel("glare")
        X[2322]:AddSlider({
            Min = 0,
            Max = 10,
            Rounding = 3,
            Default = P.AtmosphereGlare,
            Flag = "WV_AtmGlare_Flag",
            Callback = function(v)P.AtmosphereGlare=v
                        getgenv().WV_UpdateVisuals()
                    end,
        })
        X[2324]=getgenv().AtmosphereSection:AddLabel("offset")
        X[2324]:AddSlider({
            Min = 0,
            Max = 1,
            Rounding = 3,
            Default = P.AtmosphereOffset,
            Flag = "WV_AtmOffset_Flag",
            Callback = function(v)P.AtmosphereOffset=v
                        getgenv().WV_UpdateVisuals()
                    end,
        })
        X[2326]=getgenv().AtmosphereSection:AddLabel("density")
        X[2326]:AddSlider({
            Min = 0,
            Max = 1,
            Rounding = 3,
            Default = P.AtmosphereDensity,
            Flag = "WV_AtmDensity_Flag",
            Callback = function(v)P.AtmosphereDensity=v
                        getgenv().WV_UpdateVisuals()
                    end,
        })
        X[100]=(getgenv().WeatherSkySection:AddLabel("weather"))
        X[100]:AddToggle({
            Default = P.Weather,
            Flag = "WV_Weather_Flag",
            Callback = function(v)P.Weather=v
                        if v then getgenv().WV_startWeather(P.WeatherType,P.WeatherColor,P.WeatherRate)
                        else getgenv().WV_stopWeather()
                        end
                    end,
        })
        X[100]:AddColorPicker({
            Default = P.WeatherColor,
            Flag = "WV_WeatherColor_Flag",
            Callback = function(v)P.WeatherColor=v
                        if getgenv().WV_weatherParticle then getgenv().WV_weatherParticle.Color=ColorSequence.new(v)
                        end
                    end,
        })
        X[172]=getgenv().WeatherSkySection
        X[2329] = "weather type"
        local v,Y,C,h,e,B=X[172]:AddLabel(X[2329]),{Default=P.WeatherType},{},"light rain","rain","snow"
        N:jq(C,0,h,e,B)
        Y.Values=C
        Y.Flag = "WV_WeatherType_Flag"
        Y.Callback=function(C)P.WeatherType=C
            if P.Weather then getgenv().WV_startWeather(C,P.WeatherColor,P.WeatherRate)
            end
        end
        v:AddDropdown(Y)
        X[2332]=getgenv().WeatherSkySection:AddLabel("rate")
        X[2332]:AddSlider({
            Min = 1,
            Max = 100,
            Rounding = 0,
            Default = P.WeatherRate,
            Flag = "WV_WeatherRate_Flag",
            Callback = function(v)P.WeatherRate=v
                        if getgenv().WV_weatherParticle then local Y=getgenv().WV_weatherTypes[P.WeatherType]
                            if Y then getgenv().WV_weatherParticle.Rate=Y.Rate*(v/100)
                            end
                        end
                    end,
        })
        X[2334]=getgenv().WeatherSkySection:AddLabel("skybox")
        X[2334]:AddToggle({
            Default = P.Skybox,
            Flag = "WV_Skybox_Flag",
            Callback = function(v)P.Skybox=v
                        getgenv().WV_UpdateVisuals()
                    end,
        })
        X[54]=getgenv().WeatherSkySection
        e="sky"
        X[2335]=e
        local v,Y,C,e,B,G,s,W=X[54]:AddLabel(X[2335]),{Default=P.SkyboxType},{},"realistic","Minecraft","blue space","pink","black storm"
        N:jq(C,0,e,B,G,s,W)
        Y.Values=C
        Y.Flag = "WV_SkyboxType_Flag"
        Y.Callback=function(C)P.SkyboxType=C
            if P.Skybox then getgenv().WV_applySkybox(C)
            end
        end
        v:AddDropdown(Y)
        X[2338]=getgenv().TexturesSection:AddLabel("textures")
        X[2338]:AddToggle({
            Default = P.Textures,
            Flag = "WV_Textures_Flag",
            Callback = function(v)P.Textures=v
                        if v then local v=476250513
                            local Y=v
                            getgenv().WV_applyTextures()
                            local C
                            C,v=getgenv,N:Aq(Y+524557901)
                            if C().WV_textureConn then getgenv().WV_textureConn:Disconnect()
                            end
                            C,Y=nil
                            C,Y,v=getgenv(),workspace.DescendantAdded,N:Aq(v-397529676)
                            C.WV_textureConn=Y:Connect(function(v)getgenv().WV_applyTexture(v)
                            end)
                        else if getgenv().WV_textureConn then getgenv().WV_textureConn:Disconnect()
                                getgenv().WV_textureConn=nil
                            end
                            getgenv().WV_removeTextures()
                        end
                    end,
        })
        X[14]=getgenv().TexturesSection
        l="pack"
        X[2339]=l
        local v,Y,C,l=X[14]:AddLabel(X[2339]),{Default=P.TexturePack},{},"minecraft"
        N:jq(C,0,l)
        Y.Values=C
        Y.Flag = "WV_TexturePack_Flag"
        Y.Callback=function(C)P.TexturePack=C
            getgenv().WV_currentTexturePack=C
            if P.Textures then getgenv().WV_removeTextures()
                getgenv().WV_applyTextures()
            end
        end
        v:AddDropdown(Y)
        getgenv().FFMapConfig={Enabled=false,Color=Color3.fromRGB(0,170,255),ChangeColor=true,Transparency=0,CachedParts={}}
        local function P(Y)local C=Y:IsA("BasePart")
            if not C then return
            end
            if Y.Transparency>=0.95 and Y.CanCollide==false then return
            end
            if not getgenv().FFMapConfig.CachedParts[Y]then getgenv().FFMapConfig.CachedParts[Y]={Material=Y.Material,Color=Y.Color,Transparency=Y.Transparency}
            end
            Y.Material=Enum.Material.ForceField
            if getgenv().FFMapConfig.ChangeColor then Y.Color=getgenv().FFMapConfig.Color
            end
            Y.Transparency=getgenv().FFMapConfig.Transparency
        end
        local function Y()local C=473304691
            local l=C
            local e=workspace:FindFirstChild("FFA_MAP")or workspace:FindFirstChild("Map")
            if not e then return
            end
            local B=ipairs
            C=N:Aq(l+431849845)
            for l,l in B(e:GetDescendants())do P(l)
            end
            if getgenv().FFMapConn then getgenv().FFMapConn:Disconnect()
                getgenv().FFMapConn=nil
            end
            C,getgenv().FFMapConn=N:Aq(C-222715639),e.DescendantAdded:Connect(function(C)if getgenv().FFMapConfig.Enabled then local l=96800023
                    local e=l
                    local B=task
                    l=N:Aq(e+116760530)
                    l=N:Aq(l+415827507)
                    B.defer(function()P(C)
                end)
            end
        end)
    end
    getgenv().restoreForcefieldMap=function()if getgenv().FFMapConn then getgenv().FFMapConn:Disconnect()
            getgenv().FFMapConn=nil
        end
        for P,C in pairs(getgenv().FFMapConfig.CachedParts)do if P and P.Parent then local l=500825469
                local e=l
                local B
                B,l=pcall,N:Aq(e+165635511)
                B(function()P.Material=C.Material
                    P.Color=C.Color
                    P.Transparency=C.Transparency
                end)
            end
        end
        getgenv().FFMapConfig.CachedParts={}
    end
    X[104]=(getgenv().TexturesSection:AddLabel("forcefield map"))
    X[104]:AddToggle({
        Default = false,
        Flag = "WV_FFMap_Toggle",
        Callback = function(P)getgenv().FFMapConfig.Enabled=P
                if P then Y()
                else getgenv().restoreForcefieldMap()
                end
            end,
    })
    X[104]:AddColorPicker({
        Default = Color3.fromRGB(0,170,255),
        Flag = "WV_FFMap_Color",
        Callback = function(P)getgenv().FFMapConfig.Color=P
                if getgenv().FFMapConfig.Enabled and getgenv().FFMapConfig.ChangeColor then for Y,C in pairs(getgenv().FFMapConfig.CachedParts)do if Y and Y.Parent then Y.Color=P
                        end
                    end
                end
            end,
    })
    X[2344]=getgenv().TexturesSection:AddLabel("custom color")
    X[2344]:AddToggle({
        Default = true,
        Flag = "WV_FFMap_CustomColor",
        Callback = function(P)getgenv().FFMapConfig.ChangeColor=P
                if getgenv().FFMapConfig.Enabled then if not P then for P,Y in pairs(getgenv().FFMapConfig.CachedParts)do if P and P.Parent then P.Color=Y.Color
                        end
                    end
                else for P,Y in pairs(getgenv().FFMapConfig.CachedParts)do if P and P.Parent then P.Color=getgenv().FFMapConfig.Color
                        end
                    end
                end
            end
        end,
    })
X[2346]=getgenv().TexturesSection:AddLabel("forcefield transparency")
X[2346]:AddSlider({
    Min = 0,
    Max = 0.95,
    Rounding = 2,
    Default = 0,
    Flag = "WV_FFMap_Transparency",
    Callback = function(P)getgenv().FFMapConfig.Transparency=P
        if getgenv().FFMapConfig.Enabled then for Y,C in pairs(getgenv().FFMapConfig.CachedParts)do if Y and Y.Parent then Y.Transparency=P
                end
            end
        end
    end,
})
pcall(function()local P=p
    local Y=P:GetService("ReplicatedStorage"):WaitForChild("MainEvent",10)
    if Y then getgenv().MainEvent=Y
    end
end)
task.wait(1)
X[22]=getgenv
S=X[22]().Players
j=function(P)local Y={}
    for C=#Config.ForceHit.TargetQueue,1,-1 do if Config.ForceHit.TargetQueue[C]==P then table.remove(Config.ForceHit.TargetQueue,C)
        end
    end
    if Config.ForceHit.Target==P then         Config.ForceHit.Target = nil
    end
    for Y=#getgenv().target_players,1,-1 do if getgenv().target_players[Y]==P.Name then table.remove(getgenv().target_players,Y)
        end
    end
    task.wait(0.1)
    getgenv().update_player_list_glue()
    getgenv().update_player_list_fh()
end
S.PlayerRemoving:Connect(j)
E=getgenv
X[166]=E().Players
u=function(P)task.wait(0.5)
    getgenv().update_player_list_glue()
    getgenv().update_player_list_fh()
end
X[166].PlayerAdded:Connect(u)
X[2347]=getgenv()
X[2347].Base64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
X[179]=getgenv
a=function(P)local E=78496693
    local Y=E
    local C=string.gsub
    E=bit32.bxor(Y,493114114)
    P=(C(P,"[^"..getgenv().Base64Chars.."=]",""))
    local function E(l)local e=l=="="
        if e then return "" end
        local e,B="",getgenv().Base64Chars:find(l)-1
        for l=6,1,-1 do local G=e
            local s=B%2^l-B%2^(l-1)>0 and "1"or "0"
            e=G..s
        end
        return e
    end
    C=(P:gsub(".",E))
    Y="%d%d%d%d%d%d%d%d"
    local function P(E)local l=0
        for e=1,8,1 do local B=E:sub(e,e)=="1"and 2^(8-e)or 0
            l=l+B
        end
        return string.char(l)
    end
    return(C:gsub(Y,P))
end
X[2349]=X[179]()
X[2349].Base64Decode=a
X[2350]=getgenv()
X[2350].TargetIconData = (getgenv().Base64Decode("iVBORw0KGgoAAAANSUhEUgAAAB0AAAAdCAMAAABhTZc9AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAPUExURQAAAP///wwMDP39/QAAAJn0DigAAAAFdFJOU/////8A+7YOUwAAAAlwSFlzAABLlgAAS5YBPIKNxAAAABh0RVh0U29mdHdhcmUAUGFpbnQuTkVUIDUuMS4y+7wDtgAAALZlWElmSUkqAAgAAAAFABoBBQABAAAASgAAABsBBQABAAAAUgAAACgBAwABAAAAAgAAADEBAgAQAAAAWgAAAGmHBAABAAAAagAAAAAAAAD7fwcA6AMAAPt/BwDoAwAAUGFpbnQuTkVUIDUuMS4yAAMAAJAHAAQAAAAwMjMwAaADAAEAAAABAAAABaAEAAEAAACUAAAAAAAAAAIAAQACAAQAAABSOTgAAgAHAAQAAAAwMTAwAAAAAFgdiCkiK10LAAAAZ0lEQVQ4T+XT0QqAMAgF0Gv5/9/cdJrXPYweopeEoe5MGKOgHMDSR/aAiPSNyBaGnT9S4Oi3pnqOtuEqE5kfaiHxG8pYTJoHrMzdzFu1h0qt57oLH58a/YhFfUU/4s967tT/Iv4mVS+LEAmXjonxPAAAAABJRU5ErkJggg=="))
X[2352]=getgenv()
X[2352].PixelImageData = (getgenv().Base64Decode("iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII="))
X[2354]=getgenv()
X[2354].ShadowImageData = (getgenv().Base64Decode("iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXUpAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAABh0RVh0U29mdHdhcmUAUGFpbnQuTkVUIDUuMS4y+7wDtgAAAZVJREFUeF7t29FKA0EMBuE9vP9bpxfS6oIuun9mIclgMIdA8p7mU+bCAn9gC+wF9gJ7gb3AXmAvsBfYC+wF9gJ7gb3AXmAvsBfYC+wF9gJ7gb3AXmAvsBfYC+wF9gJ7gb3AXuAfL/B8fT9ez9f68vj6Pj9fXyfrW8pTytR6SlvKz8n6P6S8/pP9P99PlfeXqfP+NnXer+nrvM7H8Z6Wf/v93Nf7GfbzOdaT9T+fW0/Wv31P2/f8tXW/19bX99L/WdtfX96vl+vL+2X9er2+vV+ur9fb9+X9ur6+P69P18fV9f10fby9fH9eX66vr+vX5+vr6/v1+fT5+u1X9+b96pW9f78X/p7/rX+/9/b//d/W//X/9v+V1v/3f5fX//f/V1v9b/9/2/7+/9v+eFvep/frffre7u/P99L7pXfvefve7939/frM99PrfW/38+v1vtfX93X/+frv12++en++vn771XfX/fXdr75699V37/3p/dL7pffvfb6X3i+9v78393dvX3v7uXff/ez7v7v/+73N///f/v//AXZ/EAL7Z9gKAAA="))
getgenv().ServerPositionIndicatorConfig={Enabled=true,Smooth=true,Color=Color3.fromRGB(78,127,252),IconColor=Color3.fromRGB(255,255,255),GlowColor=Color3.fromRGB(0,0,0),Transparency=0.8,Offset=Vector3.new(0,0.5,0)}
local P,E,Y,C
X[2356]=getgenv()
X[2357]=identifyexecutor and identifyexecutor()=="Wave"and create_fake_drawing or function(l,e)P=Drawing.new(l)
    if e then for B,G in pairs(e)do E=304103071
            l=E
            B=nil
            B,E=pcall,N:Aq(bit32.band(1624229773,l)+bit32.band(1624229773,283121917)+(bit32.band(1046507750,(bit32.bor(l,283121917)))+bit32.band(1624229774,(bit32.bxor(l,283121917)))))
            B(function()P[Y]=C
            end)
        end
    end
    return P
end
X[2356].CreateDrawing=X[2357]
X[2358]=getgenv()
X[2360]=getgenv().CreateDrawing
X[2361]="Image"
X[2359]={}
X[2359]["Color"]=getgenv().ServerPositionIndicatorConfig.GlowColor
X[2359]["Transparency"]=0
X[2359]["ZIndex"]=1
X[2359]["Visible"]=false
X[2359]["Data"]=getgenv().ShadowImageData
X[2359]["Rounding"]=36
X[2358].SV_Glow = (X[2360](X[2361],X[2359]))
X[2363]=getgenv()
X[2365]=getgenv().CreateDrawing
X[2366]="Circle"
X[2364]={}
X[2364]["Thickness"]=0
X[2364]["Color"]=Color3.fromRGB(0,0,0)
X[2364]["Filled"]=true
X[2364]["ZIndex"]=2
X[2364]["Visible"]=false
X[2363].SV_Outline = (X[2365](X[2366],X[2364]))
X[2368]=getgenv()
X[2370]=getgenv().CreateDrawing
X[2371]="Image"
X[2369]={}
X[2369]["Color"]=getgenv().ServerPositionIndicatorConfig.Color
X[2369]["Transparency"]=0
X[2369]["ZIndex"]=3
X[2369]["Visible"]=false
X[2369]["Data"]=getgenv().PixelImageData
X[2369]["Rounding"]=30
X[2368].SV_Circle = (X[2370](X[2371],X[2369]))
X[2373]=getgenv()
X[2375]=getgenv().CreateDrawing
X[2376]="Image"
X[2374]={}
X[2374]["Color"]=getgenv().ServerPositionIndicatorConfig.IconColor
X[2374]["Transparency"]=0
X[2374]["ZIndex"]=4
X[2374]["Visible"]=false
X[2374]["Data"]=getgenv().TargetIconData
X[2373].SV_Image = (X[2375](X[2376],X[2374]))
getgenv().SV_SetVisibility=function(P)getgenv().SV_Circle.Visible=P
    getgenv().SV_Image.Visible=P
    getgenv().SV_Glow.Visible=P
    getgenv().SV_Outline.Visible=P
end
getgenv().SV_CurrentOpacity=0
getgenv().SV_UpdateOpacity=function(P,E)getgenv().SV_CurrentOpacity=getgenv().SV_CurrentOpacity+(P-getgenv().SV_CurrentOpacity)*math.clamp(E*12,0,1)
    getgenv().SV_Circle.Transparency=getgenv().SV_CurrentOpacity*getgenv().ServerPositionIndicatorConfig.Transparency
    getgenv().SV_Image.Transparency=getgenv().SV_CurrentOpacity
    getgenv().SV_Glow.Transparency=getgenv().SV_CurrentOpacity*0.91
    getgenv().SV_Outline.Transparency=getgenv().SV_CurrentOpacity
end
getgenv().SV_LastPos=nil
getgenv().SV_Connection=getgenv().RunService.RenderStepped:Connect(function(P)if getgenv().Unloaded then getgenv().SV_Circle:Destroy()
        getgenv().SV_Image:Destroy()
        getgenv().SV_Glow:Destroy()
        getgenv().SV_Outline:Destroy()
        return
    end
    local E=if getgenv().ServerPositionIndicatorConfig.DesyncEnabled and Config.Desync and Config.Desync.enabled and Config.Desync.target_position then Config.Desync.target_position.Position else if getgenv().ServerPositionIndicatorConfig.DesyncEnabled and Config.ForceHit and Config.ForceHit.Enabled and Config.ForceHit.Active and Config.ForceHit.StrafeEnabled and Config.ForceHit.strafespoof and Config.ForceHit.CurrentStrafeCF then Config.ForceHit.CurrentStrafeCF.Position else if getgenv().ServerPositionIndicatorConfig.GlueEnabled and getgenv().glue_active and getgenv().GlueVis and getgenv().GlueVis.Enabled and getgenv().GlueVis.IndicatorEnabled and getgenv().GlueVis_LastDestination then getgenv().GlueVis_LastDestination.Position else if getgenv().ServerPositionIndicatorConfig.FakePosEnabled and getgenv().PhysicsRepDesyncEnabled and getgenv().FakePosServerPos then getgenv().FakePosServerPos else nil
                    if not E then getgenv().SV_UpdateOpacity(0,P)
                    if getgenv().SV_CurrentOpacity<0.05 then getgenv().SV_SetVisibility(false)
                end
                getgenv().SV_LastPos=nil
                if not(getgenv().ServerPositionIndicatorConfig.DesyncEnabled or getgenv().ServerPositionIndicatorConfig.GlueEnabled or getgenv().ServerPositionIndicatorConfig.FakePosEnabled)then getgenv().SV_SetVisibility(false)
                end
                return
            end
            local Y,C=workspace.CurrentCamera:WorldToViewportPoint(E)
            if not C then getgenv().SV_UpdateOpacity(0,P)
                if getgenv().SV_CurrentOpacity<0.05 then getgenv().SV_SetVisibility(false)
                end
                return
            end
            if getgenv().FlashbackConn then local l=247007957
                C=l
                local e=pcall
                l=N:Aq(bit32.band(1347066376,C)+bit32.band(1347066376,159583344)+(bit32.band(2947900921,(bit32.bor(C,159583344)))+bit32.band(2947900919,(bit32.band(C,159583344)))))
                local function l()getgenv().FlashbackConn:Disconnect()
                end
                e(l)
                getgenv().FlashbackConn=nil
            end
            if getgenv().FlashbackConfig then getgenv().FlashbackConfig.Enabled=false
                getgenv().FlashbackConfig.SavedCF=nil
            end
            if getgenv().ServerPositionIndicatorConfig.Smooth then if not getgenv().SV_LastPos then getgenv().SV_LastPos=Y
                end
                Y=getgenv().SV_LastPos+(Y-getgenv().SV_LastPos)*math.clamp(P*16,0,1)
            end
            getgenv().SV_LastPos=Y
            C=workspace.CurrentCamera:WorldToViewportPoint(E+getgenv().ServerPositionIndicatorConfig.Offset)
            local E,l=math.clamp((Y.Y-C.Y)*10,35,45),Vector2.new(Y.X,Y.Y)
            getgenv().SV_Circle.Color=getgenv().ServerPositionIndicatorConfig.Color
            getgenv().SV_Circle.Size=Vector2.new(E,E)
            getgenv().SV_Circle.Position=l-Vector2.new(E/2,E/2)
            getgenv().SV_Outline.Radius=E/2+2
            getgenv().SV_Outline.Position=l
            C=Vector2.new(E*0.6,E*0.6)
            getgenv().SV_Image.Position=l-C/2
            getgenv().SV_Image.Size=C
            C=Vector2.new(E*1.08,E*1.08)
            getgenv().SV_Glow.Position=l-C/2
            getgenv().SV_Glow.Size=C
            getgenv().SV_UpdateOpacity(1,P)
            getgenv().SV_SetVisibility(true)
        end)
        X[186]=getgenv().ScriptConnections
        if X[186]then X[2378]=getgenv().ScriptConnections
            X[2379]="ServerPositionIndicator"
            X[2378][X[2379]] = getgenv().SV_Connection
        else local P=getgenv().Unload
            getgenv().Unload=function()local E=422763815
                local Y=getgenv()
                E=N:Aq(bit32.band(1639166069,E)+bit32.band(1639166069,502287038)+(bit32.band(2655801228,(bit32.bor(E,502287038)))+bit32.band(2655801226,(bit32.band(E,502287038)))))
                if Y.SV_Connection then local C=516854260
                    local l
                    l,C=pcall,bit32.bxor(C,286184787)
                    l(function()getgenv().SV_Connection:Disconnect()
                end)
            end
            Y=nil
            Y,E=pcall,bit32.bxor(E,294053964)
            Y(function()if getgenv().SV_Circle then getgenv().SV_Circle:Destroy()
                end
                if getgenv().SV_Image then getgenv().SV_Image:Destroy()
                end
                if getgenv().SV_Glow then getgenv().SV_Glow:Destroy()
                end
                if getgenv().SV_Outline then getgenv().SV_Outline:Destroy()
                end
            end)
            if P then P()
            end
        end
    end
    X[218]=(getgenv())
    X[58]={Enabled=false}
    X[58].Color = (Color3.fromRGB(255,255,255))
    X[58].RateMultiplier=1
    X[218].ToolAuraConfig=X[58]
    getgenv().ActiveToolAuraParticles=getgenv().ActiveToolAuraParticles or{}
    local function P()for E,Y in ipairs(getgenv().ActiveToolAuraParticles)do if Y and Y.Parent then local C=428855856
                E=C
                local l
                l,C=pcall,N:Aq(E+119502252)
                l(function()Y:Destroy()
                end)
            end
        end
        getgenv().ActiveToolAuraParticles={}
    end
    local function E()local Y,C=ipairs,getgenv().ActiveToolAuraParticles
        for l,e in Y(C)do l=e and e:IsA("ParticleEmitter")
            if l then local Y=42798208
                local C=Y
                local l
                l,Y=pcall,N:Aq(bit32.band(871899904,C)+bit32.band(871899904,30617659)+(bit32.band(3423067393,(bit32.bor(C,30617659)))+bit32.band(3423067391,(bit32.band(C,30617659)))))
                l(function()e.Color=ColorSequence.new(getgenv().ToolAuraConfig.Color)
                end)
            end
        end
    end
    local function Y(C)local l={}
        local e=11948808
        local B=e
        if not getgenv().ToolAuraConfig.Enabled then return
        end
        local G=Instance.new("ParticleEmitter")
        l[1]="rbxassetid://10927170198"
        G.Texture=l[1]
        G.LightEmission=-5
        G.Brightness=10
        G.ZOffset=1
        e=N:Aq(B+394263318)
        G.LightInfluence=0
        G.Orientation=Enum.ParticleOrientation.VelocityPerpendicular
        local l,B,s=ColorSequence.new,getgenv
        s,e=B().ToolAuraConfig,N:Aq(e-76602961)
        G.Color=l(s.Color)
        G.EmissionDirection=Enum.NormalId.Top
        G.Lifetime=NumberRange.new(0.5)
        G.Rotation=NumberRange.new(0,360)
        G.RotSpeed=NumberRange.new(1250)
        G.Speed=NumberRange.new(0.165)
        G.SpreadAngle=Vector2.new(-360,360)
        pcall(function()G.Shape=Enum.ParticleEmitterShape.Box
            G.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
            G.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
        end)
        G.Rate=49*getgenv().ToolAuraConfig.RateMultiplier
        G.Enabled=true
        G.Parent=C
        table.insert(getgenv().ActiveToolAuraParticles,G)
    end
    local function C(l)P()
        if not getgenv().ToolAuraConfig.Enabled then return
        end
        local e=l:FindFirstChild("Handle")or l:FindFirstChildWhichIsA("BasePart")
        if not e then return
        end
        Y(e)
    end
    local function Y(l)local e=522465336
        local B=e
        local G=not l
        e=N:Aq(B+382904943)
        if G then return
        end
        local B,G
        e=N:Aq(e-120097703)
        local function e(s)local W="Tool"
            if s:IsA(W)then local W=119266591
                local n=W
                local V=task
                W=bit32.bxor(n,450833150)
                n=V.defer
                W=N:Aq(bit32.band(216377690,W)+bit32.band(216377690,52585885)+(bit32.band(3862211916,(bit32.bor(W,52585885)))+bit32.band(216377691,(bit32.bxor(W,52585885)))))
                n(function()C(s)
                end)
            end
        end
        B=l.ChildAdded:Connect(e)
        local function s(W)local n="Tool"
            if W:IsA(n)then P()
            end
        end
        G=l.ChildRemoved:Connect(s)
        e=(l:FindFirstChildOfClass("Tool"))
        if e then C(e)
        end
        local function e()if B then B:Disconnect()
            end
            if G then G:Disconnect()
            end
            P()
        end
        l.Destroying:Connect(e)
    end
    if getgenv().Players.LocalPlayer.Character then task.spawn(Y,getgenv().Players.LocalPlayer.Character)
    end
    getgenv().Players.LocalPlayer.CharacterAdded:Connect(Y)
    X[2382]=getgenv()
    X[2384]=getgenv().Visuals_Self_SubTab
    X[2383]={}
    X[2383].Name="tool aura"
    X[2383].Position="right"
    X[2382].ToolAuraSection = (X[2384]:AddSection(X[2383]))
    do X[48]=(getgenv())
        X[231]={Enabled=false,FollowTarget=false}
        X[231].Color = (Color3.fromRGB(255,255,255))
        X[231].Size=28
        X[231].Speed=110
        X[231].FollowDistance=45
        X[231].AnimationSpeed=0.13
        X[48].OnekoConfig=X[231]
        local Y="NLAssets/oneko.png"
        local l="https://files.catbox.moe/twwjix.png"
        task.spawn(function()local e=not isfolder("NLAssets")
            if e then makefolder("NLAssets")
            end
            e=not isfile(Y)
            if e then local e=request or http_request or syn and syn.request or http and http.request
                if e then local B=e
                    local e={}
                    e.Url=l
                    e.Method="GET"
                    local G=B(e)
                    if G and G.Body then writefile(Y,G.Body)
                end
            else local e=p
                local B=e.HttpGet
                if B then e=p
                    local B=e:HttpGet(l)
                    if B then writefile(Y,B)
                end
            end
        end
    end
end)
if getgenv().OnekoGui then pcall(function()getgenv().OnekoGui:Destroy()
    end)
end
X[2387]=getgenv()
X[2387].OnekoGui = (Instance.new("ScreenGui"))
X[2389]=getgenv().OnekoGui
X[2389].Name = "OnekoCat"
getgenv().OnekoGui.ResetOnSpawn=false
getgenv().OnekoGui.IgnoreGuiInset=true
X[212]=not pcall(function()local l,e,B=getgenv().OnekoGui,gethui and gethui()
    if e then B=e
    else local e=p
        B=(e:GetService("CoreGui"))
    end
    l.Parent=B
end)
if X[212]then X[2391]=getgenv().OnekoGui
    X[2391].Parent = (getgenv().LocalPlayer:WaitForChild("PlayerGui"))
end
local l=Instance.new("ImageLabel")
l.Name = "Cat"
l.BackgroundTransparency=1
l.Size=UDim2.fromOffset(getgenv().OnekoConfig.Size,getgenv().OnekoConfig.Size)
l.AnchorPoint=Vector2.new(0.5,0.5)
l.ImageColor3=getgenv().OnekoConfig.Color
l.ImageRectSize=Vector2.new(32,32)
l.Visible=false
l.Parent=getgenv().OnekoGui
task.spawn(function()task.wait(0.2)
    if isfile(Y)then local e=getcustomasset or getsynasset
        if e then l.Image=e(Y)
        end
    end
end)
local Y={idle={{3,3}},N={{1,2},{1,3}},NE={{0,2},{0,3}},E={{3,0},{3,1}},SE={{5,1},{5,2}},S={{6,3},{7,2}},SW={{5,3},{6,1}},W={{4,2},{4,3}},NW={{1,0},{1,1}},tired={{3,2}},sleeping={{2,0},{2,1}},scratchSelf={{5,0},{6,0},{7,0}}}
local e=workspace.CurrentCamera
local B=e.ViewportSize/2
local G,s,W,n,V="idle",1,0,0
local F=1
local function o(T,b)local i=Y[T]
    if not i then return
    end
    T=i[(b-1)%#i+1]
    l.ImageRectOffset=Vector2.new(T[1]*32,T[2]*32)
end
local function T(b)local i=G~=b
    if i then G,s,W=b,1,0
        o(b,1)
    end
end
local function b(i,k)local y=math.deg(math.atan2(-k,i))
    k=y>=-22.5 and y<22.5
    if k then return "E"
    else local i=y>=22.5 and y<67.5
        if i then return "NE"
        else local i=y>=67.5 and y<112.5
            if i then return "N"
            else local i=y>=112.5 and y<157.5
                if i then return "NW"
                else local i=y>=157.5 or y<-157.5
                    if i then return "W"
                else local i=y>=-157.5 and y<-112.5
                    if i then return "SW"
                else local i=y>=-112.5 and y<-67.5
                    if i then return "S"
                else return "SE"
                end
            end
        end
    end
end
end
end
end
o("idle",1)
if getgenv().OnekoConnection then getgenv().OnekoConnection:Disconnect()
end
getgenv().OnekoConnection=getgenv().RunService.RenderStepped:Connect(function(i)local k={}
    if getgenv().Unloaded then if getgenv().OnekoGui then getgenv().OnekoGui:Destroy()
        end
        if getgenv().OnekoConnection then getgenv().OnekoConnection:Disconnect()
        end
        return
    end
    if not getgenv().OnekoConfig.Enabled then l.Visible=false
        return
    end
    l.Visible=true
    l.ImageColor3=getgenv().OnekoConfig.Color
    l.Size=UDim2.fromOffset(getgenv().OnekoConfig.Size,getgenv().OnekoConfig.Size)
    local y
    local J=getgenv().OnekoConfig.FollowTarget
    if J then local U=Config.ForceHit and Config.ForceHit.Target or getgenv().KillAura and getgenv().KillAura.CurrentTarget or CurrentLegitTarget
        local O=U and U.Character
        if O then local O=U.Character:FindFirstChild("Head")or U.Character:FindFirstChild("HumanoidRootPart")
            if O then local U,D=e:WorldToViewportPoint(O.Position)
                y=if D then Vector2.new(U.X,U.Y)else y
                end
            end
        end
        J=y or getgenv().UserInputService:GetMouseLocation()
        local y=J-B
        J=y.Magnitude
        local U=J>getgenv().OnekoConfig.FollowDistance
        if U then n,V,F=0,nil,1
            local O,D,z=y.Unit,math.min(getgenv().OnekoConfig.Speed*i,J-getgenv().OnekoConfig.FollowDistance),B
            B=z+O*D
            T((b(y.X,y.Y)))
            W+=i
            D=W
            z=D>=getgenv().OnekoConfig.AnimationSpeed
            if z then W=0
                s+=1
                D,O=Y[G]
                if D then local b=s
                    O=b>#D
                else O=D
                end
                if O then s=1
                end
                o(G,s)
            end
        else T("idle")
            n+=i
            local G=not V and n>3
            if G then local s=math.random()<0.01
                if s then k[1]=math.random(1,2)==1 and "sleeping"or "scratchSelf"
                    V=k[1]
                    F=1
                    W=0
                end
            end
            G=V
            if G then W+=i
                local G=W
                local s=G>=getgenv().OnekoConfig.AnimationSpeed
                if s then W=0
                    F+=1
                    local s,W=Y[V]
                    if s then G=F
                    W=G>#s*6
                else W=s
                end
                if W then V,F=nil,1
                    o("idle",1)
                elseif s then o(V,math.ceil(F/6))
                end
            end
        end
    end
    U,i=e.ViewportSize,getgenv().OnekoConfig.Size/2
    B=Vector2.new(math.clamp(B.X,i,U.X-i),math.clamp(B.Y,i,U.Y-i))
    l.Position=UDim2.fromOffset(B.X,B.Y)
end)
X[2394]=getgenv()
X[2396]=getgenv().Visuals_Self_SubTab
X[2395]={}
X[2395].Name="cursor pet"
X[2395].Position="right"
X[2394].OnekoSection = (X[2396]:AddSection(X[2395]))
X[2398]=getgenv()
X[2398].oneko_toggle_lbl = (getgenv().OnekoSection:AddLabel("oneko cat"))
X[2401]=getgenv().oneko_toggle_lbl
X[2401]:AddToggle({
    Default = false,
    Flag = "Oneko_Enabled",
    Callback = function(Y)getgenv().OnekoConfig.Enabled=Y
        if not Y then l.Visible=false
        end
    end,
})
X[2403]=getgenv().oneko_toggle_lbl
X[2403]:AddColorPicker({
    Default = Color3.fromRGB(255,255,255),
    Flag = "Oneko_Color",
    Callback = function(Y)getgenv().OnekoConfig.Color=Y
    end,
})
X[2404]=getgenv()
X[2404].oneko_target_lbl = (getgenv().OnekoSection:AddLabel("follow target"))
X[2407]=getgenv().oneko_target_lbl
X[2407]:AddToggle({
    Default = false,
    Flag = "Oneko_FollowTarget",
    Callback = function(Y)getgenv().OnekoConfig.FollowTarget=Y
    end,
})
X[2409]=getgenv().OnekoSection:AddLabel("follow speed")
X[2409]:AddSlider({
    Min = 50,
    Max = 350,
    Rounding = 0,
    Default = 110,
    Flag = "Oneko_Speed",
    Callback = function(Y)getgenv().OnekoConfig.Speed=Y
    end,
})
X[2411]=getgenv().OnekoSection:AddLabel("follow distance")
X[2411]:AddSlider({
    Min = 10,
    Max = 150,
    Rounding = 0,
    Default = 45,
    Flag = "Oneko_Distance",
    Callback = function(Y)getgenv().OnekoConfig.FollowDistance=Y
    end,
})
end
X[2412]=getgenv()
X[2412].tool_aura_lbl = (getgenv().ToolAuraSection:AddLabel("tool aura"))
X[2415]=getgenv().tool_aura_lbl
X[2414]={}
X[2414].Default=false
X[2414].Flag="ToolAura_Enabled"
local Y,l=X[2415],X[2414]
l.Callback=function(e)getgenv().ToolAuraConfig.Enabled=e
    if e then local e=getgenv().LocalPlayer.Character
        local B=e and e:FindFirstChildOfClass("Tool")
        if B then C(B)
        end
    else P()
    end
end
Y:AddToggle(l)
X[2417]=getgenv().tool_aura_lbl
X[2417]:AddColorPicker({
    Default = Color3.fromRGB(255,255,255),
    Flag = "ToolAura_Color",
    Callback = function(P)getgenv().ToolAuraConfig.Color=P
        E()
    end,
})
X[227]=getgenv().ToolAuraSection
X[2418] = "aura rate multiplier"
X[2420]=X[227]:AddLabel(X[2418])
X[2419]={}
X[2419].Min=0.1
X[2419].Max=5
X[2419].Rounding=1
X[2419].Default=1
X[2419].Flag="Visuals_ToolAura_RateMultiplier"
local P,E=X[2420],X[2419]
E.Callback=function(Y)getgenv().ToolAuraConfig.RateMultiplier=Y
    Y=getgenv().LocalPlayer.Character
    local l=Y and Y:FindFirstChildOfClass("Tool")
    if l then C(l)
    end
end
P:AddSlider(E)
do r=(getgenv())
    X[2421]={}
    X[2421].Enabled=false
    X[2421].Mode="Mouse"
    X[115]=X[2421]
    X[115].Color = (Color3.fromRGB(255,255,255))
    r.CharizardConfig=X[115]
    local P,E=80,0.045
    local Y,r=-45,0
    local C="https://files.catbox.moe/ujwejs.png"
    local l,e,B,G,s,W="NLAssets/charizard_sprite_2d.png",1040,910,130,8,51
    local function n()local V=getcustomasset or getsynasset
        local F=not V
        if F then return "" end
        F=not isfolder("NLAssets")
        if F then makefolder("NLAssets")
        end
        F=not isfile(l)
        if F then local F=request or http_request or syn and syn.request or http and http.request
            if F then local o=F
                local F={}
                F.Url=C
                F.Method="GET"
                local T=o(F)
                if T and T.Body then writefile(l,T.Body)
                end
            else local F=p
                local o=F.HttpGet
                if o then local o=495725326
                    F=o
                    local T
                    T,o=pcall,N:Aq(F+387179023)
                    local F,o=T(function()local T=p
                    return T:HttpGet(C)
                end)
                if F and o then writefile(l,o)
                end
            end
        end
    end
    if isfile(l)then return V(l)
    end
    return ""
end
if getgenv().CharizardGui then pcall(function()getgenv().CharizardGui:Destroy()
    end)
    getgenv().CharizardGui=nil
end
X[2423]=getgenv()
X[2423].CharizardGui = (Instance.new("ScreenGui"))
X[2425]=getgenv().CharizardGui
X[2425].Name = "NL_Charizard2D"
getgenv().CharizardGui.ResetOnSpawn=false
getgenv().CharizardGui.IgnoreGuiInset=true
a=not pcall(function()local C,l,V=getgenv().CharizardGui,gethui and gethui()
    if l then V=l
    else local l=p
        V=(l:GetService("CoreGui"))
    end
    C.Parent=V
end)
if a then X[2427]=getgenv().CharizardGui
    X[2427].Parent = (getgenv().LocalPlayer:WaitForChild("PlayerGui"))
end
local a=Instance.new("Frame")
a.Name = "CharizardHolder"
a.BackgroundTransparency=1
a.BorderSizePixel=0
a.ClipsDescendants=true
a.AnchorPoint=Vector2.new(0.5,0.5)
a.Size=UDim2.fromOffset(P,P)
a.Visible=false
a.Parent=getgenv().CharizardGui
local C=Instance.new("ImageLabel")
C.Name = "Sheet"
C.BackgroundTransparency=1
C.BorderSizePixel=0
C.ResampleMode=Enum.ResamplerMode.Pixelated
C.ScaleType=Enum.ScaleType.Stretch
C.Position=UDim2.new(0,0,0,0)
C.Parent=a
task.spawn(function()task.wait(0.2)
    local l=n()
    local n=l~=""and C
    if n then C.Image=l
    end
end)
local l,n=0,0
if getgenv().CharizardConnection then getgenv().CharizardConnection:Disconnect()
    getgenv().CharizardConnection=nil
end
getgenv().CharizardConnection=getgenv().RunService.RenderStepped:Connect(function(V)if getgenv().Unloaded then if getgenv().CharizardGui then getgenv().CharizardGui:Destroy()
        end
        if getgenv().CharizardConnection then getgenv().CharizardConnection:Disconnect()
        end
        return
    end
    if not getgenv().CharizardConfig.Enabled then a.Visible=false
        return
    end
    local F
    local o,T=workspace.CurrentCamera,getgenv().CharizardConfig.Mode=="Follow Target"
    if T then local b=Config.ForceHit and Config.ForceHit.Target or getgenv().KillAura and getgenv().KillAura.CurrentTarget or CurrentLegitTarget
        local i=b and b.Character
        if i then local i=b.Character:FindFirstChild("Head")or b.Character:FindFirstChild("HumanoidRootPart")
            if i then local b,k=o:WorldToViewportPoint(i.Position+Vector3.new(0,1.5,0))
                F=if k then Vector2.new(b.X,b.Y)else F
                end
            end
        end
        T=not F and getgenv().CharizardConfig.Mode=="Above Tool"
        if T then local b=getgenv().LocalPlayer.Character
            local i=b and b:FindFirstChildOfClass("Tool")
            if i then b=i:FindFirstChild("Handle")or i:FindFirstChildWhichIsA("BasePart")
                if b then local i,k=o:WorldToViewportPoint(b.Position+Vector3.new(0,1.2,0))
                    F=if k then Vector2.new(i.X,i.Y)else F
                end
            end
        end
        T=not F and getgenv().CharizardConfig.Mode=="Shoulder"
        if T then local b=getgenv().LocalPlayer.Character
            local i=b and(b:FindFirstChild("RightUpperArm")or b:FindFirstChild("Right Arm")or b:FindFirstChild("UpperTorso"))
            if i then b=i.Position+Vector3.new(0,0.8,0)
                local i,k=o:WorldToViewportPoint(b)
                F=if k then Vector2.new(i.X,i.Y)else F
                end
            end
            if not F then o=getgenv().UserInputService:GetMouseLocation()
                F=Vector2.new(o.X,o.Y)
            end
            a.Visible=true
            C.ImageColor3=getgenv().CharizardConfig.Color
            a.Size=UDim2.fromOffset(P,P)
            a.Position=UDim2.fromOffset(F.X+r,F.Y+Y)
            n+=V
            while true do T=n
                if not(T>=E)then break
                end
                n-=E
                l+=1
                o=l>=W
                if o then l=0
                end
            end
            o,T,V=l%s,math.floor(l/s),P/G
            C.Size=UDim2.fromOffset(e*V,B*V)
            C.Position=UDim2.fromOffset(-o*P,-T*P)
        end)
        X[2431]=getgenv()
        X[2433]=getgenv().Visuals_Self_SubTab
        X[2432]={}
        X[2432].Name="charizard cursor"
        X[2432].Position="right"
        X[2431].CharizardSection = (X[2433]:AddSection(X[2432]))
        X[2435]=getgenv()
        X[2435].cz_toggle_lbl = (getgenv().CharizardSection:AddLabel("charizard pet"))
        X[2438]=getgenv().cz_toggle_lbl
        X[2438]:AddToggle({
            Default = false,
            Flag = "Charizard_Enabled",
            Callback = function(P)getgenv().CharizardConfig.Enabled=P
                        if not P then a.Visible=false
                        end
                    end,
        })
        X[2440]=getgenv().cz_toggle_lbl
        X[2440]:AddColorPicker({
            Default = Color3.fromRGB(255,255,255),
            Flag = "Charizard_Color",
            Callback = function(P)getgenv().CharizardConfig.Color=P
                    end,
        })
        X[190]=getgenv().CharizardSection
        X[2441] = "position mode"
        X[2443]=X[190]:AddLabel(X[2441])
        X[2442]={}
        X[2442].Default="Mouse"
        local P,a,E,Y,r,C,l=X[2443],X[2442],{},"Mouse","Above Tool","Follow Target","Shoulder"
        N:jq(E,0,Y,r,C,l)
        a.Values=E
        a.Flag = "Charizard_Mode"
        a.Callback=function(E)getgenv().CharizardConfig.Mode=E
        end
        P:AddDropdown(a)
    end
    X[197]=(getgenv())
    X[174]={Enabled=false}
    X[174].Color = (Color3.fromRGB(245,215,225))
    X[197].RTXConfig=X[174]
    getgenv().RTXOrigSettings={}
    getgenv().RTXTimeForceConn=nil
    getgenv().RTXDescAddedConn=nil
    X[205]=nil
    X[2446]=getgenv()
    X[205]=p
    X[2446].RTXLighting = (p:GetService("Lighting"))
    m=nil
    X[2448]=getgenv()
    m=p
    X[2448].RTXTweenService = (p:GetService("TweenService"))
    K=getgenv
    X[177]=function()if getgenv().RTXTimeForceConn then getgenv().RTXTimeForceConn:Disconnect()
            getgenv().RTXTimeForceConn=nil
        end
        if getgenv().RTXDescAddedConn then getgenv().RTXDescAddedConn:Disconnect()
            getgenv().RTXDescAddedConn=nil
        end
        local P,a=ipairs,table.pack(getgenv().RTXLighting:GetChildren())
        for E,Y in P(table.unpack(a))do E=Y.Name=="RTX_Sky"or Y.Name=="RTX_SunRays"or Y.Name=="RTX_Bloom"or Y.Name=="RTX_CC"or Y.Name=="RTX_Blur"or Y.Name=="RTX_DoF"
            if E then Y:Destroy()
            end
        end
        P,a=ipairs,table.pack(workspace:GetDescendants())
        for E,Y in P(table.unpack(a))do E=(Y:FindFirstChild("rtx_highlight"))
            if E then E:Destroy()
            end
            E=(Y:IsA("BasePart"))
            if E then local P=Y:FindFirstChild("RTX_Light")
                if P then P:Destroy()
                end
            end
        end
        if getgenv().RTXOrigSettings.Technology then getgenv().RTXLighting.Technology=getgenv().RTXOrigSettings.Technology
            getgenv().RTXLighting.ClockTime=getgenv().RTXOrigSettings.ClockTime
            getgenv().RTXLighting.Brightness=getgenv().RTXOrigSettings.Brightness
            getgenv().RTXLighting.GlobalShadows=getgenv().RTXOrigSettings.GlobalShadows
            getgenv().RTXLighting.EnvironmentDiffuseScale=getgenv().RTXOrigSettings.EnvironmentDiffuseScale
            getgenv().RTXLighting.EnvironmentSpecularScale=getgenv().RTXOrigSettings.EnvironmentSpecularScale
            getgenv().RTXLighting.Ambient=getgenv().RTXOrigSettings.Ambient
            getgenv().RTXLighting.OutdoorAmbient=getgenv().RTXOrigSettings.OutdoorAmbient
            getgenv().RTXLighting.FogColor=getgenv().RTXOrigSettings.FogColor
            getgenv().RTXLighting.FogStart=getgenv().RTXOrigSettings.FogStart
            getgenv().RTXLighting.FogEnd=getgenv().RTXOrigSettings.FogEnd
            getgenv().RTXLighting.ColorShift_Top=getgenv().RTXOrigSettings.ColorShift_Top
            getgenv().RTXLighting.ColorShift_Bottom=getgenv().RTXOrigSettings.ColorShift_Bottom
        end
    end
    X[2450]=K()
    X[2450].ClearRTX=X[177]
    q=getgenv
    X[113]=function(P)local a={}
        local E=P:IsA("BasePart")and not P:FindFirstChild("rtx_highlight")
        if E then local E=Instance.new("Highlight")
            a[1]="rtx_highlight"
            E.Name=a[1]
            E.Adornee=P
            E.DepthMode=Enum.HighlightDepthMode.Occluded
            E.FillTransparency=1
            E.OutlineTransparency=0.9
            E.OutlineColor=Color3.fromRGB(0,0,0)
            E.Parent=P
        end
    end
    X[2451]=q()
    X[2451].AddRTXHighlight=X[113]
    X[67]=getgenv
    H=function(P)local a={}
        local E=P:IsA("BasePart")and not P:FindFirstChild("RTX_Light")
        if E then local E=P.Name:lower()
            local Y=E:find("lamp")or E:find("light")or E:find("bulb")or E:find("neon")
            if Y then E=(Instance.new("PointLight"))
                a[1]="RTX_Light"
                E.Name=a[1]
                E.Brightness=2.8
                E.Range=20
                E.Color=Color3.fromRGB(255,235,210)
                E.Shadows=true
                E.Parent=P
            end
        end
    end
    X[2452]=X[67]()
    X[2452].AddRTXLamplight=H
    getgenv().UpdateRTXColor=function()if not getgenv().RTXConfig.Enabled then return
        end
        getgenv().RTXLighting.FogColor=getgenv().RTXConfig.Color
        local P=getgenv().RTXLighting:FindFirstChild("RTX_CC")
        local a=P and P:IsA("ColorCorrectionEffect")
        if a then P.TintColor=getgenv().RTXConfig.Color
        end
    end
    h=getgenv
    X[15]=function()local P={}
        local a=170006168
        local E=a
        getgenv().ClearRTX()
        getgenv().RTXOrigSettings.Technology=getgenv().RTXLighting.Technology
        local Y=getgenv
        a=N:Aq(E+35339128)
        Y().RTXOrigSettings.ClockTime=getgenv().RTXLighting.ClockTime
        getgenv().RTXOrigSettings.Brightness=getgenv().RTXLighting.Brightness
        getgenv().RTXOrigSettings.GlobalShadows=getgenv().RTXLighting.GlobalShadows
        getgenv().RTXOrigSettings.EnvironmentDiffuseScale=getgenv().RTXLighting.EnvironmentDiffuseScale
        getgenv().RTXOrigSettings.EnvironmentSpecularScale=getgenv().RTXLighting.EnvironmentSpecularScale
        getgenv().RTXOrigSettings.Ambient=getgenv().RTXLighting.Ambient
        getgenv().RTXOrigSettings.OutdoorAmbient=getgenv().RTXLighting.OutdoorAmbient
        getgenv().RTXOrigSettings.FogColor=getgenv().RTXLighting.FogColor
        getgenv().RTXOrigSettings.FogStart=getgenv().RTXLighting.FogStart
        getgenv().RTXOrigSettings.FogEnd=getgenv().RTXLighting.FogEnd
        getgenv().RTXOrigSettings.ColorShift_Top=getgenv().RTXLighting.ColorShift_Top
        getgenv().RTXOrigSettings.ColorShift_Bottom=getgenv().RTXLighting.ColorShift_Bottom
        getgenv().RTXLighting.Technology=Enum.Technology.Future
        getgenv().RTXLighting.ClockTime=18.5
        getgenv().RTXLighting.Brightness=2.2
        getgenv().RTXLighting.GlobalShadows=true
        getgenv().RTXLighting.EnvironmentDiffuseScale=0.8
        getgenv().RTXLighting.EnvironmentSpecularScale=1
        E=getgenv
        a=N:Aq(a+310080987)
        E().RTXLighting.Ambient=Color3.fromRGB(75,60,65)
        E,Y=nil
        E,Y,a=getgenv().RTXLighting,Color3.fromRGB,N:Aq(a-72747024)
        E.OutdoorAmbient=Y(120,100,105)
        getgenv().RTXLighting.FogColor=getgenv().RTXConfig.Color
        getgenv().RTXLighting.FogStart=0
        getgenv().RTXLighting.FogEnd=700
        getgenv().RTXLighting.ColorShift_Top=Color3.fromRGB(35,25,28)
        getgenv().RTXLighting.ColorShift_Bottom=Color3.fromRGB(20,15,18)
        P[1]=getgenv()
        P[2]=(getgenv().RTXLighting:GetPropertyChangedSignal("ClockTime"):Connect(function()if getgenv().RTXLighting.ClockTime~=18.5 then getgenv().RTXLighting.ClockTime=18.5
            end
        end))
        P[1].RTXTimeForceConn=P[2]
        E=(Instance.new("Sky"))
        P[3]="RTX_Sky"
        E.Name=P[3]
        Y="rbxassetid://160405144"
        E.SkyboxBk=Y
        E.SkyboxDn=Y
        E.SkyboxFt=Y
        E.SkyboxLf=Y
        E.SkyboxRt=Y
        E.SkyboxUp=Y
        E.MoonAngularSize=10
        E.SunAngularSize=12
        E.StarCount=2500
        E.CelestialBodiesShown=true
        E.Parent=getgenv().RTXLighting
        Y=(Instance.new("SunRaysEffect"))
        P[4]="RTX_SunRays"
        Y.Name=P[4]
        Y.Intensity=0
        Y.Spread=0.2
        Y.Parent=getgenv().RTXLighting
        E=(Instance.new("ColorCorrectionEffect"))
        P[5]="RTX_CC"
        E.Name=P[5]
        E.Contrast=0.08
        E.Saturation=0.05
        E.Brightness=0.01
        E.TintColor=getgenv().RTXConfig.Color
        E.Parent=getgenv().RTXLighting
        local a=Instance.new("BlurEffect")
        P[6]="RTX_Blur"
        a.Name=P[6]
        a.Size=0
        a.Parent=getgenv().RTXLighting
        local r=Instance.new("DepthOfFieldEffect")
        P[7]="RTX_DoF"
        r.Name=P[7]
        r.InFocusRadius=160
        r.FocusDistance=75
        r.NearIntensity=0.1
        r.FarIntensity=0.2
        r.Parent=getgenv().RTXLighting
        getgenv().RTXTweenService:Create(Y,TweenInfo.new(1),{Intensity=0.1}):Play()
        getgenv().RTXTweenService:Create(TweenInfo.new(1),{Intensity=0.4}):Play()
        Y,r=getgenv().RTXTweenService,TweenInfo
        local P,K=r.new(1),{Contrast=0.08,Saturation=0.05,Brightness=0.01}
        K.TintColor=getgenv().RTXConfig.Color
        Y:Create(E,P,K):Play()
        getgenv().RTXTweenService:Create(a,TweenInfo.new(1),{Size=1}):Play()
        for a,a in ipairs(workspace:GetDescendants())do getgenv().AddRTXHighlight(a)
            getgenv().AddRTXLamplight(a)
        end
        P,Y=getgenv(),workspace.DescendantAdded
        local function a(E)local r=371658834
            local K=r
            local C=task
            r=N:Aq(bit32.band(1651732670,K)+bit32.band(1651732670,525379157)+(bit32.band(2643234627,(bit32.bor(K,525379157)))+bit32.band(2643234625,(bit32.band(K,525379157)))))
            r=bit32.bxor(r,51551930)
            C.defer(function()if getgenv().RTXConfig.Enabled then getgenv().AddRTXHighlight(E)
                    getgenv().AddRTXLamplight(E)
                end
            end)
        end
        P.RTXDescAddedConn=Y:Connect(a)
    end
    X[2453]=h()
    X[2453].ApplyRTX=X[15]
    X[2454]=getgenv()
    X[2456]=getgenv().Visuals_World_SubTab
    X[2455]={}
    X[2455].Name="rtx"
    X[2455].Position="right"
    X[2454].RTXSection = (X[2456]:AddSection(X[2455]))
    X[2458]=getgenv()
    X[2458].rtx_lbl = (getgenv().RTXSection:AddLabel("rtx"))
    X[2461]=getgenv().rtx_lbl
    X[2461]:AddToggle({
        Default = false,
        Flag = "RTX_Enabled",
        Callback = function(P)getgenv().RTXConfig.Enabled=P
                if P then getgenv().ApplyRTX()
                else getgenv().ClearRTX()
                end
            end,
    })
    X[2463]=getgenv().rtx_lbl
    X[2463]:AddColorPicker({
        Default = Color3.fromRGB(245,215,225),
        Flag = "RTX_Color",
        Callback = function(P)getgenv().RTXConfig.Color=P
                getgenv().UpdateRTXColor()
            end,
    })
    q=nil
    X[2464]=getgenv()
    q=p
    X[2464].UIS = (p:GetService("UserInputService"))
    X[222]=nil
    X[2466]=getgenv()
    X[222]=p
    X[2466].Players = (p:GetService("Players"))
    getgenv().LocalPlayer=getgenv().Players.LocalPlayer
    j=getgenv().UIS.TouchEnabled and not getgenv().UIS.KeyboardEnabled and not getgenv().UIS.MouseEnabled
    if j then if getgenv().KeybindGui then pcall(function()getgenv().KeybindGui:Destroy()
            end)
            getgenv().KeybindGui=nil
        end
        X[2468]=getgenv()
        X[2468].KeybindGui = (Instance.new("ScreenGui"))
        X[2470]=getgenv().KeybindGui
        X[2470].Name = "NL_KeybindHUD"
        getgenv().KeybindGui.ResetOnSpawn=false
        getgenv().KeybindGui.DisplayOrder=999999
        getgenv().KeybindGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
        getgenv().KeybindGui.Enabled=getgenv().KeybindHUDVisible
        X[2472]=getgenv()
        X[2473]=table.pack(pcall(function()local P={}
            local a
            P[1]=getgenv().KeybindGui
            a=p
            P[2]=(p:GetService("CoreGui"))
            P[1].Parent=P[2]
        end))
        X[2472].ParentSuccess=X[2473][1]
        X[78]=X[2473][2]
        X[25]=not getgenv().ParentSuccess
        if X[25]then X[2474]=getgenv().KeybindGui
            X[2474].Parent = (getgenv().LocalPlayer:WaitForChild("PlayerGui"))
        end
        X[2476]=getgenv()
        X[2476].MobileFrame = (Instance.new("Frame"))
        X[2478]=getgenv().MobileFrame
        X[2478].Name = "KeybindHUD"
        getgenv().MobileFrame.Size=UDim2.new(0,135,0,42)
        getgenv().MobileFrame.Position=UDim2.new(0.85,0,0.3,0)
        getgenv().MobileFrame.BorderSizePixel=0
        getgenv().MobileFrame.ClipsDescendants=false
        getgenv().MobileFrame.ZIndex=100
        getgenv().MobileFrame.Parent=getgenv().KeybindGui
        X[2480]=getgenv()
        X[2480].MobileFrameCorner = (Instance.new("UICorner"))
        getgenv().MobileFrameCorner.Parent=getgenv().MobileFrame
        X[2482]=getgenv()
        X[2482].MobileFrameStroke = (Instance.new("UIStroke"))
        X[2484]=getgenv().MobileFrameStroke
        X[2484].Name = "MainStroke"
        getgenv().MobileFrameStroke.Parent=getgenv().MobileFrame
        X[2486]=getgenv()
        X[2486].MobileDecorator = (Instance.new("ImageLabel"))
        X[2488]=getgenv().MobileDecorator
        X[2488].Name = "KeybindDecorator"
        getgenv().MobileDecorator.Size=UDim2.fromOffset(127,100)
        getgenv().MobileDecorator.Position=UDim2.new(0.53,0,0,0)
        getgenv().MobileDecorator.AnchorPoint=Vector2.new(0.5,1)
        getgenv().MobileDecorator.BackgroundTransparency=1
        getgenv().MobileDecorator.BorderSizePixel=0
        getgenv().MobileDecorator.ZIndex=110
        getgenv().MobileDecorator.Parent=getgenv().MobileFrame
        task.spawn(function()local P=getgenv().getCatboxAsset("https://files.catbox.moe/rt4qz4.png")
            if P and getgenv().MobileDecorator then getgenv().MobileDecorator.Image=P
            end
        end)
        X[2490]=getgenv()
        X[2490].MobileAccentLine = (Instance.new("Frame"))
        X[2492]=getgenv().MobileAccentLine
        X[2492].Name = "Bar"
        getgenv().MobileAccentLine.Size=UDim2.new(1,-16,0,2)
        getgenv().MobileAccentLine.Position=UDim2.new(0,8,0,6)
        getgenv().MobileAccentLine.BorderSizePixel=0
        getgenv().MobileAccentLine.ZIndex=101
        getgenv().MobileAccentLine.Parent=getgenv().MobileFrame
        X[2494]=getgenv()
        X[2494].MobileAccentLineCorner = (Instance.new("UICorner"))
        getgenv().MobileAccentLineCorner.CornerRadius=UDim.new(0,1)
        getgenv().MobileAccentLineCorner.Parent=getgenv().MobileAccentLine
        X[2496]=getgenv()
        X[2496].MobileHeaderLabel = (Instance.new("TextLabel"))
        X[2498]=getgenv().MobileHeaderLabel
        X[2498].Name = "Header"
        getgenv().MobileHeaderLabel.Size=UDim2.new(1,-16,0,16)
        getgenv().MobileHeaderLabel.Position=UDim2.new(0,8,0,11)
        getgenv().MobileHeaderLabel.BackgroundTransparency=1
        getgenv().MobileHeaderLabel.TextXAlignment=Enum.TextXAlignment.Left
        X[2500]=getgenv().MobileHeaderLabel
        X[2500].Text = "keybinds"
        getgenv().MobileHeaderLabel.ZIndex=102
        getgenv().MobileHeaderLabel.Parent=getgenv().MobileFrame
        X[2502]=getgenv()
        X[2502].MobileHeaderStroke = (Instance.new("UIStroke"))
        getgenv().MobileHeaderStroke.LineJoinMode=Enum.LineJoinMode.Miter
        getgenv().MobileHeaderStroke.Color=Color3.fromRGB(0,0,0)
        getgenv().MobileHeaderStroke.Transparency=0.7
        getgenv().MobileHeaderStroke.Parent=getgenv().MobileHeaderLabel
        X[2504]=getgenv()
        X[2504].MobileScrollHolder = (Instance.new("ScrollingFrame"))
        X[2506]=getgenv().MobileScrollHolder
        X[2506].Name = "ScrollHolder"
        getgenv().MobileScrollHolder.Size=UDim2.new(1,-12,1,-34)
        getgenv().MobileScrollHolder.Position=UDim2.new(0,6,0,28)
        getgenv().MobileScrollHolder.BackgroundTransparency=1
        getgenv().MobileScrollHolder.BorderSizePixel=0
        getgenv().MobileScrollHolder.ScrollBarThickness=0
        getgenv().MobileScrollHolder.ZIndex=103
        getgenv().MobileScrollHolder.Parent=getgenv().MobileFrame
        X[2508]=getgenv()
        X[2508].MobileListLayout = (Instance.new("UIListLayout"))
        getgenv().MobileListLayout.Padding=UDim.new(0,5)
        getgenv().MobileListLayout.SortOrder=Enum.SortOrder.LayoutOrder
        getgenv().MobileListLayout.Parent=getgenv().MobileScrollHolder
        getgenv().MobileDragging=false
        getgenv().MobileDragInput=nil
        getgenv().MobileDragStart=nil
        getgenv().MobileStartPos=nil
        c=getgenv
        X[10]=c().MobileFrame
        X[62]=function(P)if P.UserInputType==Enum.UserInputType.Touch or P.UserInputType==Enum.UserInputType.MouseButton1 then local a=64500505
                local E=a
                getgenv().MobileDragging=true
                a=N:Aq(bit32.band(1290362307,E)+bit32.band(4294967295,136501899)+(bit32.band(2,(bit32.bor(E,136501899)))+(bit32.band(3004604988,4294967295)+bit32.band(1290362308,(bit32.bnot(E))))))
                getgenv().MobileDragStart=P.Position
                getgenv().MobileStartPos=getgenv().MobileFrame.Position
                E=nil
                E,a=P.Changed,bit32.bxor(a,2906003)
                E:Connect(function()if P.UserInputState==Enum.UserInputState.End then getgenv().MobileDragging=false
                end
            end)
        end
    end
    X[10].InputBegan:Connect(X[62])
    X[53]=getgenv
    X[128]=X[53]().MobileFrame
    X[182]=function(P)if P.UserInputType==Enum.UserInputType.Touch or P.UserInputType==Enum.UserInputType.MouseMovement then getgenv().MobileDragInput=P
        end
    end
    X[128].InputChanged:Connect(X[182])
    X[29]=getgenv
    X[134]=X[29]().UIS
    g=function(P)if P==getgenv().MobileDragInput and getgenv().MobileDragging then local a=P.Position-getgenv().MobileDragStart
            getgenv().MobileFrame.Position=UDim2.new(getgenv().MobileStartPos.X.Scale,getgenv().MobileStartPos.X.Offset+a.X,getgenv().MobileStartPos.Y.Scale,getgenv().MobileStartPos.Y.Offset+a.Y)
        end
    end
    X[134].InputChanged:Connect(g)
    X[178]=(getgenv())
    X[164]={}
    X[2510]={}
    X[2510].Name="force hit"
    X[2510].IsActive=function()return Config.ForceHit and Config.ForceHit.Active
    end
    X[2510].Trigger=function()local g={}
        if Config.ForceHit then             Config.ForceHit.Enabled = true
            Config.ForceHit.Active = not Config.ForceHit.Active
            if Config.ForceHit.Active then if not(Config.ForceHit.Target and Config.ForceHit.Target.Parent)then Config.ForceHit.Target = (getgenv().FH_GetClosest())
                end
            else                 Config.ForceHit.Target = nil
                if getgenv().TargetLine then getgenv().TargetLine.Visible=false
                end
                                Config.ForceHit.StrafeEnabled = false
            end
        end
    end
    X[189]=X[2510]
    X[2511]={}
    X[2511].Name="target strafe"
    X[2511].IsActive=function()return Config.ForceHit and Config.ForceHit.StrafeEnabled
    end
    X[2511].Trigger=function()local g={}
        if Config.ForceHit then local P=not Config.ForceHit.StrafeEnabled
                        Config.ForceHit.StrafeArmed = P
                        Config.ForceHit.StrafeEnabled = P
            if not P and getgenv().stopStrafe then getgenv().stopStrafe()
            end
        end
    end
    u=X[2511]
    X[2512]={}
    X[2512].Name="aimbot"
    X[2512].IsActive=function()return Config.Legit and Config.Legit.AimbotActive
    end
    X[2512].Trigger=function()local g={}
        if Config.Legit then             Config.Legit.AimbotEnabled = true
            Config.Legit.AimbotActive = not Config.Legit.AimbotActive
        end
    end
    X[27]=X[2512]
    X[2513]={}
    X[2513].Name="desync"
    X[2513].IsActive=function()return Config.Desync and Config.Desync.enabled
    end
    X[2513].Trigger=function()getgenv().Des_MasterEnabled=true
        if getgenv().setDesync then getgenv().setDesync(not(Config.Desync and Config.Desync.enabled))
        end
    end
    X[6]=X[2513]
    X[2514]={}
    X[2514].Name="glue"
    X[2514].IsActive=function()return getgenv().glue_active
    end
    X[2514].Trigger=function()getgenv().feature_enabled=true
        getgenv().glue_active=not getgenv().glue_active
        if getgenv().glue_active then if getgenv().use_unc_method then getgenv().unc_connection()
            else getgenv().no_unc_connection()
            end
        else if getgenv().connection_loop then getgenv().connection_loop:Disconnect()
                getgenv().connection_loop=nil
            end
            if getgenv().no_unc_loop then getgenv().no_unc_loop:Disconnect()
                getgenv().no_unc_loop=nil
            end
            if getgenv().reset_velocity then getgenv().reset_velocity()
            end
        end
    end
    X[28]=X[2514]
    X[2515]={}
    X[2515].Name="cframe speed"
    X[2515].IsActive=function()return Config.Misc and Config.Misc.CFrameSpeedActive
    end
    X[2515].Trigger=function()local g={}
        if Config.Misc then             Config.Misc.CFrameSpeedEnabled = true
            Config.Misc.CFrameSpeedActive = not Config.Misc.CFrameSpeedActive
        end
    end
    v=X[2515]
    X[2516]={}
    X[2516].Name="cframe fly"
    X[2516].IsActive=function()return Config.Misc and Config.Misc.CFrameFlyActive
    end
    X[2516].Trigger=function()local g={}
        if Config.Misc then             Config.Misc.CFrameFlyEnabled = true
            Config.Misc.CFrameFlyActive = not Config.Misc.CFrameFlyActive
        end
    end
    w=X[2516]
    X[2517]={}
    X[2517].Name="walkspeed"
    X[2517].IsActive=function()return Config.Misc and Config.Misc.WalkSpeedActive
    end
    X[2517].Trigger=function()local g={}
        if Config.Misc then             Config.Misc.WalkSpeedEnabled = true
            Config.Misc.WalkSpeedActive = not Config.Misc.WalkSpeedActive
        end
    end
    X[136]=X[2517]
    X[2518]={}
    X[2518].Name="auto heal(stomp)"
    X[2518].IsActive=function()return false
    end
    X[2518].Trigger=function()local g={}
        if Config.Misc then             Config.Misc.AutoHealEnabled = true
        end
        if getgenv().performManualStomp then getgenv().performManualStomp()
        end
    end
    L=X[2518]
    X[2519]={}
    X[2519].Name="force reset"
    X[2519].IsActive=function()return false
    end
    X[2519].Trigger=function()local g={}
        if Config.Misc then             Config.Misc.ForceReset = true
        end
        if getgenv().performReset then getgenv().performReset()
        end
    end
    X[169]=X[2519]
    N:jq(X[164],0,X[189],u,X[27],X[6],X[28],v,w,X[136],L,X[169])
    X[178].KeybindInspectors=X[164]
    getgenv().KeybindButtonInstances={}
    getgenv().createSubCardButton=function(g)local P={}
        local a=466041707
        local v=a
        local E=Instance.new("TextButton")
        P[1]="Btn_"..g.Name
        E.Name=P[1]
        E.Size=UDim2.new(1,0,0,32)
        E.BorderSizePixel=0
        E.Text=g.Name:lower()
        E.ZIndex=104
        E.Parent=getgenv().MobileScrollHolder
        local L=Instance.new("UICorner")
        P[2]="ButtonCorner"
        L.Name=P[2]
        L.Parent=E
        L=nil
        L,a=Instance.new,N:Aq(v+394922321)
        v=(L("UIStroke"))
        P[3]="BorderStroke"
        v.Name=P[3]
        a=N:Aq(a-124430100)
        v.Parent=E
        v=(Instance.new("UIStroke"))
        P[4]="TextStroke"
        v.Name=P[4]
        v.LineJoinMode=Enum.LineJoinMode.Miter
        v.Color=Color3.fromRGB(0,0,0)
        v.Transparency=0.7
        v.Parent=E
        local P=false
        local function a()local v=439250556
            local L=v
            local Y=P
            if Y then return
            end
            P=true
            local Y,r
            Y,r,v=pcall,g.Trigger,bit32.bxor(L,377207949)
            Y(r)
            r=nil
            r,v=task,N:Aq(bit32.band(120388533,v)+bit32.band(120388533,505251156)+(bit32.band(4174578764,(bit32.bor(v,505251156)))+bit32.band(4174578762,(bit32.band(v,505251156)))))
            r.delay(0.1,function()P=false
            end)
        end
        E.Activated:Connect(a)
        E.MouseButton1Down:Connect(a)
        return E
    end
    for g,g in ipairs(getgenv().KeybindInspectors)do if not getgenv().KeybindButtonInstances[g.Name]then getgenv().KeybindButtonInstances[g.Name]=getgenv().createSubCardButton(g)
        end
    end
    task.spawn(function()while task.wait(0.12)do local g=511335709
            local P=g
            local a
            a,g=getgenv,N:Aq(P+490224918)
            P=a().Unloaded
            g=N:Aq(g-245882816)
            if P then if getgenv().KeybindGui then getgenv().KeybindGui:Destroy()
                    getgenv().KeybindGui=nil
                end
                break
            end
            local function g()local P={}
                getgenv().CurrentTheme=getgenv().ActiveUITheme or{Main=Color3.fromRGB(8,8,13),Secondary=Color3.fromRGB(20,22,27),Input=Color3.fromRGB(26,28,36),Accent=Color3.fromRGB(78,127,252),Stroke=Color3.fromRGB(45,48,58),Text=Color3.fromRGB(255,255,255),CornerRadius=8,Font=Enum.Font.GothamMedium,BoldFont=Enum.Font.GothamBold,StrokeThickness=1,StrokeTransparency=0.65,BgTransparency=0.055,SecondaryTransparency=0.5}
                local a=getgenv().CurrentTheme
                if getgenv().MobileFrame then getgenv().MobileFrame.BackgroundColor3=a.Main
                    getgenv().MobileFrame.BackgroundTransparency=a.BgTransparency or 0.15
                end
                if getgenv().MobileFrameCorner then getgenv().MobileFrameCorner.CornerRadius=UDim.new(0,a.CornerRadius or 12)
                end
                if getgenv().MobileFrameStroke then getgenv().MobileFrameStroke.Color=a.Stroke
                    getgenv().MobileFrameStroke.Thickness=a.StrokeThickness or 1.2
                    getgenv().MobileFrameStroke.Transparency=a.StrokeTransparency or 0.88
                end
                if getgenv().MobileAccentLine then getgenv().MobileAccentLine.BackgroundColor3=a.Accent
                end
                local v=getgenv().MobileHeaderLabel
                if v then getgenv().MobileHeaderLabel.TextColor3=a.Text
                    getgenv().MobileHeaderLabel.Font=a.BoldFont or Enum.Font.GothamBold
                    getgenv().MobileHeaderLabel.TextSize=a.Font==Enum.Font.Code and 10 or 11
                    getgenv().MobileHeaderLabel.Text = "keybinds ("..tostring(#getgenv().KeybindInspectors)..")"
                end
                local P,E=ipairs,getgenv().KeybindInspectors
                for L,Y in P(E)do v=getgenv().KeybindButtonInstances[Y.Name]
                    if v then local P=40096481
                    L=P
                    local E=false
                    P=N:Aq(bit32.band(2117100538,L)+bit32.band(2117100538,217613588)+(bit32.band(60766220,(bit32.bor(L,217613588)))+bit32.band(2117100539,(bit32.bxor(L,217613588)))))
                    local P=pcall
                    local function L()E=Y.IsActive()
                end
                P(L)
                L=(v:FindFirstChild("ButtonCorner"))
                P=(v:FindFirstChild("BorderStroke"))
                v.Font=a.BoldFont or Enum.Font.GothamBold
                v.TextColor3=a.Text
                v.TextSize=a.Font==Enum.Font.Code and 10 or 11
                if L then L.CornerRadius=UDim.new(0,math.clamp(a.CornerRadius or 8,0,10))
                end
                if E then v.BackgroundColor3=a.Accent
                    v.BackgroundTransparency=0.2
                    if P then P.Color=a.Accent
                    P.Thickness=a.StrokeThickness or 1
                    P.Transparency=0.4
                end
            else v.BackgroundColor3=a.Secondary or Color3.fromRGB(24,24,28)
                v.BackgroundTransparency=a.SecondaryTransparency or 0.3
                if P then P.Color=a.Stroke
                    P.Thickness=a.StrokeThickness or 1
                    P.Transparency=a.StrokeTransparency or 0.85
                end
            end
        end
    end
    v=#getgenv().KeybindInspectors*37
    getgenv().TargetHeight=math.clamp(36+v,42,260)
    if getgenv().MobileListLayout then getgenv().MobileScrollHolder.CanvasSize=UDim2.new(0,0,0,getgenv().MobileListLayout.AbsoluteContentSize.Y)
    end
    if getgenv().MobileFrame then getgenv().MobileFrame.Size=UDim2.new(0,135,0,getgenv().TargetHeight)
    end
end
pcall(g)
end
end)
end
getgenv().AnimBreaker={Enabled=false,LagAmount=0,Jitter=0}
getgenv().AnimBreakerState=getgenv().AnimBreakerState or{Data={},TimeData={},LastUpdate=os.clock(),LastFreezeTick=os.clock(),LastFreeze=os.clock(),Freeze=false}
getgenv().globalAnimBreakerConn=getgenv().RunService.Heartbeat:Connect(function()local g=getgenv().AnimBreaker
    if not g or not g.Enabled then return
    end
    local P=getgenv().LocalPlayer.Character
    if not P then return
    end
    local a=P:FindFirstChildOfClass("Humanoid")
    if not a then return
    end
    P=os.clock()
    if P-getgenv().AnimBreakerState.LastUpdate>0.028 then getgenv().AnimBreakerState.LastUpdate=P
        local v=a:GetPlayingAnimationTracks()
        if g.LagAmount>0 then if P-getgenv().AnimBreakerState.LastFreezeTick>g.LagAmount then local a=352976545
                local E=a
                a,getgenv().AnimBreakerState.LastFreezeTick=N:Aq(E+525634873),P
                E=nil
                E,a=task,N:Aq(a+6275838)
                E.defer(function()getgenv().AnimBreakerState.LastFreeze=os.clock()
                end)
                getgenv().AnimBreakerState.Freeze=false
            else getgenv().AnimBreakerState.Freeze=true
            end
            for a,a in ipairs(v)do if not getgenv().AnimBreakerState.Freeze then getgenv().AnimBreakerState.Data[a]=a.TimePosition+(P-getgenv().AnimBreakerState.LastFreeze)
                else a.TimePosition=getgenv().AnimBreakerState.Data[a]or 0
                end
            end
        end
        for a,E in ipairs(v)do if not E.Looped then a=getgenv().AnimBreakerState.TimeData[E]
                if not a then getgenv().AnimBreakerState.TimeData[E]=P
                elseif P-a>E.Length then E:Stop()
                    getgenv().AnimBreakerState.TimeData[E]=nil
                end
            end
        end
        if g.Jitter>0 then for P,a in ipairs(v)do P=math.random()*(0.5+g.Jitter*3.5)+(1+g.Jitter/4)
                a.TimePosition=-a.TimePosition*P
            end
        end
    end
end)
X[2520]=getgenv()
X[2520].anim_breaker_enable_lbl = (getgenv().EmoteSection:AddLabel("animation lagger"))
X[2523]=getgenv().anim_breaker_enable_lbl
X[2523]:AddToggle({
    Default = false,
    Flag = "AnimBreaker_Enabled",
    Callback = function(g)getgenv().AnimBreaker.Enabled=g
        if not g then getgenv().AnimBreakerState.Data={}
            getgenv().AnimBreakerState.TimeData={}
        end
    end,
})
X[2524]=getgenv()
X[2524].anim_breaker_lag_lbl = (getgenv().EmoteSection:AddLabel("animation lag amount"))
X[2527]=getgenv().anim_breaker_lag_lbl
X[2527]:AddSlider({
    Min = 0,
    Max = 1,
    Rounding = 2,
    Default = 0,
    Flag = "AnimBreaker_LagAmount",
    Callback = function(g)getgenv().AnimBreaker.LagAmount=g
    end,
})
X[2528]=getgenv()
X[2528].anim_breaker_jitter_lbl = (getgenv().EmoteSection:AddLabel("emote speed"))
X[2531]=getgenv().anim_breaker_jitter_lbl
X[2531]:AddSlider({
    Min = 0,
    Max = 100,
    Rounding = 0,
    Default = 0,
    Flag = "AnimBreaker_JitterIntensity",
    Callback = function(g)getgenv().AnimBreaker.Jitter=g/100
    end,
})
workspace.FallenPartsDestroyHeight=-20000000000000
do X[2532]={}
    X[2534]="kirky"
    X[2533]={}
    X[2533].Url="https://files.catbox.moe/mqhwda.png"
    X[2533].Width=85
    X[2533].Height=145
    X[2533].Zoom=1
    X[2533].OffsetY=0
    X[2532][X[2534]]=X[2533]
    X[2536]="triple t"
    X[2535]={}
    X[2535].Url="https://files.catbox.moe/quo16r.png"
    X[2535].Width=95
    X[2535].Height=150
    X[2535].Zoom=1.35
    X[2535].OffsetY=0
    X[2532][X[2536]]=X[2535]
    X[2538]="localplayer"
    X[2537]={}
    X[2537].Url="LOCAL_PLAYER_AVATAR"
    X[2537].Width=85
    X[2537].Height=150
    X[2537].Zoom=1.45
    X[2537].OffsetY=-2
    X[2532][X[2538]]=X[2537]
    local g=X[2532]
    X[2539]=getgenv()
    X[2540]={}
    X[2540].Enabled=true
    X[2540].SelectedImage="triple t"
    X[2540].ImageWidth=95
    X[2540].ImageHeight=150
    X[2540].Zoom=1.35
    X[2540].OffsetY=0
    X[2539].ESPPreviewConfig = X[2540]
    X[2542]=getgenv().Config.Bars.Health
    X[2542].Position = getgenv().Config.Bars.Health.Position or "Left"
    if getgenv().ESPPreviewGui then pcall(function()getgenv().ESPPreviewGui:Destroy()
        end)
        getgenv().ESPPreviewGui=nil
    end
    if getgenv().EmbeddedPreviewMain then pcall(function()getgenv().EmbeddedPreviewMain:Destroy()
        end)
        getgenv().EmbeddedPreviewMain=nil
    end
    X[2544]=getgenv()
    X[2546]=getgenv().Visuals_ESP_SubTab
    X[2545]={}
    X[2545].Name="esp preview"
    X[2545].Position="right"
    X[2544].ESPPreviewSection = (X[2546]:AddSection(X[2545]))
    local function P(a)local v=529361834
        local E=v
        local L
        v=N:Aq(bit32.band(850334915,E)+bit32.band(850334915,320190363)+(bit32.band(2594297466,(bit32.bor(E,320190363)))+bit32.band(850334916,(bit32.bxor(E,320190363)))))
        L=function(v,Y)if Y>4 then return nil
            end
            local r=typeof(v)=="Instance"and v:IsA("GuiObject")
            if r then return v
            end
            r=type(v)=="table"
            if r then local r=pairs
                for K,C in r(v)do K=typeof(C)=="Instance"and C:IsA("GuiObject")
                    if K then return C
                else local v,r=type(C),"table"
                    if v==r then local v=L(C,Y+1)
                    if v then return v
                end
            end
        end
    end
end
return nil
end
E=L(a,0)
if E then a=E
    while true do local v=a and a~=workspace and not a:IsA("ScreenGui")
        if not v then break
        end
        v="UIListLayout"
        if a:FindFirstChildOfClass(v)then return a
        end
        a=a.Parent
    end
    return E
end
return nil
end
X[20]=(getgenv().ESPPreviewSection:AddLabel("enable preview"))
X[20]:AddToggle({
    Default = true,
    Flag = "ESP_Preview_Enabled",
    Callback = function(a)getgenv().ESPPreviewConfig.Enabled=a
    end,
})
X[2550]=P(X[20])or P(getgenv().ESPPreviewSection)
X[2549]={}
X[2549].Main=Instance.new("Frame")
local P,a=X[2550],X[2549]
X[2551]=a.Main
X[2551].Name = "EmbeddedESPPreview"
a.Main.Size=UDim2.new(1,0,0,225)
a.Main.BackgroundColor3=Color3.fromRGB(11,12,16)
a.Main.BackgroundTransparency=0.15
a.Main.BorderSizePixel=0
a.Main.ClipsDescendants=true
a.Main.ZIndex=20
a.Main.LayoutOrder=5
if P then a.Main.Parent=P
end
getgenv().EmbeddedPreviewMain=a.Main
X[217]=(Instance.new("UICorner",a.Main))
X[217].CornerRadius = (UDim.new(0,6))
a.Stroke = (Instance.new("UIStroke",a.Main))
a.Stroke.Color=Color3.fromRGB(38,40,52)
a.Stroke.Thickness=1
a.Stroke.Transparency=0.3
a.CenterHolder = (Instance.new("Frame",a.Main))
X[2556]=a.CenterHolder
X[2556].Name = "CenterHolder"
a.CenterHolder.Size=UDim2.fromOffset(getgenv().ESPPreviewConfig.ImageWidth,getgenv().ESPPreviewConfig.ImageHeight)
a.CenterHolder.AnchorPoint=Vector2.new(0.5,0.5)
a.CenterHolder.Position=UDim2.new(0.5,0,0.5,2)
a.CenterHolder.BackgroundTransparency=1
a.CenterHolder.ZIndex=21
a.ImageMask = (Instance.new("Frame",a.CenterHolder))
X[2559]=a.ImageMask
X[2559].Name = "ImageMask"
a.ImageMask.Size=UDim2.fromScale(1,1)
a.ImageMask.BackgroundTransparency=1
a.ImageMask.ClipsDescendants=true
a.ImageMask.ZIndex=22
a.Image = (Instance.new("ImageLabel",a.ImageMask))
X[2562]=a.Image
X[2562].Name = "MannequinImage"
a.Image.AnchorPoint=Vector2.new(0.5,0.5)
a.Image.Position=UDim2.new(0.5,0,0.5,getgenv().ESPPreviewConfig.OffsetY)
a.Image.Size=UDim2.fromScale(getgenv().ESPPreviewConfig.Zoom,getgenv().ESPPreviewConfig.Zoom)
a.Image.BackgroundTransparency=1
a.Image.ImageTransparency=0
a.Image.ImageColor3=Color3.fromRGB(255,255,255)
a.Image.ScaleType=Enum.ScaleType.Fit
a.Image.ZIndex=22
a.Image.Visible=true
local function P(v)local E=getcustomasset or getsynasset
    local L=not E or not v or v==""
    if L then return
    end
    L=not isfolder("NLAssets")
    if L then makefolder("NLAssets")
    end
    L=v:gsub("[^%w]","")..".png"
    local Y,r="NLAssets/"..L,true
    L=isfile(Y)
    if L then local K=readfile(Y)
        local C=K and#K>500 and K:sub(1,4)=="\194\137PNG"
        if C then r=false
        else delfile(Y)
        end
    end
    if r then L=nil
        local r=request or http_request or syn and syn.request or http and http.request
        if r then local K=r
            local C={}
            C.Url=v
            C.Method="GET"
            local l=K(C)
            L=if l and l.Body then l.Body else L
            end
            local K,C=not L
            if K then r=p
                C=r.HttpGet
            else C=K
            end
            if C then local C=110701605
                K=C
                r=nil
                r,C=pcall,N:Aq(K+285724501)
                local K,C=r(function()local r=p
                    return r:HttpGet(v)
                end)
                L=if K and C then C else L
                end
                if L and#L>500 then writefile(Y,L)
                end
            end
            if isfile(Y)then return E(Y)
            end
            return nil
        end
        local function v(E)getgenv().ESPPreviewConfig.ImageWidth=math.clamp(E.Width or 50,10,500)
            getgenv().ESPPreviewConfig.ImageHeight=math.clamp(E.Height or 50,10,500)
            getgenv().ESPPreviewConfig.Zoom=math.clamp(E.Zoom or 1,0.1,5)
            getgenv().ESPPreviewConfig.OffsetY=E.OffsetY or 0
            a.CenterHolder.Size=UDim2.fromOffset(getgenv().ESPPreviewConfig.ImageWidth,getgenv().ESPPreviewConfig.ImageHeight)
            a.Image.Size=UDim2.fromScale(getgenv().ESPPreviewConfig.Zoom,getgenv().ESPPreviewConfig.Zoom)
            a.Image.Position=UDim2.new(0.5,0,0.5,E.OffsetY or 0)
        end
        local function E(L)local Y={}
            local r=216921325
            local K=type(L)
            local l="table"
            r=bit32.bxor(r,472599471)
            local r=K==l and L.Url or L
            l=r=="LOCAL_PLAYER_AVATAR"or r=="localplayer"
            if l then local L=getgenv().LocalPlayer
                if L then local K=190232258
                    K=N:Aq(K+118880266)
                    Y[1]=a.Image
                    K=N:Aq(K+73586832)
                    Y[2]="rbxthumb://type=Avatar&id="..tostring(L.UserId).."&w=352&h=352"
                    Y[1].Image=Y[2]
                    task.spawn(function()local Y=365065621
                    local K=Y
                    local C
                    C,Y=pcall,N:Aq(bit32.band(473779735,K)+bit32.band(473779735,343860875)+(bit32.band(3821187562,(bit32.bor(K,343860875)))+bit32.band(3821187560,(bit32.band(K,343860875)))))
                    local Y,K=C(function()local C=p
                    local l,m,c,e=C:GetService("Players"),L.UserId,Enum.ThumbnailType.AvatarThumbnail,Enum.ThumbnailSize.Size420x420
                    return l:GetUserThumbnailAsync(m,c,e)
                end)
                if Y and K and a.Image then a.Image.Image=K
                end
            end)
        end
        return
    end
    task.spawn(function()for L=1,5,1 do L=P(r)
            if L and a.Image then a.Image.Image=L
                break
            end
            task.wait(0.4)
        end
    end)
end
X[193]=g[getgenv().ESPPreviewConfig.SelectedImage]or g["triple t"]
v(X[193])
E(X[193])
X[14]=getgenv().LocalPlayer
j=function()local P=getgenv().ESPPreviewConfig.SelectedImage=="localplayer"
    if P then task.wait(0.5)
        E("localplayer")
    end
end
X[14].CharacterAdded:Connect(j)
q={}
for P in pairs(g)do table.insert(q,P)
end
table.sort(q)
X[2564]=getgenv()
X[2564].esp_model_lbl = (getgenv().ESPPreviewSection:AddLabel("preview image"))
X[2566]=getgenv()
X[2568]=getgenv().esp_model_lbl
X[2567]={}
X[2567].Default=getgenv().ESPPreviewConfig.SelectedImage
X[2567].Values=q
X[2567].Flag="ESP_Preview_SelectedImage"
X[2567].Callback=function(P)getgenv().ESPPreviewConfig.SelectedImage=P
    local L=g[P]
    if L then v(L)
        E(L)
    end
end
X[2566].esp_model_dropdown = (X[2568]:AddDropdown(X[2567]))
a.BoxContainer = (Instance.new("Frame",a.CenterHolder))
X[2571]=a.BoxContainer
X[2571].Name = "BoxContainer"
a.BoxContainer.Size=UDim2.fromScale(1,1)
a.BoxContainer.Position=UDim2.fromScale(0,0)
a.BoxContainer.BackgroundTransparency=1
a.BoxContainer.BorderSizePixel=0
a.BoxContainer.ZIndex=23
a.BoxContainer.Visible=false
a.BOutline = (Instance.new("Frame",a.BoxContainer))
a.BOutline.Size=UDim2.new(1,2,1,2)
a.BOutline.Position=UDim2.fromOffset(-1,-1)
a.BOutline.BackgroundTransparency=1
a.BOutline.BorderSizePixel=0
a.BOutline.ZIndex=23
a.BOutStroke = (Instance.new("UIStroke",a.BOutline))
a.BOutStroke.Thickness=1
a.BOutStroke.Color=Color3.fromRGB(0,0,0)
a.BMain = (Instance.new("Frame",a.BoxContainer))
a.BMain.Size=UDim2.fromScale(1,1)
a.BMain.Position=UDim2.fromOffset(0,0)
a.BMain.BackgroundTransparency=1
a.BMain.BorderSizePixel=0
a.BMain.ZIndex=25
a.BMainStroke = (Instance.new("UIStroke",a.BMain))
a.BMainStroke.Thickness=1
a.BIn = (Instance.new("Frame",a.BoxContainer))
a.BIn.Size=UDim2.new(1,-2,1,-2)
a.BIn.Position=UDim2.fromOffset(1,1)
a.BIn.BackgroundTransparency=1
a.BIn.BorderSizePixel=0
a.BIn.ZIndex=23
a.BInStroke = (Instance.new("UIStroke",a.BIn))
a.BInStroke.Thickness=1
a.BInStroke.Color=Color3.fromRGB(0,0,0)
a.BFill = (Instance.new("Frame",a.BIn))
a.BFill.Size=UDim2.fromScale(1,1)
a.BFill.BorderSizePixel=0
a.BFill.ZIndex=21
a.BFill.Visible=false
a.BGrad = (Instance.new("UIGradient",a.BFill))
a.BGrad.Rotation=90
local function g()local P=Instance.new("TextLabel",a.CenterHolder)
    P.BackgroundTransparency=1
    P.TextStrokeTransparency=0.15
    P.TextStrokeColor3=Color3.fromRGB(0,0,0)
    P.TextSize=11
    P.Font=Enum.Font.GothamBold
    P.TextColor3=Color3.fromRGB(255,255,255)
    P.TextXAlignment=Enum.TextXAlignment.Center
    P.ZIndex=26
    P.Visible=false
    return P
end
a.LblName=g()
a.LblName.Size=UDim2.new(3,0,0,14)
a.LblName.AnchorPoint=Vector2.new(0.5,1)
a.LblName.Position=UDim2.new(0.5,0,0,-5)
a.LblStuds=g()
a.LblStuds.Size=UDim2.new(2,0,0,14)
a.LblStuds.AnchorPoint=Vector2.new(0.5,0)
a.LblStuds.Position=UDim2.new(0.5,0,1,4)
a.LblTool=g()
a.LblTool.Size=UDim2.new(2,0,0,14)
a.LblTool.AnchorPoint=Vector2.new(0.5,0)
a.LblTool.Position=UDim2.new(0.5,0,1,17)
local function g(P)local v=Instance.new("Frame",a.CenterHolder)
    v.BackgroundColor3=Color3.fromRGB(0,0,0)
    v.BorderSizePixel=0
    v.ZIndex=P or 25
    v.Visible=false
    local E=Instance.new("Frame",v)
    E.BorderSizePixel=0
    E.Position=UDim2.fromOffset(1,1)
    E.Size=UDim2.new(1,-2,1,-2)
    E.ZIndex=(P or 25)+1
    P=(Instance.new("UIGradient",E))
    P.Rotation=90
    return v,E,P
end
a.HpOut,a.HpFill,a.HpGrad=g(35)
a.ArmOut,a.ArmFill,a.ArmGrad=g(25)
local function g(P)local v=P=="Left"
    if v then a.HpOut.Size=UDim2.new(0,4,1,4)
        a.HpOut.Position=UDim2.fromOffset(-8,-2)
        a.HpGrad.Rotation=90
        a.LblName.Position=UDim2.new(0.5,0,0,-5)
        a.LblStuds.Position=UDim2.new(0.5,0,1,4)
        a.ArmOut.Position=UDim2.fromOffset(-14,-2)
    else local v=P=="Right"
        if v then a.HpOut.Size=UDim2.new(0,4,1,4)
            a.HpOut.Position=UDim2.new(1,4,0,-2)
            a.HpGrad.Rotation=90
            a.LblName.Position=UDim2.new(0.5,0,0,-5)
            a.LblStuds.Position=UDim2.new(0.5,0,1,4)
            a.ArmOut.Position=UDim2.fromOffset(-8,-2)
        else local v=P=="Top"
            if v then a.HpOut.Size=UDim2.new(1,4,0,4)
                a.HpOut.Position=UDim2.fromOffset(-2,-8)
                a.HpGrad.Rotation=0
                a.LblName.Position=UDim2.new(0.5,0,0,-15)
                a.LblStuds.Position=UDim2.new(0.5,0,1,4)
                a.ArmOut.Position=UDim2.fromOffset(-8,-2)
            else local v="Bottom"
                if P==v then a.HpOut.Size=UDim2.new(1,4,0,4)
                    a.HpOut.Position=UDim2.new(0,-2,1,4)
                    a.HpGrad.Rotation=0
                    a.LblName.Position=UDim2.new(0.5,0,0,-5)
                    a.LblStuds.Position=UDim2.new(0.5,0,1,11)
                    a.ArmOut.Position=UDim2.fromOffset(-8,-2)
                end
            end
        end
    end
end
g(getgenv().Config.Bars.Health.Position)
local P,v,E=false
a.HpOut.InputBegan:Connect(function(L)local Y={}
    local r=L.UserInputType==Enum.UserInputType.MouseButton1 or L.UserInputType==Enum.UserInputType.Touch
    if r then local r=294830318
        L=r
        P=true
        local K=v
        r=N:Aq(L+419706859)
        if K then v:Disconnect()
        end
        K=E
        if K then E:Disconnect()
        end
        K=p
        r=N:Aq(r+6442963)
        Y[1]=(K:GetService("UserInputService").InputChanged:Connect(function(L)local r=P and(L.UserInputType==Enum.UserInputType.MouseMovement or L.UserInputType==Enum.UserInputType.Touch)
            if r then local r,C=Vector2.new(L.Position.X,L.Position.Y),a.CenterHolder.AbsolutePosition
                a.HpOut.Position=UDim2.fromOffset(r.X-C.X-a.HpOut.AbsoluteSize.X/2,r.Y-C.Y-a.HpOut.AbsoluteSize.Y/2)
            end
        end))
        v=Y[1]
        K=p
        Y[2]=(K:GetService("UserInputService").InputEnded:Connect(function(L)local r=L.UserInputType==Enum.UserInputType.MouseButton1 or L.UserInputType==Enum.UserInputType.Touch
            if r then local r=P
                if r then P=false
                    local P=v
                    if P then v:Disconnect()
                    v=nil
                end
                P=E
                if P then E:Disconnect()
                    E=nil
                end
                local v,r,K,C=a.CenterHolder.AbsolutePosition+a.CenterHolder.AbsoluteSize/2,Vector2.new(L.Position.X,L.Position.Y),a.Main.AbsolutePosition,a.Main.AbsoluteSize
                P=r.X>=K.X-40 and r.X<=K.X+C.X+40 and r.Y>=K.Y-40 and r.Y<=K.Y+C.Y+40
                if P then C=r-v
                    K="Left"
                    K=if math.abs(C.X)>math.abs(C.Y)then C.X>0 and "Right"or "Left"else C.Y>0 and "Bottom"or "Top"
                    getgenv().Config.Bars.Health.Position=K
                    g(K)
                else g(getgenv().Config.Bars.Health.Position or "Left")
                end
            end
        end
    end))
    E=Y[2]
end
end)
R=getgenv
x=R().utility
X[115]=function(g)local P={}
    if not g or not getgenv().ESPCache[g]then return
    end
    if g==getgenv().LocalPlayer and not getgenv().Config.ShowOnSelf then getgenv().utility.funcs.clear_esp(g)
        return
    end
    local v,E,R,L=getgenv().Config.Box.Enable,getgenv().Config.Text.Enable,getgenv().Config.Bars.Health.Enable,getgenv().Config.Bars.Armor.Enable
    if not(v or E or R or L)then getgenv().utility.funcs.clear_esp(g)
        return
    end
    E,L,R=g.Character,getgenv().LocalPlayer.Character,workspace.CurrentCamera
    if not E or not L or not R then return
    end
    L=(E:FindFirstChild("HumanoidRootPart"))
    v=(E:FindFirstChildWhichIsA("Humanoid"))
    if not L or not v then getgenv().utility.funcs.clear_esp(g)
        return
    end
    local Y,r,K,C,l,m,c=ipairs,table.pack(E:GetChildren()),false,1/0,-1/0,1/0,-1/0
    for e,j in Y(table.unpack(r))do e=j:IsA("BasePart")and j.Name~="HumanoidRootPart"
        if e then local e,B,u=j.CFrame,j.Size*0.5,ipairs
            local j={e*Vector3.new(B.X,B.Y,B.Z),e*Vector3.new(B.X,B.Y,-B.Z),e*Vector3.new(B.X,-B.Y,B.Z),e*Vector3.new(B.X,-B.Y,-B.Z),e*Vector3.new(-B.X,B.Y,B.Z),e*Vector3.new(-B.X,B.Y,-B.Z),e*Vector3.new(-B.X,-B.Y,B.Z),e*Vector3.new(-B.X,-B.Y,-B.Z)}
            for e,G in u(j)do B,e=R:WorldToViewportPoint(G)
                if e then K,C,l,m,c=true,if B.X<C then B.X else C,if B.X>l then B.X else l,if B.Y<m then B.Y else m,if B.Y>c then B.Y else c
                end
            end
        end
    end
    if not K or C==1/0 then getgenv().utility.funcs.clear_esp(g)
        return
    end
    local K,e,j,B,B=Vector2.new(math.floor(C-2),math.floor(m-2)),Vector2.new(math.floor(l-C+4),math.floor(c-m+4)),getgenv().ESPCache[g],R:WorldToViewportPoint(L.Position)
    if not B then getgenv().utility.funcs.clear_esp(g)
        return
    end
    r=(R.CFrame.Position-L.Position).Magnitude
    B,Y=math.clamp(math.floor(100000-r*10),100,100000),getgenv().Config.Box.Enable
    if Y then r=j.Box.Full
        local C,l,m,c,u=r.Square,r.Outline,r.Inline,r.Filled,getgenv().Config.Box.Type=="Full"
        if u then C.Visible=true
            C.Position=K
            C.Size=e
            C.Color=getgenv().Config.Box.Color
            C.Thickness=1
            C.Filled=false
            C.ZIndex=B+2
            l.Visible=true
            l.Position=K-Vector2.new(1,1)
            l.Size=e+Vector2.new(2,2)
            l.Color=Color3.new(0,0,0)
            l.Thickness=1
            l.Filled=false
            l.ZIndex=B
            if e.X>6 and e.Y>6 then m.Visible=true
                m.Position=K+Vector2.new(1,1)
                m.Size=e-Vector2.new(2,2)
                m.Color=Color3.new(0,0,0)
                m.Thickness=1
                m.Filled=false
                m.ZIndex=B
            else m.Visible=false
            end
            local C=getgenv().Config.Box.Filled.Enable and c
            if C then c.Position=UDim2.new(0,K.X,0,K.Y-getgenv().gui_inset.Y)
                c.Size=UDim2.new(0,e.X,0,e.Y)
                c.BackgroundTransparency=getgenv().Config.Box.Filled.Gradient.Transparency or 0.5
                c.BackgroundColor3=Color3.fromRGB(255,255,255)
                c.Visible=true
                c.ZIndex=-9000000000
                local C=getgenv().Config.Box.Filled.Gradient.Enable
                if C then local C=c:FindFirstChild("Gradient")or Instance.new("UIGradient")
                    P[1]="Gradient"
                    C.Name=P[1]
                    C.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,getgenv().Config.Box.Filled.Gradient.Color.Start),ColorSequenceKeypoint.new(1,getgenv().Config.Box.Filled.Gradient.Color.End)})
                    C.Rotation=math.sin(tick()*2)*180
                    C.Parent=c
                end
            elseif c then c.Visible=false
                end
            end
        else local C=j.Box.Full
            if C then if C.Square then C.Square.Visible=false
                end
                if C.Outline then C.Outline.Visible=false
                end
                if C.Inline then C.Inline.Visible=false
                end
                if C.Filled then C.Filled.Visible=false
                end
            end
        end
        local C,l,m,c,u,G=e.Y,3,K.X,K.Y-getgenv().gui_inset.Y,getgenv().Config.Bars.Health.Position or "Left",getgenv().Config.Bars.Health.Enable and v
        if G then B=(E:FindFirstChild("BodyEffects"))
            Y=B and(B:FindFirstChild("Health")or B:FindFirstChild("Health_CLIENT")or B:FindFirstChild("HP"))
            r=Y and Y.Value or v.Health
            local s=math.clamp(r/100,0,1)
            local W=j.Bars.Health.LastHealth or s
            local n=W+(s-W)*0.05
            j.Bars.Health.LastHealth=n
            local V,F,o=j.Bars.Health.Outline,j.Bars.Health.Frame,j.Bars.Health.Gradient
            W=V and F
            if W then V.Visible=true
                V.BackgroundTransparency=0.2
                F.Visible=true
                s=u=="Left"
                if s then V.Position=UDim2.new(0,m-l-5,0,c-1)
                    V.Size=UDim2.new(0,5,0,C+2)
                    F.Position=UDim2.new(0,1,0,(1-n)*C+1)
                    F.Size=UDim2.new(0,l,0,n*C)
                    if o then o.Rotation=90
                end
            else local s=u=="Right"
                if s then V.Position=UDim2.new(0,m+e.X+3,0,c-1)
                    V.Size=UDim2.new(0,5,0,C+2)
                    F.Position=UDim2.new(0,1,0,(1-n)*C+1)
                    F.Size=UDim2.new(0,l,0,n*C)
                    if o then o.Rotation=90
                end
            else local s=u=="Top"
                if s then V.Position=UDim2.new(0,m-1,0,c-l-5)
                    V.Size=UDim2.new(0,e.X+2,0,5)
                    F.Position=UDim2.new(0,1,0,1)
                    F.Size=UDim2.new(0,n*e.X,0,l)
                    if o then o.Rotation=0
                end
            else local s="Bottom"
                if u==s then V.Position=UDim2.new(0,m-1,0,c+C+3)
                    V.Size=UDim2.new(0,e.X+2,0,5)
                    F.Position=UDim2.new(0,1,0,1)
                    F.Size=UDim2.new(0,n*e.X,0,l)
                    if o then o.Rotation=0
                end
            end
        end
    end
end
end
elseif j.Bars.Health then if j.Bars.Health.Frame then j.Bars.Health.Frame.Visible=false
    end
    if j.Bars.Health.Outline then j.Bars.Health.Outline.Visible=false
    end
end
r=getgenv().Config.Text.Enable
if r then local s,W,n,V,F,o=j.Text.Name,j.Text.Tool,j.Text.Studs,K.X+e.X/2,K.Y-getgenv().gui_inset.Y,getgenv().Config.Text.Name.Enable
    if o then s.Visible=true
        Y=u=="Top"and getgenv().Config.Bars.Health.Enable and 9 or 0
        B=getgenv().Config.Text.Name.Type or "Display"
        v=B=="Display"
        if v then s.Text=g.DisplayName
        else G=B=="Username"
            if G then s.Text=g.Name
            else local T=B=="Both"
                if T then P[2]=g.DisplayName.." (@"..g.Name..")"
                    s.Text=P[2]
                end
            end
        end
        s.Position=UDim2.new(0,V-s.AbsoluteSize.X/2,0,F-15+6-Y)
    else s.Visible=false
    end
    o=u=="Bottom"and getgenv().Config.Bars.Health.Enable and 8 or 0
    s=getgenv().Config.Text.Studs.Enable
    if s then n.Visible=true
        n.Position=UDim2.new(0,V-n.AbsoluteSize.X/2,0,F+e.Y+5+o)
        local T=(R.CFrame.Position-L.Position).Magnitude
        P[3]=(string.format("[%.0fm]",T*0.28))
        n.Text=P[3]
    else n.Visible=false
    end
    s=getgenv().Config.Text.Tool.Enable
    if s then W.Visible=true
        n=F+e.Y+15+o
        n=if not getgenv().Config.Text.Studs.Enable then F+e.Y+5+o else n
            W.Position=UDim2.new(0,V-W.AbsoluteSize.X/2,0,n)
            local s=E:FindFirstChildOfClass("Tool")
            P[4]=s and s.Name or "none"
            W.Text=P[4]
        else W.Visible=false
        end
    else if j.Text.Name then j.Text.Name.Visible=false
        end
        if j.Text.Tool then j.Text.Tool.Visible=false
        end
        if j.Text.Studs then j.Text.Studs.Visible=false
        end
    end
    Y=getgenv().Config.Bars.Armor.Enable and E
    if Y then v=(E:FindFirstChild("BodyEffects"))
        e=v and v:FindFirstChild("Armor")
        G=e and math.clamp(e.Value/130,0,1)or 0
        K=j.Bars.Armor.LastArmor or G
        B=K+(G-K)*0.05
        j.Bars.Armor.LastArmor=B
        g=j.Bars.Armor.Outline
        r=j.Bars.Armor.Frame
        R=u=="Left"and getgenv().Config.Bars.Health.Enable and 14 or 7
        L=m-R
        if g and r then g.Visible=true
            g.Position=UDim2.new(0,L-1,0,c-1)
            g.Size=UDim2.new(0,5,0,C+2)
            g.BackgroundTransparency=0.2
            r.Visible=true
            r.Position=UDim2.new(0,1,0,(1-B)*C+1)
            r.Size=UDim2.new(0,l,0,B*C)
        end
    elseif j.Bars.Armor then if j.Bars.Armor.Frame then j.Bars.Armor.Frame.Visible=false
            end
            if j.Bars.Armor.Outline then j.Bars.Armor.Outline.Visible=false
            end
        end
    end
    X[2581]=x.funcs
    X[2581].update=X[115]
    d=p
    X[128]="RunService"
    X[195]=(d:GetService(X[128]))
    X[134]=function()local g={}
        if getgenv().Unloaded then if a.Main then a.Main:Destroy()
            end
            return
        end
        local P,v=getgenv().ESPPreviewConfig,getgenv().NeverLose and getgenv().NeverLose.ScreenGui
        local E=v==nil or v.Enabled==true
        if not P or not P.Enabled or not E then a.Main.Visible=false
            return
        end
        a.Main.Visible=true
        E=getgenv().Config
        if not E then return
        end
        if E.Box.Enable then a.BoxContainer.Visible=true
            a.BMainStroke.Color=E.Box.Color or Color3.fromRGB(255,255,255)
            if E.Box.Filled and E.Box.Filled.Enable then a.BFill.Visible=true
                a.BFill.BackgroundTransparency=E.Box.Filled.Gradient.Transparency or 0.5
                a.BGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,E.Box.Filled.Gradient.Color.Start),ColorSequenceKeypoint.new(1,E.Box.Filled.Gradient.Color.End)})
            else a.BFill.Visible=false
            end
        else a.BoxContainer.Visible=false
        end
        v=E.Text.Enable and E.Text.Name.Enable
        if v then a.LblName.Visible=true
            a.LblName.TextColor3=E.Text.Name.Color or Color3.fromRGB(255,255,255)
            P=E.Text.Name.Type or "Display"
            local R=P=="Display"
            if R then a.LblName.Text=getgenv().LocalPlayer.DisplayName
            else local R=P=="Username"
                if R then a.LblName.Text=getgenv().LocalPlayer.Name
                else local R=P=="Both"
                    if R then a.LblName.Text = getgenv().LocalPlayer.DisplayName.." (@"..getgenv().LocalPlayer.Name..")"
                end
            end
        end
    else a.LblName.Visible=false
    end
    P=E.Text.Enable and E.Text.Studs.Enable
    if P then a.LblStuds.Visible=true
        a.LblStuds.TextColor3=E.Text.Studs.Color or Color3.fromRGB(255,255,255)
        a.LblStuds.Text = "[15m]"
    else a.LblStuds.Visible=false
    end
    v=E.Text.Enable and E.Text.Tool.Enable
    if v then a.LblTool.Visible=true
        a.LblTool.TextColor3=E.Text.Tool.Color or Color3.fromRGB(255,255,255)
        a.LblTool.Text = "[Revolver]"
        P=getgenv().Config.Bars.Health.Position=="Bottom"and 11 or 4
        a.LblTool.Position=UDim2.new(0.5,0,1,E.Text.Studs.Enable and P+13 or P)
    else a.LblTool.Visible=false
    end
    if E.Bars.Health.Enable then a.HpOut.Visible=true
        a.HpGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,E.Bars.Health.Color1),ColorSequenceKeypoint.new(0.5,E.Bars.Health.Color2),ColorSequenceKeypoint.new(1,E.Bars.Health.Color3)})
    else a.HpOut.Visible=false
    end
    v=E.Bars.Armor.Enable
    if v then a.ArmOut.Visible=true
        local g,P=getgenv().Config.Bars.Health.Position,"Left"
        if g==P then a.ArmOut.Position=UDim2.fromOffset(-14,-2)
        else a.ArmOut.Position=UDim2.fromOffset(-8,-2)
        end
        a.ArmGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,E.Bars.Armor.Color1),ColorSequenceKeypoint.new(0.5,E.Bars.Armor.Color2),ColorSequenceKeypoint.new(1,E.Bars.Armor.Color3)})
    else a.ArmOut.Visible=false
    end
end
X[195].RenderStepped:Connect(X[134])
end
X[2582]=getgenv()
Config.CrosshairConfig={}
Config.CrosshairConfig.Enabled=false
Config.CrosshairConfig.Position="mouse"
Config.CrosshairConfig.HideGameCrosshair=false
Config.CrosshairConfig.Lines=4
Config.CrosshairConfig.Radius=14
Config.CrosshairConfig.Length=9
Config.CrosshairConfig.Thickness=2
Config.CrosshairConfig.Rotation=0
Config.CrosshairConfig.Color=Color3.fromRGB(255,250,180)
Config.CrosshairConfig.OutlineColor=Color3.fromRGB(0,0,0)
Config.CrosshairConfig.Spin=false
Config.CrosshairConfig.SpinSpeed=300
Config.CrosshairConfig.Pulse=true
Config.CrosshairConfig.PulseSpeed=4
Config.CrosshairConfig.GapPulse=5
Config.CrosshairConfig.SizePulse=6
Config.CrosshairConfig.Text=true
Config.CrosshairConfig.TextString="larptic"
Config.CrosshairConfig.TextPos="bottom right"
Config.CrosshairConfig.TextColor=Color3.fromRGB(240,240,240)
X[2582].Crosshair = Config.CrosshairConfig
local g,P,a=getgenv().Crosshair,{},{}
local v=Drawing.new("Text")
v.Font=2
v.Size=13
v.Outline=true
v.OutlineColor=Color3.fromRGB(0,0,0)
v.ZIndex=3
local function E(R)while true do local x=#P
        if not(x>R)then break
        end
        local x,L=table.remove(P),table.remove(a)
        if x then x:Remove()
        end
        if L then L:Remove()
        end
    end
    while true do local x=#P
        if not(x<R)then break
        end
        x=(Drawing.new("Line"))
        x.ZIndex=1
        table.insert(a,x)
        x=(Drawing.new("Line"))
        x.ZIndex=2
        table.insert(P,x)
    end
end
local R=0
local x,L=workspace.CurrentCamera,p
local Y,r=L:GetService("UserInputService"),p
local L=r:GetService("Players").LocalPlayer
local function r(K)local C=L and L:FindFirstChild("PlayerGui")
    local l=C and C:FindFirstChild("Main Screen")
    if l then C=(l:FindFirstChild("Aim"))
        local l=C and C:IsA("GuiObject")
        if l then C.Visible=K
        end
    end
end
local function K()local C,l=Y:GetMouseLocation(),g.Position=="mouse"
    if l then return C
    else local Y=g.Position=="gun tip"
        if Y then local Y=getgenv().FH_GetMuzzlePos and getgenv().FH_GetMuzzlePos()
            local l=not Y
            if l then local l=L and L.Character
                local L=l and l:FindFirstChildOfClass("Tool")
                l=L and(L:FindFirstChild("Handle")or L:FindFirstChildWhichIsA("BasePart"))
                Y=if l then l.Position else Y
                end
                if Y then local L,l=x:WorldToViewportPoint(Y)
                    if l then return Vector2.new(L.X,L.Y)
                end
            end
            return C
        else local L=g.Position=="target"
            if L then local L=Config and Config.ForceHit and Config.ForceHit.Target or getgenv().KillAura and getgenv().KillAura.CurrentTarget or CurrentLegitTarget
                local Y=L and L.Character
                if Y then local Y=Config and Config.ForceHit and Config.ForceHit.HitPart or "Head"
                    local l=L.Character:FindFirstChild(Y)or L.Character:FindFirstChild("Head")or L.Character:FindFirstChild("HumanoidRootPart")
                    if l then local L,Y=x:WorldToViewportPoint(l.Position)
                    if Y then return Vector2.new(L.X,L.Y)
                end
            end
        end
        return C
    end
end
end
return C
end
X[182]=nil
X[2585]=getgenv()
X[182]=p
X[2586]=(p:GetService("RunService").RenderStepped:Connect(function(x)local L=getgenv().Unloaded or not g.Enabled
    if L then local Y=#P
        for C=1,Y,1 do local l=P[C]
            if l then P[C].Visible=false
            end
            l=a[C]
            if l then a[C].Visible=false
            end
        end
        Y=v
        if Y then v.Visible=false
        end
        return
    end
    if g.HideGameCrosshair then r(false)
    end
    local Y,C=K(),g.Spin
    if C then L=R
        R=(L+g.SpinSpeed*x)%360
    end
    x=g.Pulse and math.sin(tick()*g.PulseSpeed)or 0
    L=math.max(1,g.Radius+x*g.GapPulse)
    C=L+math.max(2,g.Length+x*g.SizePulse)
    E(g.Lines)
    local E,K,l=6.283185307179586/g.Lines,math.rad,R
    local R,m=K(l+g.Rotation),g.Lines
    for d=1,m,1 do K,l,x=P[d],a[d],R+(d-1)*E
        local m,d=math.cos(x),math.sin(x)
        local c,e=Y+Vector2.new(m*L,d*L),Y+Vector2.new(m*C,d*C)
        if l then l.From=Y+Vector2.new(m*(L-0.5),d*(L-0.5))
            l.To=Y+Vector2.new(m*(C+0.5),d*(C+0.5))
            l.Color=g.OutlineColor
            l.Thickness=g.Thickness+1.5
            l.Visible=true
        end
        if K then K.From=c
            K.To=e
            K.Color=g.Color
            K.Thickness=g.Thickness
            K.Visible=true
        end
    end
    K=v
    if K then R=g.Text and g.TextString~=""
        if R then Vector2.new(0,0)
            x=if g.TextPos=="bottom right"then Y+Vector2.new(C+14,C+12)else Y+Vector2.new(-(C+14+v.TextBounds.X),C+12)
                L=v
                L.Text=g.TextString
                E=v
                E.Color=g.TextColor
                v.Position=x
                v.Visible=true
            else v.Visible=false
            end
        end
    end))
    X[2585].CrosshairConnection=X[2586]
    getgenv().DestroyCrosshair=function()if getgenv().CrosshairConnection then getgenv().CrosshairConnection:Disconnect()
            getgenv().CrosshairConnection=nil
        end
        r(true)
        local E=P
        for R,R in ipairs(E)do R:Remove()
        end
        E=a
        for R,R in ipairs(E)do R:Remove()
        end
        E=v
        if E then v:Remove()
            v=nil
        end
        P,a={},{}
    end
    X[2587]=getgenv()
    X[2589]=getgenv().Visuals_Self_SubTab
    X[2588]={}
    X[2588].Name="crosshair"
    X[2588].Position="right"
    X[2587].CrosshairSection = (X[2589]:AddSection(X[2588]))
    X[7]=(getgenv().CrosshairSection:AddLabel("crosshair"))
    X[7]:AddToggle({
        Default = false,
        Flag = "CH_Enabled",
        Callback = function(P)g.Enabled=P
                if not P and g.HideGameCrosshair then r(true)
                end
            end,
    })
    X[7]:AddColorPicker({
        Default = g.Color,
        Flag = "CH_Color",
        Callback = function(P)g.Color=P
            end,
    })
    S=(X[7]:AddOption(1))
    X[175]="position"
    X[2594]=S:AddLabel(X[175])
    X[2593]={}
    X[2593].Default="mouse"
    local P,a,v,E,R,x=X[2594],X[2593],{},"mouse","gun tip","target"
    N:jq(v,0,E,R,x)
    a.Values=v
    a.Flag = "CH_Position"
    a.Callback=function(v)g.Position=v
    end
    P:AddDropdown(a)
    X[2597]=S:AddLabel("lines")
    X[2597]:AddSlider({
        Min = 2,
        Max = 8,
        Rounding = 0,
        Default = g.Lines,
        Flag = "CH_Lines",
        Callback = function(P)g.Lines=P
            end,
    })
    X[2599]=S:AddLabel("rotation")
    X[2599]:AddSlider({
        Min = 0,
        Max = 360,
        Rounding = 0,
        Default = g.Rotation,
        Flag = "CH_Rotation",
        Callback = function(P)g.Rotation=P
            end,
    })
    X[2601]=S:AddLabel("radius")
    X[2601]:AddSlider({
        Min = 2,
        Max = 50,
        Rounding = 0,
        Default = g.Radius,
        Flag = "CH_Radius",
        Callback = function(P)g.Radius=P
            end,
    })
    X[2603]=S:AddLabel("length")
    X[2603]:AddSlider({
        Min = 2,
        Max = 40,
        Rounding = 0,
        Default = g.Length,
        Flag = "CH_Length",
        Callback = function(P)g.Length=P
            end,
    })
    X[2605]=S:AddLabel("thickness")
    X[2605]:AddSlider({
        Min = 1,
        Max = 5,
        Rounding = 0,
        Default = g.Thickness,
        Flag = "CH_Thickness",
        Callback = function(P)g.Thickness=P
            end,
    })
    X[175]=(S:AddLabel("spin"))
    X[175]:AddToggle({
        Default = false,
        Flag = "CH_Spin",
        Callback = function(P)g.Spin=P
            end,
    })
    X[175]:AddSlider({
        Min = 10,
        Max = 720,
        Rounding = 0,
        Default = g.SpinSpeed,
        Flag = "CH_SpinSpeed",
        Callback = function(P)g.SpinSpeed=P
            end,
    })
    X[59]=(S:AddLabel("pulse"))
    X[59]:AddToggle({
        Default = true,
        Flag = "CH_Pulse",
        Callback = function(P)g.Pulse=P
            end,
    })
    X[59]:AddSlider({
        Min = 1,
        Max = 15,
        Rounding = 1,
        Default = g.PulseSpeed,
        Flag = "CH_PulseSpeed",
        Callback = function(P)g.PulseSpeed=P
            end,
    })
    X[2611]=S:AddLabel("gap pulse")
    X[2611]:AddSlider({
        Min = 0,
        Max = 25,
        Rounding = 0,
        Default = g.GapPulse,
        Flag = "CH_GapPulse",
        Callback = function(P)g.GapPulse=P
            end,
    })
    X[2613]=S:AddLabel("size pulse")
    X[2613]:AddSlider({
        Min = 0,
        Max = 25,
        Rounding = 0,
        Default = g.SizePulse,
        Flag = "CH_SizePulse",
        Callback = function(S)g.SizePulse=S
            end,
    })
    X[186]=(getgenv().CrosshairSection:AddLabel("text"))
    X[186]:AddToggle({
        Default = true,
        Flag = "CH_Text",
        Callback = function(S)g.Text=S
            end,
    })
    X[186]:AddColorPicker({
        Default = g.TextColor,
        Flag = "CH_TextColor",
        Callback = function(S)g.TextColor=S
            end,
    })
    A=(X[186]:AddOption(1))
    X[68]="position"
    X[2617]=A:AddLabel(X[68])
    X[2616]={}
    X[2616].Default="bottom right"
    local S,P,a,v,E=X[2617],X[2616],{},"bottom right","bottom left"
    N:jq(a,0,v,E)
    P.Values=a
    P.Flag = "CH_TextPos"
    P.Callback=function(a)g.TextPos=a
    end
    S:AddDropdown(P)
    H=(getgenv().CrosshairSection:AddLabel("hide game crosshair"))
    H:AddToggle({
        Default = false,
        Flag = "CH_HideGameCrosshair",
        Callback = function(S)g.HideGameCrosshair=S
                if not S then r(true)
                end
            end,
    })
    getgenv().FlashbackConfig={Enabled=false,TriggerHP=10,SavedCF=nil}
    getgenv().FlashbackConn=nil
    local function g()local S=249323843
        local P
        P,S=getgenv,bit32.bxor(S,58368207)
        local a=P().FlashbackConn
        S=N:Aq(bit32.band(527422854,S)+bit32.band(527422854,231949841)+(bit32.band(3240121588,(bit32.bor(S,231949841)))+bit32.band(527422855,(bit32.bxor(S,231949841)))))
        if a then local S=376574953
            P=nil
            P,S=pcall,N:Aq(S+113104474)
            P(function()getgenv().FlashbackConn:Disconnect()
            end)
            getgenv().FlashbackConn=nil
        end
        getgenv().FlashbackConn=getgenv().RunService.Heartbeat:Connect(function()if not getgenv().FlashbackConfig.Enabled then return
            end
            local S=getgenv().LocalPlayer.Character
            local P,a=S and S:FindFirstChildOfClass("Humanoid"),S and S:FindFirstChild("HumanoidRootPart")
            if not P or not a then return
            end
            S=getgenv().FlashbackConfig
            if P.Health<=S.TriggerHP and not S.SavedCF then S.SavedCF=a.CFrame
            elseif P.Health>S.TriggerHP and S.SavedCF then a.CFrame=S.SavedCF*CFrame.new(math.sin(tick())*0.001,0,math.cos(tick())*0.001)
                    S.SavedCF=nil
                end
            end)
        end
        X[191]=p
        X[2620]="Players"
        h=(X[191]:GetService(X[2620]))
        I=p
        local S=I:GetService("RunService")
        X[108]=h.LocalPlayer
        getgenv().FlashbackConfig=getgenv().FlashbackConfig or{Enabled=false,SavedCF=nil}
        local function I(P)local a=306352800
            local v=P:WaitForChild("HumanoidRootPart",5)
            a=bit32.bxor(a,240315426)
            local H=P:WaitForChild("BodyEffects",3)
            local x=H and H:WaitForChild("Health",3)
            H=getgenv().FlashbackConfig.Enabled
            a=N:Aq(bit32.band(2764053331,a)+bit32.band(2764053331,250833363)+(bit32.band(1530913966,(bit32.bor(a,250833363)))+bit32.band(1530913964,(bit32.band(a,250833363)))))
            if H and getgenv().FlashgraphConfig then getgenv().FlashgraphConfig=nil
            end
            H=getgenv().FlashbackConfig.Enabled and getgenv().FlashbackConfig.SavedCF
            if H then local a=455129504
                local H
                H,a=getgenv(),bit32.bxor(a,237181272)
                local L,Y=H.FlashbackConfig.SavedCF
                Y,a=task,bit32.bxor(a,61451581)
                Y.spawn(function()local a=176670665
                    local H=a
                    local Y,r=0
                    a=N:Aq(H+38731923)
                    H=nil
                    H,a=S.RenderStepped,N:Aq(a+400264247)
                    r=H:Connect(function()if not P or not P.Parent or not v then if r then r:Disconnect()
                end
                return
            end
            v.CFrame=L
            v.AssemblyLinearVelocity=Vector3.new(0,0,0)
            v.AssemblyAngularVelocity=Vector3.new(0,0,0)
            Y+=1
            local N=Y
            if N>20 then r:Disconnect()
            end
        end)
    end)
end
local N
local function a()if not getgenv().FlashbackConfig.Enabled then return
    end
    local H=v and P.Parent
    if H then local H,L=false,x and x.Value<=0
        if L then H=true
        else local x=P:FindFirstChildOfClass("Humanoid")
            H=if x and x.Health<=0 then true else H
            end
            if H then N:Disconnect()
            else getgenv().FlashbackConfig.SavedCF=v.CFrame
            end
        else N:Disconnect()
        end
    end
    N=S.Heartbeat:Connect(a)
end
if X[108].Character then I(X[108].Character)
end
X[108].CharacterAdded:Connect(I)
g()
X[2621]=getgenv()
X[2621].antafk_lbl = (getgenv().SurvivalSection:AddLabel("fake afk"))
X[2624]=getgenv().antafk_lbl
X[2624]:AddToggle({
    Default = false,
    Flag = "Misc_AntiAFKEnabled",
    Callback = function(N)getgenv().AntiAFKEnabled=N
    end,
})
X[2625]=getgenv()
X[2625].spamafk_lbl = (getgenv().SurvivalSection:AddLabel("spam afk"))
X[2628]=getgenv().spamafk_lbl
X[2628]:AddToggle({
    Default = false,
    Flag = "Misc_SpamAFKEnabled",
    Callback = function(N)getgenv().SpamAFKEnabled=N
    end,
})
X[225]=p
local N=X[225].ReplicatedStorage.MainEvent
task.spawn(function()while true do local g=getgenv().AntiAFKEnabled
        if g then N:FireServer("RequestAFKDisplay",true)
        end
        task.wait(0.5)
    end
end)
task.spawn(function()while true do local g=getgenv().SpamAFKEnabled
        if g then N:FireServer("RequestAFKDisplay",true)
            task.wait(0.01)
            N:FireServer("RequestAFKDisplay",false)
            task.wait(0.01)
        else task.wait(0.01)
        end
    end
end)
X[19]=(getgenv())
X[100]={Enabled=false}
X[100].Color = (Color3.fromRGB(78,127,252))
X[100].Thickness=2
X[100].Radius=2.5
X[100].NumSegments=32
X[19].TargetHorizontalArcConfig=X[100]
local N,g={},40
for I=1,g,1 do X[30]=(Drawing.new("Line"))
    X[30].Thickness = getgenv().TargetHorizontalArcConfig.Thickness
    X[30].Visible=false
    X[30].ZIndex=3
    table.insert(N,X[30])
end
local function I()local p,P,a=getgenv().TargetHorizontalArcConfig,workspace.CurrentCamera,Config and Config.ForceHit and Config.ForceHit.Target or getgenv().KillAura and getgenv().KillAura.CurrentTarget or CurrentLegitTarget
    if not p.Enabled or not a or not a.Character then for v,v in ipairs(N)do v.Visible=false
        end
        return
    end
    local v=Config and Config.ForceHit and Config.ForceHit.HitPart or "Head"
    local H=a.Character:FindFirstChild(v)or a.Character:FindFirstChild("Head")or a.Character:FindFirstChild("HumanoidRootPart")
    if not H then for x,x in ipairs(N)do x.Visible=false
        end
        return
    end
    local x,L,Y=H.Position,p.NumSegments,tick()
    v=(math.sin(Y*2.5)+1)*0.25+0.5
    local r,K,C,l=math.floor(L*v),Y*0.8,{},true
    for h=0,r,1 do Y=K+h/L*6.283185307179586
        v,h=math.cos(Y)*p.Radius,math.sin(Y)*p.Radius
        H=x+Vector3.new(v,0,h)
        h,a=P:WorldToViewportPoint(H)
        l=if not a then false else l
            table.insert(C,Vector2.new(h.X,h.Y))
        end
        for P=1,g,1 do L=N[P]
            if P<=#C-1 then x,Y=C[P],C[P+1]
                L.From=x
                L.To=Y
                L.Color=p.Color
                L.Thickness=p.Thickness
                L.Visible=true
            else L.Visible=false
            end
        end
    end
    S.RenderStepped:Connect(I)
    X[177]=getgenv().TargetVisualsSection
    if X[177]then X[216]=(getgenv().TargetVisualsSection:AddLabel("Circle around target"))
        X[216]:AddToggle({
            Default = false,
            Flag = "Visuals_TargetHArc",
            Callback = function(N)getgenv().TargetHorizontalArcConfig.Enabled=N
                    end,
        })
        X[216]:AddColorPicker({
            Default = Color3.fromRGB(78,127,252),
            Flag = "Visuals_TargetHArcColor",
            Callback = function(N)getgenv().TargetHorizontalArcConfig.Color=N
                    end,
        })
    end

