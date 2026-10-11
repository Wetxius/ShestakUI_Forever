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

	T.SkinEditBox(LegacySystemFrame.ChallengesPage.CategoryList.SearchBox)
	LegacySystemFrame.ChallengesPage.CategoryList.SearchBox.backdrop:SetOutside(nil, 2, -1)
	T.SkinEditBox(LegacySystemFrame.TreePage.LegacyTreeTraitPanel.SearchBox)
	LegacySystemFrame.TreePage.LegacyTreeTraitPanel.SearchBox.backdrop:SetOutside(nil, 2, -4)

	T.SkinFilter(LegacySystemFrame.ChallengesPage.CategoryList.FilterDropdown)
	T.SkinScrollBar(LegacySystemFrame.ChallengesPage.CategoryList.ScrollBar)
	T.SkinScrollBar(LegacySystemFrame.ChallengesPage.DetailPane.ScrollBar)

	LegacySystemFrame.TreePage.LegacyTreeTraitPanel.ApplyButton:SkinButton()
end

T.SkinFuncs["Blizzard_LegacySystem"] = LoadSkin