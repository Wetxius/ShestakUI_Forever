local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Collections skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	T.SkinFrame(CollectionsJournal, true)
	CollectionsJournal.backdrop:SetPoint("BOTTOMRIGHT", 1, 0)

	for _, tab in next, _G.CollectionsJournal.TabContainer.Tabs do
		T.SkinSideTabs(tab)
	end

	local filterButtons = {
		WardrobeCollectionFrame.FilterButton
	}

	for i = 1, #filterButtons do
		T.SkinFilter(filterButtons[i], true)
	end

	-- Wardrobe
	WardrobeCollectionFrame.ItemsCollectionFrame:StripTextures()
	T.SkinDropDownBox(WardrobeCollectionFrame.ClassDropdown)

	WardrobeCollectionFrame.progressBar:StripTextures()
	WardrobeCollectionFrame.progressBar:CreateBackdrop("Overlay")
	WardrobeCollectionFrame.progressBar:SetStatusBarTexture(C.media.texture)
	WardrobeCollectionFrame.progressBar:SetFrameLevel(WardrobeCollectionFrame.progressBar:GetFrameLevel() + 2)
	T.SkinEditBox(WardrobeCollectionFrameSearchBox, nil, 18)
	WardrobeCollectionFrameSearchBox:SetFrameLevel(WardrobeCollectionFrameSearchBox:GetFrameLevel() + 2)
	T.SkinDropDownBox(WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame.VariantSetsDropdown)
	T.SkinDropDownBox(WardrobeCollectionFrame.ItemsCollectionFrame.WeaponDropdown)
	T.SkinNextPrevButton(WardrobeCollectionFrame.ItemsCollectionFrame.PagingFrame.PrevPageButton)
	T.SkinNextPrevButton(WardrobeCollectionFrame.ItemsCollectionFrame.PagingFrame.NextPageButton)

	WardrobeCollectionFrame.SetsCollectionFrame.LeftInset:StripTextures()
	WardrobeCollectionFrame.SetsCollectionFrame.RightInset:StripTextures()
	WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame:StripTextures()
	WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame:CreateBackdrop("Overlay")
	WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame.backdrop:SetPoint("TOPLEFT", 4, -4)
	WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame.backdrop:SetPoint("BOTTOMRIGHT", 1, 4)
	T.SkinScrollBar(WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar)

	local function SetItemQuality(_, itemFrame)
		if (itemFrame.backdrop) then
			local _, _, quality = C_Item.GetItemInfo(itemFrame.itemID);
			local alpha = 1
			if (not itemFrame.collected) then
				alpha = 0.4
			end

			if (not quality or quality < 2) then -- Not collected or item is white or grey
				itemFrame.backdrop:SetBackdropBorderColor(0, 0, 0)
			else
				itemFrame.backdrop:SetBackdropBorderColor(ITEM_QUALITY_COLORS[quality].r, ITEM_QUALITY_COLORS[quality].g, ITEM_QUALITY_COLORS[quality].b, alpha)
			end
		end
	end
	hooksecurefunc(WardrobeCollectionFrame.SetsCollectionFrame, "SetItemFrameQuality", SetItemQuality)


	for i = 1, 2 do
		T.SkinTab(_G["WardrobeCollectionFrameTab"..i], true)
	end

	hooksecurefunc(WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBox, "Update", function(frame)
		for _, button in next, {frame.ScrollTarget:GetChildren()} do
			if not button.isSkinned then
				button:GetRegions():Hide()
				button:CreateBackdrop("Overlay")
				button.backdrop:SetPoint("TOPLEFT", 2, -2)
				button.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
				button:StyleButton(nil, 4)

				button.HighlightTexture:SetTexture(nil)
				button.SelectedTexture:SetTexture(nil)

				button.IconFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				button.border = CreateFrame("Frame", nil, button)
				button.border:CreateBackdrop("Default")
				button.border.backdrop:SetPoint("TOPLEFT", button.IconFrame.Icon, -2, 2)
				button.border.backdrop:SetPoint("BOTTOMRIGHT", button.IconFrame.Icon, 2, -2)

				button.ProgressBar:SetPoint("TOPLEFT", button.backdrop, "BOTTOMLEFT", 2, 4)

				button.isSkinned = true
			end
		end
	end)

	local function ColorSelectedSet(button)
		if not button or not button.backdrop then return end
		if button.SelectedTexture:IsShown() then
			button.backdrop:SetBackdropBorderColor(1, 1, 0)
			button.border.backdrop:SetBackdropBorderColor(1, 1, 0)
		else
			button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			button.border.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
		end
	end
	hooksecurefunc(WardrobeSetsScrollFrameButtonMixin, "SetSelected", ColorSelectedSet)

	hooksecurefunc(WardrobeCollectionFrame.SetsCollectionFrame, "DisplaySet", function()
		for _, child in ipairs({WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame:GetChildren()}) do
			if child.Icon and not child.isSkinned then
				child.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				child:CreateBackdrop("Default")
				child.backdrop:SetPoint("TOPLEFT", child.Icon, -2, 2)
				child.backdrop:SetPoint("BOTTOMRIGHT", child.Icon, 2, -2)

				child.isSkinned = true
			end
		end
	end)

	local function SkinModels(model)
		model.Border:SetAlpha(0)
		model.TransmogStateTexture:SetAlpha(0)
		local bg = CreateFrame("Frame", nil, model)
		bg:CreateBackdrop("Overlay")
		bg.backdrop:SetPoint("TOPLEFT", model, "TOPLEFT", -2, 2)
		bg.backdrop:SetPoint("BOTTOMRIGHT", model, "BOTTOMRIGHT", 3, -2)
		for _, region in next, {model:GetRegions()} do
			if region:IsObjectType("Texture") then -- check for hover glow
				local texture, regionName = region:GetTexture(), region:GetDebugName()
				if texture == 1569530 or (texture == 1116940 and not strfind(regionName, "SlotInvalidTexture") and not strfind(regionName, "DisabledOverlay")) then
					region:SetColorTexture(1, 1, 1, 0.2)
					region:SetBlendMode("ADD")
					region:SetInside(bg.backdrop)
				end
			end
		end
		hooksecurefunc(model.Border, "SetAtlas", function(_, texture)
			local color
			if texture == "transmog-wardrobe-border-uncollected" then
				color = {0.3, 0.3, 1}
			elseif texture == "transmog-wardrobe-border-unusable" then
				color = {0.8, 0, 0}
			elseif model.TransmogStateTexture:IsShown() then
				color = {1, 0.7, 1}
			else
				color = C.media.border_color
			end
			bg.backdrop:SetBackdropBorderColor(unpack(color))
		end)
	end

	for i = 1, #WardrobeCollectionFrame.ItemsCollectionFrame.Models do
		local model = WardrobeCollectionFrame.ItemsCollectionFrame.Models[i]
		SkinModels(model)
	end

	local function SkinSetItemButtons(self)
		for itemFrame in self.DetailsFrame.itemFramesPool:EnumerateActive() do
			itemFrame.IconBorder:SetAlpha(0)
			SetItemQuality(self, itemFrame)
		end
	end
	hooksecurefunc(WardrobeCollectionFrame.SetsCollectionFrame, "DisplaySet", SkinSetItemButtons)

	WardrobeCollectionFrame.InfoButton.Ring:Hide()
	WardrobeCollectionFrame.InfoButton:SetPoint("TOPLEFT", WardrobeCollectionFrame, "TOPLEFT", -10, 12)

	-- Scene
	local Frame = _G.WarbandSceneJournal

	local IconsFrame = Frame.IconsFrame
	if IconsFrame then
		IconsFrame:StripTextures()

		local controls = IconsFrame.Icons and IconsFrame.Icons.Controls
		if controls then
			local checkBox = controls and controls.ShowOwned and controls.ShowOwned.Checkbox
			if checkBox then
				T.SkinCheckBox(checkBox, 28)
			end

			if controls.PagingControls then
				T.SkinNextPrevButton(controls.PagingControls.PrevPageButton)
				T.SkinNextPrevButton(controls.PagingControls.NextPageButton)
			end
		end
	end

	hooksecurefunc(WarbandSceneEntryMixin, "UpdateWarbandSceneData", function(self)
		if self.warbandSceneInfo and not self.ArtBackdrop then
			self.ArtBackdrop = CreateFrame("Frame", nil, self)
			self.ArtBackdrop:SetFrameLevel(self:GetFrameLevel() - 1)
			self.ArtBackdrop:SetOutside(self.Icon)
			self.ArtBackdrop:SetTemplate("Default")
			self.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			self.Border:SetAlpha(0)
			self.NameBackground:SetAlpha(0)
			if self.SetHighlightTexture then
				local highlight = self:CreateTexture()
				highlight:SetColorTexture(1, 1, 1, 0.3)
				highlight:SetAllPoints(self.Icon)
				self:SetHighlightTexture(highlight)
			end
		end
	end)

	-- Help box
	local HelpBox = {
		ToyBox.favoriteHelpBox,
		WardrobeCollectionFrame.ItemsCollectionFrame.HelpBox,
		WardrobeCollectionFrame.SetsTabHelpBox
	}

	for i = 1, #HelpBox do
		local frame = HelpBox[i]
		T.SkinHelpBox(frame)
	end
end

T.SkinFuncs["Blizzard_Collections"] = LoadSkin