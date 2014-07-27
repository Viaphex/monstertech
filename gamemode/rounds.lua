round = {};

round.IntermissionNow = 0;
round.monsterIteration = 0;

function round.Start()
	
	player.GetAll()[ 1 ]:EmitSound( "mt/goSound.wav", 511, 100 ); -- THIS IS STUPID

	PrintMessage( 4, "Go!" )

	round.IntermissionNow = false;
	
	mtmanager.humanAll( true );
	
	round.monsterIterate();

end

function round.Intermission( ply )

	if mtmanager.playerCount( "monster" ) == 0 or mtmanager.playerCount( "human" ) == 0 then

		if mtmanager.playerCount( "monster" ) > 0 then PrintMessage( 4, "Monsters win!" ) end
		if mtmanager.playerCount( "human" ) > 0 then PrintMessage( 4, "Humans win!" ) end
	
		round.IntermissionNow = true;

		mtmanager.spectatorAll( true );

		timer.Simple( 10, round.Start );
	
	end

end

hook.Add( "disconnectDeathTimer", "intermissionRunning", round.Intermission )

function round.monsterIterate()

	if mtmanager.playerCount() < 2 then return end;

	round.monsterIteration = round.monsterIteration + 1;
	
	if round.monsterIteration > mtmanager.playerCount() then
	
		round.monsterIteration = 1;
		
	end
	
	mtmanager.setClass( player.GetAll()[ round.monsterIteration ], "monster", true );

end