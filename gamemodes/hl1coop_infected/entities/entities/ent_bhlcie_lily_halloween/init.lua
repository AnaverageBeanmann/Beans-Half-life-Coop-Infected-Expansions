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

local CustomNPCPointsTable = {
	// Resident Evil: Cold Blood
	["npc_vj_hlr1_zombie"] = 50 -- Scientist
}

hook.Add("Initialize", "HLCoop_NPCScore", function()
	table.Merge(GAMEMODE.NPCScorePrice, CustomNPCPointsTable)
	-- table.Merge(GAMEMODE.NPCScorePriceDamageMul, CustomNPCPointsTable_DM)
end)

local zombieType = {
	// Resident Evil: Cold Blood
	[1] = {
		"npc_vj_hlr1_zombie"
	},
}
local healthTable = {
	["npc_vj_hlr1_zombie"] = 50, -- Zombie
}
local itemDrop = {
	["npc_vj_hlr1_zombie"] = false,
	["npc_vj_hlrof_zombie_sec"] = {"weapon_glock", "ammo_9mmclip"},
	["npc_vj_hlrof_zombie_soldier"] = {"ammo_mp5clip", "weapon_handgrenade", "ammo_mp5grenades"},
	["npc_vj_hlrof_gonome"] = false,
	["npc_vj_hlr1_headcrab"] = false,
	["npc_vj_hlr1_headcrab_baby"] = false,
	["npc_vj_hlr1_gonarch"] = false,
}
local itemDropChance = {
	["npc_vj_hlr1_zombie"] = 2
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
	if roundState == ROUND_PREPARE then
		self:NextThink(CurTime() + math.Rand(20, 40) / self.SpawnFreq)
		self.MaxNPCs = 1
	elseif roundState == ROUND_EVACUATION then
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