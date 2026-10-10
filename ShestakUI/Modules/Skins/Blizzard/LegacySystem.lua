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
end

T.SkinFuncs["Blizzard_LegacySystem"] = LoadSkin