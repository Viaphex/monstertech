include( "shared.lua" );

local mouseVisible = true;

function GM:Initialize()
	//Loading panels only works after the gamemode is loaded and started
	local titleScreen = vgui.Create( "DFrame", nil, "titleScreen" );
	titleScreen:SetSize( ScrW() / 2, ScrH() / 2 );
	//titleScreen:SetPos( ( ScrW() / 2 ) - ( titleScreen:GetWide() / 2 ), ( ScrH() / 2 ) - ( titleScreen:GetTall() / 2 ) );
	titleScreen:Center(); --Centres on middle of the screen if it has no parent
	titleScreen:SetTitle( "Monster Tech" ); -- Doesn't seem to work outside function
	
	logoButton = vgui.Create( "DImageButton", titleScreen );
	logoButton:SetImage( "mt/mtlogo.vtf" );
	
	gui.EnableScreenClicker( true );

end

function enableMouse()

	if mouseVisible then 
		gui.EnableScreenClicker( false ) ;
		mouseVisible = false ;
	else
		gui.EnableScreenClicker( true ) ;
		mouseVisible = true ;
	end

end

net.Receive( "enableMouse", enableMouse );

/*function GM:Think()
	
	if LocalPlayer():IsOnGround() and LocalPlayer():WaterLevel() < 2 then
		if LocalPlayer():GetVelocity().x != 0 or LocalPlayer():GetVelocity().y != 0 then 
			playerGroundMoving = 1;
		else
			playerGroundMoving = 0;
		end
	else
		playerGroundMoving = 0;
	end

end*/

/* 

Nice try, but found the IsOnGround function.

function GM:Think()
	
	playerPos = LocalPlayer():GetPos();
	playerFloorVec = playerPos - Vector( 0, 0, 100 );

	floorTrace = util.TraceLine( { start = playerPos, endpos = playerFloorVec, filter = LocalPlayer() } );
	
	//print( floorTrace.HitPos );
	
	//print( playerPos );
	//print( feetTrace.HitPos );
	
	//playerPos = LocalPlayer():GetPos();
	
	//playerPos.y = 0;
	
	//print( playerPos.y );
	
	//playerPos:Add( Vector( 0, -100, 0 ) );
	
	//print( playerPos );
	


end



function GM:DrawOverlay()

	//debugoverlay.Text( playerPos, "playerPos", 0.1 );
	//debugoverlay.Text( playerFeetPos, "playerFeetPos", 0.1 );
	//debugoverlay.Text( floorTrace.HitPos, "floorTrace.HitPos", 0.1 );
	//debugoverlay.Text( playerPos, tostring( playerPos.z == floorTrace.HitPos.z ), 0.1 );
	//debugoverlay.Text( LocalPlayer():GetPos(), tostring( playerGroundMoving ), 0.1 );
	
end