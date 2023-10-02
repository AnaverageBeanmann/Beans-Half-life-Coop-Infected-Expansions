AddCSLuaFile("shared.lua")
include('shared.lua')
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/vj_bhlcie/demons/preacher.mdl"}
ENT.StartHealth = 200
ENT.HullType = HULL_HUMAN

ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_DEMON"}

ENT.BloodColor = "Red"

ENT.AlwaysWander = true

ENT.HasMeleeAttack = false

ENT.HasRangeAttack = true
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.NextRangeAttackTime = 7
ENT.NextRangeAttackTime_DoRand = 9
ENT.DisableDefaultRangeAttackCode = true
ENT.DisableRangeAttackAnimation = true

ENT.FindEnemy_UseSphere = true
ENT.FindEnemy_CanSeeThroughWalls = true

ENT.DisableFootStepSoundTimer = true

ENT.AnimTbl_IdleStand = {ACT_IDLE_ON_FIRE}
ENT.AnimTbl_Walk = {ACT_WALK_ON_FIRE}
ENT.AnimTbl_Run = {ACT_WALK_ON_FIRE}

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.IdleSoundPitch = VJ_Set(60, 50)
ENT.AlertSoundPitch = VJ_Set(60, 50)
ENT.DeathSoundPitch  = VJ_Set(30, 40)
ENT.BreathSoundLevel = 75
ENT.NextSoundTime_Breath = VJ_Set(2,2)

ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_Breath = {"ambient/atmosphere/noise2.wav"}
ENT.SoundTbl_Alert = {"npc/zombie_poison/pz_call1.wav"}
ENT.SoundTbl_Idle = {
	"ambient/creatures/town_child_scream1.wav",
	"ambient/creatures/town_moan1.wav",
	"ambient/creatures/town_muffled_cry1.wav",
	"ambient/creatures/town_scared_breathing1.wav",
	"ambient/creatures/town_scared_breathing2.wav",
	"ambient/creatures/town_scared_sob1.wav",
	"ambient/creatures/town_scared_sob2.wav",
	"ambient/creatures/town_zombie_call1.wav",
	"ambient/voices/playground_memory.wav"
}
ENT.SoundTbl_Death = {
	"npc/stalker/go_alert2.wav"
}

ENT.BHLCIE_Preacher_Burning = false
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
	self.PreLaunchLight:Fire("SetParentAttachment","headportal")
	self.PreLaunchLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.PreLaunchLight)

	local ChestGlow1 = ents.Create("env_sprite")
	ChestGlow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	ChestGlow1:SetKeyValue("scale", "0.25")
	ChestGlow1:SetKeyValue("rendermode","5")
	ChestGlow1:SetKeyValue("rendercolor","142 0 0 255")
	ChestGlow1:SetKeyValue("spawnflags","1") -- If animated
	ChestGlow1:SetParent(self)
	ChestGlow1:Fire("SetParentAttachment", "headportal")
	ChestGlow1:Spawn()
	ChestGlow1:Activate()
	self:DeleteOnRemove(ChestGlow1)
	
	local ChestGlow2 = ents.Create("env_sprite")
	ChestGlow2:SetKeyValue("model","sprites/blueflare1.vmt")
	ChestGlow2:SetKeyValue("scale", "0.25")
	ChestGlow2:SetKeyValue("rendermode","5")
	ChestGlow2:SetKeyValue("rendercolor","255 0 0 255")
	ChestGlow2:SetKeyValue("spawnflags","1") -- If animated
	ChestGlow2:SetParent(self)
	ChestGlow2:Fire("SetParentAttachment", "headportal")
	ChestGlow2:Spawn()
	ChestGlow2:Activate()
	self:DeleteOnRemove(ChestGlow2)
	
	local ChestGlow3 = ents.Create("env_sprite")
	ChestGlow3:SetKeyValue("model","sprites/combineball_glow_black_1.vmt")
	ChestGlow3:SetKeyValue("scale", "0.25")
	ChestGlow3:SetKeyValue("rendermode","5")
	ChestGlow3:SetKeyValue("rendercolor","255 0 0 255")
	ChestGlow3:SetKeyValue("spawnflags","1") -- If animated
	ChestGlow3:SetParent(self)
	ChestGlow3:Fire("SetParentAttachment", "headportal")
	ChestGlow3:Spawn()
	ChestGlow3:Activate()
	self:DeleteOnRemove(ChestGlow3)

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if self.BHLCIE_Preacher_Burning then
		util.VJ_SphereDamage(self, self, self.dummyEnt:GetPos(), 125, 20, DMG_BURN, true, true, {DisableVisibilityCheck=true, Force=8110, UpForce=8110})
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRangeAttack_BeforeStartTimer(seed)

	if !IsValid(self:GetEnemy()) then return end

	self.dummyEnt = ents.Create("prop_dynamic")

	if IsValid(self.dummyEnt) then
		self.dummyEnt:SetPos(self:GetEnemy():GetPos())
		self.dummyEnt:SetModel("models/Gibs/HGIBS.mdl")
		self.dummyEnt:Spawn()
		self.dummyEnt:SetMoveType(MOVETYPE_NONE)
		self.dummyEnt:SetSolid(SOLID_NONE)

		self.dummyEnt:SetMaterial("models/debug/debugwhite")
		self.dummyEnt:SetRenderFX( 16 )
		self.dummyEnt:SetRenderMode( RENDERMODE_TRANSCOLOR )
		self.dummyEnt:SetColor(Color(255, 93, 0, 255))
		effects.BeamRingPoint(self.dummyEnt:GetPos()+self.dummyEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(255, 93, 0), {material="sprites/physgbeamb", framerate=20})
		timer.Simple(0.80,function() if IsValid(self.dummyEnt) then
			effects.BeamRingPoint(self.dummyEnt:GetPos()+self.dummyEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(255, 93, 0), {material="sprites/physgbeamb", framerate=20})
		end end)
		timer.Simple(1.60,function() if IsValid(self.dummyEnt) then
			effects.BeamRingPoint(self.dummyEnt:GetPos()+self.dummyEnt:GetUp()*5, 0.80, 0, 250, 5, 0, Color(255, 93, 0), {material="sprites/physgbeamb", framerate=20})
		end end)

		VJ_EmitSound(self.dummyEnt,{"npc/antlion/rumble1.wav"},70,math.random(100,90))
		util.ScreenShake(self.dummyEnt:GetPos(), 100, 100, 5, 250)
		timer.Simple(2.5,function() if IsValid(self.dummyEnt) then

			if IsValid(self) && !self.Dead then

				self.BHLCIE_Preacher_Burning = true

				util.ScreenShake(self.dummyEnt:GetPos(), 175, 200, 5, 500)
				for _, v in ipairs(ents.FindInSphere(self.dummyEnt:GetPos(), 175)) do
					if v:IsPlayer() and v:Alive() then
						v:SetLocalVelocity(v:GetVelocity()+Vector(0,0,500))
					end
				end

				-- local fire = ents.Create("ent_bhlcie_preacher_flame")
				-- fire:SetPos(self.dummyEnt:GetPos())
				-- fire:Spawn()

				ParticleEffect("strider_impale_ground",self.dummyEnt:GetPos(),Angle(0,0,0),nil)
				ParticleEffect("strider_cannon_impact",self.dummyEnt:GetPos(),Angle(0,0,0),nil)
				ParticleEffectAttach("fire_large_01",PATTACH_POINT_FOLLOW,self.dummyEnt,self.dummyEnt:LookupAttachment("origin"))

				VJ_EmitSound(self.dummyEnt,{"ambient/fire/ignite.wav"},100,math.random(100,90))
				VJ_EmitSound(self.dummyEnt,{"ambient/machines/thumper_dust.wav"},100,math.random(100,90))
				VJ_EmitSound(self.dummyEnt,{"npc/follower/concrete_break"..math.random(2,3)..".wav"},100,math.random(100,90))

				self.dummyEnt.PreLaunchLight = ents.Create("light_dynamic")
				self.dummyEnt.PreLaunchLight:SetKeyValue("brightness", "5")
				self.dummyEnt.PreLaunchLight:SetKeyValue("distance", "1000")
				self.dummyEnt.PreLaunchLight:SetLocalPos(self.dummyEnt:GetPos())
				self.dummyEnt.PreLaunchLight:SetLocalAngles(self.dummyEnt:GetAngles())
				self.dummyEnt.PreLaunchLight:Fire("Color", "255 93 0 255")
				self.dummyEnt.PreLaunchLight:SetParent(self.dummyEnt)
				self.dummyEnt.PreLaunchLight:Spawn()
				self.dummyEnt.PreLaunchLight:Activate()
				-- self.dummyEnt.PreLaunchLight:Fire("SetParentAttachment","origin")
				self.dummyEnt.PreLaunchLight:Fire("TurnOn", "", 0)
				self.dummyEnt:DeleteOnRemove(self.dummyEnt.PreLaunchLight)

				local effectData = EffectData()
				effectData:SetOrigin(self.dummyEnt:GetPos())
				effectData:SetScale(250)
				util.Effect("ThumperDust", effectData)
				
				timer.Simple(1,function() if IsValid(self.dummyEnt) then
					self.dummyEnt:StopParticles()
					self.dummyEnt:Remove()
					self.BHLCIE_Preacher_Burning = false
				end end)
			else
				self.dummyEnt:StopParticles()
				self.dummyEnt:Remove()
			end


		end end)
	end

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
	if IsValid(self.dummyEnt) then
		self.dummyEnt:StopParticles()
		self.dummyEnt:Remove()
	end
	VJ_EmitSound(self,{"ambient/levels/labs/teleport_postblast_thunder1.wav"},100,math.random(125,70))
	effects.BeamRingPoint(self:GetPos()+self:GetUp()*60, 0.80, 0, 75, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
	effects.BeamRingPoint(self:GetPos()+self:GetUp()*50, 0.80, 0, 100, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
	effects.BeamRingPoint(self:GetPos()+self:GetUp()*40, 0.80, 0, 75, 5, 0, Color(255, 0, 0), {material="sprites/physgbeamb", framerate=20})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if IsValid(self.dummyEnt) then
		self.dummyEnt:StopParticles()
		self.dummyEnt:Remove()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------