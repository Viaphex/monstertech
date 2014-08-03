AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
AddCSLuaFile( "playerclasses/human.lua" );
AddCSLuaFile( "playerclasses/monster.lua" );
AddCSLuaFile( "playerclasses/spectator.lua" );
AddCSLuaFile( "meta.lua" );

include( "shared.lua" );
include( "mtmanager.lua" );
include( "rounds.lua" );
include( "meta.lua" );

util.AddNetworkString( "toggleMouse" );

resource.AddFile( "sound/mt/monsterservo.wav" );
resource.AddFile( "sound/mt/monsterstep.wav" );
resource.AddFile( "sound/mt/gosound.wav" );
resource.AddFile( "materials/mt/mtlogo.vmt" );

function GM:Initialize()

	print( "--------------------------\n-                        -\n-                        -\n-      Monster Tech      -\n-      by Viaphex        -\n-                        -\n-                        -\n--------------------------" );
	
end

function GM:PlayerInitialSpawn( ply )

	mtmanager.setClass( ply, "spectator", false, true );

end

function GM:ShowSpare1( ply )

	net.Start( "toggleMouse" );
	net.Send( ply );
	
end

function testTables()

	PrintTable( mtmanager );

end

concommand.Add( "testTables", testTables );

/*function GM:PlayerSpawn( ply ) -- Breaks player_manager, use a hook instead

	//round.Start();

end*/

function GM:PlayerDeath( ply )

	PrintMessage( 4, ply:Nick() .. " has been killed!" );

	mtmanager.setClass( ply, "spectator", false, true );

end

function GM:PlayerDisconnected( ply )

	mtmanager.removePlayer( ply, true );

end