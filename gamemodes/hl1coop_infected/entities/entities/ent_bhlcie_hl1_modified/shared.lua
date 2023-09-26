ENT.Type = "anim"
ENT.Author = "Upset"
ENT.Spawnable = false

if CLIENT then
	function ENT:DoDrawText()
		draw.DrawText(self:GetClass(), "DermaDefault", 1, 1, Color(0, 0, 0, 150), TEXT_ALIGN_CENTER) 
		draw.DrawText(self:GetClass(), "DermaDefault", 0, 0, Color(255, 220, 50, 255), TEXT_ALIGN_CENTER)
	end
	
	function ENT:Draw()
	end
end