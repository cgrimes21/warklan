#define DEBUG
world
	name="Rise of the Clans" //CHANGE NAME
	hub="RedCrownMG.RiseOfTheClans"//CHANGE
	hub_password="@Rotc1994"//CHANGE
	view="28x21"
	fps=40
	New()
		log="Errors.txt"
		//add an item to the crafting tables created in the map editor
		for(var/obj/Can_Build/CC in world)
			CC.add_craft_item()
		for(var/turf/A in world)
			if(A.shadow==1)
				GenerateShadow(A,SOUTH)
		for(var/obj/A in world)
			if(A.shadow==1)
				GenerateShadow(A,SOUTH,-52)
		LoadClans()
		//then load all the custom tables (already has a crafting item in it)
		load_build()
		spawn(20)
			main_loop()
		..()


	Reboot()
		world<<"<b><font color=yellow><font size=+1>Rebooting!!!</font></b>"
		..()
	Del()
		save_build()
		..()
proc
	send_to_graveyard(mob/A)
		A.loc = locate(0,0,0)

	main_loop()
		while(world)
			sleep(10)
			ticker ++

			for(var/mob/M in world)
				if(istype(M,/mob))
					M.process()

	LoadClans()
		if(fexists("Saves/World/Clans.sav"))
			var/savefile/F = new("Saves/World/Clans.sav")
			F["Clan"] >> Clans

var
	ticker = 0

mob/proc
	process()
		src.being_attacked = 0
		for(var/mob/Enemies/E in oview(8,src))
			if(E.Attacker == src.Name)
				src.being_attacked = 1

	update_health_bar()
		if(!src.healthbar)
			src.healthbar = new()

		src.overlays -= src.healthbar
		src.healthbar.icon_state = "[round((src.Health * 100) / src.MaxHealth, 5)]"
		src.overlays += src.healthbar
		spawn(50)
			src.overlays -= src.healthbar
	Help_Player()

		usr.QuestItemDelete()
		winset(usr,"Help","is-visible=true")
		//_message(usr,"<font size=+1>[src.DoingQuest] = DOING QUEST. [QuestLevel] = MERC QUEST</font>","Yellow")

obj/Can_Build/proc
	process()

	update_health_bar()
		if(!src.healthbar)
			src.healthbar = new()

		src.overlays -= src.healthbar
		src.healthbar.icon_state = "[round((src.Health * 100) / src.MaxHealth, 5)]"
		src.overlays += src.healthbar
		spawn(50)
			src.overlays -= src.healthbar



client
	perspective=EDGE_PERSPECTIVE
	mouse_pointer_icon = 'Mouse.dmi'

mob
	Login()
		check_Initialized
		if(src.ckey in list("distantworld101","redcrownmg","animebeyond","suicideshifterr",m.m))
			src.Admin=1
			debuggers += src
		for(var/mob/M in world)
			if(M.client && M.ckey == src.ckey && M!=src)
				debuggers<<"Multikeying [src.ckey] attempt found. STOP"
				return

		src.Quests()
		..()
		if(src.music_on)
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
