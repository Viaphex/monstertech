AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
AddCSLuaFile( "playerclasses/human.lua" );
AddCSLuaFile( "playerclasses/monster.lua" );
AddCSLuaFile( "playerclasses/spectator.lua" );

include( "shared.lua" );
include( "mtmanager.lua" );
include( "rounds.lua" );

resource.AddFile( "sound/mt/monsterservo.wav" );
resource.AddFile( "sound/mt/monsterstep.wav" );
resource.AddFile( "sound/mt/goSound.wav" );

function GM:Initialize()

	print( "--------------------------\n-                        -\n-                        -\n-      Monster Tech      -\n-      by Viaphex        -\n-                        -\n-                        -\n--------------------------" );
	
end

function GM:PlayerInitialSpawn( ply )

	mtmanager.setClass( ply, "monster" );

end

function testHuman( ply )

	mtmanager.setClass( ply, "human", true );

end

concommand.Add( "testHuman", testHuman );

function testMonster( ply )

	mtmanager.setClass( ply, "monster", true );

end

concommand.Add( "testMonster", testMonster );

function testSpectator( ply )

	mtmanager.setClass( ply, "spectator", true );

end

concommand.Add( "testSpectator", testSpectator );

function testTables()

	PrintTable( mtmanager );

end

concommand.Add( "testTables", testTables );

/*function GM:PlayerSpawn( ply ) -- Breaks player_manager, use a hook instead

	//round.Start();

end*/

function GM:CanPlayerSuicide()

	return;

end

function GM:PlayerDeath( ply )

	mtmanager.setClass( ply, "spectator" );
	
	hook.Call( "disconnectDeathTimer" );

end

function GM:PlayerDisconnected( ply )

	mtmanager.removePlayer( ply, player_manager.GetPlayerClass( ply ) );
	
	hook.Call( "disconnectDeathTimer" );

end

/*function forceMonster( ply )

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

end*/