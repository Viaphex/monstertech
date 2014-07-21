AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
AddCSLuaFile( "player.lua" );

include( "shared.lua" );
include( "player.lua" );

function GM:Initialize()

	print( "--------------------------\n-                        -\n-                        -\n-      Monster Tech      -\n-      by Viaphex        -\n-                        -\n-                        -\n--------------------------" );
	
end

function pickMonster()

	MakeMonster( pickRandomPlayer() );

end

concommand.Add( "mt_forcemonster", pickMonster );

function pickRandomPlayer()

	if table.Count( player.GetAll() ) == 0 then return end; //if no players connected, return false.

	return player.GetAll()[ math.random( 1, table.Count( player.GetAll() ) ) ]; //instead of table.Count( player.GetAll() ) is there a better way of getting the amount of players?
	
	//PrintMessage( 4, string.Implode( " ", { tostring( playerMonster:Nick() ), "is a monster!" } ) ); //is there a better way to put two strings together within the argument

end