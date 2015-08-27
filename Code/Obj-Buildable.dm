obj/Can_Build
	Wood_Crafting_Table
		icon='NPCs.dmi'
		icon_state="Tailor"
		name="Wood Crafting Table"
		New()
			GenerateShadow(src, SOUTH,-60)
			Wood_Crafting_Table()
			..()
		Click()
			if(src in oview(1))
				usr.CreateInventory2(src)
				return