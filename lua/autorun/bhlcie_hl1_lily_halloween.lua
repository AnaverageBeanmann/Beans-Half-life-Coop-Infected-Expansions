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

	include('autorun/vj_controls.lua') -- do we need this?

	/*
		- Updated Michael's hunt mode. If Michael is in hunt mode for about a minute or so and hasn't found anyone, he'll be told where everyone is.
		- If Michael is stuck somewhere and can't get out on his own, he'll be teleported away to one of his start positions. [TBD]
		- Michael now has no collision while fleeing and hiding, and won't go back into hunt mode if he's inside something. This should hopefully reduce the chances of him getting stuck on props and stuff. [TBD] - do we really need this?
		- Reduced Michaels base hp to 100.
		- Reduced Michaels re-hunt health increase bonus to 0.10 per flee.
		- Michael now spawns near the portal to HERESY.
		- Cars now give fuel.
		- Barrels in more risky spots now generally carry more fuel, while ones in more safe spots have less.
		- Added more items outside. [TBD]
		- Moved the Tau Cannon in HERESY and also added more items in there.
		- Added items to the abandoned offices.
		- Increased the time between waves.
		- Waves now last for three minutes instead of four.
		- Added a zombie spawn to the furnace room. [TBD]
		- Added another music set. You can change between it and the FAITH pack with 'hl1_coop_sv_bhlcie_lilyhalloween_music' before the match starts.
		- Made the FAITH music quieter. [TBD]
		- Froze the table and boxes blocking the door to a specific abandoned offices room.
		- Fixed floaters. [TBD]
		
		music for new pack
		
		intro
		https://youtu.be/nc1YgQXuP0E (kingdom hearts halloween town calm)

		waves
		https://youtu.be/K2rwxs1gH9w (spooky scary skeletons)
		https://youtu.be/ho9rZjlsyYY (toccata and fugue in d minor/dracula music)
		https://youtu.be/TaV1r341wYk (ghostbusters theme)
		https://youtu.be/RI9YjHGuSOE (kingdom hearts halloween town battle)
		https://youtu.be/SOFCQ2bfmHw (monster mash)
		https://youtu.be/yRRqxnjslb0 (somebody's watching me)
		https://youtu.be/BoatSoGva_I (little dark age)
		https://youtu.be/lVLXNgk9uJ8 (donacdum) (maybe not)
		https://youtu.be/fhltB4DbtDo?list=PLy6lOuS_V1SqEo5An9PCYauJcPohbr4xW (the mark)
		https://youtu.be/t-9xbgTHpLA?list=PLU4ktq2pWONtSYFFHnFZPFfSXMF5Rw0fn (peper steak)
		https://youtu.be/KLv9PMEkvs8 (snake eyes)
		devil's bath boys
		https://youtu.be/iwa8ssjSajU?list=PLpoeCpd_sH6NXV6_A9CjjsfT-lGQOY6Wl (dive to the heart)
		https://youtu.be/8jB9OJJj7TU?list=PLpoeCpd_sH6NXV6_A9CjjsfT-lGQOY6Wl (scherzo de notte)
		deep blue?
		
		tf2 (rip these from files)
		https://youtu.be/AfjqL0vaBYU?list=PL4E9ABD7FF1106BD3 (haunted fortress 2)
		https://youtu.be/9QpmfOLaUcw?list=PL4E9ABD7FF1106BD3 (misfortune teller)
		
		check cry of fear, resident evil, and pizza tower soundtracks
		 
		holdout
		https://youtu.be/4BkRjWGPrSQ?list=PLU4ktq2pWONtSYFFHnFZPFfSXMF5Rw0fn (fake orchestra)
		https://youtu.be/dyOvTf2HolA?list=PLU4ktq2pWONtSYFFHnFZPFfSXMF5Rw0fn (avatar beat)
		https://youtu.be/KLv9PMEkvs8?t=113 (snake eyes combat)
		https://youtu.be/7xSUwK7uIxc?t=295 (destiny's force)
		https://youtu.be/KhdlCRXX6dw?list=PLpoeCpd_sH6NXV6_A9CjjsfT-lGQOY6Wl (fragments of sorrow)
		moonlight sonata 3rd movement?
		
		escape
		https://youtu.be/dyw6kQ5O-YA?list=PLU4ktq2pWONtSYFFHnFZPFfSXMF5Rw0fn (unreasonable behavior)
		https://youtu.be/7xSUwK7uIxc?t=463 (night of fate)
		https://youtu.be/7xSUwK7uIxc?t=719 (forze de male)
		https://youtu.be/ZEHsIcsjtdI (thriller)


		-=< Main Credits >=-
		An average Beanmann: Putting this addon together.
		Upset: Original creator of Half-Life Coop and Half-Life Coop Infected, any and all modified or adapted code used for this addon.
		Lily McFluffy Butt: Creator of the map used.
		DrVrej: Creator or VJ Base, which Michael Davies uses.
		Omi-Box: Original Rake texture used for Michael Davies.
		Airdorf Games: Any and all Faith: The Unholy Trinity assets, including Michael's voice clips and all music from the game.
		Comrade Blue, Lebert130, Imaya: Playtesting and giving feedback.

		-=< Music Credits >=-
		Yoko Shimomura: Any and all music from Kingdom Hearts 1.
		quivel: Snake Eyes (https://youtu.be/KLv9PMEkvs8).
		Ray Parker Jr.: Ghostbusters Theme.
		Bobby "Boris" Pickett & The Crypt Kickers: Monster Mash.
		Rockwell: Somebody's Watching Me.
		Andrew Gold: Spooky Scary Skeletons.
		Johann Sebastian Bach(?): Toccata and Fugue in D Minor.
		MGMT: Little Dark Age.
		Simon Viklund: The Mark.
		Alias Conrad Coldwood: Any and all music from OFF.
		Widdly 2 Diddly: Devil's Bath Boys.
		Mike Morasky: Any and all music from Team Fortress 2.
		Michael Jackson: Thriller.
		Beethoven: Moonlight Sonata 3rd Movement.
		Ronan "Mr. Sauceman" de Castel: Any and all music from Pizza Tower.
		ROPE: Any and all music from Zombie Night Terror.
		
		
		
Michael Davies
- Based off the enemy of the same name from Faith
- Wanders around topside
- If he hasn't found anyone after a minute, he will be told where everyone is
- Will announce himself with a warning sound apon seeing a target
- Can be fought off, but not killed
- When he loses his health, he runs off for a bit
- After a while of hiding, he retuns to hunt mode with increased hp

The Follower
- Silent Hill Downpour's Bogeyman with some changes
- Very high health
- Very slow, about as fast as a hl2 zombie, if not slower
- Can't be killed, but will teleport away and heal before it dies
- Will constantly follow you through the entire map
- Sometimes teleports to HERESY if it feels like it

The Shepherd
- Arrival is marked by the church bell ringing 3-6 times
- Father Grigori but fucked up and evil
- Gun shoots projectiles instead of being hitscan
- Can be killed, but will return eventually

IT
- Creature that wanders around topside, but doesn't actively attack
- Immortal
- If you attack it, it will enter a frenzy and begin attacking
- It will calm and teleport away if it hits you or enough time has passed

The Phantoms
- Ghostly Combine Stalkers
- Ambient threat in HERESY
- Slow
- Immortal
- Smites you after a few seconds aslong as your next to it
- Has no collision, so you and enemies can just walk through it
	
	
	
	
	*/

		local vCat = "BHLCIE"
	VJ.AddNPC("Michael Davies","npc_bhlcie_michael",vCat)
	/*
	VJ.AddNPC("The Follower","npc_bhlcie_follower",vCat)
	VJ.AddNPC("The Shepherd","npc_bhlcie_shepherd",vCat)
	VJ.AddNPC("IT","npc_bhlcie_it",vCat)
	VJ.AddNPC("Phantom","npc_bhlcie_phantom",vCat)
	*/

	VJ.AddConVar("hl1_coop_sv_bhlcie_lilyhalloween_enemies", 0, {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "This ConVar replaces the enemies on the config for the map 'GM_HL1_Lily_Halloween'. Type 'hl1_coop_sv_bhlcie_lilyhalloween_enemies_printsetups' to see all the setups.")
	VJ.AddConVar("hl1_coop_sv_bhlcie_lilyhalloween_music", 0, {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "This ConVar replaces the music on the config for the map 'GM_HL1_Lily_Halloween'. This needs to be changed before the match starts to take effect. 'hl1_coop_sv_bhlcie_lilyhalloween_music 1' will change it to music from Faith: The Unholy Trinity, otherwise it'll play a mishmash of music I liked.")

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