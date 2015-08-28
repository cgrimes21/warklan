obj/Can_Build
	CanPickUp=0
	Basic_Crafting_Table
		density=1
		Health=50
		MaxHealth=50
		icon='Icons/Buildable/WeaponTable1.dmi'
		icon_state="weapontable1"
		name="Basic Crafting Table"
		New()
			GenerateShadow(src, SOUTH,-30)
			Wood_Crafting_Table()
			..()
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
		New()
			GenerateShadow(src, SOUTH,-30)
			Sewing_Table()
			..()
		Click()
			if(src in oview(1))
				usr.CreateInventory2(src)
				return