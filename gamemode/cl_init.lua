include( "shared.lua" );

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



function entityPlaySound()

	net.ReadEntity():EmitSound( net.ReadString(), net.ReadInt( 16 ), net.ReadInt( 16 ) );

end

net.Receive( "entityPlaySound", entityPlaySound );

function shakeScreen()

	util.ScreenShake( net.ReadVector(), net.ReadInt( 16 ), net.ReadInt( 16 ), net.ReadFloat(), net.ReadInt( 16 ) ); //Radius doesn't seem to be working

end

net.Receive( "shakeScreen", shakeScreen );*/