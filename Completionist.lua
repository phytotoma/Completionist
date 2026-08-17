local addonName = ...

CompletionistDB = CompletionistDB or { 
    Zones = {}, Instances = {}, CustomList = {}, CustomStates = {}, NotesText = "", Minimap = { minimapPos = 220 }, Settings = {} 
}

SLASH_COMPLETIONIST1 = "/completionist"
SLASH_COMPLETIONIST2 = "/comp"
SlashCmdList["COMPLETIONIST"] = function()
    if CompletionistFrame:IsShown() then
        CompletionistFrame:Hide()
    else
        CompletionistFrame:Show()
    end
end

BINDING_HEADER_COMPLETIONIST = "Completionist"
BINDING_NAME_TOGGLECOMPLETIONIST = "Toggle Completionist Window"

local Zones = {
    {n="Elwynn Forest", l="1-10", f="A"}, {n="Dun Morogh", l="1-10", f="A"}, {n="Teldrassil", l="1-10", f="A"}, {n="Azuremyst Isle", l="1-10", f="A", info="TBC zone"},
    {n="Durotar", l="1-10", f="H"}, {n="Mulgore", l="1-10", f="H"}, {n="Tirisfal Glades", l="1-10", f="H"}, {n="Eversong Woods", l="1-10", f="H", info="TBC zone"},
    {n="Westfall", l="10-20", f="A"}, {n="Loch Modan", l="10-20", f="A"}, {n="Darkshore", l="10-20", f="A"}, {n="Bloodmyst Isle", l="10-20", f="A", info="TBC zone"},
    {n="Silverpine Forest", l="10-20", f="H"}, {n="Ghostlands", l="10-20", f="H", info="TBC zone"}, {n="The Barrens", l="10-20", f="N"},
    {n="Redridge Mountains", l="20-30", f="N"}, {n="Duskwood", l="20-30", f="N"}, {n="Wetlands", l="20-30", f="N"},
    {n="Ashenvale", l="20-30", f="N"}, {n="Stonetalon Mountains", l="20-30", f="N"}, {n="Hillsbrad Foothills", l="20-30", f="N"},
    {n="Thousand Needles", l="25-35", f="N"},
    {n="Arathi Highlands", l="30-40", f="N"}, {n="Alterac Mountains", l="30-40", f="N"}, {n="Desolace", l="30-40", f="N"},
    {n="Stranglethorn Vale", l="30-45", f="N"},
    {n="Dustwallow Marsh", l="35-45", f="N"}, {n="Badlands", l="35-45", f="N"}, {n="Swamp of Sorrows", l="35-45", f="N"},
    {n="Feralas", l="40-50", f="N"}, {n="Tanaris", l="40-50", f="N"},
    {n="The Hinterlands", l="45-50", f="N"},
    {n="Searing Gorge", l="45-55", f="N"}, {n="Azshara", l="45-55", f="N"}, {n="Felwood", l="45-55", f="N"}, {n="Blasted Lands", l="45-55", f="N"}, {n="Un'goro Crater", l="45-55", f="N"},
    {n="Western Plaguelands", l="50-60", f="N"}, {n="Burning Steppes", l="50-60", f="N"},
    {n="Winterspring", l="55-60", f="N"}, {n="Eastern Plaguelands", l="55-60", f="N"}, {n="Deadwind Pass", l="55-60", f="N"}, {n="Silithus", l="55-60", f="N"},
    {n="Hellfire Peninsula", l="58-70", f="N", info="TBC zone"}, {n="Zangarmarsh", l="58-70", f="N", info="TBC zone"}, {n="Terokkar Forest", l="58-70", f="N", info="TBC zone"}, {n="Nagrand", l="58-70", f="N", info="TBC zone"}, {n="Blade's Edge Mountains", l="58-70", f="N", info="TBC zone"}, {n="Netherstorm", l="58-70", f="N", info="TBC zone"}, {n="Shadowmoon Valley", l="58-70", f="N", info="TBC zone"},
    {n="Borean Tundra", l="68-80", f="N", info="WotLK zone"}, {n="Howling Fjord", l="68-80", f="N", info="WotLK zone"}, {n="Dragonblight", l="68-80", f="N", info="WotLK zone"}, {n="Grizzly Hills", l="68-80", f="N", info="WotLK zone"}, {n="Zul'Drak", l="68-80", f="N", info="WotLK zone"}, {n="Sholazar Basin", l="68-80", f="N", info="WotLK zone"}, {n="The Storm Peaks", l="68-80", f="N", info="WotLK zone"}, {n="Icecrown", l="68-80", f="N", info="WotLK zone"}, {n="Crystalsong Forest", l="68-80", f="N", info="WotLK zone"}
}

local Instances = {
    {n="Ragefire Chasm", l="13-18"}, {n="Wailing Caverns", l="15-25"}, {n="The Deadmines", l="18-23"},
    {n="Shadowfang Keep", l="22-30"}, {n="The Stockade", l="22-30"}, {n="Blackfathom Deeps", l="24-32"},
    {n="Gnomeregan", l="29-38"}, {n="Razorfen Kraul", l="30-40"}, {n="Scarlet Monastery Graveyard", l="28-38"},
    {n="Scarlet Monastery Library", l="29-39"}, {n="Scarlet Monastery Armory", l="32-42"}, {n="Scarlet Monastery Cathedral", l="35-45"},
    {n="Razorfen Downs", l="40-50"}, {n="Uldaman", l="42-52"}, {n="Zul'Farrak", l="44-54"},
    {n="Maraudon Wicked Grotto (Purple)", l="45-53"}, {n="Maraudon Foulspore Cavern (Orange)", l="45-53"}, {n="Maraudon Earth Song Falls (Inner)", l="48-57"},
    {n="The Temple of Atal'Hakkar", l="50-60"}, {n="Blackrock Depths", l="52-60"}, {n="Blackrock Spire Lower", l="55-60"},
    {n="Blackrock Spire Upper", l="58-60"}, {n="Scholomance", l="58-60"}, {n="Stratholme", l="58-60"}, {n="Dire Maul", l="58-60"},
    {n="Hellfire Ramparts", l="59-62", info="TBC dungeon"}, {n="The Blood Furnace", l="60-63", info="TBC dungeon"}, {n="The Slave Pens", l="61-64", info="TBC dungeon"},
    {n="The Underbog", l="62-65", info="TBC dungeon"}, {n="Mana-Tombs", l="64-66", info="TBC dungeon"}, {n="Auchenai Crypts", l="65-67", info="TBC dungeon"},
    {n="The Escape from Durnholde", l="66-68", info="TBC dungeon"}, {n="Sethekk Halls", l="67-69", info="TBC dungeon"}, {n="Shadow Labyrinth", l="68-70", info="TBC dungeon"},
    {n="The Shattered Halls", l="68-70", info="TBC dungeon"}, {n="The Botanica", l="68-70", info="TBC dungeon"}, {n="The Mechanar", l="68-70", info="TBC dungeon"},
    {n="The Arcatraz", l="68-70", info="TBC dungeon"}, {n="Opening of the Dark Portal", l="69-70", info="TBC dungeon"}, {n="Magisters' Terrace", l="70", info="TBC dungeon"},
    {n="Utgarde Keep", l="68-72", info="WotLK dungeon"}, {n="The Nexus", l="69-73", info="WotLK dungeon"}, {n="Azjol-Nerub", l="71-74", info="WotLK dungeon"},
    {n="Ahn'kahet: The Old Kingdom", l="73-75", info="WotLK dungeon"}, {n="Drak'Tharon Keep", l="73-76", info="WotLK dungeon"}, {n="The Violet Hold", l="75-77", info="WotLK dungeon"},
    {n="Gundrak", l="76-78", info="WotLK dungeon"}, {n="Halls of Stone", l="77-79", info="WotLK dungeon"}, {n="Halls of Lightning", l="79-80", info="WotLK dungeon"},
    {n="The Oculus", l="79-80", info="WotLK dungeon"}, {n="Culling of Stratholme", l="79-80", info="WotLK dungeon"}, {n="Utgarde Pinnacle", l="79-80", info="WotLK dungeon"},
    {n="Trial of the Champion", l="80", info="WotLK dungeon"}, {n="The Forge of Souls", l="80", info="WotLK dungeon"}, {n="Pit of Saron", l="80", info="WotLK dungeon"},
    {n="Halls of Reflection", l="80", info="WotLK dungeon"},
    {n="Molten Core", info="40-man raid"}, {n="Onyxia's Lair", info="40-man raid"},
    {n="Azuregos", info="world boss"}, {n="Lord Kazzak", info="world boss"},
    {n="Blackwing Lair", info="40-man raid"}, {n="Zul'Gurub", info="20-man raid"},
    {n="Dragons of Nightmare", info="world boss"}, {n="Ruins of Ahn'Qiraj", info="20-man raid"},
    {n="Temple of Ahn'Qiraj", info="40-man raid"}, {n="Naxxramas", info="40-man raid"},
    {n="Doom Lord Kazzak", info="TBC world boss"}, {n="Doomwalker", info="TBC world boss"},
    {n="Karazhan", info="TBC raid"}, {n="Gruul's Lair", info="TBC raid"}, {n="Magtheridon's Lair", info="TBC raid"},
    {n="Serpentshrine Cavern", info="TBC raid"}, {n="The Eye", info="TBC raid"}, {n="Battle for Mount Hyjal", info="TBC raid"},
    {n="Black Temple", info="TBC raid"}, {n="Zul'Aman", info="TBC raid"}, {n="Sunwell Plateau", info="TBC raid"},
    {n="Vault of Archavon", info="WotLK raid"}, {n="Naxxramas ", info="WotLK raid"}, 
    {n="The Obsidian Sanctum", info="WotLK raid"}, {n="The Eye of Eternity", info="WotLK raid"},
    {n="Ulduar", info="WotLK raid"}, {n="Trial of the Crusader", info="WotLK raid"},
    {n="Onyxia's Lair ", info="WotLK raid"}, {n="Icecrown Citadel", info="WotLK raid"},
    {n="The Ruby Sanctum", info="WotLK raid"}
}

local currentTab = "Zones"
local buttons = {}

local function GetExpansion(info)
    if not info then return "Classic" end
    if string.find(info, "TBC") then return "TBC" end
    if string.find(info, "WotLK") then return "WotLK" end
    return "Classic"
end

local function IsExpansionAllowed(info)
    local settings = CompletionistDB.Settings or {}
    local exp = GetExpansion(info)
    if exp ~= "Classic" and settings.showExpansion == false then return false end
    return true
end

local function GetCurrentDB()
    if currentTab == "Zones" then
        return CompletionistDB.Zones
    elseif currentTab == "Instances" then
        return CompletionistDB.Instances
    elseif currentTab == "Custom" then
        CompletionistDB.CustomStates = CompletionistDB.CustomStates or {}
        return CompletionistDB.CustomStates
    end
end

local function GetBracketedZones()
    local list = {}
    local lastLevel = nil
    local _, playerFaction = UnitFactionGroup("player")
    local fCode = (playerFaction == "Alliance") and "A" or "H"
    local settings = CompletionistDB.Settings or {}

    for _, zone in ipairs(Zones) do
        local include = true
        
        if settings.factionFilter and zone.f ~= "N" and zone.f ~= fCode then
            include = false
        end
        if include and not IsExpansionAllowed(zone.info) then include = false end
        
        if include then
            if zone.l ~= lastLevel then
                lastLevel = zone.l
                table.insert(list, { isHeader = true, title = lastLevel .. " Bracket" })
            end
            table.insert(list, zone)
        end
    end
    return list
end

local function GetGroupedInstances()
    local list = {}
    local addedDungeonsHeader = false
    local addedRaidsHeader = false
    for _, inst in ipairs(Instances) do
        if IsExpansionAllowed(inst.info) then
            if inst.l then
                if not addedDungeonsHeader then
                    addedDungeonsHeader = true
                    table.insert(list, { isHeader = true, title = "Dungeons" })
                end
                table.insert(list, inst)
            else
                if not addedRaidsHeader then
                    addedRaidsHeader = true
                    table.insert(list, { isHeader = true, title = "Raids" })
                end
                table.insert(list, inst)
            end
        end
    end
    return list
end

local f = CreateFrame("Frame", "CompletionistFrame", UIParent)
f:SetSize(430, 550)
f:SetPoint("TOPLEFT", 16, -116)
f:SetBackdrop({
    bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})
f:SetBackdropColor(0.05, 0.05, 0.05, 0.85)
f:EnableMouse(true)
f:SetMovable(true)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", f.StartMoving)
f:SetScript("OnDragStop", f.StopMovingOrSizing)
f:Hide()
table.insert(UISpecialFrames, "CompletionistFrame")

local header = f:CreateTexture(nil, "ARTWORK")
header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
header:SetWidth(256)
header:SetHeight(64)
header:SetPoint("TOP", 0, 12)

local title = f:CreateFontString(nil, "OVERLAY")
title:SetFont("Fonts\\FRIZQT__.TTF", 14)
title:SetPoint("TOP", header, "TOP", 0, -14)
title:SetText("Completionist")
title:SetTextColor(1, 0.82, 0)

local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", -5, -5)

local pctText = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
pctText:SetPoint("BOTTOM", 0, 20)
pctText:SetText("Completion: 0%")

local UpdateList 

StaticPopupDialogs["COMPLETIONIST_RESET_CONFIRM"] = {
    text = "This action will erase all your progress",
    button1 = "OK",
    button2 = "Cancel",
    OnAccept = function()
        if currentTab == "Zones" then
            CompletionistDB.Zones = {}
        elseif currentTab == "Instances" then
            CompletionistDB.Instances = {}
        end
        UpdateList()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

local resetBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
resetBtn:SetSize(75, 22)
resetBtn:SetPoint("BOTTOMRIGHT", -55, 18)
resetBtn:SetText("Reset")
resetBtn:SetScript("OnClick", function()
    StaticPopup_Show("COMPLETIONIST_RESET_CONFIRM")
end)
resetBtn:Hide()

local minimapButton = CreateFrame("Button", "CompletionistMinimapButton", Minimap)
minimapButton:SetSize(31, 31)
minimapButton:SetFrameStrata("MEDIUM")
minimapButton:SetFrameLevel(8)
minimapButton:SetMovable(true)

local bg = minimapButton:CreateTexture(nil, "BACKGROUND")
bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
bg:SetSize(25, 25)
bg:SetPoint("TOPLEFT", 2, -4)

local icon = minimapButton:CreateTexture(nil, "ARTWORK")
icon:SetTexture("Interface\\AddOns\\Completionist\\icon")
icon:SetSize(20, 20)
icon:SetPoint("TOPLEFT", 7, -6)

local border = minimapButton:CreateTexture(nil, "OVERLAY")
border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
border:SetSize(54, 54)
border:SetPoint("TOPLEFT", 0, 0)

local function UpdateMinimapButtonPosition()
    CompletionistDB.Minimap = CompletionistDB.Minimap or { minimapPos = 220 }
    local angle = math.rad(CompletionistDB.Minimap.minimapPos)
    local x = math.cos(angle) * 80
    local y = math.sin(angle) * 80
    minimapButton:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

minimapButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
minimapButton:SetScript("OnClick", function(self, button)
    if button == "LeftButton" then
        if CompletionistFrame:IsShown() then
            CompletionistFrame:Hide()
        else
            CompletionistFrame:Show()
        end
    elseif button == "RightButton" then
        if not CompletionistFrame:IsShown() then
            CompletionistFrame:Show()
        end
        currentTab = "Settings"
        UpdateList()
    end
end)

minimapButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText("Completionist", 1, 0.82, 0)
    GameTooltip:AddLine("Left-click to toggle window.", 1, 1, 1)
    GameTooltip:AddLine("Right-click to open settings.", 1, 1, 1)
    GameTooltip:AddLine("Drag to move button.", 0.7, 0.7, 0.7)
    GameTooltip:Show()
end)

minimapButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

minimapButton:SetScript("OnDragStart", function(self)
    self:SetScript("OnUpdate", function(self)
        local x, y = GetCursorPosition()
        local cx, cy = Minimap:GetCenter()
        local scale = Minimap:GetEffectiveScale()
        x, y = x / scale, y / scale
        local angle = math.deg(math.atan2(y - cy, x - cx))
        CompletionistDB.Minimap.minimapPos = angle
        UpdateMinimapButtonPosition()
    end)
end)
minimapButton:SetScript("OnDragStop", function(self) self:SetScript("OnUpdate", nil) end)
minimapButton:RegisterForDrag("LeftButton")

local editBox = CreateFrame("EditBox", "CompletionistCustomInput", f, "InputBoxTemplate")
editBox:SetSize(280, 20)
editBox:SetPoint("TOPLEFT", 20, -72)
editBox:SetAutoFocus(false)
editBox:SetMaxLetters(100)
editBox:Hide()

local addBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
addBtn:SetSize(80, 22)
addBtn:SetPoint("LEFT", editBox, "RIGHT", 5, 0)
addBtn:SetText("Add")
addBtn:SetScript("OnClick", function()
    local text = editBox:GetText()
    text = text:match("^%s*(.-)%s*$")
    if text and text ~= "" then
        CompletionistDB.CustomList = CompletionistDB.CustomList or {}
        local exists = false
        for _, v in ipairs(CompletionistDB.CustomList) do
            if v == text then exists = true; break; end
        end
        if not exists then
            table.insert(CompletionistDB.CustomList, text)
            CompletionistDB.CustomStates = CompletionistDB.CustomStates or {}
            CompletionistDB.CustomStates[text] = 0
            editBox:SetText("")
            editBox:ClearFocus()
            UpdateList()
        end
    end
end)
addBtn:Hide()
editBox:SetScript("OnEnterPressed", function() addBtn:GetScript("OnClick")(addBtn) end)

local scrollFrame = CreateFrame("ScrollFrame", "CompletionistScrollFrame", f, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 15, -70)
scrollFrame:SetPoint("BOTTOMRIGHT", -35, 50)

local scrollChild = CreateFrame("Frame", nil, scrollFrame)
scrollChild:SetSize(scrollFrame:GetWidth(), 100)
scrollFrame:SetScrollChild(scrollChild)

local notesScroll = CreateFrame("ScrollFrame", "CompletionistNotesScroll", f, "UIPanelScrollFrameTemplate")
notesScroll:SetPoint("TOPLEFT", 15, -70)
notesScroll:SetPoint("BOTTOMRIGHT", -35, 38)
notesScroll:Hide()

local notesBg = CreateFrame("Frame", nil, f)
notesBg:SetPoint("TOPLEFT", notesScroll, "TOPLEFT")
notesBg:SetPoint("BOTTOMRIGHT", notesScroll, "BOTTOMRIGHT")
notesBg:SetBackdrop({
    bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
notesBg:SetBackdropColor(0.05, 0.05, 0.05, 0.85)
notesBg:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
notesBg:EnableMouse(true)
notesBg:SetScript("OnMouseDown", function() CompletionistNotesEditBox:SetFocus() end)
notesBg:Hide()

local notesEditBox = CreateFrame("EditBox", "CompletionistNotesEditBox", notesScroll)
notesEditBox:SetMultiLine(true)
notesEditBox:SetMaxLetters(99999)
notesEditBox:SetFont("Fonts\\FRIZQT__.TTF", 14)
notesEditBox:SetTextColor(1, 1, 1, 1)
notesEditBox:SetAutoFocus(false)
notesEditBox:SetTextInsets(10, 10, 10, 10)
notesEditBox:SetScript("OnTextChanged", function(self)
    CompletionistDB.NotesText = self:GetText()
    self:SetHeight(math.max(notesScroll:GetHeight(), self:GetTextHeight() + 20))
end)
notesEditBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
notesScroll:SetScrollChild(notesEditBox)
notesScroll:SetScript("OnMouseDown", function() notesEditBox:SetFocus() end)

local settingsContainer = CreateFrame("Frame", nil, f)
settingsContainer:SetPoint("TOPLEFT", 25, -75)
settingsContainer:SetPoint("BOTTOMRIGHT", -25, 45)
settingsContainer:Hide()

local function CreateSettingCheckbox(parent, label, x, y, dbKey, onClickFunc)
    local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    cb:SetSize(24, 24)
    cb:SetPoint("TOPLEFT", x, y)
    local text = cb:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    text:SetPoint("LEFT", cb, "RIGHT", 4, 0)
    text:SetText(label)
    cb:SetScript("OnClick", function(self)
        CompletionistDB.Settings = CompletionistDB.Settings or {}
        CompletionistDB.Settings[dbKey] = self:GetChecked() and true or false
        if onClickFunc then onClickFunc(CompletionistDB.Settings[dbKey]) end
    end)
    return cb, text
end

local function CreateTransparencySetting(parent, x, y)
    local container = CreateFrame("Frame", "CompletionistTransparencyContainer", parent)
    container:SetSize(340, 45)
    container:SetPoint("TOPLEFT", x, y)

    local txt = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
    txt:SetText("Transparency")

    local bar = CreateFrame("Button", nil, container)
    bar:SetSize(140, 14) 
    bar:SetPoint("TOPLEFT", container, "TOPLEFT", 0, -20)
    bar:EnableMouse(true)
    bar:EnableMouseWheel(true) 
    bar:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    bar:SetBackdropColor(0.1, 0.1, 0.1, 1)
    bar:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)

    local bg = bar:CreateTexture(nil, "BACKGROUND")
    bg:SetTexture("Interface\\Buttons\\UI-SliderBar-Background")
    bg:SetSize(130, 8)
    bg:SetPoint("CENTER")

    local thumb = CreateFrame("Button", nil, bar)
    thumb:SetSize(16, 24)
    thumb:SetMovable(true)

    local thumbTex = thumb:CreateTexture(nil, "ARTWORK")
    thumbTex:SetTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
    thumbTex:SetSize(32, 32)
    thumbTex:SetPoint("CENTER")

    local editBox = CreateFrame("EditBox", "CompletionistAlphaEditBox", container, "InputBoxTemplate")
    editBox:SetSize(45, 20)
    editBox:SetPoint("LEFT", bar, "RIGHT", 10, 0)
    editBox:SetAutoFocus(false)
    editBox:SetMaxLetters(4)

    local resetBtn = CreateFrame("Button", nil, container, "UIPanelButtonTemplate")
    resetBtn:SetSize(55, 22)
    resetBtn:SetPoint("LEFT", editBox, "RIGHT", 8, 0)
    resetBtn:SetText("Reset")

    local minV, maxV, step = 0.1, 1.0, 0.05

    local function GetValueFromX(mouseX)
        local barLeft = bar:GetLeft()
        local barWidth = bar:GetWidth()
        if not barLeft or not barWidth or barWidth == 0 then return minV end
        local pct = (mouseX - barLeft) / barWidth
        pct = math.max(0, math.min(1, pct))
        local val = minV + pct * (maxV - minV)
        local mult = 1 / step
        return math.floor(val * mult + 0.5) / mult
    end

    local function ApplyValue(val)
        val = math.max(minV, math.min(maxV, val))
        local mult = 1 / step
        val = math.floor(val * mult + 0.5) / mult

        CompletionistDB.Settings = CompletionistDB.Settings or {}
        CompletionistDB.Settings.alpha = val
        f:SetBackdropColor(0.05, 0.05, 0.05, val)

        local pct = (val - minV) / (maxV - minV)
        local barWidth = bar:GetWidth()
        if barWidth == 0 then barWidth = 140 end
        thumb:SetPoint("CENTER", bar, "LEFT", pct * barWidth, 0)

        if not editBox:HasFocus() then
            editBox:SetText(string.format("%.2f", val))
        end
    end

    bar:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            local cursorX = GetCursorPosition() / UIParent:GetEffectiveScale()
            ApplyValue(GetValueFromX(cursorX))
        end
    end)
    
    bar:SetScript("OnMouseWheel", function(self, delta)
        local currentVal = CompletionistDB.Settings.alpha or 0.85
        ApplyValue(currentVal + (delta * step))
    end)

    thumb:RegisterForDrag("LeftButton")
    thumb:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function()
            local cursorX = GetCursorPosition() / UIParent:GetEffectiveScale()
            ApplyValue(GetValueFromX(cursorX))
        end)
    end)
    thumb:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
    end)

    editBox:SetScript("OnEnterPressed", function(self)
        local text = self:GetText()
        local num = tonumber(text)
        if num then
            ApplyValue(num)
        else
            local cur = CompletionistDB.Settings.alpha or 0.85
            self:SetText(string.format("%.2f", cur))
        end
        self:ClearFocus()
    end)

    editBox:SetScript("OnEditFocusLost", function(self)
        local text = self:GetText()
        local num = tonumber(text)
        if num then
            ApplyValue(num)
        else
            local cur = CompletionistDB.Settings.alpha or 0.85
            self:SetText(string.format("%.2f", cur))
        end
    end)

    resetBtn:SetScript("OnClick", function()
        ApplyValue(0.85)
    end)

    container.SetValue = function(_, val)
        ApplyValue(val or 0.85)
    end

    return container
end

local headerBehavior = settingsContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
headerBehavior:SetPoint("TOPLEFT", 0, 0)
headerBehavior:SetText("Behavior:")

local cbFactionColors = CreateSettingCheckbox(settingsContainer, "Enable faction colors", 5, -25, "factionColors")
local cbFactionFilter = CreateSettingCheckbox(settingsContainer, "Filter by faction", 5, -50, "factionFilter")
local cbShowExpansion = CreateSettingCheckbox(settingsContainer, "Show expansion content", 20, -75, "showExpansion")
local cbCombinedProg, cbCombinedProgText = CreateSettingCheckbox(settingsContainer, "Combined progression", 5, -100, "combinedProg")

local combinedProgInfoBtn = CreateFrame("Button", nil, settingsContainer)
combinedProgInfoBtn:SetSize(16, 16)
combinedProgInfoBtn:SetPoint("LEFT", cbCombinedProgText, "RIGHT", 8, 0)

local combinedProgInfoTex = combinedProgInfoBtn:CreateTexture(nil, "ARTWORK")
combinedProgInfoTex:SetAllPoints()
combinedProgInfoTex:SetTexture("Interface\\FriendsFrame\\InformationIcon")

combinedProgInfoBtn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Combine the percentage of completion from the Zone and Instances tab", 1, 1, 1)
    GameTooltip:Show()
end)
combinedProgInfoBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

local headerApp = settingsContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
headerApp:SetPoint("TOPLEFT", 0, -140)
headerApp:SetText("Appearance:")

local cbHideMinimap = CreateSettingCheckbox(settingsContainer, "Hide Minimap button", 5, -165, "hideMinimap", function(val)
    if val then minimapButton:Hide() else minimapButton:Show() end
end)
local cbLockWindow = CreateSettingCheckbox(settingsContainer, "Lock window position", 5, -190, "lockWindow", function(val)
    f:SetMovable(not val)
end)

local sliderAlpha = CreateTransparencySetting(settingsContainer, 15, -230)

local function GetCompletionStats(dataList, db)
    local t, c, s = 0, 0, 0
    for _, data in ipairs(dataList) do
        if not data.isHeader then
            t = t + 1
            local state = db[data.n] or 0
            if state == 1 then c = c + 1 elseif state == 2 then s = s + 1 end
        end
    end
    return t, c, s
end

UpdateList = function()
    local settings = CompletionistDB.Settings or {}

    if currentTab == "Notes" then
        scrollFrame:Hide()
        editBox:Hide()
        addBtn:Hide()
        resetBtn:Hide()
        settingsContainer:Hide()
        notesScroll:Show()
        notesBg:Show()
        pctText:Hide()
        notesEditBox:SetWidth(notesScroll:GetWidth() - 20)
        notesEditBox:SetText(CompletionistDB.NotesText or "")
        return
    elseif currentTab == "Settings" then
        scrollFrame:Hide()
        editBox:Hide()
        addBtn:Hide()
        resetBtn:Hide()
        notesScroll:Hide()
        notesBg:Hide()
        pctText:Hide()
        settingsContainer:Show()
        
        cbFactionColors:SetChecked(settings.factionColors)
        cbFactionFilter:SetChecked(settings.factionFilter)
        cbShowExpansion:SetChecked(settings.showExpansion)
        cbCombinedProg:SetChecked(settings.combinedProg)
        cbHideMinimap:SetChecked(settings.hideMinimap)
        cbLockWindow:SetChecked(settings.lockWindow)
        sliderAlpha:SetValue(settings.alpha or 0.85)
        return
    else
        settingsContainer:Hide()
        notesScroll:Hide()
        notesBg:Hide()
        pctText:Show()
    end

    local dataList
    if currentTab == "Zones" then
        dataList = GetBracketedZones()
        resetBtn:Show()
    elseif currentTab == "Instances" then
        dataList = GetGroupedInstances()
        resetBtn:Show()
    elseif currentTab == "Custom" then
        CompletionistDB.CustomList = CompletionistDB.CustomList or {}
        dataList = CompletionistDB.CustomList
        resetBtn:Hide()
    end

    if currentTab == "Custom" then
        editBox:Show()
        addBtn:Show()
        scrollFrame:SetPoint("TOPLEFT", 15, -100)
    else
        editBox:Hide()
        addBtn:Hide()
        scrollFrame:SetPoint("TOPLEFT", 15, -70)
    end
    
    scrollFrame:Show()
    local total, completed, skipped = 0, 0, 0
    scrollChild:SetHeight(#dataList * 24)

    for i=1, #dataList do
        local data = dataList[i]
        local btn = buttons[i]
        
        if not btn then
            btn = CreateFrame("Button", nil, scrollChild)
            btn:SetSize(scrollChild:GetWidth(), 24)
            btn:SetPoint("TOPLEFT", 0, -(i-1)*24)
            btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
            
            local cb = CreateFrame("CheckButton", nil, btn, "UICheckButtonTemplate")
            cb:SetSize(24, 24)
            cb:SetPoint("LEFT", 0, 0)
            cb:EnableMouse(false)
            btn.cb = cb
            
            local text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            text:SetFont("Fonts\\FRIZQT__.TTF", 13)
            btn.text = text
            
            local infoBtn = CreateFrame("Button", nil, btn)
            infoBtn:SetSize(16, 16)
            
            local infoTexture = infoBtn:CreateTexture(nil, "ARTWORK")
            infoTexture:SetAllPoints()
            infoTexture:SetTexture("Interface\\FriendsFrame\\InformationIcon")
            btn.infoTexture = infoTexture
            
            infoBtn:SetScript("OnEnter", function(self)
                if self.tooltipText then
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetText(self.tooltipText, 1, 1, 1)
                    GameTooltip:Show()
                end
            end)
            infoBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
            btn.infoBtn = infoBtn

            local delBtn = CreateFrame("Button", nil, btn, "UIPanelCloseButton")
            delBtn:SetSize(22, 22)
            delBtn:SetScript("OnClick", function()
                if currentTab == "Custom" and btn.dataName then
                    for idx, name in ipairs(CompletionistDB.CustomList) do
                        if name == btn.dataName then
                            table.remove(CompletionistDB.CustomList, idx)
                            if CompletionistDB.CustomStates then CompletionistDB.CustomStates[name] = nil end
                            break
                        end
                    end
                    UpdateList()
                end
            end)
            btn.delBtn = delBtn
            buttons[i] = btn
        end

        if data.isHeader then
            btn.cb:Hide()
            btn.delBtn:Hide()
            btn.infoBtn:Hide()
            btn.text:SetPoint("LEFT", btn, "LEFT", 4, 0)
            btn.text:SetFont("Fonts\\FRIZQT__.TTF", 13)
            btn.text:SetText(data.title)
            btn.text:SetTextColor(1, 0.7, 0.2)
            btn:SetScript("OnClick", nil)
            btn.dataName = nil
        else
            btn.cb:Show()
            btn.text:SetPoint("LEFT", btn.cb, "RIGHT", 4, 0)
            btn.text:SetFont("Fonts\\FRIZQT__.TTF", 13)

            local name, info, level, faction
            if currentTab == "Custom" then
                name = data
                info, level, faction = nil, nil, nil
            else
                name = data.n
                info = data.info
                level = data.l
                faction = data.f
            end

            btn.dataName = name
            local displayName = level and (name .. " (" .. level .. ")") or name
            btn.text:SetText(displayName)
            
            if currentTab == "Custom" then
                btn.infoBtn:Hide()
                btn.delBtn:Show()
                btn.delBtn:ClearAllPoints()
                btn.delBtn:SetPoint("LEFT", btn.text, "RIGHT", 4, 0)
            else
                btn.delBtn:Hide()
                if info then
                    btn.infoBtn:Show()
                    btn.infoBtn.tooltipText = info
                    btn.infoBtn:ClearAllPoints()
                    btn.infoBtn:SetPoint("LEFT", btn.text, "RIGHT", 8, 0)
                else
                    btn.infoBtn:Hide()
                end
            end

            btn:SetScript("OnClick", function(self, button)
                local n = self.dataName
                local db = GetCurrentDB()
                local curState = db[n] or 0
                if button == "LeftButton" then
                    db[n] = (curState == 1) and 0 or 1
                elseif button == "RightButton" then
                    db[n] = (curState == 2) and 0 or 2
                end
                UpdateList()
            end)

            local db = GetCurrentDB()
            local state = db[name] or 0

            local defR, defG, defB = 1, 0.82, 0
            if currentTab == "Zones" and settings.factionColors then
                if faction == "A" then defR, defG, defB = 0.2, 0.6, 1
                elseif faction == "H" then defR, defG, defB = 1, 0.2, 0.2 end
            end

            if state == 1 then
                btn.cb:SetChecked(true)
                if currentTab == "Zones" and settings.factionColors and (faction == "A" or faction == "H") then
                    if faction == "A" then
                        btn.text:SetTextColor(0.1, 0.35, 0.6)
                    else
                        btn.text:SetTextColor(0.6, 0.1, 0.1)
                    end
                else
                    btn.text:SetTextColor(0.9, 0.65, 0)
                end
                completed = completed + 1
            elseif state == 2 then
                btn.cb:SetChecked(false)
                btn.text:SetTextColor(0.5, 0.5, 0.5)
                skipped = skipped + 1
            else
                btn.cb:SetChecked(false)
                btn.text:SetTextColor(defR, defG, defB) 
            end
            total = total + 1
        end
        btn:Show()
    end

    for i = #dataList + 1, #buttons do
        buttons[i]:Hide()
    end

    local validTotal = total - skipped
    local pct = validTotal > 0 and (completed / validTotal * 100) or 0

    if (currentTab == "Zones" or currentTab == "Instances") and settings.combinedProg then
        local zT, zC, zS = GetCompletionStats(GetBracketedZones(), CompletionistDB.Zones)
        local iT, iC, iS = GetCompletionStats(GetGroupedInstances(), CompletionistDB.Instances)
        
        local combValidTotal = (zT + iT) - (zS + iS)
        pct = combValidTotal > 0 and ((zC + iC) / combValidTotal * 100) or 0
    end

    pctText:SetText(string.format("Completion: %.1f%%", pct))
end

local tab1 = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
tab1:SetSize(90, 25)
tab1:SetPoint("TOPLEFT", 15, -40)
tab1:SetText("Zones")
tab1:SetScript("OnClick", function() currentTab = "Zones"; UpdateList() end)

local tab2 = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
tab2:SetSize(75, 25)
tab2:SetPoint("LEFT", tab1, "RIGHT", 4, 0)
tab2:SetText("Instances")
tab2:SetScript("OnClick", function() currentTab = "Instances"; UpdateList() end)

local tab3 = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
tab3:SetSize(85, 25)
tab3:SetPoint("LEFT", tab2, "RIGHT", 4, 0)
tab3:SetText("Objectives")
tab3:SetScript("OnClick", function() currentTab = "Custom"; UpdateList() end)

local tab4 = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
tab4:SetSize(55, 25)
tab4:SetPoint("LEFT", tab3, "RIGHT", 4, 0)
tab4:SetText("Notes")
tab4:SetScript("OnClick", function() currentTab = "Notes"; UpdateList() end)

local tab5 = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
tab5:SetSize(65, 25)
tab5:SetPoint("LEFT", tab4, "RIGHT", 4, 0)
tab5:SetText("Settings")
tab5:SetScript("OnClick", function() currentTab = "Settings"; UpdateList() end)

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if arg1 == addonName then
        CompletionistDB.Zones = CompletionistDB.Zones or {}
        CompletionistDB.Instances = CompletionistDB.Instances or {}
        CompletionistDB.CustomList = CompletionistDB.CustomList or {}
        CompletionistDB.CustomStates = CompletionistDB.CustomStates or {}
        CompletionistDB.NotesText = CompletionistDB.NotesText or ""
        CompletionistDB.Minimap = CompletionistDB.Minimap or { minimapPos = 220 }
        CompletionistDB.Settings = CompletionistDB.Settings or {}
        
        local defSettings = {
            factionColors = false,
            factionFilter = false,
            showExpansion = true,
            combinedProg = false,
            hideMinimap = false,
            lockWindow = false,
            alpha = 0.85
        }
        for k, v in pairs(defSettings) do
            if CompletionistDB.Settings[k] == nil then
                CompletionistDB.Settings[k] = v
            end
        end

        UpdateMinimapButtonPosition()
        
        if CompletionistDB.Settings.hideMinimap then minimapButton:Hide() end
        f:SetBackdropColor(0.05, 0.05, 0.05, CompletionistDB.Settings.alpha)
        f:SetMovable(not CompletionistDB.Settings.lockWindow)
        
        UpdateList()
    end
end)
