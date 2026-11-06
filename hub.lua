-- ============================================
-- HUB VELOCIDADE HeNI v4.2 - Com scroll corrigido
-- ============================================

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ===== Cores =====
local COR_BG = Color3.fromRGB(20, 20, 20)
local COR_PAINEL = Color3.fromRGB(35, 35, 35)
local COR_VERMELHO = Color3.fromRGB(180, 30, 30)
local COR_VERMELHO_ESCURO = Color3.fromRGB(120, 20, 20)
local COR_TEXTO = Color3.fromRGB(255, 255, 255)
local COR_TEXTO_SUB = Color3.fromRGB(180, 180, 180)

-- ===== Configurações =====
local MAX_SPEED = 300
local MIN_SPEED = 1
local DEFAULT_SPEED = 40

-- ===== Estado =====
local originalSpeed = nil
local hubSpeed = nil

-- ===== Funções auxiliares =====
local function getHumanoid()
    local char = player.Character
    if char then
        return char:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

local function captureOriginalSpeed()
    local hum = getHumanoid()
    if hum and originalSpeed == nil then
        originalSpeed = hum.WalkSpeed
    end
end

-- ===== Interface =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HubVelocidadeHeNI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 420)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = COR_BG
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = COR_VERMELHO
stroke.Thickness = 2
stroke.Parent = frame

-- Barra de título
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = COR_VERMELHO
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 2
titleBar.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 20)
titleFix.Position = UDim2.new(0, 0, 0, 20)
titleFix.BackgroundColor3 = COR_VERMELHO
titleFix.BorderSizePixel = 0
titleFix.ZIndex = 2
titleFix.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "HUB VELOCIDADE HeNI"
title.TextColor3 = COR_TEXTO
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 3
title.Parent = titleBar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -38, 0, 5)
minBtn.BackgroundColor3 = COR_VERMELHO_ESCURO
minBtn.BorderSizePixel = 0
minBtn.Text = "—"
minBtn.TextColor3 = COR_TEXTO
minBtn.Font = Enum.Font.SourceSansBold
minBtn.TextSize = 18
minBtn.ZIndex = 100
minBtn.Active = true
minBtn.Parent = titleBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minBtn

-- Scroll
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -55)
scroll.Position = UDim2.new(0, 10, 0, 48)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 6
scroll.ScrollBarImageColor3 = COR_VERMELHO
scroll.CanvasSize = UDim2.new(0, 0, 0, 320)
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.ZIndex = 2
scroll.Parent = frame

local scrollLayout = Instance.new("UIListLayout")
scrollLayout.Padding = UDim.new(0, 10)
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollLayout.Parent = scroll

-- Impede o scroll de arrastar o hub junto
scroll.MouseEnter:Connect(function()
    frame.Draggable = false
end)
scroll.MouseLeave:Connect(function()
    frame.Draggable = true
end)
scroll.TouchTap:Connect(function()
    -- nada, só para garantir que o toque não passe para o frame
end)
scroll.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        frame.Draggable = false
    end
end)
scroll.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        frame.Draggable = true
    end
end)

-- ===== Seção: Velocidade =====
local speedSection = Instance.new("Frame")
speedSection.Size = UDim2.new(1, -10, 0, 170)
speedSection.BackgroundColor3 = COR_PAINEL
speedSection.BorderSizePixel = 0
speedSection.LayoutOrder = 1
speedSection.ZIndex = 2
speedSection.Parent = scroll

local speedSectionCorner = Instance.new("UICorner")
speedSectionCorner.CornerRadius = UDim.new(0, 8)
speedSectionCorner.Parent = speedSection

local speedTitle = Instance.new("TextLabel")
speedTitle.Size = UDim2.new(1, -30, 0, 28)
speedTitle.Position = UDim2.new(0, 15, 0, 8)
speedTitle.BackgroundTransparency = 1
speedTitle.Text = "⚡ Velocidade"
speedTitle.TextColor3 = COR_VERMELHO
speedTitle.Font = Enum.Font.SourceSansBold
speedTitle.TextSize = 15
speedTitle.TextXAlignment = Enum.TextXAlignment.Left
speedTitle.ZIndex = 3
speedTitle.Parent = speedSection

local speedValueBox = Instance.new("TextBox")
speedValueBox.Size = UDim2.new(0, 80, 0, 34)
speedValueBox.Position = UDim2.new(0, 15, 0, 42)
speedValueBox.BackgroundColor3 = COR_BG
speedValueBox.BorderSizePixel = 0
speedValueBox.Text = tostring(DEFAULT_SPEED)
speedValueBox.TextColor3 = COR_TEXTO
speedValueBox.Font = Enum.Font.SourceSansBold
speedValueBox.TextSize = 18
speedValueBox.ZIndex = 3
speedValueBox.Parent = speedSection

local valueCorner = Instance.new("UICorner")
valueCorner.CornerRadius = UDim.new(0, 6)
valueCorner.Parent = speedValueBox

local sliderBg = Instance.new("Frame")
sliderBg.Size = UDim2.new(0, 180, 0, 10)
sliderBg.Position = UDim2.new(0, 110, 0, 54)
sliderBg.BackgroundColor3 = COR_BG
sliderBg.BorderSizePixel = 0
sliderBg.ZIndex = 3
sliderBg.Parent = speedSection

local sliderBgCorner = Instance.new("UICorner")
sliderBgCorner.CornerRadius = UDim.new(0, 5)
sliderBgCorner.Parent = sliderBg

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(DEFAULT_SPEED / MAX_SPEED, 0, 1, 0)
sliderFill.BackgroundColor3 = COR_VERMELHO
sliderFill.BorderSizePixel = 0
sliderFill.ZIndex = 3
sliderFill.Parent = sliderBg

local sliderFillCorner = Instance.new("UICorner")
sliderFillCorner.CornerRadius = UDim.new(0, 5)
sliderFillCorner.Parent = sliderFill

local sliderKnob = Instance.new("Frame")
sliderKnob.Size = UDim2.new(0, 18, 0, 18)
sliderKnob.Position = UDim2.new(DEFAULT_SPEED / MAX_SPEED, -9, 0.5, -9)
sliderKnob.BackgroundColor3 = COR_TEXTO
sliderKnob.BorderSizePixel = 0
sliderKnob.ZIndex = 4
sliderKnob.Parent = sliderBg

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(0, 9)
knobCorner.Parent = sliderKnob

local applyBtn = Instance.new("TextButton")
applyBtn.Size = UDim2.new(0.45, -20, 0, 32)
applyBtn.Position = UDim2.new(0, 15, 0, 92)
applyBtn.BackgroundColor3 = COR_VERMELHO
applyBtn.BorderSizePixel = 0
applyBtn.Text = "Aplicar"
applyBtn.TextColor3 = COR_TEXTO
applyBtn.Font = Enum.Font.SourceSansBold
applyBtn.TextSize = 14
applyBtn.ZIndex = 3
applyBtn.Parent = speedSection

local applyCorner = Instance.new("UICorner")
applyCorner.CornerRadius = UDim.new(0, 6)
applyCorner.Parent = applyBtn

local panicBtn = Instance.new("TextButton")
panicBtn.Size = UDim2.new(0.45, -20, 0, 32)
panicBtn.Position = UDim2.new(0.55, 5, 0, 92)
panicBtn.BackgroundColor3 = Color3.fromRGB(200, 120, 30)
panicBtn.BorderSizePixel = 0
panicBtn.Text = "⏹ Pânico"
panicBtn.TextColor3 = COR_TEXTO
panicBtn.Font = Enum.Font.SourceSansBold
panicBtn.TextSize = 14
panicBtn.ZIndex = 3
panicBtn.Parent = speedSection

local panicCorner = Instance.new("UICorner")
panicCorner.CornerRadius = UDim.new(0, 6)
panicCorner.Parent = panicBtn

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -30, 0, 24)
statusLabel.Position = UDim2.new(0, 15, 0, 132)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: pronto"
statusLabel.TextColor3 = COR_TEXTO_SUB
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.ZIndex = 3
statusLabel.Parent = speedSection

-- ===== Seção: Informações =====
local infoSection = Instance.new("Frame")
infoSection.Size = UDim2.new(1, -10, 0, 100)
infoSection.BackgroundColor3 = COR_PAINEL
infoSection.BorderSizePixel = 0
infoSection.LayoutOrder = 2
infoSection.ZIndex = 2
infoSection.Parent = scroll

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 8)
infoCorner.Parent = infoSection

local infoTitle = Instance.new("TextLabel")
infoTitle.Size = UDim2.new(1, -30, 0, 28)
infoTitle.Position = UDim2.new(0, 15, 0, 8)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "ℹ Informações"
infoTitle.TextColor3 = COR_VERMELHO
infoTitle.Font = Enum.Font.SourceSansBold
infoTitle.TextSize = 15
infoTitle.TextXAlignment = Enum.TextXAlignment.Left
infoTitle.ZIndex = 3
infoTitle.Parent = infoSection

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -30, 0, 55)
infoText.Position = UDim2.new(0, 15, 0, 38)
infoText.BackgroundTransparency = 1
infoText.Text = "Script no cliente não rouba Exu.\nO servidor controla a posse.\nUse a velocidade para se mover melhor."
infoText.TextColor3 = COR_TEXTO_SUB
infoText.Font = Enum.Font.SourceSans
infoText.TextSize = 11
infoText.TextWrapped = true
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.ZIndex = 3
infoText.Parent = infoSection

-- ===== Lógica: slider =====
local function updateSpeedFromSlider(percent)
    percent = math.clamp(percent, 0, 1)
    local value = math.floor(MIN_SPEED + percent * (MAX_SPEED - MIN_SPEED))
    if percent >= 1 then value = MAX_SPEED end
    if percent <= 0 then value = MIN_SPEED end

    speedValueBox.Text = tostring(value)
    sliderFill.Size = UDim2.new(percent, 0, 1, 0)
    sliderKnob.Position = UDim2.new(percent, -9, 0.5, -9)

    if originalSpeed == nil then captureOriginalSpeed() end
    hubSpeed = value
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = value end
    statusLabel.Text = "Status: ativo (" .. value .. ")"
end

local dragging = false

sliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        frame.Draggable = false
        local relX = input.Position.X - sliderBg.AbsolutePosition.X
        updateSpeedFromSlider(relX / sliderBg.AbsoluteSize.X)
    end
end)

sliderBg.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local relX = input.Position.X - sliderBg.AbsolutePosition.X
        updateSpeedFromSlider(relX / sliderBg.AbsoluteSize.X)
    end
end)

sliderBg.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        frame.Draggable = true
    end
end)

-- ===== Lógica: digitar valor =====
speedValueBox.FocusLost:Connect(function()
    local num = tonumber(speedValueBox.Text)
    if not num then
        speedValueBox.Text = tostring(hubSpeed or DEFAULT_SPEED)
        return
    end
    num = math.clamp(math.floor(num), MIN_SPEED, MAX_SPEED)
    speedValueBox.Text = tostring(num)
    local percent = (num - MIN_SPEED) / (MAX_SPEED - MIN_SPEED)
    sliderFill.Size = UDim2.new(percent, 0, 1, 0)
    sliderKnob.Position = UDim2.new(percent, -9, 0.5, -9)
    if originalSpeed == nil then captureOriginalSpeed() end
    hubSpeed = num
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = num end
    statusLabel.Text = "Status: ativo (" .. num .. ")"
end)

-- ===== Lógica: botão aplicar =====
applyBtn.MouseButton1Click:Connect(function()
    local num = tonumber(speedValueBox.Text)
    if num then
        num = math.clamp(math.floor(num), MIN_SPEED, MAX_SPEED)
        hubSpeed = num
        local hum = getHumanoid()
        if hum then hum.WalkSpeed = num end
        statusLabel.Text = "Status: ativo (" .. num .. ")"
    end
end)

-- ===== Lógica: pânico =====
panicBtn.MouseButton1Click:Connect(function()
    hubSpeed = nil
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = 16 end
    statusLabel.Text = "Status: pânico — velocidade resetada"
end)

-- ===== Minimizar =====
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 50, 0, 50)
miniBtn.Position = UDim2.new(0, 20, 0, 20)
miniBtn.BackgroundColor3 = COR_VERMELHO
miniBtn.BorderSizePixel = 0
miniBtn.Text = "⚡"
miniBtn.TextColor3 = COR_TEXTO
miniBtn.Font = Enum.Font.SourceSansBold
miniBtn.TextSize = 24
miniBtn.Visible = false
miniBtn.Active = true
miniBtn.Draggable = true
miniBtn.ZIndex = 100
miniBtn.Parent = screenGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 25)
miniCorner.Parent = miniBtn

minBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    miniBtn.Visible = true
end)

miniBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    miniBtn.Visible = false
end)

-- ===== Loop de reaplicação =====
task.spawn(function()
    while task.wait(0.5) do
        if hubSpeed then
            local hum = getHumanoid()
            if hum and hum.WalkSpeed ~= hubSpeed then
                hum.WalkSpeed = hubSpeed
            end
        end
    end
end)

-- ===== Inicialização =====
captureOriginalSpeed()
statusLabel.Text = "Status: pronto (original: " .. tostring(originalSpeed and math.floor(originalSpeed)) .. ")"
