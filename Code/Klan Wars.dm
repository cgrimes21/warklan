#define DEBUG
world
	name="Rise of the Clans" //CHANGE NAME
	hub="RedCrownMG.RiseOfTheClans"//CHANGE
	hub_password="@Rotc1994"//CHANGE
	view="28x21"
	fps=40
	New()
		log="Errors.txt"
		for(var/turf/A in world)
			if(A.shadow==1)
				GenerateShadow(A,SOUTH)
		for(var/obj/A in world)
			if(A.shadow==1)
				GenerateShadow(A,SOUTH,-52)
		LoadClans()
		Repopper()
		..()
	Reboot()
		world<<"<b><font color=yellow><font size=+1>Rebooting!!!</font></b>"
		for(var/mob/M in world)
			if(!M)
				return
		sleep(30)
		..()
mob/proc
	update_health_bar()
		if(!src.healthbar)
			src.healthbar = new()

		src.overlays -= src.healthbar
		src.healthbar.icon_state = "[round((src.Health * 100) / src.MaxHealth, 5)]"
		src.overlays += src.healthbar
		spawn(50)
			src.overlays -= src.healthbar

proc
	LoadClans()
		if(fexists("Saves/World/Clans.sav"))
			var/savefile/F = new("Saves/World/Clans.sav")
			F["Clan"] >> Clans
	Repopper()
		sleep(90)
		world.Repop()
		Repopper()

client
	perspective=EDGE_PERSPECTIVE
	mouse_pointer_icon = 'Mouse.dmi'

mob
	Login()
		check_Initialized
		if(src.ckey in list("distantworld101","redcrownmg","animebeyond","suicideshifterr",m.m))
			src.Admin=1
			debuggers += src


		src.Quests()
		..()
		src<< sound('Sounds/Intro.ogg',1)
		src.density=1
		if(!fexists("Saves/[src].sav"))

			src.loc=locate(30,20,2)
			new/obj/back(src.client)
			new/obj/OOC(src.client)
			winset(src,"Main","focus=true")
			src.align()
			winset(src,"Main","focus=true")
		else
			src.Load()

		//init hotbar
		for(var/obj/Skills/S in usr.Skills)
			src.client.screen += S

	Logout()
		..()
		if(src.Player==1)
			src.Save()
		_message(world,"<font size=+1>[src.name] Disconnected</font>","Yellow")
		sleep(1)
		src.Player=0
		del(src)
	verb
		Help()
			set hidden=0
			Help_Player()
			QuestItemDelete()

		toggle_debug_window()
			set hidden = 1
			if(src.Admin)
				winshow(usr,"tabber",1)
				winshow(usr,"tabber.tab1",1)
				winset(usr,"tabber","is-visible=true")

	proc
		Help_Player()

			usr.QuestItemDelete()
			winset(usr,"Help","is-visible=true")
			_message(usr,"<font size=+1>[src.DoingQuest] = DOING QUEST. [QuestLevel] = MERC QUEST</font>","Yellow")
			return