local T, C, L = unpack(ShestakUI)
if T.class ~= "MAGE" or T.level < 11 then return end

----------------------------------------------------------------------------------------
--	Mage portals menu(by Foof and Tohveli)
----------------------------------------------------------------------------------------
local spells = (UnitFactionGroup("player") == "Horde") and {
	[1] = {3567,11417},			-- Orgrimmar
	[2] = {3563,11418},			-- Undercity
	[3] = {3566,11420},			-- Thunder Bluff
} or { -- Alliance
	[1] = {3561,10059},			-- Stormwind
	[2] = {3562,11416},			-- Ironforge
	[3] = {3565,11419},			-- Darnassus
}

local frame = CreateFrame("Frame", "TeleportMenu", UIParent)
frame:CreatePanel("Invisible", C.minimap.size, (#spells) * 20 + 4, "BOTTOMLEFT", Minimap, "TOPLEFT", -2, 3)
frame:SetFrameStrata("MEDIUM")
frame:EnableMouse(true)
frame:RegisterEvent("UNIT_SPELLCAST_START")
frame:SetScript("OnEvent", function(self)
	if self:IsShown() then
		self:Hide()
	end
end)
frame:Hide()
tinsert(UISpecialFrames, "TeleportMenu")

for i, spell in pairs(spells) do
	local teleport = GetSpellInfo(spell[1])

	local b = CreateFrame("Button", nil, frame, "SecureActionButtonTemplate")
	b:CreatePanel("Transparent", C.minimap.size, 20, "BOTTOMLEFT", frame, "BOTTOMLEFT", 0, ((i - 1) * 21))
	b:SetBackdropBorderColor(unpack(C.media.classborder_color))
	b:SetFrameStrata("HIGH")

	local l = b:CreateFontString("TeleportMenuName"..i, "OVERLAY")
	l:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	l:SetText(string.sub(teleport, (string.find(teleport, ":") and string.find(teleport, ":") + 1) or 0))

	l:SetPoint("LEFT", b, "LEFT", 2, 0)
	l:SetPoint("RIGHT", b, "RIGHT", -2, 0)
	l:SetWordWrap(false)

	b:SetFontString(l)

	b:RegisterForClicks("AnyUp", "AnyDown")
	b:SetAttribute("type1", "spell")
	b:SetAttribute("spell1", teleport)
	b:SetAttribute("type2", "spell")
	b:SetAttribute("spell2", GetSpellInfo(spell[2]))
end

local learnSpell = CreateFrame("Frame")
learnSpell:RegisterEvent("PLAYER_LOGIN")
learnSpell:RegisterEvent("LEARNED_SPELL_IN_SKILL_LINE")
learnSpell:SetScript("OnEvent", function()
	for i, spell in pairs(spells) do
		if not C_SpellBook.IsSpellKnown(spell[1]) then
			_G["TeleportMenuName"..i]:SetTextColor(0.4, 0.4, 0.4)
		else
			_G["TeleportMenuName"..i]:SetTextColor(1, 1, 1)
		end
	end
end)

local button = CreateFrame("Button", nil, UIParent)
button:SetTemplate("ClassColor")
button:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
button:SetSize(20, 20)
button:SetAlpha(0)

button.t = button:CreateTexture(nil, "OVERLAY")
button.t:SetTexture("Interface\\Icons\\Spell_Arcane_TeleportStormwind")
button.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
button.t:SetPoint("TOPLEFT", button, 2, -2)
button.t:SetPoint("BOTTOMRIGHT", button, -2, 2)

button:SetScript("OnClick", function()
	if not InCombatLockdown() then
		if _G["TeleportMenu"]:IsShown() then
			_G["TeleportMenu"]:Hide()
		else
			_G["TeleportMenu"]:Show()
		end
		if C.minimap.toggle_menu and _G["TTMenuAddOnBackground"]:IsShown() then
			_G["TTMenuAddOnBackground"]:Hide()
		end
		if C.minimap.toggle_menu and _G["TTMenuBackground"]:IsShown() then
			_G["TTMenuBackground"]:Hide()
		end
	end
end)

button:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	button:FadeIn()
end)

button:SetScript("OnLeave", function()
	button:FadeOut()
end)
