mob/verb
	NameC()
		var/Name=winget(usr,"Name.NameI","text")
		if(Name==null||Name==""){return}
		usr.Name=Name
		winset(usr,"NameChild","is-visible=false")
		return
turf/BG
	icon='Black2.dmi'
obj/Class
	Han
		icon='Han.png'
		Click()
			var/obj/Class/Description/HanD/D=new/obj/Class/Description/HanD
			D.loc=locate(21,24,2)
			usr.Class="Han"
	Monk
		icon='Monk.png'
		Click()
			usr.Class="Monk"
			usr.MaxStamina=100
			usr.MaxHealth=200
			usr.Health=200
			winset(usr,"NameChild","is-visible=true")
	Wu
		icon='Wu.png'
		Click()
			var/obj/Class/Description/WuD/D=new/obj/Class/Description/WuD
			D.loc=locate(21,24,2)
			usr.Class="Wu"

	Description
		Blank
			icon='Blank.png'
		HanD
			icon='HanD.png'
		MonkD
			icon='MonkD.png'
			maptext_width=999

		WuD
			icon='WuD.png'
	Color
		icon='CWheel.jpg'




	Finish
		icon='Finish.png'
		Click()
			if(usr.Class!=""&&usr.Name!="")
				//usr.loc=locate(11,34,13)
				usr.loc=locate(/turf/Markers/VillageOne/Spawn)
				usr.icon ='White Base.dmi'
				usr.HudCreate()
				usr.Player=1
				usr.Max_MouseName()
				usr.HEALTHREGEN()
				usr.StaminaREGEN()
				GenerateShadow(usr, SOUTH,-32)
				usr.Help_Player()

		//		if(usr.Class=="Monk")
		//			usr.contents+=new/obj/Items/Weapons/Staff