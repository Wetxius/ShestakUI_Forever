local T, C, L = unpack(ShestakUI)
if C.unitframe.unit_castbar ~= true or C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Swing Timer skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	for _, frame in next, { _G.SwingTimerMainHandFrame, _G.SwingTimerOffHandFrame, _G.SwingTimerRangedFrame } do
		frame:StripTextures()

		local bar = frame.StatusBar
		bar:CreateBackdrop("Overlay")
		-- bar.backdrop:SetPoint("TOPLEFT", 2, -2)
		-- bar.backdrop:SetPoint("BOTTOMRIGHT", -2, 1)

		bar.TypeLabel:SetFont(C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
		bar.TimeLabel:SetFont(C.font.unit_frames_font, C.font.unit_frames_font_size, C.font.unit_frames_font_style)
	end
end

T.SkinFuncs["Blizzard_SwingTimer"] = LoadSkin