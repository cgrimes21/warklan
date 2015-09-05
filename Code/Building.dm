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
			if("Basic Crafting Table")
				var/obj/Can_Build/Basic_Crafting_Table/A=new/obj/Can_Build/Basic_Crafting_Table
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

mob/verb
	BuildBCT()
		set hidden = 1
		winset(usr,"Build","is-visible=false")
		ShowingBuildMenu=0
		usr.Build("Basic Crafting Table")


mob/verb
	BuildBST()
		set hidden = 1
		winset(usr,"Build","is-visible=false")
		ShowingBuildMenu=0
		usr.Build("Basic Sewing Table")

mob
	verb
		ShowBuildMenu()
			set hidden = 1
			if(usr.InClan)
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