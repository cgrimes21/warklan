mob/var
	Building=0
	ShowingBuildMenu=0

mob/proc
	Build(var/T as text)
		if(src.Building)
			return
		else if(T=="Basic Crafting Table")
			var/obj/Can_Build/Basic_Crafting_Table/A=new/obj/Can_Build/Basic_Crafting_Table
			src.Building=1
			src.Frozen=1
			src<<"Building [T]..."
			sleep(20)
			src.Frozen=0
			src.Building=0
			A.loc = src.loc
		else if(T=="Basic Sewing Table")
			var/obj/Can_Build/Basic_Sewing_Table/A=new/obj/Can_Build/Basic_Sewing_Table
			src.Building=1
			src.Frozen=1
			src<<"Building [T]..."
			sleep(20)
			src.Frozen=0
			src.Building=0
			A.loc = src.loc

mob/verb
	BuildBCT()
		set hidden = 1
		usr.Build("Basic Crafting Table")

mob/verb
	BuildBST()
		set hidden = 1
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
