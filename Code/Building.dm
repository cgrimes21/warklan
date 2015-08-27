mob/var
	Building=0

mob/proc
	Build(var/T as text)
		if(src.Building)
			return
		else if(T=="Wood Crafting Table")
			var/obj/Can_Build/Wood_Crafting_Table/A=new/obj/Can_Build/Wood_Crafting_Table
			src.Building=1
			sleep(20)
			src.Building=0
			A.loc = src.loc

mob/verb
	BuildItems()
		//set hidden=1
		usr.Build("Wood Crafting Table")


 	.,