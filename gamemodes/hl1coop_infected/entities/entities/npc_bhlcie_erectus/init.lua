AddCSLuaFile("shared.lua")
include('shared.lua')
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/vj_bhlcie/demons/erectus.mdl"}
ENT.StartHealth = 1000
ENT.HullType = HULL_LARGE

ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_DEMON"}

ENT.BloodColor = "Red"

ENT.AlwaysWander = true

ENT.MeleeAttackDamage = 10
ENT.MeleeAttackDistance = 35
ENT.MeleeAttackDamageDistance = 60
ENT.HasMeleeAttackKnockBack = true
ENT.MeleeAttackKnockBack_Forward1 = 150
ENT.MeleeAttackKnockBack_Forward2 = 150
ENT.MeleeAttackKnockBack_Up1 = 250
ENT.MeleeAttackKnockBack_Up2 = 250
ENT.TimeUntilMeleeAttackDamage = false

ENT.FindEnemy_UseSphere = true
ENT.FindEnemy_CanSeeThroughWalls = true

ENT.DisableFootStepSoundTimer = true

ENT.AnimTbl_Run = {ACT_WALK}

ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"vjseq_death"}
ENT.HasDeathRagdoll = false

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.DeathSoundPitch = VJ_Set(80, 70)
ENT.HasBreathSound = false
ENT.FootstepSoundLevel = 75
ENT.BreathSoundLevel = 70

ENT.SoundTbl_FootStep = {"npc/erectus/taller_step.wav"}
ENT.SoundTbl_Breath = {"npc/erectus/rageloop.wav"}
ENT.SoundTbl_Idle = {
	"npc/erectus/chase1.wav",
	"npc/erectus/chase2.wav",
	"npc/erectus/chase3.wav",
	"npc/erectus/chase4.wav"
}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/erectus/attack.wav"}
ENT.SoundTbl_MeleeAttack = {
	"physics/body/body_medium_impact_hard1.wav",
	"physics/body/body_medium_impact_hard2.wav",
	"physics/body/body_medium_impact_hard3.wav",
	"physics/body/body_medium_impact_hard4.wav",
	"physics/body/body_medium_impact_hard5.wav",
	"physics/body/body_medium_impact_hard6.wav"
}
ENT.SoundTbl_Death = {
	"npc/erectus/die.wav"
}

ENT.NextSoundTime_Breath = VJ_Set(1.05,1.05)
ENT.NextSoundTime_Idle = VJ_Set(1,2)

ENT.BeforeMeleeAttackSoundLevel = 70

ENT.BHLCIE_Erectus_Raged = false
/*
npc/erectus/enrage.wav
npc/erectus/rageloop.wav
npc/erectus/enrageend.wav

npc/erectus/taller_player_impact.wav
npc/erectus/taller_player_punch.wav
npc/erectus/taller_stamp.wav
npc/erectus/taller_swing.wav
npc/erectus/taller_wall_punch.wav
*/
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	-- self:SetCollisionBounds(Vector(50, 50, 100), Vector(-50, -50, 0)) -- Collision bounds of the NPC | WARNING: All 4 Xs and Ys should be the same!
	-- self:SetSurroundingBounds(Vector(-300, -300, 0), Vector(300, 300, 500)) -- Damage bounds of the NPC, doesn't effect collision or OBB | NOTE: Only set this if the base one is not good enough! | Use "cl_ent_absbox" to view the bounds
	self:SetModelScale(2)

	self.PreLaunchLight = ents.Create("light_dynamic")
	self.PreLaunchLight:SetKeyValue("brightness", "2")
	self.PreLaunchLight:SetKeyValue("distance", "250")
	self.PreLaunchLight:SetLocalPos(self:GetPos())
	self.PreLaunchLight:SetLocalAngles(self:GetAngles())
	self.PreLaunchLight:Fire("Color", "255 0 0 255")
	self.PreLaunchLight:SetParent(self)
	self.PreLaunchLight:Spawn()
	self.PreLaunchLight:Activate()
	self.PreLaunchLight:Fire("SetParentAttachment","chest")
	self.PreLaunchLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.PreLaunchLight)

	self.ChestGlow1 = ents.Create("env_sprite")
	self.ChestGlow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	self.ChestGlow1:SetKeyValue("scale", "0.35")
	self.ChestGlow1:SetKeyValue("rendermode","5")
	self.ChestGlow1:SetKeyValue("rendercolor","142 0 0 255")
	self.ChestGlow1:SetKeyValue("spawnflags","1") -- If animated
	self.ChestGlow1:SetParent(self)
	self.ChestGlow1:Fire("SetParentAttachment", "chest")
	self.ChestGlow1:Spawn()
	self.ChestGlow1:Activate()
	self:DeleteOnRemove(self.ChestGlow1)
	
	self.ChestGlow2 = ents.Create("env_sprite")
	self.ChestGlow2:SetKeyValue("model","sprites/blueflare1.vmt")
	self.ChestGlow2:SetKeyValue("scale", "0.35")
	self.ChestGlow2:SetKeyValue("rendermode","5")
	self.ChestGlow2:SetKeyValue("rendercolor","255 0 0 255")
	self.ChestGlow2:SetKeyValue("spawnflags","1") -- If animated
	self.ChestGlow2:SetParent(self)
	self.ChestGlow2:Fire("SetParentAttachment", "chest")
	self.ChestGlow2:Spawn()
	self.ChestGlow2:Activate()
	self:DeleteOnRemove(self.ChestGlow2)
	
	self.ChestGlow3 = ents.Create("env_sprite")
	self.ChestGlow3:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
	self.ChestGlow3:SetKeyValue("scale", "0.35")
	self.ChestGlow3:SetKeyValue("rendermode","5")
	self.ChestGlow3:SetKeyValue("rendercolor","255 0 0 255")
	self.ChestGlow3:SetKeyValue("spawnflags","1") -- If animated
	self.ChestGlow3:SetParent(self)
	self.ChestGlow3:Fire("SetParentAttachment", "chest")
	self.ChestGlow3:Spawn()
	self.ChestGlow3:Activate()
	self:DeleteOnRemove(self.ChestGlow3)

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
 -- util.ScreenShake( Vector pos, number amplitude, number frequency, number duration, number radius, boolean airshake = false )
		util.ScreenShake(self:GetPos(), 5, 5, 1, 350)
	end
	if key == "attack" then
		self.MeleeAttackDamage = 50
		self.MeleeAttackDamageType = DMG_CLUB -- Type of Damage
		self.SoundTbl_MeleeAttackMiss = {"npc/erectus/taller_swing.wav"}
		self.SoundTbl_MeleeAttackExtra = {"npc/erectus/taller_player_punch.wav"}
		self:MeleeAttackCode()
	end
	if key == "stomp" then

		self.MeleeAttackDamage = 150
		self.MeleeAttackDamageType = DMG_CRUSH -- Type of Damage
		self.SoundTbl_MeleeAttackMiss = {"npc/erectus/taller_wall_punch.wav"}
		self.SoundTbl_MeleeAttackExtra = {"npc/erectus/taller_stamp.wav"}

		util.ScreenShake(self:GetPos(), 10, 5, 1, 350)

		self:MeleeAttackCode()

		util.VJ_SphereDamage(self, self, self:GetPos(), 100, 15, DMG_PHYSGUN, true, true, {DisableVisibilityCheck=true, Force=8110})

		ParticleEffect("strider_impale_ground",self:GetPos(),Angle(0,0,0),nil)
		ParticleEffect("strider_cannon_impact",self:GetPos(),Angle(0,0,0),nil)

		VJ_EmitSound(self,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))

		local effectData = EffectData()
		-- effectData:SetOrigin(self:GetPos()+self:GetForward()*90+self:GetRight()*8)
		effectData:SetOrigin(self:GetPos())
		effectData:SetScale(200)
		util.Effect("ThumperDust", effectData)

		for _, v in ipairs(ents.FindInSphere(self:GetPos(), 100)) do
			if v:IsPlayer() and v:Alive() then
				v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,300))
			end
		end

	end
	if key == "death" then

		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25)
		bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
		bloodeffect:SetScale(200)
		util.Effect("VJ_Blood1",bloodeffect)

		util.VJ_SphereDamage(self, self, self:GetPos(), 150, 20, DMG_PHYSGUN, true, true, {DisableVisibilityCheck=true, Force=8110})

		ParticleEffect("strider_impale_ground",self:GetPos(),Angle(0,0,0),nil)
		ParticleEffect("strider_cannon_impact",self:GetPos(),Angle(0,0,0),nil)

		VJ_EmitSound(self,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))

		local effectData = EffectData()
		-- effectData:SetOrigin(self:GetPos()+self:GetForward()*90+self:GetRight()*8)
		effectData:SetOrigin(self:GetPos())
		effectData:SetScale(200)
		util.Effect("ThumperDust", effectData)

		for _, v in ipairs(ents.FindInSphere(self:GetPos(), 150)) do
			if v:IsPlayer() and v:Alive() then
				v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,350))
			end
		end

	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if (self:Health() < (self:GetMaxHealth() * 0.5)) && !self.BHLCIE_Erectus_Raged && !self.Dead then

		self.BHLCIE_Erectus_Raged = true

		self.AnimTbl_Run = {ACT_RUN}

		self.HasBreathSound = true

		VJ_EmitSound(self,{"npc/erectus/enrage.wav"},100,100)
		VJ_EmitSound(self,{"npc/erectus/die.wav"},80,math.random(100,90))

		self.PreLaunchLight:SetKeyValue("distance", "1000")

		self.EyeGlow1 = ents.Create("env_sprite")
		self.EyeGlow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		self.EyeGlow1:SetKeyValue("scale", "0.05")
		self.EyeGlow1:SetKeyValue("rendermode","5")
		self.EyeGlow1:SetKeyValue("rendercolor","142 0 0 255")
		self.EyeGlow1:SetKeyValue("spawnflags","1") -- If animated
		self.EyeGlow1:SetParent(self)
		self.EyeGlow1:Fire("SetParentAttachment", "eyeglow1")
		self.EyeGlow1:Spawn()
		self.EyeGlow1:Activate()
		self:DeleteOnRemove(self.EyeGlow1)

		self.EyeGlow2 = ents.Create("env_sprite")
		self.EyeGlow2:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		self.EyeGlow2:SetKeyValue("scale", "0.05")
		self.EyeGlow2:SetKeyValue("rendermode","5")
		self.EyeGlow2:SetKeyValue("rendercolor","142 0 0 255")
		self.EyeGlow2:SetKeyValue("spawnflags","1") -- If animated
		self.EyeGlow2:SetParent(self)
		self.EyeGlow2:Fire("SetParentAttachment", "eyeglow2")
		self.EyeGlow2:Spawn()
		self.EyeGlow2:Activate()
		self:DeleteOnRemove(self.EyeGlow2)

	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
	self.ChestGlow1:Fire("Kill", "", 0.1)
	self.ChestGlow2:Fire("Kill", "", 0.1)
	self.ChestGlow3:Fire("Kill", "", 0.1)
	self.PreLaunchLight:Fire("Kill", "", 0)
	if self.BHLCIE_Erectus_Raged then
		self.EyeGlow1:Fire("Kill", "", 0.1)
		self.EyeGlow2:Fire("Kill", "", 0.1)
		VJ_EmitSound(self,{"npc/erectus/enrageend.wav"},100,100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*25)
	bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
	bloodeffect:SetScale(200)
	util.Effect("VJ_Blood1",bloodeffect)
end