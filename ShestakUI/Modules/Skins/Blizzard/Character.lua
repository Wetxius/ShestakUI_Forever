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

	for i = 1, 4 do
		local tab = _G["PaperDollSidebarTab"..i]
		for _, region in next, { tab:GetRegions() } do
			if region ~= tab.Icon and region:IsObjectType("Texture") then
				region:SetTexture()
			end
		end

		tab.Icon:SetSize(32, 32)
		tab:CreateBackdrop("Overlay")
		tab.backdrop:SetOutside(tab.Icon)
		tab:StyleButton(5, 5)
		tab.checked:SetColorTexture(1, 0.82, 0, 0.3)
	end

	CharacterFrameLeftPaneHost:SetAlpha(0)
	CharacterFrameRightPaneHost:SetAlpha(0)

	local charframe = {
		CharacterFrameInsetRight,
		PaperDollSidebarTabs,
		PaperDollFrame.EquipmentManagerPane,
		PaperDollFrame.TopBackgroundStripHost,
		CharacterStatsPaneScrollBox
	}

	for i = 1, #charframe do
		local button = charframe[i]
		if button then
			button:StripTextures()
		end
	end

	local scrollbars = {
		CharacterStatsPaneScrollBox.ScrollBar,
		PaperDollFrame.EquipmentManagerPane.ScrollBar,
		ReputationFrame.ScrollBar,
		SkillsFrame.ScrollBar,
		SkillsFrame.SkillDetailFrame.DescriptionScrollBar,
		TokenFrame.ScrollBar,
		StatisticsFrame.ScrollBar
	}

	for i = 1, #scrollbars do
		local scrollbar = scrollbars[i]
		if scrollbar then
			T.SkinScrollBar(scrollbar, true)
		end
	end

	local checkboxes = {
		ReputationFrame.ReputationDetailFrame.AtWarCheckbox,
		ReputationFrame.ReputationDetailFrame.MakeInactiveCheckbox,
		ReputationFrame.ReputationDetailFrame.WatchFactionCheckbox,
		TokenDetailFrame.InactiveCheckbox,
		TokenDetailFrame.BackpackCheckbox
	}

	for i = 1, #checkboxes do
		local checkbox = checkboxes[i]
		if checkbox then
			T.SkinCheckBox(checkbox)
		end
	end

	PaperDollFrameEquipSet:SkinButton()
	PaperDollFrameSaveSet:SkinButton()
	PaperDollFrameNewSet:SkinButton()

	T.SkinIconSelectionFrame(GearManagerPopupFrame)

	local function updateToggleCollapse(button)
		if button:GetHeader():IsCollapsed() then
			button.bg.plus:Show()
		else
			button.bg.plus:Hide()
		end
	end

	local frames = {
		ReputationFrame,
		TokenFrame,
		SkillsFrame,
		StatisticsFrame
	}

	for i = 1, #frames do
		local scrollBox = frames[i].ScrollBox
		for _, child in next, { scrollBox:GetChildren() } do
			child:StripTextures()
		end
		hooksecurefunc(scrollBox, "Update", function(frame)
			for _, child in next, {frame.ScrollTarget:GetChildren()} do
				if child and not child.isSkinned then
					if child.StateIcon then
						child:DisableDrawLayer("BACKGROUND")
						child:CreateBackdrop("Overlay")
						child.backdrop:SetPoint("TOPLEFT", child, 3, -2)
						child.backdrop:SetPoint("BOTTOMRIGHT", child, -1, 2)
					end

					local bar = child.Content and (child.Content.ReputationBar or child.Content.SkillsBar)
					if bar then
						bar:DisableDrawLayer("BACKGROUND")
						-- if not bar.backdrop then
							-- bar:CreateBackdrop("Overlay")
							-- bar.backdrop:SetInside(nil, 4, 6) -- weird scale
						-- end
					end

					if child.ToggleCollapseButton then
						child.ToggleCollapseButton:GetNormalTexture():SetAlpha(0)
						child.ToggleCollapseButton:GetPushedTexture():SetAlpha(0)
						T.SkinExpandOrCollapse(child.ToggleCollapseButton)
						updateToggleCollapse(child.ToggleCollapseButton)
						hooksecurefunc(child.ToggleCollapseButton, "RefreshIcon", updateToggleCollapse)
					end

					child.isSkinned = true
				end
			end
		end)
	end

	for _, bar in next, {ReputationFrame.ReputationDetailFrame.StandingBar, SkillsFrame.SkillDetailFrame.RankBar} do
		bar:DisableDrawLayer("BACKGROUND")
		bar:CreateBackdrop("Overlay")
		bar.backdrop:SetInside(nil, 4, 6)
	end

	-- EquipmentFlyout
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

	-- CharacterModelScene
	CharacterModelScene.BackgroundOverlay:SetColorTexture(0.01, 0.01, 0.01, 0.5)
	CharacterModelScene:CreateBackdrop("Default")
	CharacterModelScene:ClearAllPoints()
	CharacterModelScene:SetPoint("TOPLEFT", CharacterFrame.LeftPaneHost, 70, -42)
	CharacterModelScene:SetPoint("BOTTOMRIGHT", CharacterFrame.LeftPaneHost, -66, 62)

	CharacterModelScene.BackgroundOverlay:SetInside(CharacterModelScene.backdrop)

	T.SkinNextPrevButton(CharacterFrameRightPaneToggleButton)
	T.SkinModelControl(CharacterModelScene)

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

	-- Equipement Manager
	hooksecurefunc(_G.PaperDollFrame.EquipmentManagerPane.ScrollBox, "Update", function(frame)
		for _, child in next, {frame.ScrollTarget:GetChildren()} do
			if child.icon and not child.isSkinned then
				for _, region in next, { child:GetRegions() } do -- the card background and the icon frame are unnamed
					local atlas = region:IsObjectType("Texture") and region:GetAtlas()
					if atlas == "UI-Character-Info-OutfitCard" or atlas == "UI-Character-Info-OutfitIcon-Frame" then
						region:SetTexture()
					end
				end

				child.FrameBackdrop = CreateFrame("Frame", nil, frame)
				child.FrameBackdrop:SetFrameLevel(frame:GetFrameLevel() - 1)
				child.FrameBackdrop:SetPoint("TOPLEFT", child.icon, "TOPRIGHT", 5, 2)
				child.FrameBackdrop:SetPoint("BOTTOMRIGHT", child, -7, 2)
				child.FrameBackdrop:SetTemplate("Overlay")

				child.icon:SkinIcon()

				for _, bar in next, {child.HighlightBar, child.SelectedBar} do
					bar:SetInside(child.FrameBackdrop)
				end

				child.HighlightBar:SetColorTexture(1, 1, 1, 0.3)
				child.HighlightBar:SetDrawLayer("BACKGROUND")
				child.SelectedBar:SetColorTexture(1, 0.82, 0, 0.3)
				child.SelectedBar:SetDrawLayer("BACKGROUND")

				-- Making all icons the same size and position because otherwise BlizzardUI tries to attach itself to itself when it refreshes
				child.icon:SetPoint("LEFT", child, "LEFT", 4, 0)
				child.icon.SetPoint = T.dummy
				child.icon:SetSize(36, 36)
				child.icon.SetSize = T.dummy

				child.isSkinned = true
			end
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)