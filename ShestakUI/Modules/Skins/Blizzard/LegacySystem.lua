local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	LegacySystem skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = LegacySystemFrame
	T.SkinFrame(frame)

	for _, tab in next, LegacySystemFrame.Tabs do
		T.SkinSideTabs(tab)
	end

	LegacySystemFrame.RewardTrackPage.Background:SetAlpha(0)
	LegacySystemFrame.ChallengesPage.Background:SetAlpha(0)
	LegacySystemFrame.TreePage.Background:SetAlpha(0)
	LegacySystemFrame.ChallengesPage.VerticalDivider:SetAlpha(0)
	LegacySystemFrame.TreePage.VerticalDivider.VerticalDivider:SetAlpha(0)

	T.SkinEditBox(LegacySystemFrame.ChallengesPage.CategoryList.SearchBox)
	LegacySystemFrame.ChallengesPage.CategoryList.SearchBox.backdrop:SetOutside(nil, 2, -1)
	T.SkinEditBox(LegacySystemFrame.TreePage.LegacyTreeTraitPanel.SearchBox)
	LegacySystemFrame.TreePage.LegacyTreeTraitPanel.SearchBox.backdrop:SetOutside(nil, 2, -4)

	T.SkinFilter(LegacySystemFrame.ChallengesPage.CategoryList.FilterDropdown)
	T.SkinScrollBar(LegacySystemFrame.ChallengesPage.CategoryList.ScrollBar)
	T.SkinScrollBar(LegacySystemFrame.ChallengesPage.DetailPane.ScrollBar)

	LegacySystemFrame.TreePage.LegacyTreeTraitPanel.ApplyButton:SkinButton()

	for _, bar in next, {LegacySystemFrame.RewardTrackPage.LegacyRewardProgressBar, LegacySystemFrame.ChallengesPage.LegacyChallengePointSummary.PointsBar} do
		bar.ProgressBarFrame:SetAlpha(0)
		bar:CreateBackdrop("Overlay")
	end
	LegacySystemFrame.ChallengesPage.LegacyChallengePointSummary.ProgressBarBackground:SetAlpha(0)
	LegacySystemFrame.TreePage.LegacyTreePointSummary.Border:SetAlpha(0)

	hooksecurefunc(LegacySystemFrame.RewardTrackPage.LegacyRewardProgressFrame, "Init", function(self)
		for reward in self.elementPool:EnumerateActive() do
			if not reward.styled then
				reward:CreateBackdrop("Overlay")
				reward.backdrop:SetPoint("TOPLEFT", reward, 18, -8)
				reward.backdrop:SetPoint("BOTTOMRIGHT", reward, -18, 8)

				reward.RewardCardBG:SetAlpha(0)

				reward.Icon:SkinIcon(true)
				reward.IconBorder:SetAlpha(0)
				reward.styled = true
			end
		end
	end)

	hooksecurefunc(LegacySystemFrame.ChallengesPage.CategoryList.ScrollBox, "Update", function(frame)
		for _, child in next, {frame.ScrollTarget:GetChildren()} do
			if child and not child.isSkinned then
				if child.CollapseButton then
					child:GetNormalTexture():SetAlpha(0)

					child:CreateBackdrop("Overlay")
					child.backdrop:SetPoint("TOPLEFT", child, 3, -1)
					child.backdrop:SetPoint("BOTTOMRIGHT", child, -1, 1)
				end

				child.isSkinned = true
			end
		end
	end)

	hooksecurefunc(LegacySystemFrame.ChallengesPage.DetailPane.ScrollBox, "Update", function(frame)
		for _, button in next, { frame.ScrollTarget:GetChildren() } do
			if button and not button.IsSkinned then
				button.TitleBar:SetAlpha(0)
				button.Background:SetAlpha(0)
				button.BackgroundTop:SetAlpha(0)
				button.BackgroundMiddle:SetAlpha(0)
				button.BackgroundBottom:SetAlpha(0)
				button.SelectedOverlay:SetAlpha(0)
				button.Shield.CheckBackground:SetAlpha(0)

				button:CreateBackdrop("Overlay")
				button.backdrop:SetInside(button, 0, 2)

				T.SkinCheckBox(button.Tracked)
				button.Tracked:SetSize(20, 20)

				hooksecurefunc(button, "DisplayObjectives", function(self)
					for criteria in self:GetObjectiveFrame().criteriaPool:EnumerateActive() do
						if not criteria.styled then
							criteria.Background:SetAlpha(0)
							local bar = criteria.ProgressBar
							if bar then
								bar.ProgressBarFrame:SetAlpha(0)
								bar:CreateBackdrop("Overlay")
							end
							criteria.styled = true
						end
					end
				end)

				local collapse = button.PlusMinus
				if collapse then
					collapse:SetAlpha(0)
					local b = CreateFrame("Button", nil, frame)
					b:SetPoint("TOPLEFT", collapse)
					b:Hide()
					b:SetSize(17, 17)
					b:StripTextures()
					b:SetTemplate("Overlay")

					b.minus = b:CreateTexture(nil, "OVERLAY")
					b.minus:SetSize(7, 1)
					b.minus:SetPoint("CENTER")
					b.minus:SetTexture(C.media.blank)

					b.plus = b:CreateTexture(nil, "OVERLAY")
					b.plus:SetSize(1, 7)
					b.plus:SetPoint("CENTER")
					b.plus:SetTexture(C.media.blank)

					b:HookScript("OnEnter", T.SetModifiedBackdrop)
					b:HookScript("OnLeave", T.SetOriginalBackdrop)

					b:SetScript("OnMouseUp", function() button:OnClick() end)

					hooksecurefunc(collapse, "Hide", function(_, show)
						b:SetShown(false)
					end)

					hooksecurefunc(collapse, "Show", function(_, show)
						b:SetShown(true)
					end)

					hooksecurefunc(collapse, "SetShown", function(_, show)
						b:SetShown(show)
					end)

					hooksecurefunc(button, "UpdatePlusMinusArt", function(self)
						if self.collapsed then
							b.plus:Show()
						else
							b.plus:Hide()
						end
					end)
				end

				button.Icon.frame:SetAlpha(0)
				button.Icon.texture:RemoveMaskTexture(button.Icon.TextureMask)
				button.Icon.texture:SkinIcon()

				button.IsSkinned = true
			end
		end
	end)

	hooksecurefunc(LegacySystemFrame.TreePage.LegacyTreeSelectionPanel, "UpdateSelection", function(self)
		for i, button in ipairs(self.treeButtons) do
			if not button.styled then
				button:CreateBackdrop("Default")
				button:StyleButton(true, 0)
				button.checked:SetColorTexture(1, 0.82, 0, 0.3)

				button.NormalTexture:SetTexCoord(0.15, 0.85, 0.15, 0.85)
				button.PushedTexture:SetTexCoord(0.15, 0.85, 0.15, 0.85)

				button.CircleMask:Hide()
				button.Ring:Hide()
				button.SelectedGlow:SetAlpha(0)
				button.Background:SetAlpha(0)

				button.styled = true
			end
		end
	end)

	local SelectedTreeIcon = LegacySystemFrame.TreePage.LegacyTreeTraitPanel.SelectedTreeIcon
	SelectedTreeIcon:CreateBackdrop("Default")
	SelectedTreeIcon.CircleMask:Hide()
	SelectedTreeIcon.Ring:Hide()
	SelectedTreeIcon.NormalTexture:SetTexCoord(0.15, 0.85, 0.15, 0.85)
	LegacySystemFrame.TreePage.LegacyTreeTraitPanel.SpentPointsFrame.Background:SetAlpha(0)
	LegacySystemFrame.TreePage.LegacyTreeTraitPanel.SpentPointsFrame:SetMovePoint(nil, -15)

	local function TalentButtonStateBorder(button, visualState)
		local color = _G.TalentButtonUtil.GetColorForBaseVisualState(visualState)
		if visualState == TalentButtonUtil.BaseVisualState.Maxed then
			button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
		else
			button.backdrop:SetBackdropBorderColor(color:GetRGB())
		end
	end

	hooksecurefunc(LegacySystemFrame.TreePage.LegacyTreeTraitPanel, "UpdateButtonFrameLevel", function(_, button)
		if not button.styled then
			button.Icon:SkinIcon()
			button.StateBorder:SetAlpha(0)
			button.StateBorderHover:Kill()
			button.Shadow:SetAlpha(0)

			hooksecurefunc(button, "UpdateStateBorder", TalentButtonStateBorder)
			local visualState = button:GetVisualState()
			if visualState then -- state was applied before the hook existed
				TalentButtonStateBorder(button, visualState)
			end

			button.styled = true
		end
	end)
end

T.SkinFuncs["Blizzard_LegacySystem"] = LoadSkin