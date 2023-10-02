AddCSLuaFile("shared.lua")
include("shared.lua")

local cvar_infect = CreateConVar("hl1_coop_sv_infectplayers", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Allow zombies to infect players")

local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua", "GAME")

ENT.ZombieType = 0
ENT.SpawnFreq = 1

function ENT:Initialize()
	self:SetTrigger(true)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self:SetNotSolid(true)
	self:DrawShadow(false)
	
	self.SpawnedNPCs = {}
	self:NextThink(CurTime() + 15)
	self.MaxNPCs = 1
	
	if !VJExists then
		self.ChatSpam = true
		self:NextThink(CurTime() + 5)
	end
end

local CustomNPCPointsTable = {
	["npc_bhlcie_cultist"]	= 25, -- Cultist
	["npc_bhlcie_wretch"]	= 45, -- Wretch
	["npc_bhlcie_erectus"]	= 75, -- Erectus
	["npc_bhlcie_horror"]	= 50, -- Horror
	["npc_bhlcie_stalker"]	= 50, -- Stalker
	["npc_bhlcie_preacher"]	= 50, -- Preacher
	["npc_bhlcie_shepherd"]	= 666, -- Shepherd

	---- -=< Resident Evil: Cold Blood >=-
		---- Standard Zombies
	["npc_vj_recb_zombie_male"]	= 25, -- Male Zombie
	["npc_vj_recb_zombie_resear"] = 25, -- Researcher Zombie
	["npc_vj_recb_zombie_priest"] = 30, -- Priest Zombie
	["npc_vj_recb_zombie_female"] = 25, -- Female Zombie
	["npc_vj_recb_zombie_soldier"] = 30, -- Soldier Zombie
	["npc_vj_recb_zombie_torso"] = 20, -- Zombie Torso
	["npc_vj_recb_crimsonhead"] = 50, -- Crimson Head
	["npc_vj_recb_crimsonhead_resear"] = 50, -- Researcher Crimson Head

	["npc_vj_recbb1_zombie_male"] = 25, -- Male Zombie (Beta 1)
	["npc_vj_recbb1_zombie_female"] = 25, -- Female Zombie (Beta 1)
	["npc_vj_recbb1_zombie_torso"] = 20, -- Zombie Torso (Beta 1)
	["npc_vj_recbb1_zombie_hunk"] = 35, -- Hunk Zombie
		
		---- Zombified/Mutant Animals
	["npc_vj_recb_cerberus"] = 40, -- Cerberus
	["npc_vj_recbb3_cerberus"] = 40, -- Cerberus (Beta 3)
	["npc_vj_recb_crow"] = 25, -- Crow
	["npc_vj_recb_snake"] = 25, -- Snake
	["npc_vj_recb_neptune"] = 50, -- Neptune
	["npc_vj_recb_ant"] = 80, -- Ant
	["npc_vj_recb_crawler"] = 65, -- Crawler
	["npc_vj_recb_spider_baby"] = 1, -- Baby Spider
	["npc_vj_recb_spider_small"] = 70, -- Small Spider
	["npc_vj_recb_spider_giant"] = 100, -- Giant Spider
	["npc_vj_recb_spider_blacktiger"] = 1000, -- Black Tiger Spider

		---- B.O.W.s/Bioweapons
	["npc_vj_recb_tyrant"] = 100, -- Tyrant-103
	["npc_vj_recb_flyclaw"] = 40, -- Flyclaw
	["npc_vj_recb_pursuer"] = 40, -- Pursuer
	["npc_vj_recb_hunter"] = 50, -- Hunter
	["npc_vj_recbb3_hunter"] = 50, -- Hunter (Beta 3)
	["npc_vj_recb_licker"] = 50, -- Licker
	["npc_vj_recb_prototyrant"] = 1000, -- Proto-Tyrant
}

hook.Add("Initialize", "HLCoop_NPCScore", function()
	table.Merge(GAMEMODE.NPCScorePrice, CustomNPCPointsTable)
	-- table.Merge(GAMEMODE.NPCScorePriceDamageMul, CustomNPCPointsTable_DM)
end)

local zombieType = {


/*
	keep this for reference
	[1] = {"npc_vj_lnhls_scientist"},
	[2] = {"npc_vj_lnhls_barney"},
	[3] = {"npc_vj_lnhls_hev"},
	[4] = {"npc_vj_lnhls_grunt"},
	[5] = {"npc_vj_lnhls_assassin"},
	[6] = {"npc_vj_lnhls_blackops"},
	[7] = {"npc_vj_lnhls_gman"},
	[8] = {"npc_vj_lnhls_gordon"},
	[9] = {"npc_vj_lnhls_gina"},
	[10] = {"npc_vj_lnhls_scientist", "npc_vj_lnhls_barney"},
	[11] = {"npc_vj_lnhls_scientist", "npc_vj_lnhls_hev"},
	[12] = {"npc_vj_lnhls_scientist", "npc_vj_lnhls_barney", "npc_vj_lnhls_hev"},
	[13] = {"npc_vj_lnhls_blackops", "npc_vj_lnhls_assassin"},
	[14] = {"npc_vj_lnhls_blackops", "npc_vj_lnhls_assassin", "npc_vj_lnhls_grunt"},
	[15] = {"npc_vj_lnhls_scientist", "npc_vj_lnhls_barney", "npc_vj_lnhls_grunt"}
*/

	-- Resident Evil: Cold Blood
	[1] = {
		"npc_vj_recb_zombie_male",
		"npc_vj_recb_zombie_resear",
		"npc_vj_recb_zombie_resear",
		"npc_vj_recb_zombie_soldier",
		"npc_vj_recb_zombie_soldier",
		"npc_vj_recb_zombie_torso",
	},
}
local healthTable = {
	---- -=< Resident Evil: Cold Blood >=-
		---- Standard Zombies
	["npc_vj_recb_zombie_male"]	= 150, -- Male Zombie
	["npc_vj_recb_zombie_resear"] = 150, -- Researcher Zombie
	["npc_vj_recb_zombie_priest"] = 150, -- Priest Zombie
	["npc_vj_recb_zombie_female"] = 150, -- Female Zombie
	["npc_vj_recb_zombie_soldier"] = 175, -- Soldier Zombie
	["npc_vj_recb_zombie_torso"] = 100, -- Zombie Torso
	["npc_vj_recb_crimsonhead"] = 250, -- Crimson Head
	["npc_vj_recb_crimsonhead_resear"] = 250, -- Researcher Crimson Head

	["npc_vj_recbb1_zombie_male"] = 150, -- Male Zombie (Beta 1)
	["npc_vj_recbb1_zombie_female"] = 150, -- Female Zombie (Beta 1)
	["npc_vj_recbb1_zombie_torso"] = 100, -- Zombie Torso (Beta 1)
	["npc_vj_recbb1_zombie_hunk"] = 200, -- Hunk Zombie
		
		---- Zombified/Mutant Animals
	["npc_vj_recb_cerberus"] = 60, -- Cerberus
	["npc_vj_recbb3_cerberus"] = 60, -- Cerberus (Beta 3)
	["npc_vj_recb_crow"] = 30, -- Crow
	["npc_vj_recb_snake"] = 30, -- Snake
	["npc_vj_recb_neptune"] = 500, -- Neptune
	["npc_vj_recb_ant"] = 200, -- Ant
	["npc_vj_recb_crawler"] = 200, -- Crawler
	["npc_vj_recb_spider_baby"] = 5, -- Baby Spider
	["npc_vj_recb_spider_small"] = 150, -- Small Spider
	["npc_vj_recb_spider_giant"] = 300, -- Giant Spider
	["npc_vj_recb_spider_blacktiger"] = 1500, -- Black Tiger Spider

		---- B.O.W.s/Bioweapons
	["npc_vj_recb_tyrant"] = 2000, -- Tyrant-103
	["npc_vj_recb_flyclaw"] = 250, -- Flyclaw
	["npc_vj_recb_pursuer"] = 300, -- Pursuer
	["npc_vj_recb_hunter"] = 250, -- Hunter
	["npc_vj_recbb3_hunter"] = 250, -- Hunter (Beta 3)
	["npc_vj_recb_licker"] = 250, -- Licker
	["npc_vj_recb_prototyrant"] = 3000, -- Proto-Tyrant
}
local itemDrop = {
	["npc_vj_hlr1_zombie"] = false,
	["npc_vj_hlrof_zombie_sec"] = {"weapon_glock", "ammo_9mmclip"},
	["npc_vj_hlrof_zombie_soldier"] = {"ammo_mp5clip", "weapon_handgrenade", "ammo_mp5grenades"},
	["npc_vj_hlrof_gonome"] = false,
	["npc_vj_hlr1_headcrab"] = false,
	["npc_vj_hlr1_headcrab_baby"] = false,
	["npc_vj_hlr1_gonarch"] = false,

	["npc_vj_recb_zombie_resear"] = {"item_healthkit"},
	["npc_vj_recb_zombie_soldier"] = {"ammo_mp5clip", "weapon_handgrenade", "ammo_mp5grenades"},
	["npc_vj_recb_tyrant"] = false,
}
local itemDropChance = {
	["npc_vj_recb_zombie_resear"] = 10
}

function ENT:SetZombieClass(class)
	self.ZombieClass = class
end

function ENT:SetZombieType(int)
	self.ZombieType = int
end

function ENT:SetSpawnFrequency(float)
	self.SpawnFreq = float
end

function ENT:SpawnNPC(pos)
	pos = pos or self:GetPos()
	local ztype = self.ZombieType
	if self.ZombieClass then
		ztype = self.ZombieClass
	else
		if self.ZombieType == 0 then
			ztype = table.Random(zombieType[math.random(1, #zombieType)])
		else
			ztype = table.Random(zombieType[self.ZombieType])
		end
	end
	
	local tr = util.TraceHull({
		start = pos,
		endpos = pos,
		filter = self,
		mins = Vector(-16, -16, 0),
		maxs = Vector(16, 16, 72)
	})
	if tr.Hit then
		debugPrint(self, "can't spawn "..ztype.." at", pos)
		return
	end
	local npc = ents.Create(ztype)
	if IsValid(npc) then		
		if string.EndsWith(ztype, "inf") then
			ztype = string.Replace(ztype, "inf", "")
		end		
		local hp = healthTable[ztype]
		if hp then
			if game.SinglePlayer() then
				hp = hp / 1.5 -- make singleplayer a bit easier
			end
			local skill_lvl = GAMEMODE:GetSkillLevel()
			local skill_mul = 1
			if skill_lvl == 1 then
				skill_mul = 0.75
			elseif skill_lvl > 2 then
				skill_mul = 1.5
			end
			npc.StartHealth = hp * skill_mul
		end
		npc:SetPos(pos)
		npc:SetAngles(self:GetAngles())
		npc:Spawn()
		local varCDem = "CLASS_DEMON"
		npc.VJ_NPC_Class[#npc.VJ_NPC_Class + 1] = varCDem
		npc.SpawnTime = CurTime()
		--npc.Spawner = self
		npc.FindEnemy_CanSeeThroughWalls = true
		npc.FindEnemy_UseSphere = true
		-- optimization variables --
		npc.FadeCorpse = true
		npc.FadeCorpseTime = 60
		npc.NextProcessTime = 3
		----------------------------
		--npc.SoundTbl_FootStep = {"npc/zombie/foot1.wav", "npc/zombie/foot2.wav", "npc/zombie/foot3.wav"}
		--npc.SoundTbl_FootStep = {"common/npc_step1.wav", "common/npc_step2.wav", "common/npc_step3.wav"}
		local idrop = itemDrop[ztype]
		if idrop then
			npc.HasItemDropsOnDeath = true
			npc.ItemDropsOnDeathChance = itemDropChance[ztype] or 4
			npc.ItemDropsOnDeath_EntityList = idrop
		else
			npc.HasItemDropsOnDeath = false
		end
		
		function npc:RunItemDropsOnDeathCode(dmginfo,hitgroup)
			if !self.HasItemDropsOnDeath then return end
			if math.random(1, self.ItemDropsOnDeathChance) == 1 then
				--self:CustomRareDropsOnDeathCode(dmginfo,hitgroup)
				local ent = table.Random(self.ItemDropsOnDeath_EntityList)
				if ent != false then
					local randdrop = ents.Create(ent)
					randdrop:SetPos(self:GetPos() +self:OBBCenter())
					local ang = self:GetAngles()
					randdrop:SetAngles(ang)
					randdrop:SetVelocity(ang:Forward() * math.Rand(0, 200))
					randdrop:Spawn()
					randdrop:Activate()
					if ent == "weapon_handgrenade" then
						randdrop.DroppedAmmo = math.random(1, 3)
					end
				end
			end
		end

		table.insert(self.SpawnedNPCs, npc)
		debugPrint(npc, "spawned at", pos)
	end
end

function ENT:Think()
	if self.ChatSpam then
		PrintMessage(HUD_PRINTTALK, "VJ Base is missing! Check gamemode workshop page!")
		self:NextThink(CurTime() + 10)
		return true
	end

	if GAMEMODE:GetCoopState() != COOP_STATE_INGAME then return end
	local roundState = GAMEMODE:GetRoundState()
	if roundState == ROUND_END or roundState == GAME_END then return end
	if roundState == ROUND_PREPARE or (roundState == ROUND_EVACUATION && GetConVar("hl1_coop_sv_skill"):GetInt() != 3 && GetConVar("hl1_coop_sv_skill"):GetInt() != 4) then
		self:NextThink(CurTime() + math.Rand(20, 40) / self.SpawnFreq)
		self.MaxNPCs = 1
	elseif roundState == ROUND_EVACUATION && GetConVar("hl1_coop_sv_skill"):GetInt() != 3 && GetConVar("hl1_coop_sv_skill"):GetInt() != 4 then
		self:NextThink(CurTime() + math.Rand(10, 20) / self.SpawnFreq)
		self.MaxNPCs = 4
	else
		self:NextThink(CurTime() + math.Rand(10, 30) / self.SpawnFreq)
		self.MaxNPCs = 3
	end
	for k, v in pairs(self.SpawnedNPCs) do
		if !v:IsValid() or v:Health() <= 0 then
			table.RemoveByValue(self.SpawnedNPCs, v)
		end
	end
	if #self.SpawnedNPCs >= self.MaxNPCs or #GAMEMODE:GetZombies() >= GAMEMODE:GetMaxZombies() then
		return true
	end
	local canSpawn = true
	local pos = self:GetPos()
	local mindist = math.huge
	for k, v in pairs(GAMEMODE:GetActivePlayersTable()) do
		if self:Visible(v) then
			canSpawn = false
			break
		end
		local dist = pos:DistToSqr(v:GetPos())
		if dist < ZOMBIE_DIST_MIN then
			canSpawn = false
			break
		end
		if dist < mindist then
			mindist = dist
		end
	end
	if mindist > ZOMBIE_DIST_MAX then
		canSpawn = false
	end
	if canSpawn then
		self:SpawnNPC()
		if roundState == ROUND_IN_WAVE or roundState == ROUND_EVACUATION then
			local amount = math.random(0, 2) * self.SpawnFreq
			if amount > 0 then
				for i = 1, amount do
					local randpos = VectorRand() * math.Rand(32, 200)
					randpos[3] = 0
					local tr = util.TraceHull({
						start = self:GetPos(),
						endpos = self:GetPos() + randpos,
						filter = self,
						mask = MASK_NPCSOLID_BRUSHONLY,
						mins = Vector(-16, -16, 0),
						maxs = Vector(16, 16, 72)
					})
					if !tr.Hit then
						self:SpawnNPC(tr.HitPos)
					end
				end
			end
		end
	end
	return true
end