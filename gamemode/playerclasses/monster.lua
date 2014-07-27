local PLAYER = {};

PLAYER.DisplayName 		= "Monster";

if SERVER then

PLAYER.WalkSpeed   		= 100 * cvars.Number( "mt_monsterspeed" );
PLAYER.RunSpeed   		= 500 * cvars.Number( "mt_monsterspeed" );
PLAYER.JumpPower		= 200 * cvars.Number( "mt_monsterjumppower" );
PLAYER.CanUseFlashlight	= cvars.Bool( "mt_monsternightvision" );

function PLAYER:SetModel()

	self.Player:SetModel( "models/player/gman_high.mdl" );

end

function PLAYER:Loadout()

	self.Player:StripWeapons()
	self.Player:StripAmmo()
	
	self.Player:Give( "weapon_smg1" );
	self.Player:GiveAmmo( 255, "smg1", true );
	self.Player:GiveAmmo( 255, "smg1_grenade", true );

end

local function monsterFootstep( ply, pos )

	if ( player_manager.GetPlayerClass( ply ) != "monster" ) then return end;
	
	ply:EmitSound( "mt/monsterstep.wav", 80, math.random( 90, 100 ) );
	
	return true;
	
end

hook.Add( "PlayerFootstep", "monsterFootstep", monsterFootstep );

local function monsterLand( ply )

	if ( player_manager.GetPlayerClass( ply ) != "monster" ) then return end;

	ply:EmitSound( "mt/monsterservo.wav", 90, math.random( 90, 100 ) );
	
	util.ScreenShake( ply:GetPos(), 10, 10, 1.5, 0 )
	
	return false;

end

hook.Add( "GetFallDamage", "monsterLand", monsterLand );

end

if CLIENT then

local function monsterFootstep( ply, pos )

	if ( player_manager.GetPlayerClass( ply ) != "monster" ) then return end;
	
	local distance = LocalPlayer():GetPos():Distance( pos );
	
	if LocalPlayer() != ply and distance < 400 then util.ScreenShake( pos, ( ( 100 / distance ) * 10 ), 10, 0.5, 0 ) end; -- Radius doesn't seem to work
	
	return true;
	
end

hook.Add( "PlayerFootstep", "monsterFootstep", monsterFootstep );

end

player_manager.RegisterClass( "monster", PLAYER, "player_default" );