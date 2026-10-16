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

	LFGListingFrameActivityView:StripTextures()

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
	T.SkinFilter(LFGWhoListFrame.FilterDropdown, true)

	hooksecurefunc("LFGListingCategorySelection_AddButton", function(self, index)
		local button = self.CategoryButtons[index]
		if button and not button.styled then
			button.Cover:SetAlpha(0)
			button:SetTemplate("Overlay")
			button.HighlightTexture:SetColorTexture(1, 1, 1, 0.3)
			button:SetPushedTexture(0)
			button.Icon:SetDrawLayer("ARTWORK")
			button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button.Icon:SetPoint("TOPLEFT", 2, -2)
			button.Icon:SetPoint("BOTTOMRIGHT", -2, 2)

			button.styled = true
		end
	end)

	local function SkinCheckboxes(button)
		local checkbox = button.CheckButton
		if not checkbox.isSkinned then
			T.SkinCheckBox(checkbox)
			checkbox:SetFrameLevel(checkbox:GetFrameLevel() - 2)
			checkbox.SetCheckedTexture = T.dummy -- Blizzard changes checked texture, prevent it
			checkbox:SetSize(26, 26)
			checkbox.isSkinned = true
		end
	end

	hooksecurefunc("LFGListingActivityView_InitActivityButton", SkinCheckboxes)

	hooksecurefunc("LFGListingActivityView_InitActivityGroupButton", function(button)
		if not button.ExpandOrCollapseButton.styled then
			button.ExpandOrCollapseButton:GetNormalTexture():SetAlpha(0)
			T.SkinExpandOrCollapse(button.ExpandOrCollapseButton)
			button.ExpandOrCollapseButton.styled = true
		end
		SkinCheckboxes(button)
	end)

	hooksecurefunc(LFGBrowseFrameScrollBox, "Update", function(frame)
		for _, child in next, {frame.ScrollTarget:GetChildren()} do
			if child and not child.isSkinned then
				if child.CollapseIcon then
					child.ResultBG:SetAlpha(0)

					child:CreateBackdrop("Overlay")
					child.backdrop:SetPoint("TOPLEFT", child, 4, -7)
					child.backdrop:SetPoint("BOTTOMRIGHT", child, -3, 1)

					local highlight = child.Highlight
					highlight:SetColorTexture(1, 1, 1, 0.3)
					highlight:SetInside(child.backdrop)
				end

				child.isSkinned = true
			end
		end
	end)
end

T.SkinFuncs["Blizzard_GroupFinder_VanillaStyle"] = LoadSkin