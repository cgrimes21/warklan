obj/Can_Build
	CanPickUp=0
	Owner=""
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
				if(/obj/Can_Build/Stone_Crafting_Table)
					var/obj/NPCs/Items/Stone_Sword/A=new/obj/NPCs/Items/Stone_Sword
					var/obj/NPCs/Items/Stone_Spear/B=new/obj/NPCs/Items/Stone_Spear
					var/obj/NPCs/Items/Stone_Axe/C=new/obj/NPCs/Items/Stone_Axe

					src.contents+=A
					src.contents+=B
					src.contents+=C

				if(/obj/Can_Build/Bronze_Crafting_Table)
					var/obj/NPCs/Items/Bronze_Sword/D=new/obj/NPCs/Items/Bronze_Sword
					var/obj/NPCs/Items/Bronze_Spear/F=new/obj/NPCs/Items/Bronze_Spear
					var/obj/NPCs/Items/Bronze_Axe/E=new/obj/NPCs/Items/Bronze_Axe

					src.contents+=D
					src.contents+=E
					src.contents+=F

				if(/obj/Can_Build/Iron_Crafting_Table)
					var/obj/NPCs/Items/Iron_Sword/G=new/obj/NPCs/Items/Iron_Sword
					var/obj/NPCs/Items/Iron_Spear/H=new/obj/NPCs/Items/Iron_Spear
					var/obj/NPCs/Items/Iron_Axe/I=new/obj/NPCs/Items/Iron_Axe

					src.contents+=G
					src.contents+=H
					src.contents+=I

				if(/obj/Can_Build/Basic_Sewing_Table)

					var/obj/NPCs/Items/Fox_Cub_Tunic/A=new/obj/NPCs/Items/Fox_Cub_Tunic
					//var/obj/NPCs/Items/Red_Fox_Coat/B=new/obj/NPCs/Items/Red_Fox_Coat
					//var/obj/NPCs/Items/Wolf_Fur_Coat/C=new/obj/NPCs/Items/Wolf_Fur_Coat

					src.contents+=A
					//src.contents+=B
					//src.contents+=C



	Stone_Crafting_Table
		density=1
		Health=50
		MaxHealth=50
		Defense=0
		MaxDefense=0
		icon='Icons/Buildable/WeaponTable1.dmi'
		icon_state="weapontable1"
		name="Basic Crafting Table"
		Click()
			if(src in oview(1))
				usr.Clicking()
				usr.CreateInventory2(src)
				return

	Bronze_Crafting_Table
		density=1
		Health=50
		MaxHealth=50
		Defense=0
		MaxDefense=0
		icon='Icons/Buildable/WeaponTable1.dmi'
		icon_state="weapontable1"
		name="Basic Crafting Table"
		Click()
			if(src in oview(1))
				usr.Clicking()
				usr.CreateInventory2(src)
				return

	Iron_Crafting_Table
		density=1
		Health=50
		MaxHealth=50
		Defense=0
		MaxDefense=0
		icon='Icons/Buildable/WeaponTable1.dmi'
		icon_state="weapontable1"
		name="Basic Crafting Table"
		Click()
			if(src in oview(1))
				usr.Clicking()
				usr.CreateInventory2(src)
				return

	Basic_Sewing_Table
		density=1
		Health=50
		MaxHealth=50
		Defense=0
		MaxDefense=0
		icon='Icons/Buildable/SewingTable1.dmi'
		icon_state="tailortable1"
		name="Basic Sewing Table"
		Click()
			usr.Clicking()
			if(src in oview(1))
				usr.CreateInventory2(src)
				return

	Clan_Flag
		density=1
		Health=50
		MaxHealth=50
		Defense=0
		MaxDefense=0
		icon='Icons/Buildable/ClanFlag.dmi'
		icon_state="flag"
		name="Clan Flag"
		Click()
			usr<<"[src.Owner] owns this base."

	Clan_Base
		density=1
		Health=150
		MaxHealth=150
		Defense=60
		MaxDefense=60
		icon='Icons/Buildable/Firepit.dmi'
		name="Clan Base"
		Click()
			usr<<"[src.Owner] owns this base."
