local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DropdownGUI"
screenGui.Parent = playerGui

-- Main Frame (Container)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 250, 0, 50)
mainFrame.Position = UDim2.new(0, 20, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Add corner radius
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Header Frame
local headerFrame = Instance.new("Frame")
headerFrame.Name = "Header"
headerFrame.Size = UDim2.new(1, 0, 0, 50)
headerFrame.Position = UDim2.new(0, 0, 0, 0)
headerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
headerFrame.BorderSizePixel = 0
headerFrame.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = headerFrame

-- Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Fryzer Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = headerFrame

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(1, -45, 0, 5)
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleButton.BackgroundTransparency = 0
toggleButton.BorderSizePixel = 0
toggleButton.Text = "▼"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = headerFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- Content Frame (for buttons)
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, 0, 0, 280)
contentFrame.Position = UDim2.new(0, 0, 0, 50)
contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- Teleportation function
local function teleportPlayer(x, y, z)
    local player = Players.LocalPlayer
    local character = player.Character
    
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(x, y, z)
            print("Teleported to coordinates: " .. x .. ", " .. y .. ", " .. z)
        else
            warn("HumanoidRootPart not found!")
        end
    else
        warn("Character not found!")
    end
end

-- Night Vision functionality
local nightVisionEnabled = false
local originalLighting = {}

local function toggleNightVision()
    local lighting = game:GetService("Lighting")
    
    if not nightVisionEnabled then
        -- Enable night vision
        originalLighting.Ambient = lighting.Ambient
        originalLighting.Brightness = lighting.Brightness
        originalLighting.OutdoorAmbient = lighting.OutdoorAmbient
        originalLighting.TimeOfDay = lighting.TimeOfDay
        
        lighting.Ambient = Color3.fromRGB(255, 255, 255)
        lighting.Brightness = 2
        lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        lighting.TimeOfDay = "12:00:00"
        
        nightVisionEnabled = true
        print("Night Vision enabled")
    else
        -- Disable night vision
        lighting.Ambient = originalLighting.Ambient
        lighting.Brightness = originalLighting.Brightness
        lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        lighting.TimeOfDay = originalLighting.TimeOfDay
        
        nightVisionEnabled = false
        print("Night Vision disabled")
    end
end

-- Walk Speed functionality
local currentWalkSpeed = 16

local function setWalkSpeed(speed)
    local player = Players.LocalPlayer
    local character = player.Character
    
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speed
            currentWalkSpeed = speed
            print("Walk speed set to: " .. speed)
        else
            warn("Humanoid not found!")
        end
    else
        warn("Character not found!")
    end
end

-- Button configurations
local buttonConfigs = {
    {name = "Teleport", color = Color3.fromRGB(50, 50, 50), action = function()
        teleportPlayer(7.53, 4.00, 2.26)
    end},
    {name = "Night Vision", color = Color3.fromRGB(45, 45, 45), isToggle = true, action = function()
        toggleNightVision()
    end},
    {name = "Walk Speed", color = Color3.fromRGB(40, 40, 40), isSlider = true, min = 16, max = 100, action = function(value)
        setWalkSpeed(value)
    end},
    {name = "Button 4", color = Color3.fromRGB(35, 35, 35), action = function()
        -- No function yet
    end},
    {name = "Button 5", color = Color3.fromRGB(50, 50, 50), action = function()
        -- No function yet
    end},
    {name = "Button 6", color = Color3.fromRGB(45, 45, 45), action = function()
        -- No function yet
    end},
    {name = "Button 7", color = Color3.fromRGB(40, 40, 40), action = function()
        -- No function yet
    end}
}

-- Create buttons
for i, config in ipairs(buttonConfigs) do
    local button = Instance.new("TextButton")
    button.Name = "Button" .. i
    button.Size = UDim2.new(1, -20, 0, 35)
    button.Position = UDim2.new(0, 10, 0, (i-1) * 40 + 5)
    button.BackgroundColor3 = config.color
    button.BorderSizePixel = 0
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.Gotham
    button.Parent = contentFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    -- Handle toggle buttons with improved styling
    if config.isToggle then
        local toggleState = false
        
        -- Create checkbox icon (separate from button text)
        local checkboxIcon = Instance.new("TextLabel")
        checkboxIcon.Name = "CheckboxIcon"
        checkboxIcon.Size = UDim2.new(0, 20, 0, 20)
        checkboxIcon.Position = UDim2.new(0, 8, 0.5, -10)
        checkboxIcon.BackgroundTransparency = 1
        checkboxIcon.Text = "☐"
        checkboxIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
        checkboxIcon.TextScaled = true
        checkboxIcon.Font = Enum.Font.GothamBold
        checkboxIcon.Parent = button
        
        -- Create text label for button name
        local buttonText = Instance.new("TextLabel")
        buttonText.Name = "ButtonText"
        buttonText.Size = UDim2.new(1, -35, 1, 0)
        buttonText.Position = UDim2.new(0, 35, 0, 0)
        buttonText.BackgroundTransparency = 1
        buttonText.Text = config.name
        buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
        buttonText.TextScaled = true
        buttonText.Font = Enum.Font.Gotham
        buttonText.TextXAlignment = Enum.TextXAlignment.Left
        buttonText.Parent = button
        
        -- Remove the original button text
        button.Text = ""
        
        button.MouseButton1Click:Connect(function()
            toggleState = not toggleState
            
            if toggleState then
                checkboxIcon.Text = "✓"
                checkboxIcon.TextColor3 = Color3.fromRGB(255, 85, 85) -- Red checkmark only
                -- Keep button background the same
                button.BackgroundColor3 = config.color
            else
                checkboxIcon.Text = "☐"
                checkboxIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.BackgroundColor3 = config.color
            end
            
            -- Execute the button's action if it exists
            if config.action then
                local success, error = pcall(config.action)
                if not success then
                    warn("Error executing action for " .. config.name .. ": " .. tostring(error))
                end
            end
        end)
        
    -- Handle slider buttons with much better styling
    elseif config.isSlider then
        local sliderValue = config.min
        
        -- Create text label for slider name and value
        local sliderText = Instance.new("TextLabel")
        sliderText.Name = "SliderText"
        sliderText.Size = UDim2.new(1, -20, 0, 18)
        sliderText.Position = UDim2.new(0, 10, 0, 3)
        sliderText.BackgroundTransparency = 1
        sliderText.Text = config.name .. ": " .. sliderValue
        sliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
        sliderText.TextScaled = true
        sliderText.Font = Enum.Font.Gotham
        sliderText.TextXAlignment = Enum.TextXAlignment.Left
        sliderText.Parent = button
        
        -- Remove the original button text
        button.Text = ""
        
        -- Create slider track (improved design)
        local sliderTrack = Instance.new("Frame")
        sliderTrack.Name = "SliderTrack"
        sliderTrack.Size = UDim2.new(0.8, 0, 0, 6)
        sliderTrack.Position = UDim2.new(0.1, 0, 0, 22)
        sliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        sliderTrack.BorderSizePixel = 0
        sliderTrack.Parent = button
        
        local sliderTrackCorner = Instance.new("UICorner")
        sliderTrackCorner.CornerRadius = UDim.new(0, 3)
        sliderTrackCorner.Parent = sliderTrack
        
        -- Create slider fill (progress bar)
        local sliderFill = Instance.new("Frame")
        sliderFill.Name = "SliderFill"
        sliderFill.Size = UDim2.new(0, 0, 1, 0)
        sliderFill.Position = UDim2.new(0, 0, 0, 0)
        sliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255) -- Nice blue color
        sliderFill.BorderSizePixel = 0
        sliderFill.Parent = sliderTrack
        
        local sliderFillCorner = Instance.new("UICorner")
        sliderFillCorner.CornerRadius = UDim.new(0, 3)
        sliderFillCorner.Parent = sliderFill
        
        -- Create slider handle (much better looking)
        local sliderHandle = Instance.new("Frame")
        sliderHandle.Name = "SliderHandle"
        sliderHandle.Size = UDim2.new(0, 16, 0, 16)
        sliderHandle.Position = UDim2.new(0, -8, 0, -5)
        sliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        sliderHandle.BorderSizePixel = 0
        sliderHandle.Parent = sliderTrack
        
        local sliderHandleCorner = Instance.new("UICorner")
        sliderHandleCorner.CornerRadius = UDim.new(0, 8)
        sliderHandleCorner.Parent = sliderHandle
        
        -- Add shadow effect to handle
        local handleShadow = Instance.new("Frame")
        handleShadow.Name = "HandleShadow"
        handleShadow.Size = UDim2.new(0, 18, 0, 18)
        handleShadow.Position = UDim2.new(0, -9, 0, -6)
        handleShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        handleShadow.BackgroundTransparency = 0.5
        handleShadow.BorderSizePixel = 0
        handleShadow.ZIndex = sliderHandle.ZIndex - 1
        handleShadow.Parent = sliderTrack
        
        local handleShadowCorner = Instance.new("UICorner")
        handleShadowCorner.CornerRadius = UDim.new(0, 9)
        handleShadowCorner.Parent = handleShadow
        
        -- Slider functionality
        local dragging = false
        
        local function updateSlider(input)
            local sliderTrackAbsolutePos = sliderTrack.AbsolutePosition
            local sliderTrackAbsoluteSize = sliderTrack.AbsoluteSize
            local relativeX = math.clamp((input.Position.X - sliderTrackAbsolutePos.X) / sliderTrackAbsoluteSize.X, 0, 1)
            
            sliderValue = math.floor(config.min + (config.max - config.min) * relativeX)
            
            -- Update visual elements with smooth animation
            local targetFillSize = UDim2.new(relativeX, 0, 1, 0)
            local targetHandlePos = UDim2.new(relativeX, -8, 0, -5)
            local targetShadowPos = UDim2.new(relativeX, -9, 0, -6)
            
            TweenService:Create(sliderFill, TweenInfo.new(0.1), {Size = targetFillSize}):Play()
            TweenService:Create(sliderHandle, TweenInfo.new(0.1), {Position = targetHandlePos}):Play()
            TweenService:Create(handleShadow, TweenInfo.new(0.1), {Position = targetShadowPos}):Play()
            
            sliderText.Text = config.name .. ": " .. sliderValue
            
            -- Execute action
            if config.action then
                local success, error = pcall(config.action, sliderValue)
                if not success then
                    warn("Error executing action for " .. config.name .. ": " .. tostring(error))
                end
            end
        end
        
        -- Handle mouse/touch input
        sliderTrack.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                updateSlider(input)
                
                -- Visual feedback when dragging starts
                TweenService:Create(sliderHandle, TweenInfo.new(0.1), {
                    Size = UDim2.new(0, 18, 0, 18),
                    Position = UDim2.new(sliderHandle.Position.X.Scale, -9, 0, -6)
                }):Play()
            end
        end)
        
        sliderTrack.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                updateSlider(input)
            end
        end)
        
        sliderTrack.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
                
                -- Reset handle size when dragging ends
                TweenService:Create(sliderHandle, TweenInfo.new(0.1), {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(sliderHandle.Position.X.Scale, -8, 0, -5)
                }):Play()
            end
        end)
        
        -- Initialize slider at minimum value
        sliderFill.Size = UDim2.new(0, 0, 1, 0)
        sliderHandle.Position = UDim2.new(0, -8, 0, -5)
        handleShadow.Position = UDim2.new(0, -9, 0, -6)
        
    -- Handle regular buttons
    else
        button.Text = config.name
        
        button.MouseButton1Click:Connect(function()
            -- Execute the button's action if it exists
            if config.action then
                local success, error = pcall(config.action)
                if not success then
                    warn("Error executing action for " .. config.name .. ": " .. tostring(error))
                end
            end
            
            -- Visual feedback with better animation
            local originalColor = button.BackgroundColor3
            local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            
            TweenService:Create(button, tweenInfo, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
            
            wait(0.1)
            
            TweenService:Create(button, tweenInfo, {BackgroundColor3 = originalColor}):Play()
        end)
    end
end

-- Dropdown functionality
local isOpen = false
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local function toggleDropdown()
    isOpen = not isOpen
    
    local targetSize, targetRotation
    if isOpen then
        targetSize = UDim2.new(0, 250, 0, 330)
        targetRotation = 180
    else
        targetSize = UDim2.new(0, 250, 0, 50)
        targetRotation = 0
    end
    
    -- Animate main frame
    local sizeTween = TweenService:Create(mainFrame, tweenInfo, {Size = targetSize})
    sizeTween:Play()
    
    -- Animate toggle button rotation
    local rotationTween = TweenService:Create(toggleButton, tweenInfo, {Rotation = targetRotation})
    rotationTween:Play()
end

toggleButton.MouseButton1Click:Connect(toggleDropdown)

-- Dragging functionality
local dragToggle = nil
local dragSpeed = 0
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    TweenService:Create(mainFrame, TweenInfo.new(dragSpeed), {Position = position}):Play()
end

headerFrame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragToggle = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragToggle then
            updateInput(input)
        end
    end
end)

-- Mobile touch support for dragging
headerFrame.TouchMoved:Connect(function(touch, gameProcessed)
    if dragToggle then
        updateInput(touch)
    end
end)

print("Improved Dropdown GUI loaded successfully!")
