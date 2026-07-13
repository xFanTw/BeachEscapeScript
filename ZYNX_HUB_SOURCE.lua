local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local CONFIG = {
    ValidKey = "YOUR_KEY_FOR_SCRIPT_HERE", -- Replace to your own key Idea here. ;)
    DiscordInvite = "GET_KEY_LINK", -- I used Discord :)
    MaxRetries = 10,
}

local function CreateKeyGUI()
    local oldGui = PlayerGui:FindFirstChild("KeySystemGUI")
    if oldGui then oldGui:Destroy() end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeySystemGUI"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 450, 0, 380)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -190)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    mainFrame.BackgroundTransparency = 0.08
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    local glowBorder = Instance.new("Frame")
    glowBorder.Name = "GlowBorder"
    glowBorder.Size = UDim2.new(1, 6, 1, 6)
    glowBorder.Position = UDim2.new(0, -3, 0, -3)
    glowBorder.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
    glowBorder.BackgroundTransparency = 0.7
    glowBorder.BorderSizePixel = 0
    glowBorder.Parent = mainFrame

    local innerGlow = Instance.new("Frame")
    innerGlow.Name = "InnerGlow"
    innerGlow.Size = UDim2.new(1, -12, 1, -12)
    innerGlow.Position = UDim2.new(0, 6, 0, 6)
    innerGlow.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    innerGlow.BackgroundTransparency = 0.85
    innerGlow.BorderSizePixel = 0
    innerGlow.Parent = mainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame

    local innerCorner = Instance.new("UICorner")
    innerCorner.CornerRadius = UDim.new(0, 8)
    innerCorner.Parent = glowBorder

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 15)
    title.BackgroundTransparency = 1
    title.Text = "Zynx Hub"
    title.TextColor3 = Color3.fromRGB(255, 220, 180)
    title.TextSize = 30
    title.Font = Enum.Font.GothamBold
    title.TextStrokeTransparency = 0.3
    title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    title.Parent = mainFrame

    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Size = UDim2.new(1, 0, 0, 30)
    subtitle.Position = UDim2.new(0, 0, 0, 60)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Enter your access key to play"
    subtitle.TextColor3 = Color3.fromRGB(180, 180, 200)
    subtitle.TextSize = 16
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextTransparency = 0.3
    subtitle.Parent = mainFrame

    local inputBg = Instance.new("Frame")
    inputBg.Name = "InputBg"
    inputBg.Size = UDim2.new(0.8, 0, 0, 50)
    inputBg.Position = UDim2.new(0.1, 0, 0, 110)
    inputBg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    inputBg.BackgroundTransparency = 0.3
    inputBg.BorderSizePixel = 0
    inputBg.Parent = mainFrame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = inputBg

    local inputGlow = Instance.new("Frame")
    inputGlow.Name = "InputGlow"
    inputGlow.Size = UDim2.new(1, 4, 1, 4)
    inputGlow.Position = UDim2.new(0, -2, 0, -2)
    inputGlow.BackgroundColor3 = Color3.fromRGB(100, 100, 140)
    inputGlow.BackgroundTransparency = 0.8
    inputGlow.BorderSizePixel = 0
    inputGlow.Parent = inputBg

    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0, 10)
    glowCorner.Parent = inputGlow

    local keyInput = Instance.new("TextBox")
    keyInput.Name = "KeyInput"
    keyInput.Size = UDim2.new(1, -20, 1, -10)
    keyInput.Position = UDim2.new(0, 10, 0, 5)
    keyInput.BackgroundTransparency = 1
    keyInput.Text = ""
    keyInput.PlaceholderText = "Enter your key..."
    keyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 130)
    keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyInput.TextSize = 18
    keyInput.Font = Enum.Font.Gotham
    keyInput.TextXAlignment = Enum.TextXAlignment.Center
    keyInput.ClearTextOnFocus = false
    keyInput.Parent = inputBg

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(1, 0, 0, 30)
    statusLabel.Position = UDim2.new(0, 0, 0, 175)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = mainFrame

    local submitBtn = Instance.new("TextButton")
    submitBtn.Name = "SubmitBtn"
    submitBtn.Size = UDim2.new(0.4, 0, 0, 50)
    submitBtn.Position = UDim2.new(0.05, 0, 0, 220)
    submitBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
    submitBtn.BackgroundTransparency = 0.2
    submitBtn.BorderSizePixel = 0
    submitBtn.Text = "UNLOCK"
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.TextSize = 18
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = submitBtn

    local btnGlow = Instance.new("Frame")
    btnGlow.Name = "BtnGlow"
    btnGlow.Size = UDim2.new(1, 4, 1, 4)
    btnGlow.Position = UDim2.new(0, -2, 0, -2)
    btnGlow.BackgroundColor3 = Color3.fromRGB(150, 150, 200)
    btnGlow.BackgroundTransparency = 0.8
    btnGlow.BorderSizePixel = 0
    btnGlow.Parent = submitBtn

    local btnGlowCorner = Instance.new("UICorner")
    btnGlowCorner.CornerRadius = UDim.new(0, 10)
    btnGlowCorner.Parent = btnGlow

    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Name = "GetKeyBtn"
    getKeyBtn.Size = UDim2.new(0.4, 0, 0, 50)
    getKeyBtn.Position = UDim2.new(0.55, 0, 0, 220)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    getKeyBtn.BackgroundTransparency = 0.3
    getKeyBtn.BorderSizePixel = 0
    getKeyBtn.Text = "GET KEY"
    getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    getKeyBtn.TextSize = 18
    getKeyBtn.Font = Enum.Font.GothamBold
    getKeyBtn.Parent = mainFrame

    local getKeyCorner = Instance.new("UICorner")
    getKeyCorner.CornerRadius = UDim.new(0, 8)
    getKeyCorner.Parent = getKeyBtn

    local getKeyGlow = Instance.new("Frame")
    getKeyGlow.Name = "GetKeyGlow"
    getKeyGlow.Size = UDim2.new(1, 4, 1, 4)
    getKeyGlow.Position = UDim2.new(0, -2, 0, -2)
    getKeyGlow.BackgroundColor3 = Color3.fromRGB(150, 150, 255)
    getKeyGlow.BackgroundTransparency = 0.8
    getKeyGlow.BorderSizePixel = 0
    getKeyGlow.Parent = getKeyBtn

    local getKeyGlowCorner = Instance.new("UICorner")
    getKeyGlowCorner.CornerRadius = UDim.new(0, 10)
    getKeyGlowCorner.Parent = getKeyGlow

    local discordBtn = Instance.new("TextButton")
    discordBtn.Name = "DiscordBtn"
    discordBtn.Size = UDim2.new(0.6, 0, 0, 35)
    discordBtn.Position = UDim2.new(0.2, 0, 0, 290)
    discordBtn.BackgroundTransparency = 1
    discordBtn.Text = "Join our Discord for the key"
    discordBtn.TextColor3 = Color3.fromRGB(150, 150, 200)
    discordBtn.TextSize = 14
    discordBtn.Font = Enum.Font.Gotham
    discordBtn.Parent = mainFrame

    local loadingBar = Instance.new("Frame")
    loadingBar.Name = "LoadingBar"
    loadingBar.Size = UDim2.new(0, 0, 0, 4)
    loadingBar.Position = UDim2.new(0, 0, 0, 340)
    loadingBar.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    loadingBar.BorderSizePixel = 0
    loadingBar.BackgroundTransparency = 0.5
    loadingBar.Parent = mainFrame

    local loadingBg = Instance.new("Frame")
    loadingBg.Name = "LoadingBg"
    loadingBg.Size = UDim2.new(0.8, 0, 0, 4)
    loadingBg.Position = UDim2.new(0.1, 0, 0, 340)
    loadingBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    loadingBg.BackgroundTransparency = 0.5
    loadingBg.BorderSizePixel = 0
    loadingBg.Parent = mainFrame

    local loadCorner = Instance.new("UICorner")
    loadCorner.CornerRadius = UDim.new(0, 2)
    loadCorner.Parent = loadingBg
    loadCorner.Parent = loadingBar

    local dragging = false
    local dragStart, startPos
    
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X,
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    local retries = 0
    
    getKeyBtn.MouseButton1Click:Connect(function()
        setclipboard(CONFIG.DiscordInvite)
        statusLabel.Text = "Discord invite copied to clipboard"
        statusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
        task.wait(2.5)
        statusLabel.Text = ""
    end)
    
    discordBtn.MouseButton1Click:Connect(function()
        setclipboard(CONFIG.DiscordInvite)
        statusLabel.Text = "Discord invite copied to clipboard"
        statusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
        task.wait(2.5)
        statusLabel.Text = ""
    end)
    
    submitBtn.MouseButton1Click:Connect(function()
        local enteredKey = keyInput.Text
        
        if enteredKey == CONFIG.ValidKey then
            statusLabel.Text = "ACCESS GRANTED"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            submitBtn.Text = "UNLOCKED"
            submitBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
            getKeyBtn.Visible = false
            
            loadingBar.BackgroundTransparency = 0
            loadingBar.Size = UDim2.new(0, 0, 0, 4)
            for i = 1, 100 do
                loadingBar.Size = UDim2.new(i / 100 * 0.8, 0, 0, 4)
                task.wait(0.02)
            end
            loadingBar.BackgroundTransparency = 0.3
            
            task.wait(0.5)
            
            TweenService:Create(mainFrame, TweenInfo.new(0.3), {
                BackgroundTransparency = 1
            }):Play()
            
            task.wait(0.3)
            screenGui:Destroy()
            
            print("Zynx Hub loaded")
            

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TextService = game:GetService("TextService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")


local Theme = {
	Background   = Color3.fromRGB(14, 14, 16),
	Panel        = Color3.fromRGB(22, 22, 25),
	Elevated     = Color3.fromRGB(32, 32, 36),
	Stroke       = Color3.fromRGB(4, 4, 5),

	MetalLight   = Color3.fromRGB(150, 150, 158), 
	MetalDark    = Color3.fromRGB(18, 18, 20),  

	AccentGreen  = Color3.fromRGB(60, 200, 110),  
	AccentGrey   = Color3.fromRGB(120, 120, 130), 

	Text     = Color3.fromRGB(235, 235, 240),
	SubText  = Color3.fromRGB(150, 150, 158),

	TabActive   = Color3.fromRGB(48, 48, 54),
	TabInactive = Color3.fromRGB(24, 24, 27),
}

local CORNER_RADIUS = UDim.new(0, 10)


local function corner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = radius or CORNER_RADIUS
	c.Parent = parent
	return c
end

local function stroke(parent, thickness, color)
	local s = Instance.new("UIStroke")
	s.Thickness = thickness or 2
	s.Color = color or Theme.Stroke
	s.Parent = parent
	return s
end


local function addMetalShine(parent, animated)
	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.0, Theme.MetalDark),
		ColorSequenceKeypoint.new(0.45, Theme.MetalLight),
		ColorSequenceKeypoint.new(0.55, Theme.MetalLight),
		ColorSequenceKeypoint.new(1.0, Theme.MetalDark),
	})
	gradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0.0, 0.55),
		NumberSequenceKeypoint.new(0.5, 0.1),
		NumberSequenceKeypoint.new(1.0, 0.55),
	})
	gradient.Rotation = 100
	gradient.Parent = parent

	if animated then
		task.spawn(function()
			while gradient.Parent do
				local t1 = TweenService:Create(gradient, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Offset = Vector2.new(0.6, 0)})
				t1:Play(); t1.Completed:Wait()
				if not gradient.Parent then break end
				local t2 = TweenService:Create(gradient, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Offset = Vector2.new(-0.6, 0)})
				t2:Play(); t2.Completed:Wait()
			end
		end)
	end
	return gradient
end


local function makeDraggable(frame, dragHandle)
	local dragging, dragStart, startPos = false, nil, nil

	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end


local ZynxHub = {}
ZynxHub.__index = ZynxHub

function ZynxHub:CreateWindow(config)
	config = config or {}
	local title = config.Title or "Zynx Hub"


	local old = PlayerGui:FindFirstChild("ZynxHub")
	if old then old:Destroy() end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ZynxHub"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = PlayerGui

	local main = Instance.new("Frame")
	main.Name = "Main"
	main.Size = UDim2.new(0, 560, 0, 380)
	main.Position = UDim2.new(0.5, -280, 0.5, -190)
	main.BackgroundColor3 = Theme.Background
	main.Parent = screenGui
	corner(main)
	stroke(main, 2, Color3.fromRGB(55, 55, 60))

	
	local titleBar = Instance.new("Frame")
	titleBar.Size = UDim2.new(1, 0, 0, 44)
	titleBar.BackgroundColor3 = Theme.Elevated
	titleBar.Parent = main
	corner(titleBar)
	stroke(titleBar, 1, Color3.fromRGB(60, 60, 66))
	addMetalShine(titleBar, true)

	local titleLabel = Instance.new("TextLabel")
	titleLabel.BackgroundTransparency = 1
	titleLabel.Size = UDim2.new(1, -20, 1, 0)
	titleLabel.Position = UDim2.new(0, 14, 0, 0)
	titleLabel.Text = title
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 20
	titleLabel.TextColor3 = Theme.Text
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextYAlignment = Enum.TextYAlignment.Bottom
	titleLabel.Parent = titleBar

	makeDraggable(main, titleBar)


	local tabList = Instance.new("Frame")
	tabList.Size = UDim2.new(0, 140, 1, -54)
	tabList.Position = UDim2.new(0, 0, 0, 54)
	tabList.BackgroundColor3 = Theme.Panel
	tabList.Parent = main
	corner(tabList)

	local tabLayout = Instance.new("UIListLayout")
	tabLayout.Padding = UDim.new(0, 6)
	tabLayout.Parent = tabList
	local tabPad = Instance.new("UIPadding")
	tabPad.PaddingTop = UDim.new(0, 8)
	tabPad.PaddingLeft = UDim.new(0, 8)
	tabPad.PaddingRight = UDim.new(0, 8)
	tabPad.Parent = tabList

	
	local contentHolder = Instance.new("Frame")
	contentHolder.Size = UDim2.new(1, -156, 1, -64)
	contentHolder.Position = UDim2.new(0, 148, 0, 58)
	contentHolder.BackgroundTransparency = 1
	contentHolder.Parent = main

	local window = setmetatable({
		Gui = screenGui,
		Main = main,
		TabList = tabList,
		ContentHolder = contentHolder,
		Tabs = {},
	}, ZynxHub)

	return window
end


function ZynxHub:CreateTab(name)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 34)
	btn.BackgroundColor3 = Theme.TabInactive
	btn.Text = name
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 15
	btn.TextColor3 = Theme.SubText
	btn.AutoButtonColor = false
	btn.Parent = self.TabList
	corner(btn, UDim.new(0, 6))

	local page = Instance.new("ScrollingFrame")
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.ScrollBarThickness = 4
	page.Visible = false
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.Parent = self.ContentHolder

	local pageLayout = Instance.new("UIListLayout")
	pageLayout.Padding = UDim.new(0, 10)
	pageLayout.Parent = page

	local tab = { Button = btn, Page = page }
	table.insert(self.Tabs, tab)

	local function selectTab()
		for _, t in ipairs(self.Tabs) do
			t.Page.Visible = false
			TweenService:Create(t.Button, TweenInfo.new(0.15), {BackgroundColor3 = Theme.TabInactive}):Play()
			t.Button.TextColor3 = Theme.SubText
		end
		page.Visible = true
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.TabActive}):Play()
		btn.TextColor3 = Theme.Text
	end

	btn.MouseButton1Click:Connect(selectTab)

	if #self.Tabs == 1 then selectTab() end

	return setmetatable(tab, {__index = ZynxHub})
end


function ZynxHub:CreateSection(name)
	local section = Instance.new("Frame")
	section.Size = UDim2.new(1, -10, 0, 40) 
	section.AutomaticSize = Enum.AutomaticSize.Y
	section.BackgroundColor3 = Theme.Panel
	section.Parent = self.Page
	corner(section)
	stroke(section, 1, Color3.fromRGB(48, 48, 52))

	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0, 10)
	pad.PaddingBottom = UDim.new(0, 10)
	pad.PaddingLeft = UDim.new(0, 10)
	pad.PaddingRight = UDim.new(0, 10)
	pad.Parent = section

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.Parent = section

	local title = Instance.new("TextLabel")
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(1, 0, 0, 20)
	title.Text = name
	title.Font = Enum.Font.GothamBold
	title.TextSize = 15
	title.TextColor3 = Theme.Text
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = section

	return setmetatable({ Frame = section }, ZynxHub)
end




function ZynxHub:CreateButton(text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 32)
	btn.BackgroundColor3 = Theme.Elevated
	btn.Text = text
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 14
	btn.TextColor3 = Theme.Text
	btn.AutoButtonColor = false
	btn.Parent = self.Frame
	corner(btn, UDim.new(0, 6))
	addMetalShine(btn, false)

	btn.MouseButton1Click:Connect(function()
		if callback then callback() end
	end)
	return btn
end


function ZynxHub:CreateActionRow(text, buttonText, callback)
	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1, 0, 0, 32)
	holder.BackgroundTransparency = 1
	holder.Parent = self.Frame

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, -90, 1, 0)
	label.Text = text
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = Theme.Text
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = holder

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 80, 0, 28)
	btn.Position = UDim2.new(1, -80, 0.5, -14)
	btn.BackgroundColor3 = Theme.Elevated
	btn.Text = buttonText or "Start"
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 13
	btn.TextColor3 = Theme.Text
	btn.AutoButtonColor = false
	btn.Parent = holder
	corner(btn, UDim.new(0, 6))
	addMetalShine(btn, false)

	btn.MouseButton1Click:Connect(function()
		if callback then callback() end
	end)
	return holder
end


function ZynxHub:CreateToggle(text, default, callback)
	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1, 0, 0, 32)
	holder.BackgroundTransparency = 1
	holder.Parent = self.Frame

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, -60, 1, 0)
	label.Text = text
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = Theme.Text
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = holder

	local track = Instance.new("Frame")
	track.Size = UDim2.new(0, 46, 0, 22)
	track.Position = UDim2.new(1, -46, 0.5, -11)
	track.BackgroundColor3 = default and Theme.AccentGreen or Theme.TabInactive
	track.Parent = holder
	corner(track, UDim.new(1, 0))

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 18, 0, 18)
	knob.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
	knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
	knob.Parent = track
	corner(knob, UDim.new(1, 0))

	local state = default or false
	local clickArea = Instance.new("TextButton")
	clickArea.Size = UDim2.new(1, 0, 1, 0)
	clickArea.BackgroundTransparency = 1
	clickArea.Text = ""
	clickArea.Parent = holder

	clickArea.MouseButton1Click:Connect(function()
		state = not state
		local goalPos = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
		local goalColor = state and Theme.AccentGreen or Theme.TabInactive
		TweenService:Create(knob, TweenInfo.new(0.15), {Position = goalPos}):Play()
		TweenService:Create(track, TweenInfo.new(0.15), {BackgroundColor3 = goalColor}):Play()
		if callback then callback(state) end
	end)

	return { Set = function(_, value)
		state = value
		knob.Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
		track.BackgroundColor3 = state and Theme.AccentGreen or Theme.TabInactive
	end }
end


function ZynxHub:CreateProgressBar(text, value)
	value = math.clamp(value or 0, 0, 1)

	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1, 0, 0, 42)
	holder.BackgroundTransparency = 1
	holder.Parent = self.Frame

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, 0, 0, 16)
	label.Text = text
	label.Font = Enum.Font.Gotham
	label.TextSize = 13
	label.TextColor3 = Theme.SubText
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = holder

	local barBack = Instance.new("Frame")
	barBack.Size = UDim2.new(1, 0, 0, 16)
	barBack.Position = UDim2.new(0, 0, 0, 20)
	barBack.BackgroundColor3 = Theme.TabInactive
	barBack.Parent = holder
	corner(barBack, UDim.new(0, 8))

	local barFill = Instance.new("Frame")
	barFill.Size = UDim2.new(value, 0, 1, 0)
	barFill.BackgroundColor3 = Theme.AccentGrey
	barFill.Parent = barBack
	corner(barFill, UDim.new(0, 8))
	addMetalShine(barFill, false)

	return { Set = function(_, newValue)
		newValue = math.clamp(newValue, 0, 1)
		TweenService:Create(barFill, TweenInfo.new(0.25), {Size = UDim2.new(newValue, 0, 1, 0)}):Play()
	end }
end


function ZynxHub:CreateLabel(text)
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextWrapped = true
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 14
	label.TextColor3 = Theme.SubText
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Top
	label.Size = UDim2.new(1, 0, 0, 0)
	label.Parent = self.Frame

	local availableWidth = self.Frame.AbsoluteSize.X - 24
	if availableWidth <= 0 then availableWidth = 300 end
	local textBounds = TextService:GetTextSize(text, label.TextSize, label.Font, Vector2.new(availableWidth, math.huge))
	label.Size = UDim2.new(1, 0, 0, textBounds.Y + 4)

	return label
end

function ZynxHub:CreateSlider(text, min, max, default, callback)
	min, max = min or 0, max or 100
	default = default or min

	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1, 0, 0, 42)
	holder.BackgroundTransparency = 1
	holder.Parent = self.Frame

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, 0, 0, 16)
	label.Text = text .. ": " .. tostring(default)
	label.Font = Enum.Font.Gotham
	label.TextSize = 13
	label.TextColor3 = Theme.SubText
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = holder

	local track = Instance.new("Frame")
	track.Size = UDim2.new(1, 0, 0, 10)
	track.Position = UDim2.new(0, 0, 0, 24)
	track.BackgroundColor3 = Theme.TabInactive
	track.Parent = holder
	corner(track, UDim.new(1, 0))

	local fill = Instance.new("Frame")
	local pct = (default - min) / (max - min)
	fill.Size = UDim2.new(pct, 0, 1, 0)
	fill.BackgroundColor3 = Theme.MetalLight
	fill.Parent = track
	corner(fill, UDim.new(1, 0))

	local dragging = false
	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local relative = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
			fill.Size = UDim2.new(relative, 0, 1, 0)
			local val = math.floor(min + (max - min) * relative)
			label.Text = text .. ": " .. tostring(val)
			if callback then callback(val) end
		end
	end)

	return holder
end


local Window = ZynxHub:CreateWindow({ Title = "Zynx Hub" })


local FarmingTab = Window:CreateTab("Farming")
local FarmingSection = FarmingTab:CreateSection("Farming")


FarmingSection:CreateActionRow("Auto Farm Wins (Spam Me)", "Start", function() 
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local targetPosition = Vector3.new(-1281.85, 9.43, 1150.56)

    while true do
        task.wait(1.1)

        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:FindFirstChild("HumanoidRootPart")

        if hrp then
            hrp.CFrame = CFrame.new(targetPosition)
        end
    end
end)
FarmingSection:CreateActionRow("Auto Farm Speed (Spam Me)", "Start", function() 
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local AddSpeed = ReplicatedStorage.Events.AddSpeed

    local function executeScript()
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
    
        local interval = 0.00016  
        local accumulatedTime = 0
    
        local heartbeatConnection
        heartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime)
            accumulatedTime += deltaTime
            if accumulatedTime >= interval then
                accumulatedTime -= interval
                pcall(function()
                    AddSpeed:FireServer()
                end)
            end
        end)
    
    
        return heartbeatConnection
    end


    executeScript()

end)

FarmingSection:CreateSlider("WalkSpeed Changer", 16, 400, 16, function(val)
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = val
	end
end, "Normal")


FarmingSection:CreateToggle("GodMode", false, function(state) 
	if state then
        local Workspace = game:GetService("Workspace")
        local Players = game:GetService("Players")

        local function replaceKillParts()
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name == "KillPart" and obj:IsA("BasePart") then
                    local newPart = Instance.new("Part")
                    newPart.Name = "NormalPart"
                    newPart.Size = obj.Size
                    newPart.CFrame = obj.CFrame
                    newPart.Anchored = obj.Anchored
                    newPart.Color = Color3.fromRGB(163, 162, 165)
                    newPart.Material = Enum.Material.Plastic
                    newPart.Parent = obj.Parent
                    obj:Destroy()
                end
            end
        end

        local function removeByName(name)
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name == name then
                    obj:Destroy()
                end
            end
        end

        local function removeSpecific(path)
            local obj = Workspace
            for _, part in ipairs(path) do
                obj = obj:FindFirstChild(part)
                if not obj then return end
            end
            obj:Destroy()
        end

       
        local player = Players.LocalPlayer
        task.wait(1)
        if player and player.Character then
            for _, part in ipairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Size = part.Size * 1.5
                end
            end
        end

       
        removeSpecific({"Folder", "wasser"})
        removeSpecific({"Wave", "Wave"})

        
        while state do  
           replaceKillParts()
    
            removeByName("Crusher")
            removeByName("Crusher1")
            removeByName("Crusher2")
            removeByName("Crusher3")
            removeByName("Crusher4")
            removeByName("Crusher5")
    
            removeByName("LavaPart")
    
           
            removeSpecific({"Folder", "wasser"})
    
          
    
            task.wait(5)
        end
    else
       
        print("GodMode off. Please rejoin the game to reset GodMode.")
    end
end)

FarmingSection:CreateToggle("Anti AFK", false, function(state)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local runService = game:GetService("RunService")
    
   
    local isRunning = state
    local jumpTimer = 0
    local rotationAngle = 0
    local connection = nil
    local charAddedConnection = nil
    
    
    local function jump()
        if humanoid and humanoid.SeatPart == nil and humanoid.Health > 0 then
            humanoid.Jump = true
        end
    end
    
   
    local function moveInCircle(deltaTime)
        if not rootPart or not humanoid or humanoid.Health <= 0 then return end
        
        local angle = rotationAngle + math.rad(90)
        local moveDirection = Vector3.new(math.cos(angle), 0, math.sin(angle))
        
        humanoid:Move(moveDirection, true)
        
        rotationAngle = rotationAngle + (deltaTime * 0.8)
        if rotationAngle > math.pi * 2 then
            rotationAngle = rotationAngle - math.pi * 2
        end
    end
    
  
    local function startAntiAFK()
        if connection then return end
        
        connection = runService.RenderStepped:Connect(function(deltaTime)
            if not isRunning then return end
            if not character or not character.Parent then return end
            if not humanoid or humanoid.Health <= 0 then return end
            
            jumpTimer = jumpTimer + deltaTime
            if jumpTimer >= 0.5 then
                jump()
                jumpTimer = 0
            end
            
            moveInCircle(deltaTime)
        end)
    end
    
    
    local function stopAntiAFK()
       
        if connection then
            connection:Disconnect()
            connection = nil
        end
        
       
        if charAddedConnection then
            charAddedConnection:Disconnect()
            charAddedConnection = nil
        end
        
     
        if humanoid then
            humanoid:Move(Vector3.new(0, 0, 0), false)
        end
        
      
        jumpTimer = 0
        rotationAngle = 0
        isRunning = false
    end
    
    
    if state then
    
        isRunning = true
        
        
        charAddedConnection = player.CharacterAdded:Connect(function(newCharacter)
            character = newCharacter
            rootPart = character:WaitForChild("HumanoidRootPart")
            humanoid = character:WaitForChild("Humanoid")
            jumpTimer = 0
            rotationAngle = 0
            
           
            if isRunning then
                stopAntiAFK()
                startAntiAFK()
            end
        end)
        
        startAntiAFK()
        print("AntiAFK On.")
    else
     
        stopAntiAFK()
        
   
        if humanoid and humanoid.Health > 0 then
            humanoid.Health = 0
        end
        
        print("AntiAFK off")
    end
end)

local BoostTab = Window:CreateTab("Boosts")
local BoostSection = BoostTab:CreateSection("Boosts")

BoostSection:CreateActionRow("FPS Boost (Do Not Spam)", "Start", function() 
    local function removeAllTextures()
      
        for _, decal in ipairs(workspace:GetDescendants()) do
            if decal:IsA("Decal") then
                decal.Transparency = 1  
                
            end
        end

       
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Texture") then
                obj.Transparency = 1
            end
        end

        
        for _, gui in ipairs(game:GetDescendants()) do
            if gui:IsA("ImageLabel") or gui:IsA("ImageButton") then
                gui.Image = "" 
                gui.BackgroundTransparency = 1  
            end
        end

        
        for _, surf in ipairs(workspace:GetDescendants()) do
            if surf:IsA("SurfaceGui") then
                for _, child in ipairs(surf:GetDescendants()) do
                    if child:IsA("ImageLabel") or child:IsA("ImageButton") then
                        child.Image = ""
                        child.BackgroundTransparency = 1
                    end
                end
            end
        end

        print("Loaded FPS.")
    end

   
    removeAllTextures()

end)

BoostSection:CreateActionRow("Ultra FPS Boost (Only for AFK)", "Start", function() 
    local function removeTextures()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            end
        end
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
                obj.Image = ""
            end
        end
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("SurfaceGui") then
                for _, child in ipairs(obj:GetDescendants()) do
                    if child:IsA("ImageLabel") or child:IsA("ImageButton") then
                        child.Image = ""
                    end
                end
            end
        end
    end
    
    local function disableEffects()
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = false
        lighting.FogEnd = 100
        lighting.Brightness = 1
        lighting.Ambient = Color3.new(0.7, 0.7, 0.7)
        lighting.Technology = Enum.Technology.Compatibility
        lighting.ClockTime = 12
        lighting.GeographicLatitude = 0
        
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                obj.Enabled = false
                obj:Destroy()
            end
            if obj:IsA("Light") or obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj.Enabled = false
            end
            if obj:IsA("Reflection") then
                obj.Enabled = false
            end
            if obj:IsA("Explosion") then
                obj.Visible = false
            end
        end
        
        local sky = lighting:FindFirstChild("Sky")
        if sky then
            sky.SkyboxBk = ""
            sky.SkyboxDn = ""
            sky.SkyboxFt = ""
            sky.SkyboxLf = ""
            sky.SkyboxRt = ""
            sky.SkyboxUp = ""
        end
        
        local atmosphere = workspace:FindFirstChild("Atmosphere")
        if atmosphere then
            atmosphere.Density = 0
            atmosphere.Offset = 0
            atmosphere.Color = Color3.new(1, 1, 1)
        end
        
        for _, obj in ipairs(lighting:GetDescendants()) do
            if obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or obj:IsA("SunRaysEffect") or obj:IsA("ColorCorrectionEffect") then
                obj.Enabled = false
            end
        end
    end
    
    local function optimizeTerrainAndMeshes()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Terrain") then
                obj.WaterReflectance = 0
                obj.WaterRefraction = 0
                obj.WaterWaveSize = 0
                obj.WaterTransparency = 1
            end
            if obj:IsA("MeshPart") then
                obj.MeshId = ""
                obj.TextureID = ""
                obj.Color = Color3.new(1, 1, 1)
            end
        end
    end
    
    local function reduceGUI()
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("GuiObject") then
                obj.BackgroundTransparency = 1
                if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                    obj.TextTransparency = 1
                end
            end
        end
    end
    
    local function stopAnimations()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("AnimationTrack") or obj:IsA("Animator") then
                obj:Stop()
            end
        end
    end
    
    local function setCamera()
        local camera = workspace.CurrentCamera
        if camera then
            camera.FieldOfView = 70
        end
    end
    
    pcall(removeTextures)
    pcall(disableEffects)
    pcall(optimizeTerrainAndMeshes)
    pcall(reduceGUI)
    pcall(stopAnimations)
    pcall(setCamera)
    
    print("Boost activated again ;)")
end)

local TrollTab = Window:CreateTab("Troll")
local TrollSection = TrollTab:CreateSection("Troll")

TrollSection:CreateActionRow("Activate Fly GUI", "Start", function() 

if _G.ZynxHubFlyLoaded then return end
_G.ZynxHubFlyLoaded = true


local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")


local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")


local flySpeed = 1
local flyTransparency = 0.75
local FLYING = false
local isFlyToggledOn = false
local useCFrameFly = false
local bodyGyro, bodyVelocity, CFloop, noclipConnection


local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZynxHubFly"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local uiScale = Instance.new("UIScale", screenGui)

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 280, 0, 190)
mainFrame.Position = UDim2.new(0.5, -140, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true

local uiCorner = Instance.new("UICorner", mainFrame)
uiCorner.CornerRadius = UDim.new(0, 10)

local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(88, 101, 242)

local gradient = Instance.new("UIGradient", mainFrame)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 22, 28)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 32, 40))
})

local headerFrame = Instance.new("Frame", mainFrame)
headerFrame.Size = UDim2.new(1, 0, 0, 45)
headerFrame.BackgroundTransparency = 1

local titleLabel = Instance.new("TextLabel", headerFrame)
titleLabel.Size = UDim2.new(1, -90, 1, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "Zynx Hub Fly"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local versionLabel = Instance.new("TextLabel", headerFrame)
versionLabel.Size = UDim2.new(1, -90, 0, 15)
versionLabel.Position = UDim2.new(0, 5, 0, 28)
versionLabel.BackgroundTransparency = 1
versionLabel.Font = Enum.Font.Gotham
versionLabel.Text = "v2.0"
versionLabel.TextColor3 = Color3.fromRGB(88, 101, 242)
versionLabel.TextSize = 12
versionLabel.TextXAlignment = Enum.TextXAlignment.Left
versionLabel.TextTransparency = 0.5

local closeButton = Instance.new("TextButton", headerFrame)
closeButton.Size = UDim2.new(0, 14, 0, 14)
closeButton.Position = UDim2.new(1, -22, 0.5, -7)
closeButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 12
closeButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(1, 0)

local minimizeButton = Instance.new("TextButton", headerFrame)
minimizeButton.Size = UDim2.new(0, 14, 0, 14)
minimizeButton.Position = UDim2.new(1, -42, 0.5, -7)
minimizeButton.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
minimizeButton.Text = "−"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 14
minimizeButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(1, 0)

local cframeToggle = Instance.new("TextButton", headerFrame)
cframeToggle.Size = UDim2.new(0, 30, 0, 22)
cframeToggle.Position = UDim2.new(1, -78, 0.5, -11)
cframeToggle.BackgroundColor3 = Color3.fromRGB(44, 46, 51)
cframeToggle.Font = Enum.Font.GothamBold
cframeToggle.Text = "CF"
cframeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
cframeToggle.TextSize = 12
Instance.new("UICorner", cframeToggle).CornerRadius = UDim.new(0, 4)
local cframeStroke = Instance.new("UIStroke", cframeToggle)
cframeStroke.Color = Color3.fromRGB(20, 20, 20)

local bodyFrame = Instance.new("Frame", mainFrame)
bodyFrame.Size = UDim2.new(1, 0, 1, -45)
bodyFrame.Position = UDim2.new(0, 0, 0, 45)
bodyFrame.BackgroundTransparency = 1

local flyButton = Instance.new("TextButton", bodyFrame)
flyButton.Size = UDim2.new(1, -20, 0, 38)
flyButton.Position = UDim2.new(0, 10, 0, 8)
flyButton.BackgroundColor3 = Color3.fromRGB(44, 46, 51)
flyButton.Font = Enum.Font.GothamBold
flyButton.Text = "Activate Zynx Fly"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextSize = 16
Instance.new("UICorner", flyButton).CornerRadius = UDim.new(0, 6)
local flyStroke = Instance.new("UIStroke", flyButton)
flyStroke.Color = Color3.fromRGB(20, 20, 20)

local speedSliderLabel = Instance.new("TextLabel", bodyFrame)
speedSliderLabel.Size = UDim2.new(1, -20, 0, 20)
speedSliderLabel.Position = UDim2.new(0, 10, 0, 54)
speedSliderLabel.BackgroundTransparency = 1
speedSliderLabel.Font = Enum.Font.Gotham
speedSliderLabel.Text = "Speed: 1"
speedSliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
speedSliderLabel.TextSize = 14
speedSliderLabel.TextXAlignment = Enum.TextXAlignment.Left

local speedSlider = Instance.new("Frame", bodyFrame)
speedSlider.Size = UDim2.new(1, -20, 0, 6)
speedSlider.Position = UDim2.new(0, 10, 0, 78)
speedSlider.BackgroundColor3 = Color3.fromRGB(20, 22, 25)
Instance.new("UICorner", speedSlider).CornerRadius = UDim.new(0, 3)

local sliderBar = Instance.new("Frame", speedSlider)
sliderBar.Size = UDim2.new(0, 0, 1, 0)
sliderBar.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
Instance.new("UICorner", sliderBar).CornerRadius = UDim.new(0, 3)

local sliderHandle = Instance.new("TextButton", speedSlider)
sliderHandle.Size = UDim2.new(0, 18, 0, 18)
sliderHandle.Position = UDim2.new(0, -9, 0.5, -9)
sliderHandle.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
sliderHandle.Text = ""
Instance.new("UICorner", sliderHandle).CornerRadius = UDim.new(1, 0)

local handleGlow = Instance.new("UIGradient", sliderHandle)
handleGlow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 101, 242)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 140, 255))
})

local transparencyLabel = Instance.new("TextLabel", bodyFrame)
transparencyLabel.Size = UDim2.new(0.5, -15, 0, 30)
transparencyLabel.Position = UDim2.new(0, 10, 0, 92)
transparencyLabel.BackgroundTransparency = 1
transparencyLabel.Font = Enum.Font.Gotham
transparencyLabel.Text = "Opacity:"
transparencyLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
transparencyLabel.TextSize = 14
transparencyLabel.TextXAlignment = Enum.TextXAlignment.Left

local transparencyBox = Instance.new("TextBox", bodyFrame)
transparencyBox.Size = UDim2.new(0.5, -15, 0, 30)
transparencyBox.Position = UDim2.new(0.5, 5, 0, 92)
transparencyBox.BackgroundColor3 = Color3.fromRGB(20, 22, 25)
transparencyBox.Font = Enum.Font.Gotham
transparencyBox.Text = tostring(flyTransparency)
transparencyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
transparencyBox.TextSize = 14
transparencyBox.ClearTextOnFocus = false
Instance.new("UICorner", transparencyBox).CornerRadius = UDim.new(0, 4)

local controlsLabel = Instance.new("TextLabel", bodyFrame)
controlsLabel.Size = UDim2.new(1, -20, 0, 16)
controlsLabel.Position = UDim2.new(0, 10, 0, 128)
controlsLabel.BackgroundTransparency = 1
controlsLabel.Font = Enum.Font.Gotham
controlsLabel.Text = "WASD • Q/E • Click Fly to toggle"
controlsLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
controlsLabel.TextSize = 11
controlsLabel.TextTransparency = 0.5


local function makeDraggable(guiObject, dragHandle)
    local dragging = false
    local dragStart, startPos
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
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
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(mainFrame, headerFrame)


local function NoclipLoop()
    if character ~= nil then
        for _, child in pairs(character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end


local function startCFrameFlyLoop()
    if not character or not character:FindFirstChild("Head") then return end
    FLYING = true
    local Head = character.Head
    Head.Anchored = true
    CFloop = RunService.Heartbeat:Connect(function(deltaTime)
        local effectiveSpeed = flySpeed * 10
        local moveDirection = humanoid.MoveDirection * (effectiveSpeed * deltaTime)
        local headCFrame = Head.CFrame
        local camera = workspace.CurrentCamera
        local cameraCFrame = camera.CFrame
        local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
        cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
        local cameraPosition = cameraCFrame.Position
        local headPosition = headCFrame.Position
        local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
        Head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
    end)
end

local function startBodyMoverFlyLoop()
    if not character or not rootPart or not humanoid then return end
    FLYING = true
    noclipConnection = RunService.Heartbeat:Connect(NoclipLoop)
    task.spawn(function()
        bodyGyro = Instance.new('BodyGyro', rootPart)
        bodyGyro.P = 9e4
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.CFrame = rootPart.CFrame
        bodyVelocity = Instance.new('BodyVelocity', rootPart)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        if humanoid then humanoid.PlatformStand = true end
        repeat
            task.wait()
            local camera = workspace.CurrentCamera
            local moveVector = ((camera.CFrame.LookVector * (CONTROL.F + CONTROL.B)) + ((camera.CFrame * CFrame.new((CONTROL.L + CONTROL.R), (CONTROL.Q + CONTROL.E) * 0.2, 0).p) - camera.CFrame.p))
            bodyVelocity.Velocity = moveVector.Magnitude > 0 and moveVector.Unit * flySpeed or Vector3.new(0,0,0)
            bodyGyro.CFrame = camera.CFrame
        until not FLYING or not rootPart.Parent
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
        if humanoid and humanoid.Parent then humanoid.PlatformStand = false end
        CONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0}
    end)
end


local function updateSlider(input)
    local sliderWidth = speedSlider.AbsoluteSize.X
    local newX = math.clamp(input.Position.X - speedSlider.AbsolutePosition.X, 0, sliderWidth)
    local percentage = newX / sliderWidth
    flySpeed = 1 + (percentage * 499)
    speedSliderLabel.Text = string.format("Speed: %.0f", flySpeed)
    sliderBar.Size = UDim2.new(percentage, 0, 1, 0)
    sliderHandle.Position = UDim2.new(percentage, -9, 0.5, -9)
end

local function setFlying(state)
    isFlyToggledOn = state
    if FLYING == state or not character or not character.Parent then return end
    flyButton.TextColor3 = state and Color3.fromRGB(88, 101, 242) or Color3.fromRGB(255, 255, 255)
    flyStroke.Color = state and Color3.fromRGB(88, 101, 242) or Color3.fromRGB(20, 20, 20)

    if state then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = flyTransparency
            end
        end
        if useCFrameFly then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
            startCFrameFlyLoop()
        else
            startBodyMoverFlyLoop()
        end
    else
        FLYING = false
        if CFloop then CFloop:Disconnect(); CFloop = nil end
        if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
        if character and character:FindFirstChild("Head") then character.Head.Anchored = false end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                if part.Name ~= "HumanoidRootPart" then part.Transparency = 0 end
            end
        end
    end
end


local keyMap = {
    [Enum.KeyCode.W] = "F",
    [Enum.KeyCode.S] = "B",
    [Enum.KeyCode.A] = "L",
    [Enum.KeyCode.D] = "R",
    [Enum.KeyCode.Q] = "Q",
    [Enum.KeyCode.E] = "E"
}
local valueMap = {
    [Enum.KeyCode.W] = 1,
    [Enum.KeyCode.S] = -1,
    [Enum.KeyCode.A] = -1,
    [Enum.KeyCode.D] = 1,
    [Enum.KeyCode.Q] = -1,
    [Enum.KeyCode.E] = 1
}
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe or not keyMap[input.KeyCode] then return end
    CONTROL[keyMap[input.KeyCode]] = valueMap[input.KeyCode]
end)
UserInputService.InputEnded:Connect(function(input)
    if keyMap[input.KeyCode] then
        CONTROL[keyMap[input.KeyCode]] = 0
    end
end)


player.CharacterAdded:Connect(function(newChar)
    if CFloop then CFloop:Disconnect(); CFloop = nil end
    if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
    FLYING = false
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
    if isFlyToggledOn then setFlying(true) end
end)


closeButton.MouseButton1Click:Connect(function()
    _G.ZynxHubFlyLoaded = false
    screenGui:Destroy()
end)

flyButton.MouseButton1Click:Connect(function()
    setFlying(not isFlyToggledOn)
end)

cframeToggle.MouseButton1Click:Connect(function()
    useCFrameFly = not useCFrameFly
    cframeToggle.TextColor3 = useCFrameFly and Color3.fromRGB(88, 101, 242) or Color3.fromRGB(255, 255, 255)
    cframeStroke.Color = useCFrameFly and Color3.fromRGB(88, 101, 242) or Color3.fromRGB(20, 20, 20)
end)


local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    bodyFrame.Visible = not isMinimized
    local targetSize = isMinimized and UDim2.new(0, 280, 0, 45) or UDim2.new(0, 280, 0, 190)
    TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = targetSize}):Play()
end)

transparencyBox.FocusLost:Connect(function(enterPressed)
    local num = tonumber(transparencyBox.Text)
    if num and num >= 0 and num <= 1 then
        flyTransparency = num
        if FLYING then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = flyTransparency
                end
            end
        end
    else
        transparencyBox.Text = tostring(flyTransparency)
    end
end)

local isDraggingSlider = false
sliderHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingSlider = true
        updateSlider(input)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingSlider = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if isDraggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSlider(input)
    end
end)
end)

TrollSection:CreateActionRow("Open Bang Player GUI", "Start", function() 

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")


local selectedPlayer = nil
local speed = 4
local clappingSound = Instance.new("Sound")
clappingSound.SoundId = "rbxassetid://9114762281"
clappingSound.Looped = true
clappingSound.Volume = 0.5
local moving = false
local moveThread = nil
local isMinimized = false


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BangGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 280)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 32)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui


local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame


local GlossEffect = Instance.new("Frame")
GlossEffect.Size = UDim2.new(1, 0, 0, 2)
GlossEffect.Position = UDim2.new(0, 0, 0, 0)
GlossEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GlossEffect.BackgroundTransparency = 0.7
GlossEffect.BorderSizePixel = 0
GlossEffect.Parent = MainFrame

local GlossCorner = Instance.new("UICorner")
GlossCorner.CornerRadius = UDim.new(0, 12)
GlossCorner.Parent = GlossEffect


local Shadow = Instance.new("Frame")
Shadow.Size = UDim2.new(1, 8, 1, 8)
Shadow.Position = UDim2.new(0, -4, 0, -4)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.4
Shadow.BorderSizePixel = 0
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 14)
ShadowCorner.Parent = Shadow


local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 42)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar


local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "Bang Player"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar


local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -35, 0, 8)
CloseButton.Text = "✕"
CloseButton.TextSize = 16
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 62)
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton


local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 24, 0, 24)
MinimizeButton.Position = UDim2.new(1, -64, 0, 8)
MinimizeButton.Text = "−"
MinimizeButton.TextSize = 18
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 62)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinimizeButton


local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -30, 1, -55)
ContentFrame.Position = UDim2.new(0, 15, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame


local PlayerInput = Instance.new("TextBox")
PlayerInput.Size = UDim2.new(1, 0, 0, 36)
PlayerInput.Position = UDim2.new(0, 0, 0, 0)
PlayerInput.PlaceholderText = "Enter username"
PlayerInput.Text = ""
PlayerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerInput.TextSize = 14
PlayerInput.BackgroundColor3 = Color3.fromRGB(50, 50, 52)
PlayerInput.BorderSizePixel = 0
PlayerInput.ClearTextOnFocus = false
PlayerInput.Font = Enum.Font.Gotham
PlayerInput.Parent = ContentFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = PlayerInput


local PlayerInfo = Instance.new("TextLabel")
PlayerInfo.Size = UDim2.new(1, 0, 0, 28)
PlayerInfo.Position = UDim2.new(0, 0, 0, 42)
PlayerInfo.Text = "No player selected"
PlayerInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
PlayerInfo.TextSize = 13
PlayerInfo.BackgroundTransparency = 1
PlayerInfo.Font = Enum.Font.Gotham
PlayerInfo.Parent = ContentFrame


local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, 0, 0, 30)
SpeedFrame.Position = UDim2.new(0, 0, 0, 120)
SpeedFrame.BackgroundTransparency = 1
SpeedFrame.Parent = ContentFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.5, 0, 1, 0)
SpeedLabel.Text = "Speed: " .. speed
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 13
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Parent = SpeedFrame


local StartButton = Instance.new("TextButton")
StartButton.Size = UDim2.new(0, 95, 0, 40)
StartButton.Position = UDim2.new(0, 0, 0, 160)
StartButton.Text = "START"
StartButton.TextSize = 16
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.BackgroundColor3 = Color3.fromRGB(52, 199, 89)
StartButton.BorderSizePixel = 0
StartButton.Font = Enum.Font.GothamBold
StartButton.Parent = ContentFrame

local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(1, 0)
StartCorner.Parent = StartButton

local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(0, 95, 0, 40)
StopButton.Position = UDim2.new(1, -95, 0, 160)
StopButton.Text = "STOP"
StopButton.TextSize = 16
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.BackgroundColor3 = Color3.fromRGB(255, 69, 58)
StopButton.BorderSizePixel = 0
StopButton.Font = Enum.Font.GothamBold
StopButton.Parent = ContentFrame

local StopCorner = Instance.new("UICorner")
StopCorner.CornerRadius = UDim.new(1, 0)
StopCorner.Parent = StopButton


local function moveBackAndForth()
    local distanceForward = 2.5
    local distanceBack = 4.5
    local currentDist = distanceBack
    local movingForward = false
    
    while moving and selectedPlayer and selectedPlayer.Character and LocalPlayer.Character do
        local character = LocalPlayer.Character
        local targetChar = selectedPlayer.Character
        
        if character and targetChar then
            local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
            local root = character:FindFirstChild("HumanoidRootPart")
            
            if targetRoot and root then
                local targetPos = targetRoot.Position
                local lookVector = targetRoot.CFrame.LookVector
                
               
                local behindPos = targetPos - lookVector * currentDist
                local heightOffset = Vector3.new(0, 0.5, 0)
                behindPos = behindPos + heightOffset
                
            
                local newPos = root.Position + (behindPos - root.Position) * (speed / 10)
                root.CFrame = CFrame.new(newPos, targetPos)
                
               
                if movingForward then
                    currentDist = currentDist - 0.3
                    if currentDist <= distanceForward then
                        movingForward = false
                    end
                else
                    currentDist = currentDist + 0.3
                    if currentDist >= distanceBack then
                        movingForward = true
                    end
                end
            end
        end
        RunService.Heartbeat:Wait()
    end
end


local function startClappingSound()
    local character = LocalPlayer.Character
    if character then
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            clappingSound.Parent = root
            clappingSound:Play()
        end
    end
end


CloseButton.MouseButton1Click:Connect(function()
    moving = false
    clappingSound:Stop()
    ScreenGui:Destroy()
end)


MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    ContentFrame.Visible = not isMinimized
    MinimizeButton.Text = isMinimized and "+" or "−"
end)


local function setupHover(button, color, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
end

setupHover(StartButton, Color3.fromRGB(52, 199, 89), Color3.fromRGB(72, 219, 109))
setupHover(StopButton, Color3.fromRGB(255, 69, 58), Color3.fromRGB(255, 89, 78))
setupHover(CloseButton, Color3.fromRGB(60, 60, 62), Color3.fromRGB(200, 60, 60))
setupHover(MinimizeButton, Color3.fromRGB(60, 60, 62), Color3.fromRGB(80, 80, 82))


StartButton.MouseButton1Click:Connect(function()
    if selectedPlayer then
        if moveThread then
            moving = false
            task.wait(0.1)
        end
        moving = true
        startClappingSound()
        moveThread = task.spawn(moveBackAndForth)
    else
        PlayerInfo.Text = "Select a player first"
        PlayerInfo.TextColor3 = Color3.fromRGB(255, 69, 58)
        task.wait(2)
        PlayerInfo.Text = "No player selected"
        PlayerInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end)


StopButton.MouseButton1Click:Connect(function()
    moving = false
    clappingSound:Stop()
    if moveThread then
        moveThread = nil
    end
end)


PlayerInput.FocusLost:Connect(function()
    local input = PlayerInput.Text:lower()
    if input == "" then
        selectedPlayer = nil
        PlayerInfo.Text = "No player selected"
        PlayerInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
        return
    end
    
    local found = false
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local name = player.Name:lower()
            local display = player.DisplayName:lower()
            if name:find(input, 1, true) == 1 or display:find(input, 1, true) == 1 then
                selectedPlayer = player
                PlayerInfo.Text = player.DisplayName .. " (" .. player.Name .. ")"
                PlayerInfo.TextColor3 = Color3.fromRGB(52, 199, 89)
                found = true
                break
            end
        end
    end
    
    if not found then
        selectedPlayer = nil
        PlayerInfo.Text = "Player not found"
        PlayerInfo.TextColor3 = Color3.fromRGB(255, 69, 58)
        task.wait(2)
        PlayerInfo.Text = "No player selected"
        PlayerInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end)


LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if moving then
        startClappingSound()
    end
end)


RunService.Heartbeat:Connect(function()
    if not ScreenGui.Parent then
        ScreenGui.Parent = CoreGui
    end
end)
end)

TrollSection:CreateActionRow("Open Get Sucked by Player GUI", "Start", function() 

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")


local selectedPlayer = nil
local speed = 4
local clappingSound = Instance.new("Sound")
clappingSound.SoundId = "rbxassetid://9114762281"
clappingSound.Looped = true
clappingSound.Volume = 0.5
local moving = false
local moveThread = nil
local isMinimized = false
local sitAnimationTrack = nil
local animationTrack = nil


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SuckGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 280)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 32)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui


local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame


local GlossEffect = Instance.new("Frame")
GlossEffect.Size = UDim2.new(1, 0, 0, 2)
GlossEffect.Position = UDim2.new(0, 0, 0, 0)
GlossEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GlossEffect.BackgroundTransparency = 0.7
GlossEffect.BorderSizePixel = 0
GlossEffect.Parent = MainFrame

local GlossCorner = Instance.new("UICorner")
GlossCorner.CornerRadius = UDim.new(0, 12)
GlossCorner.Parent = GlossEffect


local Shadow = Instance.new("Frame")
Shadow.Size = UDim2.new(1, 8, 1, 8)
Shadow.Position = UDim2.new(0, -4, 0, -4)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.4
Shadow.BorderSizePixel = 0
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 14)
ShadowCorner.Parent = Shadow


local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 42)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar


local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "Get Sucked by Player"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar


local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -35, 0, 8)
CloseButton.Text = "✕"
CloseButton.TextSize = 16
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 62)
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton


local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 24, 0, 24)
MinimizeButton.Position = UDim2.new(1, -64, 0, 8)
MinimizeButton.Text = "−"
MinimizeButton.TextSize = 18
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 62)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinimizeButton


local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -30, 1, -55)
ContentFrame.Position = UDim2.new(0, 15, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame


local PlayerInput = Instance.new("TextBox")
PlayerInput.Size = UDim2.new(1, 0, 0, 36)
PlayerInput.Position = UDim2.new(0, 0, 0, 0)
PlayerInput.PlaceholderText = "Enter username"
PlayerInput.Text = ""
PlayerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerInput.TextSize = 14
PlayerInput.BackgroundColor3 = Color3.fromRGB(50, 50, 52)
PlayerInput.BorderSizePixel = 0
PlayerInput.ClearTextOnFocus = false
PlayerInput.Font = Enum.Font.Gotham
PlayerInput.Parent = ContentFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = PlayerInput


local PlayerInfo = Instance.new("TextLabel")
PlayerInfo.Size = UDim2.new(1, 0, 0, 28)
PlayerInfo.Position = UDim2.new(0, 0, 0, 42)
PlayerInfo.Text = "No player selected"
PlayerInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
PlayerInfo.TextSize = 13
PlayerInfo.BackgroundTransparency = 1
PlayerInfo.Font = Enum.Font.Gotham
PlayerInfo.Parent = ContentFrame


local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, 0, 0, 30)
SpeedFrame.Position = UDim2.new(0, 0, 0, 120)
SpeedFrame.BackgroundTransparency = 1
SpeedFrame.Parent = ContentFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.5, 0, 1, 0)
SpeedLabel.Text = "Speed: " .. speed
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 13
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Parent = SpeedFrame


local StartButton = Instance.new("TextButton")
StartButton.Size = UDim2.new(0, 95, 0, 40)
StartButton.Position = UDim2.new(0, 0, 0, 160)
StartButton.Text = "START"
StartButton.TextSize = 16
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.BackgroundColor3 = Color3.fromRGB(52, 199, 89)
StartButton.BorderSizePixel = 0
StartButton.Font = Enum.Font.GothamBold
StartButton.Parent = ContentFrame

local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(1, 0)
StartCorner.Parent = StartButton

local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(0, 95, 0, 40)
StopButton.Position = UDim2.new(1, -95, 0, 160)
StopButton.Text = "STOP"
StopButton.TextSize = 16
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.BackgroundColor3 = Color3.fromRGB(255, 69, 58)
StopButton.BorderSizePixel = 0
StopButton.Font = Enum.Font.GothamBold
StopButton.Parent = ContentFrame

local StopCorner = Instance.new("UICorner")
StopCorner.CornerRadius = UDim.new(1, 0)
StopCorner.Parent = StopButton


local function createSitAnimation()
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://180435774" 
    return animation
end


local function playSitAnimation(character)
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
  
    if animationTrack and animationTrack.IsPlaying then
        animationTrack:Stop()
    end
    
    local sitAnim = createSitAnimation()
    animationTrack = humanoid:LoadAnimation(sitAnim)
    if animationTrack then
        animationTrack:Play()
        animationTrack:AdjustSpeed(1)
        animationTrack:SetAttribute("Looped", true)
    end
end


local function moveOnHead()
    while moving and selectedPlayer and selectedPlayer.Character and LocalPlayer.Character do
        local character = LocalPlayer.Character
        local targetChar = selectedPlayer.Character
        
        if character and targetChar then
            
            local targetHead = targetChar:FindFirstChild("Head")
            local root = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChild("Humanoid")
            
            if targetHead and root then
                
                local headPos = targetHead.Position
                local lookVector = targetHead.CFrame.LookVector
                
               
                local distanceInFront = 2.0
                local frontPos = headPos + lookVector * distanceInFront
                
                
                local heightOffset = Vector3.new(0, 0, 0)
                local targetPos = frontPos + heightOffset
                
               
                local newPos = root.Position + (targetPos - root.Position) * (speed / 10)
                root.CFrame = CFrame.new(newPos, headPos)
                
                
                if humanoid then
                    humanoid.AutoRotate = true
                   
                    if not animationTrack or not animationTrack.IsPlaying then
                        playSitAnimation(character)
                    end
                end
            end
        end
        RunService.Heartbeat:Wait()
    end
end


local function startClappingSound()
    local character = LocalPlayer.Character
    if character then
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            clappingSound.Parent = root
            clappingSound:Play()
        end
    end
end


CloseButton.MouseButton1Click:Connect(function()
    moving = false
    clappingSound:Stop()
    if animationTrack then
        animationTrack:Stop()
    end
    ScreenGui:Destroy()
end)


MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    ContentFrame.Visible = not isMinimized
    MinimizeButton.Text = isMinimized and "+" or "−"
end)


local function setupHover(button, color, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
end

setupHover(StartButton, Color3.fromRGB(52, 199, 89), Color3.fromRGB(72, 219, 109))
setupHover(StopButton, Color3.fromRGB(255, 69, 58), Color3.fromRGB(255, 89, 78))
setupHover(CloseButton, Color3.fromRGB(60, 60, 62), Color3.fromRGB(200, 60, 60))
setupHover(MinimizeButton, Color3.fromRGB(60, 60, 62), Color3.fromRGB(80, 80, 82))


StartButton.MouseButton1Click:Connect(function()
    if selectedPlayer then
        if moveThread then
            moving = false
            task.wait(0.1)
        end
        moving = true
        startClappingSound()
        
        
        local character = LocalPlayer.Character
        if character then
            playSitAnimation(character)
        end
        
        moveThread = task.spawn(moveOnHead)
    else
        PlayerInfo.Text = "Select a player first"
        PlayerInfo.TextColor3 = Color3.fromRGB(255, 69, 58)
        task.wait(2)
        PlayerInfo.Text = "No player selected"
        PlayerInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end)


StopButton.MouseButton1Click:Connect(function()
    moving = false
    clappingSound:Stop()
    if animationTrack then
        animationTrack:Stop()
    end
    if moveThread then
        moveThread = nil
    end
end)


PlayerInput.FocusLost:Connect(function()
    local input = PlayerInput.Text:lower()
    if input == "" then
        selectedPlayer = nil
        PlayerInfo.Text = "No player selected"
        PlayerInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
        return
    end
    
    local found = false
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local name = player.Name:lower()
            local display = player.DisplayName:lower()
            if name:find(input, 1, true) == 1 or display:find(input, 1, true) == 1 then
                selectedPlayer = player
                PlayerInfo.Text = player.DisplayName .. " (" .. player.Name .. ")"
                PlayerInfo.TextColor3 = Color3.fromRGB(52, 199, 89)
                found = true
                break
            end
        end
    end
    
    if not found then
        selectedPlayer = nil
        PlayerInfo.Text = "Player not found"
        PlayerInfo.TextColor3 = Color3.fromRGB(255, 69, 58)
        task.wait(2)
        PlayerInfo.Text = "No player selected"
        PlayerInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end)


LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if moving then
        startClappingSound()
        local character = LocalPlayer.Character
        if character then
            playSitAnimation(character)
        end
    end
end)


RunService.Heartbeat:Connect(function()
    if not ScreenGui.Parent then
        ScreenGui.Parent = CoreGui
    end
end)
end)

local ChangelogTab = Window:CreateTab("Changelogs")
local ChangelogSection = ChangelogTab:CreateSection("Changelogs")
ChangelogSection:CreateLabel("ChangeLog 12/07/2026: \nAdded: \n[+] Get Sucked by Player GUI, \n[+] Bang Player GUI")
ChangelogSection:CreateLabel("ChangeLog 12/07/2026: \nAdded: \n[+] Anti AFK, \n[+] FPS Boost, \n[+] Ultra FPS Boost, \n[+] Fly GUI, \n[/] GodMode now works properly. \n[+] WalkSpeed Changer added.")
ChangelogSection:CreateLabel("ChangeLog 11/07/2026: \nAdded: \n[+] Auto Wins, \n[+] Auto Speed, \n[+] GodMode.")

local CreditsTab = Window:CreateTab("Credits")
local CreditsSection = CreditsTab:CreateSection("Credits")
CreditsSection:CreateLabel("Made by xFish with love. <3")


return ZynxHub
            
        else
            retries = retries + 1
            local remaining = CONFIG.MaxRetries - retries
            
            if remaining <= 0 then
                statusLabel.Text = "Too many failed attempts"
                statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                task.wait(1)
                screenGui:Destroy()
                return
            end
            
            statusLabel.Text = "Invalid key. Attempts left: " .. remaining
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            keyInput.Text = ""
            keyInput.PlaceholderText = "Wrong key, try again"
            
            local originalPos = mainFrame.Position
            for i = 1, 4 do
                mainFrame.Position = UDim2.new(
                    0.5, -225 + (i % 2 == 0 and 10 or -10), 
                    0.5, -190
                )
                task.wait(0.05)
            end
            mainFrame.Position = originalPos
        end
    end)
    
    keyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            submitBtn.MouseButton1Click:Fire()
        end
    end)
    
    return screenGui
end

local gui = CreateKeyGUI()

-- made by xfan you can use this script in your own roblox Script, but please give credit to the original author.