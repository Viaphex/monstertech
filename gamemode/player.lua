function monsterManager( ply )

	if IsEntity( ply ) and ply:IsPlayer() and ply != playerMonster then
		
		//net.Start( "monsterManagerCl" );
		//net.WriteEntity( ply );
		//net.Broadcast();
		
		setupPlayer( playerMonster );
			
		playerMonster = ply;
			
		setupPlayer( ply, true );
		
		PrintMessage( 4, string.Implode( " ", { ply:Nick(), " is the monster!" } ) );
		
	elseif !IsEntity( ply ) then
	
		error( "Non-entity passed to monsterManager. Server is empty?" );
		return true;
		
	elseif !ply:IsPlayer() then
	
		error( "Non-player passed to monsterManager." );
		return true;
		
	elseif ply == playerMonster then
		
		print( "Player passed to monsterManager is already the monster." );
		return true;
		
	end
		
end

function setupPlayer( ply, turnMonster )

	if !IsEntity( ply ) or !ply:IsPlayer() then return true end;
	
	print( "Testing if ply is NULL" );
	if !ply:IsValid() then print( "Player is NULL, this needs fixing." ) return true end; //Fix this, it's not good
	
	if turnMonster then

		print( "Making monster" );
		ply:Give( "weapon_smg1" );
		ply:Give( "weapon_frag" );
		ply:GiveAmmo( 256, "SMG1" );
		ply:GiveAmmo( 256, "grenade" );
		ply:SetWalkSpeed( 200 * cvars.Number( "mt_monsterspeed" ) );
		ply:SetRunSpeed( 400 * cvars.Number( "mt_monsterspeed" ) );
		ply:SetJumpPower( 800 );
		ply:SetModel( "models/player/gman_high.mdl" )
	
	else
	
		print( "Making human" );
		ply:StripWeapons();
		ply:StripAmmo();
		ply:SetWalkSpeed( 200 * cvars.Number( "mt_humanspeed" ) );
		ply:SetRunSpeed( 400 * cvars.Number( "mt_humanspeed" ) );
		ply:SetJumpPower( 200 );
		ply:SetModel( "models/player/kleiner.mdl" );
	
	end

end

function GM:PlayerFootstep( ply, pos )
	
	if ply == playerMonster then
		
		entityPlaySound( ply, "mt/monsterstep.wav", 75, math.random( 90,100 ) );
		shakeScreen( pos, 10, 1, 0.25, 5 );
	
	else
	
		return;
		
	end

end

function GM:GetFallDamage( ply, speed )

	if ply != playerMonster then
		
		return ( speed / 20 );
	
	else
	
		entityPlaySound( ply, "mt/monsterservo.wav", 90, math.random( 90,100 ) );
		entityPlaySound( ply, "mt/monsterstep.wav", 90, math.random( 90,100 ) );
		shakeScreen( ply:GetPos(), 10, 1, 1, 50 );
		
		return;
		
	end

end