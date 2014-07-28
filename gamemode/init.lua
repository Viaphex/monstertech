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
resource.AddFile( "sound/mt/gosound.wav" );

function GM:Initialize()

	print( "--------------------------\n-                        -\n-                        -\n-      Monster Tech      -\n-      by Viaphex        -\n-                        -\n-                        -\n--------------------------" );
	
end

function GM:PlayerInitialSpawn( ply )

	mtmanager.setClass( ply, "human", false, true );

end

function testHuman( ply )

	mtmanager.setClass( ply, "human", true, true );

end

concommand.Add( "mt_human", testHuman );

function testMonster( ply )

	mtmanager.setClass( ply, "monster", true, true );

end

concommand.Add( "mt_monster", testMonster );

function testSpectator( ply )

	mtmanager.setClass( ply, "spectator", true, true );

end

concommand.Add( "mt_spectator", testSpectator );

function testTables()

	PrintTable( mtmanager );

end

concommand.Add( "testTables", testTables );

/*function GM:PlayerSpawn( ply ) -- Breaks player_manager, use a hook instead

	//round.Start();

end*/

function GM:PlayerDeath( ply )

	mtmanager.setClass( ply, "spectator", false, true );

end

function GM:PlayerDisconnected( ply )

	mtmanager.removePlayer( ply, true );

end