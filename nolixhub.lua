-- [[ NOLIX HUB - Cyber Redesign & Game Inspector ]] --
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

if CoreGui:FindFirstChild("NolixHubCyber") then
    CoreGui.NolixHubCyber:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NolixHubCyber"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- Главное окно в стиле киберпанк / неон
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 560, 0, 380)
mainFrame.Position = UDim2.new(0.5, -280, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Неоновая обводка окна
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(0, 220, 255)
mainStroke.Transparency = 0.3
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

-- Шапка
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -60, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "⚡ NOLIX HUB // CYBER EDITION"
titleText.TextColor3 = Color3.fromRGB(0, 220, 255)
titleText.TextSize = 15
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -38, 0, 7)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 13
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Боковая панель категорий
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 140, 1, -45)
sidebar.Position = UDim2.new(0, 0, 0, 45)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 21)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local sideLayout = Instance.new("UIListLayout")
sideLayout.Parent = sidebar
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Padding = UDim.new(0, 5)

-- Контейнер под Вкладки
local pagesFolder = Instance.new("Folder")
pagesFolder.Name = "Pages"
pagesFolder.Parent = mainFrame

local activePage = nil

local function createTab(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, -155, 1, -55)
    page.Position = UDim2.new(0, 150, 0, 50)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.Visible = false
    page.Parent = pagesFolder

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = page
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Padding = UDim.new(0, 8)

    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -10, 0, 36)
    tabBtn.Position = UDim2.new(0, 5, 0, 0)
    tabBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(170, 170, 200)
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
                b.TextColor3 = Color3.fromRGB(170, 170, 200)
            end
        end
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    if not activePage then
        activePage = page
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    return page
end

local function createButton(page, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 36)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(230, 230, 250)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    btn.Parent = page

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(50, 50, 70)
    btnStroke.Transparency = 0.5
    btnStroke.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- === ВКЛАДКИ И ФУНКЦИИ ===

-- 1. Вкладка "Player"
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

-- 2. Вкладка "Inspector" (Изучаем составляющие игры)
local inspectorTab = createTab("📦 Inspector")

createButton(inspectorTab, "🔍 Сканировать ReplicatedStorage", function()
    print("--- [ NOLIX: ReplicatedStorage Dump ] ---")
    for _, item in pairs(ReplicatedStorage:GetChildren()) do
        print("📁 Содержимое:", item.Name, "(Тип:", item.ClassName, ")")
    end
    print("-----------------------------------------")
    warn("📦 Сканирование завершено! Проверь консоль (F9)")
end)

createButton(inspectorTab, "⚙️ Найти RemoteEvents / Functions", function()
    print("--- [ NOLIX: Remotes Finder ] ---")
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            print("⚡ Remote:", obj:GetFullName())
        end
    end
    print("---------------------------------")
    warn("⚡ Все ремоуты выведены в консоль (F9)")
end)

createButton(inspectorTab, "🎯 Найти UI элементы в игре", function()
    print("--- [ NOLIX: PlayerGUI Dump ] ---")
    local pg = player:FindFirstChild("PlayerGui")
    if pg then
        for _, gui in pairs(pg:GetChildren()) do
            print("🖥️ GUI:", gui.Name)
        end
    end
    print("---------------------------------")
    warn("🖥️ Интерфейсы выведены в консоль (F9)")
end)

-- 3. Вкладка "World"
local worldTab = createTab("🌐 World")

createButton(worldTab, "💡 Fullbright (Подсветка)", function()
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

-- Перетаскивание панели
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
