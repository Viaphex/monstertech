include( "shared.lua" );

local mouseEnabled = true;

function GM:Initialize()
	//Loading panels only works after the gamemode is loaded and started
	local titleScreen = vgui.Create( "DFrame", nil, "titleScreen" );
	titleScreen:SetSize( ScrW() / 2, ScrH() / 2 );
	//titleScreen:SetPos( ( ScrW() / 2 ) - ( titleScreen:GetWide() / 2 ), ( ScrH() / 2 ) - ( titleScreen:GetTall() / 2 ) );
	titleScreen:Center(); --Centres on middle of the screen if it has no parent
	titleScreen:SetTitle( "" ); -- Doesn't seem to work outside function
	
	logoButton = vgui.Create( "DImageButton", titleScreen );
	logoButton:SetImage( "mt/mtlogo" );
	logoButton:SizeToContents();
	logoButton:SetPos( ( ( titleScreen:GetWide() / 2 ) - ( logoButton:GetWide() / 2 ) ), ( ( ( titleScreen:GetTall() / 2 ) - ( logoButton:GetTall() / 2 ) ) - 40 ) );
	
	logoButton.DoClick = function() toggleMouse() titleScreen:Remove() end;
	
	creditsText = vgui.Create( "DLabel", titleScreen );
	creditsText:SetSize( 85, 90 );
	creditsText:SetText( "Creator: Viaphex\n\nAlpha Testers:\nBoarta\nFUH\nIsaac\nLinkzaki" );
	creditsText:SetPos( ( ( logoButton.x + ( logoButton:GetWide() / 2 ) ) - ( creditsText:GetWide() / 2 ) ), ( logoButton.y + logoButton:GetTall() ) );
	
	gui.EnableScreenClicker( true );
	
end

function toggleMouse()
	
	if mouseEnabled then 
		gui.EnableScreenClicker( false ) ;
		mouseEnabled = false;
	else
		gui.EnableScreenClicker( true ) ;
		mouseEnabled = true;
	end

end

net.Receive( "toggleMouse", toggleMouse );

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