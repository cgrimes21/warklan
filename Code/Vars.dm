var/list/Clans= list()
var/list/debuggers = list()
var
	ClanArenaFilled=0
	ClanOne=""
	ClanTwo=""
	ClanTwoMembers=0
	ClanOneMembers=0
	ClansCheck=""
	ClansLeader=""
obj
	Max_Obj_Letters
		icon='Letters.dmi'
		layer=999
mob
	proc
		Max_MouseName()
			var/MAX_Name = src.Name
			src.Max_Name = list()
			var/list/Max_Letters = list()
			var/Max_Balance =- (lentext(MAX_Name)*2)
			for(var/M = 1, M < lentext(MAX_Name) + 1, M++)
				Max_Letters += copytext(MAX_Name, M, M+1)
			for(var/Max_X in Max_Letters)
				var/obj/Max_Obj_Letters/M_O_L = new /obj/Max_Obj_Letters
				M_O_L.icon_state = Max_X
				M_O_L.pixel_x = Max_Balance
				M_O_L.pixel_y = 40
				M_O_L.icon += rgb(src.Max_Red,src.Max_Green,src.Max_Blue)
				src.Max_Name += M_O_L
				Max_Balance += 10
	MouseEntered()
		for(var/obj/Max_Obj_Letters in src.Max_Name)
			var/image/Max_Image = image(Max_Obj_Letters,src)
			usr.client.images += Max_Image
	MouseExited()
		for(var/image/Max_Image in usr.client.images)
			usr.client.images -= Max_Image

mob
	layer=15
	var
		challenging = "" //name of challenger for pvp
		clan/clan
		Attacker=""

		Mute=0
		Admin=0
		Name=""
		Class=""
		Player=0
		Enemy=0
		NPC=0
		HandToHandLevel=1
		WeaponsLevel=1
		LongRangLevel=1
		Health=100
		MaxHealth=100
		Stamina=100
		MaxStamina=100
		MaxWeight=50
		Strength=10
		MaxStrength=10
		Defense=10
		MaxDefense=10
		Gold=50
		EXP=0
		MaxEXP=100
		Level=1

		AvailableItems=0
		MaxItems=6
		SecondaryWeapon=""
		WearingWeapon=0
		WearingShirt=0


		StaffBoost=0
		SwordBoost=0
		BowBoost=0
		StaffOn=0
		BowOn=0
		SwordOn=0
		InClan=0
		ClanLevel=0
		ClanExp=0
		ClanMaxExp=100
		ClanLeader=""
		ClanGold=0
		Frozen=0
		Clan=""
		ClanFighting=0
		Clan2Fighting = 0





		QuestsDone=0


		MacroOne=""
		MacroTwo=""
		MacroThree=""
		MacroFour=""


mob/var/list/Skills=new
mob
	var
		Dying=0

	var/tmp
		SWhirlwind=0
		HTyphoon=0
		Slashing=0
		SlashDmg=0
		Buffed=0
		ShowingSkills=0
		Jab=0
		oldlayer=0
		UpperCut=0
		Punching=0
		Blocking=0
		Dead=0

		CanAttack=0
		OOC=0
		StatPanel=1
		BagOpen=0
		BagOpen2=0
		BehindTree=0
		oldloc
		oldpixelx
		oldpixely
		Jumped=0
		InFlight=0
		Location=""
		Aggressive=0
		Max_Red = 100
		Max_Green = 0
		Max_Blue = 0
		Max_Name = list()
		Max_Wait_Time = 20


obj
	var
		Level=0
		Wearing=0
		Owner=""
		Style=""
		Amount=0
		Weight=0
		Cost=0
		CanPickUp=1
		MaterialsRequired=""
