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
			src<<"You cannot build in this area!"
			return
		for(var/obj/Can_Build/B in oview(5,src))
			if(B.Owner != src.ckey)
				src<<"You can't build on someone else's base!"
				return
		switch(T)
			if("Stone Crafting Table")
				var/MaterialsReqNum=5
				var/obj/Can_Build/Stone_Crafting_Table/A=new/obj/Can_Build/Stone_Crafting_Table
				if(src.clan)
					A.clan_build = src.clan
				src.Building=1
				src.Frozen=1
				src<<"Building [T]..."
				sleep(20)
				src.Frozen=0
				src.Building=0
				A.loc = src.loc
				A.add_craft_item()
				A.Owner=src.Name
				src.MaterialDelete("Stone",MaterialsReqNum)

			if("Bronze Crafting Table")
				var/MaterialsReqNum=10
				var/obj/Can_Build/Bronze_Crafting_Table/A=new/obj/Can_Build/Bronze_Crafting_Table
				if(src.clan)
					A.clan_build = src.clan
				src.Building=1
				src.Frozen=1
				src<<"Building [T]..."
				sleep(20)
				src.Frozen=0
				src.Building=0
				A.loc = src.loc
				A.add_craft_item()
				A.Owner=src.Name
				src.MaterialDelete("Bronze",MaterialsReqNum)

			if("Iron Crafting Table")
				var/MaterialsReqNum=15
				var/obj/Can_Build/Iron_Crafting_Table/A=new/obj/Can_Build/Iron_Crafting_Table
				if(src.clan)
					A.clan_build = src.clan
				src.Building=1
				src.Frozen=1
				src<<"Building [T]..."
				sleep(20)
				src.Frozen=0
				src.Building=0
				A.loc = src.loc
				A.add_craft_item()
				A.Owner=src.Name
				src.MaterialDelete("Iron",MaterialsReqNum)

			if("Basic Sewing Table")
				var/MaterialsReqNum=5
				var/obj/Can_Build/Basic_Sewing_Table/A=new/obj/Can_Build/Basic_Sewing_Table
				if(src.clan)
					A.clan_build = src.clan
				src.Building=1
				src.Frozen=1
				src<<"Building [T]..."
				sleep(20)
				src.Frozen=0
				src.Building=0
				A.loc = src.loc
				A.add_craft_item()
				A.Owner=src.Name
				src.MaterialDelete("Stone",MaterialsReqNum)

			if("Clan Base")
				var/MaterialsReqNum=3
				var/obj/Can_Build/Clan_Base/A=new/obj/Can_Build/Clan_Base
				if(src.clan)
					A.clan_build = src.clan
				src.Building=1
				src.Frozen=1
				src<<"Building [T]..."
				sleep(20)
				src.Frozen=0
				src.Building=0
				A.loc = src.loc
				A.add_craft_item()
				A.Owner=src.ckey
				src.MaterialDelete("Stone",MaterialsReqNum)

				//color your base
				for(var/turf/too in view(5,A))
					if(istype(too,/turf))
						if(get_dist(too,src) >= 5)
							var/icon/I = new('mybase.dmi')
							too.overlays += I



mob/verb
	BuildBase()
		set hidden = 1
		var/MaterialsReqNum=3
		/*if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return*/
		if(locate(/obj/Can_Build/Clan_Base) in range(11, usr))
			usr<<"You're building too close to another clan base!"
			return
		var/area/t = src.loc.loc
		if(!t.can_build)
			src<<"You cannot build in this area!"
			return

		switch(alert("Requirements: Player Level: 5 || Materials: 3 Stones",,"Accept","Deny"))
			if("Accept")
				if(usr.Level>=5&&count_minerals("Stone",usr)>=MaterialsReqNum)
					usr.Clicking()
					winset(usr,"Build","is-visible=false")
					usr.Build("Clan Base")
					ShowingBuildMenu=0
				else
					usr<<"You do not possess the necessary requirements to build this item."
			if("Deny")
				return

	BuildSCT()
		set hidden = 1
		var/MaterialsReqNum=5
		/*if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return*/

		switch(alert("Requirements: Player Level: 5 || Materials: 5 Stones",,"Accept","Deny"))
			if("Accept")
				if(usr.Level>=5&&count_minerals("Stone",usr)>=MaterialsReqNum)
					var/obj/Can_Build/Clan_Base/B = new/obj/Can_Build/Clan_Base
					if(locate(B) in range(5, usr))
						usr.Clicking()
						winset(usr,"Build","is-visible=false")
						usr.Build("Stone Crafting Table")
						ShowingBuildMenu=0
					else usr<<"You have not built one or you are too far away from your base."
				else
					usr<<"You do not possess the necessary requirements to build this item."
			if("Deny")
				return


	BuildBCT()
		set hidden = 1
		var/MaterialsReqNum=10
		switch(alert("Requirements: Player Level: 20 || Materials: 10 Bronze Bars",,"Accept","Deny"))
			if("Accept")
				var/obj/Can_Build/Clan_Base/B = new/obj/Can_Build/Clan_Base
				if(locate(B) in range(5, usr))
					if(usr.Level>=20&&count_minerals("Bronze",usr)>=MaterialsReqNum)
						usr.Clicking()
						winset(usr,"Build","is-visible=false")
						usr.Build("Bronze Crafting Table")
						ShowingBuildMenu=0
					else usr<<"You do not possess the necessary requirements to build this item."

				else usr<<"You have not built one or you are too far away from your base."

			if("Deny")
				return

	BuildICT()
		set hidden = 1
		var/MaterialsReqNum=15
		/*if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return*/

		switch(alert("Requirements: Player Level: 40 || Materials: 15 Iron Bars",,"Accept","Deny"))
			if("Accept")
				if(usr.Level>=40&&count_minerals("Iron",usr)>=MaterialsReqNum)
					if(locate(/obj/Can_Build/Clan_Base) in range(5, usr))
						usr.Clicking()
						winset(usr,"Build","is-visible=false")
						usr.Build("Iron Crafting Table")
						ShowingBuildMenu=0
					else usr<<"You are too far away from your base flag!"
				else
					usr<<"You do not possess the necessary requirements to build this item."
			if("Deny")
				return

	BuildBST()
		set hidden = 1
		var/MaterialsReqNum=5
		/*if(!usr.InClan)
			src<<"You need to be in a clan to build this item."
			return*/

		switch(alert("Requirements: Player Level: 5 || Materials: 5 Stones",,"Accept","Deny"))
			if("Accept")
				if(usr.Level>=2&&count_minerals("Stone",usr)>=MaterialsReqNum)
					if(locate(/obj/Can_Build/Clan_Base) in range(5, usr))
						usr.Clicking()
						winset(usr,"Build","is-visible=false")
						usr.Build("Basic Sewing Table")
						ShowingBuildMenu=0
					else usr<<"You are too far away from your base flag!"
				else
					usr<<"You do not possess the necessary requirements to build this item."
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




