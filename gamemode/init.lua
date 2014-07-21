AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
AddCSLuaFile( "cl_player.lua" );

include( "shared.lua" );
include( "player.lua" );

util.AddNetworkString( "entityPlaySound" );
util.AddNetworkString( "shakeScreen" );

resource.AddFile( "sound/mt/monsterServo.wav" );
resource.AddFile( "sound/mt/monsterStep.wav" );

function GM:Initialize()

	print( "--------------------------\n-                        -\n-                        -\n-      Monster Tech      -\n-      by Viaphex        -\n-                        -\n-                        -\n--------------------------" );
	
end

function GM:PlayerSpawn( ply )

	setupPlayer( ply );

	monsterManager( pickRandomPlayer() );

end

function forceMonster( ply )

	if ply == NULL or ply:IsAdmin() then

		monsterManager( pickRandomPlayer() );
		
	else
	
		print( ply:Nick(), " is trying to use the mt_forcemonster command without admin privileges." );
		
	end

end

concommand.Add( "mt_forcemonster", forceMonster );

function pickRandomPlayer()

	if table.Count( player.GetAll() ) == 0 then return end; //if no players connected, return false.

	return player.GetAll()[ math.random( 1, table.Count( player.GetAll() ) ) ]; //instead of table.Count( player.GetAll() ) is there a better way of getting the amount of players?
	
	//PrintMessage( 4, string.Implode( " ", { tostring( playerMonster:Nick() ), "is a monster!" } ) ); //is there a better way to put two strings together within the argument

end

function entityPlaySound( ent, dir, vol, ptch )

	net.Start( "entityPlaySound" );
	net.WriteEntity( ent );
	net.WriteString( dir );
	net.WriteInt( vol, 16 ); //WriteInt needs bitcount, and has to be a power of 2
	net.WriteInt( ptch, 16 );
	net.Broadcast();

end

function shakeScreen( pos, amp, freq, dur, rad )

	net.Start( "shakeScreen" );
	net.WriteVector( pos );
	net.WriteInt( amp, 16 );
	net.WriteInt( freq, 16 );
	net.WriteFloat( dur );
	net.WriteInt( rad, 16 );
	net.Broadcast();

end