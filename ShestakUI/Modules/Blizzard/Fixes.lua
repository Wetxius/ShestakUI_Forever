local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Fix DeclensionFrame strata
----------------------------------------------------------------------------------------
if T.client == "ruRU" then
	_G["DeclensionFrame"]:SetFrameStrata("HIGH")
end

----------------------------------------------------------------------------------------
--	Fix ShouldShowMawBuffs taint
----------------------------------------------------------------------------------------
local orig = ShouldShowMawBuffs
ShouldShowMawBuffs = function()
    if C_Secrets.ShouldAurasBeSecret() then return false end

    return orig()
end

----------------------------------------------------------------------------------------
--	Fix blizzard ui error (from NDui)
----------------------------------------------------------------------------------------
local old_SetupTextureCoordinates = BackdropTemplateMixin.SetupTextureCoordinates
function BackdropTemplateMixin:SetupTextureCoordinates()
	local width = self:GetWidth()
	if T.IsSecretValue(width) then return end
	old_SetupTextureCoordinates(self)
end