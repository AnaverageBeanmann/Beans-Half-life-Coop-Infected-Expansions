AddCSLuaFile("shared.lua")
include('shared.lua')
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/vj_bhlcie/follower.mdl"}
ENT.StartHealth = 1000
ENT.HullType = HULL_HUMAN

ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_DEMON"}

ENT.BloodColor = "Red"

ENT.AlwaysWander = true

ENT.CallForHelp = false
ENT.FindEnemy_CanSeeThroughWalls = true
ENT.FindEnemy_UseSphere = true

ENT.HasMeleeAttack = true
ENT.MeleeAttackDamageType = DMG_CRUSH
ENT.AnimTbl_MeleeAttack = {"vjseq_attack"}
ENT.MeleeAttackDistance = 75
ENT.MeleeAttackDamageDistance = 110
ENT.TimeUntilMeleeAttackDamage = false

ENT.HasLeapAttack = true
ENT.AnimTbl_LeapAttack = {"vjseq_attack_range"}
ENT.TimeUntilLeapAttackDamage = nil
ENT.TimeUntilLeapAttackVelocity = nil
ENT.LeapDistance = 1000 -- This is how far away it can shoot
ENT.LeapToMeleeDistance = 300 -- How close does it have to be until it uses melee?
ENT.LeapAttackVelocityForward = -400 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = -1 -- How much upward force should it apply?
ENT.NextLeapAttackTime = 10 -- How much time until it can use any attack again? | Counted in Seconds
ENT.NextLeapAttackTime_DoRand = 20 -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.DisableDefaultLeapAttackDamageCode = true -- Disables the default leap attack damage code

ENT.AnimTbl_Walk = {ACT_RUN}

ENT.DisableFootStepSoundTimer = true

ENT.FootStepSoundLevel = 80
ENT.AlertSoundLevel = 100
ENT.IdleSoundLevel = 80
ENT.ExtraMeleeAttackSoundLevel = 80
ENT.MeleeAttackMissSoundLevel = 80

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds

ENT.SoundTbl_FootStep = {
	"npc/follower/step_1.mp3",
	"npc/follower/step_2.mp3",
	"npc/follower/step_3.mp3",
	"npc/follower/step_4.mp3",
	"npc/follower/step_5.mp3",
	"npc/follower/step_6.mp3"
}
ENT.SoundTbl_Idle = {
	"npc/follower/idle1.mp3",
	"npc/follower/idle2.mp3"
}
ENT.SoundTbl_Alert = {
	"npc/follower/alert1.mp3",
	"npc/follower/alert2.mp3",
	"npc/follower/alert3.mp3"
}
ENT.SoundTbl_MeleeAttack = {
	"npc/follower/impact1.mp3",
	"npc/follower/impact2.mp3"
}
ENT.SoundTbl_MeleeAttackExtra = {
	"npc/follower/concrete_break2.wav",
	"npc/follower/concrete_break3.wav"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"npc/follower/impact1.mp3",
	"npc/follower/impact2.mp3"
}

ENT.BHLCIE_Follower_CurrentMode = 0
/*
0 - Attack Mode
1 - Hiding
*/
ENT.BHLCIE_Follower_HideTime = 0
ENT.BHLCIE_Follower_Difficulty = 1
/*
1 - Easy
2 - Medium
3 - Hard
*/
ENT.BHLCIE_Follower_UnCloaking = false
ENT.BHLCIE_Follower_Cloaking = false
ENT.BHLCIE_Follower_CloakLevel = 256
ENT.BHLCIE_Follower_ResetCloak = false
ENT.BHLCIE_Follower_Smoking = false
ENT.BHLCIE_Follower_SmokeTime = 0
ENT.BHLCIE_Follower_RangeLocation = nil
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()

	self.AnimTbl_Run = {ACT_WALK}

	self.MeleeAttackDamage = 45

	self.BHLCIE_Follower_Difficulty = GetConVar("hl1_coop_sv_skill"):GetInt()

	if self.BHLCIE_Follower_Difficulty == 4 then

		self.BHLCIE_Follower_Difficulty = 3

	end

	if self.BHLCIE_Follower_Difficulty == 3 then -- Hard

		self.StartHealth = 3000

		self.AnimTbl_Run = {ACT_SPRINT}

		self.MeleeAttackDamage = 75

	elseif self.BHLCIE_Follower_Difficulty == 2 then -- Medium

		self.StartHealth = 2000

		self.AnimTbl_Run = {ACT_RUN}

		self.MeleeAttackDamage = 60

	end

	-- self.StartHealth = self.StartHealth * player.GetCount()
	-- self.StartHealth = self.StartHealth * player.GetCount() * 0.5

	self:SetHealth(self.StartHealth)

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

	self.GodMode = true
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.CanTurnWhileStationary = false
	self:SetMaterial("hud/killicons/default")
	self:DrawShadow(false)
	self.HasSounds = false
	self.HasMeleeAttack = false
	self.HasLeapAttack = false
	self:SetSolid(SOLID_NONE)

	timer.Simple(1,function() if IsValid(self) then

		VJ_EmitSound(self,"ambient/fire/ignite.wav",70,50)
		self.BHLCIE_Follower_Smoking = true

	end end)

	timer.Simple(5,function() if IsValid(self) then
		self:SetColor(Color(255, 255, 255, 0))
		self:VJ_ACT_PLAYACTIVITY({"vjseq_extra"},true,false,false)
		self.BHLCIE_Follower_UnCloaking = true
		self.GodMode = false
		self.MovementType = VJ_MOVETYPE_GROUND
		self.CanTurnWhileStationary = true
		self.HasMeleeAttack = true
		self.HasLeapAttack = true
		-- constraint.NoCollide(self,ents.FindByClass("npc_vj_*"))
	end end)

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel)
		util.ScreenShake(self:GetPos(), 5, 5, 1, 350)
	end
	if key == "attack" then
		self:MeleeAttackCode()
	end
	if key == "attack_shockwave" then

		local pos = self:LocalToWorld(Vector(90,8,0))

		if self.BHLCIE_Follower_Difficulty == 3 then
			util.VJ_SphereDamage(self, self, pos, 100, 20, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110})
		elseif self.BHLCIE_Follower_Difficulty == 2 then
			util.VJ_SphereDamage(self, self, pos, 100, 15, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110})
		else
			util.VJ_SphereDamage(self, self, pos, 100, 10, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110})
		end

		util.ScreenShake(self:GetPos(), 100, 200, 3, 500)

		for _, v in ipairs(ents.FindInSphere(pos, 100)) do
			if v:IsPlayer() and v:Alive() then
				v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,350))
			end
		end

		ParticleEffect("strider_impale_ground",pos,Angle(0,0,0),nil)
		ParticleEffect("strider_cannon_impact",pos,Angle(0,0,0),nil)

		VJ_EmitSound(self,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))

		local effectData = EffectData()
		effectData:SetOrigin(self:GetPos()+self:GetForward()*90+self:GetRight()*8)
		effectData:SetScale(200)
		util.Effect("ThumperDust", effectData)

	end
	if key == "follower_raise" then
		VJ_EmitSound(self,"npc/follower/raiseweapon"..math.random(1,4)..".mp3",75)
	end
	if key == "follower_woosh" then
		VJ_EmitSound(self,"npc/follower/swing"..math.random(1,4)..".mp3",75)
	end
	if key == "follower_requip" then
		VJ_EmitSound(self,"npc/follower/lowerweapon"..math.random(1,4)..".mp3",75)
	end
	if key == "follower_rumble" then

		if !IsValid(self:GetEnemy()) then return end

		local dummyEnt = ents.Create("prop_dynamic")
		if IsValid(dummyEnt) then
			dummyEnt:SetPos(self:GetEnemy():GetPos())
			dummyEnt:SetModel("models/Gibs/HGIBS.mdl")
			dummyEnt:Spawn()
			dummyEnt:SetMoveType(MOVETYPE_NONE)
			dummyEnt:SetSolid(SOLID_NONE)

			dummyEnt:SetMaterial("models/debug/debugwhite")
			dummyEnt:SetRenderFX( 16 )
			dummyEnt:SetRenderMode( RENDERMODE_TRANSCOLOR )
			dummyEnt:SetColor(Color(255, 0, 0, 255))
			effects.BeamRingPoint(dummyEnt:GetPos()+dummyEnt:GetUp()*5, 0.80, 0, 200, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
			timer.Simple(0.80,function() if IsValid(dummyEnt) then
				effects.BeamRingPoint(dummyEnt:GetPos()+dummyEnt:GetUp()*5, 0.80, 0, 200, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
			end end)
			timer.Simple(1.60,function() if IsValid(dummyEnt) then
				effects.BeamRingPoint(dummyEnt:GetPos()+dummyEnt:GetUp()*5, 0.80, 0, 200, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
			end end)

			VJ_EmitSound(dummyEnt,{"npc/antlion/rumble1.wav"},70,math.random(100,90))
			util.ScreenShake(dummyEnt:GetPos(), 100, 100, 5, 250)
			timer.Simple(2.5,function() if IsValid(dummyEnt) then

				if self.BHLCIE_Follower_Difficulty == 3 then
					util.VJ_SphereDamage(self, self, dummyEnt:GetPos(), 175, 40, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110, UpForce=8110})
				elseif self.BHLCIE_Follower_Difficulty == 2 then
					util.VJ_SphereDamage(self, self, dummyEnt:GetPos(), 175, 30, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110, UpForce=8110})
				else
					util.VJ_SphereDamage(self, self, dummyEnt:GetPos(), 175, 20, DMG_CRUSH, true, true, {DisableVisibilityCheck=true, Force=8110, UpForce=8110})
				end

				util.ScreenShake(dummyEnt:GetPos(), 175, 200, 3, 500)

				for _, v in ipairs(ents.FindInSphere(dummyEnt:GetPos(), 175)) do
					if v:IsPlayer() and v:Alive() then
						v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,500))
					end
				end

				ParticleEffect("strider_impale_ground",dummyEnt:GetPos(),Angle(0,0,0),nil)
				ParticleEffect("strider_cannon_impact",dummyEnt:GetPos(),Angle(0,0,0),nil)

				VJ_EmitSound(dummyEnt,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))
				VJ_EmitSound(dummyEnt,{"npc/follower/concrete_break"..math.random(2,3)..".wav"},100,math.random(100,90))

				local effectData = EffectData()
				effectData:SetOrigin(dummyEnt:GetPos())
				effectData:SetScale(250)
				util.Effect("ThumperDust", effectData)

				dummyEnt:Remove()
			end end)
		end
	end
	if key == "whoosh" then
		VJ_EmitSound(self,"physics/nearmiss/whoosh_huge2.wav",75)
	end
	if key == "follower_shhh" then
		VJ_EmitSound(self,"npc/follower/idle"..math.random(1,2)..".mp3",80,100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()

	if self.BHLCIE_Follower_UnCloaking == true then
		if !self.BHLCIE_Follower_ResetCloak then
			self.BHLCIE_Follower_ResetCloak = true
			self.BHLCIE_Follower_CloakLevel = 0
			self:SetRenderMode( RENDERMODE_TRANSCOLOR )
			self:SetMaterial("")
		end
		self.BHLCIE_Follower_CloakLevel = self.BHLCIE_Follower_CloakLevel + 5
		self:SetColor(Color(255, 255, 255, self.BHLCIE_Follower_CloakLevel))
		if self.BHLCIE_Follower_CloakLevel >= 255 then
			self.BHLCIE_Follower_UnCloaking = false
			self:SetColor(Color(255, 255, 255, 255))
			self:DrawShadow(true)
			self.HasSounds = true
			self:SetSolid(SOLID_BBOX)

			self.CanTurnWhileStationary = true
			self.HasMeleeAttack = true
			self.HasLeapAttack = true
			self.HasSounds = true

		end
	end

	if self.BHLCIE_Follower_Cloaking == true then
		if !self.BHLCIE_Follower_ResetCloak then
			self.BHLCIE_Follower_ResetCloak = true
			self.BHLCIE_Follower_CloakLevel = 255
			self:SetRenderMode( RENDERMODE_TRANSCOLOR )
		end
		self.BHLCIE_Follower_CloakLevel = self.BHLCIE_Follower_CloakLevel - 5
		self:SetColor(Color(255, 255, 255, self.BHLCIE_Follower_CloakLevel))
		if self.BHLCIE_Follower_CloakLevel <= 0 then
			self.BHLCIE_Follower_Cloaking = false
			self:SetColor(Color(255, 255, 255, 0))
			self:DrawShadow(false)
			self.HasSounds = false
		end
	end

	if self.BHLCIE_Follower_Smoking == true then
		if self.BHLCIE_Follower_SmokeTime < CurTime() then
			ParticleEffect("generic_smoke",self:GetPos(),self:GetAngles(),self)
			self.BHLCIE_Follower_SmokeTime = CurTime() + 1
		end
		timer.Simple(10,function() if IsValid(self) then
			self.BHLCIE_Follower_Smoking = false
			self:SetSolid(SOLID_BBOX)
		end end)
	end

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()

	if self.BHLCIE_Follower_CurrentMode == 1 then -- we're hiding

		if self.BHLCIE_Follower_HideTime < CurTime() then

			self.BHLCIE_Follower_CurrentMode = 0

			timer.Simple(1,function() if IsValid(self) then

				self.BHLCIE_Follower_ResetCloak = false

				self.BHLCIE_Follower_UnCloaking = true

				self:SetPos(Vector(6704.903320, -2236.514160, 384.031250))

				self.MovementType = VJ_MOVETYPE_GROUND

				self:VJ_ACT_PLAYACTIVITY({"vjseq_extra"},true,false,false)

				VJ_EmitSound(self,"ambient/fire/ignite.wav",70,50)

				timer.Simple(0.01,function() if IsValid(self) then
					self.BHLCIE_Follower_Smoking = true
				end end)

			end end)

		end

	end

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

	if (self:Health() - dmginfo:GetDamage()) <= 0 && self.Dead == false then -- if we take lethal damage then..

		dmginfo:ScaleDamage(0) -- to avoid him actually dying

		self:DrawShadow(false)

		VJ_EmitSound(self,"ambient/fire/ignite.wav",70,50)
		self.BHLCIE_Follower_Smoking = true

		self.BHLCIE_Follower_Cloaking = true
		self.BHLCIE_Follower_ResetCloak = false

		self:SetSolid(SOLID_NONE)

		self:VJ_ACT_PLAYACTIVITY({"vjseq_extra"},true,false,false)
		self.MovementType = VJ_MOVETYPE_STATIONARY
		self.HasMeleeAttack = false
		self.HasLeapAttack = false

		self:SetHealth(self.StartHealth)
		self.GodMode = true
		timer.Simple(0.15, function() if IsValid(self) then
			self:SetHealth(self.StartHealth)
		end end)

		timer.Simple(5,function() if IsValid(self) then
			if self.BHLCIE_Follower_Difficulty == 3 then
				self.BHLCIE_Follower_HideTime = CurTime() + math.random(60,180)
			elseif self.BHLCIE_Follower_Difficulty == 2 then
				self.BHLCIE_Follower_HideTime = CurTime() + math.random(90,240)
			else
				self.BHLCIE_Follower_HideTime = CurTime() + math.random(120,300)
				-- self.BHLCIE_Follower_HideTime = CurTime() + math.random(5,10)
			end
			self:SetPos(Vector(4365.166016, 10242.131836, -6495.968750))
			self.BHLCIE_Follower_CurrentMode = 1
		end end)

	end

end