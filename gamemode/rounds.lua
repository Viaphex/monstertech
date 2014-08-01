round = {};

round.gameStarted = false;
round.monsterIteration = 0;

function round.Check()

	if mtmanager.playerCount( false, true, true ) then -- Enough players
	
		if !round.gameStarted then round.start() return end; -- Round hasn't started, start round
		
		if round.gameStarted then -- Round has started
		
			if mtmanager.playerCount( "human" ) > 0 and mtmanager.playerCount( "monster" ) == 0 then round.finish( "human" ) end; -- 1+ humans alive, monsters dead, finish round
			if mtmanager.playerCount( "human" ) == 0 and mtmanager.playerCount( "monster" ) > 0 then round.finish( "monster" ) end; -- humans dead, 1+ monsters alive, finish round
			
		end
	
	else -- Not enough players
	
		if round.gameStarted then round.finish() return end; -- Round has started, end round

	end

end

function round.finish( roundEnder )

	if timer.Exists( "roundTimer" ) then timer.Destroy( "roundTimer" ) end;

	if roundEnder == "human" or !roundEnder then PrintMessage( 4, "Humans win!" ) end;
	if roundEnder == "monster" then PrintMessage( 4, "Monsters win!" ) end;

	mtmanager.spectatorAll( true );

	round.gameStarted = false;
	
	round.summary();

end

function round.start()

	round.monsterIterate();
	
	mtmanager.unSpectatorAll( true );
	
	round.gameStarted = true;
	
	timer.Create( "roundTimer", cvars.Number( "mt_roundtime" ), 1, round.finish );
	
	PrintMessage( 4, "Go!" );

end

function round.summary()

	timer.Simple( 10, round.Check );

end

function round.monsterIterate()

	round.monsterIteration = round.monsterIteration + 1;
	
	if round.monsterIteration > mtmanager.playerCount() then
	
		round.monsterIteration = 1;
		
	end
	
	mtmanager.setClass( player.GetAll()[ round.monsterIteration ], "monster", true );

end