AddCSLuaFile("shared.lua")
include('shared.lua')
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/vj_bhlcie/demons/cultist2.mdl"}
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN

ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_DEMON"}

ENT.BloodColor = "Red"

ENT.AlwaysWander = true

ENT.MeleeAttackDamage = 15
ENT.MeleeAttackDistance = 35
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = false

ENT.FindEnemy_UseSphere = true
ENT.FindEnemy_CanSeeThroughWalls = true

ENT.DisableFootStepSoundTimer = true

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100

ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_Alert = {
	"npc/cultist/burn_in_hell.mp3",
	"npc/cultist/destroy_the_child.mp3",
	"npc/cultist/reap_what_you_sow.mp3",
	"npc/cultist/swear_by_his_throne.mp3",
	"npc/cultist/thy_faith_is_weak.mp3",
	"npc/cultist/we_know_what_you_did.mp3"
}
ENT.SoundTbl_MeleeAttack = {
	"weapons/knife/knife_hit1.wav",
	"weapons/knife/knife_hit2.wav",
	"weapons/knife/knife_hit3.wav",
	"weapons/knife/knife_hit4.wav"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"weapons/knife/knife_slash1.wav",
	"weapons/knife/knife_slash2.wav"
}
ENT.SoundTbl_Death = {
	"npc/cultist/death.mp3"
}

ENT.BHLCIE_Cultist_Sprinting = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	end
	if key == "attack" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	if math.random(1,3) == 1 then
		self:SetBodygroup(6,1)
	end
	if math.random(1,3) == 1 then
		self:SetBodygroup(7,1)
	end
	self.WeaponModel = ents.Create("prop_physics")	
	self.WeaponModel:SetModel("models/vj_bhlcie/demons/cultist_knife.mdl")
	self.WeaponModel:SetLocalPos(self:GetPos())
	self.WeaponModel:SetLocalAngles(self:GetAngles())			
	self.WeaponModel:SetOwner(self)
	self.WeaponModel:SetParent(self)
	self.WeaponModel:Fire("SetParentAttachmentMaintainOffset","anim_attachment_LH")
	self.WeaponModel:Fire("SetParentAttachment","anim_attachment_RH")
	self.WeaponModel:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self.WeaponModel:Spawn()
	self.WeaponModel:Activate()
	self.WeaponModel:SetSolid(SOLID_NONE)
	self.WeaponModel:AddEffects(EF_BONEMERGE)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()

	if self:GetEnemy() == nil then return end

	local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos())
	if enemydist <= 300 then
		if self.BHLCIE_Cultist_Sprinting then
			self.BHLCIE_Cultist_Sprinting = false
			self.AnimTbl_Run = {ACT_RUN}
		end
	else
		if !self.BHLCIE_Cultist_Sprinting then
			self.BHLCIE_Cultist_Sprinting = true
			self.AnimTbl_Run = {ACT_SPRINT}
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
	self:CreateGibEntity("prop_physics",self.WeaponModel:GetModel(),{Pos=self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos,Ang=self:GetAngles()})
	self:SetBodygroup(1,1)
	self:SetBodygroup(2,1)
end
---------------------------------------------------------------------------------------------------------------------------------------------