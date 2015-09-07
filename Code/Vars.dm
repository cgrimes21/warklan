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
			var/Max_Balance =0// (lentext(MAX_Name))


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
		obj/Effects/health_bar/healthbar
		Sword_Skill_EXP = 0
		Sword_Skill_MaxEXP = 20
		Sword_Skill_Level = 1

		Spear_Skill_EXP = 0
		Spear_Skill_MaxEXP = 20
		Spear_Skill_Level = 1

		Axe_Skill_EXP = 0
		Axe_Skill_MaxEXP = 20
		Axe_Skill_Level = 1

		HandToHand_Skill_EXP = 0
		HandToHand_Skill_MaxEXP = 20
		HandToHand_Skill_Level = 1

		bow_skill = 0
		music_on = 1
		sound_on = 1

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
		Strength=500
		MaxStrength=500
		Defense=4
		MaxDefense=4
		Gold=50
		Iron=0
		EXP=0
		MaxEXP=100
		Level=1

		AvailableItems=0
		MaxItems=10
		SecondaryWeapon=""
		WearingWeapon=0
		WearingShirt=0


		WeaponBoost=0
		ShieldBoost=0
		BowBoost=0
		BowOn=0
		SwordOn=0
		SpearOn=0
		AxeOn=0
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


		//Tutorial
		attackTutorialDone=0
		pickupTutorialActivated=0
		pickupTutorialDone=0
		inventoryTutorialActivated=0
		inventoryTutorialDone=0
		skillsTutorialActivated=0
		skillsTutorialDone=0



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
		ShowingSkillLevels=0
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
		WeaponLevel=0
		Boost=0
		Wearing=0
		Attribute=""
		Owner=""
		Style=""
		Amount=0
		Weight=0
		Cost=0
		CanPickUp=1
		MaterialsRequired=""
		Fading=0

obj/Can_Build
	var
		Health=50
		MaxHealth=50
		MaxDefense=50
		Defense=50
		CanDestroy=1
		obj/Effects/health_bar/healthbar