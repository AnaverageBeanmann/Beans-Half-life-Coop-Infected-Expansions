/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Bean's Half-Life Coop Infected Expansions"
local AddonName = "Bean's Half-Life Coop Infected Expansions"
local AddonType = "Convars"
local AutorunFile = "autorun/bhlcia.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")

if VJExists == true then

	include('autorun/vj_controls.lua')

		local vCat = "Animals"
	VJ.AddNPC("Michael Davies","npc_bhlcie_michael",vCat)

	VJ.AddConVar("hl1_coop_sv_bhlcie_lilyhalloween_enemies", 0, {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "This ConVar replaces the enemies on the config for the map 'GM_HL1_Lily_Halloween'. Type 'hl1_coop_sv_bhlcie_lilyhalloween_enemies_printsetups' to see all the setups.")

	local enemysetups = {
		["NPC Pack Name || Setup Name || Command to use Setup || Difficulty"] = "null.wav",
		["Difficulties from Easiest to Hardest: Easy, Medium, Hard, Very Hard, Hell"] = "null.wav",
		["[Half-Life Resurgence: GoldSrc] || Half-Life 1 || hl1_coop_sv_customenemies_enemysetup 1 || Difficulty - N/A"] = "null.wav",
	}

-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end