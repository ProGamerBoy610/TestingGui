-- Fryzer Hub GUI System
-- Easy to customize like Rayfield

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Configuration
local Config = {
    -- Main Colors
    MainColor = Color3.fromRGB(25, 25, 35),
    SecondaryColor = Color3.fromRGB(35, 35, 45),
    AccentColor = Color3.fromRGB(70, 130, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    SecondaryTextColor = Color3.fromRGB(180, 180, 180),
    
    -- UI Settings
    TabWidth = 160,
    MainSize = UDim2.new(0, 650, 0, 450),
    CornerRadius = 8,
    
    -- Animation
    AnimationSpeed = 0.3,
    EasingStyle = Enum.EasingStyle.Quad,
    EasingDirection = Enum.EasingDirection.Out
}

-- Create main ScreenGui
local FryzerHub = Instance.new("ScreenGui")
FryzerHub.Name = "FryzerHub"
FryzerHub.Parent = PlayerGui
FryzerHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = FryzerHub
MainFrame.Size = Config.MainSize
MainFrame.Position = UDim2.new(0.5, -Config.MainSize.X.Offset/2, 0.5, -Config.MainSize.Y.Offset/2)
MainFrame.BackgroundColor3 = Config.MainColor
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

-- Add corner rounding
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, Config.CornerRadius)
MainCorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Config.SecondaryColor
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, Config.CornerRadius)
TitleCorner.Parent = TitleBar

-- Fix corner for title bar
local TitleBarFix = Instance.new("Frame")
TitleBarFix.Parent = TitleBar
TitleBarFix.Size = UDim2.new(1, 0, 0, Config.CornerRadius)
TitleBarFix.Position = UDim2.new(0, 0, 1, -Config.CornerRadius)
TitleBarFix.BackgroundColor3 = Config.SecondaryColor
TitleBarFix.BorderSizePixel = 0

-- Title Label
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Fryzer Hub"
TitleLabel.TextColor3 = Config.TextColor
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.GothamBold

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.white
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseButton

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.white
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.BorderSizePixel = 0

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 4)
MinimizeCorner.Parent = MinimizeButton

-- Tab Container (Left Side)
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.Size = UDim2.new(0, Config.TabWidth, 1, -40)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundColor3 = Config.SecondaryColor
TabContainer.BorderSizePixel = 0

-- Tab ScrollingFrame
local TabScrollFrame = Instance.new("ScrollingFrame")
TabScrollFrame.Name = "TabScrollFrame"
TabScrollFrame.Parent = TabContainer
TabScrollFrame.Size = UDim2.new(1, 0, 1, 0)
TabScrollFrame.Position = UDim2.new(0, 0, 0, 0)
TabScrollFrame.BackgroundTransparency = 1
TabScrollFrame.ScrollBarThickness = 4
TabScrollFrame.ScrollBarImageColor3 = Config.AccentColor
TabScrollFrame.BorderSizePixel = 0

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabScrollFrame
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)

-- Content Container (Right Side)
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.Size = UDim2.new(1, -Config.TabWidth, 1, -40)
ContentContainer.Position = UDim2.new(0, Config.TabWidth, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0

-- Content ScrollingFrame
local ContentScrollFrame = Instance.new("ScrollingFrame")
ContentScrollFrame.Name = "ContentScrollFrame"
ContentScrollFrame.Parent = ContentContainer
ContentScrollFrame.Size = UDim2.new(1, -10, 1, -10)
ContentScrollFrame.Position = UDim2.new(0, 5, 0, 5)
ContentScrollFrame.BackgroundTransparency = 1
ContentScrollFrame.ScrollBarThickness = 4
ContentScrollFrame.ScrollBarImageColor3 = Config.AccentColor
ContentScrollFrame.BorderSizePixel = 0

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Parent = ContentScrollFrame
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 10)

-- GUI Library
local FryzerLibrary = {}
FryzerLibrary.Tabs = {}
FryzerLibrary.CurrentTab = nil

-- Create Tab Function
function FryzerLibrary:CreateTab(name, icon)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Parent = TabScrollFrame
    TabButton.Size = UDim2.new(1, -10, 0, 35)
    TabButton.BackgroundColor3 = Config.MainColor
    TabButton.Text = (icon and icon .. " " or "") .. name
    TabButton.TextColor3 = Config.SecondaryTextColor
    TabButton.TextSize = 14
    TabButton.Font = Enum.Font.Gotham
    TabButton.BorderSizePixel = 0
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    
    local TabButtonCorner = Instance.new("UICorner")
    TabButtonCorner.CornerRadius = UDim.new(0, 4)
    TabButtonCorner.Parent = TabButton
    
    local TabButtonPadding = Instance.new("UIPadding")
    TabButtonPadding.Left = UDim.new(0, 10)
    TabButtonPadding.Parent = TabButton
    
    -- Tab Content Frame
    local TabContent = Instance.new("Frame")
    TabContent.Name = name .. "Content"
    TabContent.Parent = ContentScrollFrame
    TabContent.Size = UDim2.new(1, 0, 0, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    
    local TabContentLayout = Instance.new("UIListLayout")
    TabContentLayout.Parent = TabContent
    TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabContentLayout.Padding = UDim.new(0, 8)
    
    -- Tab object
    local Tab = {}
    Tab.Button = TabButton
    Tab.Content = TabContent
    Tab.Layout = TabContentLayout
    
    -- Switch to this tab
    function Tab:Select()
        if FryzerLibrary.CurrentTab then
            FryzerLibrary.CurrentTab.Content.Visible = false
            TweenService:Create(FryzerLibrary.CurrentTab.Button, TweenInfo.new(Config.AnimationSpeed), {
                BackgroundColor3 = Config.MainColor,
                TextColor3 = Config.SecondaryTextColor
            }):Play()
        end
        
        FryzerLibrary.CurrentTab = Tab
        Tab.Content.Visible = true
        TweenService:Create(Tab.Button, TweenInfo.new(Config.AnimationSpeed), {
            BackgroundColor3 = Config.AccentColor,
            TextColor3 = Config.TextColor
        }):Play()
        
        -- Update content scroll frame size
        ContentScrollFrame.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
    end
    
    -- Create Button Function
    function Tab:CreateButton(name, callback)
        local Button = Instance.new("TextButton")
        Button.Name = name .. "Button"
        Button.Parent = Tab.Content
        Button.Size = UDim2.new(1, -20, 0, 35)
        Button.BackgroundColor3 = Config.SecondaryColor
        Button.Text = name
        Button.TextColor3 = Config.TextColor
        Button.TextSize = 14
        Button.Font = Enum.Font.Gotham
        Button.BorderSizePixel = 0
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 6)
        ButtonCorner.Parent = Button
        
        Button.MouseButton1Click:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Config.AccentColor}):Play()
            wait(0.1)
            TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Config.SecondaryColor}):Play()
            
            if callback then
                callback()
            end
        end)
        
        -- Update layout
        Tab.Content.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
        ContentScrollFrame.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
        
        return Button
    end
    
    -- Create Toggle Function
    function Tab:CreateToggle(name, default, callback)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Name = name .. "Toggle"
        ToggleFrame.Parent = Tab.Content
        ToggleFrame.Size = UDim2.new(1, -20, 0, 35)
        ToggleFrame.BackgroundColor3 = Config.SecondaryColor
        ToggleFrame.BorderSizePixel = 0
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 6)
        ToggleCorner.Parent = ToggleFrame
        
        local ToggleLabel = Instance.new("TextLabel")
        ToggleLabel.Parent = ToggleFrame
        ToggleLabel.Size = UDim2.new(1, -45, 1, 0)
        ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
        ToggleLabel.BackgroundTransparency = 1
        ToggleLabel.Text = name
        ToggleLabel.TextColor3 = Config.TextColor
        ToggleLabel.TextSize = 14
        ToggleLabel.Font = Enum.Font.Gotham
        ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Parent = ToggleFrame
        ToggleButton.Size = UDim2.new(0, 30, 0, 18)
        ToggleButton.Position = UDim2.new(1, -35, 0.5, -9)
        ToggleButton.BackgroundColor3 = default and Config.AccentColor or Color3.fromRGB(60, 60, 70)
        ToggleButton.Text = ""
        ToggleButton.BorderSizePixel = 0
        
        local ToggleButtonCorner = Instance.new("UICorner")
        ToggleButtonCorner.CornerRadius = UDim.new(0, 9)
        ToggleButtonCorner.Parent = ToggleButton
        
        local ToggleSlider = Instance.new("Frame")
        ToggleSlider.Parent = ToggleButton
        ToggleSlider.Size = UDim2.new(0, 14, 0, 14)
        ToggleSlider.Position = default and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        ToggleSlider.BackgroundColor3 = Config.TextColor
        ToggleSlider.BorderSizePixel = 0
        
        local ToggleSliderCorner = Instance.new("UICorner")
        ToggleSliderCorner.CornerRadius = UDim.new(0, 7)
        ToggleSliderCorner.Parent = ToggleSlider
        
        local toggled = default or false
        
        ToggleButton.MouseButton1Click:Connect(function()
            toggled = not toggled
            
            if toggled then
                TweenService:Create(ToggleButton, TweenInfo.new(Config.AnimationSpeed), {BackgroundColor3 = Config.AccentColor}):Play()
                TweenService:Create(ToggleSlider, TweenInfo.new(Config.AnimationSpeed), {Position = UDim2.new(1, -16, 0.5, -7)}):Play()
            else
                TweenService:Create(ToggleButton, TweenInfo.new(Config.AnimationSpeed), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
                TweenService:Create(ToggleSlider, TweenInfo.new(Config.AnimationSpeed), {Position = UDim2.new(0, 2, 0.5, -7)}):Play()
            end
            
            if callback then
                callback(toggled)
            end
        end)
        
        -- Update layout
        Tab.Content.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
        ContentScrollFrame.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
        
        return ToggleFrame
    end
    
    -- Tab button click event
    TabButton.MouseButton1Click:Connect(function()
        Tab:Select()
    end)
    
    -- Update tab scroll frame size
    TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
    
    FryzerLibrary.Tabs[name] = Tab
    
    -- Select first tab automatically
    if #FryzerLibrary.Tabs == 1 then
        Tab:Select()
    end
    
    return Tab
end

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(Config.AnimationSpeed), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    
    wait(Config.AnimationSpeed)
    FryzerHub:Destroy()
end)

-- Minimize functionality
local minimized = false
local originalSize = Config.MainSize

MinimizeButton.MouseButton1Click:Connect(function()
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(Config.AnimationSpeed), {
            Size = originalSize
        }):Play()
        minimized = false
        MinimizeButton.Text = "−"
    else
        TweenService:Create(MainFrame, TweenInfo.new(Config.AnimationSpeed), {
            Size = UDim2.new(0, originalSize.X.Offset, 0, 40)
        }):Play()
        minimized = true
        MinimizeButton.Text = "+"
    end
end)

-- Dragging functionality
local dragging = false
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
