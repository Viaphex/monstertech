/*function monsterManager()
	
	received = net.ReadEntity();
	
	if IsEntity( received ) and received:IsPlayer() and received != playerMonster then
	
		playerMonster = received
	
	elseif !IsEntity( received ) then
	
		error( "Non-entity passed to clientside monsterManager." );
		return true;
		
	elseif !received:IsPlayer() then
	
		error( "Non-player passed to clientside monsterManager." );
		return true;
		
	elseif received == playerMonster then
		
		print( "Player passed to clientside monsterManager is already the monster." );
		return true;
		
	end

end

net.Receive( "monsterManagerCl", monsterManager );*/