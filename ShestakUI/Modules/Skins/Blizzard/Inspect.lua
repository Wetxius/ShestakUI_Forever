local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	InspectUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	InspectFrame:StripTextures(true)
	InspectFrameInset:StripTextures(true)
	InspectFrame:CreateBackdrop("Transparent")
	InspectFrame.backdrop:SetAllPoints()
	T.SkinCloseButton(InspectFrameCloseButton)
	InspectPaperDollFrame.ViewButton:SkinButton()
	InspectFramePortrait:SetAlpha(0)

	for _, tab in next, InspectFrame.ModeTabs.Tabs do
		T.SkinSideTabs(tab)
	end

	InspectModelFrame:StripTextures()
	InspectModelFrame:CreateBackdrop("Default")
	InspectModelFrame.backdrop:SetPoint("TOPLEFT", -3, 4)
	InspectModelFrame.backdrop:SetPoint("BOTTOMRIGHT", 4, 0)
	InspectModelFrame.BackgroundOverlay:SetColorTexture(0.01, 0.01, 0.01, 0.5)

	InspectModelFrameControlFrame:StripTextures()

	-- Unit Background Texture
	InspectModelFrameBackgroundTopLeft:SetPoint("TOPLEFT", InspectModelFrame.backdrop, "TOPLEFT", 2, -2)
	InspectModelFrameBackgroundTopRight:SetPoint("TOPRIGHT", InspectModelFrame.backdrop, "TOPRIGHT", -2, -2)
	InspectModelFrameBackgroundBotLeft:SetPoint("BOTTOMLEFT", InspectModelFrame.backdrop, "BOTTOMLEFT", 2, -50)
	InspectModelFrameBackgroundBotRight:SetPoint("BOTTOMRIGHT", InspectModelFrame.backdrop, "BOTTOMRIGHT", -2, -50)

	local slots = {
		"HeadSlot",
		"NeckSlot",
		"ShoulderSlot",
		"BackSlot",
		"ChestSlot",
		"ShirtSlot",
		"TabardSlot",
		"WristSlot",
		"HandsSlot",
		"WaistSlot",
		"LegsSlot",
		"FeetSlot",
		"Finger0Slot",
		"Finger1Slot",
		"Trinket0Slot",
		"Trinket1Slot",
		"MainHandSlot",
		"SecondaryHandSlot",
		"RangedSlot"
	}

	for _, slot in pairs(slots) do
		local icon = _G["Inspect"..slot.."IconTexture"]
		local slot = _G["Inspect"..slot]

		-- slot:StripTextures()
		slot:StyleButton()
		slot:SetNormalTexture(0)
		if slot.BorderFrame then slot.BorderFrame:SetAlpha(0) end

		icon:CropIcon()

		slot:SetFrameLevel(slot:GetFrameLevel() + 2)
		slot:CreateBackdrop("Default")
		slot.backdrop:SetAllPoints()

		hooksecurefunc(slot.IconBorder, "SetVertexColor", function(self)
			self:SetTexture("")
		end)
	end

	-- Presige texture
	local portrait = InspectPVPFrame:CreateTexture(nil, "OVERLAY")
	portrait:SetSize(55, 55)
	portrait:SetPoint("CENTER", InspectPVPFrame.PortraitBackground, "CENTER", 0, 0)

	InspectGuildFrameBG:Kill()
end

T.SkinFuncs["Blizzard_InspectUI"] = LoadSkin