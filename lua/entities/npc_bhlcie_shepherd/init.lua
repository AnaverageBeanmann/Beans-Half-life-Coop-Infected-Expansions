AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_bhlcie/shepherd.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 666
ENT.HasHealthRegeneration = true -- Can the SNPC regenerate its health?
ENT.HealthRegenerationAmount = 1 -- How much should the health increase after every delay?
ENT.HealthRegenerationDelay = VJ_Set(0.5, 1) -- How much time until the health increases
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_DEMON"}
	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {
	"npc/footsteps/hardboot_generic1.wav",
	"npc/footsteps/hardboot_generic2.wav",
	"npc/footsteps/hardboot_generic3.wav",
	"npc/footsteps/hardboot_generic4.wav",
	"npc/footsteps/hardboot_generic5.wav",
	"npc/footsteps/hardboot_generic6.wav",
	"npc/footsteps/hardboot_generic8.wav"
}

ENT.GeneralSoundPitch1 = 100

ENT.FindEnemy_UseSphere = true
ENT.FindEnemy_CanSeeThroughWalls = true

ENT.BHLCIE_Shepherd_Difficulty = 1
ENT.BHLCIE_Shepherd_PortalBlockerPos = Vector(0,0,0)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()

	self.BHLCIE_Shepherd_Difficulty = GetConVar("hl1_coop_sv_skill"):GetInt()

	if self.BHLCIE_Shepherd_Difficulty == 4 then

		self.BHLCIE_Shepherd_Difficulty = 3

	end

	self.StartHealth = self.StartHealth * player.GetCount()

	self:SetHealth(self.StartHealth)

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

	self.SoundTbl_Idle = {""}
	self.SoundTbl_OnPlayerSight = {""}
	self.SoundTbl_Alert = {""}
	self.SoundTbl_BecomeEnemyToPlayer = {""}
	self.SoundTbl_CallForHelp = {""}
	self.SoundTbl_AllyDeath = {""}
	self.SoundTbl_MedicBeforeHeal = {""}
	self.SoundTbl_OnGrenadeSight = {""}
	self.SoundTbl_OnDangerSight = {""}
	self.SoundTbl_OnKilledEnemy = {""}
	self.SoundTbl_Pain = {""}
	self.SoundTbl_Death = {""}

	self.WeaponReload_FindCover = false
	self.MoveOrHideOnDamageByEnemy = false
	self.FindEnemy_UseSphere = true
	self.FindEnemy_CanSeeThroughWalls = true

	self.SoundTbl_RandomHellNoise = {
		"npc/zombie/zombie_voice_idle5.wav",
		"npc/zombie/zombie_voice_idle6.wav",
		"npc/zombie_poison/pz_alert1.wav",
		"npc/zombie_poison/pz_alert2.wav",
		"npc/zombie_poison/pz_call1.wav",
		"npc/zombie_poison/pz_throw2.wav",
		"npc/zombie_poison/pz_throw3.wav",
		"npc/fast_zombie/fz_alert_close1.wav",
		"npc/fast_zombie/fz_alert_far1.wav",
		"npc/fast_zombie/fz_frenzy1.wav",
		"npc/fast_zombie/fz_scream1.wav",
		"npc/antlion_guard/angry1.wav",
		"npc/antlion_guard/angry2.wav",
		"npc/antlion_guard/angry3.wav",
	}

	VJ_EmitSound(self,{"npc/antlion/rumble1.wav"},90,50)
	util.ScreenShake(self:GetPos(), 5, 5, 15, 350)

	self:SetSolid(SOLID_NONE)
	self.HasMeleeAttack = false
	self.GodMode = true
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)

	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

	timer.Simple(3,function() if IsValid(self) then

		ParticleEffectAttach("fire_medium_01_glow",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

		VJ_EmitSound(self,{"npc/antlion/rumble1.wav"},90,50)

		self.PreLaunchLight = ents.Create("light_dynamic")
		self.PreLaunchLight:SetKeyValue("brightness", "5")
		self.PreLaunchLight:SetKeyValue("distance", "500")
		self.PreLaunchLight:SetLocalPos(self:GetPos())
		self.PreLaunchLight:SetLocalAngles(self:GetAngles())
		self.PreLaunchLight:Fire("Color", "255 0 0 255")
		self.PreLaunchLight:SetParent(self)
		self.PreLaunchLight:Spawn()
		self.PreLaunchLight:Activate()
		self.PreLaunchLight:Fire("SetParentAttachment","chest")
		self.PreLaunchLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.PreLaunchLight)

		self:Shepherd_PlayHellScream()

		local ChestGlow1 = ents.Create("env_sprite")
		ChestGlow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		ChestGlow1:SetKeyValue("scale", "1.5")
		ChestGlow1:SetKeyValue("rendermode","5")
		ChestGlow1:SetKeyValue("rendercolor","142 0 0 255")
		ChestGlow1:SetKeyValue("spawnflags","1") -- If animated
		ChestGlow1:SetParent(self)
		ChestGlow1:Fire("SetParentAttachment", "chest")
		ChestGlow1:Fire("Kill", "", 13)
		ChestGlow1:Spawn()
		ChestGlow1:Activate()
		self:DeleteOnRemove(ChestGlow1)
		
		local ChestGlow2 = ents.Create("env_sprite")
		ChestGlow2:SetKeyValue("model","sprites/blueflare1.vmt")
		ChestGlow2:SetKeyValue("scale", "1.5")
		ChestGlow2:SetKeyValue("rendermode","5")
		ChestGlow2:SetKeyValue("rendercolor","255 0 0 255")
		ChestGlow2:SetKeyValue("spawnflags","1") -- If animated
		ChestGlow2:SetParent(self)
		ChestGlow2:Fire("SetParentAttachment", "chest")
		ChestGlow2:Fire("Kill", "", 13)
		ChestGlow2:Spawn()
		ChestGlow2:Activate()
		self:DeleteOnRemove(ChestGlow2)
		
		local ChestGlow3 = ents.Create("env_sprite")
		ChestGlow3:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
		ChestGlow3:SetKeyValue("scale", "1")
		ChestGlow3:SetKeyValue("rendermode","5")
		ChestGlow3:SetKeyValue("rendercolor","255 0 0 255")
		ChestGlow3:SetKeyValue("spawnflags","1") -- If animated
		ChestGlow3:SetParent(self)
		ChestGlow3:Fire("SetParentAttachment", "chest")
		ChestGlow3:Fire("Kill", "", 13)
		ChestGlow3:Spawn()
		ChestGlow3:Activate()
		self:DeleteOnRemove(ChestGlow3)

	end end)

	timer.Simple(6,function() if IsValid(self) then

		self:Shepherd_PlayHellScream()

		VJ_EmitSound(self,{"npc/antlion/rumble1.wav"},90,50)

	end end)

	timer.Simple(9,function() if IsValid(self) then

		self:Shepherd_PlayHellScream()

		VJ_EmitSound(self,{"npc/antlion/rumble1.wav"},90,50)

	end end)

	timer.Simple(11,function() if IsValid(self) then

		self:Shepherd_PlayHellScream()

		VJ_EmitSound(self,{"npc/antlion/rumble1.wav"},90,90)

	end end)

	timer.Simple(13,function() if IsValid(self) then

		VJ_EmitSound(self,{"npc/antlion/rumble1.wav"},90,90)

		self.PreLaunchLight:Fire("Kill", "", 0)

		self.LaunchLight = ents.Create("light_dynamic")
		self.LaunchLight:SetKeyValue("brightness", "7")
		self.LaunchLight:SetKeyValue("distance", "800")
		self.LaunchLight:SetLocalPos(self:GetPos())
		self.LaunchLight:SetLocalAngles(self:GetAngles())
		self.LaunchLight:Fire("Color", "255 0 0 255")
		self.LaunchLight:SetParent(self)
		self.LaunchLight:Spawn()
		self.LaunchLight:Activate()
		self.LaunchLight:Fire("SetParentAttachment","chest")
		self.LaunchLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.LaunchLight)

		VJ_EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",100,100)
		VJ_EmitSound(self,"ambient/creatures/town_child_scream1.wav",100,math.random(60,70))
		self:Shepherd_PlayHellScream()

	end end)

	timer.Simple(15,function() if IsValid(self) then

		self.LaunchLight:Fire("Kill", "", 0)
		VJ_EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",100,100)
		VJ_EmitSound(self,"ambient/explosions/exp"..math.random(1,4)..".wav",85,100)
		VJ_EmitSound(self,"ambient/levels/labs/teleport_postblast_thunder1.wav",100,50)
		VJ_EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",100,50)

		VJ_EmitSound(self,"ambient/creatures/town_zombie_call1.wav",100,30)
		VJ_EmitSound(self,"ambient/voices/playground_memory.wav",100,30)
		self:StopParticles()

		ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

		self.PreLaunchLight = ents.Create("light_dynamic")
		self.PreLaunchLight:SetKeyValue("brightness", "2")
		self.PreLaunchLight:SetKeyValue("distance", "200")
		self.PreLaunchLight:SetLocalPos(self:GetPos())
		self.PreLaunchLight:SetLocalAngles(self:GetAngles())
		self.PreLaunchLight:Fire("Color", "255 0 0 255")
		self.PreLaunchLight:SetParent(self)
		self.PreLaunchLight:Spawn()
		self.PreLaunchLight:Activate()
		self.PreLaunchLight:Fire("SetParentAttachment","crucifix")
		self.PreLaunchLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.PreLaunchLight)

		self:Shepherd_PlayHellScream()

		local ChestGlow1 = ents.Create("env_sprite")
		ChestGlow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		ChestGlow1:SetKeyValue("scale", "0.1")
		ChestGlow1:SetKeyValue("rendermode","5")
		ChestGlow1:SetKeyValue("rendercolor","142 0 0 255")
		ChestGlow1:SetKeyValue("spawnflags","1") -- If animated
		ChestGlow1:SetParent(self)
		ChestGlow1:Fire("SetParentAttachment", "crucifix")
		ChestGlow1:Spawn()
		ChestGlow1:Activate()
		self:DeleteOnRemove(ChestGlow1)
		
		local ChestGlow2 = ents.Create("env_sprite")
		ChestGlow2:SetKeyValue("model","sprites/blueflare1.vmt")
		ChestGlow2:SetKeyValue("scale", "0.1")
		ChestGlow2:SetKeyValue("rendermode","5")
		ChestGlow2:SetKeyValue("rendercolor","255 0 0 255")
		ChestGlow2:SetKeyValue("spawnflags","1") -- If animated
		ChestGlow2:SetParent(self)
		ChestGlow2:Fire("SetParentAttachment", "crucifix")
		ChestGlow2:Spawn()
		ChestGlow2:Activate()
		self:DeleteOnRemove(ChestGlow2)
		
		local ChestGlow3 = ents.Create("env_sprite")
		ChestGlow3:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
		ChestGlow3:SetKeyValue("scale", "0.1")
		ChestGlow3:SetKeyValue("rendermode","5")
		ChestGlow3:SetKeyValue("rendercolor","255 0 0 255")
		ChestGlow3:SetKeyValue("spawnflags","1") -- If animated
		ChestGlow3:SetParent(self)
		ChestGlow3:Fire("SetParentAttachment", "crucifix")
		ChestGlow3:Spawn()
		ChestGlow3:Activate()
		self:DeleteOnRemove(ChestGlow3)


		self:Give("weapon_shepherd_gun")
		self:SetSolid(SOLID_BBOX)
		self.HasMeleeAttack = true
		self.GodMode = false
		self.MovementType = VJ_MOVETYPE_GROUND
		self.CanTurnWhileStationary = true
		self:SetMaterial("")
		self:DrawShadow(true)

		if self.BHLCIE_Shepherd_Difficulty == 3 then -- block the exit so you have to kill him
			PrintMessage(4,"-= KILL THE SHEPHERD =-")
			self.exitblocker = ents.Create("prop_physics")
			if IsValid(self.exitblocker) then
				self.exitblocker:SetModel("models/hunter/blocks/cube2x2x2.mdl")				
				for k, v in pairs(ents.FindByClass("hl1_inf_portal")) do
					self.BHLCIE_Shepherd_PortalBlockerPos = v:GetPos()
				end
				self.exitblocker:SetPos(Vector(self.BHLCIE_Shepherd_PortalBlockerPos))
				-- self.exitblocker:SetPos(Vector(3667.167725, 4418.179199, 64.031250))
				self.exitblocker:SetAngles(Angle(0,0,0))
				self.exitblocker:Spawn()
				self.exitblocker:SetMoveType(MOVETYPE_NONE)
				self.exitblocker:SetRenderFX(16)
				local thefunny = Color(255, 0, 0, 254)
				self.exitblocker:SetColor(thefunny)
				self.exitblocker:SetMaterial("models/flesh")
				self:DeleteOnRemove(self.exitblocker)
				
				ParticleEffectAttach("embers_large_02",PATTACH_POINT_FOLLOW,self.exitblocker,self.exitblocker:LookupAttachment("origin"))
				ParticleEffectAttach("smoke_burning_engine_01",PATTACH_POINT_FOLLOW,self.exitblocker,self.exitblocker:LookupAttachment("origin"))
				
			end
		end

	end end)

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Shepherd_PlayHellScream()
	effects.BeamRingPoint(self:GetPos(), 0.80, 0, 175, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
	VJ_EmitSound(self,"ambient/fire/ignite.wav",75,math.random(45,70))
	VJ_EmitSound(self,self.SoundTbl_RandomHellNoise,80,math.random(50,90))
	util.ScreenShake(self:GetPos(), 50, 5, 3, 750)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnSetupWeaponHoldTypeAnims(hType)
	if hType == "crossbow" or hType == "shotgun" then
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= ACT_RANGE_ATTACK_SHOTGUN
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= ACT_GESTURE_RANGE_ATTACK_SHOTGUN
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1_LOW] 				= ACT_RANGE_ATTACK_SMG1_LOW
		self.WeaponAnimTranslations[ACT_RELOAD] 						= ACT_RELOAD_SMG1
		self.WeaponAnimTranslations[ACT_RELOAD_LOW] 					= ACT_RELOAD_SMG1_LOW
		
		self.WeaponAnimTranslations[ACT_IDLE] 							= ACT_IDLE
		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= ACT_IDLE_ANGRY
		
		self.WeaponAnimTranslations[ACT_WALK] 							= ACT_WALK_RIFLE
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= ACT_WALK_AIM_RIFLE
		self.WeaponAnimTranslations[ACT_WALK_CROUCH] 					= ACT_WALK_CROUCH_RPG
		self.WeaponAnimTranslations[ACT_WALK_CROUCH_AIM] 				= ACT_WALK_CROUCH_AIM_RIFLE
		
		self.WeaponAnimTranslations[ACT_RUN] 							= ACT_RUN_RIFLE
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= ACT_RUN_AIM_RIFLE
		self.WeaponAnimTranslations[ACT_RUN_CROUCH] 					= ACT_RUN_CROUCH_RPG
		self.WeaponAnimTranslations[ACT_RUN_CROUCH_AIM] 				= ACT_RUN_CROUCH_AIM_RIFLE
		self.CanCrouchOnWeaponAttack = false
		return true
	else
		self.CanCrouchOnWeaponAttack = true
		return false
	end
end
