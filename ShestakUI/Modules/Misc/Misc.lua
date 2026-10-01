local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Force readycheck warning
----------------------------------------------------------------------------------------
local ShowReadyCheckHook = function(_, initiator)
	if initiator ~= "player" then
		PlaySound(SOUNDKIT.READY_CHECK, "Master")
	end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)

----------------------------------------------------------------------------------------
--	Force other warning
----------------------------------------------------------------------------------------
local ForceWarning = CreateFrame("Frame")
ForceWarning:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
ForceWarning:RegisterEvent("PET_BATTLE_QUEUE_PROPOSE_MATCH")
ForceWarning:RegisterEvent("LFG_PROPOSAL_SHOW")
ForceWarning:RegisterEvent("RESURRECT_REQUEST")
ForceWarning:SetScript("OnEvent", function(_, event)
	if event == "UPDATE_BATTLEFIELD_STATUS" then
		for i = 1, GetMaxBattlefieldID() do
			local status = GetBattlefieldStatus(i)
			if status == "confirm" then
				PlaySound(SOUNDKIT.PVP_THROUGH_QUEUE, "Master")
				break
			end
			i = i + 1
		end
	elseif event == "PET_BATTLE_QUEUE_PROPOSE_MATCH" then
		PlaySound(SOUNDKIT.PVP_THROUGH_QUEUE, "Master")
	elseif event == "LFG_PROPOSAL_SHOW" then
		PlaySound(SOUNDKIT.READY_CHECK, "Master")
	elseif event == "RESURRECT_REQUEST" then
		PlaySound(37, "Master")
	end
end)

----------------------------------------------------------------------------------------
--	Misclicks for some popups
----------------------------------------------------------------------------------------
StaticPopupDialogs.RESURRECT.hideOnEscape = nil
StaticPopupDialogs.AREA_SPIRIT_HEAL.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil
PetBattleQueueReadyFrame.hideOnEscape = nil
PVPReadyDialog.leaveButton:Hide()
PVPReadyDialog.enterButton:ClearAllPoints()
PVPReadyDialog.enterButton:SetPoint("BOTTOM", PVPReadyDialog, "BOTTOM", 0, 25)

----------------------------------------------------------------------------------------
--	Spin camera while afk(by Telroth and Eclipse)
----------------------------------------------------------------------------------------
if C.misc.afk_spin_camera == true then
	local spinning
	local function SpinStart()
		spinning = true
		MoveViewRightStart(0.1)
		UIParent:Hide()
	end

	local function SpinStop()
		if not spinning then return end
		spinning = nil
		MoveViewRightStop()
		if InCombatLockdown() then return end
		UIParent:Show()
	end

	local SpinCam = CreateFrame("Frame")
	SpinCam:RegisterEvent("PLAYER_LEAVING_WORLD")
	SpinCam:RegisterEvent("PLAYER_FLAGS_CHANGED")
	SpinCam:SetScript("OnEvent", function(_, event)
		if event == "PLAYER_LEAVING_WORLD" then
			SpinStop()
		else
			if T.CheckUnitStatus(UnitIsAFK, "player") and not InCombatLockdown() then
				SpinStart()
			else
				SpinStop()
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Auto select current event boss from LFD tool(EventBossAutoSelect by Nathanyel)
----------------------------------------------------------------------------------------
local firstLFD
LFDParentFrame:HookScript("OnShow", function()
	if not firstLFD then
		firstLFD = true

		for i = 1, GetNumRandomDungeons() do
			local id = GetLFGRandomDungeonInfo(i)
			local isHoliday, _, _, isTimeWalker = select(15, GetLFGDungeonInfo(id))
			if isHoliday and not isTimeWalker and not GetLFGDungeonRewards(id) then
				LFDQueueFrame_SetTypeInternal(id) -- Previous function cause taint SetEntryTitle()
				break
			end
		end
	end
end)

----------------------------------------------------------------------------------------
--	Undress button in dress-up frame(by Nefarion)
----------------------------------------------------------------------------------------
local strip = CreateFrame("Button", "DressUpFrameUndressButton", DressUpFrame, "UIPanelButtonTemplate")
strip:SetText(L_MISC_UNDRESS)
strip:SetWidth(strip:GetTextWidth() + 40)
strip:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
strip:RegisterForClicks("AnyUp")
strip:SetScript("OnClick", function(_, button)
	local actor = DressUpFrame.ModelScene:GetPlayerActor()
	if not actor then return end
	if button == "RightButton" then
		actor:UndressSlot(19)
	else
		actor:Undress()
	end
	PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
end)

----------------------------------------------------------------------------------------
--	Boss Banner Hider
----------------------------------------------------------------------------------------
if C.general.hide_banner == true then
	BossBanner.PlayBanner = function() end
	BossBanner:UnregisterAllEvents()
end

----------------------------------------------------------------------------------------
--	Easy delete good items
----------------------------------------------------------------------------------------
local deleteDialog = StaticPopupDialogs["DELETE_GOOD_ITEM"]
if deleteDialog.OnShow then
	hooksecurefunc(deleteDialog, "OnShow", function(s) s:GetEditBox():SetText(DELETE_ITEM_CONFIRM_STRING) s:GetEditBox():SetAutoFocus(false) s:GetEditBox():ClearFocus() end)
end

----------------------------------------------------------------------------------------
--	Change UIErrorsFrame strata
----------------------------------------------------------------------------------------
UIErrorsFrame:SetFrameLevel(0)

----------------------------------------------------------------------------------------
--	Increase speed for AddonList scroll
----------------------------------------------------------------------------------------
AddonList.ScrollBox.wheelPanScalar = 6
AddonList.ScrollBar.wheelPanScalar = 6


----------------------------------------------------------------------------------------
--	Allow mousewheel in ItemTextScrollFrame
----------------------------------------------------------------------------------------
ItemTextScrollFrame:HookScript("OnMouseWheel", function(_, delta)
	if delta < 0 and ItemTextNextPageButton:IsShown() then
		ItemTextNextPageButton:Click()
	elseif delta > 0 and ItemTextPrevPageButton:IsShown() then
		ItemTextPrevPageButton:Click()
	end
end)

----------------------------------------------------------------------------------------
--	Find cheapest BoP item in bags and destroy it
----------------------------------------------------------------------------------------
local function FindCheapestItem()
	local cheapest = nil

	for bag = 0, 4 do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			local info = C_Container.GetContainerItemInfo(bag, slot)
			if info and info.itemID then
				local itemLocation = ItemLocation:CreateFromBagAndSlot(bag, slot)
				local isBound = C_Item.IsBound(itemLocation)
				if isBound then
					local itemName, itemLink, _, _, _, _, _, _, _, _, sellPrice = C_Item.GetItemInfo(info.itemID)
					if sellPrice and sellPrice > 0 then
						local totalValue = sellPrice * (info.stackCount or 1)

						if not cheapest or totalValue < cheapest.totalValue then
							cheapest = {
								bag = bag,
								slot = slot,
								itemID = info.itemID,
								itemLink = itemLink,
								itemName = itemName,
								totalValue = totalValue
							}
						end
					end
				end
			end
		end
	end

	return cheapest
end

StaticPopupDialogs["CHEAP_DESTROY_CONFIRM"] = {
	text = L_MISC_DESTROY_ITEM.."\n\n\n\n",
	button1 = YES,
	button2 = CANCEL,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,

	OnShow = function(self, data)
		if not data or not data.itemLink then
			return
		end

		if not self.itemLinkText then
			local linkText = self:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
			linkText:SetPoint("TOP", self.Text, "BOTTOM", 0, 25)
			linkText:SetJustifyH("CENTER")
			linkText:EnableMouse(true)
			self.itemLinkText = linkText
		end

		self.itemLinkText:SetText(data.itemLink.."\n"..T.FormatGold(1, data.totalValue))

		self.itemLinkText:SetScript("OnEnter", function(self)
			if not data.itemLink then
				return
			end

			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetHyperlink(data.itemLink)
			GameTooltip:Show()
		end)

		self.itemLinkText:SetScript("OnLeave", GameTooltip_Hide)
	end,

	OnHide = function(self)
		GameTooltip:Hide()
		if self.itemLinkText then
			self.itemLinkText:SetText("")
		end
	end,

	OnAccept = function(self, data)
		if not data then
			return
		end

		local info = C_Container.GetContainerItemInfo(data.bag, data.slot)
		if not info or info.itemID ~= data.itemID then
			print(CDMSND_WAR3_ERROR)	-- item was moved
			return
		end

		C_Container.PickupContainerItem(data.bag, data.slot)

		if CursorHasItem() then
			DeleteCursorItem()
		end
	end,
}

SlashCmdList["CHEAPDESTROY"] = function()
	local item = FindCheapestItem()

	if not item or not item.itemLink then
		print(CDMSND_WAR3_ERROR)
		return
	end

	local popup = StaticPopup_Show("CHEAP_DESTROY_CONFIRM", nil, nil, item)
end

SLASH_CHEAPDESTROY1 = "/di"
SLASH_CHEAPDESTROY2 = "/вш"