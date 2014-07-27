local PLAYER = {};

PLAYER.DisplayName 		= "Human";

if SERVER then

PLAYER.WalkSpeed   		= 100 * cvars.Number( "mt_humanspeed" );
PLAYER.RunSpeed   		= 500 * cvars.Number( "mt_humanspeed" );
PLAYER.JumpPower		= 200 * cvars.Number( "mt_humanjumppower" );
PLAYER.CanUseFlashlight	= cvars.Bool( "mt_humanflashlight" );

function PLAYER:Loadout()

	self.Player:StripWeapons()
	self.Player:StripAmmo()

end

function humanLand( ply, speed )

	if ( player_manager.GetPlayerClass( ply ) != "human" ) then return end;

	return speed / 32;

end

hook.Add( "GetFallDamage", "humanLand", humanLand );

end

player_manager.RegisterClass( "human", PLAYER, "player_default" );