local PLAYER = {};

PLAYER.DisplayName 		= "Spectator";

if SERVER then

PLAYER.CanUseFlashlight	= false;

function PLAYER:Loadout()

	self.Player:StripWeapons()
	self.Player:StripAmmo()

end

function PLAYER:Spawn()

	self.Player:Spectate( 6 );

end

function changeView( ply, button )

	if button == 107 and mtmanager.playerClassCheck( ply ) == "spectator" then
	
		if ply:GetObserverMode() == 6 then ply:Spectate( 4 ) return end;
		if ply:GetObserverMode() == 4 then ply:Spectate( 6 ) return end;
	
	end

end

hook.Add( "PlayerButtonDown", "spectatorChangesView", changeView )

end

player_manager.RegisterClass( "spectator", PLAYER, "player_default" );