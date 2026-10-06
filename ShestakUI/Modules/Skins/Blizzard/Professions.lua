local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Professions skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = ProfessionsFrame
	T.SkinFrame(frame)

	for _, tab in next, _G.ProfessionsFrame.rightProfessionTabs do
		T.SkinSideTabs(tab)
	end
	T.SkinSideTabs(ProfessionsFrame.ProfessionsOverviewTab)

	local function replaceHighlight(button)
		button.highlightTexture:SetColorTexture(1, 1, 1, 0.3)
		button.highlightTexture:SetPoint("TOPLEFT", button, 4, -4)
		button.highlightTexture:SetPoint("BOTTOMRIGHT", button, -4, 4)
	end

	local frames = {
		ProfessionsFrame.BookPage.ProfessionsContentFrame.PrimaryProfession1,
		ProfessionsFrame.BookPage.ProfessionsContentFrame.PrimaryProfession2,
		ProfessionsFrame.BookPage.ProfessionsContentFrame.SecondaryProfession1,
		ProfessionsFrame.BookPage.ProfessionsContentFrame.SecondaryProfession2,
		ProfessionsFrame.BookPage.ProfessionsContentFrame.SecondaryProfession3
	}

	for i = 1, #frames do
		local frame = frames[i]
		frame:CreateBackdrop("Overlay")
		frame.backdrop:SetInside(nil, 5, 5)
		frame.Background:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		frame.Background:SetInside(frame.backdrop, 1, 1)

		local bar = frame.StatusBar
		if bar then
			bar.Border:Hide()
			bar.Background:Hide()
			bar:CreateBackdrop("Overlay")
			bar.backdrop:SetOutside(bar.Fill)

			if bar.overrideWidth then
				bar.Fill:SetWidth(bar.overrideWidth)
			end
		end

		local unlearn = frame.UnlearnButton
		if unlearn then
			unlearn:SetMovePoint(6)
		end

		local spellButtons = frame.spellButtons
		if spellButtons then
			for _, button in next, spellButtons do
				button.IconTextureOverlay:SetAlpha(0)

				button:GetCheckedTexture():SetColorTexture(0, 1, 0, 0.3)
				button:GetCheckedTexture():SetPoint("TOPLEFT", button, 4, -4)
				button:GetCheckedTexture():SetPoint("BOTTOMRIGHT", button, -4, 4)

				button:GetPushedTexture():SetColorTexture(0, 1, 0, 0.3)
				button:GetPushedTexture():SetPoint("TOPLEFT", button, 4, -4)
				button:GetPushedTexture():SetPoint("BOTTOMRIGHT", button, -4, 4)

				button.cooldown:SetPoint("TOPLEFT", button, 4, -4)
				button.cooldown:SetPoint("BOTTOMRIGHT", button, -4, 4)

				local icon = button.IconTexture
				if icon then
					icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					icon:ClearAllPoints()
					icon:SetPoint("TOPLEFT", 4, -4)
					icon:SetPoint("BOTTOMRIGHT", -4, 4)

					hooksecurefunc(button, "UpdateButton", replaceHighlight)

					if not button.backdrop then
						button:CreateBackdrop("Default")
						button.backdrop:SetPoint("TOPLEFT", 2, -2)
						button.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
					end
				end
			end
		end
	end

	ProfessionsFrame.CraftingPage:StripTextures()

	T.SkinEditBox(frame.CraftingPage.RecipeList.SearchBox, nil, 16)

	T.SkinFilter(frame.CraftingPage.RecipeList.FilterDropdown)
	frame.CraftingPage.RecipeList.FilterDropdown:SetHeight(20)
	frame.CraftingPage.RecipeList.FilterDropdown:SetPoint("TOPRIGHT", ProfessionsFrame.CraftingPage.RecipeList, "TOPRIGHT", -8, -6)

	frame.CraftingPage.ConcentrationDisplay.Icon:SkinIcon()

	local RankBar = frame.CraftingPage.RankBar
	RankBar.Border:Hide()
	RankBar.Background:Hide()
	RankBar:CreateBackdrop("Overlay")
	RankBar.backdrop:SetOutside(RankBar.Fill)

	if RankBar.ExpansionDropdownButton then
		local arrow = RankBar.ExpansionDropdownButton:CreateTexture(nil, "ARTWORK")
		arrow:SetSize(14, 15)
		arrow:SetPoint("CENTER")
		arrow:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
		arrow:SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)

		RankBar.ExpansionDropdownButton:SetSize(18, 18)
		RankBar.ExpansionDropdownButton:SetPoint("RIGHT", RankBar, "RIGHT", -7, -3)
		RankBar.ExpansionDropdownButton:SkinButton()
		RankBar.ExpansionDropdownButton.Texture:Hide()
	end

	local LinkButton = frame.CraftingPage.LinkButton
	LinkButton:CreateBackdrop("Overlay")
	LinkButton:SetSize(17, 14)
	LinkButton:SetPoint("LEFT", ProfessionsFrame.CraftingPage.RankBar, "RIGHT", 1, -3)

	hooksecurefunc(_G.ProfessionsFrame.CraftingPage.RecipeList.ScrollBox, "Update", function(frame)
		for _, child in next, {frame.ScrollTarget:GetChildren()} do
			if child.CollapseButton and not child.isSkinned then
				child:StripTextures()
				child:CreateBackdrop("Overlay")
				child.backdrop:SetPoint("TOPLEFT", child, 6, 0)
				child.backdrop:SetPoint("BOTTOMRIGHT", child, -6, 4)
				child.isSkinned = true
			end
		end
	end)

	local RecipeList = frame.CraftingPage.RecipeList
	RecipeList:StripTextures()
	RecipeList.Background:SetAlpha(0)
	T.SkinScrollBar(RecipeList.ScrollBar)

	local SchematicForm = frame.CraftingPage.SchematicForm
	SchematicForm:StripTextures()
	SchematicForm:CreateBackdrop("Overlay")
	SchematicForm.backdrop:SetInside(nil, 5, 5)

	SchematicForm.backdrop:SetPoint("TOPLEFT", 3, -6)
	SchematicForm.backdrop:SetPoint("BOTTOMRIGHT", -3, 5)

	SchematicForm.Background:SetInside(SchematicForm.backdrop, 1, 1)
	SchematicForm.MinimalBackground:SetAlpha(0)

	T.SkinCheckBox(SchematicForm.TrackRecipeCheckbox, 24)
	T.SkinCheckBox(SchematicForm.AllocateBestQualityCheckbox, 24)

	local ConcentrateToggleButton = SchematicForm.Details.CraftingChoicesContainer.ConcentrateContainer.ConcentrateToggleButton
	ConcentrateToggleButton:CreateBackdrop()
	ConcentrateToggleButton.backdrop:SetAllPoints()
	ConcentrateToggleButton.Icon:CropIcon()
	ConcentrateToggleButton:StyleButton()
	ConcentrateToggleButton.NormalTexture:SetAlpha(0)

	local function skinDetails(frame)
		frame:SetFrameLevel(frame:GetFrameLevel() + 1)
		frame:StripTextures()
		frame.backdrop = CreateFrame("Frame", nil, frame)
		frame.backdrop:SetFrameLevel(frame:GetFrameLevel() - 1)
		frame.backdrop:SetTemplate("Overlay")
		frame.backdrop:SetBackdropColor(C.media.backdrop_color[1], C.media.backdrop_color[2], C.media.backdrop_color[3], C.media.backdrop_alpha)
		frame.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 0.5)
		frame.backdrop:SetPoint("TOPLEFT", -2, -15)
		frame.backdrop:SetPoint("BOTTOMRIGHT", 2, 15)
	end

	skinDetails(SchematicForm.Details)

	local OutputIcon = SchematicForm.OutputIcon
	if OutputIcon then
		OutputIcon.Icon:SkinIcon()
		T.SkinIconBorder(OutputIcon.IconBorder, OutputIcon.Icon:GetParent().backdrop)
		OutputIcon:GetHighlightTexture():Hide()
		OutputIcon.CircleMask:Hide()
		if OutputIcon.CountShadow then OutputIcon.CountShadow:SetAlpha(0) end
	end

	local qualityDialog = SchematicForm.QualityDialog
	qualityDialog:StripTextures()
	qualityDialog:SetTemplate("Transparent")
	T.SkinCloseButton(qualityDialog.ClosePanelButton)
	qualityDialog.AcceptButton:SkinButton()
	qualityDialog.CancelButton:SkinButton()

	local function ReskinQualityContainer(container)
		local button = container.Button
		button:StripTextures()
		button:SetNormalTexture(0)
		button:SetPushedTexture(0)
		button:GetHighlightTexture():Hide()
		button.Icon:SkinIcon()
		T.SkinIconBorder(button.IconBorder, button.Icon:GetParent().backdrop)

		local box = container.EditBox
		box:DisableDrawLayer("BACKGROUND")
		T.SkinEditBox(box, nil, 18)
		T.SkinNextPrevButton(box.DecrementButton, true)
		T.SkinNextPrevButton(box.IncrementButton)
		box.DecrementButton:SetSize(22, 22)
		box.IncrementButton:SetSize(22, 22)
		box.IncrementButton:SetPoint("LEFT", box, "RIGHT", 6, 0)
	end

	ReskinQualityContainer(qualityDialog.Container1)
	ReskinQualityContainer(qualityDialog.Container2)
	ReskinQualityContainer(qualityDialog.Container3)

	local function skinReagentIcon(button)
		if button and not button.styled then
			button.Icon:SkinIcon()
			button:SetNormalTexture(0)
			button:SetPushedTexture(0)
			button:GetHighlightTexture():Hide()
			T.SkinIconBorder(button.IconBorder, button.Icon:GetParent().backdrop)
			if button.SlotBackground then
				button.SlotBackground:Hide()
			end
			button.styled = true
		end

		if button then
			button:SetNormalTexture(0)
			button:SetPushedTexture(0)
			button:GetHighlightTexture():Hide()
		end
	end

	hooksecurefunc(SchematicForm, "Init", function(frame)
		for slot in frame.reagentSlotPool:EnumerateActive() do
			skinReagentIcon(slot.Button)
		end

		local slot = SchematicForm.salvageSlot
		if slot then
			skinReagentIcon(slot.Button)
		end

		local slot = SchematicForm.enchantSlot
		if slot then
			skinReagentIcon(slot.Button)
		end
	end)

	hooksecurefunc("OpenProfessionsItemFlyout", T.SkinProfessionsFlyout)

	frame.CraftingPage.CreateAllButton:SkinButton()
	frame.CraftingPage.CreateButton:SkinButton()
	T.SkinEditBox(ProfessionsFrame.CraftingPage.CreateMultipleInputBox, nil, 18)
	T.SkinNextPrevButton(ProfessionsFrame.CraftingPage.CreateMultipleInputBox.DecrementButton, true)
	T.SkinNextPrevButton(ProfessionsFrame.CraftingPage.CreateMultipleInputBox.IncrementButton)
	ProfessionsFrame.CraftingPage.CreateMultipleInputBox.IncrementButton:SetPoint("LEFT", ProfessionsFrame.CraftingPage.CreateMultipleInputBox, "RIGHT", 5, 0)
	ProfessionsFrame.CraftingPage.CreateMultipleInputBox.IncrementButton:SetSize(22, 22)
	ProfessionsFrame.CraftingPage.CreateMultipleInputBox.DecrementButton:SetSize(22, 22)
end

T.SkinFuncs["Blizzard_Professions"] = LoadSkin