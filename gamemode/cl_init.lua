include( "shared.lua" );
include( "player.lua" );

function makeMonsterCl()

	playerMonsterCl = net.ReadEntity();
	
end

net.Receive( "makeMonsterCl", makeMonsterCl );