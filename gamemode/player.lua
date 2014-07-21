if SERVER then resource.AddFile( "sound/mt/monsterStep.wav" ) end;

if CLIENT then util.PrecacheSound( "mt/monsterStep.wav" ) end;

if SERVER then util.AddNetworkString( "makeMonsterCl" ) end;

function MakeMonster( ply )

	if SERVER then

		if IsEntity( ply ) and ply:IsPlayer() and ply != playerMonster then
		
			net.Start( "makeMonsterCl" );
			net.WriteEntity( ply );
			net.Broadcast();
		
			unSetupMonster();
			
			playerMonster = ply;
			
			setupMonster();
		
			print( ply, " is turning into a monster." );
		
		elseif !IsEntity( ply ) then
	
			error( "Non-entity passed to MakeMonster. Server is empty?" );
			return true;
		
		elseif !ply:IsPlayer() then
	
			error( "Non-player passed to MakeMonster." );
			return true;
		
		elseif ply == playerMonster then
		
			print( "Player passed to MakeMonster is already the monster." );
			return true;
		
		end
		
	end
	
	if CLIENT then
	
		playerMonsterCl = net.ReadEntity();
	
	end

end

if CLIENT then net.Receive( "makeMonsterCl", MakeMonster ); end

function unSetupMonster()

	if SERVER and IsEntity( playerMonster ) and playerMonster:IsPlayer() then
	
		playerMonster:SetWalkSpeed( 500 );
	
	end

end

function setupMonster()

	if SERVER and IsEntity( playerMonster ) and playerMonster:IsPlayer() then
	
		playerMonster:SetWalkSpeed( 50 );
	
	end

end

function GM:PlayerFootstep( ply, pos )
	
	if CLIENT and ply == playerMonsterCl then
	
		ply:EmitSound("mt/monsterStep.wav");
		util.ScreenShake( pos, 5, 5, 1, 500 );
		
		return true;
	
	else
	
		return;
		
	end

end