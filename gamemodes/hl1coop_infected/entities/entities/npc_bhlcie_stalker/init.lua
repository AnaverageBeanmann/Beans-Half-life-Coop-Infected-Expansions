AddCSLuaFile("shared.lua")
include('shared.lua')
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/vj_bhlcie/demons/stalker.mdl"}
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN

ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_DEMON"}

ENT.BloodColor = "Red"

ENT.AlwaysWander = true

ENT.MeleeAttackDamage = 15
ENT.AnimTbl_MeleeAttack = {"vjges_attack1","vjges_attack2","vjges_attack3"}
ENT.MeleeAttackDistance = 45
ENT.MeleeAttackDamageDistance = 70
ENT.TimeUntilMeleeAttackDamage = false

ENT.FindEnemy_UseSphere = true
ENT.FindEnemy_CanSeeThroughWalls = true

ENT.DisableFootStepSoundTimer = true

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.NextSoundTime_Breath = VJ_Set(6.9,6.9)

ENT.SoundTbl_FootStep = {
	"npc/stalker/stalker_footstep_left1.wav",
	"npc/stalker/stalker_footstep_left2.wav",
	"npc/stalker/stalker_footstep_right1.wav",
	"npc/stalker/stalker_footstep_right2.wav"
}
ENT.SoundTbl_Breath = {"player/breathe1.wav"}
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

ENT.BHLCIE_Stalker_Cloaked = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" && !self.BHLCIE_Stalker_Cloaked then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	end
	if key == "melee" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()

	if self:GetEnemy() == nil then return end

	local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos()) -- distance check

	if !self:Visible(self:GetEnemy()) && enemydist >= 250 or !(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60))) then -- if we can't see our current enemy and they're far enough..

		if self.BHLCIE_Stalker_Cloaked then

			local myCenterPos = self:GetPos() + self:OBBCenter()
			local tr1 = util.TraceLine({
				start = myCenterPos,
				endpos = myCenterPos + self:GetForward()*40,
				filter = self
			})
			local tr2 = util.TraceLine({
				start = myCenterPos,
				endpos = myCenterPos + self:GetForward()*-40,
				filter = self
			})
			local tr3 = util.TraceLine({
				start = myCenterPos,
				endpos = myCenterPos + self:GetRight()*40,
				filter = self
			})
			local tr4 = util.TraceLine({
				start = myCenterPos,
				endpos = myCenterPos + self:GetRight()*-40,
				filter = self
			})
			if
				!tr1.Hit
				&&
				!tr2.Hit
				&&
				!tr3.Hit
				&&
				!tr4.Hit
			then
				self.BHLCIE_Stalker_Cloaked = false
				self:RemoveAllDecals()
				self:SetRenderMode(0)
				local thefunny = Color(255, 255, 255, 255)
				self:SetColor(thefunny)
				self:DrawShadow(true)
				self.AnimTbl_Run = {ACT_RUN}
				self:SetSolid(SOLID_BBOX)
				self.GodMode = false
			end
		end
	else
		if !self.BHLCIE_Stalker_Cloaked then
			self.BHLCIE_Stalker_Cloaked = true
			self:RemoveAllDecals()
			self:SetRenderMode(1)
			local thefunny = Color(50, 50, 50, 50)
			self:SetColor(thefunny)
			self:DrawShadow(false)
			self.AnimTbl_Run = {ACT_WALK}
			self:SetSolid(SOLID_NONE)
			self.GodMode = true
		end
	end

end
---------------------------------------------------------------------------------------------------------------------------------------------