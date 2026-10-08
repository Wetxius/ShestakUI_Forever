local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Character skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = CharacterFrame
	T.SkinFrame(frame)

	for _, tab in next, _G.CharacterFrame.ModeTabs.Tabs do
		T.SkinSideTabs(tab)
	end

	CharacterFrameLeftPaneHost:SetAlpha(0)
	CharacterFrameRightPaneHost:SetAlpha(0)

	local charframe = {
		CharacterFrameInsetRight,
		PaperDollSidebarTabs
	}

	for i = 1, #charframe do
		local button = charframe[i]
		if button then
			button:StripTextures()
		end
	end

	T.SkinModelControl(CharacterModelScene)

	EquipmentFlyoutFrameHighlight:Kill()
	EquipmentFlyoutFrame.NavigationFrame:StripTextures()
	EquipmentFlyoutFrame.NavigationFrame.BottomBackground:Hide()
	EquipmentFlyoutFrame.NavigationFrame:SetTemplate("Transparent")
	EquipmentFlyoutFrame.NavigationFrame:SetPoint("TOPLEFT", EquipmentFlyoutFrameButtons, "BOTTOMLEFT", 3, -1)
	EquipmentFlyoutFrame.NavigationFrame:SetPoint("TOPRIGHT", EquipmentFlyoutFrameButtons, "BOTTOMRIGHT", 0, -1)
	T.SkinNextPrevButton(EquipmentFlyoutFrame.NavigationFrame.PrevButton)
	T.SkinNextPrevButton(EquipmentFlyoutFrame.NavigationFrame.NextButton)

	local function SkinItemFlyouts()
		EquipmentFlyoutFrameButtons:StripTextures()

		for i = 1, 23 do
			local button = _G["EquipmentFlyoutFrameButton"..i]
			local icon = _G["EquipmentFlyoutFrameButton"..i.."IconTexture"]
			if button then
				button:StyleButton()
				button.IconBorder:Hide()

				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:GetNormalTexture():SetTexture(nil)

				icon:ClearAllPoints()
				icon:SetPoint("TOPLEFT", 2, -2)
				icon:SetPoint("BOTTOMRIGHT", -2, 2)
				button:SetFrameStrata("DIALOG")
				if not button.backdrop then
					button:CreateBackdrop("Default")
					button.backdrop:SetAllPoints()
				end
			end
		end
	end

	-- Swap item flyout frame (shown when holding alt over a slot)
	EquipmentFlyoutFrame:HookScript("OnShow", SkinItemFlyouts)
	hooksecurefunc("EquipmentFlyout_Show", SkinItemFlyouts)

	-- Icon in upper right corner of character frame
	CharacterModelScene.BackgroundOverlay:SetColorTexture(0.01, 0.01, 0.01, 0.5)
	CharacterModelScene:CreateBackdrop("Default")
	CharacterModelScene:SetPoint("TOPLEFT", CharacterFrame.LeftPaneHost, 70, -62)
	CharacterModelScene:SetPoint("BOTTOMRIGHT", CharacterFrame.LeftPaneHost, -66, 72)

	CharacterModelScene.BackgroundOverlay:SetInside(CharacterModelScene.backdrop)

	-- Unit Background Texture
	local BackgroundTopLeft, BackgroundTopRight, BackgroundBotLeft, BackgroundBotRight = CharacterModelScene.BackgroundTopLeft, CharacterModelScene.BackgroundTopRight, CharacterModelScene.BackgroundBotLeft, CharacterModelScene.BackgroundBotRight
	BackgroundTopLeft:SetPoint("BOTTOMRIGHT", CharacterModelScene, "BOTTOMRIGHT", -25, 54)
	BackgroundTopRight:SetWidth(25)
	BackgroundTopRight:SetPoint("BOTTOMRIGHT", CharacterModelScene, "BOTTOMRIGHT", 0, 54)
	BackgroundBotLeft:SetHeight(54)
	BackgroundBotLeft:SetPoint("BOTTOMRIGHT", CharacterModelScene, "BOTTOMRIGHT", -25, 0)
	BackgroundBotRight:SetSize(25, 54)

	for _, slot in next, { _G.PaperDollItemsFrame:GetChildren() } do
		if slot:IsObjectType("Button") or slot:IsObjectType("ItemButton") then
			slot:StripTextures()
			slot:SetTemplate("Default")
			slot:StyleButton()

			slot.icon:CropIcon()

			slot.SetHighlightTexture = T.dummy
			slot:GetHighlightTexture().SetAllPoints = T.dummy

			T.SkinIconBorder(slot.IconBorder, slot)

			if slot.ignoreTexture then
				slot.ignoreTexture:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-LeaveItem-Transparent]])
			end
		end
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)