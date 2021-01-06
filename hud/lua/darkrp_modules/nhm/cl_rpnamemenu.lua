surface.CreateFont( "MainText", {
		font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 25,
		weight = 1000,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	})
surface.CreateFont( "MiniText", {
		font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 15,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	})

local function OpenSWMenu()
	local DTextEntry1, DTextEntry2, DButton1
	if NameMenu and NameMenu:IsValid() then NameMenu:Remove() end
	NameMenu = vgui.Create("DFrame")
	NameMenu:SetSize(350, 200)
	NameMenu:SetTitle("")
	NameMenu:Center()
	NameMenu:ShowCloseButton(false)
	NameMenu:MakePopup()
	NameMenu.Paint = function(self)
		draw.RoundedBox(1, 0, 0, self:GetWide(), self:GetTall(), Color(10, 10, 10, 240))
		local txt = "Сделайте себе позывной"
		surface.SetFont("MiniText")
		local x, y = surface.GetTextSize(txt)
		--draw.RoundedBox(8, self:GetWide()*0.5-x*0.5-4, 5, x+8, y, Color(49, 78, 85, 255))
		draw.SimpleText(txt, "MainText", self:GetWide()*0.5, 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		draw.SimpleText("Например: Timezel ; Moonya ; Gamerra", "MiniText", self:GetWide()*0.5, 35, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		
		--draw.SimpleText("Позывной", "MiniText", NameMenu:GetWide()*0.5, 137, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	end

	DTextEntry1 = vgui.Create("DTextEntry", NameMenu)
	DTextEntry1:SetSize(110, 20)
	DTextEntry1:SetPos(NameMenu:GetWide()*0.5-55, 60)
	DTextEntry1.Think = function(self)
	local text = self:GetValue()
	
	if text:len() < 3 then correct = false end
	if text:len() > 3 then correct = true end

	self.Correct = (text != " " and text != "" and text != "..." and text != ",,," and text != "[[[" and text != "'''" and text != "    " and text != "     ") and correct or false

	end

	DButton1 = vgui.Create("DButton", NameMenu)
	DButton1:SetSize(80, 25)
	DButton1:SetPos(NameMenu:GetWide()*0.5-DButton1:GetWide()*0.5, NameMenu:GetTall()*0.75)
	DButton1:SetText("")
	DButton1.Paint = function(self)
		--draw.RoundedBox(1, 0, 0, self:GetWide(), self:GetTall(), self.MouseOver and Color(200, 200, 200, 255) or Color(100, 0, 100, 255))
		draw.RoundedBox(1, 1, 1,self:GetWide()-2, self:GetTall()-2, !self:GetDisabled() and Color(30, 180, 0, 255) or Color(120, 120, 120, 255))
		draw.SimpleTextOutlined("Начать", "MiniText", self:GetWide()*0.5, 4.5, !self:GetDisabled() and Color(255, 255, 255, 255) or Color(180, 180, 180, 255), TEXT_ALIGN_CENTER, nil, 1.1, Color(0, 0, 0, 255))
	end
	DButton1.DoClick = function(self)
		if !DTextEntry1.Correct then return end
		net.Start("setmynumbernick")
		 net.WriteString(DTextEntry1:GetValue())
		 net.SendToServer()
		NameMenu:Remove()
	end
	DButton1.Think = function(self)
		if correct == false then
			self:SetDisabled(true)
			return
		else
			self:SetDisabled(false)
		end
	end
	DButton1.OnCursorEntered = function(self)
		self.MouseOver = true
	end
	DButton1.OnCursorExited = function(self)
		self.MouseOver = false
	end
end
usermessage.Hook("opennamemenu", OpenSWMenu)
concommand.Add("menusw", OpenSWMenu)