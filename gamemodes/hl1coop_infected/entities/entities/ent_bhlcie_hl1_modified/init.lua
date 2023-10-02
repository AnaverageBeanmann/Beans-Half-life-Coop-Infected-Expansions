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
	["npc_bhlcie_cultist"]	= 30, -- Cultist
	["npc_bhlcie_wretch"]	= 45, -- Wretch
	["npc_bhlcie_erectus"]	= 75, -- Erectus
	["npc_bhlcie_horror"]	= 40, -- Horror
	["npc_bhlcie_stalker"]	= 50, -- Stalker
	["npc_bhlcie_preacher"]	= 50, -- Preacher
	["npc_bhlcie_shepherd"]	= 666, -- Shepherd
}

hook.Add("Initialize", "HLCoop_NPCScore", function()
	table.Merge(GAMEMODE.NPCScorePrice, CustomNPCPointsTable)
	-- table.Merge(GAMEMODE.NPCScorePriceDamageMul, CustomNPCPointsTable_DM)
end)

local zombieType = {
	-- Scientists and Barneys
	[1] = {
		"npc_vj_lnhls_scientist",
		"npc_vj_lnhls_scientist",
		"npc_vj_lnhls_barney"
	},
	-- Scientists, Barneys and HECUs
	[2] = {
		"npc_vj_lnhls_scientist",
		"npc_vj_lnhls_barney",
		"npc_vj_lnhls_grunt"
	},
	-- Scientists, Barneys, HECUs and HEVs
	[3] = {
		"npc_vj_lnhls_scientist",
		"npc_vj_lnhls_barney",
		"npc_vj_lnhls_grunt",
		"npc_vj_lnhls_hev"
	},
	-- Scientists
	[4] = {
		"npc_vj_lnhls_scientist"
	},
	-- Barneys
	[5] = {
		"npc_vj_lnhls_barney"
	},
	-- HEVs
	[6] = {
		"npc_vj_lnhls_hev"
	},
	-- Scientists, Barneys and HEVs
	[7] = {
		"npc_vj_lnhls_scientist",
		"npc_vj_lnhls_barney",
		"npc_vj_lnhls_hev"
	},
}

local healthTable = {
	["npc_vj_lnhls_scientist"] = 30,
	["npc_vj_lnhls_barney"] = 70,
	["npc_vj_lnhls_gman"] = 50,
	["npc_vj_lnhls_grunt"] = 120,
	["npc_vj_lnhls_assassin"] = 60,
	["npc_vj_lnhls_blackops"] = 130,
	["npc_vj_lnhls_hev"] = 170,
	["npc_vj_lnhls_gina"] = 180,
	["npc_vj_lnhls_gordon"] = 180,
}

local itemDrop = {
	["npc_vj_lnhls_gina"] = false,
	["npc_vj_lnhls_gordon"] = false,
	["npc_vj_lnhls_gman"] = false,
	["npc_vj_lnhls_scientist"] = false,
	["npc_vj_lnhls_barney"] = {"weapon_glock", "ammo_9mmclip"},
	["npc_vj_lnhls_hev"] = {"item_battery"},
	["npc_vj_lnhls_grunt"] = {"ammo_mp5clip", "weapon_handgrenade", "ammo_mp5grenades"},
	["npc_vj_lnhls_assassin"] = {"weapon_glock", "ammo_9mmclip", "weapon_handgrenade"},
	["npc_vj_lnhls_blackops"] = {"ammo_mp5clip", "ammo_mp5grenades", "weapon_handgrenade"},
}
local itemDropChance = {
	["npc_vj_lnhls_hev"] = 5,
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
		local roundState = GAMEMODE:GetRoundState()
		if roundState == ROUND_IN_WAVE or roundState == ROUND_EVACUATION then
			ztype = ztype.."inf"
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
		-- optimization variables --
		npc.FadeCorpse = true
		npc.FadeCorpseTime = 60
		npc.NextProcessTime = 3
		----------------------------
		npc.FollowPlayer = false
		npc.AllowPrintingInChat = false
		npc.FlinchChance = 2
		if GAMEMODE:GetSkillLevel() > 2 then
			npc.CanFlinch = 2
			npc.FlinchChance = 1
			npc.FlinchDamageTypes = {DMG_CLUB}
			npc.NextFlinchTime = 2.5
		end
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
		
		function npc:DoKilledEnemy(ent, attacker, inflictor)
			if !cvar_infect:GetBool() then return end
			if self.HEVDamage and self.HEVDamage >= 80 then return end
			if IsValid(ent) and ent:IsPlayer() then
				local modelMerge = false
				if ent:LookupBone("ValveBiped.Bip01_Pelvis") then
					modelMerge = true
				end

				local npc_zombie = "npc_vj_lethalnecrotics_baseinf"
				if attacker.LN_IsWalker then
					npc_zombie = "npc_vj_lethalnecrotics_basewalker"
				end

				local npc = ents.Create(npc_zombie)
				if IsValid(npc) then
					if modelMerge then
						npc:AddEffects(EF_NODRAW)
						npc:SetNoDraw(true)
						npc:SetMaterial("hud/killicons/default")
					end
					npc:SetPos(ent:GetPos())
					npc:SetAngles(ent:GetAngles())
					function npc:CustomOnInitialize()
						self.GodMode = true
						self.VJ_NoTarget = true
						self.DisableMakingSelfEnemyToNPCs = true
						self.DisableChasingEnemy = true
						self.DisableFindEnemy = true
						self.DisableWandering = true
						self.MovementType = VJ_MOVETYPE_STATIONARY
						self.CanTurnWhileStationary = false
						self.HasSounds = false

						timer.Simple(6,function()
							if IsValid(self) then
								self:VJ_ACT_PLAYACTIVITY("infectionrise",true,4,false)
								VJ_EmitSound(self,{"lethalnecrotics/infectedturned.mp3"},100,math.random(100,100))
								self.GodMode = false
								self.VJ_NoTarget = false
								self.DisableMakingSelfEnemyToNPCs = false
								self.DisableChasingEnemy = false
								self.DisableFindEnemy = false
								self.DisableWandering = false
								self.HasSounds = true

								local eyeglow1 = ents.Create("env_sprite")
								eyeglow1:SetKeyValue("model", self.EyeGlowSprite..".vmt")
								eyeglow1:SetKeyValue("scale","0.04")
								eyeglow1:SetKeyValue("rendermode","5")
								eyeglow1:SetKeyValue("rendercolor", self.EyeGlowColor)
								eyeglow1:SetParent(self)
								eyeglow1:Fire("SetParentAttachment","eye1")
								eyeglow1:Spawn()
								eyeglow1:Activate()
								self:DeleteOnRemove(eyeglow1)
								
								local eyeglow2 = ents.Create("env_sprite")
								eyeglow2:SetKeyValue("model", self.EyeGlowSprite..".vmt")
								eyeglow2:SetKeyValue("scale","0.04")
								eyeglow2:SetKeyValue("rendermode","5")
								eyeglow2:SetKeyValue("rendercolor", self.EyeGlowColor)
								eyeglow2:SetParent(self)
								eyeglow2:Fire("SetParentAttachment","eye2")
								eyeglow2:Spawn()
								eyeglow2:Activate()
								self:DeleteOnRemove(eyeglow2)

								timer.Simple(4,function()
									if IsValid(self) then
										self.MovementType = VJ_MOVETYPE_GROUND
									end
								end)
							end
						end)
					end
					npc.DoKilledEnemy = self.DoKilledEnemy
					npc.MultipleMeleeAttacks = self.MultipleMeleeAttacks
					npc:Spawn()
					npc:VJ_ACT_PLAYACTIVITY("infectiondeath",true,5.9,false)
				end

				if modelMerge then
					local victim = ents.Create("ln_bonemerge_infectionmodel")
					if IsValid(victim) and IsValid(npc) then
						victim:SetModel(ent:GetModel())
						victim:SetSkin(ent:GetSkin())
						for i = 0, ent:GetNumBodyGroups() -1 do
							victim:SetBodygroup(i,ent:GetBodygroup(i))
						end
						victim:SetMaterial(ent:GetMaterial())
						victim:SetPos(npc:GetPos())
						victim:SetParent(npc)
						victim:Spawn()
						timer.Simple(.05, function()
							if IsValid(victim) then
								victim:BroadcastEntityPlayerColor(ent:GetPlayerColor())
							end
						end)
						timer.Simple(6,function()
							if IsValid(victim) then
								victim:SetColor(Color(207,255,193))
							end
						end)
						npc.mergedmodel_model = victim:GetModel()
					end
				end

				local ragdoll = ent:GetRagdollEntity()
				if IsValid(ragdoll) then
					ragdoll.Infected = true
					ragdoll:Remove()
				end
			end
		end
		
		npc.MeleeAttackBleedEnemy = false
		function npc:CustomOnMeleeAttack_AfterChecks(ply)
			if ply:IsPlayer() then
				local skill = GAMEMODE:GetSkillLevel()
				local maxrandom = math.Clamp(6 - skill, 0, 5)
				if math.random(0, maxrandom) == 0 then
					ply.Bleeding = {time = CurTime() + 30, npc = self}
				end
			end
		end
		
		if ztype == "npc_vj_lnhls_hev" then
			npc.NextHEVIdleSound = 0
			npc.NextSparkTime = 0
			npc.NextShockDamageTime = 0
			npc.SentenceLastTime = 0
			npc.HEVDamage = math.random(10, 100)
			if npc.HEVDamage >= 80 then
				npc.StartHealth = npc.StartHealth - npc.HEVDamage / 2
			end
			npc.HEVIdleSnds = {
				Sound("hl1coop_inf/hevzombie/blood_toxins.wav"),
				Sound("hl1coop_inf/hevzombie/hev_gereral_failure.wav"),
				Sound("hl1coop_inf/hevzombie/hev_critical_fail.wav")
			}

			function npc:CustomOnTouch(ent)
				if self.HEVDamage >= 80 and self.NextShockDamageTime <= CurTime() and (ent:IsPlayer() or ent:IsNPC()) then
					local tr = self:GetTouchTrace()
					
					self:EmitSound("ambient/energy/zap"..math.random(5,9)..".wav")
					
					ent:SetLocalVelocity(tr.HitNormal * 400)
					
					local dmg = DamageInfo()
					dmg:SetDamage(self.HEVDamage / 12)
					dmg:SetAttacker(self)
					dmg:SetInflictor(self)
					dmg:SetDamageType(DMG_SHOCK)
					dmg:SetDamageForce(tr.HitNormal * 10000)
					dmg:SetDamagePosition(tr.HitPos)
					ent:TakeDamageInfo(dmg)
					
					self.NextShockDamageTime = CurTime() + .3
				end
			end
			function npc:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
				self:DoDamageKnockback(dmginfo, hitgroup)
				--[[if dmginfo:IsBulletDamage() then
					local e = EffectData()
					e:SetOrigin(dmginfo:GetDamagePosition())
					e:SetStart(dmginfo:GetReportedPosition())
					e:SetSurfaceProp(1)
					e:SetDamageType(DMG_BULLET)
					--e:SetHitBox(tr.HitBox)
					e:SetEntIndex(self:EntIndex())
					util.Effect("MetalSpark", e, true, true)
				end]]
				--ChatMessage("dmg: "..dmginfo:GetDamage()..", hp: "..self:Health()..", hitgroup: "..hitgroup)
				if self:Health() > 0 then
					if self:Health() >= 40 and math.random(0,1) == 0 then
						local dmg = dmginfo:GetDamage()
						if dmg > 10 then
							local dmgtype = dmginfo:GetDamageType()
							local sentence = math.random(0,1) == 0 and "HEV_DMG6" or "HEV_HLTH1"
							if dmgtype == DMG_CRUSH or dmgtype == DMG_CLUB then
								sentence = "HEV_DMG4"
								if dmg >= 50 then
									sentence = "HEV_DMG5"
								end
							elseif dmgtype == DMG_ENERGYBEAM then
								sentence = "HEV_SHOCK"
							end
							if self.SentenceLastTime < CurTime() then
								self.NextHEVIdleSound = self.NextHEVIdleSound + math.Rand(5, 10)
								if self.HEVDamage < 30 then
									local pitchMul = math.Rand(0.8, 0.92)
									self.SentenceLastTime = CurTime() + SentenceDuration(sentence) / pitchMul
									EmitSentence(sentence, self:GetPos(), self:EntIndex(), CHAN_VOICE, 0.85, 65, 0, 100 * pitchMul)
								elseif self.HEVDamage >= 50 then
									local t = {
										["HEV_DMG6"] = "hl1coop_inf/hevzombie/bloodloss1.wav",
										["HEV_HLTH1"] = "hl1coop_inf/hevzombie/healthdropping.wav",
										["HEV_DMG4"] = "hl1coop_inf/hevzombie/healthdropping.wav",
										["HEV_DMG5"] = "hl1coop_inf/hevzombie/healthdropping.wav",
										["HEV_SHOCK"] = "hl1coop_inf/hevzombie/hev_gereral_failure.wav",
									}
									if self.HEVDamage > 70 then
										t = {
											["HEV_DMG6"] = "hl1coop_inf/hevzombie/bloodloss2.wav",
											["HEV_HLTH1"] = "hl1coop_inf/hevzombie/hev_critical_fail.wav",
											["HEV_DMG4"] = "hl1coop_inf/hevzombie/hev_critical_fail.wav",
											["HEV_DMG5"] = "hl1coop_inf/hevzombie/hev_gereral_failure.wav",
											["HEV_SHOCK"] = "hl1coop_inf/hevzombie/hev_critical_fail.wav",
										}
									end
									if t[sentence] then
										self.SentenceLastTime = CurTime() + SoundDuration(t[sentence])
										self:EmitSound(t[sentence], 65, math.random(95, 103), 1, CHAN_VOICE)
									end
								end
							end
						end
					end
					/*if !self.CriticalHealthMsg and self:Health() <= 25 and self:Health() >= 10 then
						self.CriticalHealthMsg = true
						self:PlayDelayedSentence("HEV_HLTH2")
					end
					if !self.DeathMsg and self:Health() < 10 then
						self.DeathMsg = true
						self:PlayDelayedSentence("HEV_HLTH3")
					end*/
				end
			end
			
			/*function npc:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
				EmitSentence("AI_BaseNPC.SentenceStop", self:GetPos(), self:EntIndex(), CHAN_VOICE)
			end

			function npc:PlayDelayedSentence(sentence, pitchMul, vol, sndlvl)
				pitchMul = pitchMul or math.Rand(0.87, 0.92)
				vol = vol or 0.9
				sndlvl = sndlvl or 65
				
				local delay = self.SentenceLastTime > CurTime() and self.SentenceLastTime - CurTime() or 0
				self.SentenceLastTime = CurTime() + SentenceDuration(sentence) / pitchMul + delay
				timer.Simple(delay, function()
					if IsValid(self) then
						EmitSentence(sentence, self:GetPos(), self:EntIndex(), CHAN_VOICE, vol, sndlvl, 0, 100 * pitchMul)
					end
				end)
			end*/
		end
			
		function npc:CustomOnThink_AIEnabled()
			if !self.Dead and self.CurrentSchedule != nil and IsValid(self:GetEnemy()) and (!self.NextClimbCheck or self.NextClimbCheck <= CurTime()) then
				-- print(self:IsPathBlocked(), self:CanClimbOver())
				if self:IsMoving() and self:IsPathBlocked() and self:CanClimbOver() then
					local anim = ACT_CLIMB_DISMOUNT
					self:StopAttacks()
					self:StopMoving()
					self:VJ_ACT_PLAYACTIVITY(anim, true, self:DecideAnimationLength(anim, false), false, 0, {OnFinish = function() self:DoChangeMovementType(VJ_MOVETYPE_GROUND) self:SetPos(self:CalculateFloorPos()) end})
					self:DoChangeMovementType(VJ_MOVETYPE_AERIAL)
					self.NextClimbCheck = CurTime() + 3
				end
				self.NextClimbCheck = CurTime() + 1
			end
			
			if self.HEVDamage and self.HEVDamage >= 50 and self.SentenceLastTime < CurTime() and self.NextHEVIdleSound < CurTime() and self:Health() > 50 then
				if math.random(0, 3) == 0 then 
					local snd = self.HEVIdleSnds[math.random(1, 3)]
					if self.HEVDamage >= 80 then
						snd = self.HEVIdleSnds[math.random(2, 3)]
					end
					self.SentenceLastTime = CurTime() + SoundDuration(snd)
					self:EmitSound(snd, 70, math.random(93, 103), 1, CHAN_VOICE)
				end
				self.NextHEVIdleSound = CurTime() + math.Rand(10, 20)
			end
			if self.HEVDamage and self.HEVDamage >= 80 then
				if self.NextSparkTime < CurTime() then
					local norm = VectorRand() * 100
					local rand = VectorRand() * 3
					rand[3] = rand[3] * 8
					local sparks = EffectData()
					sparks:SetOrigin(self:WorldSpaceCenter() + rand)
					sparks:SetNormal(norm)
					sparks:SetMagnitude(2)
					sparks:SetScale(0.5)
					sparks:SetRadius(2)
					util.Effect("Sparks", sparks, true, true)
					self:EmitSound("ambient/energy/spark"..math.random(1,6)..".wav")
					
					self.NextSparkTime = CurTime() + math.Rand(5, 6) - (self.HEVDamage / 100) * 5
				end
			end
		end
		
		function npc:IsPathBlocked()
			local pos = self:WorldSpaceCenter() - Vector(0,0,5)
			local tr = util.TraceHull({
				start = pos,
				endpos = pos + self:GetForward() * 24,
				filter = self,
				mask = MASK_NPCSOLID_BRUSHONLY,
				mins = Vector(-16, -16, 0),
				maxs = Vector(16, 16, 64),
			})
			return tr.Hit
		end

		function npc:CanClimbOver()
			local headPos = self:GetPos() + Vector(0,0,64)
			local tr = util.TraceHull({
				start = headPos,
				endpos = headPos + self:GetForward() * 32,
				filter = self,
				mask = MASK_NPCSOLID,
				mins = Vector(-16, -16, 0),
				maxs = Vector(16, 16, 64),
			})
			return !tr.Hit
		end

		function npc:CalculateFloorPos()
			local tr = util.TraceHull({
				start = self:WorldSpaceCenter(),
				endpos = self:WorldSpaceCenter() - self:GetUp() * 64,
				filter = self,
				mask = MASK_NPCSOLID,
				mins = Vector(-16, -16, 0),
				maxs = Vector(16, 16, 64),
			})
			return tr.HitPos
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