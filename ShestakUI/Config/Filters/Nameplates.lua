local T, C, L = unpack(ShestakUI)
if C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Polymorph -> http://www.wowhead.com/spell=118
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		print("|cffff0000ShestakUI: Nameplates spell ID ["..tostring(id).."] no longer exists!|r")
		return "Empty"
	end
end

T.DebuffWhiteList = {
	-- Druid
	[5211] = true,	-- Bash
	[16922] = true,	-- Celestial Focus (Starfire Stun)
	[5209] = true,	-- Challenging Roar
	[99] = true,		-- Demoralizing Roar
	[339] = true,	-- Entangling Roots
	-- [19975] = true,	-- Entangling Roots (Nature's Grasp)
	[770] = true,	-- Faerie Fire
	[16857] = true,	-- Faerie Fire (Feral)
	[19675] = true,	-- Feral Charge Effect
	[2637] = true,	-- Hibernate
	-- [16914] = true,	-- Hurricane
	[5570] = true,	-- Insect Swarm
	[414644] = true,	-- Lacerate [Season of Discovery]
	[407995] = true,	-- Mangle (Bear) [Season of Discovery]
	[407993] = true,	-- Mangle (Cat) [Season of Discovery]
	[8921] = true,	-- Moonfire
	[9005] = true,	-- Pounce
	[9007] = true,	-- Pounce Bleed
	[1822] = true,	-- Rake
	[1079] = true,	-- Rip
	[2908] = true,	-- Soothe Animal
	[414684] = true,	-- Sunfire [Season of Discovery]
	-- [414687] = true,	-- Sunfire (Bear) [Season of Discovery]
	-- [414689] = true,	-- Sunfire (Cat) [Season of Discovery]

	-- Hunter
	-- [1462] = true,	-- Beast Lore
	[3674] = true,	-- Black Arrow
	[25999] = true,	-- Charge (Boar)
	[409495] = true,	-- Chimera Shot - Scorpid [Season of Discovery]
	[5116] = true,	-- Concussive Shot
	[19306] = true,	-- Counterattack
	[19185] = true,	-- Entrapment
	[409552] = true,	-- Explosive Shot [Season of Discovery]
	[13812] = true,	-- Explosive Trap Effect
	[409507] = true,	-- Expose Weakness [Season of Discovery]
	[1543] = true,	-- Flare
	[3355] = true,	-- Freezing Trap Effect
	[13810] = true,	-- Frost Trap Aura
	[1130] = true,	-- Hunter's Mark
	[13797] = true,	-- Immolation Trap Effect
	[19410] = true,	-- Improved Concussive Shot
	[19229] = true,	-- Improved Wing Clip
	[24394] = true,	-- Intimidation
	[444678] = true,	-- Lava Breath [Season of Discovery]
	[1513] = true,	-- Scare Beast
	[19503] = true,	-- Scatter Shot
	[24640] = true,	-- Scorpid Poison (Scorpid)
	[3043] = true,	-- Scorpid Sting
	[24423] = true,	-- Screech (Bat / Bird of Prey / Carrion Bird)
	[1978] = true,	-- Serpent Sting
	[3034] = true,	-- Viper Sting
	[2974] = true,	-- Wing Clip
	[19386] = true,	-- Wyvern Sting

	-- Mage
	[11113] = true,	-- Blast Wave
	-- [10] = true,	-- Blizzard
	-- [12484] = true,	-- Chilled (Blizzard)
	[6136] = true,	-- Chilled (Frost Armor)
	-- [7321] = true,	-- Chilled (Ice Armor)
	[120] = true,	-- Cone of Cold
	[18469] = true,	-- Counterspell - Silenced
	[428739] = true,	-- Deep Freeze [Season of Discovery]
	[133] = true,	-- Fireball
	[22959] = true,	-- Fire Vulnerability (Improved Scorch)
	[2120] = true,	-- Flamestrike
	[122] = true,	-- Frost Nova
	[12494] = true,	-- Frostbite
	[116] = true,	-- Frostbolt
	[401502] = true,	-- Frostfire Bolt [Season of Discovery]
	[12654] = true,	-- Ignite
	[12355] = true,	-- Impact
	[400613] = true,	-- Living Bomb [Season of Discovery]
	-- [401558] = true,	-- Living Flame [Season of Discovery]
	[118] = true,	-- Polymorph
	[11366] = true,	-- Pyroblast
	[412532] = true,	-- Spellfrost Bolt [Season of Discovery]
	[12579] = true,	-- Winter's Chill

	-- Paladin
	[407669] = true,	-- Avenger's Shield [Season of Discovery]
	[26573] = true,	-- Consecration
	[853] = true,	-- Hammer of Justice
	[407631] = true,	-- Hand of Reckoning [Season of Discovery]
	[20184] = true,	-- Judgement of Justice
	[20185] = true,	-- Judgement of Light
	[20186] = true,	-- Judgement of Wisdom
	[21183] = true,	-- Judgement of the Crusader
	[20066] = true,	-- Repentance
	[20170] = true,	-- Seal of Justice (Stun)
	[2878] = true,	-- Turn Undead
	[67] = true,		-- Vindication

	-- Priest
	[15269] = true,	-- Blackout
	[402808] = true,	-- Cripple (Homunculi) [Season of Discovery]
	[402792] = true,	-- Curse of the Elements (Eye of the Void) [Season of Discovery]
	[402791] = true,	-- Curse of Shadow (Eye of the Void) [Season of Discovery]
	[402794] = true,	-- Curse of Tongues (Eye of the Void) [Season of Discovery]
	[402818] = true,	-- Degrade (Homunculi) [Season of Discovery]
	[402811] = true,	-- Demoralize (Homunculi) [Season of Discovery]
	[2944] = true,	-- Devouring Plague
	[9035] = true,	-- Hex of Weakness
	[14914] = true,	-- Holy Fire
	[605] = true,	-- Mind Control
	[15407] = true,	-- Mind Flay
	[413259] = true,	-- Mind Sear [Season of Discovery]
	[453] = true,	-- Mind Soothe
	[2096] = true,	-- Mind Vision
	[8122] = true,	-- Psychic Scream
	[9484] = true,	-- Shackle Undead
	[15258] = true,	-- Shadow Vulnerability (Shadow Weaving)
	[589] = true,	-- Shadow Word: Pain
	[15487] = true,	-- Silence
	[10797] = true,	-- Starshards
	[2943] = true,	-- Touch of Weakness
	[15286] = true,	-- Vampiric Embrace
	[425204] = true,	-- Void Plague [Season of Discovery]
	[431681] = true,	-- Void Zone [Season of Discovery]

	-- Rogue
	[439473] = true,	-- Atrophic Poison [Season of Discovery]
	[400009] = true,	-- Between the Eyes [Season of Discovery]
	[2094] = true,	-- Blind
	[1833] = true,	-- Cheap Shot
	[3409] = true,	-- Crippling Poison
	[2818] = true,	-- Deadly Poison
	[8647] = true,	-- Expose Armor
	[703] = true,	-- Garrote
	[1776] = true,	-- Gouge
	[16511] = true,	-- Hemorrhage
	[18425] = true,	-- Kick - Silenced
	[408] = true,	-- Kidney Shot
	[5760] = true,	-- Mind-numbing Poison
	[439472] = true,	-- Numbing Poison [Season of Discovery]
	[398196] = true,	-- Quick Draw [Season of Discovery]
	[14251] = true,	-- Riposte
	[1943] = true,	-- Rupture
	[424785] = true,	-- Saber Lash [Season of Discovery]
	[6770] = true,	-- Sap
	[439471] = true,	-- Sebacious Poison [Season of Discovery]
	[415725] = true,	-- Waylay [Season of Discovery]
	[13218] = true,	-- Wound Poison

	-- Shaman
	[3600] = true,	-- Earthbind
	[408681] = true,	-- Earth Shock (Way of Earth) [Season of Discovery]
	[8050] = true,	-- Flame Shock
	[8056] = true,	-- Frost Shock
	[8034] = true,	-- Frostbrand Attack
	[17364] = true,	-- Stormstrike

	-- Warlock
	[18118] = true,	-- Aftermath
	[710] = true,	-- Banish
	[172] = true,	-- Corruption
	[20812] = true,	-- Cripple (Doomguard)
	[980] = true,	-- Curse of Agony
	[603] = true,	-- Curse of Doom
	[18223] = true,	-- Curse of Exhaustion
	[1010] = true,	-- Curse of Idiocy
	[704] = true,	-- Curse of Recklessness
	[17862] = true,	-- Curse of Shadow
	[1714] = true,	-- Curse of Tongues
	[702] = true,	-- Curse of Weakness
	[1490] = true,	-- Curse of the Elements
	[6789] = true,	-- Death Coil
	[412789] = true,	-- Demonic Howl (Metamorphosis) [Season of Discovery]
	[689] = true,	-- Drain Life
	[5138] = true,	-- Drain Mana
	[1120] = true,	-- Drain Soul
	[1098] = true,	-- Enslave Demon
	[5782] = true,	-- Fear
	[403501] = true,	-- Haunt [Season of Discovery]
	[5484] = true,	-- Howl of Terror
	[348] = true,	-- Immolate
	[412758] = true,	-- Incinerate [Season of Discovery]
	-- [403650] = true,	-- Lake of Fire [Season of Discovery]
	[403828] = true,	-- Menace (Metamorphosis) [Season of Discovery]
	[18093] = true,	-- Pyroclasm
	-- [5740] = true,	-- Rain of Fire
	[6358] = true,	-- Seduction (Succubus)
	[426325] = true,	-- Shadowflame [Season of Discovery]
	[17794] = true,	-- Shadow Vulnerability (Improved Shadow Bolt)
	[18265] = true,	-- Siphon Life
	[24259] = true,	-- Spell Lock (Felhunter)
	[21949] = true,	-- Rend (Doomguard)
	[19479] = true,	-- Tainted Blood Effect (Felhunter)
	[427717] = true,	-- Unstable Affliction [Season of Discovery]
	-- [427719] = true,	-- Unstable Affliction (Silence) [Season of Discovery]

	-- Warrior
	[1161] = true,	-- Challenging Shout
	[7922] = true,	-- Charge Stun
	[12809] = true,	-- Concussion Blow
	[1160] = true,	-- Demoralizing Shout
	[676] = true,	-- Disarm
	[1715] = true,	-- Hamstring
	[23694] = true,	-- Improved Hamstring
	[20253] = true,	-- Intercept Stun
	[20511] = true,	-- Intimidating Shout (Cower)
	[5246] = true,	-- Intimidating Shout (Fear)
	[694] = true,	-- Mocking Blow
	[12294] = true,	-- Mortal Strike
	[12323] = true,	-- Piercing Howl
	[772] = true,	-- Rend
	[12798] = true,	-- Revenge Stun
	[18498] = true,	-- Shield Bash - Silenced
	[7386] = true,	-- Sunder Armor
	[6343] = true,	-- Thunder Clap

	-- Mace Specialization
	[5530] = true,	-- Mace Stun Effect (Rogue / Warrior)

	-- Racial
	[20549] = true,	-- War Stomp
}

for _, spell in pairs(C.nameplate.debuffs_list) do
	T.DebuffWhiteList[spell] = true
end

T.DebuffBlackList = {
	-- [spellID] = true,	-- Spell Name
}

for _, spell in pairs(C.nameplate.ignore_list) do
	T.DebuffBlackList[spell] = true
end

T.BuffWhiteList = {
	-- [SpellName(226510)] = true,	-- Sanguine Ichor
}

for _, spell in pairs(C.nameplate.buffs_list) do
	T.BuffWhiteList[SpellName(spell)] = true
end

T.BuffBlackList = {
	-- [SpellName(spellID)] = true,	-- Spell Name
}

T.PlateBlacklist = {
	["24207"] = true,	-- Army of the Dead
	["29630"] = true,	-- Fanged Pit Viper (Gundrak)
	["55659"] = true,	-- Wild Imp
	["167966"] = true,	-- Experimental Sludge (De Other Side)
}

T.InterruptCast = { -- Yellow border for interruptible cast
	-- The War Within Season 1
	[461904] = true,	-- Cosmic Ascension
	[462508] = true,	-- Dark Prayer
	-- Algeth'ar Academy
	[396812] = true,	-- Mystic Blast
	[332612] = true,	-- Healing Touch
	[377389] = true,	-- Call of the Flock
	[387843] = true,	-- Astral Bomb
	-- The Azure Vault
	[370225] = true,	-- Shriek
	-- The Nokhud Offensive
	[386024] = true,	-- Tempest
	[373395] = true,	-- Bloodcurdling Shout
	-- Halls of Valor
	[215433] = true,	-- Holy Radiance
	-- Shadowmoon Burial Grounds
	[152818] = true,	-- Shadow Mend
	-- Temple of the Jade Serpent
	[395859] = true,	-- Haunting Scream
}

T.ImportantCast = { -- Red border for non-interruptible cast
	-- The Nokhud Offensive
	[383823] = true,	-- Rally the Clan
	-- Ruby Life Pools
	[372743] = true,	-- Ice Shield
	-- Court of Stars
	[210261] = true,	-- Sound Alarm
}

for _, spell in pairs(C.nameplate.cast_color_list) do
	T.InterruptCast[spell] = true
end

local color = C.nameplate.mob_color
local color_alt = C.nameplate.mob_color_alt
T.ColorPlate = {
	-- Midnight
	["caster"] = color,			-- All caster mobs
	["miniboss"] = color_alt,	-- All miniboss
	-- Algeth'ar Academy
	["196548"] = color,			-- Ancient Branch
	-- The Azure Vault
	["187159"] = color_alt,		-- Shrieking Whelp
	-- The Nokhud Offensive
	["194894"] = color,			-- Primalist Stormspeaker
	-- Temple of the Jade Serpent
	["59555"] = color,			-- Haunting Sha
	["59545"] = color,			-- The Golden Beetle
	-- Court of Stars
	["104251"] = color_alt,		-- Duskwatch Sentry
	-- PvP
	["5925"] = color,			-- Grounding Totem
}

for word in gmatch(C.nameplate.mob_color_list, "%S+") do
	T.ColorPlate[tostring(word)] = color
end

for word in gmatch(C.nameplate.mob_color_alt_list, "%S+") do
	T.ColorPlate[tostring(word)] = color_alt
end

T.ShortNames = {
	-- Академия Алгет'ар
	["Рассерженная стрекотуха"] = "Cтрекотуха",
	["Мерзкий плеточник"] = "Плеточник",
	["Алгет'арский охранник"] = "Охранник",
	["Алгет'арский рыцарь эха"] = "Рыцарь",
	["Алгет'арская заклинательница"] = "Заклинательница",
	["Алгет'арский целитель"] = "Целитель",
	-- Наступление клана Нокхуд
	["Мастер копья из клана Нокхуд"] = "Мастер копья",
	["Лучница из клана Нокхуд"] = "Лучница",
	["Боевое копье клана Нокхуд"] = "Копье",
	["Трубач из клана Нокхуд"] = "Трубач",
	["Нокхудский копейщик"] = "Копейщик",
	["Громовой кулак из клана Нокхуд"] = "Кулак",
	["Псарь из клана Нокхуд"] = "Псарь",
	["Заступник из клана Нокхуд"] = "Заступник",
	-- Квартал Звезд
	["Караульный из Сумеречной стражи"] = "Караульный",
	["Часовой из Сумеречной стражи"] = "Часовой",
	["Бдительный инквизитор"] = "Инквизитор",
	["Пылающий бес"] = "Бес",
	["Порабощенная Скверной карательница"] = "Карательница",
}