local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	PvE skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	T.SkinFrame(LFGListingFrame)

	LFGParentFramePortrait:Kill()
	T.SkinCloseButton(LFGParentFrameCloseButton)

	T.SkinSideTabs(LFGParentFrame.ListingTab)
	T.SkinSideTabs(LFGParentFrame.BrowsingTab)
	T.SkinSideTabs(LFGParentFrame.WhoListingTab)

	LFGListingFrame.RolesSection:StripTextures()
	LFGListingFrame.DividerFrame:Hide()

	local buttons = {
		LFGListingFrame.BackButton,
		LFGListingFrame.PostButton,
		LFGListingFrame.GroupRoleButtons.RolePollButton,
		LFGBrowseFrame.SendMessageButton,
		LFGBrowseFrame.GroupInviteButton
	}

	for i = 1, #buttons do
		buttons[i]:SkinButton()
	end

	local checkButtons = {
		LFGListingFrameSoloRoleButtonsRoleButtonTank,
		LFGListingFrameSoloRoleButtonsRoleButtonHealer,
		LFGListingFrameSoloRoleButtonsRoleButtonDPS,
		LFGListingFrameNewPlayerFriendlyButton
	}

	for _, roleButton in pairs(checkButtons) do
		T.SkinCheckBox(roleButton.checkButton or roleButton.CheckButton)
	end

	T.SkinCheckBox(LFGListingFrameActivityView.LevelRangesCheckbox.Checkbox)

	T.SkinFrame(LFGBrowseFrame)
	T.SkinFrame(LFGWhoListFrame)

	local scrollbars = {
		LFGListingFrame.ActivityView.ScrollBar,
		LFGBrowseFrame.ScrollBar,
		LFGWhoListFrame.ScrollBar
	}

	for i = 1, #scrollbars do
		T.SkinScrollBar(scrollbars[i])
	end

	T.SkinDropDownBox(LFGListingFrameActivityView.PlayStyleDropdown)
	T.SkinDropDownBox(LFGListingFrameActivityViewVoiceChatDropdown)
	T.SkinDropDownBox(LFGBrowseFrameCategoryDropdown)
	T.SkinDropDownBox(LFGBrowseFrameActivityDropdown)

	LFGBrowseFrameRefreshButton:SkinButton()
	LFGBrowseFrameRefreshButton:SetSize(22, 22)
	LFGBrowseFrameRefreshButton.Icon:SetPoint("CENTER")

	T.SkinEditBox(LFGListingComment)
	T.SkinEditBox(WhoFrameEditBox)
	WhoFrameEditBox.backdrop:SetOutside(nil, 2, -4)

	LFGWhoListFrame.WhoSearch:SkinButton()
	LFGWhoListFrame.WhoSearch:SetSize(22, 22)
	LFGWhoListFrame.WhoSearch:SetMovePoint(4, 1)
	T.SkinFilter(LFGWhoListFrame.FilterDropdown)

	-- for i = 1, 4 do
		-- local button = GroupFinderFrame["groupButton"..i]

		-- if button then
			-- button.ring:Hide()
			-- button.CircleMask:Hide()
			-- button:CreateBackdrop("Overlay")
			-- button.backdrop:SetAllPoints()
			-- button:StyleButton()

			-- button.bg:SetTexture("")

			-- button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			-- button.icon:SetPoint("LEFT", button, "LEFT", 10, 0)
			-- button.icon:SetDrawLayer("OVERLAY")
			-- button.icon:SetSize(40, 40)

			-- button.border = CreateFrame("Frame", nil, button)
			-- button.border:CreateBackdrop("Default")
			-- button.border.backdrop:SetPoint("TOPLEFT", button.icon, -2, 2)
			-- button.border.backdrop:SetPoint("BOTTOMRIGHT", button.icon, 2, -2)
		-- end
	-- end

	-- hooksecurefunc("GroupFinderFrame_SelectGroupButton", function(index)
		-- local self = GroupFinderFrame
		-- for i = 1, 3 do
			-- local button = self["groupButton"..i]
			-- if i == index then
				-- button.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
				-- button.backdrop.overlay:SetVertexColor(1, 0.82, 0, 0.3)
				-- button.border.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
			-- else
				-- button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				-- button.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
				-- button.border.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			-- end
		-- end
	-- end)

	-- hooksecurefunc("LFGRewardsFrame_SetItemButton", function(parentFrame, _, index)
		-- local parentName = parentFrame:GetName()
		-- local item = _G[parentName.."Item"..index]

		-- if item and not item.isSkinned then
			-- item.border = CreateFrame("Frame", nil, item)
			-- item.border:CreateBackdrop("Default")
			-- item.border.backdrop:SetPoint("TOPLEFT", item.Icon, "TOPLEFT", -2, 2)
			-- item.border.backdrop:SetPoint("BOTTOMRIGHT", item.Icon, "BOTTOMRIGHT", 2, -2)

			-- item.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			-- item.Icon:SetDrawLayer("OVERLAY")
			-- item.Icon:SetParent(item.border)

			-- hooksecurefunc(item.IconBorder, "SetVertexColor", function(self, r, g, b)
				-- if r ~= 0.65882 and g ~= 0.65882 and b ~= 0.65882 then
					-- self:GetParent().border.backdrop:SetBackdropBorderColor(r, g, b)
				-- end
				-- self:SetTexture("")
			-- end)

			-- hooksecurefunc(item.IconBorder, "Hide", function(self)
				-- self:GetParent().border.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			-- end)

			-- item.Count:SetDrawLayer("OVERLAY")
			-- item.Count:SetParent(item.border)

			-- item.NameFrame:Hide()

			-- item.shortageBorder:SetTexture(nil)

			-- item.roleIcon1:SetParent(item.border)
			-- item.roleIcon2:SetParent(item.border)

			-- item.isSkinned = true
		-- end
	-- end)

	-- local function SkinMoney(button)
		-- _G[button].border = CreateFrame("Frame", nil, _G[button])
		-- _G[button].border:CreateBackdrop("Default")
		-- _G[button].border.backdrop:SetPoint("TOPLEFT", _G[button.."IconTexture"], "TOPLEFT", -2, 2)
		-- _G[button].border.backdrop:SetPoint("BOTTOMRIGHT", _G[button.."IconTexture"], "BOTTOMRIGHT", 2, -2)

		-- _G[button.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		-- _G[button.."IconTexture"]:SetDrawLayer("OVERLAY")
		-- _G[button.."IconTexture"]:SetParent(_G[button].border)

		-- _G[button.."NameFrame"]:Hide()

		-- _G[button.."Count"]:SetDrawLayer("OVERLAY")
		-- _G[button.."Count"]:SetParent(_G[button].border)
	-- end
	-- SkinMoney("LFDQueueFrameRandomScrollFrameChildFrameMoneyReward")
	-- SkinMoney("RaidFinderQueueFrameScrollFrameChildFrameMoneyReward")

	-- hooksecurefunc("LFGDungeonListButton_SetDungeon", function(button)
		-- if not button.expandOrCollapseButton.isSkinned then
			-- T.SkinCheckBox(button.enableButton)
			-- button.enableButton:SetFrameLevel(button.enableButton:GetFrameLevel() - 2)
			-- button.enableButton.SetCheckedTexture = T.dummy -- Blizzard changes checked texture, prevent it
			-- T.SkinExpandOrCollapse(button.expandOrCollapseButton)
			-- button.expandOrCollapseButton.isSkinned = true
		-- end
	-- end)

	-- for i = 1, 4 do
		-- local tab = _G["PVEFrameTab"..i]
		-- if tab then
			-- T.SkinTab(tab)
		-- end
	-- end

	-- LFGListApplicationDialog:SetTemplate("Transparent")
	-- PVEFrame:CreateBackdrop("Transparent")
	-- PVEFrame.backdrop:SetAllPoints()

	-- LFDQueueFrameNoLFDWhileLFR:CreateBackdrop("Overlay")
	-- LFDQueueFrameNoLFDWhileLFR.backdrop:SetPoint("TOPLEFT", 2, 5)
	-- LFDQueueFrameNoLFDWhileLFR.backdrop:SetPoint("BOTTOMRIGHT", 0, 6)

	-- LFDQueueFrameCooldownFrame:CreateBackdrop("Overlay")
	-- LFDQueueFrameCooldownFrame.backdrop:SetPoint("TOPLEFT", 2, 4)
	-- LFDQueueFrameCooldownFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 6)

	-- LFDQueueFramePartyBackfill:CreateBackdrop("Overlay")
	-- LFDQueueFramePartyBackfill.backdrop:SetPoint("TOPLEFT", 2, 4)
	-- LFDQueueFramePartyBackfill.backdrop:SetPoint("BOTTOMRIGHT", 0, 6)

	-- RaidFinderQueueFrameCooldownFrame:CreateBackdrop("Overlay")
	-- RaidFinderQueueFrameCooldownFrame.backdrop:SetPoint("TOPLEFT", 2, 6)
	-- RaidFinderQueueFrameCooldownFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 8)

	-- RaidFinderQueueFramePartyBackfill:CreateBackdrop("Overlay")
	-- RaidFinderQueueFramePartyBackfill.backdrop:SetPoint("TOPLEFT", 2, 6)
	-- RaidFinderQueueFramePartyBackfill.backdrop:SetPoint("BOTTOMRIGHT", 0, 8)

	-- T.SkinDropDownBox(LFDQueueFrameTypeDropdown, 300)
	-- LFDQueueFrameTypeDropdown.backdrop:SetParent(LFDQueueFrame) -- fixed SetFrameLevel raise to 10000
	-- LFDQueueFrameTypeDropdown:SetPoint("RIGHT", -10, 0)

	-- T.SkinDropDownBox(RaidFinderQueueFrameSelectionDropdown, 300)
	-- RaidFinderQueueFrameSelectionDropdown:SetPoint("RIGHT", -10, 0)

	-- LFGListFrame.SearchPanel.ResultsInset:StripTextures()
	-- LFGListFrame.NothingAvailable:StripTextures()
	-- LFGListFrame.CategorySelection:StripTextures()

	-- LFGListFrame.CategorySelection.FindGroupButton:SkinButton()
	-- LFGListFrame.CategorySelection.StartGroupButton:SkinButton()
	-- LFGListFrame.SearchPanel.BackToGroupButton:SkinButton()
	-- LFGListFrame.SearchPanel.BackButton:SkinButton()
	-- LFGListFrame.SearchPanel.SignUpButton:SkinButton()
	-- LFGListFrame.SearchPanel.RefreshButton:SkinButton()
	-- LFGListFrame.SearchPanel.RefreshButton:SetSize(22, 22)
	-- LFGListFrame.SearchPanel.RefreshButton.Icon:SetPoint("CENTER")
	-- T.SkinFilter(LFGListFrame.SearchPanel.FilterButton, true)
	-- LFGListFrame.SearchPanel.RefreshButton:SetPoint("LEFT", LFGListFrame.SearchPanel.SearchBox, "RIGHT", 3, 0)
	-- LFGListFrame.SearchPanel.SearchBox:SetPoint("TOPLEFT", LFGListFrame.SearchPanel.CategoryName, "TOPLEFT", 4, -27)

	-- local function skinCreateButton(button)
		-- local child = button:GetChildren()
		-- if not child.styled and child:IsObjectType("Button") then
			-- child:SkinButton()
			-- child.styled = true
		-- end
	-- end

	-- local delayStyled -- otherwise it taints while listing (from NDui)
	-- hooksecurefunc(LFGListFrame.SearchPanel.ScrollBox, "Update", function(self)
		-- if not delayStyled then
			-- self.StartGroupButton:SkinButton()
			-- T.SkinScrollBar(LFGListFrame.SearchPanel.ScrollBar)
			-- delayStyled = true
		-- end
		-- self:ForEachFrame(skinCreateButton)
	-- end)

	-- hooksecurefunc("LFGListApplicationViewer_UpdateApplicant", function(button)
		-- if not button.DeclineButton.isSkinned then
			-- button.DeclineButton:SkinButton()
			-- button.DeclineButton.isSkinned = true
		-- end
		-- if not button.InviteButtonSmall.isSkinned then
			-- button.InviteButtonSmall:SkinButton()
			-- button.InviteButtonSmall.isSkinned = true
		-- end
		-- if not button.InviteButton.isSkinned then
			-- button.InviteButton:SkinButton()
			-- button.InviteButton.isSkinned = true
		-- end
	-- end)

	-- hooksecurefunc("LFGListSearchEntry_Update", function(button)
		-- if button and not button.isSkinned then
			-- button.CancelButton:SkinButton()
			-- button.isSkinned = true
		-- end
	-- end)

	-- hooksecurefunc("LFGListSearchPanel_UpdateAutoComplete", function(self)
		-- for i = 1, LFGListFrame.SearchPanel.AutoCompleteFrame:GetNumChildren() do
			-- local child = select(i, LFGListFrame.SearchPanel.AutoCompleteFrame:GetChildren())
			-- if child and not child.isSkinned and child:GetObjectType() == "Button" then
				-- child:SkinButton()
				-- child.isSkinned = true
			-- end
		-- end

		-- local text = self.SearchBox:GetText()
		-- local matchingActivities = C_LFGList.GetAvailableActivities(self.categoryID, nil, self.filters, text)
		-- local numResults = math.min(#matchingActivities, MAX_LFG_LIST_SEARCH_AUTOCOMPLETE_ENTRIES)

		-- for i = 2, numResults do
			-- local button = self.AutoCompleteFrame.Results[i]
			-- if button and not button.moved then
				-- button:SetPoint("TOPLEFT", self.AutoCompleteFrame.Results[i-1], "BOTTOMLEFT", 0, -2)
				-- button:SetPoint("TOPRIGHT", self.AutoCompleteFrame.Results[i-1], "BOTTOMRIGHT", 0, -2)
				-- button.moved = true
			-- end
		-- end
		-- self.AutoCompleteFrame:SetHeight(numResults * (self.AutoCompleteFrame.Results[1]:GetHeight() + 3.5) + 8)
	-- end)

	-- LFGListFrame.SearchPanel.AutoCompleteFrame:StripTextures()
	-- LFGListFrame.SearchPanel.AutoCompleteFrame:CreateBackdrop("Transparent")
	-- LFGListFrame.SearchPanel.AutoCompleteFrame.backdrop:SetPoint("TOPLEFT", LFGListFrame.SearchPanel.AutoCompleteFrame, "TOPLEFT", 0, 3)
	-- LFGListFrame.SearchPanel.AutoCompleteFrame.backdrop:SetPoint("BOTTOMRIGHT", LFGListFrame.SearchPanel.AutoCompleteFrame, "BOTTOMRIGHT", 6, 3)

	-- LFGListFrame.SearchPanel.AutoCompleteFrame:SetPoint("TOPLEFT", LFGListFrame.SearchPanel.SearchBox, "BOTTOMLEFT", -2, -8)
	-- LFGListFrame.SearchPanel.AutoCompleteFrame:SetPoint("TOPRIGHT", LFGListFrame.SearchPanel.SearchBox, "BOTTOMRIGHT", -4, -8)

	-- T.SkinEditBox(LFGListFrame.SearchPanel.SearchBox)

	-- T.SkinCloseButton(PVEFrameCloseButton)
	-- T.SkinCloseButton(LFGDungeonReadyStatusCloseButton, nil, "-")
	-- T.SkinCloseButton(LFGDungeonReadyDialogCloseButton, LFGDungeonReadyDialog, "-")

	-- LFGInvitePopup:StripTextures()
	-- LFGInvitePopup:SetTemplate("Transparent")
	-- LFGDungeonReadyPopup:SetTemplate("Transparent")
	-- LFGDungeonReadyDialog.SetBackdrop = T.dummy
	-- LFGDungeonReadyDialog.Border:Hide()
	-- LFGDungeonReadyStatus.Border:Hide()

	-- hooksecurefunc("LFGDungeonReadyDialog_UpdateRewards", function()
		-- for i = 1, LFD_MAX_REWARDS do
			-- local reward = LFGDungeonReadyDialogRewardsFrame.Rewards[i]
			-- if not reward.isSkinned then
				-- reward.texture:SetSize(18, 18)
				-- reward.texture:SkinIcon(true)
				-- reward:DisableDrawLayer("OVERLAY")
				-- reward.isSkinned = true
			-- end
		-- end
	-- end)

	-- LFGListFrame.CategorySelection.CategoryButtons[1]:SetNormalFontObject(GameFontNormal)
	-- hooksecurefunc("LFGListCategorySelection_AddButton", function(self, index)
		-- local button = self.CategoryButtons[index]
		-- if button and not button.styled then
			-- button.Cover:Hide()
			-- button:SetTemplate("Overlay")
			-- button:StyleButton()
			-- button.Icon:SetDrawLayer("ARTWORK")
			-- button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			-- button.Icon:SetPoint("TOPLEFT", 2, -2)
			-- button.Icon:SetPoint("BOTTOMRIGHT", -2, 2)
			-- button.SelectedTexture:SetColorTexture(1, 0.82, 0, 0.3)
			-- button.SelectedTexture:SetPoint("TOPLEFT", 2, -2)
			-- button.SelectedTexture:SetPoint("BOTTOMRIGHT", -2, 2)

			-- button.Label:SetFontObject(_G.GameFontNormal)
			-- button.styled = true
		-- end
	-- end)

	-- LFGListFrame.EntryCreation:StripTextures()
	-- LFGListFrame.EntryCreation.Description:StripTextures()
	-- LFGListApplicationDialogDescription:StripTextures()
	-- LFGListInviteDialog:StripTextures()
	-- LFGListInviteDialog:SetTemplate("Transparent")
	-- LFGListInviteDialog.AcknowledgeButton:SkinButton()
	-- LFGListInviteDialog.AcceptButton:SkinButton()
	-- LFGListInviteDialog.DeclineButton:SkinButton()

	-- T.SkinEditBox(LFGListApplicationDialogDescription)
	-- T.SkinEditBox(LFGListFrame.EntryCreation.Name, nil, 17)
	-- T.SkinEditBox(LFGListFrame.EntryCreation.ItemLevel.EditBox, nil, 17)
	-- T.SkinEditBox(LFGListFrame.EntryCreation.VoiceChat.EditBox, nil, 17)
	-- T.SkinEditBox(LFGListFrame.EntryCreation.Description)
	-- T.SkinDropDownBox(LFGListEntryCreationGroupDropdown)
	-- T.SkinDropDownBox(LFGListEntryCreationActivityDropdown)
	-- T.SkinCheckBox(LFGListFrame.EntryCreation.VoiceChat.CheckButton)
	-- T.SkinCheckBox(LFGListFrame.EntryCreation.ItemLevel.CheckButton)
	-- T.SkinCheckBox(LFGListFrame.EntryCreation.PrivateGroup.CheckButton)
	-- T.SkinCheckBox(LFGListFrame.EntryCreation.CrossFactionGroup.CheckButton)
	-- LFGListFrame.EntryCreation.ListGroupButton:SkinButton()
	-- LFGListFrame.EntryCreation.CancelButton:SkinButton()

	-- T.SkinDropDownBox(LFGListEntryCreationPlayStyleDropdown)
	-- T.SkinCheckBox(LFGListFrame.EntryCreation.MythicPlusRating.CheckButton)
	-- T.SkinEditBox(LFGListFrame.EntryCreation.MythicPlusRating.EditBox, nil, 17)

	-- T.SkinCheckBox(LFGListFrame.EntryCreation.PvpItemLevel.CheckButton)
	-- T.SkinEditBox(LFGListFrame.EntryCreation.PvpItemLevel.EditBox, nil, 17)

	-- T.SkinCheckBox(LFGListFrame.EntryCreation.PVPRating.CheckButton)
	-- T.SkinEditBox(LFGListFrame.EntryCreation.PVPRating.EditBox, nil, 17)

	-- LFGListFrame.EntryCreation.ActivityFinder.Dialog:StripTextures()
	-- LFGListFrame.EntryCreation.ActivityFinder.Dialog:SetTemplate("Transparent")
	-- LFGListFrame.EntryCreation.ActivityFinder.Dialog.BorderFrame:StripTextures()
	-- LFGListFrame.EntryCreation.ActivityFinder.Dialog.BorderFrame:SetTemplate("Transparent")
	-- T.SkinEditBox(LFGListFrame.EntryCreation.ActivityFinder.Dialog.EntryBox, 276, 17)
	-- LFGListFrame.EntryCreation.ActivityFinder.Dialog.SelectButton:SkinButton()
	-- LFGListFrame.EntryCreation.ActivityFinder.Dialog.CancelButton:SkinButton()

	-- -- ApplicationViewer (Custom Groups)
	-- T.SkinCheckBox(LFGListFrame.ApplicationViewer.AutoAcceptButton)
	-- LFGListFrame.ApplicationViewer.Inset:StripTextures()
	-- LFGListFrame.ApplicationViewer.Inset:SetTemplate("Transparent")

	-- LFGListFrame.ApplicationViewer.NameColumnHeader:SkinButton(true)
	-- LFGListFrame.ApplicationViewer.NameColumnHeader:ClearAllPoints()
	-- LFGListFrame.ApplicationViewer.NameColumnHeader:SetPoint("BOTTOMLEFT", LFGListFrame.ApplicationViewer.Inset, "TOPLEFT", 0, 1)
	-- LFGListFrame.ApplicationViewer.NameColumnHeader.Label:SetFont(C.media.normal_font, 10, "")

	-- LFGListFrame.ApplicationViewer.RoleColumnHeader:SkinButton(true)
	-- LFGListFrame.ApplicationViewer.RoleColumnHeader:ClearAllPoints()
	-- LFGListFrame.ApplicationViewer.RoleColumnHeader:SetPoint("LEFT", LFGListFrame.ApplicationViewer.NameColumnHeader, "RIGHT", 1, 0)
	-- LFGListFrame.ApplicationViewer.RoleColumnHeader.Label:SetFont(C.media.normal_font, 10, "")

	-- LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:SkinButton(true)
	-- LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:ClearAllPoints()
	-- LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:SetPoint("LEFT", LFGListFrame.ApplicationViewer.RoleColumnHeader, "RIGHT", 1, 0)
	-- LFGListFrame.ApplicationViewer.ItemLevelColumnHeader.Label:SetFont(C.media.normal_font, 10, "")

	-- LFGListFrame.ApplicationViewer.RatingColumnHeader:SkinButton(true)
	-- LFGListFrame.ApplicationViewer.RatingColumnHeader:ClearAllPoints()
	-- LFGListFrame.ApplicationViewer.RatingColumnHeader:SetPoint("LEFT", LFGListFrame.ApplicationViewer.ItemLevelColumnHeader, "RIGHT", 1, 0)
	-- LFGListFrame.ApplicationViewer.RatingColumnHeader.Label:SetFont(C.media.normal_font, 10, "")

	-- LFGListFrame.ApplicationViewer.RefreshButton:SkinButton()
	-- LFGListFrame.ApplicationViewer.RefreshButton:SetSize(24,24)
	-- LFGListFrame.ApplicationViewer.RefreshButton:ClearAllPoints()
	-- LFGListFrame.ApplicationViewer.RefreshButton:SetPoint("BOTTOMRIGHT", LFGListFrame.ApplicationViewer.Inset, "TOPRIGHT", 16, 4)

	-- LFGListFrame.ApplicationViewer.BrowseGroupsButton:SkinButton(true)
	-- LFGListFrame.ApplicationViewer.BrowseGroupsButton:ClearAllPoints()
	-- LFGListFrame.ApplicationViewer.BrowseGroupsButton:SetPoint("BOTTOMLEFT", -1, 2)

	-- LFGListFrame.ApplicationViewer.RemoveEntryButton:SkinButton(true)
	-- LFGListFrame.ApplicationViewer.RemoveEntryButton:SetWidth(80)

	-- LFGListFrame.ApplicationViewer.EditButton:SkinButton(true)
	-- LFGListFrame.ApplicationViewer.EditButton:ClearAllPoints()
	-- LFGListFrame.ApplicationViewer.EditButton:SetPoint("BOTTOMRIGHT", -6, 2)
	-- LFGListFrame.ApplicationViewer.EditButton:SetWidth(80)

	-- LFGListFrame.ApplicationViewer.ScrollBar:ClearAllPoints()
	-- LFGListFrame.ApplicationViewer.ScrollBar:SetPoint("TOPLEFT", LFGListFrame.ApplicationViewer.Inset, "TOPRIGHT", 0, -14)
	-- LFGListFrame.ApplicationViewer.ScrollBar:SetPoint("BOTTOMLEFT", LFGListFrame.ApplicationViewer.Inset, "BOTTOMRIGHT", 0, 14)
	-- T.SkinScrollBar(LFGListFrame.ApplicationViewer.ScrollBar)

	-- LFGListFrame.ApplicationViewer.InfoBackground:SkinIcon()
	-- LFGListFrame.ApplicationViewer.InfoBackground:SetPoint("TOPLEFT", 1, -27)
	-- LFGListFrame.ApplicationViewer.InfoBackground:SetSize(324, 90)
end

T.SkinFuncs["Blizzard_GroupFinder_VanillaStyle"] = LoadSkin