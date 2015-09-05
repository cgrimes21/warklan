mob/var
	Building=0
	ShowingBuildMenu=0

area
	var/can_build = 1
	no_build
		can_build = 0
mob/proc
	Build(var/T as text)
		if(src.Building)
			return
		var/area/t = src.loc.loc
		if(!t.can_build)
			return
		switch(T)
			if("Stone Crafting Table")
				var/obj/Can_Build/Stone_Crafting_Table/A=new/obj/Can_Build/Stone_Crafting_Table
				src.Building=1
				src.Frozen=1
				src<<"Building [T]..."
				sleep(20)
				src.Frozen=0
				src.Building=0
				A.loc = src.loc
				A.add_craft_item()

			if("Bronze Crafting Table")
				var/obj/Can_Build/Bronze_Crafting_Table/A=new/obj/Can_Build/Bronze_Crafting_Table
				src.Building=1
				src.Frozen=1
				src<<"Building [T]..."
				sleep(20)
				src.Frozen=0
				src.Building=0
				A.loc = src.loc
				A.add_craft_item()

			if("Iron Crafting Table")
				var/obj/Can_Build/Iron_Crafting_Table/A=new/obj/Can_Build/Iron_Crafting_Table
				src.Building=1
				src.Frozen=1
				src<<"Building [T]..."
				sleep(20)
				src.Frozen=0
				src.Building=0
				A.loc = src.loc
				A.add_craft_item()

			if("Basic Sewing Table")
				var/obj/Can_Build/Basic_Sewing_Table/A=new/obj/Can_Build/Basic_Sewing_Table
				src.Building=1
				src.Frozen=1
				src<<"Building [T]..."
				sleep(20)
				src.Frozen=0
				src.Building=0
				A.loc = src.loc
				A.add_craft_item()

			if("Clan Flag")
				var/obj/Can_Build/Clan_Flag/A=new/obj/Can_Build/Clan_Flag
				src.Building=1
				src.Frozen=1
				src<<"Building [T]..."
				sleep(20)
				src.Frozen=0
				src.Building=0
				A.loc = src.loc
				A.add_craft_item()


//PROCEDURE BELOW TO DECIDE IF YOU CAN BUILD ON AN AREA OR NOT

atom/movable/var/canBuild = 1 //false defaultly

area/cannotBuildOn
	Entered(mob/M) //executing what happens as you go inside an atom, and enter is called when you bump against an atom
		M:canBuild = 0
		return ..()
	Exited(mob/M)
		M:canBuild = 1
		return ..()


mob/verb
	BuildBaseFlag()
		set hidden = 1
		/*if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return*/
		if(canBuild)
			switch(alert("Requirements: Clan Level: 1",,"Accept","Deny"))
				if("Accept")
					if(usr.Player)
						usr.Build("Clan Flag")
						winset(usr,"Build","is-visible=false")
						ShowingBuildMenu=0
					else
						src<<"You do not possess the necessary requirements to build this item."
				if("Deny")
					return
		else
			src<<"You cannot build in a tutorial/dungeon/creature heavy area."

	BuildSCT()
		set hidden = 1
		if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return
		if(canBuild)
			switch(alert("Requirements: Clan Level: 5 || Materials: 10 Stones",,"Accept","Deny"))
				if("Accept")
					if(usr.ClanLevel>=5)
						if(locate(/obj/Can_Build/Clan_Flag) in range(5, usr))
							usr.Build("Stone Crafting Table")
							winset(usr,"Build","is-visible=false")
							ShowingBuildMenu=0
						else src<<"You are too far away from your base flag!"
					else
						src<<"You do not possess the necessary requirements to build this item."
				if("Deny")
					return
		else
			src<<"You cannot build in a tutorial/dungeon/creature heavy area."


	BuildBCT()
		set hidden = 1
		if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return
		if(canBuild)
			switch(alert("Requirements: Clan Level: 10 || Materials: 10 Bronze Bars",,"Accept","Deny"))
				if("Accept")
					if(usr.ClanLevel>=10)
						if(locate(/obj/Can_Build/Clan_Flag) in range(5, usr))
							usr.Build("Bronze Crafting Table")
							winset(usr,"Build","is-visible=false")
							ShowingBuildMenu=0
						else src<<"You are too far away from your base flag!"
					else
						src<<"You do not possess the necessary requirements to build this item."
				if("Deny")
					return
		else
			src<<"You cannot build in a tutorial/dungeon/creature heavy area."

	BuildICT()
		set hidden = 1
		if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return
		if(canBuild)
			switch(alert("Requirements: Clan Level: 15 || Materials: 10 Iron Bars",,"Accept","Deny"))
				if("Accept")
					if(usr.ClanLevel>=15)
						if(locate(/obj/Can_Build/Clan_Flag) in range(5, usr))
							usr.Build("Iron Crafting Table")
							winset(usr,"Build","is-visible=false")
							ShowingBuildMenu=0
						else src<<"You are too far away from your base flag!"
					else
						src<<"You do not possess the necessary requirements to build this item."
				if("Deny")
					return
		else
			src<<"You cannot build in a tutorial/dungeon/creature heavy area."

	BuildBST()
		set hidden = 1
		if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return
		if(canBuild)
			switch(alert("Requirements: Clan Level: 5",,"Accept","Deny"))
				if("Accept")
					if(usr.ClanLevel>=5)
						if(locate(/obj/Can_Build/Clan_Flag) in range(5, usr))
							usr.Build("Basic Sewing Table")
							winset(usr,"Build","is-visible=false")
							ShowingBuildMenu=0
						else src<<"You are too far away from your base flag!"
					else
						src<<"You do not possess the necessary requirements to build this item."
				if("Deny")
					return
		else
			src<<"You cannot build in a tutorial/dungeon/creature heavy area."

mob
	verb
		ShowBuildMenu()
			set hidden = 1
			if(usr.Player)
				if(!usr.ShowingBuildMenu)
					usr.ShowingBuildMenu=1
					usr.ShowBuildMenuProc()
					return
				else
					usr.ShowingBuildMenu=0
					winset(usr,"Build","is-visible=false")
					return
			else
				src<<"You need to be in a clan to use the building menu."
	proc
		ShowBuildMenuProc()
			winset(usr,"Build","is-visible=true")

proc
	save_build()
		if(fexists("Saves/World/Build"))
			fdel("Saves/World/Build")
		var/savefile/F = new ("Saves/World/Build")
		var/list/what = list()
		for(var/obj/Can_Build/B in world)
			B.lastx = B.x
			B.lasty = B.y
			B.lastz = B.z
			B.underlays = null
			what.Add(B)

		F["list"] << what

	load_build()
		if(fexists("Saves/World/Build"))
			var/savefile/F = new ("Saves/World/Build")
			var/list/load = list()
			F["list"] >> load

		//implement
			for(var/obj/Can_Build/B in load)
				if(locate(/obj/Can_Build) in locate(B.lastx,B.lasty,B.lastz))
					continue

				B.loc = locate(B.lastx,B.lasty,B.lastz)




