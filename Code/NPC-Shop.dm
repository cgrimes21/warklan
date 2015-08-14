mob
	proc
		CreateInventory2(mob/T)
			if(BagOpen2==1)
				BagOpen2=0
				for(var/obj/NPCs/Items/O in src.client.screen)
					O.layer = OBJ_LAYER
					src.client.screen-=O

				for(var/obj/Bag2/H in src.client.screen)
					del(H)
				return
			for(var/obj/NPCs/Items/O in src.client.screen)
				O.layer = OBJ_LAYER
				src.client.screen-=O

			for(var/obj/Bag2/H in src.client.screen)
				del(H)
			src.BagOpen2=1
			src.MenuBack2()
			src.AddItems2(T)
		AddItems2(mob/T)
			var/ox = 14
			var/oy = 15
			var/count = 0
			for(var/obj/O in T.contents)
				if(count < 100)
					count++
					O.layer = MOB_LAYER+20
					src.client.screen += O
					O.screen_loc = "[ox],[oy]"
					oy--
					if(oy<1)
						oy=10
						ox++
		MenuBack2()
			var/obj/H = new/obj/Bag2/Bag2(src.client)
			var/obj/X = new/obj/Bag2/Exit(src.client)
			H.screen_loc = "14,10 to 17,15"
			X.screen_loc = "15:16,16"
obj/Bag2
	Bag2
		icon='Huds.dmi'
		icon_state="Bag"
		layer=15
		New(client/C)
			C.screen += src
			..()
	Exit
		icon='Huds.dmi'
		icon_state="X"
		layer=15
		New(client/C)
			C.screen += src
			..()
		Click()

			usr.CreateInventory2()
			return