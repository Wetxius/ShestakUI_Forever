local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Character skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	T.SkinFrame(CharacterFrame)

	for _, tab in next, _G.CharacterFrame.ModeTabs.Tabs do
		T.SkinSideTabs(tab)
	end

	CharacterFrameLeftPaneHost:SetAlpha(0)
	CharacterFrameRightPaneHost:SetAlpha(0)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)