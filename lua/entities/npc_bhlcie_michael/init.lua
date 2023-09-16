AddCSLuaFile("shared.lua")
include('shared.lua')
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/vj_bhlcie/michael_davies.mdl"}
ENT.StartHealth = 150
ENT.HullType = HULL_HUMAN

ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_DEMON"}

ENT.BloodColor = "Red"

ENT.AlwaysWander = true

ENT.MeleeAttackDamage = 50
ENT.AnimTbl_MeleeAttack = {"vjseq_BR2_Attack"}
ENT.MeleeAttackDistance = 35
ENT.MeleeAttackDamageDistance = 75
ENT.TimeUntilMeleeAttackDamage = 0.6

ENT.FootStepTimeRun = 0.25

ENT.AlertSoundLevel = 100

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100

ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_MeleeAttack = {
	"player/pz/hit/zombie_slice_1.wav",
	"player/pz/hit/zombie_slice_2.wav",
	"player/pz/hit/zombie_slice_3.wav",
	"player/pz/hit/zombie_slice_4.wav",
	"player/pz/hit/zombie_slice_5.wav",
	"player/pz/hit/zombie_slice_6.wav"
}
ENT.SoundTbl_Warn = {
	"npc/michael_davies/I_have_the_body_of_a_pig.mp3",
	"npc/michael_davies/Run_run_run.mp3",
	"npc/michael_davies/Suffer.mp3",
	"npc/michael_davies/Carnage.mp3",
	"npc/michael_davies/Worship_me.mp3",
	"npc/michael_davies/En_nombre_de_jesus.mp3",
	"npc/michael_davies/Corruption_thou_art_my_father.mp3",
	"npc/michael_davies/Blood.mp3"
}
ENT.SoundTbl_Flee = {
	"npc/michael_davies/Father.mp3",
	"npc/michael_davies/Noooo.mp3",
	"npc/michael_davies/Aaaaaaaaaaaaaa.mp3",
	"npc/michael_davies/I_go_unwillingly.mp3",
	"npc/michael_davies/You_know_nothing.mp3",
	"npc/michael_davies/Por_la_cruz_invertida.mp3",
	"npc/michael_davies/La_sangre_de_puta_madre.mp3",
	"npc/michael_davies/Que_te_cojan_mil_cabras.mp3"
}

ENT.BHLCIE_Michael_CurrentMode = 0
ENT.BHLCIE_Michael_HideTime = 0
ENT.BHLCIE_Michael_PlayedWarnSound = false
ENT.BHLCIE_Michael_TimesFendedOff = 1
/*
0 - Attack Mode
1 - Fleeing
2 - Hiding
*/
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	self.StartHealth = self.StartHealth * player.GetCount()
	self:SetHealth(self.StartHealth)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" then
		VJ.EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
	elseif key == "melee" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()

	if self.BHLCIE_Michael_CurrentMode == 0 && !self.BHLCIE_Michael_PlayedWarnSound && self:GetEnemy() != nil && self:Visible(self:GetEnemy()) then

		VJ_EmitSound(self,self.SoundTbl_Warn,100,100)
		self.BHLCIE_Michael_PlayedWarnSound = true

	end

	if self.BHLCIE_Michael_CurrentMode == 1 then

		local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos()) -- distance check

		if (self:GetEnemy() == nil or !self:Visible(self:GetEnemy())) && enemydist >= 250 then

			-- self.FindEnemy_CanSeeThroughWalls = true
			self:SetMaterial("hud/killicons/default")
			self:DrawShadow(false)
			self:RemoveAllDecals()
			self.BHLCIE_Michael_HideTime = CurTime() + math.random(30,180)
			-- self.BHLCIE_Michael_HideTime = CurTime() + math.random(5,10)
			self.BHLCIE_Michael_CurrentMode = 2
			self.HasFootStepSound = false

		end

	end

	if self.BHLCIE_Michael_CurrentMode == 2 && self.BHLCIE_Michael_HideTime < CurTime() then
		if self:GetEnemy() != nil then
			local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos()) -- distance check
			if self:GetEnemy() != nil && (!self:Visible(self:GetEnemy()) && enemydist >= 1000 or !(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60)))) then

				self.FindEnemy_CanSeeThroughWalls = false
				self.FindEnemy_UseSphere = false
				self:SetMaterial(nil)
				self:DrawShadow(true)
				self:RemoveAllDecals()
				self.BHLCIE_Michael_CurrentMode = 0
				self.HasFootStepSound = true
				self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
				self.BHLCIE_Michael_PlayedWarnSound = false
				self.GodMode = false
				
				self:SetRenderFX(0)
				local thefunny = Color(255, 255, 255, 255)
				self:SetColor(thefunny)

				self:SetHealth(self.StartHealth * self.BHLCIE_Michael_TimesFendedOff)

			else
				self.BHLCIE_Michael_HideTime = CurTime() + 5
			end
		end
	end

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

	if (self:Health() - dmginfo:GetDamage()) <= 0 && self.Dead == false then

		VJ_EmitSound(self,self.SoundTbl_Flee,100,100)

		self.GodMode = true
		self:SetHealth(self.StartHealth)
		timer.Simple(0.15, function() if IsValid(self) then
			self:SetHealth(self.StartHealth)
		end end)
		self.BHLCIE_Michael_TimesFendedOff = self.BHLCIE_Michael_TimesFendedOff + 0.25

		self.BHLCIE_Michael_CurrentMode = 1
		self.Behavior = VJ_BEHAVIOR_PASSIVE
		self.FindEnemy_UseSphere = true

		self:SetRenderFX(16)
		local thefunny = Color(200, 200, 200, 200)
		self:SetColor(thefunny)
			self:SetMaterial("models/wireframe")

	end

end