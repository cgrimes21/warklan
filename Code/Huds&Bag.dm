mob
	proc
		HudCreate_Tut1()
			new/obj/Huds/Tutorial(src.client)
		HudCreate_Tut2()
			new/obj/Huds/Tutorial2(src.client)
		HudCreate_Tut3()
			new/obj/Huds/Tutorial3(src.client)
		HudCreate_Tut4()
			new/obj/Huds/Tutorial4(src.client)
		HudCreate_Tut5()
			new/obj/Huds/Tutorial5(src.client)
		HudDelete_Tut1()
			for(var/obj/Huds/Tutorial/S in usr.client.screen)
				del(S)
		HudDelete_Tut2()
			for(var/obj/Huds/Tutorial2/S in usr.client.screen)
				del(S)
		HudDelete_Tut3()
			for(var/obj/Huds/Tutorial3/S in usr.client.screen)
				del(S)
		HudDelete_Tut4()
			for(var/obj/Huds/Tutorial4/S in usr.client.screen)
				del(S)
		HudDelete_Tut5()
			for(var/obj/Huds/Tutorial5/S in usr.client.screen)
				del(S)
		HudCreate()
			new/obj/Huds/Health(src.client);new/obj/Huds/EXP(src.client);new/obj/Huds/Stamina(src.client)
			new/obj/Huds/StatPanel/MainStatPanel(src.client)
			new/obj/Huds/StatPanel/STRPanel(src.client)
			new/obj/Huds/StatPanel/STRPanel2(src.client)
			new/obj/Huds/StatPanel/EXPPanel(src.client)
			new/obj/Huds/StatPanel/EXPPanel2(src.client)
			new/obj/Huds/StatPanel/DefensePanel2(src.client)
			new/obj/Huds/StatPanel/DefensePanel(src.client)
			new/obj/Huds/StatPanel/NamePanel(src.client)
			new/obj/Huds/StatPanel/HealthPanel2(src.client)
			new/obj/Huds/StatPanel/HealthPanel(src.client)
			new/obj/Huds/StatPanel/StaminaPanel2(src.client)
			new/obj/Huds/StatPanel/StaminaPanel(src.client)
			new/obj/Huds/SkillHuds/SkillHudOne(src.client)
			new/obj/Huds/SkillHuds/SkillHudTwo(src.client)
			new/obj/Huds/SkillHuds/SkillHudThree(src.client)
			new/obj/Huds/SkillHuds/SkillHudFour(usr.client)
			new/obj/Huds/SkillHuds/SkillHudFive(src.client)
			new/obj/Huds/StatPanel/LevelPanel(src.client)
			new/obj/Huds/StatPanel/LevelPanel2(src.client)
			new/obj/Huds/StatPanel/WeaponLevelPanel(src.client)
			new/obj/Huds/StatPanel/WeaponLevelPanel2(src.client)
			var/obj/M1 = new/obj/Huds/Money1(src.client)
			var/obj/M2 = new/obj/Huds/Money2(src.client)
			var/obj/M3 = new/obj/Huds/Money3(src.client)
			var/obj/M4 = new/obj/Huds/Money4(src.client)
			var/obj/M5 = new/obj/Huds/Money5(src.client)
			M1.screen_loc= "24,21"
			M2.screen_loc= "25,21 to 27,21"
			M3.screen_loc= "28,21"
			M4.screen_loc= "24:8,21:16"
			M5.screen_loc= "25:10,21:16"
	verb
		StatPanel()
			set hidden=1
			if(!StatPanel)
				StatPanel=1
				new/obj/Huds/StatPanel/MainStatPanel(usr.client)
				new/obj/Huds/Health(src.client);new/obj/Huds/EXP(src.client);new/obj/Huds/Stamina(src.client)
				new/obj/Huds/StatPanel/STRPanel(usr.client)
				new/obj/Huds/StatPanel/STRPanel2(usr.client)
				new/obj/Huds/StatPanel/EXPPanel(usr.client)
				new/obj/Huds/StatPanel/EXPPanel2(usr.client)
				new/obj/Huds/StatPanel/DefensePanel2(usr.client)
				new/obj/Huds/StatPanel/DefensePanel(usr.client)
				new/obj/Huds/StatPanel/NamePanel(usr.client)
				new/obj/Huds/StatPanel/HealthPanel2(usr.client)
				new/obj/Huds/StatPanel/HealthPanel(usr.client)
				new/obj/Huds/StatPanel/StaminaPanel2(usr.client)
				new/obj/Huds/StatPanel/StaminaPanel(usr.client)
				new/obj/Huds/StatPanel/StaminaPanel(usr.client)
				new/obj/Huds/StatPanel/LevelPanel(src.client)
				new/obj/Huds/StatPanel/LevelPanel2(src.client)
				new/obj/Huds/StatPanel/WeaponLevelPanel(src.client)
				new/obj/Huds/StatPanel/WeaponLevelPanel2(src.client)
				return
			else
				StatPanel=0
				for(var/obj/Huds/StatPanel/S in usr.client.screen)
					del(S)


obj/Huds
	layer=99
	SkillHuds
		icon='HudT.dmi'
		SkillHudOne
			layer=17
			New(client/c)
				screen_loc="13,1"
				c.screen+=src
				src.overlays+=new/obj/HudLetter/A
				..()
		SkillHudTwo
			layer=17
			New(client/c)
				screen_loc="14:4,1"
				c.screen+=src
				src.overlays+=new/obj/HudLetter/One
				..()
		SkillHudThree
			layer=17
			New(client/c)
				screen_loc="15:8,1"
				c.screen+=src
				src.overlays+=new/obj/HudLetter/Two
				..()
		SkillHudFour
			layer=17
			New(client/c)
				screen_loc="16:12,1"
				c.screen+=src
				src.overlays+=new/obj/HudLetter/Three
				..()
		SkillHudFive
			layer=17
			New(client/c)
				screen_loc="17:16,1"
				c.screen+=src
				src.overlays+=new/obj/HudLetter/Four
				..()

	Tutorial
		layer=9999
		icon='Tutorial.dmi'
		icon_state="tutorial"
		New(client/c)
			screen_loc="8,15:52"
			c.screen+=src

	Tutorial2
		layer=9999
		icon='Tutorial.dmi'
		icon_state="tutorial2"
		New(client/c)
			screen_loc="8,15:52"
			c.screen+=src

	Tutorial3
		layer=9999
		icon='Tutorial.dmi'
		icon_state="tutorial3"
		New(client/c)
			screen_loc="8,15:52"
			c.screen+=src

	Tutorial4
		layer=9999
		icon='Tutorial.dmi'
		icon_state="tutorial4"
		New(client/c)
			screen_loc="8,15:52"
			c.screen+=src

	Tutorial5
		layer=9999
		icon='Tutorial.dmi'
		icon_state="tutorial5"
		New(client/c)
			screen_loc="8,15:52"
			c.screen+=src

	Health
		layer=9999
		icon='Health.dmi'
		New(client/c)
			screen_loc="1,19:52"
			c.screen+=src
			spawn while(usr)
				if(!usr.client)
					return
				if(round(usr.Health/usr.MaxHealth*100)>=90) src.icon_state="1"
				else if(round(usr.Health/usr.MaxHealth*100)>=85&&round(usr.Health/usr.MaxHealth*100)<90) src.icon_state="2"
				else if(round(usr.Health/usr.MaxHealth*100)>=80&&round(usr.Health/usr.MaxHealth*100)<85) src.icon_state="3"
				else if(round(usr.Health/usr.MaxHealth*100)>=75&&round(usr.Health/usr.MaxHealth*100)<80) src.icon_state="4"
				else if(round(usr.Health/usr.MaxHealth*100)>=70&&round(usr.Health/usr.MaxHealth*100)<75) src.icon_state="5"
				else if(round(usr.Health/usr.MaxHealth*100)>=65&&round(usr.Health/usr.MaxHealth*100)<70) src.icon_state="6"
				else if(round(usr.Health/usr.MaxHealth*100)>=60&&round(usr.Health/usr.MaxHealth*100)<65) src.icon_state="7"
				else if(round(usr.Health/usr.MaxHealth*100)>=55&&round(usr.Health/usr.MaxHealth*100)<60) src.icon_state="8"
				else if(round(usr.Health/usr.MaxHealth*100)>=50&&round(usr.Health/usr.MaxHealth*100)<55) src.icon_state="9"
				else if(round(usr.Health/usr.MaxHealth*100)>=45&&round(usr.Health/usr.MaxHealth*100)<50) src.icon_state="10"
				else if(round(usr.Health/usr.MaxHealth*100)>=40&&round(usr.Health/usr.MaxHealth*100)<45) src.icon_state="11"
				else if(round(usr.Health/usr.MaxHealth*100)>=35&&round(usr.Health/usr.MaxHealth*100)<40) src.icon_state="12"
				else if(round(usr.Health/usr.MaxHealth*100)>=30&&round(usr.Health/usr.MaxHealth*100)<35) src.icon_state="14"
				else if(round(usr.Health/usr.MaxHealth*100)>=20&&round(usr.Health/usr.MaxHealth*100)<30) src.icon_state="15"
				else if(round(usr.Health/usr.MaxHealth*100)>=15&&round(usr.Health/usr.MaxHealth*100)<20) src.icon_state="17"
				else if(round(usr.Health/usr.MaxHealth*100)>=10&&round(usr.Health/usr.MaxHealth*100)<15) src.icon_state="19"
				else if(round(usr.Health/usr.MaxHealth*100)>=5&&round(usr.Health/usr.MaxHealth*100)<10) src.icon_state="20"
				else if(round(usr.Health/usr.MaxHealth*100)>=0&&round(usr.Health/usr.MaxHealth*100)<5) src.icon_state="21"
				else if(round(usr.Health/usr.MaxHealth*100)<=0) src.icon_state="21"
				sleep(world.tick_lag)


	EXP
		layer=9999
		icon='EXP.dmi'
		New(client/c)
			screen_loc="1,18:84"
			c.screen+=src
			spawn while(usr)
				usr.SetMainEXP(usr.EXP,usr.MaxEXP)
				if(!usr.client)
					return
				if(round(usr.EXP/usr.MaxEXP*100)>=90) src.icon_state="1"
				else if(round(usr.EXP/usr.MaxEXP*100)>=85&&round(usr.EXP/usr.MaxEXP*100)<90) src.icon_state="2"
				else if(round(usr.EXP/usr.MaxEXP*100)>=80&&round(usr.EXP/usr.MaxEXP*100)<85) src.icon_state="3"
				else if(round(usr.EXP/usr.MaxEXP*100)>=75&&round(usr.EXP/usr.MaxEXP*100)<80) src.icon_state="4"
				else if(round(usr.EXP/usr.MaxEXP*100)>=70&&round(usr.EXP/usr.MaxEXP*100)<75) src.icon_state="5"
				else if(round(usr.EXP/usr.MaxEXP*100)>=65&&round(usr.EXP/usr.MaxEXP*100)<70) src.icon_state="6"
				else if(round(usr.EXP/usr.MaxEXP*100)>=60&&round(usr.EXP/usr.MaxEXP*100)<65) src.icon_state="7"
				else if(round(usr.EXP/usr.MaxEXP*100)>=55&&round(usr.EXP/usr.MaxEXP*100)<60) src.icon_state="8"
				else if(round(usr.EXP/usr.MaxEXP*100)>=50&&round(usr.EXP/usr.MaxEXP*100)<55) src.icon_state="9"
				else if(round(usr.EXP/usr.MaxEXP*100)>=45&&round(usr.EXP/usr.MaxEXP*100)<50) src.icon_state="10"
				else if(round(usr.EXP/usr.MaxEXP*100)>=40&&round(usr.EXP/usr.MaxEXP*100)<45) src.icon_state="11"
				else if(round(usr.EXP/usr.MaxEXP*100)>=35&&round(usr.EXP/usr.MaxEXP*100)<40) src.icon_state="12"
				else if(round(usr.EXP/usr.MaxEXP*100)>=30&&round(usr.EXP/usr.MaxEXP*100)<35) src.icon_state="14"
				else if(round(usr.EXP/usr.MaxEXP*100)>=20&&round(usr.EXP/usr.MaxEXP*100)<30) src.icon_state="15"
				else if(round(usr.EXP/usr.MaxEXP*100)>=15&&round(usr.EXP/usr.MaxEXP*100)<20) src.icon_state="17"
				else if(round(usr.EXP/usr.MaxEXP*100)>=10&&round(usr.EXP/usr.MaxEXP*100)<15) src.icon_state="19"
				else if(round(usr.EXP/usr.MaxEXP*100)>=5&&round(usr.EXP/usr.MaxEXP*100)<10) src.icon_state="20"
				else if(round(usr.EXP/usr.MaxEXP*100)>=0&&round(usr.EXP/usr.MaxEXP*100)<5) src.icon_state="21"
				sleep(5)
	Stamina
		layer=9999
		icon='Stamina.dmi'
		New(client/c)
			screen_loc="1,19:52"
			c.screen+=src
			spawn while(usr)
				if(!usr.client)
					return

				if(round(usr.Stamina/usr.MaxStamina*100)>=90) src.icon_state="1"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=85&&round(usr.Stamina/usr.MaxStamina*100)<90) src.icon_state="2"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=80&&round(usr.Stamina/usr.MaxStamina*100)<85) src.icon_state="3"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=75&&round(usr.Stamina/usr.MaxStamina*100)<80) src.icon_state="4"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=70&&round(usr.Stamina/usr.MaxStamina*100)<75) src.icon_state="5"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=65&&round(usr.Stamina/usr.MaxStamina*100)<70) src.icon_state="6"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=60&&round(usr.Stamina/usr.MaxStamina*100)<65) src.icon_state="7"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=55&&round(usr.Stamina/usr.MaxStamina*100)<60) src.icon_state="8"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=50&&round(usr.Stamina/usr.MaxStamina*100)<55) src.icon_state="9"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=45&&round(usr.Stamina/usr.MaxStamina*100)<50) src.icon_state="10"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=40&&round(usr.Stamina/usr.MaxStamina*100)<45) src.icon_state="11"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=35&&round(usr.Stamina/usr.MaxStamina*100)<40) src.icon_state="12"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=30&&round(usr.Stamina/usr.MaxStamina*100)<35) src.icon_state="14"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=20&&round(usr.Stamina/usr.MaxStamina*100)<30) src.icon_state="15"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=15&&round(usr.Stamina/usr.MaxStamina*100)<20) src.icon_state="17"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=10&&round(usr.Stamina/usr.MaxStamina*100)<15) src.icon_state="19"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=5&&round(usr.Stamina/usr.MaxStamina*100)<10) src.icon_state="20"
				else if(round(usr.Stamina/usr.MaxStamina*100)>=0&&round(usr.Stamina/usr.MaxStamina*100)<5) src.icon_state="21"
				sleep(world.tick_lag)
	Money1
		icon='Huds.dmi'
		icon_state="M1"
		layer=9999
		New(client/C)
			C.screen += src
			..()
	Money2
		icon='Huds.dmi'
		icon_state="M2"
		layer=9999
		New(client/C)
			C.screen += src
			..()
	Money3
		icon='Huds.dmi'
		icon_state="M3"
		layer=9999
		New(client/C)
			C.screen += src
			..()
	Money4
		icon='JpShopItems.dmi'
		icon_state="iron"
		layer=9999
		New(client/C)
			C.screen += src
		//	src.maptext="<font color=yellow>Gold:</font>"
			..()
	Money5
		layer=999
		maptext_width=900
		maptext_height=900
		New(client/C)
			C.screen += src
			spawn while(src)
				if(!usr)
					return
				src.maptext="<font color=white>[usr.Iron]</font>"
				sleep(5)
			..()



	StatPanel
		mouse_opacity = 0
		MainStatPanel
			icon = 'chatbox_bg.dmi'
			New(client/c)
				screen_loc = "24,8 to 28,16"
				c.screen+=src

		NamePanel
			layer=9999
			maptext_width=900
			maptext_height=900
			New(client/c)
				screen_loc="24:30,16:18"
				c.screen+=src
				src.maptext="<font color=white><b>[usr.Name]</b></font>"

		LevelPanel
			layer=9999
			maptext_width=900
			maptext_height=900
			New(client/c)
				screen_loc="24:4,11:21"
				c.screen+=src
				src.maptext="<font color=white>Player Level:</font>"

		LevelPanel2
			layer=9999
			maptext_width=900
			maptext_height=900
			New(client/c)
				screen_loc="26:30,11:21"
				c.screen+=src
				spawn while(usr)
					if(!usr.client)
						return
					src.maptext="<font color=white>[usr.Level]</font>"
					sleep(5)

		WeaponLevelPanel
			layer=9999
			maptext_width=900
			maptext_height=900
			New(client/c)
				screen_loc="24:4,10:22"
				c.screen+=src
				src.maptext="<font color=white>Weapon Level:</font>"

		WeaponLevelPanel2
			layer=9999
			maptext_width=900
			maptext_height=900
			New(client/c)
				screen_loc="24:100,10:22"
				c.screen+=src
				spawn while(usr)
					if(!usr.client)
						return
					if(usr.SwordOn)
						src.maptext="<font color=white>[usr.Sword_Skill_Level]</font>"
					else if(usr.SpearOn)
						src.maptext="<font color=white>[usr.Spear_Skill_Level]</font>"
					else if(usr.AxeOn)
						src.maptext="<font color=white>[usr.Axe_Skill_Level]</font>"
					else
						src.maptext="<font color=white>[usr.HandToHand_Skill_Level]</font>"
					sleep(5)

		EXPPanel
			layer=9999
			maptext_width=900
			New(client/c)
				screen_loc="24:4,9:23"
				c.screen+=src
				src.maptext="<font color=white>EXP:</font>"

		EXPPanel2
			layer=9999
			maptext_width=900
			New(client/c)
				screen_loc="25:8,9:23"
				c.screen+=src
				spawn while(usr)
					if(!usr.client)
						return
					if(usr.SwordOn)
						src.maptext="<font color=white>[usr.Sword_Skill_EXP] / [usr.Sword_Skill_MaxEXP]</font>"
					if(usr.SpearOn)
						src.maptext="<font color=white>[usr.Spear_Skill_EXP] / [usr.Spear_Skill_MaxEXP]</font>"
					if(usr.AxeOn)
						src.maptext="<font color=white>[usr.Axe_Skill_EXP] / [usr.Axe_Skill_MaxEXP]</font>"

					else src.maptext="<font color=white>[usr.HandToHand_Skill_EXP] / [usr.HandToHand_Skill_MaxEXP]</font>"
					sleep(5)

		HealthPanel
			layer=9999
			maptext_width=900
			New(client/c)
				screen_loc="24:4,15:15"
				c.screen+=src
				src.maptext="<font color=white>Health:</font>"
		HealthPanel2
			layer=9999
			maptext_width=900
			New(client/c)
				screen_loc="25:18,15:15"
				c.screen+=src
				spawn while(usr)
					if(!usr.client)
						return
					//src.maptext="<font color=white>[usr.Health] / [usr.MaxHealth]</font>"
					src.maptext="<font color=white>[percent(usr.Health, usr.MaxHealth)]%</font>"
					sleep(5)
		StaminaPanel2
			layer=9999
			maptext_width=900
			New(client/c)
				screen_loc="25:32,14:17"
				c.screen+=src
				spawn while(usr)
					if(!usr.client)
						return
					//src.maptext="<font color=white>[usr.Stamina] / [usr.MaxStamina]</font>"
					src.maptext="<font color=white>[percent(usr.Stamina, usr.MaxStamina)]%</font>"
					sleep(5)
		StaminaPanel
			layer=9999
			maptext_width=900
			New(client/c)
				screen_loc="24:4,14:17"
				c.screen+=src
				src.maptext="<font color=white>Stamina:</font>"
		DefensePanel
			layer=9999
			maptext_width=900
			New(client/c)
				screen_loc="24:4,12:20"
				c.screen+=src
				src.maptext="<font color=white>Defense:</font>"
		DefensePanel2
			layer=9999
			maptext_width=900
			New(client/c)
				screen_loc="25:30,12:20"
				c.screen+=src
				spawn while(usr)
					if(!usr.client)
						return
					src.maptext="<font color=white>[percent(usr.Defense, usr.MaxDefense)]%</font>"
					sleep(5)

		STRPanel
			layer=9999
			maptext_width=900
			New(client/c)
				screen_loc="24:4,13:19"
				c.screen+=src
				src.maptext="<font color=white>Strength:</font>"
		STRPanel2
			layer=9999
			maptext_width=900
			New(client/c)
				screen_loc="25:30,13:19"
				c.screen+=src
				spawn while(usr)
					if(!usr.client)
						return
					src.maptext="<font color=white>[percent(usr.Strength, usr.MaxStrength)]%</font>"
					sleep(5)



//////////////////////////////////
///////////////BAG///////////////
////////////////////////////////

obj/Bag
	Bag
		icon='Huds.dmi'
		icon_state="Bag"
		layer=20
		New(client/C)
			C.screen += src
			..()

mob
	verb
		Bag()
			usr.CreateInventory()
			usr.Clicking()
			if(!usr.inventoryTutorialDone&&usr.inventoryTutorialActivated)
				usr.HudDelete_Tut3()
				usr.inventoryTutorialDone=1
				_message(usr, "<font color=green>New Task Unlocked: <font color=white>Make A Weapon!</font>","white")
	proc
		CreateInventory()
			if(BagOpen==1)
				BagOpen=0
				for(var/obj/Items/O in src.client.screen)
					O.layer = OBJ_LAYER
					src.client.screen-=O

				for(var/obj/Bag/H in src.client.screen)
					del(H)
				return
			else
				BagOpen = 1
				for(var/obj/Items/O in src.client.screen)
					O.layer = OBJ_LAYER
					src.client.screen-=O

				for(var/obj/Bag/H in src.client.screen)
					del(H)
				src.MenuBack()
				src.AddItems()
		AddItems()
			var/ox = 24
			var/oy = 5
			var/count = 0
			for(var/obj/O in src.contents)
				if(count < src.MaxItems)
					count++
					O.layer = MOB_LAYER+20
					src.client.screen += O
					O.screen_loc = "[ox],[oy]"
					ox++
					if(ox>28)
						ox=24
						oy--
		MenuBack()
			var/obj/H = new/obj/Bag/Bag(src.client)
			H.screen_loc = "24,1 to 28,5"

mob/proc
	StaminaREGEN()
		spawn while(src)
			if(src.Dead)
				goto next
				return
			if(src.Dying)
				goto next
				return
			if(src.Stamina>=src.MaxStamina)
				src.Stamina=src.MaxStamina
				goto next
				return
			else
				src.Stamina+=5
			next
			sleep(20)
	HEALTHREGEN()
		spawn while(src)
			if(src.Dead)
				goto next
				return
			if(src.Dying)
				goto next
				return
			if(src.Health>=src.MaxHealth)
				src.Health=src.MaxHealth
				goto next
				return
			else
				src.Health+=5
			next
			sleep(20)
proc/percent(value, max)
  return 100 / max * value
#define mKK m.m

obj/HUD
	FadeIn
		layer=9001
		icon='FadeIn.dmi'
		screen_loc="SOUTHWEST to NORTHEAST"
	FadeOut
		layer=9001
		icon='FadeOut.dmi'
		screen_loc="SOUTHWEST to NORTHEAST"

mob/proc
	UnFadeScreen()
		var/obj/HUD/FadeOut/f = new
		if(client)
			client.screen-=f
			sleep(3)
			client.screen-=f
		.=..()

	FadeScreen()
		var/obj/HUD/FadeIn/f = new
		if(client)
			client.screen+=f
			sleep(3)
			client.screen-=f
		.=..()
