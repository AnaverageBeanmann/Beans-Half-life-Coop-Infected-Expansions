ENT.Type = "anim"
ENT.Author = "Upset, modified by An average Beanmann"
ENT.Spawnable = false

if CLIENT then
	function ENT:DoDrawText()
		draw.DrawText(self:GetClass(), "DermaDefault", 1, 1, Color(0, 0, 0, 150), TEXT_ALIGN_CENTER) 
		draw.DrawText(self:GetClass(), "DermaDefault", 0, 0, Color(255, 220, 50, 255), TEXT_ALIGN_CENTER)
	end
	
	function ENT:Draw()
		--[[local ang = self:GetAngles()
		local rot = math.sin(CurTime() * 5) + ang[2]
		cam.Start3D2D(self:GetPos(), Angle(0, rot, 90), 1)
			self:DoDrawText()
		cam.End3D2D()
		cam.Start3D2D(self:GetPos(), Angle(0, rot + 180, 90), 1)
			self:DoDrawText()
		cam.End3D2D()]]
	end
end