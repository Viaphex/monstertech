mtmanager = {};

mtmanager.humans = {};
mtmanager.monsters = {};
mtmanager.spectators = {};

function mtmanager.validPlayer( ply )

	if !IsValid( ply ) or !IsEntity( ply ) or !ply:IsPlayer() then 
		error( "player validation check failure" );
		return;
	else
		return true;
	end

end

function mtmanager.validClass( class )

	if class == "human" then 
		return mtmanager.humans;
	elseif class == "monster" then 
		return mtmanager.monsters;
	elseif class == "spectator" then 
		return mtmanager.spectators;
	else
		return;
	end

end

function mtmanager.playerClassCheck( ply )

	if table.HasValue( mtmanager.humans, ply ) then return "human" end;
	if table.HasValue( mtmanager.monsters, ply ) then return "monster" end;
	if table.HasValue( mtmanager.spectators, ply ) then return "spectator" end;
	
	return;

end

function mtmanager.playerCount( class, enoughPlayers, message )

	if class then
		
		local classCheck = mtmanager.validClass( class );
		
		if !classCheck then return end;
		
		return table.Count( classCheck );
		
	end
	
	if enoughPlayers then
		
		if table.Count( player.GetAll() ) >= cvars.Number( "mt_enoughplayers" ) then
			return true;
		elseif message and table.Count( player.GetAll() ) < cvars.Number( "mt_enoughplayers" ) then
			PrintMessage( 4, "Not enough players!" );
		end
		
	else
	
		return table.Count( player.GetAll() );
	
	end

end

function mtmanager.removePlayer( ply, roundCheck )
	
	print( "---------------------------------------------" );
	print( "removePlayer" );
	print( "#player validation" );
	if !mtmanager.validPlayer( ply ) then return end;
	print( "#" .. ply:Nick() .. " validated" );
	print( "#finding " .. ply:Nick() );
	
	local tableRemoveFrom = nil;
	
	if table.HasValue( mtmanager.humans, ply ) then tableRemoveFrom = mtmanager.humans else print( "#" .. ply:Nick() .. " not found in humans class table" ) end;
	if table.HasValue( mtmanager.monsters, ply ) then tableRemoveFrom = mtmanager.monsters else print( "#" .. ply:Nick() .. " not found in monsters class table" ) end;
	if table.HasValue( mtmanager.spectators, ply ) then tableRemoveFrom = mtmanager.spectators else print( "#" .. ply:Nick() .. " not found in spectators class table" ) end;
	
	if !tableRemoveFrom then print( "#!#failed to find " .. ply:Nick() .. ", is " .. ply:Nick() .. " newly connected?\n---------------------------------------------" ) return end;
	
	for k, v in pairs( tableRemoveFrom ) do
		
		if v == ply then 
			
			print( "#found player " .. ply:Nick() .. " in class table, removing" );
			
			table.remove( tableRemoveFrom, k );
			
			break;
			
		end

	end

	if roundCheck then 
	
		print( "#roundCheck == true, calling roundCheck" );
		
		round.Check();
		
	end
	
	print( "---------------------------------------------" );
	
	return true;

end

function mtmanager.setClass( ply, class, kill, roundCheck )
	
	print( "---------------------------------------------" );
	print( "setClass" );
	print( "#player validation" );
	
	if !mtmanager.validPlayer( ply ) then return end;
	
	print( "#" .. ply:Nick() .. " validated" );
	print( "#class validation" );
	
	local tableAddTo = mtmanager.validClass( class );
	
	if !tableAddTo then error( "#!#setting " .. ply:Nick() .. " to invalid class!" ) return end;
	
	print( "#" .. class .. " validated" );
	print( "#removing " .. ply:Nick() .. " from " .. class .. " class table" );
	
	mtmanager.removePlayer( ply );
	
	print( "#adding " .. ply:Nick() .. " to " .. class .. " class table" );
	
	table.Add( tableAddTo, { ply } );
	
	print( "#setting " .. ply:Nick() .. " to class " .. class );
	
	player_manager.SetPlayerClass( ply, class );
	
	if roundCheck then 
	
		print( "#roundCheck == true, calling roundCheck" );
		
		round.Check();
		
	end
	
	if kill then 
	
		print( "#kill == true, calling silentkill" );
		
		ply:KillSilent();
		
	end
	
	print( "---------------------------------------------" );
		
end

function mtmanager.spectatorAll( kill, roundCheck )

	for k, v in pairs( player.GetAll() ) do
		
		if mtmanager.playerClassCheck( v ) != "spectator" then mtmanager.setClass( v, "spectator", kill, roundCheck ) end;
		
	end

end

function mtmanager.unSpectatorAll( kill, roundCheck )

	for k, v in pairs( player.GetAll() ) do
		
		if mtmanager.playerClassCheck( v ) == "spectator" then mtmanager.setClass( v, "human", kill, roundCheck ) end;
		
	end

end