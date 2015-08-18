#define AI_DEAD		1
#define AI_ROAM		2
#define AI_SPOT		3
#define AI_ATTACKED	4
mob/npc

	var
		goal = null
		mob/enemy
	proc
		Get_Nearest_Enemy()
		Roam()


		Do_Goal()