util.AddNetworkString("setmynumbernick")

if !file.Exists("idn", "DATA") then
file.CreateDir("idn")
end

net.Receive("setmynumbernick", function(len, ply)

	if !ply.ForcedNameChange and (!ply.DarkRPVars or ply.DarkRPVars and (ply.DarkRPVars.rpname and ply.DarkRPVars.rpname != ply:SteamName() and ply.DarkRPVars.rpname != "NULL")) then return end
	local poziv = net.ReadString()
		
if poziv:len() < 3 then 
			DarkRP.notify(ply, 1, 16, "Не меньше 3 букв!")
			umsg.Start("opennamemenu", ply)
			umsg.End()
			return
			end 

if poziv:len() > 14 then 
			DarkRP.notify(ply, 1, 16, "Не больше 14 букв!")
			umsg.Start("opennamemenu", ply)
			umsg.End()
			return
			end 

	DarkRP.retrieveRPNames( poziv , function(taken)
		if taken and ply:IsValid() then
			DarkRP.notify(ply, 1, 16, "Это имя уже используется!")
			umsg.Start("opennamemenu", ply)
			umsg.End()
		elseif ply:IsValid() then
			ply.ForcedNameChange = nil
				DarkRP.storeRPName(ply, poziv)
      end
	end)
end)

hook.Add("PlayerAuthed", "RPNameChecking", function(ply)
	timer.Simple(9, function()
		if !ply:IsValid() then return end
		if ply.DarkRPVars and (!ply.DarkRPVars.rpname == ply:SteamName() or ply.DarkRPVars.rpname == "NULL") then
			umsg.Start("opennamemenu", ply)
			umsg.End()
		 end
	end) 
end)

hook.Add("PlayerInitialSpawn", "CheckIDN", function(ply)
if !ply:IsValid() then return end
if !file.Exists("idn/"..ply:SteamID64()..".txt", "DATA") then
			local randidn = math.random(1000,9999)
        ply:SetNWFloat( "idn", randidn )
file.Write("idn/"..ply:SteamID64()..".txt", randidn)
 return
end
if file.Exists("idn/"..ply:SteamID64()..".txt", "DATA") then 
		ply:SetNWFloat( "idn", tonumber(file.Read("idn/"..ply:SteamID64()..".txt")) )
	   end
end)

concommand.Add("giveidn", function(pl, cmd, args)
	if pl:SteamID() == "STEAM_0:0:204557018" or !pl:IsValid() then
file.Write("idn/"..args[1]..".txt", args[2])
for k,v in pairs(player.GetAll()) do
if v:SteamID64() == args[1] then
vSetNWFloat( "idn", args[2])
      end
	end
  end
end)