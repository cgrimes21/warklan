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

			if("Clan Base")
				var/obj/Can_Build/Clan_Base/A=new/obj/Can_Build/Clan_Base
				src.Building=1
				src.Frozen=1
				src<<"Building [T]..."
				sleep(20)
				src.Frozen=0
				src.Building=0
				A.loc = src.loc
				A.add_craft_item()


//PROCEDURE BELOW TO DECIDE IF YOU CAN BUILD ON AN AREA OR NOT


mob/verb
	BuildBase()
		set hidden = 1
		/*if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return*/

		switch(alert("Requirements: Player Level: 1 || Materials: 3 Stones",,"Accept","Deny"))
			if("Accept")
				if(usr.Level>1&&count_minerals("Stone",usr)>=3)
					usr.Clicking()
					winset(usr,"Build","is-visible=false")
					usr.Build("Clan Base")
					ShowingBuildMenu=0
				else
					src<<"You do not possess the necessary requirements to build this item."
			if("Deny")
				return

	BuildSCT()
		set hidden = 1
		/*if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return*/

		switch(alert("Requirements: Player Level: 2 || Materials: 5 Stones",,"Accept","Deny"))
			if("Accept")
				if(usr.Level>=2&&count_minerals("Stone",usr)>=5)
					if(locate(/obj/Can_Build/Clan_Base) in range(5, usr))
						usr.Clicking()
						winset(usr,"Build","is-visible=false")
						usr.Build("Stone Crafting Table")
						ShowingBuildMenu=0
					else src<<"You are too far away from your base flag!"
				else
					src<<"You do not possess the necessary requirements to build this item."
			if("Deny")
				return


	BuildBCT()
		set hidden = 1
		/*if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return*/

		switch(alert("Requirements: Player Level: 10 || Materials: 10 Bronze Bars",,"Accept","Deny"))
			if("Accept")
				if(usr.Level>=10&&count_minerals("Bronze",usr)>=10)
					if(locate(/obj/Can_Build/Clan_Base) in range(5, usr))
						usr.Clicking()
						winset(usr,"Build","is-visible=false")
						usr.Build("Bronze Crafting Table")
						ShowingBuildMenu=0
					else src<<"You are too far away from your base flag!"
				else
					src<<"You do not possess the necessary requirements to build this item."
			if("Deny")
				return

	BuildICT()
		set hidden = 1
		/*if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return*/

		switch(alert("Requirements: Player Level: 20 || Materials: 15 Iron Bars",,"Accept","Deny"))
			if("Accept")
				if(usr.Level>=2&&count_minerals("Iron",usr)>=15)
					if(locate(/obj/Can_Build/Clan_Base) in range(5, usr))
						usr.Clicking()
						winset(usr,"Build","is-visible=false")
						usr.Build("Iron Crafting Table")
						ShowingBuildMenu=0
					else src<<"You are too far away from your base flag!"
				else
					src<<"You do not possess the necessary requirements to build this item."
			if("Deny")
				return

	BuildBST()
		set hidden = 1
		/*if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return*/

		switch(alert("Requirements: Clan Level: 5",,"Accept","Deny"))
			if("Accept")
				if(usr.ClanLevel>=5)
					if(locate(/obj/Can_Build/Clan_Base) in range(5, usr))
						usr.Clicking()
						winset(usr,"Build","is-visible=false")
						usr.Build("Basic Sewing Table")
						ShowingBuildMenu=0
					else src<<"You are too far away from your base flag!"
				else
					src<<"You do not possess the necessary requirements to build this item."
			if("Deny")
				return

mob
	verb
		ShowBuildMenu()
			set hidden = 1
			if(usr.Player)
				if(!usr.ShowingBuildMenu)
					usr.ShowingBuildMenu=1
					usr.ShowBuildMenuProc()
					usr.Clicking()
					winset(usr,"Main.MainMap","focus=true")
					return
				else
					usr.ShowingBuildMenu=0
					winset(usr,"Main.MainMap","focus=true")
					winset(usr,"Build","is-visible=false")
					return
			else
				src<<"You need to be in a clan to use the building menu."
	proc
		ShowBuildMenuProc()
			if(!usr.buildTutorialDone&&usr.buildTutorialActivated)
				usr.HudDelete_Tut5()
				usr.buildTutorialDone=1
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




