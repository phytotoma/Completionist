CompletionistDB = CompletionistDB or { Zones = {}, Instances = {}, CustomList = {}, CustomStates = {}, NotesText = "", Minimap = { minimapPos = 220 } }

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
    {n="Hellfire Ramparts", l="59-62"}, {n="The Blood Furnace", l="60-63"}, {n="The Slave Pens", l="61-64"},
    {n="The Underbog", l="62-65"}, {n="Mana-Tombs", l="64-66"}, {n="Auchenai Crypts", l="65-67"},
    {n="The Escape from Durnholde", l="66-68"}, {n="Sethekk Halls", l="67-69"}, {n="Shadow Labyrinth", l="68-70"},
    {n="The Shattered Halls", l="68-70"}, {n="The Botanica", l="68-70"}, {n="The Mechanar", l="68-70"},
    {n="The Arcatraz", l="68-70"}, {n="Opening of the Dark Portal", l="69-70"}, {n="Magisters' Terrace", l="70"},
    {n="Utgarde Keep", l="68-72"}, {n="The Nexus", l="69-73"}, {n="Azjol-Nerub", l="71-74"},
    {n="Ahn'kahet: The Old Kingdom", l="73-75"}, {n="Drak'Tharon Keep", l="73-76"}, {n="The Violet Hold", l="75-77"},
    {n="Gundrak", l="76-78"}, {n="Halls of Stone", l="77-79"}, {n="Halls of Lightning", l="79-80"},
    {n="The Oculus", l="79-80"}, {n="Culling of Stratholme", l="79-80"}, {n="Utgarde Pinnacle", l="79-80"},
    {n="Trial of the Champion", l="80"}, {n="The Forge of Souls", l="80"}, {n="Pit of Saron", l="80"},
    {n="Halls of Reflection", l="80"},
    {n="Molten Core", info="40-man raid"}, {n="Onyxia's Lair", info="40-man raid"},
    {n="Azuregos", info="world boss"}, {n="Lord Kazzak", info="world boss"},
    {n="Blackwing Lair", info="40-man raid"}, {n="Zul'Gurub", info="20-man raid"},
    {n="Dragons of Nightmare", info="world boss"}, {n="Ruins of Ahn'Qiraj", info="20-man raid"},
    {n="Temple of Ahn'Qiraj", info="40-man raid"}, {n="Naxxramas", info="40-man raid"},
    {n="Doom Lord Kazzak", info="TBC world boss"}, {n="Doomwalker", info="TBC world boss"},
    {n="Karazhan", info="TBC raid"}, {n="Gruul's Lair", info="TBC raid"}, {n="Magtheridon's Lair", info="TBC raid"},
    {n="Serpentshrine Cavern", info="TBC raid"}, {n="The Eye", info="TBC raid"}, {n="Battle for Mount Hyjal", info="TBC raid"},
    {n="Black Temple", info="TBC raid"}, {n="Zul'Aman", info="TBC raid"}, {n="Sunwell Plateau", info="TBC raid"},
    {n="Vault of Archavon", info="WotLK raid"}, {n="Naxxramas (WotLK)", info="WotLK raid"}, 
    {n="The Obsidian Sanctum", info="WotLK raid"}, {n="The Eye of Eternity", info="WotLK raid"},
    {n="Ulduar", info="WotLK raid"}, {n="Trial of the Crusader", info="WotLK raid"},
    {n="Onyxia's Lair (WotLK)", info="WotLK raid"}, {n="Icecrown Citadel", info="WotLK raid"},
    {n="The Ruby Sanctum", info="WotLK raid"}
}

local currentTab = "Zones"
local buttons = {}

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
    for _, zone in ipairs(Zones) do
        if zone.l ~= lastLevel then
            lastLevel = zone.l
            table.insert(list, { isHeader = true, title = lastLevel .. " Bracket" })
        end
        table.insert(list, zone)
    end
    return list
end

local function GetGroupedInstances()
    local list = {}
    local addedDungeonsHeader = false
    local addedRaidsHeader = false
    for _, inst in ipairs(Instances) do
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

local UpdateList -- forward declaration

-- Setup the confirmation dialog popup
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
    -- Trigger the confirmation popup instead of instantly resetting
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

if minimapButton.CreateMaskTexture then
    local mask = minimapButton:CreateMaskTexture()
    mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask")
    mask:SetSize(20, 20)
    mask:SetPoint("TOPLEFT", 7, -6)
    icon:AddMaskTexture(mask)
end

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
    end
end)

minimapButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText("Completionist", 1, 0.82, 0)
    GameTooltip:AddLine("Left-click to toggle window.", 1, 1, 1)
    GameTooltip:AddLine("Drag to move button.", 0.7, 0.7, 0.7)
    GameTooltip:Show()
end)

minimapButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

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

minimapButton:SetScript("OnDragStop", function(self)
    self:SetScript("OnUpdate", nil)
end)
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

editBox:SetScript("OnEnterPressed", function()
    addBtn:GetScript("OnClick")(addBtn)
end)

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
notesBg:SetScript("OnMouseDown", function()
    CompletionistNotesEditBox:SetFocus()
end)
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
notesEditBox:SetScript("OnEscapePressed", function(self)
    self:ClearFocus()
end)
notesScroll:SetScrollChild(notesEditBox)

notesScroll:SetScript("OnMouseDown", function()
    notesEditBox:SetFocus()
end)

UpdateList = function()
    if currentTab == "Notes" then
        scrollFrame:Hide()
        editBox:Hide()
        addBtn:Hide()
        resetBtn:Hide()
        notesScroll:Show()
        notesBg:Show()
        pctText:Hide()
        notesEditBox:SetWidth(notesScroll:GetWidth() - 20)
        notesEditBox:SetText(CompletionistDB.NotesText or "")
        return
    else
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
                            if CompletionistDB.CustomStates then
                                CompletionistDB.CustomStates[name] = nil
                            end
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

            local name, info, level
            if currentTab == "Custom" then
                name = data
                info, level = nil, nil
            else
                name = data.n
                info = data.info
                level = data.l
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
            if state == 1 then
                btn.cb:SetChecked(true)
                btn.text:SetTextColor(0.9, 0.65, 0)
                completed = completed + 1
            elseif state == 2 then
                btn.cb:SetChecked(false)
                btn.text:SetTextColor(0.5, 0.5, 0.5)
                skipped = skipped + 1
            else
                btn.cb:SetChecked(false)
                btn.text:SetTextColor(1, 0.82, 0) 
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
    pctText:SetText(string.format("Completion: %.1f%%", pct))
end

local tab1 = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
tab1:SetSize(108, 25)
tab1:SetPoint("TOPLEFT", 15, -40)
tab1:SetText("Leveling zones")
tab1:SetScript("OnClick", function()
    currentTab = "Zones"
    UpdateList()
end)

local tab2 = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
tab2:SetSize(78, 25)
tab2:SetPoint("LEFT", tab1, "RIGHT", 4, 0)
tab2:SetText("Instances")
tab2:SetScript("OnClick", function()
    currentTab = "Instances"
    UpdateList()
end)

local tab3 = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
tab3:SetSize(118, 25)
tab3:SetPoint("LEFT", tab2, "RIGHT", 4, 0)
tab3:SetText("User objectives")
tab3:SetScript("OnClick", function()
    currentTab = "Custom"
    UpdateList()
end)

local tab4 = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
tab4:SetSize(64, 25)
tab4:SetPoint("LEFT", tab3, "RIGHT", 4, 0)
tab4:SetText("Notes")
tab4:SetScript("OnClick", function()
    currentTab = "Notes"
    UpdateList()
end)

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if arg1 == "Completionist" then
        CompletionistDB.Zones = CompletionistDB.Zones or {}
        CompletionistDB.Instances = CompletionistDB.Instances or {}
        CompletionistDB.CustomList = CompletionistDB.CustomList or {}
        CompletionistDB.CustomStates = CompletionistDB.CustomStates or {}
        CompletionistDB.NotesText = CompletionistDB.NotesText or ""
        -- Minimap Init
        CompletionistDB.Minimap = CompletionistDB.Minimap or { minimapPos = 220 }
        UpdateMinimapButtonPosition()
        
        UpdateList()
    end
end)