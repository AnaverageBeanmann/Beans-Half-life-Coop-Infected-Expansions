AddCSLuaFile("shared.lua")
include('shared.lua')
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/vj_bhlcie/michael_davies.mdl"}
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN

ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_DEMON"}

ENT.BloodColor = "Red"

ENT.AlwaysWander = true

ENT.MeleeAttackDamage = 50
ENT.AnimTbl_MeleeAttack = {"vjseq_BR2_Attack"}
ENT.MeleeAttackDistance = 35
ENT.MeleeAttackDamageDistance = 75
ENT.TimeUntilMeleeAttackDamage = 0.6

ENT.AnimTbl_Walk = {ACT_RUN}

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
/*
0 - Attack Mode
1 - Fleeing
2 - Hiding
*/
ENT.BHLCIE_Michael_HideTime = 0
ENT.BHLCIE_Michael_PlayedWarnSound = false
ENT.BHLCIE_Michael_TimesFendedOff = 1
ENT.BHLCIE_Michael_Patience = 0
ENT.BHLCIE_Michael_LostPatient = false
ENT.BHLCIE_Michael_Difficulty = 1
/*
1 - Easy
2 - Medium
3 - Hard
*/
ENT.BHLCIE_Michael_Difficulty_ChangeWarning = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	self.BHLCIE_Michael_Difficulty = GetConVar("hl1_coop_sv_skill"):GetInt()
	if self.BHLCIE_Michael_Difficulty == 3 then
		self.StartHealth = 300
	elseif self.BHLCIE_Michael_Difficulty == 2 then
		self.StartHealth = 200
	end
	self.StartHealth = self.StartHealth * player.GetCount()
	self:SetHealth(self.StartHealth)
	PrintMessage(4,"Michael's health is now "..self.StartHealth.."")
	-- PrintMessage(4,"Michael's difficulty is now "..self.BHLCIE_Michael_Difficulty.."")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	if self.BHLCIE_Michael_Difficulty == 3 then
		self.BHLCIE_Michael_Patience = CurTime() + math.random(5,10)
	elseif self.BHLCIE_Michael_Difficulty == 2 then
		self.BHLCIE_Michael_Patience = CurTime() + 30
	else
		self.BHLCIE_Michael_Patience = CurTime() + 60
	end
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

	if self.BHLCIE_Michael_CurrentMode == 0 then -- we're hunting!
		if !self.BHLCIE_Michael_PlayedWarnSound && self:GetEnemy() != nil && self:Visible(self:GetEnemy()) then -- check if we haven't played our warning sound and we have a valid and visible enemy
			-- play the warning sound
			VJ_EmitSound(self,self.SoundTbl_Warn,100,100)
			self.BHLCIE_Michael_PlayedWarnSound = true
		end
		if self.BHLCIE_Michael_Patience < CurTime() && !self.BHLCIE_Michael_LostPatient then -- if our patience counter has hit 0 and we haven't lost our patience..
			-- lose patience. michael is now omnipotenent
			self.BHLCIE_Michael_LostPatient = true
			self.FindEnemy_CanSeeThroughWalls = true
			self.FindEnemy_UseSphere = true
		end
	end

	if self.BHLCIE_Michael_CurrentMode == 1 then -- we're fleeing
		if self:GetEnemy() != nil then -- check if we have no valid enemy
			local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos()) -- distance check
			if !self:Visible(self:GetEnemy()) && enemydist >= 250 or !(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60))) then -- if we can't see our current enemy and they're far enough..
				-- go into hiding
				self:SetMaterial("hud/killicons/default")
				self:DrawShadow(false)
				self:RemoveAllDecals()
				if self.BHLCIE_Michael_Difficulty == 3 then
					self.BHLCIE_Michael_HideTime = CurTime() + math.random(10,60)
				elseif self.BHLCIE_Michael_Difficulty == 2 then
					self.BHLCIE_Michael_HideTime = CurTime() + math.random(20,120)
				else
					self.BHLCIE_Michael_HideTime = CurTime() + math.random(30,180)
				end
				self.BHLCIE_Michael_CurrentMode = 2
				self.HasFootStepSound = false
				self.FindEnemy_CanSeeThroughWalls = true
				self.FindEnemy_UseSphere = true
			end
		end
		if self:GetEnemy() == nil then -- if we have no valid enemy then..
			-- go into hiding
			self:SetMaterial("hud/killicons/default")
			self:DrawShadow(false)
			self:RemoveAllDecals()
			if self.BHLCIE_Michael_Difficulty == 3 then
				self.BHLCIE_Michael_HideTime = CurTime() + math.random(10,60)
			elseif self.BHLCIE_Michael_Difficulty == 2 then
				self.BHLCIE_Michael_HideTime = CurTime() + math.random(20,120)
			else
				self.BHLCIE_Michael_HideTime = CurTime() + math.random(30,180)
			end
			self.BHLCIE_Michael_CurrentMode = 2
			self.HasFootStepSound = false
		end

	end

	if self.BHLCIE_Michael_CurrentMode == 2 then -- we're hiding

		if self.BHLCIE_Michael_HideTime < CurTime() then -- if our hide time check hits 0 then..

			if IsValid(self:GetEnemy()) then -- if we have a valid enemy..

				local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos()) -- distance check

				if
					self:GetEnemy() != nil -- another valid enemy check?
						&&
					(
						!self:Visible(self:GetEnemy())
							&&
						(
							enemydist >= 1000
						or
							!(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60)))
						)
					)
					-- if our current enemy isn't visislbe and is far enough, or they're not looking at us, then..

				then

					-- go on the hunt!

					self.GodMode = false
					self.BHLCIE_Michael_CurrentMode = 0
					self.BHLCIE_Michael_LostPatient = false
					if self.BHLCIE_Michael_Difficulty == 3 then
						self.BHLCIE_Michael_Patience = CurTime() + math.random(5,10)
					elseif self.BHLCIE_Michael_Difficulty == 2 then
						self.BHLCIE_Michael_Patience = CurTime() + 30
					else
						self.BHLCIE_Michael_Patience = CurTime() + 60
					end
					self.FindEnemy_CanSeeThroughWalls = false
					self.FindEnemy_UseSphere = false
					self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
					self.BHLCIE_Michael_PlayedWarnSound = false
					self.HasFootStepSound = true

					self:SetMaterial(nil)
					self:DrawShadow(true)
					self:RemoveAllDecals()
					self:SetRenderFX(0)
					local thefunny = Color(255, 255, 255, 255)
					self:SetColor(thefunny)

					self:SetHealth(self.StartHealth * self.BHLCIE_Michael_TimesFendedOff)
					PrintMessage(4,"Michael's health is now "..self:Health().."")
				end

			else

				-- we didn't meet the requirements, keep hiding
				self.BHLCIE_Michael_HideTime = CurTime() + 3

			end

		end

	end

	if
		(
			self.BHLCIE_Michael_Difficulty == 1 && GetConVar("hl1_coop_sv_skill"):GetInt() != 1
		or
			self.BHLCIE_Michael_Difficulty == 2 && GetConVar("hl1_coop_sv_skill"):GetInt() != 2
		or
			self.BHLCIE_Michael_Difficulty == 3 && GetConVar("hl1_coop_sv_skill"):GetInt() != 3
		)
		&&
		self.BHLCIE_Michael_Difficulty_ChangeWarning
	then
		self.BHLCIE_Michael_Difficulty_ChangeWarning = false
		PrintMessage(4,"Please restart the match/map to get the full effect of changing the difficulty!")
	end

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

	if (self:Health() - dmginfo:GetDamage()) <= 0 && self.Dead == false then -- if we take lethal damage then..

		dmginfo:ScaleDamage(0.001) -- to avoid him actually dying

		-- flee!
		VJ_EmitSound(self,self.SoundTbl_Flee,100,100)

		self:SetHealth(self.StartHealth)
		self.GodMode = true
		timer.Simple(0.15, function() if IsValid(self) then
			self:SetHealth(self.StartHealth)
		end end)
		if self.BHLCIE_Michael_Difficulty == 3 then
			self.BHLCIE_Michael_TimesFendedOff = self.BHLCIE_Michael_TimesFendedOff + 0.45
		elseif self.BHLCIE_Michael_Difficulty == 2 then
			self.BHLCIE_Michael_TimesFendedOff = self.BHLCIE_Michael_TimesFendedOff + 0.30
		else
			self.BHLCIE_Michael_TimesFendedOff = self.BHLCIE_Michael_TimesFendedOff + 0.15
		end

		self.BHLCIE_Michael_CurrentMode = 1
		self.Behavior = VJ_BEHAVIOR_PASSIVE
		self.FindEnemy_UseSphere = true

		self:SetRenderFX(16)
		local thefunny = Color(200, 200, 200, 200)
		self:SetColor(thefunny)
		self:SetMaterial("models/wireframe")

	end

end