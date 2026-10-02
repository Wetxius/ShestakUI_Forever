local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Font replacement
----------------------------------------------------------------------------------------
MapQuestInfoRewardsFrame.XPFrame.Name:SetFont(C.media.normal_font, 13, "")

----------------------------------------------------------------------------------------
--	Change position
----------------------------------------------------------------------------------------
hooksecurefunc(WorldMapFrame, "SynchronizeDisplayState", function()
	if CharacterFrame:IsShown() or (PlayerSpellsFrame and PlayerSpellsFrame:IsShown()) or (ChannelFrame and ChannelFrame:IsShown()) or (MacroFrame and MacroFrame:IsShown()) or (GarrisonLandingPage and GarrisonLandingPage:IsShown()) then return end
	if not WorldMapFrame:IsMaximized() then
		WorldMapFrame:ClearAllPoints()
		WorldMapFrame:SetPoint(unpack(C.position.map))
	end
end)
WorldMapFrame:SetClampedToScreen(true)

----------------------------------------------------------------------------------------
--	Added options to map tracking button
----------------------------------------------------------------------------------------
local MapFrame = CreateFrame("Frame", nil, UIParent)
local WorldMap_DDMenu = CreateFrame("Frame")
WorldMap_DDMenu.displayMode = "MENU"
WorldMap_DDMenu.info = {}

local Close = CreateFrame("Button", "WorldMapUIButton", WorldMapFrame, "UIPanelCloseButton")
T.SkinCloseButton(Close, nil, "-", true)
Close:ClearAllPoints()
Close:SetPoint("TOPLEFT", WorldMapFrame, "TOPLEFT", 5, -45)
Close:SetSize(15, 15)
Close:RegisterForClicks("AnyUp")
Close:SetScript("OnClick", function(self)
	if WorldMap_DDMenu.initialize ~= MapFrame.Menu then
		CloseDropDownMenus()
		WorldMap_DDMenu.initialize = MapFrame.Menu
	end
	ToggleDropDownMenu(nil, nil, WorldMap_DDMenu, self:GetName(), 0, 0)
	return
end)

function MapFrame.Menu(self, level)
	if not level then return end

	local info = self.info

	info.isTitle = true
	info.notCheckable = true
	info.text = "ShestakUI"

	UIDropDownMenu_AddButton(info)
	info.text = nil

	info.isTitle = nil
	info.disabled = nil
	info.notCheckable = nil
	info.isNotRadio = true
	info.keepShownOnClick = true

	-- info.text = L_MAP_COORDS
	-- info.checked = function()
		-- return ShestakUISettingsPerChar.Coords == true
	-- end

	-- info.func = function()
		-- if ShestakUISettingsPerChar.Coords == true then
			-- ShestakUISettingsPerChar.Coords = false
			-- coords:SetAlpha(0)
		-- else
			-- ShestakUISettingsPerChar.Coords = true
			-- coords:SetAlpha(1)
		-- end
	-- end
	-- UIDropDownMenu_AddButton(info)

	if C.minimap.fog_of_war == true then
		info.text = L_MAP_FOG
		info.checked = function()
			return ShestakUISettingsPerChar.FogOfWar == true
		end

		info.func = function()
			if ShestakUISettingsPerChar.FogOfWar == true then
				ShestakUISettingsPerChar.FogOfWar = false
				for i = 1, #T.overlayTextures do
					T.overlayTextures[i]:Hide()
				end
			else
				ShestakUISettingsPerChar.FogOfWar = true
				for i = 1, #T.overlayTextures do
					T.overlayTextures[i]:Show()
				end
			end
		end
		UIDropDownMenu_AddButton(info)
	end
end