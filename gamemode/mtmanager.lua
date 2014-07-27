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

function mtmanager.playerCount( class )

	if class then
		
		local classCheck = mtmanager.validClass( class );
		
		if !classCheck then return end;
		
		return table.Count( classCheck );
		
	end
	
	return table.Count( player.GetAll() );

end

function mtmanager.removePlayer( ply, class )

	if !mtmanager.validPlayer( ply ) then return end;
	
	local tableRemoveFrom = mtmanager.validClass( class );

	if tableRemoveFrom and table.HasValue( tableRemoveFrom, ply ) then
	
		for k, v in pairs( tableRemoveFrom ) do
		
			if v == ply then 
			
				table.remove( tableRemoveFrom, k );
			
				break;
			
			end

		end
	
	else
	
		print( "Didn't remove player from their class table when class changed, possibly a new player who wasn't put in a table yet. Check last console message." );
	
	end

end

function mtmanager.setClass( ply, class, kill )
	
	if !mtmanager.validPlayer( ply ) then return end;
	
	if class == player_manager.GetPlayerClass( ply ) then return end;
	
	local tableAddTo = mtmanager.validClass( class );
	
	if !tableAddTo then error( "setClass was passed an invalid class" ) return end;
	
	mtmanager.removePlayer( ply, player_manager.GetPlayerClass( ply ) );
	
	if !table.HasValue( tableAddTo, ply ) then
	
		table.Add( tableAddTo, { ply } );
	
	else
	
		error( "Trying to add " .. ply:Nick() .. " to a class table, but the player is already in the " .. class .. " table!" );
	
	end
	
	player_manager.SetPlayerClass( ply, class );
	
	if kill then ply:KillSilent() end;
	
	return true;
		
end

function mtmanager.spectatorAll( kill )

	for k, v in pairs( player.GetAll() ) do
		
		mtmanager.setClass( v, "spectator", kill );
		
	end

end

function mtmanager.humanAll( kill )

	for k, v in pairs( player.GetAll() ) do
		
		mtmanager.setClass( v, "human", kill );
		
	end

end