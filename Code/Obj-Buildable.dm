obj/Can_Build
	CanPickUp=0
	var
		lastx
		lasty
		lastz
	New()

		GenerateShadow(src, SOUTH,-30)
		..()
	proc
		add_craft_item()
			switch(src.type)
				if(/obj/Can_Build/Basic_Crafting_Table)
					var/obj/NPCs/Items/Wooden_Sword/S=new/obj/NPCs/Items/Wooden_Sword
					src.contents+=S
				if(/obj/Can_Build/Basic_Sewing_Table)
					var/obj/NPCs/Items/Fox_Fur_Tunic/G=new/obj/NPCs/Items/Fox_Fur_Tunic
					src.contents+=G

	Basic_Crafting_Table
		density=1
		Health=50
		MaxHealth=50
		icon='Icons/Buildable/WeaponTable1.dmi'
		icon_state="weapontable1"
		name="Basic Crafting Table"
		Click()
			if(src in oview(1))
				usr.CreateInventory2(src)
				return
	Basic_Sewing_Table
		density=1
		Health=50
		MaxHealth=50
		icon='Icons/Buildable/SewingTable1.dmi'
		icon_state="tailortable1"
		name="Basic Sewing Table"
		Click()
			if(src in oview(1))
				usr.CreateInventory2(src)
				return

