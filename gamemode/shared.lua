GM.Name = "Monster Tech";
GM.Author = "Viaphex";

include( "playerclasses/human.lua" );
include( "playerclasses/monster.lua" );
include( "playerclasses/spectator.lua" );

util.PrecacheSound( "mt/monsterservo.wav" );
util.PrecacheSound( "mt/monsterstep.wav" );
util.PrecacheSound( "mt/gosound.wav" );