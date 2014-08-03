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
	
		if ply:GetObserverMode() == 6 and mtmanager.playerCount() > 1 then
		
			ply:Spectate( 4 );
			
			return;
			
		elseif ply:GetObserverMode() == 4 then
		
			ply:Spectate( 6 );
			
			return;
		
		end
	
	end

end

hook.Add( "PlayerButtonDown", "spectatorChangesView", changeView )

function spectatorUse( ply )

	if ( player_manager.GetPlayerClass( ply ) == "spectator" ) then return false else return true end;

end

hook.Add( "PlayerUse", "spectatorFailsToUse", spectatorUse )

function spectatorSpray( ply )

	if ( player_manager.GetPlayerClass( ply ) == "spectator" ) then return true end;

end

hook.Add( "PlayerSpray", "spectatorFailsToSpray", spectatorSpray )

end

player_manager.RegisterClass( "spectator", PLAYER, "player_default" );