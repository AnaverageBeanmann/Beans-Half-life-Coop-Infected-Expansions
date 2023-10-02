AddCSLuaFile("shared.lua")
include('shared.lua')
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/vj_bhlcie/demons/horror.mdl"}
ENT.StartHealth = 50
ENT.HullType = HULL_HUMAN

ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_DEMON"}

ENT.BloodColor = "Red"

ENT.AlwaysWander = true

ENT.MeleeAttackDamage = 0
ENT.AnimTbl_MeleeAttack = {"vjseq_BR2_Attack"}
ENT.MeleeAttackDistance = 50
ENT.MeleeAttackDamageDistance = 75
ENT.TimeUntilMeleeAttackDamage = false
ENT.DisableMeleeAttackAnimation = true

ENT.AnimTbl_Walk = {ACT_RUN}

ENT.FindEnemy_UseSphere = true
ENT.FindEnemy_CanSeeThroughWalls = true

ENT.DisableFootStepSoundTimer = true

ENT.HasDeathRagdoll = false

ENT.BreathSoundLevel = 75
ENT.AlertSoundLevel = 90
ENT.PainSoundLevel = 90
ENT.DeathSoundLevel = 90

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100

ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_Breath = {"npc/horror/sjasact.wav"}
ENT.SoundTbl_Alert = {"npc/horror/sjassee.wav"}
ENT.SoundTbl_Pain = {"npc/horror/sjaspain.wav"}
ENT.SoundTbl_Death = {"npc/horror/sjasdeat.wav"}

ENT.NextSoundTime_Breath = VJ_Set(0.35,0.35)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeStartTimer(seed)
	effects.BeamRingPoint(self:GetPos()+ self:GetUp()*45, 0.5, 0, 125, 5, 0, Color(50, 50, 50), {material="sprites/physgbeamb", framerate=20})
	effects.BeamRingPoint(self:GetPos()+ self:GetUp()*30, 0.5, 0, 175, 5, 0, Color(50, 50, 50), {material="sprites/physgbeamb", framerate=20})
	effects.BeamRingPoint(self:GetPos()+ self:GetUp()*15, 0.5, 0, 125, 5, 0, Color(50, 50, 50), {material="sprites/physgbeamb", framerate=20})
	VJ_EmitSound(self,"weapons/physcannon/energy_sing_explosion2.wav",90,math.random(110,125))
	util.ScreenShake(self:GetPos(), 5, 5, 1, 350)
-- function VJ.ApplyRadiusDamage(attacker, inflictor, startPos, dmgRadius, dmgMax, dmgType, ignoreInnocents, realisticRadius, extraOptions, customFunc)
	util.VJ_SphereDamage(self, self, self:GetPos(), 100, 25, DMG_PHYSGUN, true, true, {DisableVisibilityCheck=true, Force=8110})
	for _, v in ipairs(ents.FindInSphere(self:GetPos(), 100)) do
		if v:IsPlayer() and v:Alive() then
			v:ScreenFade(1,Color(0,0,0),3,0.1)
		end
	end
	self.SoundTbl_Death = {"npc/horror/sjasatta.wav"}
	local d = DamageInfo()
	d:SetDamage(self:GetMaxHealth())
	d:SetAttacker(self)
	d:SetDamageType(DMG_BLAST) 
	self:TakeDamageInfo(d)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() + self:GetUp()*40)
	bloodeffect:SetColor(VJ_Color2Byte(Color(25,25,25,255)))
	bloodeffect:SetScale(100)
	util.Effect("VJ_Blood1",bloodeffect)
end
---------------------------------------------------------------------------------------------------------------------------------------------