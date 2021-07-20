hud = {}
local BG = Color(0, 0, 0, 230)
local HealthBG = Color(99, 35, 35, 255)
local ArmorBG = Color(0, 70, 88, 255)

	surface.CreateFont( "Job", { font = "Tahoma", size = 25, weight = 600, antialias = true, })
	surface.CreateFont( "Nick", { font = "Roboto", size = 25, weight = 600, antialias = true, })
	surface.CreateFont( "Health", { font = "Roboto", size = 18, weight = 1000, antialias = true, })
	surface.CreateFont( "Armor", { font = "Roboto", size = 18, weight = 1000, antialias = true, })
	surface.CreateFont( "Ammo", { font = "Roboto", size = 35, weight = 1000, antialias = true, })

local ply = LocalPlayer()

local Scrw, Scrh

local Health = 0
local Armor = 0

local Elements = {
	["CHudAmmo"] = true,
	["CHudBattery"] = true,
	["CHudHealth"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudSuitPower"] = true,
	["DarkRP_Agenda"] = true,
	["DarkRP_ArrestedHUD"] = true,
	["DarkRP_EntityDisplay"] = true,
	["DarkRP_HUD"] = true,
	["DarkRP_Hungermod"] = true,
	["DarkRP_LocalPlayerHUD"] = true,
	["DarkRP_LockdownHUD"] = true
}

local function hudHideElements(name)
	if Elements[name] then return false end
end

hook.Add("HUDShouldDraw", "hudHideElements", hudHideElements)

local function hudDrawRightElement()
	if input.IsKeyDown(KEY_F1) then return end

	Health = Lerp(FrameTime() * 6, Health, LocalPlayer():Health())
	local HealthWidth = math.Min(350 * (Health / 100), 350)
	draw.RoundedBox(1, 1, Scrh - 65, 350, 25, HealthBG)
	draw.RoundedBox(1, 1, Scrh - 65, HealthWidth, 25, Color(250, 50, 50))
	if LocalPlayer():Health() > 500000 then
	draw.SimpleText("ВЫ БЕССМЕРТНЫ", "Health", 50, Scrh - 60, Color(255, 255, 255))
	end

	Armor = Lerp(FrameTime() * 6, Armor, LocalPlayer():Armor())
	local ArmorWidth = math.Min(350 * (Armor / 100), 350)
	draw.RoundedBox(1, 1, Scrh - 95, 350, 25, ArmorBG)
	draw.RoundedBox(1, 1, Scrh - 95, ArmorWidth, 25, Color(0, 130, 230))
	draw.SimpleText(LocalPlayer():Armor() .. "%", "Armor", 50, Scrh - 87, Color(255, 255, 255))

if LocalPlayer():GetNWFloat("idn") ~= nil and LocalPlayer():GetNWFloat("idn") ~= 0 then
	draw.SimpleText(LocalPlayer():Name(), "Nick", 40, Scrh - 120, Color(255, 255, 255))
	end

	if LocalPlayer():Health() > 500000 then return end
	draw.SimpleText(LocalPlayer():Health() .. "%", "Health", 50, Scrh - 60, Color(255, 255, 255))
	
	if LocalPlayer():getDarkRPVar("legion") ~= "-" then
end
end

local function DrawAmmunationAA()
	if input.IsKeyDown(KEY_F1) then return end
	if not LocalPlayer():GetActiveWeapon():IsValid() then return end

	local PrimaryAmmo = LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()
	local PrimaryClip = LocalPlayer():GetActiveWeapon():Clip1()

	local PrimaryAmmoText = LocalPlayer():GetAmmoCount(PrimaryAmmo) .. " "
	local PrimaryClipText = " " .. PrimaryClip .. " / "

	surface.SetFont("Ammo")
	local PrimaryAmmoWidth = surface.GetTextSize(PrimaryAmmoText)

	surface.SetFont("Ammo")
	local PrimaryClipWidth = surface.GetTextSize(PrimaryClipText)

	if PrimaryClip ~= -1 and PrimaryAmmo ~= -1 then
		draw.SimpleText(PrimaryAmmoText, "Ammo", Scrw - (PrimaryAmmoWidth + 25), Scrh - 50, Color(190, 190, 190, 255))
		draw.SimpleText(PrimaryClipText, "Ammo", Scrw - (PrimaryAmmoWidth + PrimaryClipWidth + 25), Scrh - 50, Color(255, 255, 255, 255))
	end
end

local function hudDrawHUD()
	Scrw, Scrh = ScrW(), ScrH()

	hudDrawRightElement()
	DrawAmmunationAA()
end

local function hudDrawHUDPaint()
	if not LocalPlayer():IsValid() then return end

	hudDrawHUD()
end

hook.Add("HUDPaint", "hudDrawHUDPaint", hudDrawHUDPaint)

