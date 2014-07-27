local PLAYER = {};

PLAYER.DisplayName 		= "Spectator";

if SERVER then

function PLAYER:Loadout()

	self.Player:StripWeapons()
	self.Player:StripAmmo()

end

function PLAYER:Spawn()

	//if !mtmanager.everyoneDead then 

		//self.Player:Spectate( 4 );
		
	//else
	
		self.Player:Spectate( 6 );
		
	//end

end

end

player_manager.RegisterClass( "spectator", PLAYER, "player_default" );