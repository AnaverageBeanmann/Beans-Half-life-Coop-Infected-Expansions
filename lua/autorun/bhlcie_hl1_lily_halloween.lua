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
local AutorunFile = "autorun/bhlcie_hl1_lily_halloween.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")

if VJExists == true then

	include('autorun/vj_controls.lua') -- do we need this?

	/*
	
		- Added The Follower
		- Added The Shepherd
		- Added more props, mainly outside the Offices.
		- Michael now has no collision while fleeing and hiding, and also won't enter hunt mode if he's inside something in an an attempt to help with him getting stuck on everything.
		- Added a lot more items to the Church.
		- Thriller's intro is shorter and it is now a wave song.
		- Added the Ghostbusters Theme as a wave song.
		- Added Bustin' as a wave song.
		- Snake Eyes now loops once before ending.
	
		- Updated Michael's hunt mode. If Michael is in hunt mode for about a minute or so and hasn't found anyone, he'll be told where everyone is.
		- If Michael is stuck somewhere and can't get out on his own, he'll be teleported away to one of his start positions. - maybe add more spots?
		- Michael now has no collision while fleeing and hiding, and won't go back into hunt mode if he's inside something. This should hopefully reduce the chances of him getting stuck on props and stuff. - do we really need this?
		- Reduced Michaels base hp to 100.
		- Reduced Michaels re-hunt health increase bonus to 0.10 per flee.
		- Michael now spawns near the portal to HERESY.
		- Cars now give fuel.
		- Barrels in more risky spots now generally carry more fuel, while ones in more safe spots have less.
		- Added more items outside.
		- Moved the Tau Cannon in HERESY and also added more items in there.
		- Added items to the abandoned offices.
		- Increased the time between waves.
		- Waves now last for three minutes instead of four.
		- Added a zombie spawn to the furnace room.
		- Added another music set. You can change between it and the FAITH pack with 'hl1_coop_sv_bhlcie_lilyhalloween_music' before the match starts.
		- Made the FAITH music quieter.
		- Froze the table and boxes blocking the door to a specific abandoned offices room.
		- Fixed floaters.
		
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
		DrVrej: Creator of VJ Base.
		Valve Corperation: Any and all Half-Life assets.
		Airdorf Games: Any and all Faith: The Unholy Trinity assets, including Michael's voice clips and all music from the game.
		Vatra Games: Silent Hill Downpour's Bogeyman, used for The Follower.
		Omi-Box: Original Rake texture used for Michael Davies.
		Warkin Iskander Volselli: Folley sounds used for The Follower, animations used for Horrors, Beta Half-Life Stalker, and playtesting.
		Comrade Blue, Lebert130, Imaya: Playtesting and giving feedback.

The Followers footsteps were taken from the Resident Evil 2 Remake.
Cultist model from here ( https://steamcommunity.com/sharedfiles/filedetails/?id=1380429026 )
Horror and Erectus's sounds from Ghouls Forest 3.
Wretch and Preachers models from Get a Life.
Erectus's animations and some sounds for it are from Cry of Fear.
Horror's model taken from LNR.

		-=< Music Credits >=-
		Yoko Shimomura: Any and all music from Kingdom Hearts 1.
		quivel: Snake Eyes (https://youtu.be/KLv9PMEkvs8).
		Ray Parker Jr.: Ghostbusters Theme.
		Neil Cicierega: Bustin.
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
		Heaven Pierce Her: Altars of Apostasy.
		Andrew Hulshult: Any and all music from DUSK.
		And anyone else I forgot to mention.
		
		
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
- Spawns when the escape panel is activated
- Arrival is marked by the church bell ringing 3-6 times
- Father Grigori but fucked up and evil
- Gun shoots projectiles instead of being hitscan
- Can be killed

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
	VJ.AddNPC("Michael Davies","npc_bhlcie_michael",vCat) -- please make him have no collision when fleeing/hiding so he stops getting stuck on doors or whatever, thanks
	VJ.AddNPC("The Follower","npc_bhlcie_follower",vCat)
	VJ.AddNPC("The Shepherd","npc_bhlcie_shepherd",vCat)


	-- basic bitches for holdout
	VJ.AddNPC("Cultist","npc_bhlcie_cultist",vCat)

	VJ.AddNPC("Erectus","npc_bhlcie_erectus",vCat)
	-- giant skeleton
	-- basically works like a cof taller

	VJ.AddNPC("Wretch","npc_bhlcie_wretch",vCat)
		-- Antlion

	VJ.AddNPC("Preacher","npc_bhlcie_preacher",vCat)
		-- get a life priest zombie
		-- talks in backwards grigori
		-- summons demons and pillars of flames under his enemies

	VJ.AddNPC("Stalker","npc_bhlcie_stalker",vCat)
		-- If it's being looked at, it goes transparent and can't be hurt
		-- If not being looked at, it goes faster, non-transparent, and can be hurt

	-- VJ.AddNPC("Thrall","npc_bhlcie_thrall",vCat)
		-- Red Civvies
		-- Melee Enemy
	VJ.AddNPC("Horror","npc_bhlcie_horror",vCat)
		-- explosive poison zombie
		-- attacks by blowing itself up
		-- voice actor: sjas
	/*
	VJ.AddNPC("IT","npc_bhlcie_it",vCat)
	VJ.AddNPC("Phantom","npc_bhlcie_phantom",vCat)

	Monster Mash
	-- Solid Ideas
		VJ.AddNPC("Zombie","npc_bhlcie_monster_",vCat)
		-- Basic melee npc, tries to claw at you
		-- Voice actor: cancer
		VJ.AddNPC("Skeleton","npc_bhlcie_monster_",vCat)
		-- Basic melee npc, tries to beat you to death with his boner
		-- Voice actor: doot skeleton and dry bones
		VJ.AddNPC("Mummy","npc_bhlcie_monster_",vCat)
		-- Basic melee npc, slows you down on hit
		-- Voice actor: husk(?) from minecraft (the desert zombie)
		VJ.AddNPC("Deer Haunter","npc_bhlcie_monster_",vCat)
		-- Acts like a fast zombie
		-- Voice actor: l4d2 charger?
		VJ.AddNPC("Banshee","npc_bhlcie_monster_",vCat)
		-- Runs up near you and screams, dealing aeo damage
		-- Voice actor: l4d witch
		VJ.AddNPC("Vampire","npc_bhlcie_monster_",vCat)
		-- Pops out of nowhere close by, runs up and sucks your blood (grabs you)
		VJ.AddNPC("Frankenstein's Monster","npc_bhlcie_monster_",vCat)
		-- literally just a meathead from yakuza dead souls, same voice actor and all
		VJ.AddNPC("Guest","npc_bhlcie_monster_",vCat)
		-- Has a gun
		-- Voice actor: quake skeleton (forgot name)
		VJ.AddNPC("Scarecrow","npc_bhlcie_monster_",vCat)
		-- Has a shotgun
		-- Summons crows to swarm you when he dies
		-- Voice actor: DUSK scarecrow
	-- Maybe?
		VJ.AddNPC("Mad Scientist","npc_bhlcie_monster_",vCat)
		-- throws acid vials
		VJ.AddNPC("Invisible Man","npc_bhlcie_monster_",vCat)
		-- involve invisibility somehow
	-- Probably Not
	VJ.AddNPC("Witch","npc_bhlcie_monster_",vCat)
	VJ.AddNPC("Nosferatu","npc_bhlcie_monster_",vCat)
	VJ.AddNPC("Headless Horseman","npc_bhlcie_monster_",vCat)
	VJ.AddNPC("Bride","npc_bhlcie_monster_",vCat)
	VJ.AddNPC("Bloody Mary","npc_bhlcie_monster_",vCat)
	VJ.AddNPC("Lagoon Creature","npc_bhlcie_monster_",vCat)

	






	VJ.AddNPC("Glutton","npc_bhlcie_glutton",vCat)
		-- obese

	VJ.AddNPC("Bloody Bones","npc_bhlcie_b0ner_frenzy",vCat)


	VJ.AddNPC("Wisp","npc_bhlcie_thrall",vCat)
	VJ.AddNPC("Vesselbine","npc_bhlcie_thrall",vCat)
	VJ.AddNPC("Vessel","npc_bhlcie_thrall",vCat)
	*/

	VJ.AddConVar("hl1_coop_sv_bhlcie_lilyhalloween_enemies", 0, {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "This ConVar replaces the enemies on the config for the map 'GM_HL1_Lily_Halloween'. Type 'hl1_coop_sv_bhlcie_lilyhalloween_enemies_printsetups' to see all the setups.")
	VJ.AddConVar("hl1_coop_sv_bhlcie_lilyhalloween_music", 0, {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "This ConVar replaces the music on the config for the map 'GM_HL1_Lily_Halloween'. This needs to be changed before the match starts to take effect. 'hl1_coop_sv_bhlcie_lilyhalloween_music 1' will change it to music from Faith: The Unholy Trinity, otherwise it'll play a mishmash of music I liked.")

	local enemysetups = {
		["NPC Pack Name || Command to use Setup"] = "null.wav",
		-- ["Difficulties from Easiest to Hardest: Easy, Medium, Hard, Very Hard, Hell"] = "null.wav",
		["[Half-Life Coop: Infected] || hl1_coop_sv_bhlcie_lilyhalloween_enemies 0"] = "null.wav",
		["[Resident Evil: Cold Blood] || hl1_coop_sv_bhlcie_lilyhalloween_enemies 1"] = "null.wav",
	}

	if CLIENT then
		concommand.Add("hl1_coop_sv_bhlcie_lilyhalloween_enemies_printsetups", function(ply)
			for k, v in SortedPairs(enemysetups) do
				ply:PrintMessage(HUD_PRINTCONSOLE, k.."\n")
			end
		end)
	end

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