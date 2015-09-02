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
					var/obj/NPCs/Items/Stone_Sword/A=new/obj/NPCs/Items/Stone_Sword
					var/obj/NPCs/Items/Stone_Axe/B=new/obj/NPCs/Items/Stone_Axe
					var/obj/NPCs/Items/Stone_Spear/C=new/obj/NPCs/Items/Stone_Spear

					var/obj/NPCs/Items/Bronze_Sword/D=new/obj/NPCs/Items/Bronze_Sword
					var/obj/NPCs/Items/Bronze_Axe/E=new/obj/NPCs/Items/Bronze_Axe
					var/obj/NPCs/Items/Bronze_Spear/F=new/obj/NPCs/Items/Bronze_Spear

					var/obj/NPCs/Items/Iron_Sword/G=new/obj/NPCs/Items/Iron_Sword
					var/obj/NPCs/Items/Iron_Axe/H=new/obj/NPCs/Items/Iron_Axe
					var/obj/NPCs/Items/Iron_Spear/I=new/obj/NPCs/Items/Iron_Spear

					src.contents+=A
					src.contents+=B
					src.contents+=C

					src.contents+=D
					src.contents+=E
					src.contents+=F

					src.contents+=G
					src.contents+=H
					src.contents+=I

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

