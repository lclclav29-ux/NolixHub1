-- [[ NOLIX HUB - Premium Dark Redesign ]] --
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

if CoreGui:FindFirstChild("NolixHubPremium") then
    CoreGui.NolixHubPremium:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NolixHubPremium"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- Главное окно
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 600, 0, 380)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(45, 45, 65)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

-- Тень окна (эффект глубины)
local dropShadow = Instance.new("ImageLabel")
dropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
dropShadow.BackgroundTransparency = 1
dropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
dropShadow.Size = UDim2.new(1, 40, 1, 40)
dropShadow.ZIndex = -1
dropShadow.Image = "rbxassetid://6015897843"
dropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
dropShadow.ImageTransparency = 0.4
dropShadow.ScaleType = Enum.ScaleType.Slice
dropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
dropShadow.Parent = mainFrame

-- Шапка
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 48)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 14)
titleCorner.Parent = titleBar

-- Убираем скругление снизу для шапки
local fixBar = Instance.new("Frame")
fixBar.Size = UDim2.new(1, 0, 0, 10)
fixBar.Position = UDim2.new(0, 0, 1, -10)
fixBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
fixBar.BorderSizePixel = 0
fixBar.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -60, 1, 0)
titleText.Position = UDim2.new(0, 18, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "NOLIX HUB <font color='#00A2FF'>// ELITE</font>"
titleText.RichText = true
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 15
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 28, 0, 28)
closeButton.Position = UDim2.new(1, -38, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(180, 180, 200)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 12
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

closeButton.MouseEnter:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(230, 50, 50)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end)
closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    closeButton.TextColor3 = Color3.fromRGB(180, 180, 200)
end)

-- Боковая панель
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 150, 1, -48)
sidebar.Position = UDim2.new(0, 0, 0, 48)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local sideLayout = Instance.new("UIListLayout")
sideLayout.Parent = sidebar
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Padding = UDim.new(0, 6)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0, 12)
sidePadding.Parent = sidebar

-- Контейнер для вкладок
local pagesFolder = Instance.new("Folder")
pagesFolder.Name = "Pages"
pagesFolder.Parent = mainFrame

local activePage = nil

local function createTab(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, -166, 1, -62)
    page.Position = UDim2.new(0, 158, 0, 54)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 162, 255)
    page.Visible = false
    page.Parent = pagesFolder

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = page
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Padding = UDim.new(0, 8)

    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -20, 0, 38)
    tabBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(140, 140, 165)
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.TextSize = 13
    tabBtn.Parent = sidebar

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = tabBtn

    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(pagesFolder:GetChildren()) do
            p.Visible = false
        end
        for _, b in pairs(sidebar:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
                b.TextColor3 = Color3.fromRGB(140, 140, 165)
            end
        end
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    if not activePage then
        activePage = page
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    return page
end

local function createButton(page, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -12, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(210, 210, 230)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    btn.Parent = page

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(40, 40, 58)
    btnStroke.Parent = btn

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(32, 32, 46)
        btnStroke.Color = Color3.fromRGB(0, 162, 255)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
        btnStroke.Color = Color3.fromRGB(40, 40, 58)
    end)

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- === ВКЛАДКИ ===

-- 1. Player
local playerTab = createTab("👤 Player")

createButton(playerTab, "⚡ Speed Boost (50)", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 50
    end
end)

createButton(playerTab, "🚶 Normal Speed (16)", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
    end
end)

createButton(playerTab, "🦘 High Jump (120)", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = 120
    end
end)

local noclipEnabled = false
createButton(playerTab, "👻 Noclip (Сквозь стены)", function()
    noclipEnabled = not noclipEnabled
end)

RunService.Stepped:Connect(function()
    if noclipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 2. Inspector (Интерактивный сканер с выводом в окно)
local inspectorTab = createTab("📦 Inspector")

local outputBox = Instance.new("ScrollingFrame")
outputBox.Size = UDim2.new(1, -12, 0, 160)
outputBox.BackgroundColor3 = Color3.fromRGB(11, 11, 16)
outputBox.BorderSizePixel = 0
outputBox.ScrollBarThickness = 3
outputBox.Parent = inspectorTab

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 8)
boxCorner.Parent = outputBox

local boxLayout = Instance.new("UIListLayout")
boxLayout.Parent = outputBox
boxLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function printToUI(text, color)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = " " .. text
    lbl.TextColor3 = color or Color3.fromRGB(200, 200, 200)
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = outputBox
    outputBox.CanvasSize = UDim2.new(0, 0, 0, boxLayout.AbsoluteContentSize.Y + 20)
    outputBox.CanvasPosition = Vector2.new(0, outputBox.AbsoluteCanvasSize.Y)
end

createButton(inspectorTab, "🔍 Начать сканирование структуры", function()
    for _, child in pairs(outputBox:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
    
    printToUI("=== ЗАПУСК СКАНИРОВАНИЯ ===", Color3.fromRGB(0, 255, 120))
    printToUI("📁 ReplicatedStorage папки:", Color3.fromRGB(0, 162, 255))
    
    for _, item in pairs(ReplicatedStorage:GetChildren()) do
        printToUI(" • " .. item.Name .. " [" .. item.ClassName .. "]", Color3.fromRGB(220, 220, 220))
    end
    
    local remotes = 0
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            remotes = remotes + 1
        end
    end
    printToUI("⚡ Всего Remotes найдено: " .. remotes, Color3.fromRGB(255, 180, 0))
    printToUI("=== СКАНИРОВАНИЕ ЗАВЕРШЕНО ===", Color3.fromRGB(0, 255, 120))
end)

-- 3. World
local worldTab = createTab("🌐 World")

createButton(worldTab, "💡 Fullbright (Подсветка карты)", function()
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.GlobalShadows = false
end)

createButton(worldTab, "☀️ Установить День", function()
    Lighting.ClockTime = 12
end)

createButton(worldTab, "🌙 Установить Ночь", function()
    Lighting.ClockTime = 0
end)

-- Перетаскивание окна мышкой
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
