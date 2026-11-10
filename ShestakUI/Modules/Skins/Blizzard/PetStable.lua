local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	PetStable skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = PetStableFrame
	T.SkinFrame(frame)

	PetStableMoneyFrame:StripTextures()
	PetStableFrame.TopDividerFrame:SetAlpha(0)
	PetStableFrame.BottomDividerFrame:SetAlpha(0)

	PetStableFrame.purchaseButton:SkinButton()

	local buttons = {
		"PetStableCurrentPet",
		"PetStableStabledPet1",
		"PetStableStabledPet2",
	}

	for _, v in pairs(buttons) do
		local button = _G[v]
		local icon = _G[v.."IconTexture"]

		button:StripTextures()
		button:StyleButton()
		button:SetTemplate("Default")

		icon:CropIcon()
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)